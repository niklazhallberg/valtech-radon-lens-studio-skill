# Changelog

All notable changes to **lens-studio-snapchat-filter** are documented here.

Discoveries från riktiga Valtech-projekt flödar in i [Unreleased]-sektionen
automatiskt via skill-growth-protokollet — se `references/skill-growth-protocol.md`
för in-flow-ask-mekaniken och format-spec.

Vid release: [Unreleased]-entries konsolideras under en `[vX.Y.Z]`-rubrik
med release-datum.

Format löst inspirerat av [Keep a Changelog](https://keepachangelog.com/) men
anpassat för skill-evolution snarare än software-API.

---

## [Unreleased]

_Discoveries från pågående och kommande Valtech-projekt hamnar här._

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

Denna CHANGELOG är skillens biografi — varje rad representerar antingen
en release (manuellt konsoliderad) eller en in-flow discovery från ett
verkligt projekt (automatiskt prepended av agent).

Idén: när en Valtech-kollega om 6 månader scrollar denna fil ska de få
en känsla av momentum. "Vi har lärt oss X i januari, Y i februari, hela
vägen till idag. Det här är inte stillastående — det här växer av sig
självt när vi använder det."

Discoveries över time = compound interest på skill-investering.
