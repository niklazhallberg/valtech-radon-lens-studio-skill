# Body-Anchored Calibration — universal protocol for all tracker-driven content

**Scope:** ALL body-anchored or tracker-driven content in Lens Studio. Applies to foot-tracking, head-tracking, face-mesh, hand-tracking, full-body tracking, and world-anchors. Anywhere a tracker writes to a SceneObject reference each frame and your content needs to ride on that anchor.

**Status:** This is the *canonical* universal pattern. Body-part-specific findings (e.g., Try-On Pack Sneakers exact pivot offsets, head-tracker overwrite behavior) live in `lens-studio-api-gotchas.md` as applied sections that reference back here.

**First seeded:** 2026-05-13, from empirical learnings on a Sponsored Lens foot-AR-lens build (Phase 1 calibration).

---

## Why a universal protocol exists

Tracker-driven content has a deceptive failure mode: it works in Lens Studio Preview (no tracker ML runs in editor) and fails on real device (tracker overwrites mutations, mesh pivots are off-center, scale amplifies hidden offsets). Without a disciplined protocol, every body-anchored project rediscovers the same calibration pitfalls.

This file is the **memory** that prevents that rediscovery. Read it before *any* tracker-driven build, not just foot try-on.

---

## Mandatory probe-first protocol

For ALL body-anchored content, in this order:

### 0. Library-first sourcing

Before commissioning a custom 3D model OR proposing in-house Blender work: scan Snap Asset Library AND Snap-templates for body-part-relevant assets. If a serviceable asset exists, use it for at least Phase 1 scaffolding — switch to custom only when the library asset can't meet the brief's photo-real / brand-specific requirements.

**Why:** Custom modeling typically costs 1-2 days in-house to 1-2 weeks via commission. Library assets are immediate. A "perfect brand-specific photo-real" replaced by a "library placeholder" in Phase 1 does not slow the project — it accelerates it, because foot-tracking, calibration, and material/animation logic can be validated against the placeholder while real asset is sourced in parallel. The placeholder also de-risks the project: if the real asset is delayed, submission can fall back to the library version rather than slip.

**How to scan:**
- **Snap Asset Library** — search by body-part keyword ("foot", "head", "hand"), filter to 3D objects, look for "Try-On Pack" series and similar Snap-curated content packs.
- **Snap Templates** — when starting a new project, browse Tracking section ("Foot Tracking", "Head Binding", "Hand Effects"). Templates ship with a default content asset built-in.
- **Confirmed library assets per body part:** see per-body-part defaults section below (each section leads with the library-scan result).

**When to skip:** Library scan can be skipped only if the brief explicitly requires a photo-real brand asset from day 1 AND that asset is already in hand at project start. In all other cases, scan first and propose the library option as the Phase 1 default.

**Mentor framing (not optional):** Never present library-vs-custom as a hidden internal calculation. Surface the library option to the user explicitly, by name, with a one-line description of what it gives them and what it doesn't. Anti-pattern: launching into "I'll model a placeholder in Blender" without first reporting "Snap has a Try-On Pack with sneakers — that gets us shoes on feet today; we swap to your real asset in Phase 3."

### 1. Hierarchy walk FIRST

Before proposing any mutation: run `scene-graphql` query that outputs object names + IDs + localTransforms + components + script-wiring + REFERENCE properties at every level of the relevant subtree. Show the diagram to the user for visual confirmation before any mutation is proposed.

**Why:** Tracker scripts have anchor REFERENCES that determine which SceneObjects they write to each frame. You cannot reason about mutations without knowing which level of the hierarchy is the tracker's write target. Skipping this step produces mutations made on the wrong layer and wastes pair-tests.

### 2. Defensive component disable

Tracker-template prefabs (Try-On Pack, Snap Face Effects samples, Head Bindings, Hand Effects templates) often ship with **AnimationPlayer / ScriptComponent / Tween / Behavior** components on root nodes. These can be dormant (clip with 0 frames, empty script body) or active (autoplay tweens, behavior-triggered transforms). Either way, they're a potential overwrite source.

