# Composition Patterns — architecture-level recipes for Lens Studio 5.x

Where `lens-recipe-catalog.md` covers ~50 named **single-feature recipes** ("I want a sunglasses try-on"), this file covers the **architectural patterns** that compose those features into novel lens designs. Use this when a client brief doesn't decompose cleanly into one named recipe — when it needs camera passes, screen-space effects, paint accumulation, ML-driven materials, or other multi-system compositions.

Compiled 2026-05-27 from Snap Lens Studio official docs + Perplexity research on Lens Studio 5.21 system boundaries. Treat as research-validated patterns; verify the first build of each pattern in a real project and add `**Validated:**` lines as evidence accumulates.

## How the agent should use this file

1. **At brief intake (Phase 0)**: after checking `lens-recipe-catalog.md` for a named recipe match, scan this file for the architectural pattern(s) the brief implies. Briefs often compose multiple patterns — a "music-reactive paint-on-face lens" combines Interactive Paint + Material Driven by Tracking + VFX From Script State.

2. **At spec drafting**: use the matched pattern's **Anatomy** section as the starting outline for `TECH-SPEC.md` — it lists the scene hierarchy, components, render-target wiring, and script ownership you'll need.

3. **At Phase 2 scripting**: each pattern's **Editors involved** line tells you whether the build is code-heavy (TypeScript), graph-heavy (Material Editor / VFX Editor), event-heavy (Visual Scripting), or a mix. Plan agent ownership accordingly.

4. **At Phase 4 (DoD)**: the **Common pitfalls** sections are your pre-submission checklist.

## The 8 patterns

1. Multi-pass render target chain
2. Full Frame Effect (screen-space post-processing)
3. VFX driven by script state
4. Material driven by tracking data
5. Interactive paint / drawing
6. Tween-driven animation orchestration
7. ML / SnapML pipeline
8. Event-graph glue pattern

Patterns compose freely. A scrolling slot-machine reel (RFSU Fortune Lens reference) uses Tween Orchestration + a script-based clipping fallback because the documented Masking-component path failed empirically (see `lens-studio-api-gotchas.md` § "Masking Component does not visibly clip Text grandchildren in LS 5.21"). A paint-on-face brand activation uses Interactive Paint + Material Driven by Tracking. A music-reactive AR cape uses Material Driven by Tracking + VFX From Script + audio analysis from `audio-in-lenses.md`.

---

## Pattern 1 — Multi-pass render target chain

**Use when**: one camera must render an intermediate texture and another camera (or screen-space surface) composites that texture into the final image. Typical briefs:

- Region-based full-frame effects ("only stylize the background", "only blur the body")
- Painterly composites where one camera produces a mask and another composites it
- Picture-in-picture / mirror-style lenses (small camera preview inside main view)
- Stylized portals (camera into another scene mode + alpha-composite)

**Anatomy**:

- Source scene objects placed on a specific render layer.
- **Camera A**: renders to a `RenderTarget` texture asset instead of the screen. Its render layer is set so it only sees the source objects.
- **Camera B** (main / Orthographic): renders the final composition to the device screen. Higher render order than A.
- A `Screen Image` (or full-frame quad) under Camera B references the render target via its material's texture input. A graph material can sample that texture and combine it with the live camera, with masks, or with brand graphics.
- Optionally a TypeScript Script Component animates parameters on the composite material (transition strength, blend amount, brand-color tints).

**Editors involved**: Material Editor (composite shader), TypeScript (parameter animation), scene hierarchy + camera setup.

**Common pitfalls**:

- Camera render-order matters. Camera A must complete its pass before Camera B samples its render target — set `renderOrder` so A < B. Wrong order leaves Camera B sampling stale or empty data on frame 1.
- Render-target resolution defaults are not always what you want. For high-quality post-effects, set the target's resolution explicitly (e.g. 1024×1024 or device-aspect); for performance-bound branchings, dropping to half-resolution often looks the same but costs less.
- Render layers (`renderLayer`) act like bitmask filters. Forgetting to add Camera A's layer to the source object's layers leaves Camera A rendering nothing. Forgetting to *exclude* a layer from Camera B leaves the source object double-rendered (once in the target, once in final).
- Cameras with `clearColor.mode: None` inherit whatever was in the buffer — usually fine for compositing layers but produces garbage if the render target wasn't initialized.

**Why generalizable**: render-target chains are the foundation of most screen-space and region-stylized effects. Briefs that say "the background should look different" or "only the body should be in color" or "the camera preview appears inside a magic mirror" all decompose to this pattern.

