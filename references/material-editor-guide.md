# Material Editor — guide

Lens Studio's **Material Editor** is a node-graph shader authoring tool.
Every visual element in a lens — a Render Mesh, a face overlay, an Image,
a particle quad — samples a Material at draw time. The Material wraps a
shader; the shader is either a built-in (PBR, Unlit, Sprite) or a custom
graph authored in the Material Editor.

This file describes when to author custom materials vs use built-ins, how
the graph maps to GPU work, common shapes (face lookup table / colour
grade, screen-space dissolve, animated UV scroll, normal-mapped stylize),
and the pitfalls that bite mid-build.

---

## PBR vs Graph Unlit — the lighting heuristic

Snap's official 5.x docs say it explicitly: if the visual content **does not need lighting**, use `Graph Unlit` rather than routing through `PBR (Lighting)`. The mental model:

- **PBR** → the object exists in a lit 3D world, has surface properties (metallic, roughness, normals), receives shadows. Use for: 3D characters, props, geometry that should "feel real" alongside the camera feed.
- **Graph Unlit** → the effect is screen-space, UI-anchored, mask-oriented, compositing-style, or full-frame post-processing. Use for: color grades, overlays, sprites, screen UI, LUT applications, glitch / vignette / chromatic aberration, dissolve transitions.

Cost difference is real: PBR includes light loops, normal calculations, environment sampling. Unlit skips all of that — faster on mid-range Android and simpler graphs.

Rule of thumb when reading a brief: if the visual would look the same with or without the lens's lights, you want Unlit. Source: Snap 5.x Material Editor docs.

## When to reach for the Material Editor

**Reach for it when:**

- You need a **stylized look** that the built-in Unlit/PBR shaders can't
  produce — toon shading, halftone, glitch, hand-painted, color-graded
  pass.
- The visual depends on **screen-space data** (camera frame, depth,
  position) — built-ins don't expose those, the Material Editor does via
  `Camera Frame` and `Position World` nodes.
- The visual depends on **tracking data** (face landmarks, hand position,
  body joints) flowing into the shader as uniforms.
- The visual needs **animation that's expensive to do per-frame in CPU**
  (vertex displacement, UV scroll, noise patterns) — push it to GPU via
  the shader.

**Don't reach for it when:**

- You only need a flat-coloured or textured sprite — `Sprite Material`
  (built-in) takes a texture and a tint and is done.
- You only need PBR — `PBR Material` ships with the standard inputs and
  is faster to author than rebuilding from nodes.
- You're tuning *values* not *structure* — bind the value to a Material
  parameter and adjust from the Inspector or from TypeScript; don't
  re-author the graph.

---

## Graph anatomy

Every Material Editor graph has:

**Inputs** (left side of canvas):
- Texture parameters (color textures, masks, lookup tables)
- Scalar/vector parameters (tint colours, blend factors, thresholds)
- Built-in inputs: `UV`, `Position World`, `Normal World`, `Camera Frame`,
  `Time`, `Screen Position`

**Computation nodes** (middle):
- Math nodes: `Add`, `Multiply`, `Lerp`, `Smoothstep`, `Sin`
- Texture sample nodes: `Sample Texture 2D`
- Vector ops: `Dot`, `Cross`, `Normalize`, `Mix`
- Control flow: `Branch` (if/else — note: GPU branches are not free, both
  branches execute and the result is selected — see Pitfall P3)

**Outputs** (right side, fixed sockets):
- `Albedo` (final RGB color)
- `Alpha` (transparency)
- `Emissive` (self-illumination)
- `Normal` (for PBR variants)

A Material graph is **stateless and per-pixel** — every wire computes
once per fragment, every frame. No persistence between frames; no read
from previous frame (use a render target chain — see
`composition-patterns.md` § "Multi-pass render target chain" — for
inter-frame state).

---

## Custom Code Node — drop into GLSL when graph nodes aren't enough

The `Custom Code` node (also called Code Node) lets you write **almost-pure GLSL** directly inside a Material Graph. Snap's docs describe it as native GLSL that Lens Studio analyzes and runs through a cross-compiler to device-safe shader code (so it'll work across iOS/Android).

Shape of the node body:

```glsl
input float intensity;
input vec3 baseColor;
output vec4 result;

void main() {
  result = vec4(baseColor * intensity, 1.0);
}
```

- `input X` / `output X` declarations at the top create the node's input and output ports
- A `main()` function is required — it's the entry point
- Standard GLSL math, swizzles, conditionals, loops work
- `Custom Code Global` (separate node) lets you declare functions/globals that other Custom Code nodes can call

