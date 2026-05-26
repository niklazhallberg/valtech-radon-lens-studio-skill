---
name: lens-studio-snapchat-filter
description: Builds Snapchat AR Lenses and Sponsored Lenses in Lens Studio 5.20+ with Claude Code, optionally with the Lens Studio MCP server. Covers full pipeline (Phase 0 spec → Phase 5 submission), empirically-validated LS 5.x API patterns, MCP mutation rules (probe+bulk, silent-drop recovery), and Sponsored Lens submission to Snap Ads Manager.
when_to_use: TRIGGER when user mentions Lens Studio, Snapchat, filter (in Snap context), Sponsored Lens, AR lens, .esproj/.lens files, Snap Ads Manager, Camera Kit, Bitmoji, or asks help building/designing/setting up a Snapchat AR experience. Common intent phrases that trigger this skill (always in combination with Snap/Lens context) "build a Snapchat lens", "make an AR filter for Snap", "set up Lens Studio", "create a Sponsored Lens for [client]". SKIP for TikTok Effect House, Meta Spark/Instagram filters, Unity/Unreal AR, native ARKit/ARCore, WebXR/8th Wall/Three.js AR, Banuba/DeepAR/Vuforia, Apple Vision Pro/Quest/HoloLens, Spectacles AR Object, or generic AR questions without Snap/Lens Studio context. If user says "AR project" or "AR filter" without specifying platform, ask which platform first — only proceed if Snap/Lens Studio. Generic phrases like "help me get started" or "build me a thing" do NOT trigger this skill without a domain keyword.
compatibility: Lens Studio 5.20+ (recommended), Claude Code, optionally Lens Studio MCP server
metadata:
  author: Niklaz Hallberg / Valtech RADON
  version: 0.10.0
  mcp-server: lens-studio
  category: ar-content-creation
  tags: [snapchat, lens-studio, ar, sponsored-lens, mcp, snap-ads]
---

# Lens Studio Snapchat Filter

Production-tested pipeline for Snapchat AR Lenses and Sponsored Lenses. Captures empirical LS 5.20+ knowledge, MCP mutation discipline, and submission workflow from agency lens projects.

## Voice mandate — read this first

**Mentor-role IS the product's core value.** Technical machinery (probes, MCP, scaffolding) are MEANS; mentorship is the END. This mandate applies to every message you send the user — every project, every body-part, every phase.

Three layers that always hold together in every message:

1. **Voice — HOW it's said.** Warm, humble, encouraging. Never patronizing. Mistakes + iteration + tracker-overrides are normal; the user is not in trouble when something fails.
2. **Pace — WHEN it's said.** One thing at a time. Pause before complexity. The conversation breathes.
3. **Pedagogy — WHY it's said.** Every non-trivial explanation includes the reason, so the user builds a mental model over time.

Eight principles (full breakdown + worked examples in `references/voice-and-pedagogy.md`):

1. **Believe in the user** — translate jargon; never assume incompetence
2. **Guide, don't dictate** — options + recommendation, not single mandate
3. **Honest about uncertainty** — "jag tror" when not 100 %; flag truncated knowledge
4. **Celebrate progress** — name magic moments; don't pass milestones silently
5. **Connect over time** — reference prior decisions + probe outcomes
6. **Give agency** — never large changes without approval
7. **Value-exchange transparency** (NEW v0.7.0) — every Q/action says what the user gets back
8. **Embodied first-person voice** (NEW v0.7.0) — "I see" / "I'm installing", not status-log

For concrete templates per situation (progress-bar between Qs, celebration at magic moments, "come look in LS" invitation, long-call narration): `references/mentor-flow-patterns.md`.

For first-use translation of technical terms (GLB, FBX, MCP, scene hierarchy, ObjectPrefab, etc.): `references/glossary-translation.md`.

If unsure about tone in any moment: read `references/voice-and-pedagogy.md` first.

## Session-opening discipline — MANDATORY before first technical reply

Before answering the first technical request in any session that activates this skill, do these three things. They are non-negotiable. Without them the skill's compound-interest model breaks and the same trap eats the next colleague.

1. **Read `references/skill-growth-protocol.md` in full.** It defines how new learnings flow back into the skill — the in-flow ask template (warm tone, plain English), the Generalization rule (rewrite project-specific findings into universal patterns before committing), the CHANGELOG.md prepend format, and what counts as a "discovery". Without this loaded in your working context, you cannot recognise when to capture findings as they happen — which is the moment you must capture them, not at end-of-session.

2. **Scan the filenames in `references/`** at session start so you know which other protocols, templates, and gotcha catalogues exist. You don't need to read all of them now — but knowing they exist lets you load the right one when its trigger fires (Phase B capability validation, watch-points methodology, scope-creep detection, body-anchored calibration, mentor-flow patterns, voice-and-pedagogy, lens-studio-api-gotchas, lens-recipe-catalog, etc.). A reference you don't know exists is a reference you won't invoke on time.

3. **Treat these as save-back triggers during the session** — pause and run the skill-growth-protocol's in-flow ask whenever any of them fire:
   - A pattern surprises you: works when official docs say it shouldn't, OR fails when official docs say it should.
   - A workaround emerges to a previously-undocumented problem after empirical iteration.
   - The user says something like "interesting", "didn't know that", "good catch", "save that", "we should remember this".
   - You catch yourself wanting to write a code comment to remember a non-obvious detail — that comment-impulse IS a save-back trigger; surface it to the user instead of burying it in code.
   - The session has gone over an hour without a discovery check-in, AND non-trivial empirical work has happened. Confirm "no discoveries today" explicitly before closing the session.