---

## Pattern 2 — Full Frame Effect (screen-space post-processing)

**Use when**: the brief is fundamentally "apply a shader to the whole camera result". Typical briefs:

- Stylization filters: VHS, glitch, CRT, halftone, comic-book outline, oil paint, pixelization
- Colour grading: LUTs, vintage tints, brand-color tinting, day-to-night transitions
- Whole-screen bloom, blur, distortion, kaleidoscope
- Transition effects between effect states

**Anatomy**:

- A `Camera` outputs to a render target OR an LS-provided `Screen Texture` capturing the live camera result.
- A full-frame `Screen Image` (anchored to the full Orthographic Camera region) with a graph material that samples the screen texture, applies the effect logic, and outputs the modified result.
- The graph material's parameters (effect intensity, color tint, distortion amount, time-driven offset) are exposed in the Inspector and optionally driven by a TypeScript Script Component for runtime control (tap-to-toggle, gradual intensity ramp, music-reactive).

**Editors involved**: Material Editor (the heart — node graph defines the look), TypeScript (parameter animation, event-driven activation), scene hierarchy (full-frame Screen Image under the right camera).

**Common pitfalls**:

- Mistaking Full Frame Effect for VFX Editor: this is a per-pixel surface shader problem, not a particle problem. If your "effect" is many small visual elements moving over time, that's VFX. If it's a transformation of the whole screen each frame, it's Full Frame Effect.
- Screen-texture sampling has coordinate-system quirks: UV-flips, aspect-ratio compensation, and screen-vs-world spaces. Use the Material Editor's `Screen UV` source when the docs recommend it, not authored Mesh UVs.
- Performance budget: heavy screen-space shaders (multi-tap blur, large convolution kernels) tank FPS on mid-range Android. Keep tap counts low; bake LUT-style colour grades into a small texture instead of computing per-pixel.
- `Position From Depth` (LS 5.21+) enables depth-aware effects (fake fog, depth-based blur, parallax). Older LS versions don't have it; check the project's LS version before promising depth-based effects.

**Why generalizable**: any brief that uses words like "vintage", "stylized", "filtered", "cinematic", "glitch", "trippy", "retro" is asking for Full Frame Effect. It's one of the two highest-value patterns in this catalogue (with Multi-pass Render Target).

---

## Pattern 3 — VFX driven by script state

**Use when**: particles must respond to runtime values — game state, interaction state, tracking confidence, music intensity, brand event flags. The VFX graph itself can't know about user actions or external data; a script bridges that gap.

**Anatomy**:

- A VFX asset built in the VFX Graph Editor (see `vfx-graph-guide.md`) with **Parameter nodes** exposed in the Inspector for the values script will control (spawn rate, particle color, lifetime multiplier, force magnitude).
- A `VFXComponent` on a SceneObject referencing the VFX asset.
- A `Script Component` (TypeScript) with `@input` references to the VFXComponent. The script computes target parameter values from runtime state and pushes them into the VFX via the documented parameter API.
- Optional helper scripts (e.g. `SendDataToVFX` from the VFX template) that wrap the parameter API in a more ergonomic interface.

**Editors involved**: VFX Editor (graph authoring), TypeScript (runtime orchestration), Visual Scripting (optional event-glue for triggers like tap → burst).

**Common pitfalls**:

- VFX parameter API name and signature varies across LS versions. Verify the exact call against `Support/StudioLib.d.ts` for the project's LS version before claiming a contract. The script-side getter/setter pattern is documented but property names occasionally drift between minor versions.
- Forgetting to mark a graph parameter as **exposed** (green node) — it then can't be set from script. The graph compiles fine but script writes silently no-op.
- Performance: spawn-rate parameters driven by per-frame script can spawn many more particles than the artist designed for. Cap script-side before pushing. The performance optimization guide recommends `Particle (Kill)` and culling for spawn-rate-driven scenarios.
- Local vs world simulation space: VFX assets are authored in one space and behave differently in the other. If the script changes the host SceneObject's position, world-space particles trail behind cleanly while local-space particles teleport with it. Pick the right space when authoring.

**Why generalizable**: any brief where "particles should respond to X" — claps trigger sparkles, smiles spawn hearts, scores raise burst intensity, songs drive ember speed — is this pattern. Cross-reference `audio-in-lenses.md` for the audio-reactive variant and `face-effects-deep-dive.md` for expression-triggered variants.

---

## Pattern 4 — Material driven by tracking data