- Use `setEnabled(id: <component-id>, enabled: false)` — fully reversible, no risk of broken references.
- NOT `deleteComponent` — delete is destructive and can break dependent references.
- Do this BEFORE any geometry probe, so probe results aren't contaminated by an animation/tween writing to transforms.

### 3. Asymmetric experiment (paired-symmetry content only)

When content is paired left/right (shoes, earrings, rings, contact lenses, eyebrow makeup, gloves, wrist accessories):

- Mutate ONE side. Leave the other side as untouched control.
- The visible delta IS the evidence — no delta = hypothesis falsified, no guessing needed.
- Mirror to the other side ONLY after the first side's probes lock + user signs off on the visual.

**Does NOT apply to central content** (hats, masks, collars, necklaces, single-object scenes). For those, use:
- Toggle-and-revert: mutate → pair-test → revert → pair-test (compare before/after by memory).
- Before/after screenshots: capture device screen pre-mutation, mutate, capture post, compare.

### 4. Tracker-overwrite detection

Before assuming a property is yours to control: probe it on one side and pair-test.

- **If you see visible delta on device** → that property layer is yours to control.
- **If NO visible delta** → tracker overwrites that property each frame. Move to wrapper-anchor architecture (step 5).

Possible overwrite scopes (must be verified empirically per tracker — there is no public spec):
- Position only
- Position + rotation
- Position + rotation + scale (FULL transform overwrite)
- Individual properties via setProperty path

**Empirically confirmed:** Snap's Foot Tracking custom component (`0d0a080f-37d1-401d-be96-f14684516652`, asset name "Foot Tracking", part of Try-On Pack) overwrites FULL `localTransform` on its anchor references each frame. Setting scale or position directly on the SceneObject referenced by `leftFootAnchor` / `rightFootAnchor` produces zero visible delta.

### 5. Wrapper-anchor architecture (when tracker overwrites your target property)

The universal workaround. Introduces an empty intermediate SceneObject between the tracker reference and your content SceneObject. Tracker writes to wrapper; content (as child) preserves its own `localTransform` unaffected.

**Mutation sequence (3 steps, NOT atomic — read-back after each):**

1. `createSceneObject(name: "<DescriptiveAnchorName>", parentId: <TrackerParent-id>)` → empty container
2. `setParent(id: <Content-SceneObject-id>, parentId: <new-wrapper-id>)` → content becomes child of wrapper
3. `setProperty(id: <TrackerScript-Component-id>, propertyPath: "<anchorRefName>", value: <new-wrapper-id>, valueType: REFERENCE)` → re-wire tracker reference

**Read-back protocol:**
- After step 1: verify new SceneObject exists with correct parent.
- After step 2: verify content SceneObject is now child of wrapper (NOT child of tracker parent anymore).
- After step 3: verify tracker script's anchor reference points to wrapper, not to content directly.
- Then apply your content's `localTransform` (scale, position) — it now persists, because tracker writes to wrapper's transform each frame.

**Mirror to other side ONLY after first side's calibration locks + user signs off.**

### 6. Mesh-pivot awareness BEFORE scale mutations

Library, template, and asset-store meshes routinely have pivots NOT at the anatomical anchor point (foot-center, head-center, finger-base). The mesh's bounding box (AABB) tells you where the geometry actually sits relative to the pivot.

**Read FileMesh bbox via `asset-graphql`:**

```graphql
{ asset(id: "<FileMesh-asset-id>") {
    properties
  }
}
```

Look at `info.aabbMin`, `aabbMax`, `aabbSize`. Compute mesh-center offset from pivot:
- mesh-center.X = (aabbMin.X + aabbMax.X) / 2
- mesh-center.Y = (aabbMin.Y + aabbMax.Y) / 2
- mesh-center.Z = (aabbMin.Z + aabbMax.Z) / 2

If mesh-center is far from (0,0,0): pivot is OFF-CENTER. You'll need to apply a position offset on your content SceneObject to compensate.

