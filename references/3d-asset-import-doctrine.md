# 3D Asset Import Doctrine — GLB-first + Two-pass Optimization

Load this when the user mentions a 3D object, GLB/FBX/OBJ files, "lens size too big", custom models, or any AR accessory (hat, glasses, jewelry, prop). Also load proactively in Phase 0/1 when the brief mentions custom 3D content.

Snap officially supports **FBX, glTF/GLB, and OBJ** for 3D import. Snap has a dedicated official glTF import guide and glTF is the format the platform pipeline is built around. This doctrine reflects that preference order — without locking the skill to any specific upstream tool.

---

## A. Agent doctrine — when the user wants to add a 3D object

These are my (the agent's) decision rules, *not* a checklist I dump on the user.

- *I prefer GLB/glTF as the default format for custom 3D objects.* Snap has a dedicated import guide for glTF/GLB and the format is natively supported. FBX and OBJ are valid fallback formats, not first choice.
- *I check lens size risk early — as soon as 3D objects are mentioned in the brief.* Many 3D sources (especially image-to-3D services) produce rich geometry and large textures by default that can quickly blow up a Snap lens. I flag the risk before the user gets far into their pipeline.
- *I think in two passes when reasoning about size.* (i) Before import: mesh/format/textures from any 3D source, optional post-process. (ii) Inside Lens Studio: texture compression + Resource Inspector. When the size shoots up, I know immediately which pass needs fixing.
- *I treat textures as the likely main culprit.* Textures are often the biggest culprit in a 3D asset's size. I start diagnosing there, not with the mesh.
- *I ask briefly about the source when it matters for the next step.* Image-to-3D service, asset library, or DCC tool? Otherwise I don't assume any specific tool.
- *I use the skill's internal budget to flag risk.* If a single accessory significantly exceeds ~1 MB compressed, or the whole lens approaches 6 MB, I flag it. This is the *skill's* working budget; Snap's hard cap is 8 MB (see the Performance budget table in `SKILL.md` for the skill's default target).
- *I always start with library-first sourcing.* Before I suggest custom 3D generation, I check the Snapchat Asset Library, Lens Studio Templates, and already-imported prefabs. Snap-official assets are pre-optimized and skip the entire Pass 0–Pass 2 chain. When library/templates don't match the user's expectations — *then* I lift image-to-3D as a path forward and refer to `image-to-3d-generation.md`. Skipping the library check is the most common reason a lens unnecessarily lands in the 3D pipeline from the start.

---

## B. Format priority — GLB-first doctrine

| Format | Role | When |
|--------|------|-----|
| `.glb` / `.gltf` | **First choice** | Default for all custom 3D objects. Enable Draco compression if the source supports it. |
| `.fbx` | Fallback | When the source can't export GLB cleanly. Uncheck "Embed Media" if possible; deliver textures separately. |
| `.obj` | Fallback | Only for simple static props without PBR materials or animation. |

**Why this order:**
- **GLB** is binary, compact, and designed for web/AR delivery. It's the format Snap's import pipeline is optimized for.
- **FBX** is a DCC interchange format — good for swapping between modeling tools, less good for final delivery. Embedded textures aren't compressed automatically.
- **OBJ** is a legacy format without modern material support (no PBR, no animation).

**About Draco compression:** can give significant reduction in geometry data — typical wins vary with model complexity, often halving or more. Not a hard promise, but a valuable default when the source allows it.

---

## C. User playbook — how to import 3D in Lens Studio

Two clear paths in. Snap documents both in the official import guide.

### Asset Browser (most common — flexible)

1. In the Asset Browser panel: click `+` → `Import Asset`, or drag-and-drop your `.glb` file directly on the Asset Browser.
2. Result: the file becomes a **resource** in `Assets/`. It is *not* visible in the scene yet.
3. To place it in the scene: drag the prefab from Asset Browser → Scene Hierarchy.

**Why two steps:** it separates "the file exists in the project" (resource) from "the file is active in the scene" (instance). You can keep heavy assets sitting as resources without them counting toward the scene's render budget, as long as they aren't instantiated. Good for keeping the scene clean while you experiment with different variants.