**When to reach for it**: when you've hit the limits of graph-node composition — typically iterative algorithms (raymarching, custom blur kernels, signed-distance fields), or when you want to encapsulate a math chain that's already cleaner in GLSL than as 8 chained nodes. Same mechanic exists in **VFX Editor** Custom Code nodes (Spawn / Update / Output context variants).

Source: Snap 5.x Material Editor + VFX Editor docs.

## Functional node taxonomy

Snap's docs organize Material Editor nodes under technical menu categories (Functions / Inputs / Main / Math). The functional grouping below is more useful when picking nodes for a brief:

| Group | Purpose | Representative nodes |
|---|---|---|
| **Shading / PBR** | Lit 3D surface rendering with basecolor, normals, roughness, metallic, opacity, overrides | `PBR (Lighting)`, `Override`, `Faceted Normal`, `Linear Tone Mapping` |
| **Texture sampling** | 2D / 3D / cube / array texture reads, direct or via object parameters | `Texture 2D Sample`, `Texture 2D Parameter`, `Texture 3D Parameter`, `Texture Cube Parameter`, `Texture 2D Array Parameter` |
| **UV / coordinate transform** | Scroll, rotate, scale, triplanar, parallax, flipbook, flow-map sampling | `Rotate Coords`, `Scale Coords`, `Scroll Coords`, `Triplanar UV Coord`, `Parallax Coords`, `Flipbook Coords`, `Flow Map Sample` |
| **Math / logic / interpolation** | Arithmetic, swizzles, vector/matrix construction, conditionals, loops, mix | `Add`, `Subtract`, `Multiply`, `Mix`, `Construct Vector`, `Construct Matrix`, `Switch`, `Conditional`, `If/else`, Loop nodes |
| **Vectors / matrices / transforms** | Space conversion, world/camera/object data, vertex-to-pixel transfer | `Transform Vector`, `Transform by Matrix`, `Matrix Parameter`, `Get Object Transform`, `Interpolate` |
| **Time / animation** | Time, delta time, fluctuation, parameter modulation over time | `Elapsed Time`, `Delta Time`, `Fluctuate` |
| **Noise / procedural** | Procedural texturing, variation, gradients, value fields | `Noise (Simplex)`, `Voronoi Noise`, `Random Noise`, `Gradient` |
| **Screen-space / camera / surface** | Full-frame effects, depth-aware logic, view-dependent shading, screen-derived values | `Depth`, `DDX`, `DDY`, `FWidth`, `Camera Position`, `Camera Facing Ratio`, `View Vector`, `Screen UV Coord`, `Position From Depth` |
| **Lighting / environment** | Read lights, shadows, environment maps; combine with shading | `Light Color`, `Light Direction`, `Light Intensity`, `Light Position`, `Environment Sample`, `Shadow Sample`, Loop (Lights) |
| **Parameters / exposure** | Make the graph script-controllable; scalars, colors, textures, arrays, curves, matrices, dropdowns | `Bool Parameter`, `Color Parameter`, `Float Parameter`, `Int Parameter`, `Texture 2D Object Parameter`, `Float Array Object Parameter`, `Curve Parameter`, `DropList Parameter`, `Matrix Parameter` |
| **Subgraphs / reuse** | Encapsulate logic, reuse node clusters | Sub-Graph imports/exports, Sub-Graph library |
| **Custom shader code** | Drop into GLSL when graph nodes don't suffice | `Custom Code`, `Custom Code Global` |

Use this when a brief asks for a specific effect — pick the group first, then the node. Source: Snap 5.x docs (functional re-grouping by us, not an official taxonomy).

## Material parameters: the script ↔ shader handoff

This is the most important bit for the agent to internalize.

A Material has **parameters** (scalars, vec2/3/4, textures) declared in
the graph as Inputs. Each parameter gets a stable name. At runtime,
TypeScript can read/write any parameter:

```typescript
const mat = this.visual.mainMaterial;
mat.mainPass.tintColor = new vec4(1, 0.5, 0, 1);   // VEC4 → vec4
mat.mainPass.threshold = 0.7;                       // FLOAT → number
mat.mainPass.mask = someTextureAsset;               // TEXTURE → asset
```

Parameter names in the graph become property names on `mainPass` at
runtime. The naming convention is loose — but **avoid spaces and
hyphens** in parameter names, they don't survive the script bridge cleanly.
`tintColor`, `threshold`, `mask` are safe; `Tint Color`, `tint-color` are
risky.

Tween Manager has direct support for Material parameters:
`TweenMaterial` (component) tweens a named parameter from A to B over T
seconds. Most "fade in by changing alpha", "shift colour to red on tap",
"animate dissolve" effects use this rather than a per-frame script.

For mass parameter assignment (e.g., applying the same look to N
materials), MCP `ExecuteEditorCode` lets you iterate over all materials
of a type and set parameters in one trip — see
`references/editor-scripting-api.md` § Recipe 4.