**Pivot offset scales LINEARLY with scale:**
- Pivot 1cm off-center at scale 1× = 1cm visible displacement
- At scale 4× = 4cm visible displacement
- At scale 10× = 10cm visible displacement

A small pivot misalignment that's invisible at scale 1 becomes a calibration disaster at scale ≥ 2. **Always bbox-read before scaling beyond 1.5×.**

**Compensation formula:** to bring mesh-center over the pivot (and thus over the tracker anchor):

```
content_SceneObject.localTransform.position = -1 × scale × mesh-center-offset
```

Example: mesh-center at (26.65, 9.64, 9.19) in mesh-local coords, scale (4,4,4):
- Compensation: position = -1 × 4 × (26.65, 9.64, 9.19) = (-106.6, -38.56, -36.76)
- Note: Y compensation should usually be SKIPPED because mesh-local Y=0 typically aligns with sole/floor (anatomically correct) — only compensate Y if the bbox shows the mesh is centered around Y=0 rather than rising up from Y=0.

**Important: bbox-center is a starting estimate, not an exact value.** Use `-scale × aabbCenter` as starting compensation, then expect to fine-tune by 10-30% based on first pair-test. Reasons:

1. **AABB measures geometry extent**, including outliers (loose tessellation, decorative geometry far from the visual "body" of the asset). The geometric centroid can bias away from the visual center.
2. **The actual pivot in the source FBX** may be at an authored landmark (heel-tip, bbox-corner, model-origin in DCC tool, character-rig joint) that doesn't equal the geometric centroid.
3. **The mesh-local axes** may not align 1:1 with the body-part anatomical axes; e.g., the "length" of a shoe mesh might be along local X, Y, or Z depending on the FBX export convention.

**Practical implication**: Expect the first probe with bbox-formula values to put the content "in the right neighborhood" but not at final position. Iterate empirically from there. Document the *delta* between formula value and empirical value as part of the calibration record — it's the asset's pivot-bias signature.

### 7. Geometry before material — placement before cosmetics

Lock scale → position → mirror FIRST. Material color, brightness, tint, hue, roughness, metallic are all cosmetic and can only be judged in the correct visual context (shoe sitting on foot, hat sitting on head, ring sitting on finger).

**Why:** Tuning material before geometry produces (a) judgments made in the wrong visual context, (b) risk of accepting bad color because you can't separate "wrong material" from "wrong placement", and (c) wasted pair-tests if geometry probes later force a structural rebuild via wrapper-anchor.

The same principle generalizes to all visual hierarchy:
- Shape before color
- Layout before typography
- Position before animation
- Structure before polish

### 8. ⌘S handshake

After EACH successful probe-pair-test cycle, pause and ask the user to `⌘S` (or Ctrl+S) in Lens Studio. MCP mutations are in-memory-only; ⌘S persists to disk. Critical before any commit, version-control snapshot, or cross-session reload.

---

## Tracker anchor placement ≠ mesh pivot location

A common but easily-overlooked failure mode: the tracker writes its anchor at anatomically-correct positions (foot-center, head-center, finger-base), but first-party content assets (Try-On Pack, Head Bindings, Hand Effects templates) ship with mesh pivots at FBX-origin — which is rarely at the anatomical anchor point.

**Symptom**: Inpainting / removal pipeline produces *visually perfect* foot/face/hand removal (the tracker visibly knows where the body part is), but virtual content renders at offset from where it should sit.

**Diagnosis**: This is NOT a tracking bug. The tracker is doing its job correctly. It is **mesh-pivot offset** — the FBX's authored pivot point isn't at the anatomical anchor point the tracker writes to.

**Why this matters**: It changes your debugging direction. If you assume "tracking is wrong", you waste time inspecting the tracker script (often sealed `.lsc`, internal logic not inspectable) or re-wiring anchor references that are already correct. The fix is content-side compensation, not tracker-side.

**Cure**: Read the FileMesh bbox via `asset-graphql`. The mesh-center offset from (0,0,0) tells you how much position-compensation to apply on a wrapper-child SceneObject (see step 5 of probe-first protocol above).