**Use when**: a material's appearance must change based on live tracking data — face landmark positions, body pose, hand position, segmentation masks, world surfaces. The material itself is static; tracking output is converted into material parameters per frame.

**Anatomy**:

- A `Tracking Component` (face, body, hand, head-binding, segmentation, world tracking) producing runtime values or output textures.
- A visual component (`MaterialMeshVisual`, `Image`, `Face Mesh Visual`, etc.) using a graph material with **Parameter nodes** exposed for the values the tracking should drive.
- A `Script Component` that reads tracking data per frame and writes derived values into the material's parameters. Or, where the tracking surface produces a texture directly (e.g. segmentation mask), the texture is wired straight into the material's texture input — no script needed in that simpler case.
- Optionally a `Custom Component` (Visual Scripting node) wrapping the script for designer-editable wiring.

**Editors involved**: Tracking components (data source), Material Editor (the consuming visual), TypeScript (data-to-parameter conversion). See `face-effects-deep-dive.md` for face-specific patterns and `body-anchored-calibration.md` for body/foot/hand tracking calibration.

**Common pitfalls**:

- Coordinate-space mismatches: face landmarks are in screen UV or face-mesh UV depending on which API you use. Material parameters expect specific spaces (object-space, world-space, screen-space, UV-space). Always convert at the script boundary.
- Tracking-confidence gating: when the tracker loses signal (face goes off-screen, hand leaves frame), feeding stale or zero values to the material produces visible glitches. Gate the script update on tracking confidence and either freeze the material state or fade it out.
- Segmentation textures are not necessarily binary 0/1 — they have soft edges. Materials that hard-threshold the segmentation lose the feathered edge; multiply or smooth-step instead.
- Face landmarks API: there are 93 landmark IDs (per `face-effects-deep-dive.md`). Hard-coding an ID without comment makes future maintenance impossible. Always document which landmark a script targets ("landmark 27 = right eyebrow inner tip").

**Why generalizable**: any brief where "the face/body/hand makes the visual react" or "the segmentation should drive the look" — face-paint that follows expressions, body-paint that follows pose, hand-driven distortion, segmentation-aware colour swap — is this pattern.

---

## Pattern 5 — Interactive paint / drawing

**Use when**: the user's touch input must accumulate into a persistent visual on the screen, the face, or a tracked surface. Typical briefs:

- Finger paint on selfie, brand-color paint on face
- Scratch-to-reveal coupon / mystery photo
- AR graffiti tagged on a wall surface
- Signature on the camera image
- Painterly reveals where touch paints the brand layer in over the camera

**Anatomy**:

- A `Touch Component` or `Tap Handler` captures screen-space input — typically via TypeScript using `createEvent("TouchMoveEvent")` and reading the touch position per frame.
- A `RenderTarget` acts as the "paint buffer" — a texture that accumulates strokes over time, never cleared until the user resets.
- A dedicated low-render-order **brush camera** draws stroke quads into the paint buffer. Each stroke is a Screen Image or quad with a brush-texture material, positioned at the touch coordinate, render-ordered to draw before the main camera. The brush camera's `clearColor.mode: None` so previous strokes persist.
- The **main camera** composites the paint buffer over the live camera result via a graph material on a full-frame Screen Image (see Pattern 2). The composite can use multiply, additive, or alpha-blend depending on the desired look.
- For face-anchored paint: replace the screen-space coords with face-mesh UVs from `face-effects-deep-dive.md`. The brush camera then paints into a face UV texture instead of a screen texture.

**Editors involved**: TypeScript (touch capture, stroke spawning), Material Editor (brush material + composite material), scene hierarchy + render targets + camera setup.

**Common pitfalls**:

- Touch-to-world mapping: `getScreenPosition()` returns normalized screen space but render-target UVs may need explicit aspect-correction. Test with strokes near screen edges to verify alignment.
- Stroke density vs performance: spawning a new SceneObject per touch frame builds up fast and tanks FPS within seconds. Pool stroke quads and reuse them, or use a single Screen Image whose `mainPass.baseTex` is updated to a fresh stroke each frame.
- Paint persistence: forgetting to set the brush camera's `clearColor.mode: None` wipes the buffer every frame and only the latest stroke shows. Conversely, never wiping it on reroll/reset leaves old paint visible on a new session.
- Brush texture authoring: hard-edged brushes look pixelated; use a soft alpha-feathered brush PNG with premultiplied-alpha blend on the brush material.

