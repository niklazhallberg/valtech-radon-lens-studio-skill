# Graph authoring protocol — Shader, VFX, Script Graph

When a user asks for help with Shader Graph, VFX Graph, or Script Graph
(Visual Scripting) authoring, the agent does **not** have a public Editor
API for editing graph node structure — see `lens-studio-api-gotchas.md` §
"Shader Graph / VFX Graph / Script Graph node structure is NOT editable
via the public Editor API" for the empirical proof.

That doesn't mean the agent is useless here. It means the *work model*
has to be different: the agent runs as a plugin author + probe runner,
not as a raw asset editor. This file defines that work model.

---

## Four-mode discipline

For any task that touches a graph editor, the agent operates in one of
four modes — explicitly stated in the response so the user knows which
gear we're in.

### Mode 1 — Discover

**Goal**: map the available surface before doing anything.

- Enumerate `Editor.*` namespaces, `Editor.Assets.*` types, `Editor.Components.*`.
- List the assets in the project by type (`asset-graphql { allAssets(typeFilter: …) }`).
- Identify which graph entrypoints exist (e.g., `ShaderGraphPass`, `VFXAsset`, `ScriptGraphAsset`).
- Check if the asset is serializable out without mutation (sourcePath, fileMeta.assets, getOwnedEntities).
- Report findings to the user as a discovery summary.

**Discover-mode prompts to surface**:

> "Found N ShaderGraphPass assets in the project. Their on-disk source
> is `.ss_graph` (binary). Editor API exposes them as opaque (id, name,
> type only). No public node-mutation API."

Discover never mutates. Read-only.

### Mode 2 — Probe

**Goal**: run small, reversible tests on a **throwaway asset**, never on the user's production assets.

- Create a throwaway asset with a recognizable prefix (e.g., `__PROBE_DELETE_ME`).
- Test the smallest possible operation (read a property, call an API with one input).
- Read back the result; compare expected vs actual.
- Delete the throwaway when done.

**Probe-mode discipline**:

- Always prefix throwaway asset names with `__PROBE_` so they're greppable for cleanup.
- Always clean up at the end of the probe, even if the probe fails.
- If the user is monitoring LS visually, tell them what the probe is doing and what they should see.
- One probe = one hypothesis. Don't chain "while I'm here, also try X" — that's how cleanup gets missed.

### Mode 3 — Mutate

**Goal**: apply a verified change to the real asset.

