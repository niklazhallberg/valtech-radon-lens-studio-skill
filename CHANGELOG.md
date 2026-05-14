# Changelog

All notable changes to **lens-studio-snapchat-filter** are documented here.

Discoveries from real Valtech RADON projects flow into the
"Improvements and newly acquired knowledge" section automatically
via the skill-growth protocol — see `references/skill-growth-protocol.md`
for the in-flow-ask mechanic and format spec.

At release time: those entries are consolidated under a `[vX.Y.Z]`
heading with the release date.

Format loosely inspired by [Keep a Changelog](https://keepachangelog.com/)
but adapted for skill evolution rather than a software API.

---

## Improvements and newly acquired knowledge

_New learnings registered from past or ongoing Valtech RADON projects._

### 💡 2026-05-14 18:22 — [project: demo-face-lens]
- **Skipped items after scene-object deletion**: When paginating
  through all scene objects and deleting one mid-iteration, the
  list skips the next entry. Solution: re-query the list from
  the start after each destructive batch.
- Value for user: Saves at least one bug-hunt where "missing
  object" seems mysterious but is actually just a list that
  shifted between calls.
- File: `references/mcp-tool-schemas.md` § Edge case: allSceneObjects offset
- Type: [demo]

### 💡 2026-05-14 18:21 — [project: demo-foot-lens]
- **Stable anchor when tracker confidence drops**: When a
  body-tracker (foot, hand, face) becomes uncertain about where
  the body part is, the anchor position starts jittering visibly.
  Solution: hide visual content when confidence is low, show it
  again when it stabilizes — with a small margin so it doesn't
  flicker.
- Value for user: Avoids visible jitter when the user moves near
  the camera edge — the final result feels more polished.
- File: `references/body-anchored-calibration.md` § Tracker confidence-tröskel för stabil anchor
- Type: [demo]

### 💡 2026-05-14 18:20 — [project: demo-promo-lens]
- **Parent screen-anchor overrides child position**: When a
  parent object has screen-anchor enabled, it silently overrides
  its children's position every frame. Solution: place a plain
  object between the parent and child — the plain object
  absorbs the anchor override.
- Value for user: Saves 1-2 hours of bug-hunting where "I set
  position to X but nothing shows" seems impossible — when in
  fact the parent's anchor is taking over every frame.
- File: `references/lens-studio-api-gotchas.md` § ScreenTransform parent anchor inheritance
- Type: [demo]

---

## [v0.7.4] — 2026-05-14

### 💡 2026-05-14 18:30 — [project: skill-meta]
- **Warm tone in CHANGELOG + protocol v0.5**: CHANGELOG entries
  now use 💡-emoji, HH:MM timestamp, plain-English description,
  and "Value for user" field. The section title is now
  "Improvements and newly acquired knowledge" instead of
  "[Unreleased]". The protocol template for the agent's in-flow
  ask is rewritten in plain Swedish ("Vi har lärt oss något nytt
  här...") instead of technical "Vi har en discovery..." phrasing —
  the in-flow ask is user-facing chat, so it stays in the user's
  language; the GitHub artifact (CHANGELOG + references files)
  is English-only. Retroactively updated 3 demo entries +
  v0.7.3 entry to the new format.
- Value for user: The CHANGELOG structure becomes readable for
  non-technical colleagues (designers, team leads, leadership).
  The value of each learning is directly visible without having
  to read the file it landed in.
- Files: `CHANGELOG.md`, `references/skill-growth-protocol.md`
- Type: [convention]

---

## [v0.7.3] — 2026-05-14

### 💡 2026-05-14 13:30 — [project: skill-meta]
- **Documentation sync: MCP capability gap-fixes (Tier 1)**:
  Cross-validated an external Perplexity Deep Research report
  (2026-05-13) against existing `references/`. Three Tier 1
  gaps closed:
  - `references/mcp-tool-schemas.md` — new section "Vad MCP
    INTE kan göra" (What MCP cannot do): 11-row UI-only
    operations table, desktop preview limits, per-phase
    implications.
  - `references/mcp-tool-schemas.md` — new section "Officiella
    tool-namn ↔ MCP-client-namn" (Official tool names ↔
    MCP-client names): mapping between Snap's 40+ "normalized
    names" and our 20-tools client capture, with a version-
    disclaimer for LS-version evolution.
  - `references/mcp-setup.md` — Chat Tool Package added as a
    prerequisite (Prerequisites bullet + new Step 2 with
    renumbering 2→3, 3→4, 4→5). Honest about the empirical
    observation that core MCP works without explicit install
    in LS 5.20+.
- Value for user: Three operational MCP gaps closed — a
  designer who hits MCP limits in real projects sees directly
  what MCP can and cannot do, and understands the mapping
  between Snap's official tool names and what they actually
  see in Claude Code.
- Files: `references/mcp-tool-schemas.md`, `references/mcp-setup.md`
- Type: [docs]

---

## [v0.7.2] — 2026-05-14

### 2026-05-14 — [project: skill-meta]
- **VALTECH-PRESENTATION.md tillagd**: självständig översikt över
  skillen för bred Valtech-publik (designer, teamlead, teknikchef,
  beslutsfattare). Sju sektioner inkl. säkerhet och ROI.
  Generaliserad — inga klient- eller personnamn.
- File: `docs/VALTECH-PRESENTATION.md`
- Type: [docs]

### 2026-05-14 — [project: skill-meta]
- **Version convention codified in CONTRIBUTING.md**: `SKILL.md`
  `version:` field tracks minor releases only (0.7 → 0.8). Patch
  releases (0.7.0 → 0.7.1) are tracked via git tag + CHANGELOG entry,
  NOT via SKILL.md-bump. Avoids churn from version-stamp commits on
  small fix-ups. Triggered by v0.7.0/v0.7.1-cycle observation that the
  SKILL.md bump per patch wasn't worth its commit overhead.
- File: `CONTRIBUTING.md` § Version convention
- Type: [convention]

---

## [v0.7.1] — 2026-05-14

### Patch — SKILL.md version fix + Generaliseringsregeln i skill-growth-protocol

**Fix:**
- `SKILL.md` — version 0.6.1 → 0.7.0. Bump var missad i v0.7.0 commit
  `e2dfa45` (commit-meddelandet sa "version 0.6.1 → 0.7.0" men själva
  filändringen inkluderade inte version-bumpen). Korrigerad här.

**Feature:**
- `references/skill-growth-protocol.md` (v0.3 → v0.4) — ny sektion
  "Generaliseringsregeln" insat före in-flow ask. Tre-stegs
  omskrivningsprotokoll:
  1. Identifiera kärnan (projekt-specifikt → universellt mönster)
  2. Ta bort allt projektspecifikt (checklist med explicit ❌/✅)
  3. "Nästa kollega"-test (skulle en kollega på ett annat projekt
     ha nytta av detta?)
  
  Triggad av observation att den tidigare "undvik projektspecifika
  värden"-regeln var för svag — discoveries landade som anekdoter
  snarare än universella regler. Nu en explicit metodologisk regel
  som körs INNAN in-flow ask.

---

## [v0.7.0] — 2026-05-14

### Mentor mode (voice / pace / pedagogy) + cumulative discovery history

Skillens första canonical voice-capture, plus protokollet för hur skillen växer över tid.

**Nya filer:**

- **`references/voice-and-pedagogy.md`** — 8 principer (Believe in user, Guide-not-dictate, Honest about uncertainty, Celebrate progress, Connect over time, Give agency, Value-exchange transparency, Embodied first-person voice) + 3 lager (Voice/Pace/Pedagogy). Worked examples från Samba/adidas-sessionen.
- **`references/glossary-translation.md`** — 19 tekniska termer i klarspråk (GLB, FBX, MCP, scen-hierarki, state machine, Try-On Pack, etc.) + first-use-regel.
- **`references/mentor-flow-patterns.md`** — 7 templates: progress-bar mellan frågor, magic moment celebration, "kom och titta i LS"-inbjudan, "hitta i LS UI"-navigation, long-call mellansnack, embodied screenshot-narration, Inspector handoff.
- **`references/skill-growth-protocol.md`** (v0.3) — in-flow ask för discoveries med colleague-impact-framing; SKILL-DISCOVERIES.md som backup-path; CHANGELOG.md som obligatorisk del av varje discovery-commit.
- **`CHANGELOG.md`** — denna fil. Kumulativ skill-biografi.

**Rewrites / patches:**

- **`references/onboarding-protocol.md`** — announce-structure-omvändning (reverses prior "don't announce 8/3"-regel); Q1.2 (känsla) accepts open answer; Q1.3 (tempo) sensoriska exempel istället för sekunder; Readiness Report plain-language-purpose före filnamn.
- **`references/concierge-setup-flow.md`** — Step 8 öppnar med structure-announcement istället för dold pacing.
- **`references/phase-progression.md`** — magic-moment-checkpoint per phase (0/B/1/1.5/2/2.5/3/4/5) som strukturella krav + översikt-tabell. Phase 3 cross-ref till Template 7.
- **`SKILL.md`** — voice mandate leads (innan role-split). Version 0.6.1 → 0.7.0.
- **`docs/MANUAL.html`** — rebuilt beginner-first 4-step flow (claude.ai/code → terminalen → klistra setup-prompt → följ Claude). 71 KB bilingual → 32 KB svensk single-language. Setup-prompt som magic centerpiece. "Fastnar du?"-sektion med 4 vägar inkl. screenshot-pasta.

---

## [v0.6.1] — 2026-05-13

### Snap-docs mirror + MCP tool schemas + v0.6.0 follow-up patches

Skillens första laser-fokuserade kunskapsbas + canonical MCP-referens.

**Nya filer:**

- **`references/snap-docs/`** — 365 markdown-sidor curated från `developers.snap.com/lens-studio/` (5.x current), organiserade i 9 must-have buckets (MCP, scripting, assets, scene, AR-tracking, try-on, publishing, performance, overview) + nice-to-have/. `00-INDEX.md` som routing-tabell. `.mirror-meta.md` för inventory + maintenance.
- **`references/mcp-tool-schemas.md`** — empirical capture av alla 20 `mcp__lens-studio__*` tool-schemas i 6 kategorier (Scene 3, Asset 6, Panel 2, File/scripting 5, Generation 2, Runtime/Knowledge 2).

**Follow-up patches till v0.6.0** (commit `c8e0a96`):

- `references/body-anchored-calibration.md` — Step 0 "Library-first sourcing" added before hierarchy walk. Feet-sektion leder med library-scan-resultat (Try-On Pack Sneakers + Foot Tracking template).
- `references/mcp-setup.md` — wording-note for `/exit`-restart-instruktion (löser "i terminalen där Claude Code körs"-förvirring).
- `references/concierge-setup-flow.md` Step 7 — inspiration-coaching rewrite med value-exchange + Pinterest/AR-filter-screenshot-exempel.

---

## [v0.6.0] — 2026-05-13

### Body-anchored calibration awareness

Skillens första canonical fil — universal probe-first protokoll för all tracker-driven content (foot, face, head, hand, body, world-anchored).

**Ny fil:**

- **`references/body-anchored-calibration.md`** (committed `74e9b5f`):
  - 8 mandatory steg (hierarchy walk → defensive component disable → asymmetric experiment → tracker-overwrite detection → wrapper-anchor architecture → mesh-pivot awareness → geometry before material → ⌘S handshake)
  - Per-body-part defaults (feet seeded med Try-On Pack Sneakers + Foot Tracking custom component)
  - Real-device pair-test workflow med pair-test-ask-pattern (WHY + WHAT + QUESTION + REASSURANCE)
  - Visual judgment requires correct visual context (screen-coord vs world)
  - Empirisk data: AABB-formel under-kompenserar X med ~15-20%, Y-axeln ska skippas (sole sitter vid Y=0)
  - First seeded från Sponsored Lens foot-AR-build för adidas Samba.

---

## Note on cumulative growth

This CHANGELOG is the skill's biography — each line represents either a
release (manually consolidated) or an in-flow discovery from a real project
(automatically prepended by the agent).

The idea: when a Valtech RADON colleague scrolls this file 6 months from
now, they should feel momentum. "We learned X in January, Y in February,
all the way to today. This isn't standing still — it grows on its own
when we use it."

Discoveries over time = compound interest on skill investment.
