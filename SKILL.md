---
name: lens-studio-snapchat-filter
description: Builds Snapchat AR Lenses and Sponsored Lenses in Lens Studio 5.20+ with Claude Code, optionally with the Lens Studio MCP server. Covers full pipeline (Phase 0 spec → Phase 5 submission), empirically-validated LS 5.x API patterns, MCP mutation rules (probe+bulk, silent-drop recovery), and Sponsored Lens submission to Snap Ads Manager. TRIGGER when user mentions Lens Studio, Snapchat, filter (in Snap context), Sponsored Lens, AR lens, .esproj/.lens files, Snap Ads Manager, Camera Kit, Bitmoji, or asks help building a Snapchat AR experience. SKIP for TikTok Effect House, Meta Spark, Unity/Unreal AR, native ARKit/ARCore, WebXR, Spectacles AR Object, or generic AR without Snap context. If user says "AR project" without specifying platform, ask first.
---

# Lens Studio Snapchat Filter

Production-tested pipeline for Snapchat AR Lenses and Sponsored Lenses. LS 5.20+, Claude Code, optional Lens Studio MCP server.

## Read these three files first (mandatory, session-start)

1. `references/voice-and-pedagogy.md` — how to talk to the user. Mentor-role IS the product. Apply to every message.
2. `references/operational-discipline.md` — session-opening protocol, mandatory checkpoints, prior-knowledge consultation rule, save-back triggers.
3. `CHANGELOG.md` — scan the last 15–25 entries as an INDEX. For each plausibly relevant entry, OPEN the file it points to and read that section. CHANGELOG without follow-through is trivia.

Then scan `references/` filenames so you know which protocols exist before triggers fire.

## Role split

You (Claude Code) are the **technical + graphical executor**. The user is the **creative director + approver**. Infer design decisions from inspiration, draft specs from the brief, make scene mutations, ask 2–4 targeted questions per phase. Never bundle multiple actions per message; never auto-advance on silence.

## Entry point — first decision

| Situation | Action |
|---|---|
| Brand-new project (no `lens/`, no `PROJECT-STATE.md`) | Concierge mode → onboarding intake |
| `PROJECT-STATE.md` exists | Read it, resume at stated phase |
| `.esproj` exists but no `PROJECT-STATE.md` | Read scene via MCP, infer phase from artifacts |
| User uses build-mode language ("Phase 3 polish", "wire @input", "anchor isn't working") | Skip concierge, go to relevant references |

**Concierge mode** activates only when ALL hold: domain keyword (Snap/Lens/filter-in-Snap-context) + action intent (build/create/help me) + not mid-build. Then: confirm platform → run `references/environment-detection.md` → walk `references/concierge-setup-flow.md` (8 steps, one action per message, wait for confirmation).

**Onboarding intake** (after concierge complete): see `references/onboarding-protocol.md` — 8 questions, 3 groups, ~7 min, gates at Readiness Report.

## Pipeline

Nine phases (0, B, 1, 1.5, 2, 2.5, 3, 4, 5). 2.5 is optional. Each phase has DoD + watch points in `references/phase-progression.md`.

| Phase | Focus | DoD signal |
|---|---|---|
| 0 | Spec drafts, repo, MCP, structure | Specs concrete enough to generate code |
| B | Capability tests for unfamiliar APIs (optional) | Blocking patterns validated |
| 1 | Static scaffolding (NO logic) | First asset + pulse animation in Preview |
| 1.5 | Production copy + custom fonts | Final copy renders correctly |
| 2 | Scripts + animation logic | Tap-to-final-state cycle works |
| 2.5 | Advanced features (face/ML/audio) — brief permitting | Feature toggles without breaking core loop |
| 3 | Polish (magnitude tuning, feel calibration) | User signs off in Preview |
| 4 | Real-device testing (iPhone + mid-range Android) | FPS ≥ 25, lens ≤ 4 MB, LAT < 650 ms |
| 5 | Submission (icon, preview video, ad-account, metadata) | Snap submission accepted |

Per-phase detail, watch-point templates, and pipeline checklist: `references/phase-progression.md`.

## Operational rules (locked, non-negotiable)