**Universal**: Applies to any tracker pipeline + first-party / library content. Foot tracking, face mesh, head binding, hand tracking, full-body tracking. The two pipelines (tracker → anchor write, asset → mesh pivot) are independent and rarely co-author the same anatomical reference point.

---

## Desktop LS Preview limitations for tracker-driven content

For tracker-driven content (foot, face, head, hand, full-body, world-anchored), validation MUST happen on a paired phone via Preview Lens. Desktop LS Preview is NOT a reliable testbed regardless of input source.

| Preview input | Tracking ML runs? | Content renders correctly? |
|---|---|---|
| Still image | ❌ No | ❌ No virtual content visible |
| MP4 video | ⚠️ Partial (inpainting / removal pipeline runs) | ❌ Content rendering unreliable |
| Live desktop camera | ⚠️ Limited (depends on body-part + camera quality) | ⚠️ Unreliable |
| **Phone (paired Preview Lens)** | ✅ Full | ✅ Full — **single source of truth** |

**Rule**: For ALL body-anchored content, validate calibration ONLY via phone pair-test. Desktop preview is useful for:
- Scene-graph inspection
- Asset import + verification
- MCP mutation verification (was the value stored correctly?)
- Component property inspection

Desktop preview is NOT useful for:
- Visual ground truth of tracker-driven content placement
- Material judgment in tracker-anchored visual context
- Calibration sign-off

**Practical implication**: Build your iteration loop around in-memory MCP mutations streaming to a phone-paired Preview Lens session (see "Real-device pair-test workflow" below). Desktop preview is a debugging tool, not a validation tool.

---

## Per-side wrapper positions create asymmetric visual displacement

For paired-symmetry content (left/right shoes, earrings, rings), the tracker writes each side's anchor to its own world position. When wrapper-anchor architecture is in place with identical position-offset values on both children, both sides move by the **same amount in world space** — but the visual result can appear **asymmetric** depending on the magnitude of the offset relative to the body's center.

**Example mechanic**:
- Left wrapper at world position (-A, 0, 0) (left side of body)
- Right wrapper at world position (+A, 0, 0) (right side of body)
- Both children with same `position.x = +B` offset
- Result: left content at (-A + B, ...), right content at (+A + B, ...)
- If B is small relative to A: both contents shifted slightly to the right of their respective anchors → symmetric translation → looks like "both displaced right"
- If B is large enough to overlap body center: left content moves toward body center while right content moves further outward → **asymmetric visual displacement**, even though the world-translation is symmetric per side

**Diagnostic value**: If the user reports paired content displaced *symmetrically* (both same direction), your compensation is on the right axis but magnitude is partial. If they report *asymmetrically* (e.g., left toward center, right outward — or vice versa), you have a large under-compensation. Both are evidence the wrapper-architecture is working correctly — the tracker is writing per-side world positions independently.

**Cure**: Increase compensation magnitude until mesh-center cancels the mesh-pivot offset, at which point both contents land on their respective anchors simultaneously and asymmetry resolves.

**Universal**: Applies to any paired body-anchored content where the tracker writes per-side anchor world positions independently.

---

## Control-lifespan in asymmetric experiments

The asymmetric-experiment pattern (step 3 of probe-first protocol above) uses one side as a control to make the visual delta unambiguous. The control side is **essential only until two proofs land**:

1. **Layer-control proven**: the property layer you mutated is yours to control (delta visible on device vs untouched control).
2. **Wrapper-isolation proven** (if wrapper-anchor was needed): the wrapper successfully isolates your content from tracker overwrites.

Once both proofs land, the control becomes **noise**, not signal. Specifically:

- The un-mutated control side renders at a different (often visually-broken) state.
- It obstructs your visual judgment of the calibrated side ("is the calibrated side good? hard to tell when the other side is visually weird").
- Extending the control lifespan past these two proofs actively slows iteration.

**Rule**: As soon as both proofs land, **mirror the wrapper-architecture to the control side** with the same starting values. Value-tuning then proceeds in parallel on both sides. This is not premature mirroring — it's appropriate timing.

