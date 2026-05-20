# Lens Recipe Catalog — "I want X → here's how"

Fast-lookup catalog of common lens patterns for Lens Studio 5.20+. Designed for **brief-intake time**: when a colleague describes what they want in natural language ("a personality quiz lens", "a sunglasses try-on", "a music-reactive lens"), match the intent here BEFORE doing any spec drafting. Cuts the "let me research what's possible" step out of Phase 0.

## How the agent should use this file

1. **At brief intake (Phase 0)**: scan the catalog for matching intent. **Match loosely, not literally** — see "Critical" below.
2. **At spec drafting**: use the matched recipe's **Build approach** as the starting outline for `TECH-SPEC.md`. The recipe lists exact primitives, install paths, and pitfalls.
3. **At Phase 1 scaffolding**: the recipe tells you what Asset Library item to install first.
4. **At Phase 4 (DoD)**: cross-check the recipe's **Common pitfalls** as part of pre-submission review.

## Critical: this catalog is a parts-bin, not a strict pattern-match

The recipe names ("I want a sunglasses try-on", "I want a personality quiz") are **examples of common briefs** — not strings the agent must match literally. Colleagues will phrase intents in their own words: *"I want something that hovers next to the eyes"*, *"a logo that lights up when you smile"*, *"a butterfly that lands on the nose"*. None of those have an exact recipe entry — and that's expected.

When a colleague's brief doesn't have an exact named match here:

1. **Decompose the brief into primitives.** A "halo above the head" is not a named recipe, but it composes from `Head Binding` (F-4 method) + `GPU Particles` (B-4) + optionally `Face Expressions` (A-5) for trigger logic.
2. **Borrow from multiple recipes simultaneously.** A "logo that appears when the user smiles" combines A-5 (expression trigger) + F-1 (brand-logo Screen Image placement) — two recipes, one novel result.
3. **Reach beyond this file.** Audio briefs cross to `audio-in-lenses.md`. Sponsored Lens briefs cross to `sponsored-lens-submission.md`. Gotchas you'll hit during the build live in `lens-studio-api-gotchas.md`. Custom 3D models bring in `3d-asset-import-doctrine.md`.
4. **Never refuse based on "no exact match".** Say instead: *"I don't have a single-shot recipe for exactly this, but here's how I'd compose it: [A-X for component 1] + [B-Y for component 2] + [gotcha note for the tricky part]. Want me to proceed with this plan, or refine first?"*

The recipes are tested **patterns**. The agent's job is to recognise that patterns compose — and to propose composition confidently, flagging it as a novel composition that hasn't yet been valtech-validated.

### Concrete decomposition examples

| Brief | Composition |
|---|---|
| **"A butterfly that lands on the nose"** | Face Mesh (built-in primitive) + 3D model as child + Animation Player loop + Head Binding positioning pattern from F-4 |
| **"Logo that appears when you smile"** | A-5 (Face Expressions trigger on Smile) + F-1 (brand-logo Screen Image, disabled at start, toggled by Behavior on expression event) |
| **"Eyes that glow when you blink"** | A-5 (Face Expressions Blink) + A-6 (Eye Color secondary glow colour) + GPU Particles burst (B-4) on blink event |
| **"Audio-reactive 3D object that scales with the music"** | `audio-in-lenses.md` Audio Analyzer or Beat Sync (driver) + B-2 (Animated Object base) + custom scaling script bound to analyzer output |
| **"A floating brand object next to the head"** | F-4 (Head Binding pattern) + any 3D model + optional A-1 Face Retouch underneath for premium feel |
| **"Something that hovers near the eyes"** | A-6 (Eye Color positioning + Eye Editor for spatial reference) + Head Binding from F-4 + 3D model OR Screen Image with face-anchor |
| **"Branded countdown that pulses on the beat"** | F-3 (Branded Countdown base) + D-5 / `audio-in-lenses.md` Beat Sync (drives Tween on countdown text scale) |
| **"Personality quiz with a music-reactive intro"** | D-2 (Quiz Template) + D-5 Beat Sync (intro state) + state-transition wiring between intro and quiz |

If the brief decomposes into **more than 3-4 recipe fragments**, that's a signal it may be capability Tier 2/3 (requires external assets or research). Surface that to the colleague: "This is a novel combination — I can prototype, but expect Phase 1 to take longer than for a single-recipe lens."

## Source quality

Compiled 2026-05-20 from Snap's official Lens Studio documentation + LS in-app template browser. The recipes themselves are **research-validated, not Valtech-project-validated** — verify the first time you build each one in a real project, and when a recipe holds up in a shipped lens, promote it by adding a `**Validated:**` line citing the project.

`[STALE]` markers in source URLs indicate the doc URL is from Lens Studio 4.55.1, but the template/feature itself remains current in LS 5.x Asset Library — these are kept because the older URL is often where Snap's most detailed reference still lives.

## Asset sourcing boundary (important — read at brief intake)

Recipes here say things like *"import your shoe 3D model"* or *"assign brand logo as Screen Image"* — those user-provided assets are the **colleague's responsibility** to attach to the project's `assets/` folder. The agent doesn't fetch or generate client-specific assets (brand logos, brand 3D models, licensed music outside Snap's library, brand fonts, custom artwork).

What the agent CAN source: Snap's Asset Library (recipes' install steps), Snap Music Library, built-in face/world/body building blocks, GPU Particles presets, standard materials.

Surface this in plain mentor language at intake (not as a "what I can / cannot do" list): *"Har ni en logotyp, 3D-modeller eller egen licensierad musik som ska in i lensen? Lägg dem i projektmappen. Allt annat fixar jag från Snaps bibliotek."*

See `SKILL.md` → "Asset sourcing — what the agent fetches vs what the colleague provides" for the canonical boundary.

## Cross-references to other skill files

- **Sponsored Lens compliance** for any F-category recipe → `references/sponsored-lens-submission.md`
- **Deprecated `TurnOnEvent` / `AnimationMixer` patterns** that may still appear in legacy templates → `references/deprecated-api-migration.md`
- **Specific API gotchas** referenced inline → `references/lens-studio-api-gotchas.md`
- **Body-anchored tracker calibration** for E-3 (foot try-on) and other tracker recipes → `references/body-anchored-calibration.md`
- **3D model import** for any recipe using custom 3D assets → `references/3d-asset-import-doctrine.md`
- **Asset Library navigation** (categories, prefab `__SUFFIX` install hints, packed-vs-unpacked discipline) → `references/asset-library-guide.md` — every recipe install path goes through Asset Library
- **Audio recipes** (D-4 Soundboard, D-5 Beat Sync) and audio-anywhere → `references/audio-in-lenses.md`

## Contents

- **A** — Face Filters (7 recipes): beauty/retouch, makeup, hair color, face distort, expression-driven, eye color, face paint
- **B** — World / Environment (5 recipes): portal, animated 3D object, picture frame, particle ambience, look-around 360°
- **C** — Body / Hand (3 recipes): background segmentation, shoulder accessory, hand tracking
- **D** — Interactive / Mini-Experience (6 recipes): tap-to-cycle, personality quiz, countdown, soundboard, music-reactive, leaderboard
- **E** — Commerce / Try-On (5 recipes): eyewear, makeup product, footwear, wristwear, catalogue/shopping
- **F** — Brand / Sponsored Lens Specifics (4 recipes): branded face filter, branded particle ambience, branded countdown, brand identity integration

---

## A — Face Filters

### A-1 — "I want a beauty filter that smooths skin and brightens eyes"

**Intent**: Subtle skin retouching — soft skin, teeth whitening, eye sharpening, eye whitening.

**LS primitive(s)**:
- `Face Retouch` object (built-in: `+ → Face Retouch` in Scene Hierarchy)
- Optional: `ML Retouch Conditional` Custom Component from Asset Library (pimples, wrinkles, eye bags with independent sliders)

**Build approach**:
- `+` → search `Face Retouch` → add. Auto Mode applies ML Retouch out of the box.
- In Inspector, expand individual features (Soft Skin, Teeth Whitening, Eye Sharpening, Eye Whitening); intensity sliders 0.2–0.5 range recommended.
- For per-feature targeting (clear skin, wrinkles, eye bags), install `ML Retouch Conditional` from Asset Library, place under Ortho Camera, tune per-feature sliders.
- Set `Face Index = 0` for first face; duplicate with `Face Index = 1` for multi-face support.

**Performance notes**: Face Retouch + ML Retouch adds an ML inference pass per frame. Single Retouch object is well within the 150 MB RAM budget; stacking with Hair Color + Face Generator will compound the cost.

**Common pitfalls**:
- High `Soft Skin` intensity blurs the face into uncanny wax texture — keep ≤0.5.
- `ML Retouch Conditional` must be under Orthographic Camera with correct Render Order — placing in 3D scene produces no output.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-retouch + ML Retouch Conditional docs

**Confidence**: official-docs

---

### A-2 — "I want a makeup filter with lip color, eyeshadow, and blush"

**Intent**: Full-face cosmetic overlay, colour-adjustable without importing custom textures.