### Scene Hierarchy (fast — direct instance)

1. Drag the GLB file *directly* from Finder/Explorer onto the Scene Hierarchy panel.
2. Result: the file is imported as a resource *and* instantiated in the scene in one step.

**Why this:** the shortest path to "object in the scene". Use this when you know you want the object in the scene immediately and don't need multiple variants.

---

## D. Two-pass optimization (tool-agnostic)

### Pass 0 — Generating the .glb (if the user doesn't already have the file)

If the user doesn't have a .glb yet but wants to *create* a custom model from an image/idea — e.g. because Snapchat Asset Library didn't have anything matching, or because the brand requires something unique — start in `image-to-3d-generation.md`. That file covers image requirements, prompt → image, service selection (Meshy/Tripo/Hunyuan3D/Rodin), and a quality checklist before the .glb file is taken forward to Pass 1b.

Skip Pass 0 if the user already has a .glb (from a DCC tool, asset library, or other source) — then start directly in Pass 1 below.

### Pass 1 — Before import (in the 3D source, regardless of tool)

**Goal:** produce as small and well-formed an asset as possible *before* it reaches Lens Studio.

- **Format:** export/download as `.glb` when possible. Enable Draco compression if the source supports it.
- **Mesh:** keep the polygon count as low as visual quality allows. For a small accessory (hat, glasses, smaller prop), a reasonable **target zone is 1k–3k triangles** — a guideline for accessories, not a universal rule. Larger or more detailed objects can take more, but make an active choice based on how large the object is in the frame.
- **Textures:** target zone **1024×1024**, or **512×512** for smaller objects. JPG if alpha isn't needed, PNG only when transparency is actually required. Merge into a PBR atlas if the source allows it, instead of several separate textures.

**Pipeline context:** Snap supports many 3D sources. DCC tools (Blender, Maya, Cinema 4D), the Snapchat Asset Library, or image-to-3D services (Meshy, Tripo, Luma Genie, Rodin, Hunyuan3D via fal.ai, etc.) are all legitimate starting points. Many image-to-3D services have limited export parameters — use what's available and rely on Pass 1b if needed.

### Pass 1b — Optional post-process on the .glb file

If Pass 1 wasn't enough on its own (common with image-to-3D output, which tends toward rich geometry and large textures), run the .glb file through a post-process tool before Lens Studio import:

- **`optimizeglb.com/dashboard`** (https://optimizeglb.com/dashboard) — **recommended first choice for designers.** Drag-and-drop in the browser, runs mesh and texture compression on your .glb and gives you an optimized file back. Empirically verified in Valtech projects: preserves visual quality cleanly without visible artifacts on image-to-3D output.
- **`gltfpack`** (CLI, for advanced/batch): `npm install -g gltfpack`, then `gltfpack -i in.glb -o out.glb -cc -tc`. The flags: `-cc` = mesh compression (meshopt), `-tc` = texture compression.
- **`gltf-pipeline`** (CLI, Cesium): an alternative with similar capabilities if gltfpack is missing something specific.

**This step is a recommendation, not a universal requirement** — but often practical when the 3D source didn't give full control over output size.

**Tools to avoid for now:** `gltf.report` (https://gltf.report) has been observed to introduce visible artifacts (tearing/distortion in mesh surfaces) in optimize output even when the source .glb is clean and even with lossless settings. The artifacts appear in the web tool — before the file even reaches Lens Studio — and then carry over. Use `optimizeglb.com` instead until this is verified fixed.

### Pass 2 — Inside Lens Studio

1. Import the optimized .glb file (via Asset Browser or Scene Hierarchy, see C above).
2. Select each texture in Resources → Inspector → set Texture Compression to `BC3` (with alpha) or `BC1` (without). **Never `RGBA8 Uncompressed`** — that's the default trap that gives 4–8× too-large textures.
3. Open **Resource Inspector** / Lens Stats **early in the flow**, not at publish time. Sort by "Compressed Size" and confirm the individual 3D asset stays within the skill's accessory budget (see E below).

**Why Resource Inspector early:** at publish time, it's too late to fix anything cheaply. Early in the flow you can iterate per asset — try a compression setting, read off the result, adjust. That turns optimization from "crisis action when a red number appears" into "continuous design discipline".

---

## E. The skill's internal working budget for 3D

This is **the skill's budget for keeping margin against Snap's 8 MB ceiling**, not limits set by Snap.

| Component | Skill's target value |
|-----------|-------------------|
| 3D model (accessory) incl. textures | ~1 MB compressed |
| Face Mesh / Head occluder | ~0.2 MB |
| HDR / environment | ~1 MB (or skip, use Ambient Light) |
| Scripts + UI | ~0.3 MB |
| Scene/material/graphs | ~0.5 MB |
| Headroom for fonts, audio, etc. | the rest |

**Total lens size — refer to `SKILL.md`'s Performance budget table:**
- **Target:** ≤ 4 MB (the skill's default; for simple lenses)
- **Acceptable margin:** up to 6 MB for 3D-heavy lenses where the extra megabytes are well-invested in visual quality
- **Hard limit:** 8 MB (Snap's ceiling — always)

When the budget breaks → back to Pass 1, not Pass 2. You can't compress down quality that was never generated; you can always scale down something that came out too big.

---

## F. What the skill should help the user understand (mentor goals)

Before publish, the user should be able to answer four questions on their own. This doctrine exists to support that.

### 1. Which format is best for my 3D object?

GLB/glTF as the first choice — preferably Draco-compressed. FBX and OBJ are fallback formats that Snap supports, but glTF is the format Lens Studio's pipeline is built around.

**Why it matters:** the right format removes an entire class of size problems from the start. Starting with the wrong format makes everything downstream harder.

### 2. How do I import the file in Lens Studio?

Two paths:
- **Asset Browser import** (`+ → Import Asset` or drag-and-drop on the panel): the file becomes a **resource** first — you have to drag the prefab to Scene Hierarchy for it to become visible in the scene.
- **Scene Hierarchy import** (drag-and-drop directly on the panel): the file is imported as a resource *and* instantiated in the scene in one step.

**Why the difference matters:** the Asset Browser path gives you the flexibility to keep resources around that don't count toward the scene budget. The Scene Hierarchy path is fastest when you know what you want.

### 3. What affects lens size?

- **Textures** — often the biggest culprit (resolution, format, compression)
- **Polygon count** — the mesh's complexity
- **File format** — GLB compresses better than FBX
- **Lens Studio's compression settings per texture** — `RGBA8 Uncompressed` vs `BC1/BC3` can give a 4–8× difference

**Why this is worth understanding:** when you know textures dominate, you learn to check them first. That saves time every time the size shoots up.

### 4. Which optimization steps should be taken before publish?

1. **Pass 1** — optimize mesh, textures, and format in the source, preferably GLB
2. **Pass 1b** — optional post-process (`optimizeglb.com` recommended for designers) if the output is too big
3. **Pass 2** — in Lens Studio: set BC1/BC3 on all textures + open Resource Inspector **early**, not at publish time
4. **Publish check** — the Publishing dialog should show a green Lens Size under 8 MB; the aim is ≤ 4 MB target, 6 MB max for a 3D-heavy lens

**Why the order matters:** Pass 1 is the cheapest and most effective. Pass 2 complements but can't fix fundamental problems in the source. Skipping Pass 1 is the most common trap.

---

## G. When the doctrine does NOT apply

- **Snapchat Asset Library objects** imported as finished prefabs — Snap has already optimized them. You don't need to go through the doctrine for these, just verify in Resource Inspector that they aren't unexpectedly out of line.
- **Pre-bundled Templates** from Lens Studio — same thing.
- **Snap-official SnapML models** — count separately (the SnapML budget of 10 MB is separate from the Lens Size budget of 8 MB).

For all other custom 3D content, the GLB-first + two-pass flow applies.