**When to keep control alive longer**: only if there's a third hypothesis still being tested (e.g., does the tracker treat left vs right anchors identically?). In practice, this is rarely needed — the wrapper-mirror itself tests left/right tracker behavior.

**Universal**: Applies to any paired-symmetry content build.

---

## Calibration tuning order — tune at target scale, not probe scale

When scale needs tuning AFTER probes confirm layer-control + pivot-compensation direction: **tune at target scale, not at probe scale**. Pivot-compensation is scale-dependent.

**Why**:
- Pivot-compensation formula: `position_offset = -scale × mesh-center-offset`
- Position offset and scale are coupled — if you tune scale, the optimal position offset changes proportionally
- Tuning placement at probe-scale 4× then changing to target-scale 2× invalidates the placement values (now under-compensated by 50%)

**Working order**:
1. Establish layer-control with ANY working scale (use the scale that makes the visual delta unambiguous — often higher than target).
2. Switch to target scale BEFORE fine-tuning final placement values.
3. Compute pivot-compensation at target scale.
4. Fine-tune X/Y/Z values empirically on top of the target-scale baseline.

**Anti-pattern**: Iterating placement values at probe scale, then once perfect, switching to target scale and discovering placement is now wrong. Re-tune-from-scratch.

**Universal**: Applies whenever calibration involves both scale AND position-offset compensation (mesh-pivot offset scenarios — common for first-party / library content assets).

---

## Visual judgment requires correct visual context

User observations are in **screen-coordinates** — what the user sees on their phone, looking down at feet, up at head, or whatever orientation the body-part requires. World-coordinates (Lens Studio scene space) and mesh-local coordinates (the FBX/asset's own coordinate frame) are *different* reference frames, connected to screen-frame through:

1. The tracker's rotation matrix (rotates mesh-local → world based on detected body-part orientation).
2. The user's body orientation in physical space (rotates world → world-from-user's-perspective).
3. The phone's camera orientation (projects world-from-user → screen-frame).

These three transformations stack. A mutation in mesh-local +X can appear anywhere on screen depending on how the user is holding their phone and how their body is oriented.

### Implications for mentor-agent behavior

1. **NEVER predict which screen-direction a mesh-local mutation will appear in.** Probe + observe. Reasoning ahead-of-empirics about "this offset will look like X on screen" is a trap — the rotation chain has too many degrees of freedom to predict reliably.

2. **Pair-test questions must be framed in screen-space**, never in coord-axis names.
   - ❌ "Ser du en X-offset?" / "Has the Z-position changed?"
   - ✅ "Ser du vänster sko åt sidan av foten?" / "Is the shoe in front of, behind, or to the side of the foot?"
   - The user is reporting from screen-coordinates. Translate to coord-axes on your side; don't push the translation work onto the user.

3. **Camera angle matters for calibration validity.** Pair-test in *typical user-position* (~30-45° down for foot, ~chest-level distance for hands, head-on for face), NOT in stress-test extremes like rakt-nedåt-only.
   - A lens perfectly calibrated for `rakt-ned` view can fail in normal use.
   - Default user pose is what the lens must look correct in. Edge poses (extreme angles, very close, very far) are stretch-validation, not the calibration target.

4. **Document the calibration camera-pose** alongside numeric values. "Shoe scale 2.5 at pivot offset (-50, 0, -15)" without context is incomplete — the calibration is only valid relative to the pose it was validated in. Capture: distance, angle, what the user was doing (standing, sitting, looking down).

5. **Assistant image-interpretation is unreliable for screen-coord judgments.** When the user sends an image + text reporting a visual delta, prioritize the text over the assistant's image read. When only an image is provided, explicitly verify the assistant's interpretation with the user before basing mutation decisions on it. Reason: vision can generally identify objects accurately but is unreliable for screen-coord directional judgments (is content displaced left vs right? toward center vs outward?). Probe values based on misinterpreted images waste pair-test cycles.

---

## Tracker confidence-tröskel för stabil anchor

> ⚠️ DEMO ENTRY — added 2026-05-14 to demonstrate skill-growth-flow.
> Not empirically verified. Safe to remove.