Eleven rules. Full rationale and edge cases: `references/operational-rules.md`.

1. **Two-step commit/push gate** — never combine.
2. **⌘S save handshake** — MCP mutations only update LS in-memory; ask user to ⌘S before commit; verify with `git diff lens/`.
3. **Auto-accept read-only, manual approval for destructive** — every mutation/write/install/commit/push needs explicit per-call approval.
4. **Atomic commits** — one logical change per commit.
5. **Scaffold-correct + logic-correct as independent checkpoints** — push static scaffold before building logic.
6. **Probe + bulk mutation pattern** — probe one → read-back → bulk-apply. Never mass-apply unproven patterns.
7. **Concrete values, not generic descriptions** — `anchor.left = -1.8`, not "anchor moves toward edge".
8. **Don't fabricate authority citations** — frame as internal target unless verifiable.
9. **Don't extend scope** — see `references/scope-creep-detection.md` before adding anything.
10. **Lock UX principles before scripting** — declare 3–5 principles before Phase 2. See `references/ux-principle-locking.md`.
11. **Read-back rule** — `success: true` does NOT guarantee persistence. Read back compound/enum/REFERENCE mutations.

## Guiding principles

1. 2D-first; reach for 3D only when brief demands.
2. Tap is primary input; gestures are enhancement.
3. MCP is optional — skip if setup exceeds 90 min.
4. Validate APIs empirically before generating production code.
5. Mid-range Android testing is non-negotiable.
6. MCP token rotates daily — every LS restart issues a new Bearer token. Run `references/mcp-setup.md` reconnect playbook before troubleshooting other things.
7. Hand off "feel" parameters (magnitude, easing, color) to user in LS Inspector via `SetLensStudioSelection`.

## Feature intent detection

Users describe what they want, not what the API is called. Map natural-language intent to a concrete LS primitive, confirm in plain language, then install or script.

**Full intent-map table** (25+ rows: clickable thing → Button, blurry background → GaussianBlurPreset, hand gesture → Hand Gestures template, etc.): `references/intent-mapping.md`.

**Critical** — references are knowledge banks, not literal pattern-match tables. Most briefs phrase intents in their own words ("something that hovers next to the eyes"). Decompose into primitives. Combine across files. Propose like a mentor, not a librarian — describe what the user will experience, not internal recipe IDs. Flag novelty honestly.

**Confirmation pattern**: "I'm reading this as wanting [feature]. I can add [primitive] which [does X]. Match, or did you mean something else?" Wait for explicit yes.

**Deeper recipe lookup**: 30 named recipes across Face/World/Body/Interactive/Commerce/Sponsored in `references/lens-recipe-catalog.md`. Load at brief intake (Phase 0).

## Scope discipline

MVP first, stretch second. Never polish until Phase 4 DoD met. One brief = one lens. Before adding anything not in brief, run the 4-question check in `references/scope-creep-detection.md`.

## Asset sourcing — what you fetch vs what the user provides

**User provides** (you cannot fetch or generate): brand assets (logo, 3D models, mascots, brand fonts), licensed music from outside Snap's library, custom artwork, photo/video references, NDA-protected material.

**You can source** (from Snap-provided libraries): Asset Library items, Snap Music Library tracks, built-in templates, generic geometry/materials, bundled SFX. See `references/asset-library-guide.md` for the 16 Asset Library categories.

Surface this boundary at brief intake in plain mentor language, not as a list. Full phrasing: `references/asset-sourcing-boundary.md`. For brand-themed briefs without provided IP, flag IP licensing at Phase 0, don't proceed quietly.

## Domain context

Snapchat-specific terminology, ad-policy categories, performance gates (LAT < 650 ms is the most-missed Sponsored gate), Bitmoji/Lens Cloud restrictions in Sponsored, brand-mark requirement, related lens types (Community, Spectacles): `references/snap-domain-context.md`.

## Performance budget

| Metric | Valtech target | Valtech hard | Snap gate |
|---|---|---|---|
| Lens size | ≤ 4 MB | 8 MB | 8 MB cap; <4 MB recommended for Sponsored |
| LAT | < 500 ms | 650 ms | **< 650 ms — REQUIRED for ad lenses** |
| FPS (mid-Android) | ≥ 30 | 25 | 30 target / >15 minimum |
| RAM | < 80 MB | 100 MB | 120 MB conservative / 150 MB ceiling |
| Tap-to-feedback | ≤ 3 s | 5 s | — |
| Texture compression | ASTC | — | — |