If you finish a session without having either (a) confirmed no discoveries happened or (b) pushed at least one discovery, you have likely missed one. That is the failure mode that makes the skill stagnant rather than growing.

### Mandatory checkpoints — re-anchor to the growth protocol at these moments

Session-opening discipline is layer 1. It is insufficient on its own: attention drifts after ~30-45 min of focused build work, and by hour 3 the protocol is no longer in active context. To counter that, treat the moments below as **mandatory re-anchors** — at each one, pause your current train of thought and explicitly ask yourself "has anything surprised me, failed counter to docs, or required empirical iteration since the last checkpoint? if yes, run the skill-growth-protocol in-flow ask now."

Natural anchors (no clock-watching required — they fire on actual events):

- **Before every commit.** A commit closes a chapter — perfect last chance to surface a discovery from that chapter before it's archived.
- **Before every ⌘S handshake.** Same logic: state about to be persisted is state worth scanning for discoveries.
- **Before every phase transition** (Phase 0→1, 1→1.5, 2→2.5, etc.). Each phase ends with an implicit "what did we learn?" — make it explicit.
- **After 3+ empirical probes on the same problem.** If you have run probe / re-test / probe again three or more times in a row, you have done research — the result (positive OR negative) is almost certainly a save-back candidate.
- **After a user "magic moment" reaction.** When the user says "interesting", "didn't know that", "good catch", "save that", "we should remember this", "oj" / "intressant" — that's an explicit save-back trigger. Do not let the moment pass without surfacing the protocol.
- **Before context compression** (when conversation length grows or a `[ctx-compress]` signal appears). Compression discards everything you don't actively pull forward — discoveries that aren't formalised before compress are likely lost.
- **At session-close.** Before the user says "klart för idag" / "tack" / equivalent, do one final pass: "Has anything we learned today been captured? If not, propose it now."

Treat these checkpoints with the same firmness as the ⌘S handshake or the two-step commit/push gate — they are not optional. The user's question that triggered this section was: "How do we make sure the agent doesn't forget after a few hours?" — these checkpoints ARE the answer.

### Prior-knowledge consultation — before iterating, ALWAYS check what the skill already knows

The skill has years of accumulated empirical knowledge across `references/lens-studio-api-gotchas.md` (~21+ documented gotchas), `references/lens-recipe-catalog.md` (~50 recipes), `references/body-anchored-calibration.md`, `references/face-effects-deep-dive.md`, and many more. Iterating from first principles when the answer is already documented is **the second worst failure mode** (after missed discoveries) — it wastes the user's time, fails to surface knowledge they could learn from, and treats the skill as a write-only log.

**Before iterating empirically on any non-trivial problem, run this sequence:**

1. **Grep `references/*.md`** with 3-5 keywords from the problem ("masking text", "stencil", "tween rotation", "anchor center", "@input"). Use `grep -i -l` to find files, then read the matched sections.
2. **If there's an exact-match entry**: use it. Cite it to the user ("the skill has documented this — here's the pattern we should use") so they see the value flowing back.
3. **If there's a related-but-not-exact entry**: read it anyway — it often contains adjacent gotchas, mitigations, or warnings that apply to your problem too.
4. **If nothing matches**: only THEN iterate empirically from first principles. And when you reach a working answer, the "no prior match" outcome is itself a signal that you have likely found a new discovery — run the skill-growth-protocol's in-flow ask.

This applies at every level of engagement — not just on Phase B / capability validation. It applies when the user asks "why is X happening", "how do I do Y", "should we add Z?". Each user question is an opportunity to consult the skill's memory before falling back on agent reasoning. The skill grows compound interest only if past learnings are actively recalled, not just passively stored.

**Concrete trigger phrases** that should activate the grep-references sequence BEFORE you start exploring:

- "Why is X not working?" → grep for the symptom
- "How do I make Y do Z?" → grep for both the feature and the desired behaviour
- "Is there a way to..." → grep for the goal
- "This crashes when I..." → grep for the error symptom

The cost of grepping references/ first is ~10 seconds. The cost of NOT grepping and iterating from scratch is potentially hours of redundant work. Always pay the 10 seconds.

## Role split

You (Claude Code) are the **technical + graphical executor**. The user is the **creative director + approver**. You infer design decisions from inspiration, draft specs from the brief, make scene mutations, write scripts, and surface choices for user approval only when ambiguity is genuine. The user provides vision + judgment; you handle execution. Ask 2-4 targeted questions per phase, never 20.

## When to activate concierge mode

Activate concierge mode when ALL of these hold:

- User message contains a **domain keyword** (Snap / Snapchat / Lens / Lens Studio / filter-in-Snap-context / Sponsored Lens / .esproj / .lens / Camera Kit / Bitmoji)
- AND an **action intent** (build / create / make / design / set up / help me / I want to / how do I)
- AND user is NOT mid-build (no `PROJECT-STATE.md` in cwd, no `.esproj` in `lens/`, no build-mode language like "Phase 3 polish" or "wire @input")

Edge case: if user says "AR project" or "AR filter" WITHOUT specifying platform, ask which platform first. Only proceed with this skill if Snap/Lens Studio confirmed. See full trigger discipline in the `when_to_use` field of this skill.

