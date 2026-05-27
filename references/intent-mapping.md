# Intent mapping — natural-language brief → concrete LS primitive

This file maps the natural-language phrases colleagues use ("clickable thing", "blurry background", "audio-reactive countdown") to the actual Lens Studio primitives the agent should reach for. Use as a fast-pass detector during brief intake (Phase 0) and feature requests during Phase 1–3.

**Critical**: this is a knowledge bank, not a literal pattern-match table. Colleagues will phrase intents in their own words. The agent must DECOMPOSE briefs into primitives the table can cover, not refuse based on "no exact match".

---

## Workflow

1. Detect intent from the user's natural language during build phases (Phase 1–3).
2. Map to a concrete feature / primitive using the table below — **loosely**, not literally.
3. Confirm with the user before installing or scripting. Wait for explicit yes.

---

## Decomposition principle — why this isn't pattern-matching

Most briefs phrase intents in their own words: *"something that hovers next to the eyes"*, *"a logo that lights up when you smile"*, *"audio-reactive countdown"*. Most won't have an exact named recipe or table row. That's expected — and the agent must NOT refuse based on "no exact match". Instead:

1. **Decompose** the brief into primitives the references DO cover. "Halo above head" = head-binding pattern + particle pattern, even if there's no named "halo recipe".
2. **Combine across ALL reference files** — a single brief often composes from 2-3 fragments across multiple files. Every file in `references/` is part of the parts-bin.
3. **For novel briefs, actively scan `references/` before answering.** Don't limit yourself to files explicitly named here — use `ls references/` or grep across the folder when the brief doesn't obviously map to a known file. The directory is the source of truth, not this file.
4. **Propose the composition like a mentor, not a librarian.** Speak about the lens in plain language — describe what the user will experience. Do NOT expose internal recipe IDs ("D-12", "B-4"), do NOT status-report on agent knowledge ("I don't have a recipe for X but I can combine Y + Z"), do NOT pile multiple technical caveats at intake. Bring constraints (Sponsored-vs-organic, Lens Cloud restriction, IP risk) **only when actionable** — typically in spec drafting or asset planning, not in the first response to a brief. See `references/voice-and-pedagogy.md` → principle 3 worked example "novel-brief composition (the mentor tone, not the librarian tone)" for canonical phrasing.
5. **Flag novelty honestly**: a composed solution isn't yet valtech-validated. Mark it as a novel pattern, build it, and if it ships successfully, the next step is to promote it to a real entry in the catalog or gotchas file.

---

## Worked example of cross-file composition

A colleague says: *"I want a Sponsored Lens for a sports brand where the user's face becomes the team mascot, with branded particles, beat-synced to the team's anthem."*

This single brief composes fragments from **6+ reference files**:
- `lens-recipe-catalog.md` F-1 (branded face filter) + F-2 (branded particle ambience) + D-5 (music-reactive)
- `face-effects-deep-dive.md` Face Swap (mascot transformation) + IP risk flag
- `bitmoji-integration.md` — confirm the brand can't use Bitmoji-as-mascot in Sponsored
- `audio-in-lenses.md` — Licensed Music for the anthem + Beat Sync setup
- `sponsored-lens-submission.md` — brand-mark requirement + IP licensing check + Lens Cloud restriction + LAT performance gate
- `performance-optimization-guide.md` — Face Swap real-time-mode perf cost + texture sizes + Phase 4 DoD checklist

No single file has the full answer. The agent's job is to assemble.

---

## Intent → feature map