Deep optimization mechanics, per-asset numeric budgets, anti-patterns, Phase 4 DoD checklist: `references/performance-optimization-guide.md`. 3D-heavy lenses: `references/3d-asset-import-doctrine.md`. Submission compliance: `references/sponsored-lens-submission.md`.

## Project documentation pattern (per-project, created by agent)

**In each client Lens Studio project**, the agent scaffolds: `PROJECT-STATE.md` (living tracker), `PROJECT-PLAN.md`, `docs/USER-EXPERIENCE.md`, `docs/TECH-SPEC.md`, `docs/PROJECT-DECISIONS.md`, `INSPIRATION/` (≥5 reference images, sorted into sub-folders), `project-info/client-brief.md`. These files live in the CLIENT'S project repo, not in the skill. Template scaffold: `assets/project-template/`.

## References (load on demand)

**Communication and pedagogy (read at session-start)**
- `references/voice-and-pedagogy.md` — 8 principles + 3 layers, full templates, glossary translations, mentor-flow patterns, stepped-conversation discipline
- `references/operational-discipline.md` — session-opening protocol, mandatory checkpoints (30-min fallback, 5-failed-attempts, agent-internal triggers), prior-knowledge consultation rule

**Concierge / pre-build**
- `references/environment-detection.md` · `references/concierge-setup-flow.md` · `references/onboarding-protocol.md` · `references/capability-tiers.md` · `references/troubleshooting-decision-tree.md`

**Build pipeline**
- `references/phase-progression.md` · `references/operational-rules.md` · `references/watch-points-methodology.md` · `references/scope-creep-detection.md` · `references/ux-principle-locking.md` · `references/ux-patterns.md` · `references/capability-validation-protocol.md` · `references/prompt-templates.md`

**Architecture / authoring-surface choice (load early)**
- `references/composition-patterns.md` — 8 recurring scene-architecture shapes
- `references/visual-scripting-guide.md` — node graphs vs TypeScript decision
- `references/editor-scripting-api.md` — LS 5.17+ `ExecuteEditorCode`
- `references/material-editor-guide.md` — shader graphs vs built-ins
- `references/graph-authoring-protocol.md` — 4-mode discipline for graph editors

**Scripts / mutations**
- `references/lens-studio-api-gotchas.md` — ~21 empirically-validated 5.x gotchas
- `references/body-anchored-calibration.md` — MANDATORY for any tracker-driven content
- `references/3d-asset-import-doctrine.md` · `references/image-to-3d-generation.md`
- `references/mcp-setup.md` · `references/mcp-tool-schemas.md` · `references/deprecated-api-migration.md`
- `references/sponsored-lens-submission.md` — submission rules, gates, rejection patterns
- `references/lens-recipe-catalog.md` — 30 named recipes
- `references/intent-mapping.md` — natural-language → LS primitive table
- `references/audio-in-lenses.md` · `references/asset-library-guide.md` · `references/bitmoji-integration.md` · `references/remote-apis-integration.md` · `references/performance-optimization-guide.md` · `references/face-effects-deep-dive.md` · `references/vfx-graph-guide.md` · `references/asset-sourcing-boundary.md` · `references/snap-domain-context.md`

**Foundational + cultural**
- `references/snap-docs/` — 365 Snap docs pages, curated into 9 buckets. Use `references/snap-docs/00-INDEX.md` as routing table; don't grep blindly
- `references/_growth-protocol-pointer.md` — pointer to the shared `radon-skill-growth` skill which governs discovery flow-back: generalize, propose, approve, write, commit, push

**User-facing docs**
- `docs/MANUAL-SV.md` · `docs/MANUAL-EN.md` · `docs/INSTALL-REFERENCE.md` · `docs/TROUBLESHOOTING.md`

## Compatibility

Lens Studio 5.20+ (recommended). Claude Code. Optional: Lens Studio MCP server.
