# VFX Graph Guide (LS 5.20+)

The modern node-based particle / visual-effects system in Lens Studio 5.x. Covers `Component.VFXComponent`, the VFX Graph Editor, script-driven runtime control, spawn modes, world-vs-local simulation, and the standard helper scripts.

Compiled 2026-05-20 from Snap's VFX template documentation (URL is 4.55.1, system is current in LS 5.x — `[STALE]` URL only).

## Critical distinction: VFX Graph vs GPU Particles (vs Legacy Particles)

LS 5.x has **three** particle / VFX systems with overlapping but distinct purposes. Briefs that say "I want particles" need triage to the right system:

| System | What it is | When to use | Where in skill |
|---|---|---|---|
| **VFX Graph** (`Component.VFXComponent`) | Modern node-based authoring. Build effects from scratch with full control over spawn, update, render. Script-driven runtime parameters. | Custom branded effects, novel particle behaviour, mesh-driven spawn, segmentation-aware effects, complex compositions | **This file** |
| **GPU Particles Effects Pack** | Pre-built shader-driven presets (rain, snow, sparkles, blizzard, bouquet). Configured via Inspector. | Brief calls for a standard ambience preset and the existing pack covers it | `lens-recipe-catalog.md` B-4 |
| **Legacy Particle System** | Pre-5.x particle component. | **NEVER** — deprecated in favour of VFX Graph | n/a — don't propose |

**Agent's coaching rule**: if a brief specifies a standard preset (snow, rain, sparkles), check the GPU Particles Effects Pack first (recipe B-4) — it's faster to install. If the brief needs custom behaviour (brand-colored embers reacting to user tap, particles spawning from face mesh, segmentation-aware effects), use VFX Graph from this file.

## Contents

1. VFXComponent — the runtime object
2. VFX Graph Editor — the authoring tool
3. Script API — runtime parameter control
4. Spawn modes — Continuous, Burst, custom kill logic
5. World Space vs Local Space simulation
6. Standard example presets (16 variants in template)
7. Customization knobs
8. Helper scripts (SendDataToVFX, DuplicateVFXExample, EncodeMeshPositions, Behavior)
9. Performance considerations
10. Common gotchas
11. Composing VFX Graph with recipes
12. Cross-references

---

## 1. VFXComponent — the runtime object

The component placed on a SceneObject that runs a VFX Graph. Add via `+ → VFXComponent` and assign a VFX asset.

VFX assets live in the Resources panel and are authored in the VFX Graph Editor (separate panel from the main scene editor).

## 2. VFX Graph Editor — the authoring tool

A node-based editor where you build effects from:
- **Spawn containers** — when and how particles are born
- **Update containers** — how particles change each frame (velocity, color, size)
- **Output containers** — how particles render (blend mode, texture)

**Parameter nodes** (shown green in the editor) become Inspector-editable values on the VFX asset. They're how you expose "knobs" the colleague (or script) can tune without re-authoring the graph.

Examples of common Parameter node names you'll see in templates: `Ground Height`, `burstDuration`, `worldPosition`, `imageScale`.

## 3. Script API — runtime parameter control

The universal pattern for driving VFX from script:

```typescript
script.vfx.asset.properties['parameterName'] = value;
```

Example:
```typescript
script.vfx.asset.properties['burstDuration'] = script.duration + getTime();
script.vfx.asset.properties['worldPosition'] = new vec3(0, 1, 0);
```

### CRITICAL gotcha: silent type-mismatch

`properties[...]` is typed loosely. Writing a value of the wrong type (e.g. a number to a vec3 parameter, or a vec4 to a color parameter expecting RGB) produces a **silent warning** — the value is ignored, no error is thrown, and the visual effect doesn't change. Easy to miss; common cause of "my script doesn't update the VFX".

**Mitigation**: after every property write, do a quick visual verify in Preview. For automated workflows, log the property read-back after a write to confirm the value landed.

### Cloning a VFX asset at runtime

```typescript
const clonedVfx = script.vfx.asset.clone();
// Use for spawning independent instances dynamically
```

See `DuplicateVFXExample` helper script (below).

## 4. Spawn modes — Continuous, Burst, custom kill logic

Set on the Spawn container in the VFX Graph:

| Mode | Behaviour |
|---|---|
| **Continuous** | Steady stream of particles over time |
| **Burst** | Spawn N particles in one tick, then stop |
| **Custom (time-based kill)** | Custom logic in the spawn container; useful for "spawn for X seconds then stop" |

For **Interactive Spawn** (tap-driven burst), use a `Behavior` script that writes to a `burstDuration` parameter on tap event.