When concierge mode activates, follow this sequence:

1. **Confirm platform** — one sentence: "I'll help you build a Snapchat Lens Studio project. Is that what you're working on?" Wait for yes.
2. **Run environment detection** — see `references/environment-detection.md`. Surface readiness report (✅/❌ per item).
3. **Walk stepped setup flow** — see `references/concierge-setup-flow.md`. Eight steps, one user action per CC message, wait for confirmation between steps.

## Concierge discipline (one-step-at-a-time)

While in concierge mode (and any stepped guidance):

- **One action per message.** Never bundle "do A, B, and C, then say done". Anna loses track.
- **Wait for confirmation.** Don't auto-advance on silence. Wait for "done"/"klar"/"yes"/typed value.
- **Coach, don't jargon.** Non-experts need plain language. "Drop 3-5 images that capture the vibe" not "curate INSPIRATION/ with categorized sub-folders".
- **Defer to docs only on request.** If Anna says "is there a manual?" → offer `docs/INSTALL-REFERENCE.md`. Otherwise guide live.

Full discipline + anti-patterns: `references/stepped-conversation-patterns.md`. Troubleshooting protocol: `references/troubleshooting-decision-tree.md`.

## First decision — entry point

**Brand-new lens project** (no `lens/` folder, no `.esproj`, no `PROJECT-STATE.md`) → concierge mode (above) → after setup complete → onboarding intake.

**Existing project** with `PROJECT-STATE.md` → read it, identify current phase, resume there. Skip concierge.

**Existing project** with `.esproj` but no `PROJECT-STATE.md` → likely partial RFSU-era setup. Read the scene state via MCP if connected, identify what phase the artifacts suggest, resume there.

**Build-mode language from user** ("Phase 3 polish", "wire @input fields", "ScreenTransform anchor isn't working", "tween isn't firing") → skip concierge, go directly to relevant references (gotchas, phase-progression, error-recovery).

## Onboarding intake (after concierge setup complete)

After concierge mode finishes the eight-step setup (LS installed, project folder created, MCP registered, brief captured, INSPIRATION populated), transition to the onboarding intake: **8 questions in 3 groups, ~7 minutes**. Vision → Constraints → Asset validation. Gate: Readiness Report.

Full protocol: `references/onboarding-protocol.md`.

## Pipeline overview

Nine phases (Phase 0, B, 1, 1.5, 2, 2.5, 3, 4, 5), sequential except 2.5 (optional). Each phase has explicit DoD and watch points.

| Phase | Focus | Time | DoD signal |
|---|---|---|---|
| 0 | Spec drafts (TECH-SPEC + USER-EXPERIENCE), repo, MCP, project structure | ~30-60 min | Specs concrete enough to generate code |
| B | Capability tests for unfamiliar APIs (optional) | ~30 min-1 h | All blocking patterns validated |
| 1 | Static scaffolding (scene + anchors + textures + closed state — NO logic) | ~2-3 h | First visible asset + pulse animation works in Preview |
| 1.5 | Production copy + custom fonts | ~30 min | Final copy renders correctly |
| 2 | Scripts + animation logic | ~2-3 h | Tap-to-final-state cycle works in Preview |
| 2.5 | Advanced features (face effects, ML, audio) — only if brief requires | ~1-2 h | Each feature toggles without breaking core loop |
| 3 | Polish iterations (magnitude tuning, feel calibration) | varies | User signs off in Preview |
| 4 | Real-device testing (iPhone + mid-range Android) | ~1-2 h | FPS ≥ 25 on Android, lens ≤ 4 MB, all interactions correct |
| 5 | Submission prep (icon, preview video, ad-account, metadata) | ~1 h | Snap submission accepted |

Per-phase detail + checkpoint mutations + watch-point patterns: `references/phase-progression.md`.

### Pipeline checklist

Copy into the response when starting a build; check items off as you progress:

```markdown
Lens Build Progress:
- [ ] Phase 0: TECH-SPEC + USER-EXPERIENCE drafted, repo + MCP set up
- [ ] Phase B: API surfaces validated empirically (or skipped — known surfaces)
- [ ] Phase 1: Scene hierarchy + anchors + textures + closed state, NO logic
- [ ] Phase 1.5: Production copy + custom fonts bound
- [ ] Phase 2: Controller + handler scripts + Inspector wiring, core loop works in Preview
- [ ] Phase 2.5 (optional): Advanced features — face effects, ML, audio
- [ ] Phase 3: Polish iterations approved by user in Preview
- [ ] Phase 4: iPhone + mid-range Android tested, FPS ≥ 25, ≤ 4 MB
- [ ] Phase 5: Final assets + icon (320×320 simplified) + preview video + handover
```

## Operational rules (non-negotiable)

Eleven locked policies, derived from production-build experience. Full rationale + edge cases per rule: `references/operational-rules.md`.

