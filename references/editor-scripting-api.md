# Editor Scripting API — guide

Lens Studio 5.17+ exposes an **Editor Scripting API**: TypeScript / JavaScript
code that runs *inside the editor* (not inside the lens at runtime). It is
how the LS MCP server itself executes mutations against the open project,
how custom Lens Studio plugins extend the UI, and how you can author one-shot
project-level automation that the runtime API can't reach.

This is a different runtime than lens code. Lens scripts (`.ts` files under
`Assets/Scripts/`) execute when a user runs the lens in Snapchat. Editor
scripts execute *only inside the LS app*, with access to project files, the
asset library, the scene graph, and editor UI hooks. They never ship with
the final `.lens` bundle.

This file describes when to reach for it, how the MCP `ExecuteEditorCode`
tool relates to it, and the gotchas that come with editor-side code.

---

## What's in the API surface

The editor-side API is roughly three things:

**1. Project mutation API** — read and write the scene graph and assets the
same way the LS UI does:

- `LensStudio.openProject(path)` / `LensStudio.activeProject` — get a handle
  on the project
- `project.scene` — the scene root; same hierarchy you see in the Objects
  panel
- `scene.createSceneObject(parent)` — create a new SceneObject
- `obj.addComponent("Component.ScreenTransform")` — add components by id
- `obj.setProperty("anchors.top", 0.5)` — set component properties (this is
  what `scene-graphql` wraps)
- `project.assets.import(filePath)` — import an asset from disk
- `project.assets.createMaterial(graphTemplate)` — create a material

**2. Editor UI extension API** — register custom panels, menu items,
inspectors. Used by LS plugins (the third-party ones that show up under
Window menu or as inspectors on specific component types). Less relevant
for lens authoring; relevant if the user wants to ship a plugin.

**3. Lifecycle hooks** — `LensStudio.onProjectOpened`, `onProjectSaved`,
`onSceneSelectionChanged`. Used for tooling that reacts to editor actions.

---

## When to reach for it

**Reach for editor scripting when:**

- You need to mutate the *project file structure* (move assets, rename
  folders, batch-import textures) at scale.
- You need to run a one-shot scan over the scene to find/fix patterns (e.g.,
  "find every Text component with font size > 60 and clamp it to 60").
