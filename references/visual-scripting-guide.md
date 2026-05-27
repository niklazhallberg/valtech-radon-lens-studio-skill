# Visual Scripting — guide

Lens Studio ships two parallel ways to author behavior: TypeScript components
(Asset → ⊕ → TypeScript) and **Visual Scripting** (node graphs). Both compile
to the same runtime; both can call the LS API; both can be attached to a
SceneObject as a component. Choose per task — they coexist on the same scene.

This file describes what Visual Scripting actually is, when to reach for it,
how it talks to TypeScript, and the pitfalls that come with mixing them.

---

## What Visual Scripting actually is

A node-graph editor (Window → Visual Scripting Editor) that produces a
**Visual Script asset** (`.vs`). A SceneObject gets a *Visual Script Component*
that points at the asset; at runtime the graph executes inside the same event
loop as TypeScript components.

Three node types:

- **Event nodes** — entry points. `OnAwake`, `OnTap`, `OnFrame`, `OnFaceFound`,
  `OnTouchStart`, `OnTriggered`, custom-event nodes. Each event node spawns
  its own execution flow.
- **Action nodes** — do something. Mutate a transform, play a tween, fire an
  audio component, call a TypeScript function, set a material parameter.
- **Value nodes** — produce data. Read a transform, read the current time,
  read a math expression, sample a face landmark.

Execution flows along the white "exec" wires; data flows along the colored
data wires. A graph can fan out (one event → multiple actions in parallel)
and can branch (`Branch` node = if/else, `Switch` = N-way).

---

## When to choose Visual Scripting

Reach for it when **all** of these hold:

1. The author is a designer/artist who is comfortable with node graphs but
   not comfortable writing TypeScript.
2. The logic is mostly **event → reaction** (tap fires animation, face found
   plays audio, timer triggers fade).
3. State is small (a flag, a counter) and short-lived per interaction.
4. The logic touches **components and assets** (Materials, Tweens, Audio,
   Visual, Render Mesh) more than it touches **data structures** (arrays,
   maps, JSON parsing).

Reach for TypeScript when **any** of these hold:

1. The logic needs arrays/maps, sorting, JSON parsing, regex, or other
   data-structure work.
2. The logic has more than ~3 interacting state variables.
3. The logic is long-lived (a controller that survives across many taps and
   coordinates multiple subsystems).
4. The logic is shared across many SceneObjects — TypeScript components with
   `@input` fields are easier to template than near-identical graphs.
5. You'll need to write unit-test-like probes via MCP `ExecuteEditorCode`.

**Hybrid is fine, and common.** A typical lens has 1–3 TypeScript controllers
that own state + coordinate phases, and small Visual Scripts wired to UI
events that *call into* the controllers via a custom-event or a public
TypeScript function. Pick the right tool per node, not per project.

---

## How a Visual Script talks to TypeScript (and vice versa)

Three handoff mechanisms:

**1. Component-level handoff — Visual Script calls a TypeScript function via
the `Call Script API` action node.**
- Wire the TypeScript component's SceneObject into the node.
- The node lists all `public` (non-underscored) functions on attached
  TypeScript components.
- Pass arguments as data wires; the return value flows out as a data wire.
- Useful for "graph reacts to UI, then asks the controller to do the heavy
  lifting".

**2. Event bus — both sides emit and listen for global events.**
- TypeScript side: `global.behaviorSystem.sendCustomTrigger("myEvent")` or
  `script.createEvent("CustomEvent")`.
- Visual Scripting side: `On Trigger` event node listening on the same name.
- Use this when the producer doesn't know who the listeners are (loose
  coupling). The downside is no static type checking — name typos silently
  drop.

**3. Shared component state — both sides read/write the same component.**
- e.g., TypeScript controller toggles `myObject.enabled = false`; Visual
  Script uses `Get Enabled` on the same object and branches.
- Cleanest when the shared state is a component property; brittle when it's
  custom data on the object.

---

## Common patterns

### Pattern A — Tap → play tween → fire audio → trigger script

UI element with InteractionComponent. Visual Script on the same object:

```
OnTap (event)
  └─ Play Tween (action, ref → Tween Manager component on target object)
     └─ Play Audio (action, ref → Audio Component)
        └─ Call Script API (action, ref → Controller, function → onTap)
```

Fine for prototypes and for UI that does no real branching. If you need
"play tween A if X, else tween B" with X coming from outside the graph,
push the decision to TypeScript and have it call the right tween.

### Pattern B — Face tracking trigger

```
OnFaceFound (event, ref → Face Tracking component)
  └─ Set Enabled (action, target → "face overlay" SceneObject, value → true)
OnFaceLost (event)
  └─ Set Enabled (action, target → "face overlay", value → false)
```