## 5. World Space vs Local Space simulation

Critical setting on Spawn and Update containers:

| Space | Behaviour | Use for |
|---|---|---|
| **Local Space** | Effect is simulated relative to the SceneObject holding the VFXComponent | Face-anchored effects (move with head), hand-attached, object-attached |
| **World Space** | Effect is simulated independently of the parent's transform | Ambient world particles, snow falling regardless of where camera moves |

**Common pitfall**: face-bound effects in World Space drift away when the user moves their head. Switch to Local Space for any binding to face / head / hand / body tracker.

## 6. Standard example presets (16 variants in the template)

The official VFX template ships 16 named example variants showing common patterns. Use them as starting points for custom effects:

| Preset | What it teaches |
|---|---|
| **Texture Emitter** | Texture-based particle output |
| **Shapes Emitter with Size Fade** | Geometric shapes (triangles → circles) with size animation |
| **Directional Emitter** | Force-driven particles |
| **Directional Emitter with Noise by Age** | Noise deformation over particle lifetime |
| **Directional Emitter with Noise by Age and Color** | Fire effect with color ramps (no "fire preset" ships standalone; this is the recipe) |
| **Spawn Examples — Continuous** | Steady spawn over time |
| **Spawn Examples — Burst** | Burst spawn pattern |
| **Interactive Spawn Example — TAP** | Tap-triggered burst |
| **Simple Flipbook** | Animated sprite sheets on particles |
| **Dynamic Flipbook** | Texture-switching on collision |
| **Rotate Around Head** | Head-tracked torus emission (face-bound) |
| **Image Spawn** | Screen-space texture sampling for spawn positions |
| **Segmentation Spawn** | Spawn particles from body/background segmentation mask |
| **Hand Tracking Example** | Hand-following particles |
| **Spawn On Mesh** (Red Panda + Face Mesh variants) | Particles spawn from arbitrary mesh surface |
| **Complex Example** | Combined techniques in one effect |

**No standalone "smoke" / "fire" / "magic" preset** — these are RECIPES built from combinations of the above primitives. Composing them is the agent's job.

## 7. Customization knobs (per-particle behaviour)

Common Parameter nodes exposed in templates:

| Knob | Behaviour |
|---|---|
| **Spawn mode** | Continuous / Burst / custom |
| **Blend mode** | Additive, Multiply, etc. (set in Output container) |
| **Particle age (0 → 1)** | Drive color via `Set Color (Ramp Texture by Age)` |
| **Size / scale** | Per-particle via noise or attributes |
| **Lifetime** | Implicit in particle age (0 = born, 1 = dying) |
| **Color** | Texture sampling, ramps, or direct RGBA |
| **Force / velocity** | Directional, noise-based, mesh-derived |
| **Shape sides** | 3+ via `Particle Random` node (e.g. 3 = triangle) |

## 8. Helper scripts

Bundled with the VFX template, reusable for any VFX-driving lens:

| Script | Purpose |
|---|---|
| **`SendDataToVFX`** | Event-driven parameter passing — bridges Behavior events (tap, update, hand tracking detection) to `script.vfx.asset.properties[...]` writes |
| **`DuplicateVFXExample`** | VFX cloning at runtime via `script.vfx.asset.clone()` — spawn independent instances dynamically |
| **`EncodeMeshPositions`** | Encodes mesh vertex positions into a data texture, so VFX can spawn from arbitrary mesh surfaces |
| **`Behavior`** | Standard LS Behavior script — wire VFX enable/disable to events |

**Use case mapping**:
- "Particles spawn from the user's tap location" → `SendDataToVFX` listening to tap event, writing `worldPosition` parameter
- "Multiple independent particle bursts per tap" → `DuplicateVFXExample` clones the VFX asset per burst
- "Particles spawn from the surface of an animated 3D model" → `EncodeMeshPositions` encodes vertex data, VFX samples it for spawn positions

## 9. Performance considerations

Direct from `performance-optimization-guide.md`:
- **Reduce particle count** — fewer emitters, lower max particles per emitter
- **Prevent overlapping emitters** — they double-count GPU cost
- **Simplify VFX graphs** — fewer nodes, especially fewer math operations per particle

VFX-specific:
- **Filtering mode "Nearest"** for mesh data textures (see Gotchas) — bilinear blending costs perf AND corrupts data
- **Cap particle lifetime** — particles past visible range still cost CPU/GPU
- **Use Texture Atlas** for flipbook effects instead of multiple individual textures

## 10. Common gotchas

### Mesh data textures MUST use "Nearest" filter, not blended

