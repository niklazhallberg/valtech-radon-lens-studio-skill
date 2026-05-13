---
name: lens-studio-snapchat-filter
description: Builds Snapchat AR Lenses and Sponsored Lenses in Lens Studio 5.20+ with Claude Code, optionally with the Lens Studio MCP server. Covers full pipeline (Phase 0 spec → Phase 5 submission), empirically-validated LS 5.x API patterns, MCP mutation rules (probe+bulk, silent-drop recovery), and Sponsored Lens submission to Snap Ads Manager.
when_to_use: TRIGGER when user mentions Lens Studio, Snapchat, filter (in Snap context), Sponsored Lens, AR lens, .esproj/.lens files, Snap Ads Manager, Camera Kit, Bitmoji, or asks help building/designing/setting up a Snapchat AR experience. Common intent phrases that trigger this skill (always in combination with Snap/Lens context) "build a Snapchat lens", "make an AR filter for Snap", "set up Lens Studio", "create a Sponsored Lens for [client]". SKIP for TikTok Effect House, Meta Spark/Instagram filters, Unity/Unreal AR, native ARKit/ARCore, WebXR/8th Wall/Three.js AR, Banuba/DeepAR/Vuforia, Apple Vision Pro/Quest/HoloLens, Spectacles AR Object, or generic AR questions without Snap/Lens Studio context. If user says "AR project" or "AR filter" without specifying platform, ask which platform first — only proceed if Snap/Lens Studio. Generic phrases like "help me get started" or "build me a thing" do NOT trigger this skill without a domain keyword.
compatibility: Lens Studio 5.20+ (recommended), Claude Code, optionally Lens Studio MCP server
metadata:
  author: Niklaz Hallberg / Valtech RADON
  version: 0.6.1
  mcp-server: lens-studio
  category: ar-content-creation
  tags: [snapchat, lens-studio, ar, sponsored-lens, mcp, snap-ads]
---

# Lens Studio Snapchat Filter

Production-tested pipeline for Snapchat AR Lenses and Sponsored Lenses. Captures empirical LS 5.20+ knowledge, MCP mutation discipline, and submission workflow from agency lens projects.

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
2. Map to a concrete feature / primitive using the table below.
3. Confirm with the user before installing or scripting. Wait for explicit yes.

**Intent → feature map**:

| Natural-language intent | Concrete LS primitive / feature | Notes |
|---|---|---|
| "clickable thing / button / tap target" | `Button` v1.0.1 (Asset Library install) | Easy Lens Button label maps here; see `lens-studio-api-gotchas.md` for input surface + `animtionType` typo'd-key gotcha |
| "blurry background / frosted glass" | `GaussianBlurPreset` (native scene preset) | Easy Lens Blur label overlaps; native path is scriptable today |
| "progress / score / fill bar" | Progress Bar block (LS 5.21+) | Easy Lens panel feature; primitive install path unverified — probe before promising |
| "glasses / sunglasses on face" | Glasses collection (LS 5.21+) | Easy Lens / Asset Library; transparent + sun variants — ask which |
| "physics / bouncing / gravity" | Easy Lens 2D Physics block (5.21+) or native 3D physics presets | 2D for game-style, 3D for world-anchored; confirm before installing |
| "play sound / audio / ding" | `AudioComponent` (native) | For preset SFX (jump/coin), Easy Lens SFX library is a 5.21+ option (install path unverified) |
| "3D character / avatar" | GenAI Body Generator (5.21+) — Tier 2 | Generated asset still needs FBX/glTF integration — Tier 2 (external asset) per `capability-tiers.md` |
| "spin / rotate / animate text" | Text3D Animator block (5.21+); fallback `TweenTransform` on `Text3D` | Block install path unverified — fallback is production-safe |

**Confirmation pattern** (Swedish, matches project bilingual tone):

> "Jag tolkar det som att du vill ha [feature]. Jag kan lägga till [concrete primitive] som [does X]. Stämmer det, eller menar du något annat?"