A staple for showing/hiding face accessories. Could also live in TypeScript
but the graph is faster to author and read.

### Pattern C — Timer-driven loop

```
OnAwake
  └─ Delay (1.5s) → fire Custom Event "tick"

On Trigger "tick"
  └─ Toggle visual on some object
  └─ Delay (1.5s) → fire Custom Event "tick"
```

A self-firing timer using custom events. Works but is hard to *stop* cleanly
later — for anything you might cancel (e.g. user closes a panel), prefer a
TypeScript controller with `createEvent("DelayedCallbackEvent")` that you
can dispose.

### Pattern D — Math-driven material parameter

```
OnFrame
  └─ Get Time (value) → Sin (value, expression node) → Multiply by 0.5
       → Set Material Param (action, target → material, param → "pulse")
```

A pulsing material parameter. Fast to set up; clear in the graph; no
controller code needed. If the math gets more than 3 nodes deep, write a
`MathNode` expression node or move to TypeScript.

---

## Pitfalls

### P1 — Renaming a TypeScript function breaks the `Call Script API` node silently

The Visual Script stores the function name as a string. Rename the TS
function, the graph still compiles, the node just no-ops at runtime. **Search
for `Call Script API` node bindings whenever you rename a public function**,
or wrap the function call inside the script with a stable name.

### P2 — Custom event name typos drop silently

Same root cause as P1: events are strings. `sendCustomTrigger("myEvet")`
fires into the void. There's no compiler-time check.

Mitigation: centralize event names in a TypeScript module
(`export const EVENTS = { TAP: "tap", RESULT: "result" }`) and reference
that constant from TS. Visual Scripts will still hand-type the name — so
the constants file becomes the source of truth, and a `grep` finds typos.

### P3 — Per-frame work in a graph is harder to profile than TypeScript

A graph that ticks every frame (e.g. Pattern D above) doesn't show up
clearly in the LS Performance Inspector. If a lens drops frames and there's
a per-frame Visual Script in the scene, suspect it first — move it to
TypeScript where you can see the cost more clearly.

### P4 — Two Visual Scripts on the same OnTap event fire in undefined order

If two graphs both listen to `OnTap` on the same InteractionComponent, the
fire order is not guaranteed by the editor. For "play sound, then animation,
then text reveal" ordering, put the sequence inside a single graph (chain
exec wires) or move to a TypeScript controller that explicitly orders the
calls.

### P5 — `On Frame` and `On Late Update` differ subtly

`On Frame` runs in the update phase. `On Late Update` runs after transforms
have been applied for the frame — use it for "follow the head's *final*
position" style logic. Using `On Frame` for follow-the-head produces 1-frame
lag.

### P6 — Visual Script asset path matters for the MCP (empirically verified)

When using `scene-graphql` mutations on a `VisualScriptComponent`, the
`asset` reference must be the asset id of the `.vs` file. **The MCP
cannot edit the graph nodes themselves** — confirmed empirically via
probe against LS 5.21: the Editor Scripting API exposes Script Graph
assets as opaque (no `nodes`, no `connections` enumerable properties);
`Editor.Graph.convertGraphToYaml` / `convertYamlToGraph` exist at runtime
but are not in the public TypeScript types and their signature is
undocumented. Use the LS UI for node-level changes, and use MCP only to
bind the asset to a component or to enable/disable the component.

Detail: see `lens-studio-api-gotchas.md` § "Shader Graph / VFX Graph /
Script Graph node structure is NOT editable via the public Editor API".

---

## Generalizable agent guidance

When designing a feature with the user, ask:

> "Is this logic mostly event → reaction with light state, or is there real
>  data work happening here? If event → reaction, Visual Scripting is faster
>  and more readable. If data work, TypeScript."

When a user shows up with a prototype Visual Script that has grown too big:
look for these smells and offer to extract the controller into TypeScript:

- More than ~12 nodes per event
- More than 2 nested `Branch` nodes
- Any node doing string parsing or array iteration
- Any state that needs to survive a tween restart

For Phase 2 scripting work, *default to TypeScript controllers* and use
Visual Scripts only where a designer will likely want to tweak the graph
later without touching code. The agent should not auto-generate Visual
Scripts as a primary tool unless the user explicitly asks.

---

## Cross-references

- `references/composition-patterns.md` § "Event-graph glue pattern" — when
  Visual Scripting is the right shape architecturally
- `references/lens-studio-api-gotchas.md` — TypeScript decorator gotchas
  (`@input`, `@allowUndefined`, custom-type registration)
- `references/phase-progression.md` § Phase 2 — when TypeScript controllers
  get authored