**Why generalizable**: any brief involving "user paints", "scratch to reveal", "draw on", "signature", "tag" is this pattern. It's currently the most-underrepresented capability in the skill — no recipe in `lens-recipe-catalog.md` covers it directly.

---

## Pattern 6 — Tween-driven animation orchestration

**Use when**: the brief wants polished animated transitions on transforms, colors, opacity, scale, or effect intensities, triggered by events or state changes. Not particles, not simulation — interpolated values over time.

**Anatomy**:

- A `Tween Manager` package (installed via Asset Library — see `lens-studio-api-gotchas.md` Tween Manager entries).
- `TweenScreenTransform`, `TweenAlpha`, `TweenValue`, `TweenTransform` script components configured in the Inspector with named tweens (`pack_split_L`, `note_fade_in`, `fortune_pop`, etc.).
- A controller `Script Component` that calls `tweenManager.startTween(sceneObject, "tween_name")` / `stopTween` / `resetObject` in response to events.
- Optional `TweenValue` with `callbackType: 2` ("Call API function") wiring a tween's animated value to a script-side setter (e.g. `setRotation`, `setSize`) for properties without a built-in tween component.

**Editors involved**: TypeScript (event handlers + tween orchestration), Inspector (named tween configuration), Visual Scripting optionally (event triggers).

**Common pitfalls**:

- `resetObject` on a `TweenValue` resets the internal tween float but does NOT invoke the callback function — so the target property (e.g. `Image.rotationAngle`) stays at its last value. After reset, write the property directly. Cross-reference `lens-studio-api-gotchas.md` for the full pattern.
- Image.rotationAngle persists across taps unless explicitly reset before each new tween — leads to "first frame flashes wrong direction" bugs.
- Easing choice has dramatic UX impact: Cubic Out is fast-at-start (good for slides), Cubic In is slow-at-start (good for builds), Exponential Out is the classic "slot machine wind-down" with most action late. Quartic In/Out gives gentle bell curves. Try multiple before committing.
- Multiple tweens on the same property race. If `pack_split_L` (anchors) and `rotation_L_v1` (rotation callback) both fire on tap, their start times and durations must be coordinated or the visual feels chaotic. Sync durations or stagger explicitly with `DelayedCallbackEvent`.

**Why generalizable**: nearly every polished commercial lens uses Tween orchestration for entrance/exit transitions, branded reveals, settle animations after recipe-driven triggers. The RFSU Fortune Lens reference uses ~15 named tweens in one controller.

---

## Pattern 7 — ML / SnapML pipeline

**Use when**: the brief requires inference output — segmentation masks, classification labels, generated textures, landmark points — that then drive visual elements. The ML system produces data; the rest of the scene consumes it.

**Anatomy**:

- An `MLComponent` or built-in tracking component that runs an inference model. Outputs are typically a texture (segmentation mask, generated content) or numeric values (classification result, confidence scores).
- A `Script Component` that reads the ML output and translates it into something the rest of the scene can consume — material parameters, scene-object enabled states, transform values, text content.
- Visuals (materials, VFX, scene objects) that consume the script-translated values per Pattern 4 (material driven by data) or Pattern 3 (VFX driven by script).

**Editors involved**: ML components (data source), TypeScript (orchestration), Material Editor (consumer), sometimes Tracking components and Asset Library models.

**Common pitfalls**:

- Model inference cost is per-frame and can dominate the FPS budget. For real-time ML (segmentation, face detection), use Snap's optimized built-in models — custom-trained SnapML models often need significant quantization/optimization before they hit 30 FPS on mid-range Android. See `performance-optimization-guide.md`.
- ML outputs are not always 0..1 normalized. Always check the model's documented output range before normalizing in script.
- Confidence gating: when the model is uncertain (low confidence), the output is noise. Apply temporal smoothing in script (`lerp` over N frames) to prevent jitter in downstream visuals.
- Lens Cloud-backed models are NOT permitted in Sponsored Lenses (Snap policy — see `sponsored-lens-submission.md`). For Sponsored briefs needing classification or detection beyond built-in models, the only path is on-device SnapML.

**Why generalizable**: emerging brief category — clients increasingly ask for "smart" lenses that recognise products, react to expressions, classify what the camera sees, or generate custom content. Pattern 7 is the architecture.

---

## Pattern 8 — Event-graph glue pattern

**Use when**: the brief is highly interactive but the per-event logic is simple — "tap to cycle effect", "blink triggers burst", "screen tap spawns object and plays sound", "smile shows brand badge". These are declarative event → action wirings, not stateful algorithms.