---

## Common material recipes

### Recipe M1 — Color grade with lookup table

A 1D LUT (lookup table) texture remaps RGB through a curve. Cheap, fast,
and the standard way to apply a "look" to a camera feed or face overlay.

```
Camera Frame (input) → Sample Texture 2D (with LUT as texture, UV = RGB)
                    → Albedo (output)
```

Use Snap's `Color Correction` LUTs from the Asset Library as a starting
point — the graph for them is exactly this shape.

### Recipe M2 — Screen-space dissolve

A noise texture + a threshold parameter. Pixels where `noise < threshold`
go transparent; the rest stay opaque. Animate `threshold` from 1.0 → 0.0
via TweenMaterial to dissolve the visual away.

```
Sample Noise Texture (UV input)
  → Step (input "noise", threshold param)
  → Alpha output

Albedo from regular texture or color
```

### Recipe M3 — UV scroll

Animated texture pan. Useful for water, conveyor belts, scrolling banners.

```
UV (input) + Vector2(Time * speedX, Time * speedY)
  → Sample Texture 2D
  → Albedo
```

`Time` is a built-in input that auto-updates every frame; no script needed.

### Recipe M4 — Face-data-driven distortion

For a face material where the distortion magnitude depends on landmark
distance (e.g., mouth-open driving a chin stretch). The script writes the
landmark distance into a material parameter; the shader does the warp.

```
Script per-frame:
  mat.mainPass.mouthOpen = (lowerLip.y - upperLip.y);

Shader:
  UV - Vector2(0, mouthOpen * 0.1)   // pull UV up by mouth-open factor
  → Sample Texture 2D
  → Albedo
```

The expensive math (face landmark sampling) stays on CPU; the cheap
per-pixel work (UV offset) goes to GPU. Right division of labor.

### Recipe M5 — Stylized outline (sketch / cartoon)

Render the mesh twice: once front-faced normally, once back-faced
expanded along normals with a black material. The expanded back-faces
peek out as an outline.

This isn't a one-material recipe — it's a two-pass setup. Use a Material
group with two materials, or a Full Frame Effect (see
`composition-patterns.md` § "Full Frame Effect"). The Material Editor
authors the inner material; the outer pass usually uses a flat colour.

### Recipe M6 — Camera-feed blur sample

For background blur or frosted-glass effects:

```
Sample Camera Frame at UV → blur kernel (5-7 taps) → average → Albedo
```

