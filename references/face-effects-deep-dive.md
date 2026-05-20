# Face Effects Deep Dive — Building Blocks (LS 5.20+)

Building-block components and APIs behind Face effects in Lens Studio 5.x. Where `lens-recipe-catalog.md` A-1 through A-7 covers **whole recipes** ("I want a Face Retouch lens"), this file covers the **underlying components** the recipes are built from — so the agent can compose novel face effects beyond the named recipes.

Compiled 2026-05-20 from Snap's official Face Effects documentation.

## Why this file exists

When a colleague's brief doesn't match a named recipe — "I want a brand logo that anchors to the user's right eyebrow tip" — the recipe catalog can't help directly. But knowing that:
- **Face Landmarks** = 93 tracked points (one of which is the right eyebrow tip)
- **Head Binding** = the component that exposes them via `getLandmark(landmarkId)`
- **screenPointToParentPoint()** = converts landmark screen position to parent coordinates

…lets the agent compose the answer in 2 minutes instead of researching.

This file is loaded when a brief calls for **face-anchored content positioning at granular level**, **multi-face support**, **face occlusion behind hair / glasses**, **face swap**, **face anonymisation**, or any "I want X attached to / driven by the face" pattern.

## Contents

1. Face Mesh — the foundational geometry
2. Head Mesh — full 3D skull geometry
3. Face Landmarks — 93 tracked points
4. Head Binding — the component that exposes landmarks + face attachment
5. Eye Tracking — gaze position + rotation
6. Face Swap — full-face replacement
7. Face Occlusion + Features Segmentation
8. Working with Multiple Faces (max 2)
9. Faceless ML — face / nose hiding (anonymisation)
10. Composing with recipes
11. Cross-references

---

## 1. Face Mesh — the foundational geometry

### What it is

A 3D mesh that mimics the user's facial expression in real time. The foundation underneath nearly all face effects (Face Paint, Face Inset, custom mesh-based effects, etc.).

### Install