**Entry conditions** (all must hold):
1. Discover mode mapped the surface.
2. Probe mode round-tripped the same operation on a throwaway asset.
3. The user has explicitly approved the specific mutation.
4. The agent has a verification step queued for after the mutation
   (open the asset in the LS editor, check it didn't break).

Never enter Mutate mode without all four. If the user says "just try
it on the real thing", explain the risk and offer to probe first.

### Mode 4 — Explain

**Goal**: separate verified facts from hypothesis, so the user can
trust the agent's claims.

After any work session that involved graph APIs, the agent writes (or
prepares to write) an Explain summary in this exact format:

```
## Verified working
- <thing> — confirmed via <probe>, evidence: <what we saw>

## Working but undocumented
- <thing> — works at runtime, NOT in public TS types, signature unclear,
  could break on next LS update

## Read-only only
- <thing> — can introspect, cannot mutate via documented API

## Unsafe / do not use
- <thing> — fails in <situation>, or has unclear semantics
```

This becomes the **capability ledger** for the project (see below).

---

## Capability ledger pattern

For each lens project that touches graphs, maintain a small ledger in
the project root: `GRAPH-CAPABILITY-LEDGER.md`. Each row is one tested
operation with one of four states:

- ✅ **Verified working** — empirically probed, deterministic, documented
- ⚠️ **Working but undocumented** — works at runtime, not in public types
- 👁️ **Read-only only** — introspection OK, no mutation path
- 🚫 **Unsafe / do not use** — fails or has unclear semantics

Example:

```markdown
| Operation | Graph type | State | Notes |
|---|---|---|---|
| Read material parameter values | Shader Graph | ✅ | via mat.mainPass.X |
| Write material parameter values | Shader Graph | ✅ | via mat.mainPass.X |
| Read ShaderGraphPass node list | Shader Graph | 👁️ | opaque asset only |
| Edit ShaderGraphPass node connections | Shader Graph | 🚫 | no API |
| Read VFX property values | VFX | ✅ | script.vfx.asset.properties |
| Edit VFX graph node structure | VFX | 🚫 | no API |
| Bind .vs asset to VisualScriptComponent | Script Graph | ✅ | scene-graphql |
| Edit Script Graph nodes | Script Graph | 🚫 | no API |
```

Use the ledger before suggesting an operation to the user. If an
operation isn't in the ledger, drop into Discover/Probe modes before
committing to it.

---

## Per-graph priority (when graph automation is genuinely needed)

If a project needs graph automation beyond what the current API allows,
work through them in this order — easiest to hardest:

### 1. Script Graph (Visual Scripting) — easiest target

**Why first**: Snap documents the structure best (Event nodes, Script
inputs, Asset references, Variables, Sub-graphs, Custom Nodes). The
recommended approach is to **not author complex logic in the graph
itself** — use the graph for wiring (event → action → asset reference)
and put logic in **Custom Nodes**, which are TypeScript files.

**Bridge pattern** (recommended architecture):

- **Script Graph** does: event listening, asset wiring, simple state
  toggles, sub-graph composition.
- **Custom Nodes** (TypeScript files registered as graph nodes) do:
  data manipulation, math, conditional logic, JSON parsing, anything
  with arrays or maps.

The agent can author and edit Custom Node TypeScript freely — it's
just `.ts` files. The Script Graph wiring stays in the LS UI but is
thin and stable because the logic lives in code.

**Why this works**: graph wiring rarely changes once the lens architecture
is set; logic changes constantly. Pushing logic to code = fewer graph
modifications = less friction with the "no graph mutation API" reality.

### 2. Shader Graph — round-trip test target

**Why second**: undocumented runtime helpers (`Editor.Graph.convertGraphToYaml`)
exist and *might* support round-trip authoring, but the signature is
unknown and not in public types. Worth investigating IF a project has
strong need; not worth investigating speculatively.

**Investigation order** (only if user explicitly asks):

1. Discover the YAML schema — call `convertGraphToYaml` with every
   plausible argument shape; capture any successful output.
2. If a YAML representation can be extracted: do a no-op round-trip
   (export → import unchanged → verify the asset still opens and renders).
3. If round-trip works: try the smallest possible mutation (change a
   literal value, add an unconnected parameter).
4. If mutation works: build verification (open in editor, check warnings,
   confirm attach to a Visual still renders).

Treat anything reached via undocumented API as ⚠️ **Working but
undocumented** in the ledger. Could break on next LS update.

### 3. VFX Graph — most fragile

**Why last**: VFX graphs carry implicit phase structure (spawn / update /
render) and editor-dependent metadata. Mutations are more likely to
silently break the effect than in Shader Graph. The agent should not
attempt VFX graph mutation without a strong user need and the user's
explicit acknowledgement that this is experimental.

If a project genuinely requires VFX graph automation, start with the
**most boring possible** mutation: change one numeric default value on
an existing exposed parameter, round-trip, open in editor, verify
visually. Build up confidence from there.

---

## Plugin-author mindset

The agent's role around graphs is **plugin author + probe runner**, not
**file editor**.

What this means concretely:

- **Don't edit binary files by hand.** `.ss_graph`, `.vfx`, `.vs` are
  binary or semi-binary. Direct file writes are not safe.
- **Don't promise mutation capabilities the API doesn't support.** "I'll
  add a node to your shader graph" is a promise the agent can't keep.
  The honest answer is "I can drive parameter values; node-level edits
  are your job in the UI."
- **Use `SetLensStudioSelection` as the handoff mechanism.** When the
  agent identifies which asset or scene object needs a graph-level edit,
  it selects the asset and tells the user what to do in the panel.
- **Verify after every user-driven graph edit.** Once the user reports
  the edit done, probe the result (parameter values, asset references,
  visible effect) and confirm.

---

## What's left for the agent to do

The non-graph surface is huge and CC can do all of it:

- **Material parameters** — read/write via runtime API.
- **Render-state on Material passes** — blendMode, twoSided, depthWrite,
  cullMode, etc.
- **VFX property values** — `script.vfx.asset.properties['name'] = value`.
- **VisualScriptComponent asset binding** — pick which .vs runs.
- **Custom Node TypeScript** — full author/edit/refactor.
- **Material asset create / delete / rename** — via asset-graphql.
- **Pass add / remove** on a Material — via runtime `addPass` / `passInfos`.
- **Asset Library installation** — drop in pre-built shader/VFX presets,
  then let user customize via parameters.

Frame the agent's graph-related contribution in these terms. The
position is "I drive the values and the wiring; you author the graph
shape" — and that's a productive division of labor.

---

## Decision template — when a brief touches graphs

When the brief calls for stylized shading / particles / behavior graphs:

1. Identify which graph type the brief implies (Shader / VFX / Script).
2. Ask the user: "Are you authoring the graph yourself, or do you want
   me to drive everything I can drive (parameters, wiring, asset
   selection)?"
3. If they say "I'll author the graph": agent stays in Read-only +
   parameter-driver mode. User does the graph; agent does everything else.
4. If they say "Can you drive everything?": explain the boundary
   (graph node structure = user; everything else = agent). Confirm
   the role split before starting.

Be explicit about the boundary up front. Discovering the boundary
mid-build is more painful than acknowledging it at intake.

---

## Cross-references

- `references/lens-studio-api-gotchas.md` § "Shader Graph / VFX Graph /
  Script Graph node structure is NOT editable via the public Editor API"
  — the empirical proof
- `references/editor-scripting-api.md` — what `ExecuteEditorCode` CAN
  do (the surface the four modes operate against)
- `references/visual-scripting-guide.md` — the Custom Node bridge
  pattern for Script Graph
- `references/material-editor-guide.md` § P8 — parameter-driving as
  the agent's actual contribution to shader work