**LS primitive(s)**: `2D Makeup Helper` Asset Library package (`Makeup__PLACE_IN_OBJECTS_PANEL` prefab). Provides Lip Tint, Lip Gloss, Blush, Eyeliner, Eyeshadow, Mascara, Eyebrow Coloring.

**Build approach**:
- Asset Library → search `2D Makeup Helper` → Install → drag prefab into Scene Hierarchy.
- Right-click → Unpack for Editing to expose individual `MakeupController` children per region.
- Toggle each effect on/off; adjust Color picker and Intensity slider (0–1) per region.
- Test `Blend Mode` (`Soft Light` or `Multiply`) for realistic layering over natural lip tone.
- Add `Face Retouch` (A-1) as a light base layer before Makeup; keep Render Order lower than Makeup.

**Performance notes**: Face-mesh-mapped Screen Images, not 3D — relatively lightweight. All 6 regions simultaneously adds marginal GPU cost.

**Common pitfalls**:
- Eyeshadow on dark skin tones with default `Normal` blend mode looks unnatural — use `Soft Light` or `Screen`.
- Prefab must be dragged into Scene Hierarchy (not just Asset Browser) — no effect otherwise.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates/makeup

**Confidence**: official-docs

---

### A-3 — "I want a filter that changes hair color"

**Intent**: Recolor user's hair (full head, roots only, or ombre ends) with configurable colors.

**LS primitive(s)**: `Hair Color` Asset Library asset + `Hair Color Custom Component`.

**Build approach**:
- Asset Library → `Hair Color` → Install → drag into Scene Hierarchy.
- Find `Hair Color Custom Component` in Inspector.
- Set `Mode` (`Roots`, `Ends`, or `Full Head`); set `Base Color`.
- For two-tone: enable `Second Color`, set `Secondary Color`, choose `Gradient Mode` (`Ombre` vertical, `Split` horizontal).
- `Swap Colors` checkbox inverts gradient direction without changing values.

**Performance notes**: Uses Portrait Hair segmentation texture — hair-mask ML inference per frame. Heavier than 2D overlay, lighter than full body segmentation.

**Common pitfalls**:
- Very dark or very short hair → weak segmentation at hairline. Small Feathering helps but can't fully fix poor lighting.
- The `Alpha` slider on the `Hair` object under the Camera controls overall opacity — often missed in favour of editing the Component settings.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates/hair-color

**Confidence**: official-docs

---

### A-4 — "I want a face distortion / funny face / alien eyes filter"

**Intent**: Stretch, warp (liquify), or duplicate facial features — classic "big eye" or squish-face effect.

**LS primitive(s)**: `Face Distort` Asset Library asset (also `Distort` sample project). Sub-effects: `Face Liquify`, `Face Stretch`, `Face Inset`.

**Build approach**:
- Asset Library → `Face Distort` → Install → drag prefab into Scene Hierarchy. Or open Distort sample from LS Home Page.
- Face Liquify: `+ → Face → Face Liquify`; double-click object → opens Face Liquify Editor; drag blue control circle over target feature; adjust `Radius` + `Intensity`.
- Face Stretch: `+ → Face → Face Stretch`; 2D view with control points over face mesh; drag points to reshape outline.
- Face Inset: `+ → Face Effects → Face Inset`; set Source and Target regions.

**Performance notes**: GPU-lightweight (face-mesh 2D operations). >8 Liquify points at high intensities can cause jitter on low-end devices.

**Common pitfalls**:
- `Face Stretch` control points have no undo in some LS 5.x versions — save frequently.
- Face Distort renders on front camera by default; rear camera needs additional `Face Tracking` object.

**See also**: `lens-studio-api-gotchas.md` → `FaceLiquifyObjectPreset` ships with 1 eye + 1 mouth; LiquifyVisual must be under perspective Camera.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates/distort

**Confidence**: official-docs (multi-source)

---

### A-5 — "I want a filter that reacts to facial expressions (open mouth, blink, smile)"

**Intent**: Visible effects — particle bursts, 3D object animations, colour changes — triggered by specific face expressions.

**LS primitive(s)**: `Face Expressions` effect (`+ → Face Effects → Face Expressions`) + `Behavior` script + optional `ExpressionController` script.

**Build approach**:
- LS Home Page → open Face Expressions sample, or `+ → Face → Face Expressions`.
- To trigger a visual: add `Behavior` script; set Trigger = `Face Event` and choose expression (`Mouth Open`, `Blink Left`, `Smile`, etc.).
- For driving blend shapes on a 3D model: import model with blend shapes named to match LS expression list; add `ExpressionController`, link `BlendShapes Component`; auto-maps.
- 51 expressions available, each with `weight` (0–1 float); `Customize Expression` lets you remap to custom blend shape names.

**Performance notes**: ML expression-estimation pass on top of face tracking — moderate. Don't combine with Face Generator or heavy post-effects on same lens.

**Common pitfalls**:
- 3D model's blend shape names MUST exactly match LS expression list for auto-mapping — silent no-op otherwise.
- Mouth-open triggers on Sponsored Lens require device testing — preview panel's mouth-detection threshold differs from on-device ML.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates + Behavior examples

**Confidence**: official-docs

---

### A-6 — "I want an eye colour change filter"

**Intent**: Change iris colour of user's eyes with realistic blending.

**LS primitive(s)**: `Eye Color` object (`+ → Face → Eye Color`).

**Build approach**:
- `+ → Face → Eye Color` (2D object that auto-opens Eye Color Editor).
- In Editor, set iris colour via material colour picker. Use `Blend Mode` beyond `Normal` (try `Overlay` or `Multiply`) for natural blending.
- `Alpha` slider for subtler tint — 1.0 looks harsh on light eyes.
- Set to `Left Eye`, `Right Eye`, or `Both Eyes` on single object — or duplicate.
- For user-cycle through colours: multiple `Eye Color` objects (different colours each), start all but first disabled, wire tap events with `Behavior` → `Set Enabled → Toggle`.

**Performance notes**: Face-mesh-mapped 2D overlay — extremely lightweight, no ML pass.

**Common pitfalls**:
- Eye Color Editor opens via **double-click** — single-click only opens Inspector, leading to "where do I set colour?" confusion.
- Front camera only by default; rear camera needs additional setup.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/eye-color

**Confidence**: official-docs

---

### A-8 — "I want users to pick a face from their camera roll and apply it to a 3D object"

**Intent**: User selects a photo from phone library; LS auto-detects faces in the image, crops them, and applies the selected face as a texture to a custom 3D mesh.

**LS primitive(s)**: `Face Image Picker` template + `FaceImagePickerController [EDIT_ME]` + `face_image_picker` material + `FaceMesh [POSITION_ME]` prefab + Face Image Picker Texture component.

**Build approach**: Open Face Image Picker template → import 3D object → assign `face_image_picker` material → wire to `FaceImagePickerController`. User flow: tap picker UI → camera roll opens → user selects image → faces auto-detected + cropped → selected face mapped to UV.

**Common pitfalls**: Requires camera roll permission (handle denial); no-face-in-image needs fallback; multi-face images need selection UI; UV mapping must match the picker's expected layout.

**Sponsored Lens caveat**: User's chosen photo may contain third-party faces — this is user-driven IP, distinct from Face Swap (E recipe series). For Sponsored, brief carefully — user-controlled selection generally fine, but campaign messaging shouldn't encourage IP-violating choices.

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/world/face-image-picker [STALE URL; template current]

**Confidence**: official-docs

---

### A-7 — "I want a face paint / face mask filter"

**Intent**: Apply a custom-painted texture that appears painted directly on user's skin, following facial contours.

**LS primitive(s)**: `Face Paint` Asset Library asset + Photoshop UV template (downloadable from docs). Three artboards: `Full`, `Eye`, `Lips`.

**Build approach**:
- Download Photoshop UV template from Face Paint docs page; paint artwork on new layer within relevant Artboard.
- Export each Artboard as PNG with transparency via `File → Export → Artboards to Files`.
- LS: Asset Library → `Face Paint` → Install → drag prefab into Scene Hierarchy.
- Import exported PNG(s); in Inspector, assign each to corresponding texture slot (Full, Eye, Lips).
- Adjust blend mode per region (`Screen` for glitter, `Multiply` for realistic paint).

**Performance notes**: Face Mesh UV mapping — GPU cost low. 1024×1024+ PNG textures for full face are the main size risk.

**Common pitfalls**:
- Painting outside UV template boundaries produces clipping artefacts — respect Photoshop artboard boundaries exactly.
- Transparent areas in PNG must be genuinely alpha-0 (not white); JPEG export will break transparency.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates/face-paint

**Confidence**: official-docs (multi-source)

---

## B — World / Environment

### B-1 — "I want a portal lens that lets you step into another world"

**Intent**: World-tracked doorway/portal users can walk through into a custom 3D environment.

**LS primitive(s)**: `Portal` Asset Library asset + `Device Tracking` (Surface mode + Use Native AR) + `PortalController` script + `InteractionComponent`.

