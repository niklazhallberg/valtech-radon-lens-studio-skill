# Performance Optimization Guide (LS 5.20+)

Concrete numeric budgets + optimization techniques + anti-patterns from Snap's official Performance and Optimization documentation. Designed as a fast-lookup cheat-sheet during Phase 2-4 (scripting → polish → DoD).

Compiled 2026-05-20 from Snap's published optimization docs:
- `/lens-studio/publishing/optimization/overview`
- `/lens-studio/publishing/optimization/performance-optimization-guide`
- `/lens-studio/publishing/optimization/3d-meshes`
- `/lens-studio/publishing/optimization/texture-optimization`

## Why this file is separate from `sponsored-lens-submission.md`

`sponsored-lens-submission.md` covers the **publish-gating** numbers (LAT < 650 ms, RAM ceiling, lens size cap) — what gets your lens rejected at Ads Manager.

This file covers the **deeper optimization mechanics** — how to get from "works on my desktop" to "ships under budget on mid-range Android". Anti-patterns, per-asset-type budgets, material/texture/RTT discipline, scripting rules. Load when a colleague is in Phase 3-4 and asking "how do I shave 50ms off LAT" or "why is my RAM at 180 MB".

## Note on Snap-doc inconsistency: RAM budget

Snap's two optimization pages publish different RAM numbers:
- **Performance Optimization Guide**: "150 MB RAM" maximum
- **Texture Optimization Guide**: "less than 120 MB of RAM" when loaded on device

Either interpretation is defensible (120 MB on-load vs 150 MB peak runtime), but the safe agent guidance is **target 120 MB and treat 150 MB as the hard ceiling**. Our internal Valtech budget (`SKILL.md`) is tighter still: 80 MB target, 100 MB hard limit.

## Contents

1. Numbers cheat-sheet (all budgets in one table)
2. Lens Performance Toolkit — the 5 dashboard metrics
3. Material optimization
4. Texture optimization
5. Render Target (RTT) discipline
6. Scripting performance
7. SnapML rules
8. VFX rules
9. 3D animation rules
10. Multi-person Face Effects render-order gotcha
11. Mesh vertex compression
12. Project structure conventions
13. Cross-references

---

## 1. Numbers cheat-sheet

The agent can cite these directly to colleagues — all are Snap-published.

### Submission-gating numbers (publish blockers)

| Metric | Limit | Sponsored target |
|---|---|---|
| **Lens Activation Time (LAT)** | < 650 ms benchmark device | < 500 ms (Valtech) |
| **Lens size** | 8 MB hard | < 4 MB (Snap-rec) |
| **RAM** | 150 MB (Performance Guide) / 120 MB (Texture Guide) | 120 MB safe target |
| **FPS** | > 15 minimum | ≥ 30 target |

### 3D model budgets

| Asset type | Triangle budget |
|---|---|
| **Static 3D** | < 100,000 triangles total |
| **Rigged / skinned mesh** | < 60,000 triangles |
| **Animation rig** | < 100 joints |

### Animation

- **Total duration**: < 10 seconds (matches Snap length)

### Texture max resolutions

| Texture type | Max size |
|---|---|
| **Standard 3D texture** | 2048 × 2048 |
| **Screen-occupying element** | 720 × 1280 |
| **Eye color** | 64 × 64 |
| **Lips** | 250 px longest side |
| **Lashes / eyeshadow** | 300 px longest side |
| **Blush / face paint** | 450 px longest side |
| **Lens icon** | 320 × 320 |

**Empty-space rule**: any texture with > 50% empty space → crop and reduce dimensions instead.

### Face effects

- **Liquify count**: ≤ 10 liquefies per render order (more = jitter on low-end devices)

### Audio

- **Format**: MP3 mono preferred at lower bitrate (per `audio-in-lenses.md`)

## 2. Lens Performance Toolkit — 5 dashboard metrics

On a paired device, click the **Gear icon** in LS Preview to reveal the metrics dashboard:

| Metric | What it measures |
|---|---|
| **LAT** | Lens Activation Time (download → first render) |
| **FPS** | Frames Per Second |
| **FPT** | Frame Processing Time (CPU ms per frame) — the composite cost metric |
| **RAM** | Active memory consumption |
| **SIZE** | Current Lens package size on device |