- You need to validate scene invariants before commit ("assert every
  SceneObject under `UI Root` has a ScreenTransform").
- You're building a **Lens Studio plugin** that ships outside the lens
  bundle and lives in the editor for other authors to use.

**Do not reach for it when:**

- The logic is part of the lens runtime — that's a regular `.ts` component
  under `Assets/Scripts/`.
- You only need to do one mutation interactively — use the LS UI or the
  scene-graphql MCP.
- The change is small enough to do in 2 minutes by hand — editor scripts
  have a setup cost that doesn't pay back for tiny edits.

---

## How MCP `ExecuteEditorCode` fits in

The Lens Studio MCP server exposes `mcp__lens-studio__ExecuteEditorCode` —
**this runs editor-scripting code inside the open LS instance**, in the
same execution environment a plugin would. It is the *most powerful tool
in the MCP toolbox* and the most underused.

Capabilities that `ExecuteEditorCode` unlocks beyond `scene-graphql`:

| Need | scene-graphql | ExecuteEditorCode |
|---|---|---|
| Read a single property | ✓ | ✓ |
| Set a single property | ✓ | ✓ |
| Walk the entire scene tree and filter | clunky (N round trips) | one trip |
| Read-back after compound-type setProperty | ✓ | ✓ (cheaper) |
| Mutate dozens of objects at once | one mutation per call | one trip |
| Inspect runtime state (asset registry, package list) | partial | full |
| Conditional mutations ("if X, then set Y") | requires multiple round trips | one trip |
| Compute a value from the scene and apply it | impossible | trivial |

Pattern — when probing N similar objects (per `operational-rules.md` rule 6):

```typescript
// scene-graphql way: N round trips
// ExecuteEditorCode way: one round trip
const slots = scene.findAllByName("Slot");
const results = slots.map(s => {
  const st = s.getComponent("Component.ScreenTransform");
  return { name: s.name, top: st.anchors.top, bottom: st.anchors.bottom };
});
return JSON.stringify(results, null, 2);
```

Use `ExecuteEditorCode` for:

- **Probes that touch >3 objects** — one call beats 3+ round trips
- **Read-back after a setProperty** when you already had to issue the call
  via ExecuteEditorCode anyway
- **Anything that computes from the scene** (e.g., "what's the bounding box
  of all UI elements combined?")
- **Conditional mutations** that would otherwise require client-side
  branching plus another MCP call

Do NOT use `ExecuteEditorCode` for:

- Single-property reads or writes — `scene-graphql` is shorter, returns
  structured data, and is easier to read in the transcript
- Anything where the mutation needs to be visible/diffable in the LS UI
  *during* the call (ExecuteEditorCode mutations may not update the
  Inspector view until the user clicks the object — same ⌘S handshake
  applies)

---

## Gotchas

### G1 — Editor scripts run in a TypeScript subset, not full Node

There is no `fs`, no `require()` for arbitrary npm modules, no `process`.
You have `LensStudio.*` globals, basic JS standard library, and console
logging. If you need filesystem access for a one-shot, do it from the
*outside* (Bash + Read/Write tools), not from inside an editor script.

### G2 — Mutations from `ExecuteEditorCode` need ⌘S to persist to disk

Same rule as `scene-graphql`: anything that changes scene state lives in
the editor's in-memory project until the user (or the script) saves. The
script *can* call `LensStudio.activeProject.save()` programmatically, but
**ask the user first** before doing that — they may have unsaved manual
edits in flight that they don't want bundled with your save.

### G3 — Errors in editor scripts surface in the LS Logger panel, not in the
MCP response

`ExecuteEditorCode` returns a string of whatever you `return` from your
code. Uncaught exceptions inside the editor-script body sometimes return
the error message; sometimes they return `undefined` and the actual error
is in the LS Logger panel. When something silently fails: open
**Window → Logger** in LS and check.

### G4 — Some `setProperty` paths only work via editor-script `obj.X = Y`,
not via `setProperty("X", Y)`

The compound-type silent-drop gotcha (RECT, VEC4, VEC2 — see
`lens-studio-api-gotchas.md`) applies to both `scene-graphql` and
`ExecuteEditorCode` when you call `setProperty`. But editor scripts have
the option of doing direct assignment:

```typescript
// silent-drop risk:
obj.getComponent("ScreenTransform").setProperty("anchors", {top: 1, bottom: -1, left: -1, right: 1});

// safe — direct assignment hits the real setter:
const st = obj.getComponent("ScreenTransform");
st.anchors.top = 1;
st.anchors.bottom = -1;
st.anchors.left = -1;
st.anchors.right = 1;
```

Prefer direct assignment inside editor scripts unless you have a specific
reason to use `setProperty`.

### G5 — `findByName` is case-sensitive and matches only the first hit

Use `findAllByName` for ambiguous names. For unique-name lookups, prefer
asset id (stable across renames) over name.

### G6 — Editor scripts run synchronously, no `await`

There is no async runtime; if you need to "wait" for something (e.g., a
file import to complete), use the relevant callback API or poll the
returned handle. `setTimeout` is not available.

---

## Common editor-scripting recipes

### Recipe 1 — Bulk-rename slots

```typescript
const slots = scene.findAllByName("Slot");
slots.forEach((s, i) => { s.name = `Slot_${String(i).padStart(2, "0")}`; });
return `Renamed ${slots.length} slots`;
```

### Recipe 2 — Audit which SceneObjects lack a ScreenTransform under UI Root

```typescript
const uiRoot = scene.findByName("UI Root");
const missing = [];
const walk = (obj) => {
  if (!obj.getComponent("Component.ScreenTransform")) missing.push(obj.name);
  for (let i = 0; i < obj.childCount; i++) walk(obj.getChild(i));
};
walk(uiRoot);
return JSON.stringify(missing);
```

### Recipe 3 — Snapshot all anchor values for visual diff

```typescript
const out = {};
const walk = (obj) => {
  const st = obj.getComponent("Component.ScreenTransform");
  if (st) out[obj.name] = { top: st.anchors.top, bottom: st.anchors.bottom, left: st.anchors.left, right: st.anchors.right };
  for (let i = 0; i < obj.childCount; i++) walk(obj.getChild(i));
};
walk(scene);
return JSON.stringify(out, null, 2);
```

Snapshot before and after a polish iteration — diff the two JSON strings
to confirm only the intended objects changed.

### Recipe 4 — Find all references to a material

```typescript
const targetMat = project.assets.findByName("MyMaterial");
const refs = [];
const walk = (obj) => {
  const visual = obj.getComponent("Component.Visual");
  if (visual && visual.mainMaterial === targetMat) refs.push(obj.name);
  for (let i = 0; i < obj.childCount; i++) walk(obj.getChild(i));
};
walk(scene);
return JSON.stringify(refs);
```

Useful before deleting a material — confirm nothing depends on it.

---

## Packaging / distribution via `LensStudio:Spk`

The editor scripting module `LensStudio:Spk` is described in Snap's plugin docs as "Toolkit for packaging and distributing Lens Studio projects." It lives in the editor-scripting world, not as a standalone CLI — invoke it from a plugin or `ExecuteEditorCode`. Specific public API surface isn't deeply documented, but the module name confirms that **packaging automation is intentionally inside Lens Studio's process, not headless**.

For an agent: if a user asks "can we automate `.lens` exports via CI?", the honest answer is "not via a public CLI — automation must run inside LS via plugins or MCP". `LensStudio:Spk` is the entry point to investigate when this comes up.

Source: Snap 5.x plugin / editor scripting docs.

---

## Plugin authoring (sketch)

Lens Studio plugins are editor-side scripts that register UI extensions.
They live in `~/Documents/Lens Studio/Plugins/` (path varies per OS) and
are loaded at LS startup.

A plugin's `package.json`-like manifest declares which extension points it
hooks (custom inspector, menu item, side panel). The script then calls
`LensStudio.registerInspector(...)` or similar.

This skill does **not** auto-author plugins — they're a niche use case for
agency work, and the cost-to-value ratio is poor for one-off lens projects.
If a user explicitly asks for plugin authoring, escalate to the LS Plugin
documentation directly rather than guessing at the API surface from this
file.

---

## Generalizable agent guidance

For lens *authoring*: prefer `scene-graphql` for single-property work,
prefer `ExecuteEditorCode` when N > 3 objects or when you need to compute.

For project-level *automation* (one-shot batch operations): write an
editor script and run it via `ExecuteEditorCode` — don't fall back to
"open LS UI and click manually" for anything that touches more than 5
objects.

For *plugin* development: out of scope by default. Ask the user to
confirm before going there.

---

## Cross-references

- `references/mcp-setup.md` — connect/reconnect playbook for the MCP
- `references/operational-rules.md` § 6 (probe + bulk mutation) — when
  `ExecuteEditorCode` is the right tool
- `references/lens-studio-api-gotchas.md` § setProperty compound-type
  silent drop — applies to editor-script `setProperty` calls too