This is more expensive than it looks; on mid-range Android, a 7-tap blur
per-pixel can drop FPS visibly. Use the **Gaussian Blur Preset** instead
when possible (it's optimized to two passes) — only hand-roll if the
preset can't do what you need.

---

## Pitfalls

### P0 — Bool parameters marked "Static" cannot be changed from script at runtime

When you add a `Bool Parameter` node to a Material Graph and mark it **Static** in its properties, the parameter compiles into the shader as a compile-time constant (used for code-branch generation / dead-code elimination). The shader is faster — but `material.mainPass.<paramName> = true` from a Script Component at runtime **has no effect**: the value is baked into the compiled shader binary.

**Symptom**: you toggle a bool in TS, expect the visual to switch, nothing happens. No error, no warning.

**Mitigation**: for any bool parameter the agent expects to mutate at runtime, leave Static **unchecked** in the Material Graph. Reserve Static for booleans that only differ between materials (e.g., "this material is the night variant" — chosen once at design time).

Source: Snap 5.x Material Editor parameter docs.

### P1 — Material parameter name typos drop silently

`mat.mainPass.tintColor = ...` against a graph that calls the parameter
`tintCol` will not throw — it sets a new property on the runtime object
that the shader never reads. Visual looks unchanged; no warning.

Mitigation: after wiring a Material parameter from TypeScript, **probe
back via `ExecuteEditorCode`** to confirm the parameter name in the graph
matches the name your script writes. Or read the parameter immediately
after writing and assert the value persisted.

### P2 — Branch nodes don't save GPU work

A `Branch` node in the Material Editor doesn't conditionally skip work —
both branches execute and the result is selected. So a graph with `if
(distance < 0.5) { sample expensive texture } else { return black }`
samples the expensive texture *every pixel*.

Mitigation: use `Step` and `Lerp` to mathematically gate the result
(`output = lerp(black, expensive, step(0.5, distance))` — still samples
expensive, but is honest about it) — and if the cost matters, split the
material in two and switch which Material the Visual uses from
TypeScript.

### P3 — Custom materials cost more than built-ins on mid-range Android

A 30-node graph has measurable cost. Snap reviews on mid-range Android,
not high-end iPhone — desktop preview will not show the cost. Before
shipping a custom material, test on the worst device you have.

Rough rule: aim for < 25 nodes per material on a mid-range target;
< 15 nodes for a face material (which runs at face-tracked resolution
every frame).

### P4 — Material parameters set in onAwake() before the visual is enabled

If you set `mat.mainPass.x = value` in `onAwake()` but the Visual component
gets enabled later (e.g., after a load animation), the parameter may
be reset by the Visual's initial state. Set parameters **in OnEnableEvent
or in the first frame after enable**, not in onAwake.

### P5 — A material is shared by default between all SceneObjects using it

If two Visuals point at the same Material asset and you write
`visualA.mainMaterial.mainPass.tint = red`, both Visuals turn red.

For per-object parameter variation, clone the material per-instance:

```typescript
this.visual.mainMaterial = this.visual.mainMaterial.clone();
this.visual.mainMaterial.mainPass.tint = red;  // only affects this Visual
```

Be deliberate about whether you want shared or per-instance. The cost is
slightly more memory for clones; the benefit is independent state per
object.

### P6 — Visual Scripting can write material params but can't read graph internals

Visual Scripting's "Set Material Param" action can write a value into a
parameter, but it can't introspect the shader graph or its parameter list
— you hand-type the parameter name. Typo here is a P1 silent drop.

### P7 — Asset Library "preset materials" use opaque internal graphs

The materials shipped under presets (Color Correction, Gaussian Blur,
etc.) often hide their internals — you can use them and tweak exposed
parameters, but you can't refactor the graph. If you need a variant,
duplicate the material asset and edit the copy.

### P8 — CC / MCP cannot edit the Shader Graph node structure (empirically verified)

The Material Editor's graph is authored exclusively in the LS Shader
Graph panel. The Editor Scripting API exposes `ShaderGraphPass` as an
opaque asset (no `nodes`, no `graph`, no `connections` enumerable);
on-disk `.ss_graph` is binary; `Editor.Graph.convertGraphToYaml` /
`convertYamlToGraph` exist at runtime but are not in the public types
and their signature is undocumented. Detail: see
`lens-studio-api-gotchas.md` § "Shader Graph / VFX Graph / Script Graph
node structure is NOT editable via the public Editor API".

**What CC CAN do for graphs**: read/write Material parameter values,
add/remove material passes, render-state mutations (blendMode, twoSided,
depthWrite, etc.), create/delete Material assets. **What CC CANNOT do**:
add/remove/rename/reconnect graph nodes.

**Mitigation**: For Phase 3 custom-shader work, lock the graph
structure with the user once (they author in the UI; CC uses
`SetLensStudioSelection` to direct them). After that, CC drives
parameter values for iteration. Don't promise structural graph
modifications from CC.

---

## Performance budget (per material)

| Material type | Node count target | Hard cap | Notes |
|---|---|---|---|
| UI sprite material | < 10 | 15 | Runs on every UI element, every frame |
| Face overlay material | < 15 | 25 | Runs at face resolution, every frame |
| Full-screen post effect | < 25 | 40 | Runs at screen resolution, every frame |
| Object material (one-off) | < 30 | 50 | Runs per-object draw; cost amortized |
| Particle material | < 12 | 20 | Multiplied by particle count |

Texture samples are the most expensive node type. Each sample is one
texture lookup per pixel; budget 1-2 in UI sprites, 3-4 in face overlays,
5-6 in full-screen effects.

---

## Generalizable agent guidance

For Phase 1 (scaffolding): use built-in materials. Don't author custom
shaders during scaffolding — pick PBR/Unlit/Sprite, get scene + animation
working, defer shading until Phase 3.

For Phase 3 (polish): if a stylized look is in the brief and the
built-ins won't deliver, author one custom material per look-of-thing.
Lock the graph structure early; iterate on **parameter values via the
Inspector**, not on graph structure. Magnitude tuning is for Anna's
sliders; structural changes mean the agent re-enters the design loop.

When a graph crosses 30 nodes, pause and ask: "Is this one material, or
should this be a two-pass render-target chain (see composition-patterns)?"
The split is often cheaper and easier to reason about.

For tracker-driven materials (face liquify, body warp, hand-driven
distortion): see `references/face-effects-deep-dive.md`
— lock baseline via script, hand off feel-tuning to LS Inspector sliders.

---

## Cross-references

- `references/composition-patterns.md` § "Full Frame Effect", "Material
  driven by tracking data", "Multi-pass render target chain"
- `references/lens-studio-api-gotchas.md` § setProperty compound-type
  silent drop, FaceLiquify enum setProperty
- `references/editor-scripting-api.md` — bulk material parameter
  mutation via ExecuteEditorCode
- `references/visual-scripting-guide.md` § Pattern D — math-driven
  material parameter from a graph instead of TypeScript