**Anatomy**:

- A `Script Component` referencing a `Script Graph` asset (Visual Scripting — see `visual-scripting-guide.md`).
- **Event nodes** as entry points: `Touch Event`, `Face Expression Event`, lifecycle events.
- **Action nodes** mutating scene state: enable/disable SceneObjects, set component properties, play audio, start tweens, send VFX parameters.
- Optional **Custom Nodes** bridging to script files for reusable logic that should live in source-controlled TypeScript (animations, calculations, complex state machines).
- Optional helper components (Behavior, Tap Handler, Interaction Component) wired through the graph.

**Editors involved**: Visual Scripting (the graph), TypeScript (for any Custom Nodes), scene hierarchy (the wired SceneObjects).

**Common pitfalls**:

- Choosing Visual Scripting when TypeScript would be cleaner. Visual Scripting is great for "event → action" chains and designer-readable flow. It's poor for state machines with many transitions, computational logic, async/promise patterns, or anything you'd normally want in version control as code. Mixing the two via Custom Nodes is fine; relying on Visual Scripting for complex logic is not.
- Custom Node API drift: when a Custom Node's script file changes its `@input` signatures, the graph can hold stale references. Re-import the Custom Node into the graph after the script changes its public surface.
- Touch events fire at framerate, not per-tap. For tap-only logic, gate on `TouchStartEvent` or use a Tap Handler component, not raw `TouchMoveEvent`.
- Event order is not always strictly deterministic across components. If two scripts depend on each other's lifecycle (one needs the other's `onAwake` to have run first), enforce order via explicit `setEnabled` toggles or a coordinator script — not by trusting LS to call them in hierarchy order.

**Why generalizable**: clients in workshops want to iterate behaviour live. A motion designer can adjust a Visual Script graph alongside the agent without a TS deployment cycle. Pattern 8 is what makes designer-editable handoffs possible.

---

## Pattern 9 — Trigger-bus with Behavior + Script Graph custom triggers

**Use when**: UI buttons, score systems, simple game rules, prototyping, workshop-style "wire things up live" interactions. The user wants no-code-feeling orchestration where buttons and scene events fire **named project-wide triggers** that any listener can react to.

**Anatomy**:

- Multiple `Behavior` components (Snap's official Behavior helper, installed from Asset Library) configured to **Send Custom Trigger** with a project-wide trigger name (e.g., `"button_pressed"`, `"score_changed"`).
- A `Script Graph` (Visual Scripting) with **Trigger Response** nodes that listen on those names and route to action nodes.
- Optional: small TypeScript controllers as Custom Nodes for state that grows beyond what's elegant in the graph.

**Editors involved**: Visual Scripting (the listener graph), Behavior components (the senders), occasional small TS for state.

**Why this is its own pattern (vs Pattern 8)**:
Pattern 8 is event → action wired DIRECTLY within one graph. Pattern 9 is a publish-subscribe bus where senders and receivers don't know each other — they only share the trigger name. This makes it easier to refactor (add a new listener without touching the sender) and easier for designers to extend (drop another Behavior with the same trigger name).

**Common pitfalls**:

- **Typo'd trigger names fail silently** — there's no compile-time check that a sender's trigger name matches a listener's. Recommendation: centralize trigger names in a single Markdown / constants doc the team can grep.
- **Out-of-order receiver execution** — multiple listeners on the same trigger fire in registration order. For ordering-dependent logic, chain triggers (`A` → fires `B` → fires `C`) instead of relying on registration order.

Source: Snap 5.x Visual Scripting + Behavior sample projects.

---

## Cross-references

- Named single-feature recipes: `lens-recipe-catalog.md`
- VFX-specific patterns + script API: `vfx-graph-guide.md`
- Material Editor node taxonomy + 5.21 changelog: `material-editor-guide.md`
- Visual Scripting node taxonomy + VS-vs-TS decision: `visual-scripting-guide.md`
- TypeScript decorator reference: `lens-studio-api-gotchas.md` § "TypeScript decorator family"
- Face-specific patterns: `face-effects-deep-dive.md`
- Body / foot / hand tracking calibration: `body-anchored-calibration.md`
- Audio-reactive specifics: `audio-in-lenses.md`
- Performance budgets per pattern: `performance-optimization-guide.md`
- LS Masking + Text limitation in 5.21 (forces script-clip fallback for scrolling Text): `lens-studio-api-gotchas.md`
- File format / automation reality: `editor-scripting-api.md`