Body-trackers (foot, hand, face) exponerar ofta en confidence-value.
När confidence dippar under ~0.55 börjar anchor-position jittra
synligt även när trackern fortfarande "ser" body-parten.

**Defensiv guard-pattern:** disable visual content när confidence
< 0.6; re-enable när confidence stabilt över 0.65 i minst 200 ms.
Hysteresis-marginalen mellan 0.6 och 0.65 undviker flicker.

**Gäller per body-part:** foot (Try-On Pack), hand, face mesh.
Världs-tracking har annan stabilitet-modell — skippa.

---

## Real-device pair-test workflow

### In-memory streaming via Preview Lens pairing

MCP `scene-graphql` and `asset-graphql` mutations stream LIVE to active Preview Lens sessions on device. No re-pairing required between probes; in-memory changes propagate to phone within ~1-2 seconds of mutation.

- User can pair-test rapidly between probes without QR-rescan.
- Probe → read-back → user pair-tests on device (already paired) → reports → next probe.
- Iteration cycle: ~30-60 seconds per probe-test loop in practice.

**Exception:** ⌘S is still required to persist mutations to disk for cross-session reload. In-memory streaming does NOT save the project file. If you want the calibration to survive Lens Studio restart, ⌘S after each successful probe-pair-test cycle.

### Pair-test ask pattern (mandatory structure)

NEVER just say "pair-test now". ALWAYS include four elements:

1. **WHY** — what hypothesis is being tested. "Detta testar om position-offset persisterar i wrapper-child eller om tracker:n också skriver position på child-nivå."
2. **WHAT to look for** — specific screen-space visual signal. "Är vänster sko nu på (eller nära) foten? Eller är den fortfarande lika långt bort som tidigare?"
3. **Specific question to answer** — explicit binary or short-answer question, not open-ended observation.
4. **Reassurance that iteration is normal** — both outcomes (success and failure) are useful information. Iteration is the norm, not the exception. Failure is the protocol working, not the user doing something wrong.

### Probe transitions

Between probes, briefly acknowledge what was just learned BEFORE moving on. Don't barrel forward silently.

- ❌ Immediately after pair-test success: "Probe-4 next."
- ✅ "Bra fynd — wrapper-arkitekturen håller, scale persisterar. Det betyder vi äger geometry-layern. Probe-3 (position) kommer nu, samma princip."

### Setback handling

Tracker overwrites, mutations rejected, unexpected device behavior: NEVER blame the user, NEVER blame the tooling. Normalize, explain in plain language, reassure next step exists, show next step clearly.

- ❌ "Mutation failed — tracker overwrote it."
- ✅ "OK, så tracker:n skriver över scale varje frame — det är faktiskt det vanligare beteendet, nu vet vi det. Probe-4 (wrapper-arkitektur) är planerad just för det här fallet. Vi byter rute. Ingen tid förlorad, vi lärde oss något konkret."

### Celebrations

Explicit acknowledgment when probe confirms a hypothesis. Don't move silently past wins.

- "Vänster sko är dubbelt så stor — vi äger scale-lagret. Det betyder probe-4 kan skippas."
- "Position-offset persisterar — wrapper-arkitekturen håller hela vägen. Vi kan nu mirror till höger."

---

## Per-body-part defaults

Filled in empirically over time as projects discover the per-body-part specifics. Each section here should reference back to the foot-section in `lens-studio-api-gotchas.md` (for foot) or its equivalent (for other body parts) for exact values and IDs.

### Feet (Try-On Pack Sneakers + Foot Tracking custom component)