**Build approach**:
- Asset Library → `Portal` → Install → drag prefab into Scene Hierarchy.
- Select main `Camera Object`, add `Device Tracking` component, enable `Use Native AR`.
- Assign Camera reference to both `InteractionComponent` on `Portal [EDIT_ME]` AND `camera` field in `PortalController` script.
- Custom 3D world content as children of `Portal [EDIT_ME]`; size/position occluder mesh to match portal opening exactly.
- Position `PortalCornerMin` (bottom-left) + `PortalCornerMax` (top-right) of occluder for accurate enter/exit detection.

**Performance notes**: Native AR (ARKit/ARCore) is heavier than basic Surface tracking. World-inside-portal ≤50K polygons for mid-range devices.

**Common pitfalls**:
- Forgetting to assign Camera to BOTH `InteractionComponent` and `PortalController` causes enter/exit events to never fire.
- Native AR needs flat well-lit surface to initialise — instruct designers that near-white floors / table surfaces are the target.

**Source(s)**: https://developers.snap.com/lens-studio/examples/lens-examples/portal

**Confidence**: official-docs

---

### B-2 — "I want to place an animated 3D object in the world that users can move"

**Intent**: World-anchored 3D model with looping animation users can reposition, scale, rotate with pinch/drag.

**LS primitive(s)**: `Animated Object` Asset Library asset + `Device Tracking` (Surface) + `WorldObjectController` script + `TouchCollision` object.

**Build approach**:
- Asset Library → `Animated Object` → Install; add `Device Tracking` (Surface mode) to Camera Object; switch Preview to back camera.
- Drag prefab `Animated Object__PLACE_IN_SCENE` into Scene Hierarchy; attach Camera Object reference in both WorldObjectController instances.
- Replace `[REPLACE_ME]` placeholder with imported `.fbx`/`.glb` 3D model; set as child of `WorldObjectController`.
- Resize `TouchCollision` (R for scale) to match 3D model bounding box so tap-to-move works across whole object.

**Performance notes**: Standard world AR budget (150 MB RAM, LAT <650 ms for Sponsored). Animation Mixer adds minimal CPU overhead for loops.

**Common pitfalls**:
- `Animated Object` asset uses deprecated `AnimationMixer` in older versions — check for warnings, migrate to `AnimationPlayer`/`AnimationAsset` if flagged. See `deprecated-api-migration.md`.
- Not assigning Camera reference in WorldObjectController → object floats at scene origin instead of tracking surface.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/world/world-templates/animated-object

**Confidence**: official-docs

---

### B-3 — "I want a picture frame / artwork lens that places a framed image in the room"

**Intent**: Drop user-provided 2D image into a world-placed 3D picture frame, anchored to surface.

**LS primitive(s)**: `Picture Frame` template + `PictureFrameController` script + `Device Tracking` (Surface).

**Build approach**:
- Open `Picture Frame` template from Asset Library; auto-generates 3D frame around assigned image.
- Import 2D artwork as PNG/JPG; drag into Resources.
- Select `PictureFrameController`; assign imported texture to `Picture` field. Preview updates with correct aspect-ratio frame.
- Adjust frame width, border colour, drop shadow in Inspector.
- Add `Device Tracking` (Surface mode) to Camera Object for surface-anchoring.

**Performance notes**: One of the lightest world templates — textured plane + generated frame mesh.

**Common pitfalls**:
- 3D frame uses aspect ratio from imported texture — non-square image imported as square produces stretched frame until texture reimported at correct dimensions.
- Template lacks touch-to-reposition by default — add `WorldObjectController` manually if needed.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/world/picture-frame [STALE — 4.55.1 URL; template unchanged in LS 5.x]

**Confidence**: official-docs

---

### B-4 — "I want a particle ambience / environment particles lens (snow, sparkles, rain)"

**Intent**: Ambient particles floating around user or scene — snow, rain, embers, confetti, bokeh.

> **System choice**: LS 5.x has **two distinct particle systems** — pick based on whether a preset matches the brief. If yes, use GPU Particles Effects Pack (this recipe). If the brief needs custom behaviour (brand colors, mesh-driven spawn, segmentation-aware, novel composition), use VFX Graph instead — see `vfx-graph-guide.md`. (Legacy Particle System is deprecated; never propose.)

**LS primitive(s)**: `GPU Particles Effects Pack` Asset Library asset (rain, snow, blizzard, bouquet, sparkles presets) + `Portrait Particles` template (face-forward variant) + optional `Behavior` for face-found gating.

**Build approach**:
- Asset Library → `GPU Particles Effects Pack` → Install → drag desired prefab (`rain_vfx`, `sparkles_vfx`) into Scene Hierarchy.
- Switch Preview to outdoor/indoor video as appropriate.
- Behind user (world-depth) → under Perspective Camera; floating on screen plane → under Ortho Camera.
- Optional wiring: Behavior with Trigger = `Face Event → Face Found` → `Set Enabled` on particle object → particles only when face detected.
- For `Portrait Particles` template: use `PortraitParticlesController [EDIT_ME]` to swap presets, assign header/footer images, set post-effect colour filter.

**Performance notes**: GPU Particles are shader-driven, highly efficient. Set `Max Particles` ≤500 for mid-range Android.

**Common pitfalls**:
- `ExternalTimeController.js` has NO effect unless `External Time` checkbox is enabled per material in Inspector — script doesn't toggle the checkbox. See `lens-studio-api-gotchas.md` Part 2 → "GPU particle External Time must be checked per-material".
- Particles placed as world children without `WorldObjectController` drift when user moves phone — add Device Tracking + parent to scene root.

**Source(s)**: https://developers.snap.com/lens-studio/features/graphics/particles/gpu-particles/gpu-particles-templates/particles

**Confidence**: official-docs

---

### B-5 — "I want a look-around lens with content placed all around the user (360° environment)"

**Intent**: Objects or images anchored in 3D space around user, visible by rotating device.

**LS primitive(s)**: `Look Around` template + gyroscope-based Device Tracking (no surface detection) + optional `Look At` component.

**Build approach**:
- Open `Look Around` sample from LS Home Page or Asset Library.
- Import 3D objects; drag as children of `WorldObjectParent`, replacing `[REPLACE_ME]` placeholders.
- Position/scale/rotate each child relative to Camera — positions are preserved as fixed offsets from user's starting orientation.
- For objects always facing user: add `Look At` component, link Camera as Target, set `Aim Vector` to `Z aim, Y up`.

**Performance notes**: Gyroscope-only (no ARKit/ARCore) — extremely low tracking overhead.

**Common pitfalls**:
- Each animated object needs its own `IdleAnim` script bound to `Initialized` event with its own `AnimationMixer` reference — single IdleAnim script doesn't fan out to multiple models. (Note: `AnimationMixer` is deprecated; migrate per `deprecated-api-migration.md`.)
- Look Around starts from user's current phone orientation at lens launch — if launched while tilted, content appears offset.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/world/look-around [STALE — 4.55.1 URL; template unchanged in LS 5.x]

**Confidence**: official-docs

---

### B-6 — "I want a hole-in-the-ground / window-down effect (peer into another world)"

**Intent**: Designer wants a 3D hole that appears in the floor or ground in front of the user, letting them peer down into a custom world below — variant on the Portal concept but specifically ground-based, no doorway to walk through.

**LS primitive(s)**: `Window` template (LS 4.55 template, still functional in LS 5.x) + `WorldObjectController` script + `Occluder` mesh with `window_occluder_mat` material + Surface tracking (world-locked hole).

**Build approach**:
- Open `Window` template (Asset Library / LS Home Page — search "Window").
- Add `Device Tracking` (Surface mode) to Camera Object so the hole locks to detected ground.
- Replace the `[REPLACE_ME]` placeholder object under `WorldObjectController` with your custom 3D world content (e.g. underwater scene, miniature city, brand environment).
- The `Occluder` mesh with `window_occluder_mat` material hides the parts of your world that are "above ground" — gives the illusion that the world exists below the floor.
- Adjust `TouchCollision` to match the hole's perimeter for tap-to-reposition.
- Toggle `Use Ground Grid` on WorldObjectController for a circular visual indicator under the hole.

**Performance notes**: Window uses standard world AR (Surface tracking) — comparable cost to B-1 Portal and B-2 Animated Object. The occluder mesh adds one draw call. World-inside-hole polygon budget applies — keep <50K total for mid-range devices.

**Common pitfalls**:
- Occluder mesh shape must precisely match the hole's perimeter — gaps allow "underground" content to peek above ground, breaking the illusion
- Tracking requires flat well-lit floor — works best on light-coloured floors, struggles on dark patterned surfaces
- World content placed too high will clip through the occluder — anchor world content well below ground plane (-Y direction)

**Difference from Portal (B-1)**:
- **Portal** = vertical doorway you walk THROUGH to a different space
- **Window** = horizontal hole in the FLOOR you look DOWN into

Brief language clues: "step into" / "doorway" / "walk through" → Portal (B-1). "Peer into" / "look down" / "hole in the ground" → Window (B-6).