| Natural-language intent | Concrete LS primitive / feature | Notes |
|---|---|---|
| "clickable thing / button / tap target" | `Button` v1.0.1 (Asset Library install) | Easy Lens Button label maps here; see `lens-studio-api-gotchas.md` for input surface + `animtionType` typo'd-key gotcha |
| "blurry background / frosted glass" | `GaussianBlurPreset` (native scene preset) | Easy Lens Blur label overlaps; native path is scriptable today |
| "progress / score / fill bar" | Progress Bar block (LS 5.21+) | Easy Lens panel feature; primitive install path unverified — probe before promising |
| "glasses / sunglasses on face" | Glasses collection (LS 5.21+) | Easy Lens / Asset Library; transparent + sun variants — ask which |
| "physics / bouncing / gravity" | Easy Lens 2D Physics block (5.21+) or native 3D physics presets | 2D for game-style, 3D for world-anchored; confirm before installing |
| "play sound / audio / ding / background music" | `AudioComponent` + `AudioTrackAsset` (native) | See `audio-in-lenses.md` for full API surface, Mix to Snap gotcha, Licensed Music flow. For preset SFX, Easy Lens SFX library is 5.21+ |
| "voice modulation / voice changer / robot voice / pitch shift" | `AudioEffectComponent` (preset-based) | Post-record only — NOT live in Preview. Only 1 effect per lens. See `audio-in-lenses.md` |
| "music-reactive / audio-reactive / beat-synced visuals" | `Audio Analyzer` (amplitude) OR `Beat Sync` (beat timestamps) | Beat Sync more stable for long sessions. See `audio-in-lenses.md` + `lens-recipe-catalog.md` D-5 |
| "react when user says a keyword / phrase" | Keyword Detection template | Mic + ML; NOT general transcription. See `audio-in-lenses.md` |
| "detect a pet / cat / dog / animal in frame" | `Object Tracking` (Cat / Dog / Cats and Dogs) | 2D bounding-box, 8 built-in categories. NOT custom-trainable — for brand product detection use SnapML. See `lens-recipe-catalog.md` C-3-alt |
| "detect a specific product / brand object / custom thing" | SnapML / Bring Your Own Model | NOT Object Tracking (which is 8 fixed categories). Custom ML model training required; one ML component per lens max. (SnapML deep-dive deferred to separate research round.) |
| "custom particles / branded effect / particles from face mesh / segmentation-aware effect" | `Component.VFXComponent` + VFX Graph Editor | Distinct from GPU Particles Effects Pack (recipe B-4 — presets only). Use VFX Graph for custom behaviour. See `vfx-graph-guide.md` |
| "2D character / mascot / paper-cutout in the world" | `Cutout` template + `CutoutController` + `Look At Camera` (Y-axis) | Lighter than 3D model. Silhouette-shape rendered as plane + optional ground shadow. See `lens-recipe-catalog.md` B-7 |
| "hole in the floor / window down into another world" | `Window` template + Surface tracking + Occluder mesh | Ground-based variant of Portal (B-1). 'Peer into' vs Portal's 'step through'. See `lens-recipe-catalog.md` B-6 |
| "user picks face from camera roll / their own photo on a 3D object" | `Face Image Picker` + `FaceImagePickerController` + `face_image_picker` material | Requires camera roll permission. User-driven IP (distinct from Face Swap). See `lens-recipe-catalog.md` A-8 |
| "hand gesture trigger (peace sign, thumbs, fist, point)" | `Hand Gestures` template (5 named: open / close / horns / index_finger / victory) | Pre-built detection, faster than HandTrackingController joint-inference. See `lens-recipe-catalog.md` C-3 |
| "ASL fingerspelling / sign language recognition" | `ASL Fingerspelling` template + SignAll ML model | A-Z + numbers; onNewChar / onHandFound / onHandLost events. Inclusive / accessibility brand campaigns. See `lens-recipe-catalog.md` D-8 |
| "branded canvas / UI panel anchored in world / floating info card" | `Simple Canvas` template + `Canvas` component + `ScreenTransform` + `UIPanel` + `LayoutGrid` | Distinct from Ortho-camera UI: Canvas is portable (can world-anchor). See `lens-recipe-catalog.md` D-7 |
| "interactive plants / swaying flowers / branded foliage" | `Physics Responsive Plants` template + Physics Body / Constraint / Collider chains | Requires `Physics.WorldSettingsAsset` (manual add). See `lens-recipe-catalog.md` D-9 |
| "smash to reveal / break the package / destruction physics" | `Let's Break It` template + `ConvexMeshHelper` + `onCollisionBreak` (with scene-name filter) | Author both intact + pre-broken models. See `lens-recipe-catalog.md` D-10 |
| "collect-em-up / catch falling items / coin game" | `Collect Coins` template + `Game Controller` state machine + `Spawner` + Physics Collider Events | Gamified brand activation. See `lens-recipe-catalog.md` D-11 |
| "scan a real-world product / place / vehicle to unlock content" | `Scan` template + Lens Cloud backend | **ORGANIC ONLY** — uses Lens Cloud which is NOT allowed in Sponsored. For Sponsored re-scope to SnapML. See `lens-recipe-catalog.md` D-12 |
| "multi-user live sync / collaborative voting lens" | `Realtime Store` template + Connected Lenses / Lens Cloud | **ORGANIC ONLY** — Lens Cloud not allowed in Sponsored. See `sponsored-lens-submission.md` |
| "personal lens / show my Bitmoji / friends' Bitmoji / Bitmoji reaction" | `Bitmoji 2D` / `Bitmoji 3D` / `Bitmoji Head` / `Bitmoji Face Animator` via Asset Library + `BitmojiModule` script | **ORGANIC ONLY** — Bitmoji is NOT allowed in Sponsored Lenses (commercial use prohibited per Snap rule). See `bitmoji-integration.md` |
| "live weather / live data / location-aware / AI text generation / nearby places" | `Remote Service Module` (AccuWeather / ChatGPT / Snap Places / Stock Market) via Asset Library APIs category | **TRADEOFF**: DISABLES microphone, Voice ML, DeviceTracking mesh/raycast, UserContextSystem birthdate/location in same lens. ChatGPT lenses Discover-disabled by default. See `remote-apis-integration.md` |
| "3D character / avatar" | GenAI Body Generator (5.21+) — Tier 2 | Generated asset still needs FBX/glTF integration — Tier 2 (external asset) per `capability-tiers.md` |
| "spin / rotate / animate text" | Text3D Animator block (5.21+); fallback `TweenTransform` on `Text3D` | Block install path unverified — fallback is production-safe |
| "character animation / state machine / blend between idle and action" | `AnimationPlayer` + Animation State Graph Editor (LS 5.20+) | New visual state-machine editor; we have no empirical depth — point user at https://ar.snap.com/download/v5-20-0 and proceed cautiously |
| "multi-style text / mixed fonts in one label / highlighted word" | Rich Text on `Text`/`Text3D` (LS 5.20+) | New tag-based markup; uses Font Family + Font Collection assets — see https://ar.snap.com/download/v5-20-0 |
| "color grading / LUT / cinematic look" | Color Correction plugin (LS 5.20+) | Realtime preview inside LS; we have no empirical depth — see https://ar.snap.com/download/v5-20-0 |

---

## Confirmation pattern

> "I'm reading this as you wanting [feature]. I can add [concrete primitive] which [does X]. Does that match, or did you mean something else?"

Wait for explicit confirmation before any install / mutation. If the user confirms, proceed; if they describe a different intent, re-map.

**Why this gate exists**: 5.21 features ship under marketing names ("Easy Lens X"), MCP-actionable primitives ship under different names (`Button` v1.0.1, `GaussianBlurPreset`), and mismatched terminology between brief and implementation is a common source of wasted iteration. The mapping table + confirmation step closes the gap before any install/mutation cost is incurred.

---

## Deeper recipe lookup

This file is the fast-pass intent detector for UI primitives + post-effects. For scene-level lens recipes ("I want a personality quiz lens", "I want a sunglasses try-on", "I want a music-reactive lens"), load `references/lens-recipe-catalog.md` — 30 named recipes across Face Filters / World / Body / Interactive / Commerce / Sponsored Brand categories, each with concrete primitives, build approach, performance notes, and common pitfalls.