**Phase 4 DoD ritual**: agent should ensure all 5 metrics are captured for every Sponsored Lens before submission. LAT is the most-missed gate.

## 3. Material optimization

### Anti-patterns to avoid

- **Complex nodes**: noise, PBR, complex subgraphs — these compile into heavy shaders
- **Each unique shader compiles separately** → fewer material graphs = lower LAT
- **Order Independent Transparency (OIT)** disabled by default unless visually critical
- **Depth Test / Write** disabled for 2D materials (no depth interaction needed)
- **PBR / Uber** for simple visuals — prefer **Unlit** when possible

### Quick wins

- Reuse material across multiple objects (shader compiled once, used many times)
- Pre-bake what you can into a texture instead of computing in the shader
- Test on device: shader compile times are silent in desktop preview, visible on first lens activation

## 4. Texture optimization

### Compression choice — major impact

> *"Performance" compression saves 6× RAM for RGB textures, 4× for RGBA — over "Size" compression.*

**Always pick "Performance"** unless lens-size budget is the binding constraint and you've already optimised everything else.

### Resolution discipline

- Standard 3D textures: start at 2048×2048, reduce to 1024² or 512² based on model complexity and screen presence
- Single-color textures: reduce to 1px theoretically
- Different texture maps need NOT share resolutions — normal maps can be smaller than base color
- Always crop transparent or empty space before import

### Format choice

| Use | Format |
|---|---|
| Opaque texture | JPG (smaller) |
| Transparency required | PNG (alpha channel) |
| Animated / video texture | LS-native (compressed) |
| External tools | `tinypng.com` for quick wins, `Lens Studio` built-in compression |

### Normal maps + environment maps caveat

> *"Be careful with compressing normal maps and environment maps. In some cases auto compression tools might result in bad normals."*

Test these on device after compression — automated tools can produce visible artefacts.

### Mipmaps

- **Crucial for FPS** when textures are minified (rendered smaller than native resolution)
- **Disable mipmaps only if** the texture always maps 1:1 to screen pixels (e.g. full-screen UI overlay where source = display resolution)

### Anti-patterns

- Large swaths of identical color → wastes texture memory, reuse / tile instead
- Different objects each with their own near-identical texture → atlas / share

## 5. Render Target (RTT) discipline

### Rules

- **Minimize number of Render Targets** — each one increases LAT + RAM
- **Share one RTT between cameras** when possible
- **Order matters**: input RTTs must render BEFORE they're consumed
- **Enable Clear Depth** for first camera / RTT that contains 3D objects
- **Disable MSAA** for 2D objects (no visual benefit, costs perf)

### When to chain RTTs (vs share)

Chain when: the second pass legitimately needs the first's output as input (e.g. post-effect on a rendered scene).

Share when: multiple cameras render the same scene from different angles for compositing.

## 6. Scripting performance

### Anti-patterns

- **Per-frame update loops** for logic that doesn't need to run every frame → tie to events instead
- **Repeatedly retrieving values via API** (e.g. `getComponent` inside `onUpdate`) → cache once on `onAwake`, reuse
- **Storing large data (textures, meshes) in script variables repeatedly** → reference, don't copy

### Recommended pattern

```typescript
@component
export class MyController extends BaseScriptComponent {
  @input visual: MeshVisual;
  private cachedMaterial: Material;

  onAwake() {
    // Cache once
    this.cachedMaterial = this.visual.mainMaterial;
  }

  onUpdate(event: UpdateEvent) {
    // Use cached reference; never re-fetch
    this.cachedMaterial.mainPass.someParam = computeValue(event.getDeltaTime());
  }
}
```

## 7. SnapML rules

- **Max 1 ML component per lens** (recommended). Multiple ML components compound dramatically in load time + RAM.
- ML inference runs per frame for active ML components — keep models small and inference-light

(SnapML deep-dive deferred to its own research round.)

## 8. VFX rules

- **Reduce particle count** — fewer emitters, lower max particles per emitter
- **Prevent overlapping emitters** — they double-count GPU cost
- **Simplify VFX graphs** — fewer nodes, especially fewer math operations per particle
- **External Time per material** — see `lens-studio-api-gotchas.md` Part 2 → "GPU particle External Time"

## 9. 3D animation rules

### Avoid