English equivalent:

> "I read that as wanting [feature]. I can add [concrete primitive] which [does X]. Right read, or did you mean something else?"

Wait for explicit confirmation before any install / mutation. If the user confirms, proceed; if they describe a different intent, re-map.

**Why this gate exists**: 5.21 features ship under marketing names ("Easy Lens X"), MCP-actionable primitives ship under different names (`Button` v1.0.1, `GaussianBlurPreset`), and mismatched terminology between brief and implementation is a common source of wasted iteration. The mapping table + confirmation step closes the gap before any install/mutation cost is incurred.

## Scope discipline

Lens projects fail more often from feature creep than from technical issues. Hold the line:

- MVP first, stretch goals second. Never start polish (audio, particles, idle animations) until Phase 4 DoD met.
- "Lagom ambitiöst" — use Claude Code aggressively where it saves real time, but don't build tooling that exceeds the lens itself in complexity.
- One client brief = one lens. Resist scope expansion mid-project; capture new ideas as v2 candidates.
- Before adding anything not in the brief, run the 4-question check (see `references/scope-creep-detection.md`).

## Domain context

Snapchat-specific terminology and constraints worth knowing explicitly:

- **Sponsored Lens** = paid AR ad on Snapchat, distributed via Snap Ads Manager. Always 18+ ad-gated for regulated categories.
- **Ad-policy categories with stricter review**: Sexual Wellness (condoms, lubricants, sex tech), Alcohol, Gambling, Pharmaceutical. Snap reviews on US standards regardless of campaign region — Nordic projects in these categories must clear US-conservative content guidelines.
- **Snap ad-review SLA**: 1-3 business days for general categories; 1-2 weeks for regulated categories or rejected resubmissions. Plan accordingly.
- **Performance standard**: Snap reviews lenses on mid-range Android, not high-end iPhone. Desktop preview is misleading and over-optimistic.
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
- `references/mcp-setup.md` — MCP registration, reconnect playbook, MetaInfo view-write-back, MCP tool patterns

**User documentation (human-facing — Anna reads these herself)**:
- `docs/MANUAL-SV.md` — Användarhandbok (svenska): vad skill:en gör, hur den fungerar, var gränserna går
- `docs/MANUAL-EN.md` — User manual (English): what the skill does, how it works, where the limits are
- `docs/INSTALL-REFERENCE.md` — full install steps (read after the manual confirms this fits the project)
- `docs/TROUBLESHOOTING.md` — debug guide for when something breaks after install

## Performance budget

Default targets — adjust per brief, but don't loosen without explicit reason.

| Metric | Target | Hard limit |
|---|---|---|
| Lens size | ≤ 4 MB | 8 MB |
| FPS (mid-range Android) | ≥ 30 | 25 |
| RAM | < 80 MB | 100 MB |
| Tap-to-primary-feedback | ≤ 3 s | 5 s |
| Texture compression | ASTC | — |

## Project documentation pattern

Each lens project ships with a standard documentation set. Template scaffold lives in `assets/project-template/` — copy as starting point for new projects.

- `PROJECT-STATE.md` — living state tracker: phase, locked decisions, watch points, UX principles, open questions, gotchas, pipeline metrics. CC + user maintain together.
- `PROJECT-PLAN.md` — overview, phases, milestones, risk log
- `docs/USER-EXPERIENCE.md` — second-by-second user journey (CC drafts, user reviews)
- `docs/TECH-SPEC.md` — assets, scripts, performance, state machine (CC drafts, user reviews)
- `docs/PROJECT-DECISIONS.md` — log of every inference CC made (for user validation)
- `INSPIRATION/` — user-provided reference images (≥5), with sub-folders for visual-style, motion-references, color-palette-refs, ui-references (CC sorts retroactively if user provides flat folder)
- `project-info/client-brief.md`, `vision-statement.md` — user-provided in concierge mode