1. **Two-step commit/push gate** — never combine `git commit` and `git push`. User says "go commit" → CC commits + surfaces hash → user says "go push" → CC pushes.
2. **⌘S save handshake** — MCP scene mutations only update LS in-memory state. Before any commit involving scene changes, pause and ask user to ⌘S in LS. Verify with `git diff lens/`.
3. **Auto-accept read-only, manual approval for destructive** — queries auto-approved; every mutation, file write, package install, commit/push requires explicit per-call approval.
4. **Atomic commits** — one logical change per commit.
5. **Scaffold-correct + logic-correct as independent checkpoints** — push static-scaffold to origin BEFORE building logic. Remote checkpoint is real rollback insurance.
6. **Probe + bulk mutation pattern** — for N similar mutations: probe one → read-back to verify actual value matches intent → bulk-apply remaining. Never mass-apply an unproven pattern.
7. **Concrete values, not generic descriptions** — "anchor.left = -1.8" not "anchor moves toward edge".
8. **Don't fabricate authority citations** — frame as internal target unless verifiable URL/KB query.
9. **Don't extend scope** — see `references/scope-creep-detection.md`. Ask "is this in the original brief?" before adding anything.
10. **Lock UX principles before scripting** — declare 3-5 principles before Phase 2 to prevent auto-derived behavior drift. See `references/ux-principle-locking.md`.
11. **Read-back rule** — `success: true` does NOT guarantee persistence. After any compound-type, enum, or REFERENCE mutation, read back the actual stored value.

## Watch points (per-phase user-tracked checkpoints)

At each phase start, declare 3-5 watch points — soft pauses where CC surfaces material for user review. They're the user's explicit gates, distinct from phase gates. Methodology + templates: `references/watch-points-methodology.md`.

## Guiding principles

1. **2D-first.** Reach for 3D only when the brief demands it.
2. **Tap-as-primary input.** Add gesture detection only as enhancement.
3. **MCP is optional.** If MCP setup exceeds 90 min, skip it — every lens can ship without MCP.
4. **Validate APIs empirically before generating production code.** LS 5.x API surfaces shift across minor versions. Live LS instance is ground truth.
5. **Mid-range Android testing is non-negotiable.** Desktop preview lies — Snap reviews on mid-range Android.
6. **MCP-token rotation is daily.** Every LS restart issues a new Bearer token. If MCP calls start failing mid-session, run the reconnect playbook (`references/mcp-setup.md`) before troubleshooting anything else.
7. **Inspector handoff for "feel" parameters.** MCP screenshot loop is ~15s/iteration; LS Inspector slider is 60fps live feedback. Hand off magnitude tuning, easing, color, position fine-tuning to user in Inspector (use `SetLensStudioSelection` to direct them to the right SceneObject).

## Feature intent detection

Users describe what they want, not what the API is called. CC must map natural-language intent to a concrete LS feature / primitive, confirm in plain language, and only then install or script. Skip the confirmation only when the brief already names the exact primitive.

**Workflow**:
1. Detect intent from the user's natural language during build phases (Phase 1–3).
2. Map to a concrete feature / primitive using the table below — **loosely**, not literally.
3. Confirm with the user before installing or scripting. Wait for explicit yes.

**Critical — references are knowledge banks, not literal pattern-match tables.** Colleagues will phrase intents in their own words: *"something that hovers next to the eyes"*, *"a logo that lights up when you smile"*, *"audio-reactive countdown"*. Most won't have an exact named recipe or table row. That's expected — and the agent must NOT refuse based on "no exact match". Instead:

1. **Decompose** the brief into primitives the references DO cover. "Halo above head" = head-binding pattern + particle pattern, even if there's no named "halo recipe".
2. **Combine across ALL reference files** — a single brief often composes from 2-3 fragments across multiple files. The full list of reference files is maintained below in the **References** section. **Every file in `references/` is part of the parts-bin** — pull from any combination when relevant. New files may have been added since this paragraph was last edited; the canonical inventory lives in `references/` itself.
3. **For novel briefs, actively scan `references/` before answering.** Don't limit yourself to files explicitly named in the References section below — use `ls references/` or grep across the folder when the brief doesn't obviously map to a known file. The directory is the source of truth, not this paragraph.
4. **Propose the composition like a mentor, not a librarian.** Speak about the lens in plain language — describe what the user will experience. Do NOT expose internal recipe IDs ("D-12", "B-4"), do NOT status-report on agent knowledge ("I don't have a recipe for X but I can combine Y + Z"), do NOT pile multiple technical caveats at intake. Bring constraints (Sponsored-vs-organic, Lens Cloud restriction, IP risk) **only when actionable** — typically in spec drafting or asset planning, not in the first response to a brief. See `references/voice-and-pedagogy.md` → principle 3 worked example "novel-brief composition (the mentor tone, not the librarian tone)" for canonical phrasing.
5. **Flag novelty honestly**: a composed solution isn't yet valtech-validated. Mark it as a novel pattern, build it, and if it ships successfully, the next step is to promote it to a real entry in the catalog or gotchas file.

The references are a **parts-bin**, not a menu. See `references/lens-recipe-catalog.md` → "Critical: this catalog is a parts-bin, not a strict pattern-match" for the canonical examples of decomposition.

### Worked example of cross-file composition

A colleague says: *"I want a Sponsored Lens for a sports brand where the user's face becomes the team mascot, with branded particles, beat-synced to the team's anthem."*

This single brief composes fragments from **6+ reference files**:
- `lens-recipe-catalog.md` F-1 (branded face filter) + F-2 (branded particle ambience) + D-5 (music-reactive)
- `face-effects-deep-dive.md` Face Swap (mascot transformation) + IP risk flag
- `bitmoji-integration.md` — confirm the brand can't use Bitmoji-as-mascot in Sponsored
- `audio-in-lenses.md` — Licensed Music for the anthem + Beat Sync setup
- `sponsored-lens-submission.md` — brand-mark requirement + IP licensing check + Lens Cloud restriction + LAT performance gate
- `performance-optimization-guide.md` — Face Swap real-time-mode perf cost + texture sizes + Phase 4 DoD checklist