**Library-first scan result for feet (as of 2026-05-13):**
- ✅ **Try-On Pack Sneakers** (Snap Asset Library) — low-poly sneaker prefab. Ships with `shoe_mesh_l` + `shoe_mesh_r` + 3 pre-made colorways (default white, sneakers_blue.mat, sneakers_red.mat). Generic silhouette, not brand-specific. **Suitable for:** Phase 1 scaffolding, calibration validation, tap-through animation logic, fallback submission. **Not suitable for:** final submission requiring photo-real brand-specific shoe.
- ✅ **Foot Tracking template** (Snap Templates → Tracking) — starter project with the Foot Tracking custom component pre-wired to default placeholder shoe. Use when starting a foot project from scratch instead of importing pieces separately.
- ➡️ **When brand-specific shoe is needed for final submission:** source/commission the real asset AFTER Phase 1 scaffolding validates calibration with the library placeholder. Real-asset swap happens in Phase 3 polish; no calibration work is wasted because mesh-pivot offsets are asset-specific and re-probed against the real mesh anyway.

Empirical findings for the Snap-supplied Try-On Pack Sneakers + Foot Tracking custom component (applies to any project using these assets):

- **Tracker overwrite scope:** FULL transform (position + rotation + scale) on `leftFootAnchor` / `rightFootAnchor` references. Wrapper-anchor mandatory for any property control.
- **Mesh-pivot:** FileMesh has pivot at (0,0,0). AABB extends X: 19.74→33.56 (mesh entirely +X of pivot, 26.65 sideways offset from center), Y: 0→19.27 (sole sits at pivot Y — anatomically correct for floor-alignment), Z: -6.99→25.38 (pivot near heel-end). Bbox-formula `-scale × bbox-center` under-compensates X by ~15-20% empirically; real pivot slightly inside the mesh.
- **Tracker anchor Y-position:** ~40 LS units above floor (ankle level, NOT sole). Y=-40 compensation needed to drop shoe-sole to floor at typical scales 2-4×.
- **Typical scale needed:** 2-4× (depends on real foot size vs default mesh size).
- **Default material:** DefaultMtl baseColor at `passInfos.0.baseColor = (0.4, 0.4, 0.4, 1)` — 40% gray, NOT white. Both shoes share material instance.
- **Pre-made colorway alternatives:** sneakers_blue.mat (textured blue), sneakers_red.mat (textured red) — see `lens-studio-api-gotchas.md` foot section for asset IDs.
- **Detailed application:** see "Try-On Pack Sneakers — Foot Tracking calibration" section in `lens-studio-api-gotchas.md`.

### Head / face

TBC — fill in when the first head/face-tracking project hits the same pattern. Expected findings to validate:
- Does face-mesh tracker overwrite full transform on Head Binding anchors?
- Are sample face/head-content meshes pivoted at face-center, eye-line, or off-center?
- Typical scale for head-worn accessories (hats, glasses, headphones)?

### Hands / fingers

TBC — fill in when the first hand-tracking project hits the pattern. Expected findings:
- Does hand-tracker overwrite per-finger anchors or per-hand anchor?
- Ring-mesh pivot conventions (finger-base, ring-center, finger-tip)?
- Typical scale for ring/watch/glove content?

### Full-body / upper-body

TBC.

### World-anchored (non-body) content

Partial applicability — wrapper-anchor and mesh-pivot awareness still apply for world-tracker overwrite behavior. Camera-frame discipline differs (no body-part rotation chain to track). Section to expand if a world-tracking project ships.

---

## When to read this file

- **Project kickoff:** read FIRST before proposing any architecture for tracker-driven content. The protocol determines the build sequence.
- **First device test:** read AGAIN before interpreting first-device pair-test results. The setback-handling and celebration patterns shape how you respond.
- **Any unexpected calibration result:** read the relevant section (overwrite-detection, pivot-awareness, visual-judgment) before diagnosing — the framing usually clarifies what the symptom means.
- **New body-part project:** read top-to-bottom, then check the per-body-part section for existing findings. If TBC, plan to seed it empirically during the build.

---

## Cross-reference

- `lens-studio-api-gotchas.md` — body-part-specific empirical findings (foot, head, hand sections that reference back here for protocol).
- `phase-progression.md` — Phase 1 final-checkpoint integrates this protocol as mandatory before any UI/animation/polish work begins.
- `voice-and-pedagogy.md` (planned v0.7.0) — mentor-tone application of the pair-test/setback/celebration patterns above.