**Sponsored Lens fit**: Identical to B-1 Portal — works for brand-environment reveals (brand-world below the user's floor), product launches (3D product emerging from the hole), and immersive campaign storytelling. Same brand-mark + LAT + safe-zone requirements apply.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/world/window [STALE URL; template current in LS 5.x]

**Confidence**: official-docs

---

## C — Body / Hand

### C-1 — "I want a background swap / green screen lens using body segmentation"

**Intent**: Replace background behind user with custom image/video/colour, keeping user in foreground.

**LS primitive(s)**: `Background Image` / `Background Color` Asset Library assets + `Segmentation Texture` (Portrait Background type) + Fullscreen Segmentation pipeline.

**Build approach**:
- Asset Library → `Background Image` → Install → drag into Scene Hierarchy.
- `+ → Segmentation Texture` in Asset Browser; set Type to `Portrait Background`.
- Assign Segmentation Texture to Background Image's mask slot; import background PNG/JPG; assign to Image Texture slot.
- `Fill Mode = Fill` for full-frame cover; enable `Refine Edge` on Segmentation Texture for cleaner person edges.
- Manual/low-level: Unlit material with `Base Texture` (Device Camera) + `Opacity Texture` (Segmentation Texture), assigned to Full-Screen Screen Image; `Plane Mode = Normal`.

**Performance notes**: Portrait Background segmentation is one of the heavier LS effects — full-frame segmentation ML pass per frame. Avoid combining with Hair Color or full-body segmentation in same lens.

**Common pitfalls**:
- `Plane Mode` MUST be `Normal` (not `Disabled`) for segmentation material to apply — otherwise renders nothing.
- High Feathering causes halo at hair edges — `Refine Edge` more effective than large Feathering values.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/body/segmentation/fullscreen-segmentation

**Confidence**: official-docs (multi-source)

> **Variant — full-body vs portrait**: C-1 uses `Portrait Background` (face + upper chest area). For **full-body segmentation** (arms, legs, full silhouette), select the `Body` segmentation type instead. Use Body when brief calls for whole-figure cutout or full-body silhouette effects (dance lens, full-body costume swap). Additional gotchas for full-body segmentation: set Segmentation Texture's wrap mode to `ClampToEdge` (prevents undesired texture repeating at edges); render layer of effect MUST match the camera's render layer; outline effects need TWO segmentation instances (one feathered, one refined). Same ML cost class as Portrait — heavy; don't combine with Hair Color in the same lens. Source: https://developers.snap.com/lens-studio/4.55.1/references/templates/world/body-segmentation [STALE URL; segmentation pipeline current in LS 5.x].

---

### B-7 — "I want a 2D character / cutout placed in the world (paper-cut style)"

**Intent**: Designer wants a 2D image (transparent PNG of a character, mascot, or object) placed in 3D world space as if it were a cardboard cutout, with optional ground shadow derived from the silhouette.

**LS primitive(s)**: `Cutout` template + `CutoutController [EDIT_ME]` + `Look At Camera` (Y-axis-only) + optional ground shadow via silhouette + Surface tracking.

**Build approach**: Open Cutout template → import 2D image (transparent PNG) → assign to `CutoutController` Image field → set `Ground Offset` for shadow position → `Look At Camera` keeps the cutout facing the user as they walk around it (rotates only on Y-axis, so the cutout doesn't tilt sideways).

**Performance notes**: Extremely lightweight — single textured plane + optional shadow plane. Suitable for many cutouts in one scene (paper-cut diorama, character collection).

**Common pitfalls**:
- PNG edges with poor alpha (premultiplied / fringe) show ugly halos — use `Straight Alpha` export from Photoshop/Illustrator
- `Look At Camera` rotation is Y-axis only — the cutout doesn't tilt up/down when the user looks down from above. Acceptable for ground-anchored cutouts; weird for ceiling-anchored
- Shadow `Ground Offset` tuning is per-cutout — copy values between similar-sized cutouts to keep visual consistency

**Difference from B-3 Picture Frame**: B-3 generates a 3D frame around any image (rectangular). B-7 Cutout uses the image's own silhouette (any shape) as the visible object.

**Sponsored Lens fit**: Strong for character-based brand activations (mascot in your living room, branded paper-cut diorama). Same brand-mark + IP rules apply per `sponsored-lens-submission.md`.

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/world/cutout [STALE URL; template current]

**Confidence**: official-docs

---

### C-2 — "I want a body-anchored shoulder accessory / wings / badge"

**Intent**: Images or 3D objects attached to user's shoulders, following body movement.

**LS primitive(s)**: `Shoulder` Asset Library asset (LS 5.x: `2D Shoulder` or `Body Tracking` via `+ → Object Tracking → Body Tracking`) + `Body Tracking` component for scripted control.

**Build approach**:
- Asset Library → `Shoulder` → Install → drag prefab into Scene Hierarchy.
- Switch Preview to `Body` video preset.
- Select `Skeletal Image Controller [EDIT_ME]`; assign texture assets to Left Shoulder / Right Shoulder / Neck slots.
- Toggle each joint's checkbox; adjust Size, Offset, Rotation, Alpha per joint.
- For 3D objects on shoulders: parent 3D mesh as child of appropriate shoulder joint scene object (instead of 2D screen image).

**Performance notes**: Lighter than full skeletal tracking (only 3 attachment points). Shoulder detection works medium-to-far from camera; close-range selfies may lose tracking.

**Common pitfalls**:
- `2D Skeletal` prefab MUST be under Orthographic Camera — placing in 3D perspective scene produces no 2D screen-space output.
- Close selfie range unreliable — use `Shoulder` template (not `Skeletal`) for front-camera experiences.

**See also**: `body-anchored-calibration.md` for universal probe-first protocol on tracker-driven content.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/body/body-templates/body

**Confidence**: official-docs

---

### C-3-alt — "I want a lens that detects and reacts to a pet (cat / dog)"

**Intent**: Designer wants a lens that detects when a cat or dog is in frame and attaches effects to specific points on the animal (eyes, nose, head).

**LS primitive(s)**: `Object Tracking` via Scene Hierarchy `+ → Tracking → Cat` / `Dog` / `Cats and Dogs` + `AttachToObjectTracking.js` helper script for 3D attachment.

**Build approach**:
- `+ → Tracking → Cat` (or `Dog` / `Cats and Dogs` for combined) — creates parent tracking object + child 2D image slot.
- Each pet category has specific attachment points: Cat = `Center`, `Left Eye`, `Right Eye`, `Nose`. Select the point in Inspector.
- For 2D effects (sunglasses on dog, sticker on cat nose): drag images as children, position via Screen Transform under attachment point.
- For 3D effects (party hat on dog): use the `AttachToObjectTracking.js` script with Perspective Camera reference + Object Tracking target + Base Depth Factor + Apply Rotation toggle.
- Test in Preview with cat/dog video presets — built-in webcam test won't trigger pet detection.

**Performance notes**: Pet tracking uses an ML model separate from face / hand / body. Don't combine multiple tracking systems (face + pet + hand) in one lens without perf testing — each ML model compounds the cost.

**Common pitfalls**:
- Cat/Dog tracking is **2D screen-space bounding box only** — no 3D pose data, no orientation data exposed
- Multi-pet (two cats in frame) not documented as supported — design for one pet at a time
- Lighting / distance sensitivity not documented; assume ML accuracy degrades in poor lighting (test on device)
- `Object Tracking` is **NOT custom-trainable** — for brand product detection (e.g. "detect our cereal box"), use **SnapML** with a Bring-Your-Own-Model approach (separate research bucket)

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/world/object-tracking

**Confidence**: official-docs

---

### C-3 — "I want a hand tracking lens where things follow or react to hand gestures"

**Intent**: Images, particles, or 3D effects attached to hand joints or triggered on specific gestures (peace sign, open palm, pinch).

**LS primitive(s)**: `2D Hand Tracking Joints` Asset Library asset (25 joint points) + `Default 3D Hands` / `Frog 3D Hands` / `Skeleton 3D Hands` for 3D hand models + `HandTrackingController` script + optional `Hand Segmentation` for occlusion.

**Build approach**:
- Asset Library → `2D Hand Tracking Joints` → Install → drag into Scene Hierarchy under Camera Object.
- Switch Preview to back-camera or `Object Tracking → Hand` video preset.
- Attach images/objects as children of desired joint objects (e.g., `LeftHandIndex3` for fingertip particle); set Tracking Type to `Smooth` (less jitter) or `Precise` (lower latency).
- For gesture triggers: `HandTrackingController` reads joint positions to infer gesture states; add Behavior responses or TS script logic on gesture-change events.
- For 3D hand overlay: install `Default 3D Hands`, drag under Camera Object, use `Match Hierarchy` button to bind custom 3D model to tracking skeleton.

**Performance notes**: Hand tracking runs separate ML model from face tracking — DON'T combine both without perf testing. 3D hand rigging heavier than 2D joint attachment.

**Common pitfalls**:
- Custom 3D hand models MUST have rig bone hierarchy exactly matching provided reference — `Match Hierarchy` silently no-ops if bone names don't match.
- Hand tracking is rear-camera-optimised; front-camera detection has lower accuracy and range.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/hand/hand-tracking-templates/3d-hand-tracking

**Confidence**: official-docs

> **Pre-built hand gesture detection** — the `Hand Gestures` template (Asset Library) ships with **5 named gestures** detected out-of-the-box: `open`, `close`, `horns`, `index_finger`, `victory`. Uses `Object Tracking` attached to `Orthographic Camera > Hand Tracking Region`. Trigger pattern: gesture event → instantiate visual prefab + play SFX via Behavior wiring. For brand briefs that want gesture-driven activation ("show victory sign to trigger brand reveal"), this is faster than HandTrackingController gesture-inference from joint positions. Source: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/hand-gestures [STALE URL; template current].

---

## D — Interactive / Mini-Experience

### D-1 — "I want a tap-to-cycle lens that changes background, effect, or 3D object on each tap"

**Intent**: User taps to cycle through visual states (backgrounds, overlays, characters, colors).

**LS primitive(s)**: `Behavior` script (no-code: `+ → Scripts → Behavior`) OR `Script Graph` with `SceneObject Array Input`, `Foreach`, `setEnabled` nodes.

**Build approach**:
- Add all variant objects to Scene Hierarchy; disable all except first (index 0).
- Add `Script Graph` to scene; create `SceneObject Array Input` named "objects" with all variants.
- On `OnAwake`: `Foreach` → `setEnabled(false)` on all except index 0.
- On `Tap Event`: increment counter; `setEnabled(false)` on current; increment index mod N; `setEnabled(true)` on new.
- Simpler two-state toggle: `Behavior` with Trigger = `Touch Event → Tap`, Response = `Set Enabled → Toggle`.

**Performance notes**: Enable/disable only — no overhead per cycle. Keep inactive states fully disabled (not just invisible) to avoid unnecessary GPU draw calls.

**Common pitfalls**:
- Script-graph `setEnabled` for SceneObjects vs Components are SEPARATE nodes — use the SceneObject variant.
- `Behavior` Toggle pattern only works for 2 states — 3+ states require Script Graph or custom TS.

**Source(s)**: AR Bootcamp tap-to-change tutorial + Snap Behavior docs

**Confidence**: community-tutorial (official-docs for Behavior primitive)

---

### D-2 — "I want a personality quiz / choice-driven branching lens"

**Intent**: Users answer questions (tap or tilt) and receive personalised result based on choices.

**LS primitive(s)**: `Quiz Template` (LS 4.55 template, still available on Home Page + Asset Library) + `Behavior` script for tap/head-tilt triggers + optional `Fullscreen` template for state management.

**Build approach**:
- Open `Quiz Template` from LS Home Page or Asset Library.
- Edit `QuizController` script properties: question text strings, answer option labels, AR effect / scene state per answer.
- Template supports `Tap` and `Head Tilt` triggers out of the box via included `Behavior` scripts.
- Deeper branching (beyond linear): `SceneObject Array` per question state + counter variable in custom TS component to track current branch.
- Test all branches via simulated taps in Preview; ensure disabled states reset if restart-quiz is supported.

**Performance notes**: UI-heavy but render-light — all 2D/Ortho. Main risk: preloading all result states as enabled bloats RAM. Lazy-load via `setEnabled`.

**Common pitfalls**:
- `Quiz Template` is 4.55 legacy — `TurnOnEvent` wiring inside may generate deprecation warnings in LS 5.x. Migrate to `OnStartEvent`. See `deprecated-api-migration.md`.
- Quiz branches sharing audio cues need explicit audio stop/reset — `Behavior Play Sound` doesn't auto-stop currently-playing track.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/quiz-template [STALE URL; pattern unchanged]

**Confidence**: official-docs

---

### D-3 — "I want a branded countdown lens for an event or product launch"

**Intent**: Lens showing countdown timer to specific future date with customisable visuals + branded elements.

**LS primitive(s)**: `Countdown` template (LS 5.x built-in beginner template) + `CountdownController` script + optional 3D hat/glasses accessories (can be disabled).

**Build approach**:
- LS Home Page → Beginner Templates → Countdown.
- Select `CountdownController [EDIT_ME]`; set target date by modifying date field in script.
- Customise colours, fonts, "before-countdown" / "after-countdown-complete" messages in Inspector.
- Remove built-in hat/glasses: expand `Effects` in Scene Hierarchy → disable/delete `Birthday Hat` and `Sunglasses`.
- Add brand imagery: import logo PNG, assign to `Screen Image` positioned in safe zone.

**Performance notes**: One of the lightest LS templates — 2D text + simple 3D props. Well within Sponsored Lens <4 MB and <650 ms LAT.

**Common pitfalls**:
- `CountdownController` reads device's LOCAL time — designer testing in different timezone from target audience displays incorrect value. **Set date in UTC** and brief explicitly.
- Countdown animations may trigger immediately on `OnStart` if Behavior trigger is wired to `Lens Turn On` (deprecated). Migrate to `OnStartEvent`.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/face/countdown [STALE URL; unchanged in LS 5.x]

**Confidence**: official-docs

---

### D-4 — "I want a soundboard lens with tappable buttons that play sounds"

**Intent**: On-screen buttons that each trigger different sound + pop-up visual graphic when tapped.

**LS primitive(s)**: `Soundboard` Asset Library asset + `SoundboardKey` script (per button) + separate Live Target / Capture Target cameras (buttons visible while recording, hidden in final Snap).

**Build approach**:
- Asset Library → `Soundboard` → Install → drag prefab into Scene Hierarchy under Orthographic Camera.
- Add/duplicate `SoundboardKey_` objects per button; assign `Audio Track` asset to each SoundboardKey script.
- Replace default kitty pop-up sprites on `TriggerVisual_` objects with brand's own images.
- Template already uses Capture Target / Live Target split — buttons appear only during recording, not in final Snap. DO NOT remove this layer setup.
- Add branded background/overlay as Screen Image under main Ortho Camera render layer.

**Performance notes**: UI-only, extremely lightweight. Audio tracks as MP3 (compressed) — WAV imports bloat size significantly.

**Common pitfalls**:
- Audio tracks bundled inside lens count toward 8 MB size limit; >10 sec clips can push a simple soundboard over the limit.
- Live Target / Capture Target layer system is REQUIRED for buttons to not appear in saved Snaps — removing the Capture Target camera breaks this.

**Source(s)**: https://developers.snap.com/lens-studio/features/audio/audio-templates/soundboard

**Confidence**: official-docs

---

### D-5 — "I want a music-reactive visual lens where the effect responds to the beat"

**Intent**: Visuals (particles, material colours, scale animations) that pulse/change in sync with music track beats.

**LS primitive(s)**: `Beat Sync` Custom Component (Asset Library) + `Sound Sync API` (used internally) + `Music Lyrics & Beats` sample project (LS 5.x, Home Page) + optional `Wired Parameters` Custom Component (for binding beat data to material/transform properties without scripting).

**Build approach**:
- Asset Library → `Beat Sync` → Install → add component to scene object.
- Download music track from Asset Library (Music section); in track's Inspector, **uncheck `Bundled`** — required for Beat Sync to function.
- Configure trigger type: `OnBeat` (every beat), `OnDownBeat` (every bar downbeat), or specific beat index.
- Wire responses: Behavior scripts, material property changes, custom TS API calls on Beat Sync trigger events.
- Simplest visual-only approach: open `Music Lyrics & Beats` sample project, enable `Behavior Response` beat sync example (Color Correction VFX on beats), swap music track.

**Performance notes**: Uses pre-analysed beat timestamp data (not real-time audio analysis) — minimal CPU per frame. Pre-computed data loaded at lens start; keep music tracks unbundled to avoid 8 MB size limit.

**Common pitfalls**:
- Leaving `Bundled` checked on music track causes Beat Sync to silently fail — no errors, but beat events never fire.
- Beat Sync only works with tracks that have pre-analysed beat data in Asset Library — cannot analyse arbitrary imported audio files.

**Source(s)**: https://developers.snap.com/lens-studio/features/audio/beat-sync

**Confidence**: official-docs

---

### D-6 — "I want a leaderboard / competitive mini-game lens where scores are tracked"

**Intent**: Users accumulate score and see ranking against friends or globally.

**LS primitive(s)**: `LeaderboardCore` Custom Component (LS 5.x, Sep 2024) + `LeaderboardInfo` Custom Component (headless UI display) + `LeaderboardModule` API (scripting) + `Turn-Based Game` sample project.

**Build approach**:
- Asset Library → `LeaderboardCore` → Install → add component to scene object.
- In TS: `@input Component.ScriptComponent Leaderboard`, then call `script.Leaderboard.initializeWithOptions({ name, userType, scoreOrdering, ttlSeconds, userLimit, useTimer, leaderboardStartDate })`.
- Submit score: `script.Leaderboard.submitScore(score)` on game-end event.
- UI display without custom code: install `LeaderboardInfo`, link text components + Bitmoji image slots in Inspector — auto-populates rankings. (Bitmoji slots are ORGANIC-ONLY — see `bitmoji-integration.md` for the Sponsored Lens restriction.)
- Subscribe to updates: `script.Leaderboard.onLeaderboardRecordsUpdated.add((wrapper) => { /* update UI */ })`.

**Performance notes**: Leaderboard data fetched async from Snap cloud — network latency (0.5–2 s) on first load. Design UI for loading state.

**Common pitfalls**:
- Leaderboard name + Lens ID MUST be unique — same name across multiple dev lenses shares scores between projects unintentionally.
- `scoreResetInterval` set during `initializeWithOptions` — CANNOT change after leaderboard is created without new name.

**Sponsored Lens caveat**: Cloud features like Leaderboard fall under the "Lens Cloud features NOT allowed in Sponsored Lenses" rule — see `sponsored-lens-submission.md`. Leaderboard is OK for organic lenses; for Sponsored campaigns, re-scope to local-only score tracking.

**Source(s)**: https://developers.snap.com/lens-studio/features/games/leaderboard-core + leaderboard-info

**Confidence**: official-docs

---

### D-7 — "I want a 2D UI layout (button grid, text panels) anchored anywhere in 3D"

**Intent**: Designer wants a 2D interface (text + image panels, buttons, layout grids) that can be placed at the top of the scene OR anchored in 3D world space, instead of always rendering through the Orthographic Camera.

**LS primitive(s)**: `Simple Canvas` template + `Canvas` component (on parent SceneObject) + `ScreenTransform` (required on every child) + `UIPanel` script (touch detection via `containsScreenPoint`) + `LayoutGrid` (auto-arrangement) + optional `TweenScreenTransform` (animation) + optional `Device Tracking` (world-anchored UI).

**Build approach**: Open Simple Canvas template → child UI elements have ScreenTransform → wire touch via UIPanel's `containsScreenPoint(point)`. For world-anchored UI: place Canvas at top of Objects panel + add Device Tracking to Camera so Canvas tracks in the world. Auto-arrange buttons via LayoutGrid (e.g. phone-keypad layout).

**Common pitfalls**:
- Children MUST have unbroken ScreenTransform chain — breaking the chain (a non-ScreenTransform parent in between) breaks Screen Transform behaviour entirely
- "Things rendered more than once in Preview" = more than one camera rendering the same content; usually means Canvas is in both Ortho and Perspective render layers
- Touch detection requires `containsScreenPoint` — Behavior alone doesn't fire on Canvas elements

**Difference from Ortho-camera UI**: Standard 2D UI via Ortho Camera is screen-locked. Canvas is **portable** — can be placed at top-level (screen-locked behaviour) OR as child of a world-tracked object (UI panel appears anchored to a surface). Good for interactive product cards, branded info panels at world locations.

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/canvas-template [STALE URL; template current]

**Confidence**: official-docs

---

### D-8 — "I want a lens that recognises American Sign Language fingerspelling (A–Z + numbers)"

**Intent**: Designer wants a lens that detects ASL alphabet/number fingerspelling in real time — for educational, accessibility-focused, or deaf-community-centered brand activations.

**LS primitive(s)**: `ASL Fingerspelling` template + `Fingerspell Detector` component (ML model from SignAll partner, runs on 2D hand tracking) + `Fingerspell Hint` (3D hand-animation visualiser + text display) + `Mode` parameter (alphabet vs numbers).

**Build approach**: Open ASL Fingerspelling template → configure `Fingerspell Detector` with `threshold` (detection confidence), `minOccurrence` (frame persistence), `repeatAfter` (cooldown). Subscribe to events:

```typescript
script.fingerspellDetector.onNewChar.add((c) => { print(c); });
script.fingerspellDetector.onHandFound.add(() => { print('Hand Found'); });
script.fingerspellDetector.onHandLost.add(() => { print('Hand Lost'); });
```

Wire `onNewChar` to display the letter, animate a response, or build a fingerspell-the-word game.

**Common pitfalls**:
- Hand orientation sensitivity — detection varies with hand angle to camera; coach users to face palm forward
- Lighting: low-light degrades ML accuracy
- Ambiguous letters (M / N, R / U, F / W) need higher `threshold` to disambiguate; tune per-letter if a specific brand-word relies on it
- Frame-based detection requires sustained finger positioning — fast switches between letters may miss

**Sponsored Lens fit**: Strong for **inclusive / accessibility / educational brand campaigns**. Examples: deaf-community-focused product launch, "spell our brand name" interactive challenge, language-learning brand partnership. ML model is the SignAll partner model — flag IP/licensing chain at Phase 0 for any commercial use.

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/asl-fingerspelling [STALE URL; template current]

**Confidence**: official-docs

---

### Physics templates (D-9 through D-11)

LS ships a cluster of physics-driven interactive templates. All use the same underlying physics system (Physics Body, Physics Constraint, Physics Collider, Physics Matter, Physics World). See `lens-studio-api-gotchas.md` Part 2 → "`Physics.WorldSettingsAsset` is NOT added by default" — must be added manually for any physics-using lens.

> **Physics Lab** (`/templates/interactive/physics-lab-template`) is a **tutorial sandbox** for LS Content Editor tools (Select/Move/Scale/Rotate/Clone/Delete/Parent) plus 7 puzzles. **Not a brand-brief recipe** — useful only as a learning resource for new colleagues. Skip when recipe-matching a colleague's brief.

> **Physics Gravity Gun** (`/templates/interactive/physics-gravity-gun`) demonstrates Raycasting + Physics + UI Buttons for pickup/propel of objects. Docs are thin; treat as a starting point for "physics-based custom tool" briefs but expect substantial custom work. Author: MousePack.

### D-9 — "I want interactive plants / flowers that sway and react"

**Intent**: Nature-themed lens with foliage that deforms physically — branded plant/florist activations, wellness lens, garden-themed product launches.

**LS primitive(s)**: `Physics Responsive Plants` template + chain-linked `Physics Body Component` (dynamic) + `Physics Constraint Component` (Fixed / Hinge / Point) + `Physics Collider Component` (cylindrical for stems) + 3 generator scripts: `TensionStemGenerator.js` (vertical stems with slight bend), `SuspensionFrondGenerator.js` (multi-frond spreads), `BonesTargetColliders.js` (links 3D rig to Collider Rig via bone mapping) + `ResponsivePlantSettings.js` (unified density / damping / matter overrides) + `Physics.WorldSettingsAsset` (mandatory — add via Asset Browser).

**Build approach**: Install template → pick a plant preset (4 ship) → tune via `ResponsivePlantSettings` (density, damping, angular damping). Plants respond to simulated gravity + constraint forces — **no built-in touch trigger**; for tap-driven interaction, add a Physics Body Component to a "wind" or "finger" object that collides with the plant rigs.

**Common pitfalls**:
- Multiple plants compound physics cost — for ambient decoration use low-detail variants
- "Physics objects are not parents of one another" — plant chains link via Constraints, NOT hierarchy. Don't try to nest physics bodies in Scene Hierarchy
- Mesh vertex count must be enough for smooth deformation; under-detailed mesh produces visible jitter
- Bones must align with collision segment positions or deformation looks wrong

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/physics-responsive-plants [STALE URL; system current]

**Confidence**: official-docs

---

### D-10 — "I want a destructible object that breaks when tapped / hit"

**Intent**: Object (branded packaging, piñata, glass bottle) that fragments into pieces on collision — for "smash to reveal" brand activations, gamified destruction, product launch.

**LS primitive(s)**: `Let's Break It` template + `ConvexMeshHelper` script (applies physics to broken-model parent) + `onCollisionBreak` script (boolean `is Breaking` toggle + `Filter the collision` for scene-name matching) + Physics Body (Box) for floor + Convex Mesh Physics Body for breakable object + `Physics.WorldSettingsAsset` (mandatory).

**Build approach**: Author both an **intact** and a **pre-broken** 3D model (broken model is a parent containing the fragment-meshes as children, each with its own Render Mesh Visual). Import both → place `ConvexMeshHelper` on broken-model parent → add Physics floor (`+ → Physics → Box body`) → wire `onCollisionBreak` with collision filter (list the projectile object's scene names). On collision: intact model hides, broken model spawns at the same position with physics-driven fragments.

**Common pitfalls**:
- Overlapping intact + broken models — toggle visibility, never both visible
- All children of broken model MUST have Render Mesh Visual or fragments don't render
- Filter list needs **explicit** scene-name entries — wildcard / category matching not supported
- World Mesh-based collisions require Interactive Preview mode in LS (desktop preview doesn't reproduce)
- Mass property control: set to 0 for static (the floor), positive for breakable objects

**Sponsored Lens fit**: Strong for "smash to reveal" mechanics — branded piñata, breakable package reveal, brand-bottle-smash-into-confetti. Verify any product-likeness against IP rules per `sponsored-lens-submission.md`.

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/physics-lets-break-it [STALE URL; system current]

**Confidence**: official-docs

---

### D-11 — "I want a collect-the-falling-items mini-game (coins, items, brand objects)"

**Intent**: Mini-game where items drop from the top of the screen, user catches/collects them for score, optional "bomb" objects end the game on collection — for gamified brand activations.

**LS primitive(s)**: `Collect Coins` template (Maha Aldosary) + `Game Controller` (intro / play / game-over state machine via `Game State Config`) + `Spawner` script (configurable frequency, random item selection) + `Bomb` and `Coin` prefabs (physics bodies with collision triggers) + Behavior with `Physics Collider Event` triggers filtered by object name (score on coin-collision, end-game on bomb-collision) + `Physics.WorldSettingsAsset` (mandatory).

**Build approach**: Open template → replace `Coin` prefab visuals with branded collectibles → keep `Bomb` prefab as "avoid" mechanic (or swap for brand-inappropriate visual) → tune `Spawner` frequency → wire score-event Behavior to update Screen Image counter + audio feedback → game-over state shows final score + retry CTA. Player input is not explicitly documented in the template — typically device-tilt or tap-to-move; check template's controller for the actual mechanic.

**Common pitfalls**:
- Game state transitions: ensure "play → over → intro" reset cleanly; common bug is leftover spawned objects on retry
- Score-event Behavior uses `Physics Collider Event` filtered by object name — must match prefab names exactly
- Audio (collect-ding) loads with the lens — count toward 8 MB / 4 MB Sponsored budget; use short MP3 clips

**Sponsored Lens fit**: Classic gamified brand activation — branded collectibles raining down for the user to catch. Add leaderboard via D-6 for competitive layer (but D-6 uses Lens Cloud → organic only per `sponsored-lens-submission.md`).

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/physics-collect-coins [STALE URL; system current]

**Confidence**: official-docs

---

### D-12 — "I want users to scan a real-world product / place / vehicle to unlock content"

**Intent**: Camera-driven scan that identifies a real-world object, place, or vehicle and triggers a branded response — "point camera at our product to unlock the brand experience".

**LS primitive(s)**: `Scan` template + Lens Cloud backend (object/place/vehicle identification ML) + permission handling + conditional visual response + optional data extraction (car prices, place metadata).

**Build approach**: Open Scan template → configure target scan type (object / place / vehicle / SnapCode) → wire identification-result event to a Behavior chain that enables the brand response. Use Lens Cloud's object-recognition backend — no custom ML training required for the supported categories.

**Common pitfalls**:
- Camera + scan permission flow — handle denial gracefully
- ML identification varies with lighting + angle + distance — coach users to "hold steady, point at the [object]"
- Only Lens-Cloud-supported categories are detectable out-of-the-box — for custom brand product detection, use SnapML (Bring Your Own Model)

**CRITICAL Sponsored Lens caveat**: Scan template uses **Lens Cloud backend** → **NOT allowed in Sponsored Lenses** per Snap rule. See `sponsored-lens-submission.md` → "Lens Cloud features are NOT permitted in Sponsored Lenses". For Sponsored briefs that need scan-to-unlock: re-scope to **SnapML** (custom-trained model, runs on-device, no Lens Cloud) — separate research bucket.

**Source**: https://developers.snap.com/lens-studio/4.55.1/references/templates/interactive/scan [STALE URL; template current]

**Confidence**: official-docs

---

## E — Commerce / Try-On

### E-1 — "I want a sunglasses / eyewear try-on lens"

**Intent**: Users virtually try on glasses — 3D model precisely tracked to nose bridge + ears.

**LS primitive(s)**: `Eyewear Try-On` template (Asset Library) + face tracking (built-in to template) + optional `Carousel` UI for multi-frame switching.

**Build approach**:
- Asset Library → `Eyewear Try-On` → Install + open; includes example glasses already positioned.
- Replace placeholder glasses mesh with own 3D `.fbx`/`.glb`; ensure model pivot is centred on nose bridge.
- Template requires "almost no coding" for basic replacement — adjust `Transform` (position/scale/rotation) in Inspector to fit.
- Multi-SKU try-on: add `Carousel` component (see E-5) that swaps between glasses child objects.
- Test with face tracking preview video; pair to device to verify on male + female face shapes.

**Performance notes**: Single face-tracking pass + simple 3D mesh — lightweight. Glasses mesh ≤5K triangles for best mobile performance.

**Common pitfalls**:
- Models with incorrect pivot (e.g., at world origin instead of nose bridge) float off-face — re-centre pivot before import.
- Default `Face Index = 0`; multi-face glasses need duplicating eyewear assembly with `Face Index = 1`.

**See also**: `3d-asset-import-doctrine.md` for GLB-first format priority and per-asset budgets.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/object/Try-On/eyewear-try-on [STALE URL; template current]

**Confidence**: official-docs

---

### E-2 — "I want a virtual makeup / lip gloss product try-on lens"

**Intent**: Users try on brand's actual cosmetic product — specific lipstick shade, eyeshadow palette — with brand-accurate colour.

**LS primitive(s)**: `2D Makeup Helper` Asset Library asset (same as A-2, used here for brand-specific colour matching) + colour picker tied to brand hex values in MakeupController.

**Build approach**:
- Follow A-2 build approach but replace colour values in `MakeupController` with brand's exact product HEX values.
- Multi-shade carousel: duplicate Makeup assembly per shade, disable all but first, wire tap cycling (D-1 pattern).
- Swatchable palette UI: Screen Image buttons per shade, each wired to Behavior script that sets Material Parameter on lip material to corresponding colour.
- Export project as `.lspkg` for team sharing while maintaining colour accuracy.

**Performance notes**: Same as A-2. Multiple stacked disabled makeup assemblies add zero runtime GPU cost (only enabled renders).

**Common pitfalls**:
- CMYK brand colour profiles MUST be converted to sRGB before LS — Photoshop → Export → Convert to sRGB, otherwise on-device colours look desaturated.
- Face Mesh UV mapping for lip tint shifts slightly between users due to varied lip shapes — test on 3+ diverse face types before client delivery.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates/makeup

**Confidence**: official-docs

---

### E-3 — "I want a foot / shoe try-on lens"

**Intent**: Users try on virtual shoes tracked to feet, with product carousel to switch SKUs.

**LS primitive(s)**: `Footwear Try-On` template (Asset Library, previously `Foot Tracking`) + `Foot Tracking` Custom Component + `Carousel` UI + `Shoe Controller` script.

**Build approach**:
- Asset Library → `Footwear Try-On` → Install; open from LS Home Page.
- Replace `[REPLACE_ME]` objects with shoe 3D models; ensure each shoe is oriented same way as provided example models.
- `Carousel` handles switching between shoes; add additional `[REPLACE_ME]` children under `Left Foot` and `Right Foot` per SKU.
- `Shoe Controller` script automatically wires Carousel selection to active shoe objects — no custom scripting for basic SKU carousel.
- Lower garment occlusion (included in template) visually hides foot below shoe for cleaner compositing.

**Performance notes**: Foot tracking runs separate ML from face tracking. Rear-camera heavier than front. For multi-SKU (3+), disable non-active shoe meshes completely to avoid overdraw.

**Common pitfalls**:
- Shoe models in wrong orientation appear rotated/backward on-foot — match example model axis orientation before export.
- Template's feet-removal occlusion masks natural foot — if brief requires keeping feet visible alongside virtual shoe, remove occlusion mesh manually.

**See also**: `body-anchored-calibration.md` and `lens-studio-api-gotchas.md` → "Try-On Pack Sneakers — Foot Tracking calibration" for the full empirical record from a Valtech RFSU project (geometry-scale-position-mirror sequencing, wrapper-anchor architecture, foot-specific verification protocol).

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/object/Try-On/foot-tracking [STALE URL; template current]

**Confidence**: official-docs (Valtech-validated for the foot try-on calibration specifics)

---

### E-4 — "I want a watch / bracelet / wristwear try-on lens"

**Intent**: AR accessories tracked to user's wrist — watches, bracelets, cuffs.

**LS primitive(s)**: `Wristwear Try-On` sample project (LS Home Page / Asset Library) + `Wrist Binding` Custom Component + `Left Wrist` / `Right Wrist` scene objects.

**Build approach**:
- Open `Wristwear Try-On` sample project from LS Home Page.
- Right-click + delete `Watch [TOGGLE_ME]` and `Bracelet [TOGGLE_ME]` default meshes; import custom 3D accessory model.
- Drag imported mesh as child of `Left Wrist` or `Right Wrist` (or both).
- Adjust Transform in Inspector to align around wrist — reference example mesh positions in docs.
- Multi-variant: multiple mesh children + tap-cycle script (D-1 pattern) to toggle.

**Performance notes**: Wrist Binding uses body/hand tracking for wrist estimation — moderate ML cost. Pair with Foot Try-On or other body tracking only after confirming RAM budget.

**Common pitfalls**:
- Custom meshes MUST be oriented same way as example Watch mesh — Wrist Binding places pivot at wrist centre, so model orientation relative to pivot is critical.
- Wrist tracking loses accuracy when wrist is near face or partially occluded — known ML model limitation, not config issue.

**Source(s)**: https://developers.snap.com/lens-studio/features/try-on/wristwear-try-on

**Confidence**: official-docs

---

### E-5 — "I want a catalogue/shopping lens connected to a product catalogue"

**Intent**: Commerce lens where product info (name, price, image, CTA link) updates dynamically from brand's product catalogue without republishing lens.

**LS primitive(s)**: `Shopping Template` (Catalog-Powered Lens, Sponsored Lens feature) + `Lens Product Cards` UI + Product Catalogue connection (configured in Ads Manager / Snap for Business).

**Build approach**:
- Download Shopping Template from `developers.snap.com/lens-studio/sponsored`.
- Template includes 3 example products on a surface with `Lens Product Cards` — pre-built swipeable product UI.
- Connect lens to Product Catalogue via Snap Ads Manager during submission — names/images/prices then update dynamically.
- Replace example surface 3D objects with brand-specific models/imagery; `Carousel` and `Product Cards` UI is pre-built.
- Configure `True Size Object` scaling if physical size accuracy matters.

**Performance notes**: Catalogue-connected lenses require network fetch on load for product data — design loading state. 3D surface objects are main polygon budget concern.

**Common pitfalls**:
- Shopping Template is **Sponsored Lens only** — requires Ads Manager account + associated Product Catalogue. Cannot be used as organic public lens. See `sponsored-lens-submission.md`.
- `True Size` tracking (LiDAR / Multi-Surface) falls back to basic Surface on older devices — product may appear non-true-scale on non-LiDAR Android.

**Source(s)**: https://developers.snap.com/lens-studio/sponsored/sponsored-lens-templates/shopping/surface-objects

**Confidence**: official-docs

---

## F — Brand / Sponsored Lens Specifics

### F-1 — "I want a branded face filter with a prominent logo overlay"

**Intent**: Face filter (makeup, retouch, or distortion) with brand logo clearly displayed — satisfying Sponsored Lens branding requirement.

**LS primitive(s)**: Any face filter assembly (A-1 through A-7) + `Screen Image` for logo (Ortho Camera layer, safe zone placed) + Render Order management.

**Build approach**:
- Build core face filter (e.g., A-2 Makeup or A-3 Hair Color) as primary effect.
- Import brand logo as PNG with transparency; add `Screen Image` under Ortho Camera.
- Position logo in safe zone (top or lower-mid screen, avoiding Snap's capture button area).
- Set Screen Image Render Order to value higher than all other Ortho Camera objects to prevent it from being covered.
- Confirm logo visible throughout FULL lens experience, not just at start — Snap Ads Manager rejects otherwise. See `sponsored-lens-submission.md` → "Brand name or logo MUST be visible".

**Performance notes**: Screen Image logo is essentially free — single textured quad. Keep logo PNG ≤256×256 px at 2× resolution.

**Common pitfalls**:
- Logo outside safe zone occluded by Snap system UI (capture button, chat field) on certain screen sizes — test on iPhone + mid-screen Android.
- Transparent-background PNG with pre-multiplied alpha shows dark fringe on some blend modes — use `Straight Alpha` export from Illustrator/Photoshop.

**Source(s)**: https://developers.snap.com/lens-studio/publishing/optimization/performance-optimization-guide

**Confidence**: official-docs

---

### F-2 — "I want a branded particle ambience lens with the brand's colour palette"

**Intent**: GPU Particles Effects Pack recoloured to brand colours — golden sparkles, brand-red embers — placed behind user as premium brand atmosphere.

**LS primitive(s)**: `GPU Particles Effects Pack` Asset Library asset + `Portrait Particles` template (if face-forward) + Shader Graph (recolour particle material via gradient/colour parameters).

**Build approach**:
- Follow B-4 build approach; select preset (sparkles or bouquet work well for luxury feel).
- In particle material's Shader Graph, find `Gradient` or `Color` parameter node; adjust gradient stops to brand hex values (sRGB).
- For `Portrait Particles`: assign brand logo as header texture, brand tagline as footer text via `PortraitParticlesController [EDIT_ME]` Inspector.
- Add `Post Effect` colour grade (LUT-based) in `PortraitParticlesController` to push colour temperature toward brand identity.
- Add logo Screen Image (F-1 pattern) to satisfy Sponsored Lens branding.

**Performance notes**: Same as B-4. Recolouring via Shader Graph parameters adds no runtime cost. LUT post-effects add single full-frame texture sample — negligible.

**Common pitfalls**:
- Modifying particle colour directly in texture (not via Shader Graph parameter) bakes the gradient — future brand-palette updates require texture re-import instead of script/parameter adjust.
- Particles behind user (world-depth) render on Perspective Camera, logo overlay on Ortho Camera — confirm Render Layers correctly set to prevent z-fighting.

**Source(s)**: https://developers.snap.com/lens-studio/features/graphics/particles/gpu-particles/gpu-particles-templates/particles

**Confidence**: official-docs

---

### F-3 — "I want a branded countdown lens for a product launch campaign"

**Intent**: Standard countdown (D-3) enhanced with brand fonts, colours, logo, possibly post-launch reveal state (product image or CTA).

**LS primitive(s)**: `Countdown` beginner template (same as D-3) + `Screen Image` for logo (same as F-1) + `Fullscreen` template or state machine for post-launch reveal.

**Build approach**:
- Open `Countdown` template; disable default hat/glasses; replace countdown text colours with brand hex values.
- Import brand font as `.ttf` via Asset Browser → Import Files; assign to countdown text objects.
- Add logo Screen Image (F-1 pattern) above countdown text in Render Order.
- Second scene state (enabled after countdown reaches zero) via `Fullscreen`-style approach: `Screen Image` showing product reveal, enabled by `CountdownController` script when countdown completes.
- For Sponsored Lens: add CTA text ("Shop Now") in post-reveal state; confirm against branding-only-no-competing-platform rule. See `sponsored-lens-submission.md`.

**Performance notes**: Same as D-3. Post-reveal image adds one Screen Image — trivial cost. Keep total lens <4 MB for Sponsored Lens reach optimisation.

**Common pitfalls**:
- Custom `.ttf` fonts MUST be embedded in lens (not linked) — confirm font is included in exported `.lspkg`; missing fonts fall back to LS default silently.
- `CountdownController` triggers reveal on client's local device clock — for fixed campaign launch time, set date field to fixed future UTC timestamp and brief against timezone ambiguity.

**Source(s)**: https://developers.snap.com/lens-studio/4.55.1/references/templates/face/countdown [STALE URL; unchanged]

**Confidence**: official-docs

---

### F-4 — "I want a brand identity integration pattern (logo on a 3D mask / face object)"

**Intent**: Brand imagery integrated into face mask or 3D head attachment — brand mark becomes part of face experience rather than static 2D overlay.

**LS primitive(s)**: Face Paint / Face Mask (A-7) for 2D brand texture mapped to face UV, OR `Face Expressions` + 3D branded object (hat, badge, halo anchored to head), OR `Face Stickers` template (2D images at face landmark points).

**Build approach**:
- 2D brand-on-skin (logo tattooed on cheek): use A-7 Face Paint — paint brand mark onto face UV template in `Eye` or `Full` artboard.
- 3D branded head object: `+ → Face → Head Binding`; parent 3D branded prop (hat, halo, crown) to head binding. Adjust position/scale to match head.
- Branded face stickers at landmarks: Asset Library → `Face Stickers` → Install; places 2D images at any LS landmark point (eyebrow, chin, cheek, etc.).
- Expression-driven brand reveal (mark appears on smile): combine Face Paint or 3D prop with A-5 expression trigger.
- Apply A-1 Face Retouch underneath for premium brand feel.

**Performance notes**: 3D head-attached objects very lightweight (face tracking pass already running). Multiple face stickers accumulate draw calls — keep total ≤10.

**Common pitfalls**:
- Brand logos on face UV that include text appear MIRRORED on user's face unless text is pre-mirrored in Photoshop artboard (face camera mirrors left/right).
- `Face Stickers` template is 4.x legacy in Asset Library — in LS 5.x, verify no `TurnOnEvent` or `AnimationMixer` deprecation warnings on import. See `deprecated-api-migration.md`.

**Source(s)**: https://developers.snap.com/lens-studio/features/ar-tracking/face/face-templates/face-paint + Face Stickers template

**Confidence**: official-docs

---

## Adding new recipes

When a Valtech project ships using a pattern not yet in this catalog, add it here with:

1. **Recipe name** — natural-language intent ("I want X")
2. **LS primitive(s)** — exact 5.x names + Asset Library install path
3. **Build approach** — 3-5 sentences, concrete steps in order
4. **Performance notes** — perf implications + cost vs alternatives
5. **Common pitfalls** — what tripped you up the first time
6. **Source(s)** — Snap docs URL where applicable
7. **Confidence** — official-docs / community-tutorial / valtech-validated
8. **Validated** — project name + date if Valtech-validated

Promote research-validated recipes to **valtech-validated** confidence once shipped successfully.