When encoding mesh data (positions, normals, etc.) into textures for VFX consumption, set the texture filter mode to **Nearest**. Bilinear / trilinear blending will silently corrupt the encoded data — particles spawn in wrong positions, normals point wrong, etc. No error.

### 16-bit position encoding requires `ObjectBoundsMin` / `ObjectBoundsMax` uniforms to match

If you encode mesh positions in 16-bit precision, the decode in the VFX Graph needs `ObjectBoundsMin` and `ObjectBoundsMax` uniforms set to the EXACT values used during encoding. Mismatch → particles spawn at wrong scale or position.

### UV coverage matters for mesh-driven spawn

Mesh data textures sample from UV0. If the mesh has gaps in UV coverage (empty pixels in the data texture), particles spawning from those pixels read invalid data. Use the `IsValid` output in the VFX Graph to skip invalid spawn positions.

### Age ratio normalisation — born = 0, dying = 1

Particle age is normalised to a 0→1 range regardless of actual lifetime in seconds. Scale color / size ramps accordingly. A common mistake is using raw time-in-seconds when the VFX Graph expects 0→1.

### Simulation space mismatch breaks face binding

Face-bound effects (e.g. "Rotate Around Head") **MUST** use Local Space simulation. World Space causes the effect to drift away as the user moves their head — looks like a tracking bug, is actually a space-mode bug.

### Spawn vs Update container — forces behave differently

- **Spawn container**: forces are initial impulse (set once at particle birth)
- **Update container**: forces are continuous (applied every frame)

Easy to put a force in the wrong container and get the opposite behaviour from what was intended.

### Flipbook indexing depends on collision detection

`Dynamic Flipbook` switches the displayed texture frame based on collision events. Position threshold mismatches between expected collision distance and actual particle distance cause visual pops (the flipbook frame jumps suddenly instead of smoothly).

### Silent type-mismatch on `script.vfx.asset.properties[...]` writes

(Repeated from Section 3 because it's the most common cause of "my script doesn't update the VFX.) Writing wrong-type values silently fails. Verify visually in Preview after every write.

## 11. Composing VFX Graph with recipes

VFX Graph fills gaps that the canned recipes can't cover. Example compositions:

| Novel brief | Composition |
|---|---|
| **"Brand-colored embers that spawn from the user's hands as they wave"** | `face-effects-deep-dive.md` Hand Tracking + VFX Graph custom Directional Emitter with brand color ramp + Hand Tracking helper script feeding `worldPosition` |
| **"Particles spawn from the user's face mesh edges when they smile"** | VFX Graph `Spawn On Mesh` (Face Mesh variant) + `EncodeMeshPositions` + A-5 Face Expressions Smile trigger |
| **"Branded confetti burst when score increases"** | VFX Graph Burst spawn + `SendDataToVFX` listening to score-event Behavior + brand confetti textures via Flipbook |
| **"Particles only appear behind the user (segmentation-aware)"** | VFX Graph `Segmentation Spawn` + `Portrait Background` segmentation + brand color ramp |
| **"Multiple independent magic bursts on tap, each at a different location"** | VFX Graph Burst spawn + `DuplicateVFXExample` for per-tap cloning + `SendDataToVFX` for tap position |
| **"Branded smoke trail from a moving 3D object"** | B-2 (Animated Object) + VFX Graph Continuous spawn in World Space + position-tracking script writing `worldPosition` per frame |

## 12. Cross-references

- `lens-recipe-catalog.md` B-4 (GPU Particles Effects Pack — the simpler-but-less-flexible alternative)
- `lens-studio-api-gotchas.md` Part 2 → "GPU particle External Time must be checked per-material" (separate gotcha for GPU Particles, not VFX Graph)
- `performance-optimization-guide.md` → VFX rules (reduce particle count, prevent overlapping emitters, simplify graphs)
- `face-effects-deep-dive.md` → Face Mesh, Face Landmarks, Hand Tracking as VFX spawn sources
- `audio-in-lenses.md` → Beat Sync can drive VFX parameter writes for music-reactive particle effects
- `asset-library-guide.md` → VFX template install path (Asset Library → Effects category)
- `deprecated-api-migration.md` → Legacy Particle System is deprecated; never propose it

## Adding new findings

When a Valtech project surfaces a VFX Graph behaviour not in this file:

1. **Pattern / fact** — one sentence
2. **Graph context** — which container (Spawn / Update / Output), which Parameter node
3. **Source** — Snap docs URL or empirical record
4. **Confidence** — official-docs / multi-source / single-source / valtech-validated