- **Blend Shape animation** — high memory cost. Use sparingly.
- **Vertex animation** — costly across all metrics (CPU + GPU + RAM)

### Prefer

- **Tween Manager** for simple property animations (transform, color, alpha)
- **AnimationPlayer + AnimationTrack** for character / mesh animation (NOT deprecated AnimationMixer — see `deprecated-api-migration.md`)

## 10. Multi-person Face Effects render-order gotcha

When a lens supports 2+ faces (e.g. user + friend in selfie cam):

- **Render orders MUST match** between first- and second-person face effects (same position in the render-order chain on both faces)
- **Exception**: 3rd / 4th person should be **+1 higher render order** than Face Stretch on the previous-person face
- **Remove unnecessary effects** on non-primary faces (e.g. eye color hidden behind a mask)

Without these rules, multi-face lenses render visually inconsistent — first face looks correct, others look broken.

## 11. Mesh vertex compression

Snap's 3D Mesh Optimization page focuses on **vertex attribute compression**, not polygon reduction:

### Compression formats per attribute

| Attribute | Recommended format |
|---|---|
| **Position** | Float / Half Float (or rearrange to [-1, 1] range to fit smaller types) |
| **Normal** | SNorm (signed normalised) |
| **Tangent / Bitangent** | Can be disabled if no normal map is used |
| **Color** | 8-bit Byte UNorm (HDR colours: Half Float) |

### Draco compression

> *"Draco compression enables 10× smaller compression ratios compared to original files."*

Compression levels 0–10. Use Draco for any 3D model where lens-size budget is tight.

### What Snap does NOT specify (in this page)

- Per-asset-type triangle budgets (covered in Performance Guide — see numbers cheat-sheet above)
- File format priority (glTF / GLB / FBX) — see `3d-asset-import-doctrine.md` for our GLB-first doctrine
- LOD / bone-reduction / baking techniques — deferred

## 12. Project structure conventions

Snap explicitly calls out project-organisation anti-patterns:

### Don't

- Generic naming: `Group1`, `Object2`, `MyScript`
- Unorganised Resources window — flat list, mixed asset types
- Keeping unused objects in Resources

### Do

- Descriptive prefixes: `FE_` (Face Effects), `3D_`, `VFX_`, `UI_`, `Audio_`
- Directory-grouped Resources: subfolders per asset type
- Delete unused objects + assets before submission (counts toward lens size)

## 13. Cross-references

- `sponsored-lens-submission.md` — submission-gating numbers (LAT < 650 ms, lens size, brand-mark requirement)
- `lens-studio-api-gotchas.md` — Tween Manager + ScreenTransform + GPU particle External Time gotchas
- `3d-asset-import-doctrine.md` — GLB-first format priority, two-pass optimization flow
- `audio-in-lenses.md` — MP3-over-WAV for audio size budget
- `deprecated-api-migration.md` — AnimationMixer → AnimationPlayer migration
- `bitmoji-integration.md` — Bitmoji 3D performance cost notes
- `remote-apis-integration.md` — Remote API performance budget (3 calls max, 800 KB response)

## Phase 4 DoD checklist (use this file before submission)

When a colleague says "I'm ready to submit", agent walks through:

1. **LAT measured on device < 650 ms?** (Lens Performance Toolkit Gear icon)
2. **RAM < 120 MB on first load?**
3. **Lens size < 4 MB?** (or < 8 MB if non-Sponsored)
4. **FPS ≥ 30 on mid-range Android?**
5. **All textures use "Performance" compression?**
6. **All face mask textures within per-region max size?** (eye 64², lips 250px, etc.)
7. **Render Targets minimised + shared where possible?**
8. **At most 1 SnapML component?**
9. **No deprecated APIs (AnimationMixer, LensTurnOnEvent, etc.)?** See `deprecated-api-migration.md`
10. **All Asset Library suffixes respected (`__PLACE_IN_SCENE` etc.)?** See `asset-library-guide.md`

If any gate fails → optimise before resubmission.

## Adding new findings

When a Valtech project surfaces a performance behaviour not in this file:

1. **Pattern / anti-pattern** — one sentence
2. **Numeric impact** — what did you measure (LAT before/after, RAM saved, FPS gained)
3. **Source** — Snap docs URL or empirical record
4. **Confidence** — official-docs / multi-source / single-source / valtech-validated