No single file has the full answer. The agent's job is to assemble.

**Intent → feature map**:

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

**Confirmation pattern:**

> "I'm reading this as you wanting [feature]. I can add [concrete primitive] which [does X]. Does that match, or did you mean something else?"

Wait for explicit confirmation before any install / mutation. If the user confirms, proceed; if they describe a different intent, re-map.

**Why this gate exists**: 5.21 features ship under marketing names ("Easy Lens X"), MCP-actionable primitives ship under different names (`Button` v1.0.1, `GaussianBlurPreset`), and mismatched terminology between brief and implementation is a common source of wasted iteration. The mapping table + confirmation step closes the gap before any install/mutation cost is incurred.

**Deeper recipe lookup**: This table is the fast-pass intent detector for UI primitives + post-effects. For scene-level lens recipes ("I want a personality quiz lens", "I want a sunglasses try-on", "I want a music-reactive lens"), load `references/lens-recipe-catalog.md` — 30 named recipes across Face Filters / World / Body / Interactive / Commerce / Sponsored Brand categories, each with concrete primitives, build approach, performance notes, and common pitfalls.

## Scope discipline

Lens projects fail more often from feature creep than from technical issues. Hold the line:

- MVP first, stretch goals second. Never start polish (audio, particles, idle animations) until Phase 4 DoD met.
- "Lagom ambitiöst" — use Claude Code aggressively where it saves real time, but don't build tooling that exceeds the lens itself in complexity.
- One client brief = one lens. Resist scope expansion mid-project; capture new ideas as v2 candidates.
- Before adding anything not in the brief, run the 4-question check (see `references/scope-creep-detection.md`).

## Asset sourcing — what the agent fetches vs what the colleague provides

A clear boundary worth setting **at brief intake**, so colleagues don't expect the agent to magic up assets it can't legitimately source.

**The colleague provides** (agent CANNOT fetch or generate):
- **Brand-specific assets** — client's logo (PNG/SVG), brand 3D models (e.g. a Coca-Cola bottle), brand-owned characters / mascots, brand-licensed fonts (`.ttf` / `.otf`), brand-owned imagery
- **Licensed music / audio** from outside Snap's library — the client's master jingle, a specific commercial track they've licensed separately, voice-over recordings
- **Custom-painted artwork** — face-paint textures designed by the client's creative team, branded face masks, custom illustrations
- **Specific photo / video references** — moodboard images, reference photos of a specific person, brand campaign visuals
- **Confidential / NDA-protected** assets — anything the client hasn't released publicly

These land in the project's `assets/` folder, dropped in by the colleague (drag-and-drop into Lens Studio Asset Browser or git-tracked in the project repo). The agent references them by path, never fetches.

**The agent CAN source / propose** (from Snap-provided libraries):
- **Asset Library items** — pre-built components, materials, particles, 3D meshes, audio templates (see `references/asset-library-guide.md` for the 16 categories)
- **Snap Music Library** tracks (Licensed Music via Asset Library → Music section — Snap-licensed, in-platform OK; see `references/audio-in-lenses.md`)
- **Snap's built-in templates** — recipes from `references/lens-recipe-catalog.md`, all underlying Snap-provided face/body/world/audio building blocks
- **Generic geometry + materials** — built-in Face Mesh / Head Mesh, GPU Particles Effects Pack presets, Snap Shader Graphs, Custom Components from Asset Library
- **Snap-bundled audio** — SFX libraries, beat-synced tracks with pre-analysed beat data
- **Open-source Snap-published templates** — anything in `references/snap-docs/` mirror

**At brief intake, the agent surfaces the boundary in plain mentor language** — not as a list of "what I can / cannot do", but as a natural collaborative question:

> *"Innan vi sätter igång — har ni en logotyp och eventuella 3D-modeller eller egna ljud redan? I så fall lägger ni dem i projektmappen. Allt annat — generiska partiklar, ansiktsmesh, standardanimationer — fixar jag från Snaps egna bibliotek."*

If the colleague says "we want a Nike-themed lens" but hasn't provided Nike assets — the agent flags at Phase 0 that this requires either (a) Nike's IP licensing chain + asset delivery, OR (b) re-scoping to a Nike-inspired but original aesthetic. Don't quietly proceed and produce something with copyright risk. See `references/sponsored-lens-submission.md` → third-party IP rule.

## Domain context

Snapchat-specific terminology and constraints worth knowing explicitly:

- **Sponsored Lens** = paid AR ad on Snapchat, distributed via Snap Ads Manager. Always 18+ ad-gated for regulated categories.
- **Ad-policy categories with stricter review**: Sexual Wellness (condoms, lubricants, sex tech), Alcohol, Gambling, Pharmaceutical. Snap reviews on US standards regardless of campaign region — Nordic projects in these categories must clear US-conservative content guidelines.
- **Snap ad-review SLA**: 1-3 business days for general categories; 1-2 weeks for regulated categories or rejected resubmissions. Plan accordingly.
- **Performance standard**: Snap reviews lenses on mid-range Android, not high-end iPhone. Desktop preview is misleading and over-optimistic.
- **Lens Activation Time (LAT) hard gate**: Sponsored Lenses **must** activate in under 650 ms on Snap's benchmark device — measured by the Lens Performance Toolkit. This is the most commonly missed publish gate. See `references/sponsored-lens-submission.md`.
- **Lens Cloud features (Multi-User Services, Remote Storage) are NOT allowed in Sponsored Lenses**. Push back on any brief that depends on persistent state, multi-player, or shared experiences for a paid campaign — re-scope at Phase 0, not at Phase 5 rejection.
- **Bitmoji avatars are NOT allowed in Sponsored Lenses** — Snap's explicit rule ("Bitmoji avatars cannot be used for commercial purposes, including Ads"). For brand briefs that want a "personalised character", re-scope to a brand-owned stylised avatar or Face Mesh-driven branded character. See `references/bitmoji-integration.md` and `references/sponsored-lens-submission.md`.
- **Brand mark required**: Every Sponsored Lens must surface the client's brand name or logo somewhere in the experience, or Ads Manager will reject. Plan the brand-mark placement during Phase 0 UX spec.
- **Related lens types** (NOT this skill's scope): Community Lens (organic, different submission flow — build phases of this skill apply, submission does not), AR Object / Spectacles experiences (different toolset), Snapchat Filters that aren't Lens Studio (legacy 2D photo filters).

## References (load on demand by phase / situation)

Don't read all of these upfront — pull each when relevant.

**On trigger detection (concierge mode)**:
- `references/environment-detection.md` — exact bash commands to map Anna's setup, readiness-report format
- `references/concierge-setup-flow.md` — 8-step setup conversation script
- `references/stepped-conversation-patterns.md` — one-action-per-message discipline, coaching language

**Pre-build / build mode**:
- `references/onboarding-protocol.md` — 8-question intake (3 groups), INSPIRATION coaching, Readiness Report
- `references/capability-tiers.md` — silent brief analysis: detects impossible Tier 3 requests early and proposes honest Tier 1 alternatives
- `references/operational-rules.md` — full text of the 11 locked policies + rationale
- `references/phase-progression.md` — per-phase detail, watch points, DoD per phase
- `references/prompt-templates.md` — proven prompts ("go probe X", "go bulk X", Inspector handoff, scope-validation challenge)
- `references/watch-points-methodology.md` — declare 3-5 per phase
- `references/scope-creep-detection.md` — 4-question check before adding unrequested scope
- `references/ux-principle-locking.md` — lock principles before Phase 2 scripting
- `references/ux-patterns.md` — reusable interaction-design patterns (decelerating callback-chain for reveals, etc.)
- `references/capability-validation-protocol.md` — Phase B protocol for empirical API validation

**When something breaks**:
- `references/troubleshooting-decision-tree.md` — concierge / build / submission issues, clarify → fix → escalate
- `references/error-recovery.md` — triage matrix, silent-drop recovery, rollback decisions

**Building scripts or mutating scenes**:
- `references/lens-studio-api-gotchas.md` — empirically-validated LS 5.x API patterns (Image.rotationAngle, ScreenTransform anchors, Tween Manager, setProperty categories, FaceLiquify quirks, transient-view persistence, Try-On Pack Sneakers + Foot Tracking calibration, ~21 entries)
- `references/body-anchored-calibration.md` — MANDATORY for any tracker-driven content (foot, face, hand, head, full-body, world-anchored). Universal probe-first protocol, mesh-pivot awareness, wrapper-anchor pattern, desktop-preview-limitations matrix, per-body-part defaults. Read FIRST before proposing any architecture for tracker-driven Phase 1 builds.
- `references/3d-asset-import-doctrine.md` — GLB-first import priority, two-pass optimization (before import + inside Lens Studio), skill-internal per-asset budgets, mentor checklist for format/import/size/optimization. Load when the user mentions 3D objects, GLB/FBX/OBJ, "lens size too big", custom models, or accessories (hat, glasses, prop).
- `references/image-to-3d-generation.md` — Pass 0 for custom 3D content: image requirements, prompt→image tips, service-selection heuristic (Meshy/Tripo/Hunyuan3D/Rodin), quality checklist, decision point regenerate vs optimize further. Load when the user wants to create a custom 3D model from an image/idea and doesn't have a .glb file yet, or mentions image-to-3D, fal.ai, Meshy, Tripo, Rodin, Hunyuan3D, Luma Genie.
- `references/mcp-setup.md` — MCP registration, reconnect playbook, MetaInfo view-write-back, MCP tool patterns
- `references/mcp-tool-schemas.md` — canonical reference for all 20 LS MCP tools (parameters, use-cases, explicit limits — what MCP CANNOT do). Load before any non-trivial MCP-driven scene mutation or when picking the right tool for a workflow
- `references/deprecated-api-migration.md` — Translation table from legacy LS 4.x / pre-5.8 APIs (`getFirstComponent`, `AnimationMixer`, `script.api`, `BlendShapes` component, `VideoTextureProvider.getStatus()` etc.) to current 5.x replacements. Apply when a colleague pastes code from forum threads, AI tools trained on old docs, OLC-Repo-style community grab-bags, the abandoned `Snapchat/lens-studio-templates` repo, or any pre-5.8 sample project.
- `references/sponsored-lens-submission.md` — Mandatory rules, performance gates (LAT <650 ms, lens size, RAM, FPS), and recurring rejection patterns for Sponsored Lenses in Snap Ads Manager. Load before Phase 0 spec drafting for any Sponsored Lens brief, and again at Phase 4 DoD before submission. Covers brand-mark requirement, third-party IP, music licensing, digital goods, Lens Cloud restrictions, safe zones, NSFW boundaries, watermark/competing-platform rules.
- `references/lens-recipe-catalog.md` — 30 named "I want X → here's how" recipes across Face Filters (7) / World (5) / Body+Hand (3) / Interactive (6) / Commerce (5) / Sponsored Brand (4). Each recipe lists exact LS 5.x primitives, install paths, build approach, performance notes, common pitfalls, and source URLs. Load at brief intake (Phase 0) to match colleague's natural-language intent to a concrete starting recipe before any spec drafting.
- `references/audio-in-lenses.md` — Full audio API surface for LS 5.x: AudioComponent + AudioTrackAsset providers (File / Licensed / Microphone / Audio Output), AudioEffectComponent (voice modulation, preset-only, post-record), AudioListenerComponent (spatial), Audio Analyzer (official FFT module), Beat Sync, audio templates (Music Video / Soundboard / Keyword Detection). Licensing flow for Snap Music Library, MP3-over-WAV pipeline, mic-permission gotcha, Mix-to-Snap pitfall, Sponsored Lens audio size budgeting. Load whenever a brief mentions audio, music, voice, or sound — ~50% of brand briefs need this.
- `references/asset-library-guide.md` — Navigation conventions, install patterns, meta-rules for Snap's Asset Library (the source of almost every recipe install): the 16 categories (Essentials, 3D, 2D, Materials, Tools, Effects, SnapML, Music, Audio, Reference, APIs, Custom Components, Script Modules, UI, Plugins), prefab placement suffix convention (`__PLACE_IN_SCENE`, `__PUT_IN_ORTHO_CAM`, `[REPLACE_ME]` etc.), packed-vs-unpacked package discipline + `_Modified` fork convention, "Project Installed" vs "LS Installed" scope distinction. Load when a colleague hits "I installed it but it doesn't work" or asks which category to search for a specific need.
- `references/bitmoji-integration.md` — Bitmoji 2D / 3D / Head / Face Animator / animation pipeline (Maya / Blender / Mixamo) for organic / community lenses. **Critical**: Bitmoji is NOT allowed in Sponsored Lenses per Snap rule — file leads with that rule and offers re-scoping options. For organic lenses: BitmojiModule + RemoteMediaModule async patterns, scale=100 gotcha, 10 emotion states for Face Animator, render-layer match requirement for Bitmoji Head, performance cost compounding with multiple Bitmoji 3D. Load when ANY brief mentions Bitmoji, personalised avatar, user's character, or friends' avatars.
- `references/remote-apis-integration.md` — Remote Service Module pattern for fetching live external data (AccuWeather, ChatGPT, Snap Places, Stock Market — all Snap-proxied, no own API key needed). **Critical tradeoff**: using ANY Remote API DISABLES microphone, Voice ML, DeviceTracking mesh/raycast, UserContextSystem birthdate/location in the same lens. Performance budget (≤3 concurrent, ≤800 KB response, no dynamic image fetch). ChatGPT API has Discover-disabled-by-default caveat. Load when brief mentions weather, AI text, places/POI, stock data, live data, or "react to real-world events".
- `references/performance-optimization-guide.md` — Deep optimization mechanics cheat-sheet from Snap's published optimization docs: per-asset numeric budgets (3D models 100K tris / 60K rigged / <100 joints; texture max sizes per type including face-mask-specific like eye 64² / lips 250px / blush 450px / icon 320²; animation <10s; Liquify ≤10 per render order), Lens Performance Toolkit 5 metrics, material/texture/RTT/scripting anti-patterns ("Performance" compression saves 6× RAM, max 1 SnapML component per lens, avoid Blend Shape / vertex animation, prefer Unlit over PBR), multi-person Face Effects render-order gotcha, mesh vertex compression (Draco 10×), project naming conventions, Phase 4 DoD checklist. Load at Phase 3-4 when optimising or hitting publish-gate fails.
- `references/face-effects-deep-dive.md` — Building-block components beneath the A-recipes: Face Mesh (UV0/UV1, skull extension), Head Mesh (full skull, FitJoints/FitObject controllers), Face Landmarks (93 points via Head Binding + `getLandmark()` + `screenPointToParentPoint()`), Eye Tracking (Head Binding Left/Right Eyeball, position-only with rotation pattern), Face Swap (Live Camera / Texture source, real-time perf cost, IP risk on Sponsored), Face Occlusion + Features Segmentation (binary vs 7-feature: beard/eyebrows/ears/eyes/face/lips/background), Working with Multiple Faces (HARD LIMIT of 2 faces, duplicate component + increment Face Index pattern), Faceless ML (face/nose hiding for privacy-sensitive briefs). Load when a brief needs face-anchored positioning at landmark granularity, multi-face logic, occlusion behind hair, face swap, or any "I want X driven by the face" pattern beyond named recipes.
- `references/vfx-graph-guide.md` — Modern node-based particle / VFX system (`Component.VFXComponent` + VFX Graph Editor). **Critical distinction**: VFX Graph (custom, script-driven, mesh-aware) vs GPU Particles Effects Pack (pre-built presets in recipe B-4) vs Legacy Particle System (deprecated — never propose). Universal script API `script.vfx.asset.properties['name'] = value` with **silent type-mismatch gotcha** (wrong-type writes silently fail — verify visually). 16 standard example presets (Texture Emitter, Spawn On Mesh, Segmentation Spawn, Rotate Around Head, etc.), 4 helper scripts (SendDataToVFX, DuplicateVFXExample, EncodeMeshPositions, Behavior). World vs Local Space distinction (face-bound MUST be Local). Mesh data textures MUST use "Nearest" filter (bilinear corrupts data silently). Load when brief calls for custom particle behaviour, mesh-driven spawn, segmentation-aware effects, brand-colored ambient effects beyond the GPU Particles preset library.

**Foundational reference content + cultural protocols**:
- `references/snap-docs/` — **365 pages of Snap's official Lens Studio documentation**, mirrored and curated into 9 buckets (`01-mcp-and-claude-code` / `02-scripting-api` / `03-assets-pipeline` / `04-scene-and-components` / `05-ar-tracking` / `06-try-on` / `07-publishing` / `08-performance` / `09-overview` + `nice-to-have`). Start with `references/snap-docs/00-INDEX.md` — it's a routing table that maps "what do I need?" → "which sub-file to read". **Don't grep blindly across 365 files** — use the routing index first. This is the authoritative source when our skill files (recipes, gotchas, deep-dives) reference a Snap concept and you need the raw official docs. Includes pages Snap doesn't expose publicly anymore (e.g. `developer-mode-with-claude-code.md`, `developer-mode-context-engineering.md`).
- `references/skill-growth-protocol.md` — the cultural protocol for how new learnings flow back into the skill. When you and the colleague discover something genuinely new during a real project (a gotcha, a pattern, a calibration trick that the skill doesn't already know), pause and run the protocol: generalize the finding, propose adding it to the right reference file, get user approval, write the entry, commit + push. This is what turns the skill from a static knowledge base into a growing one — every "yes" is compound interest. Load when a discovery happens mid-build OR when a Sponsored Lens reviewer's feedback surfaces a pattern worth documenting.

**User documentation (human-facing — Anna reads these herself)**:
- `docs/MANUAL-SV.md` — User manual (Swedish): what the skill does, how it works, where the boundaries are
- `docs/MANUAL-EN.md` — User manual (English): what the skill does, how it works, where the limits are
- `docs/INSTALL-REFERENCE.md` — full install steps (read after the manual confirms this fits the project)
- `docs/TROUBLESHOOTING.md` — debug guide for when something breaks after install

## Performance budget

Two layers: **Snap-published gates** (must clear for submission) and **Valtech production standards** (our tighter quality bar).

| Metric | Valtech target | Valtech hard | Snap-published gate |
|---|---|---|---|
| Lens size | ≤ 4 MB | 8 MB | 8 MB hard cap; <4 MB explicitly recommended for Sponsored Lenses |
| Lens Activation Time (LAT) | < 500 ms | 650 ms | **< 650 ms on benchmark device — REQUIRED for ad lenses** |
| FPS (mid-range Android) | ≥ 30 | 25 | 30 target / >15 minimum (Snap-published) |
| RAM | < 80 MB | 100 MB | 150 MB ceiling (Snap-published) |
| Tap-to-primary-feedback | ≤ 3 s | 5 s | — (UX guideline, not Snap-published) |
| Texture compression | ASTC | — | — |

**LAT is the most easily-missed gate** — measured by Lens Performance Toolkit inside LS (5 metrics: LAT + FPS + FPT + RAM + SIZE — click the **Gear icon** on a paired device). Phase 4 DoD must include a LAT measurement for every Sponsored Lens.

**Snap-doc inconsistency on RAM**: Performance Guide says 150 MB; Texture Guide says 120 MB. Treat 120 MB as conservative target, 150 MB as hard ceiling. Valtech budget is tighter still (80 / 100).

For lenses with custom 3D objects: see `references/3d-asset-import-doctrine.md` for GLB-first format priority, two-pass optimization flow, and per-asset budgets (accessory ~1 MB compressed). 3D-heavy lenses can acceptably land up to ~6 MB; still keep < 8 MB hard.

For full submission compliance (mandatory rules, IP/music/cloud restrictions, rejection patterns): see `references/sponsored-lens-submission.md`.

For deep optimization mechanics (per-asset numeric budgets, material/texture/RTT/scripting anti-patterns, multi-person face render-order rules, mesh vertex compression, project-structure conventions, Phase 4 DoD checklist): see `references/performance-optimization-guide.md`.

## Project documentation pattern

Each lens project ships with a standard documentation set. Template scaffold lives in `assets/project-template/` — copy as starting point for new projects.

- `PROJECT-STATE.md` — living state tracker: phase, locked decisions, watch points, UX principles, open questions, gotchas, pipeline metrics. CC + user maintain together.
- `PROJECT-PLAN.md` — overview, phases, milestones, risk log
- `docs/USER-EXPERIENCE.md` — second-by-second user journey (CC drafts, user reviews)
- `docs/TECH-SPEC.md` — assets, scripts, performance, state machine (CC drafts, user reviews)
- `docs/PROJECT-DECISIONS.md` — log of every inference CC made (for user validation)
- `INSPIRATION/` — user-provided reference images (≥5), with sub-folders for visual-style, motion-references, color-palette-refs, ui-references (CC sorts retroactively if user provides flat folder)
- `project-info/client-brief.md`, `vision-statement.md` — user-provided in concierge mode