- **Via Scene Hierarchy**: `+ → Face Mesh` (auto-binds to user's head)
- **Via Asset Browser**: `+ → Face Mesh`, then assign to a `Render Mesh Visual` component's `Mesh` field
- **For skull-extended version**: see Head Mesh below

### UV coordinate system

- **UV0** — standard face mapping
- **UV1** — required for skull or ear geometry (Head Mesh)

To apply UV1:
- Uber PBR material → set texture UV coordinate in material settings
- Graph material → modify `Surface UV Coord` node
- Texture parameter → change `UV Coords Mode`

Snap provides downloadable UV reference images + OBJ files for texturing in external DCC tools.

### Multi-face

Set `Face Index` field: first detected face = `0`, second = `1`.

### Common pitfalls

- Forgetting UV1 when using Skull / Ear geometry → texture maps to wrong area
- External meshes must match built-in Face Mesh UV maps for correct alignment
- Not downloading correct UV reference before painting in Photoshop / Substance

### Use cases (composes with)

- Face Paint (A-7 recipe) — Face Mesh + opacity-mask material
- Face Inset (A-4 distort recipe) — Face Mesh + Inset component
- Custom mesh morphing via External Face Mesh
- Brand textures wrapped to the face

---

## 2. Head Mesh — full skull geometry

### What it is vs Face Mesh

**Head Mesh = Face Mesh with the `Skull` property enabled.** Adds full 3D skull geometry beyond just the face — back of head, ears, top of skull.

### When to use Head Mesh vs Face Mesh

| Use Face Mesh when | Use Head Mesh when |
|---|---|
| Effect is front-facing only | Effect wraps around the head |
| 2D textures on face surface | Hat / hood / wig sits on top of skull |
| Standard makeup / face paint | Hair painted on top of head, ear accessories |
| Performance is critical | Realistic head-shape-aware effects |

### Install

- Scene Hierarchy → add `Head Mesh` directly, OR
- Inspector → select Face Mesh resource → enable `Skull` checkbox

### UV layouts (critical)

- **UV0** — standard face mapping
- **UV1** — required for skull + ear geometry

> *"Since the two options use two different UV layouts, it is important to set a corresponding mapping for the Face Mesh."*

### Template patterns

Snap provides three template approaches:

1. **Head Decal** — Custom Material Editor effects across full head surface
2. **Fit to Head** — rigged 3D models auto-positioned via `FitJointsToHeadController` script + Pin To Mesh component (example: 36-joint visor)
3. **Move on Head** — non-rigged 3D objects dynamically scaled/rotated using `FitObjectToHeadController` (uses 4 reference points: Left, Right, Front, Back)

### Script API

Two primary controllers (from templates):
- `FitJointsToHeadController` — auto-adds Pin To Mesh components to skeleton joints
- `FitObjectToHeadController` — calculates centroid + normal from four pinned reference points

Both leverage Pin To Mesh system (added at runtime, not visible in Inspector).

### Materials

Standard PBR or Unlit. Use skull-compatible UV mapping (UV1) when texturing the skull surface.

### Use cases

- Hats, hoods, helmets that fit the user's head shape
- Hair painted on top of head (vs Hair Color which uses segmentation)
- Branded crown / halo / decoration sitting realistically on the head
- Full-head paint / war paint patterns

---

## 3. Face Landmarks — 93 tracked points

### What they are

**93 numbered points** (indices 0–92) tracked with the user's face in screen space. Cover:
- Eye corners + regions
- Nose tip + bridge
- Mouth corners + contours
- Eyebrows
- Jawline
- Face outline

Snap provides a visual map showing all 93 points. Indices are numeric only — no enumerated names like `LEFT_EYE_INNER_CORNER`.

### How to access (script)

```typescript
//@input Component.Head headBinding
const landmarkPos: vec3 = script.headBinding.getLandmark(landmarkId);
```

Returns `vec3` position in **screen space**. Call during `OnStartEvent` after head initialization. (Note: legacy docs may say `TurnOnEvent` — that's deprecated, use `OnStartEvent` per `deprecated-api-migration.md`.)

### Anchoring objects to landmarks

```typescript
const parentPos = screenImage.screenPointToParentPoint(landmarkPos);
screenImage.anchors.setCenter(parentPos);
```

`screenPointToParentPoint()` converts the landmark's screen position to parent-coordinate space so a Screen Image can anchor to it.

### Detection check

Always guard landmark access with a face-detection check:

```typescript
if (script.headBinding.getFacesCount() < 1) {
  // no face → don't read landmark
  return;
}
```

### Common pitfalls

- Calling `getLandmark()` before face detection → undefined behaviour
- Landmark is in screen space — for 3D positioning use Head Binding directly
- Indices are not human-readable — map them in code with comments (e.g. `const LEFT_EYE_INNER = 36;`)

### Use cases

- Face Stickers placed at specific facial features (eyebrow tip, mouth corner, chin)
- Brand accessory placement at a precise feature (e.g. logo at jaw line)
- Distance-based interactions between two landmarks (e.g. mouth-open detection by lip-corner distance — though Face Expressions does this better)
- Expression-triggered effects based on landmark distance / position

---

## 4. Head Binding — the bridge component

### What it is

`Head Binding` is the LS component that exposes:
- Face landmarks (via `getLandmark()`)
- Face count (via `getFacesCount()`)
- Eye attachment (via Left / Right Eyeball options — see Eye Tracking)
- Per-face Face Index targeting

It's the connector between the abstract face-tracking ML and your scripts / scene-positioned objects.

### Install

Scene Hierarchy → `+ → Head Binding`

### Configuration

- `Face Index` (0, 1) — which detected face to bind to
- Eye attachment toggles (Left Eye / Right Eye) — for Eye Tracking patterns

### Use cases

Head Binding is required for almost every landmark / eye / multi-face pattern. Treat it as "the API entry point for face data".

---

## 5. Eye Tracking — gaze position + rotation

### What it is

> *"The Eye Tracking effect allows you to track the position and rotation of the user's eyes."*

Important: **"Only position is supported, rotation is currently not supported" in certain contexts**, though rotation IS used for eyeball attachment via Head Binding.

### Install + setup

- Use `Head Binding` component with `Left Eyeball` or `Right Eyeball` options selected
- Asset Library → `Eyeballs` prefab can be imported, positioning under main camera

### Attaching objects to eyes

Attach objects as children of `Left Eye` or `Right Eye` objects in the Scene Hierarchy. They inherit eye position/rotation automatically.

### Script API — copying rotation only

Head Binding modifies BOTH rotation AND position by default. To isolate rotation (e.g. for an eyeball reflection that follows gaze direction without moving), use the `CopyRotation.js` pattern:

```typescript
const sourceRotation = sourceTransform.getWorldRotation();
targetTransform.setWorldRotation(sourceRotation);
```

### Use cases

- Reflective sclera, cosmetic eye effects
- Eyeball rotation for character animations (Bitmoji-style)
- Gaze-driven interactions via rotation-copying patterns

### Common pitfalls

- Head Binding modifies position AND rotation — isolate manually if you want only one
- Front camera only (implied by Snapchat / Spectacles context)
- No documented APIs for pupil position, eye-open / closed state, or direct gaze direction vector — use Head Binding + rotation pattern

---

## 6. Face Swap — full-face replacement

### What it is

Transfers a face from one source onto the target's position + expressions. Source can be live camera (a friend's face in the same frame) or a texture (pre-set image, AI-generated face, branded character).

### Install + placement

- Asset Library → Custom Components → `Face Swap` → Install
- Place under an Orthographic Camera, with a Screen Transform
- Render layer must match the camera (default: green)

### Source face options

| Source | Use case |
|---|---|
| **Live Camera** (Device Camera Texture) | Friend-swap (two faces in frame) |
| **Texture** | Static / animated source image |

Animated source impacts real-time performance significantly.

### Script API

```typescript
// Trigger the swap
faceSwap.start(): Promise<Texture>;
// Can be called multiple times (e.g. retry button)

// Read-only state
faceSwap.sourceFacePresent: boolean;
faceSwap.targetFacePresent: boolean;

// Events
faceSwap.onSwapStarted;
faceSwap.onResultReady;
faceSwap.onError;
faceSwap.onSourceFacePresent;
faceSwap.onTargetFacePresent;
```

### Performance gotchas

- **Real-Time Mode** *"may heavily impact performance on older devices"* — flag at Phase 0 for Sponsored briefs targeting mid-range Android
- **Animated Source mode** has additional perf impact
- **Render order critical** — wrong order causes one-frame lag
- **Override Tracking Scope** when using rendered textures to avoid "jello" effect

### IP / privacy / consent

Snap's docs do NOT explicitly address consent / safety / moderation for face-swap content. **For Sponsored Lenses, this is a high-risk feature** — using a celebrity's face, a competitor's brand mascot, or any third-party face without explicit license is an IP violation. See `sponsored-lens-submission.md` → "Third-party IP requires explicit license".

**Agent's coaching rule**: if a brief proposes Face Swap with anything other than (a) user-controlled source (selfie), (b) brand-owned character, or (c) Snap-provided template face, flag the IP risk at Phase 0.

### Sponsored Lens fit

Not explicitly documented. Assume it works mechanically, but treat IP risk as the binding constraint. ChatGPT API + Face Swap together would be especially fraught (auto-generated faces of identifiable people).

---

## 7. Face Occlusion + Features Segmentation

### Two distinct components

| Component | Output | Use for |
|---|---|---|
| **Face Occlusion** | Single binary mask (face / not-face) | Hide AR content behind anything in front of face (e.g. hands) |
| **Facial Features Segmentation** | 7 separate masks (beard, eyebrows, ears, eyes, face, lips, background) | Per-feature targeting (effect only on lips, only behind hair, etc.) |

Both installed via Asset Library → Install button.

### Setup pattern (both)

1. **Orthographic Camera** rendering segmentation output to a Render Target
2. **Perspective Camera** for face effects, masked by the render target
3. Custom layer assignment to isolate segmentation rendering
4. Render Target with black background (rgba: 0,0,0,1)
5. Camera `Mask Texture` field points to the segmentation Render Target

### Use cases

- 3D glasses occluded by face when user tilts head → glasses stay realistic
- Branded prop integrated behind hair (hair occludes the prop in front of it)
- Brand logo "tattooed" on cheek that disappears behind a hand wave
- Per-feature makeup effects (Features Segmentation → lips only)

### Performance

Snap docs don't specify multi-face support limitations for these or detailed perf overhead. Add multiple camera objects if non-masked AR effects need to render alongside occluded content.

### Gotchas

- Orthographic + Perspective camera setup is non-obvious — common cause of "occlusion does nothing" reports
- Render Target dimensions affect mask quality — too small = pixelated edges
- Black-background requirement is strict — any other clear color breaks the mask

---

## 8. Working with Multiple Faces

### Hard limit

**LS supports up to 2 faces simultaneously.** Not 3, not 4 — 2. Brief planning must respect this.

### Face Index pattern

Components that support multi-face expose a `Face Index` field:
- First detected face = `0`
- Second detected face = `1`

### Per-face component duplication

To apply an effect to BOTH faces, you must **duplicate the component** and increment `Face Index`:

> *"Right click the object containing your Face Substitution component and select `Duplicate`. You can then increment the `Face Index` field."*

Supported across:
- Face Mask
- Face Retouch / Face Stretch / Eye Color
- Head Binding
- Face Inset (requires Face Index updates in BOTH Head Binding AND child components — easy to miss)
- Face Liquify (combine Head Binding + Liquify with matching Face Index)

### Render-order rule (from `performance-optimization-guide.md`)

Render orders MUST match between first- and second-person face effects (same position in render-order chain on both faces). Exception: 3rd/4th person should be +1 higher than Face Stretch on previous-person face. But: this is moot for general lenses since the LS limit is 2 faces.

### What Snap docs DON'T cover

- Script API to detect face count changes dynamically (only `getFacesCount()` per-frame check)
- Performance scaling implications of 1 vs 2 faces
- Behavior when face indices shift (person leaving frame — does index 1 become index 0?)
- Face identity consistency across frames

**Agent's coaching rule**: for any multi-face brief, build UX around the assumption that face indices are NOT stable across frames. Don't promise "the brand effect always stays on the same person".

### UX patterns

- **0 faces**: show "look at the camera" coaching state
- **1 face**: full effect on Face Index 0
- **2 faces**: full effect on both, mirrored or differentiated
- **2+ faces (impossible)**: never happens — only 2 supported

---

## 9. Faceless ML — face / nose hiding

### What it is

Privacy-focused face / nose hiding effect. Two component variants:
- `Faceless ML Face` — hides full face
- `Faceless ML Nose` — hides nose only

Use case: anonymisation in recordings, privacy-respectful lens effects, or creative "no face" branded effects.

### Install

Asset Library → Custom Components → install. Add via Asset Browser to resources.

### Configuration

- **Input texture** — render target source (default: Device Camera Texture)
- **Face Index** — which face to process (0, 1)
- **Render Order**

### Setup

Requires: Orthographic Camera + Full Frame Region + child Scene Object with Screen Transform component.

### Use cases

- GDPR / COPPA-sensitive contexts (lens that doesn't expose identifying face features)
- Creative "faceless" branded effects (mystery character, anonymous mode)
- Privacy-respectful audience-recording lenses

### What Snap docs DON'T cover

- Explicit GDPR / COPPA guidance
- Comparison to standard Face Tracking (when to use Faceless vs Face Mesh)
- Sponsored Lens compatibility

**Agent's coaching rule**: Faceless ML is a privacy effect, not a tracking primitive. If a brief mentions "anonymous", "privacy", "no-face", or sensitive-audience contexts, this is the right answer. Otherwise stick with Face Mesh.

---

## 10. Composing building blocks with recipes

The 8 building blocks above compose with the recipe catalog (`lens-recipe-catalog.md`) for novel briefs:

| Novel brief | Composition |
|---|---|
| **"Logo at the user's right eyebrow tip"** | Face Landmarks (get index for right eyebrow) + Head Binding + Screen Image with `screenPointToParentPoint` |
| **"Branded crown that fits the head shape"** | Head Mesh + `FitObjectToHeadController` + 3D crown model |
| **"Brand prop behind the user's hair"** | Face Occlusion + 3D prop + render-order coordination |
| **"Lip-only colour effect"** | Features Segmentation (lips mask) + A-2 Makeup color |
| **"Eyes glow when the user looks at the brand mark"** | Eye Tracking rotation + A-6 Eye Color + Behavior trigger on gaze-target overlap |
| **"Face swap with the brand mascot"** | Face Swap + brand-owned mascot texture (CHECK IP) + retry tap-handler |
| **"Two friends both get the brand filter"** | Duplicate effect component + Face Index 0 and 1 + matched render orders |
| **"Anonymous reaction lens"** | Faceless ML Face + ambient brand particles + audio cue on face-detection |
| **"Glasses occluded by face when user tilts"** | E-1 Eyewear Try-On + Face Occlusion + render-order coordination |
| **"Custom-painted face texture for war-paint look"** | A-7 Face Paint + Face Mesh UV reference + Photoshop UV template |

## 11. Cross-references

- `lens-recipe-catalog.md` — A-1 through A-7 (face recipes), F-4 (brand identity integration), parts-bin framing for novel briefs
- `lens-studio-api-gotchas.md` — `FaceLiquifyObjectPreset` (1 eye + 1 mouth), LiquifyVisual under perspective Camera, Face Mesh `Face Index` pattern
- `deprecated-api-migration.md` — `TurnOnEvent` → `OnStartEvent` migration applies to legacy face-effect samples
- `performance-optimization-guide.md` — texture sizes per face region (eye 64² / lips 250px / blush 450px), multi-person render-order, Liquify cap ≤10, "Performance" compression
- `sponsored-lens-submission.md` — third-party IP rule applies to Face Swap source images
- `bitmoji-integration.md` — Bitmoji Head + Face Animator are face-attached too (Bitmoji is organic-only)

## Adding new findings

When a Valtech project surfaces face-effect behaviour not in this file:

1. **Building block** — which component
2. **Pattern / use case** — concrete
3. **Numeric impact** — perf measurement if relevant
4. **Source** — Snap docs URL or empirical record
5. **Confidence** — official-docs / multi-source / single-source / valtech-validated
