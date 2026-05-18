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

### 💡 2026-05-18 15:05 — [project: skill-meta]
- **Pass 0 — Image-to-3D Generation: skillen kan nu mentorera hela kedjan
  idé → bild → 3D → komprimering → import → publish**: tidigare började
  3D-doktrinen vid "du har en .glb"; allt uppströms var en blank ruta.
  Ny referensfil `references/image-to-3d-generation.md` täcker det första
  steget i pipelinen:
  - **Bildkrav med "varför"** — bakgrund, vinkel, upplösning, belysning,
    motivet ensamt; varje krav förklarat utifrån hur image-to-3D-tjänsten
    segmenterar och genererar (mindre gissning = bättre output).
  - **Prompt → bild-tips** för ChatGPT Image / Midjourney som
    automatiskt uppfyller bildkraven; med exempel på fraser att undvika.
  - **Tjänsteval-heuristik** (Meshy / Tripo / Hunyuan3D via fal.ai /
    Rodin) — som tabell med bäst-för / svaghet / var den körs. Tydligt
    flaggad som startpunkter, inte facit; uppdateras när skillen ser
    mer empiri.
  - **Kvalitetschecklista innan post-process** — poly-count-ordning,
    texturupplösning, typiska artefakter (hängande mesh-flikar, inbakade
    skuggor, smetade ytor, phantom-objekt, asymmetri, hål) som explicita
    punktlistor.
  - **Beslutspunkt generera om vs optimera vidare** — kriterier för
    bägge vägarna + principen "att optimera en dålig mesh ger en mindre
    dålig mesh, inte en bra mesh".
- **Library-first sourcing förstärkt i 3D-doktrinen**: agenten ska alltid
  börja med Snapchat Asset Library / Templates / redan importerade
  prefabs innan custom 3D-generering föreslås. Image-to-3D är fallback —
  inte default — när library-vägen genuint inte motsvarar användarens
  förväntningar. Snap-officiella assets är pre-optimerade och slipper
  hela Pass 0–Pass 2-kedjan; att hoppa över library-checken är den
  vanligaste anledningen till att en lens onödigt landar i 3D-pipelinen.
  - Tillägg i `3d-asset-import-doctrine.md` Section A (agent doctrine)
    och nytt Pass 0-block i Section D som pekar till nya filen.
  - Tillägg i `image-to-3d-generation.md` Section A som tar emot
    "library-first matchade inte"-triggern och påminner om
    library-checken som default-vana.
- Value for user: nästa kollega som vill skapa en helt egen 3D-modell
  får mentor-stöd från första pennstrecket — vilken källbild, vilken
  tjänst, vad man tittar efter i output — innan optimering ens börjar.
  Och om kollegan börjar med "jag behöver något i scenen" föreslår
  agenten library-vägen först; image-to-3D kommer som ett medvetet val
  när library inte räcker, inte som default-reflex.
- Files: `references/image-to-3d-generation.md` (ny),
  `references/3d-asset-import-doctrine.md` (Section A + Section D Pass 0),
  `SKILL.md` (References-pointer + version bump 0.9.0 → 0.10.0)
- Type: [doctrine]

### 💡 2026-05-18 14:20 — [project: rfsu-bang-fortune-lens]
- **GLB post-process: byter rekommenderat verktyg från `gltf.report` till
  `optimizeglb.com/dashboard`**: empiriskt fynd från RFSU-projektet där samma
  ren källa-.glb gav synliga mesh-artifakter (tearing/distortion) efter
  `gltf.report`-optimering — även med lossless-inställningar, även med PNG
  istället för JPEG, och även på 2K-textur-output. Artifakterna uppstod *i
  webbverktyget*, innan filen ens nådde Lens Studio, och följde sedan med
  vidare. Samma källa-.glb genom `optimizeglb.com/dashboard` gav ren output
  utan artifakter. Doktrinen uppdaterad: `optimizeglb.com` är nu primär
  drag-and-drop-rekommendation för designers; `gltfpack`/`gltf-pipeline`
  kvar som CLI-alternativ; `gltf.report` flaggat med "undvik just nu"-not.
- Value for user: nästa kollega som tar in en image-to-3D-output (Hunyuan3D
  via fal.ai, Meshy, Tripo m.fl.) och behöver krympa filen innan
  Lens Studio-import får direkt rätt verktyg, slipper iterera på samma
  artifakt-problem som löstes här. Skillen flaggar också tydligt att
  problemet uppstår i post-process-verktyget — inte i Lens Studio — så
  felsökningen hamnar på rätt ställe direkt.
- Files: `references/3d-asset-import-doctrine.md` (Pass 1b-sektionen)
- Type: [doctrine-correction]

### 💡 2026-05-18 10:49 — [project: rfsu-bang-fortune-lens]
- **GLB-first 3D import doctrine + två-pass optimization — systematiskt sätt
  att hålla lens size under Snaps gräns när egna 3D-modeller importeras**:
  ett RFSU-projekt visade hur snabbt en hatt-FBX kunde blåsa upp lensen från
  ~3 MB till 34 MB. Skillen får nu en `references/3d-asset-import-doctrine.md`
  som etablerar GLB/glTF som default-format (Snap har dedikerad importguide
  för glTF), med FBX och OBJ som fallback-format. Doktrinen klargör
  skillnaden mellan Asset Browser-import (resource only, prefab måste dras
  till scenen) och Scene Hierarchy-import (resource + instans i ett steg),
  och separerar optimeringen i två tydliga pass:
  - **Pass 1 — före import**: optimera mesh, texturer och format i
    3D-källan (oavsett om det är DCC-verktyg eller image-to-3D-service),
    gärna GLB med Draco-kompression
  - **Pass 1b — valfri post-process**: `gltf.report` rekommenderas för
    designers (drag-and-drop i browser), `gltfpack`/`gltf-pipeline` för
    CLI-folk när Pass 1 inte räckte
  - **Pass 2 — inne i Lens Studio**: BC1/BC3 texture compression per asset
    + Resource Inspector öppen tidigt i flödet, inte vid publish
  
  Skillens interna budget per 3D-accessoar: ~1 MB komprimerat. Total
  lens-size håller sig till `SKILL.md`'s Performance budget (≤ 4 MB target,
  8 MB hård gräns); 3D-tunga lenser kan acceptabelt landa upp till ~6 MB.
- Value for user: nästa gång användaren tar in en custom-modell börjar
  skillen flagga storleksrisken *innan* importen sker, inte när
  Publishing-dialogen lyser rött. Användaren får också en mentor-checklista
  som svarar på fyra kärnfrågor (vilket format är bäst, hur importerar jag
  i Lens Studio, vad påverkar lens size, vilka optimeringssteg ska tas
  innan publish) utan att behöva googla Snap-docsen. Doktrinen är
  verktygsagnostisk så den fungerar för både Blender-folk och designers
  som använder image-to-3D-services som Meshy, Tripo eller Hunyuan3D
  via fal.ai.
- Files: `references/3d-asset-import-doctrine.md` (ny), `SKILL.md` (pointer
  i References + inline-mening i Performance budget + version bump
  0.8.0 → 0.9.0)
- Type: [doctrine]

---

## [v0.8.0] — 2026-05-15

### 💡 2026-05-15 10:35 — [project: skill-meta]
- **One-line installer + auto-sync — non-technical designers can onboard
  themselves**: Three pieces that together close the "designer can't set up
  the skill alone" gap.
  - `bin/install.sh` — idempotent installer with mentor-tone output. Nine
    steps: OS check, Node.js/git pre-reqs, Claude Code install, Lens Studio
    verify, skill clone check, SessionStart hook config (via Python
    JSON-merge so existing settings are preserved), state folder, smoke test,
    success summary. Fail-fast with concrete recovery instructions per step.
  - `scripts/session-sync.sh` — SessionStart hook that runs `git pull --ff-only`
    on the skill repo when Claude Code starts. Silent on no-op, friendly
    inline announcement when new entries arrive. Pull-only, never pushes.
  - `README.md` — new "Auto-sync" section documenting the mechanic so
    colleagues understand what they see when the hook fires.
- Value for user: A designer who has been invited as a collaborator can now
  go from zero to working `claude` session in 2–3 minutes — without a
  technical colleague holding their hand. And once installed, every new
  lesson pushed by any colleague reaches their machine automatically the next
  time they open Claude Code. The compound-interest promise becomes real
  instead of aspirational.
- Files: `bin/install.sh`, `scripts/session-sync.sh`, `README.md`, `SKILL.md` (version bump 0.7.0 → 0.8.0)
- Type: [feature]

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
- **VALTECH-PRESENTATION.md added**: standalone overview of the
  skill for a broad Valtech audience (designer, team lead, tech
  lead, decision-maker). Seven sections including security and
  ROI. Generalized — no client or personal names.
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

### Patch — SKILL.md version fix + Generaliseringsregeln in skill-growth-protocol

**Fix:**
- `SKILL.md` — version 0.6.1 → 0.7.0. The bump was missed in v0.7.0
  commit `e2dfa45` (the commit message said "version 0.6.1 → 0.7.0"
  but the file change itself didn't include the version bump).
  Corrected here.

**Feature:**
- `references/skill-growth-protocol.md` (v0.3 → v0.4) — new section
  "Generaliseringsregeln" (Generalization rule) inserted before the
  in-flow ask. Three-step rewrite protocol:
  1. Identify the core (project-specific → universal pattern)
  2. Remove everything project-specific (checklist with explicit ❌/✅)
  3. "Next colleague" test (would a colleague on a different project
     benefit from this?)
  
  Triggered by the observation that the earlier "avoid project-
  specific values" rule was too weak — discoveries landed as
  anecdotes rather than universal rules. Now an explicit
  methodological rule that runs BEFORE the in-flow ask.

---

## [v0.7.0] — 2026-05-14

### Mentor mode (voice / pace / pedagogy) + cumulative discovery history

The skill's first canonical voice capture, plus the protocol for how the skill grows over time.

**New files:**

- **`references/voice-and-pedagogy.md`** — 8 principles (Believe in user, Guide-not-dictate, Honest about uncertainty, Celebrate progress, Connect over time, Give agency, Value-exchange transparency, Embodied first-person voice) + 3 layers (Voice/Pace/Pedagogy). Worked examples from the foot-tracking Sponsored Lens session.
- **`references/glossary-translation.md`** — 19 technical terms in plain language (GLB, FBX, MCP, scene hierarchy, state machine, Try-On Pack, etc.) + first-use rule.
- **`references/mentor-flow-patterns.md`** — 7 templates: progress bar between questions, magic-moment celebration, "come and look in LS" invitation, "find it in the LS UI" navigation, long-call mid-talk, embodied screenshot narration, Inspector handoff.
- **`references/skill-growth-protocol.md`** (v0.3) — in-flow ask for discoveries with colleague-impact framing; SKILL-DISCOVERIES.md as backup path; CHANGELOG.md as mandatory part of every discovery commit.
- **`CHANGELOG.md`** — this file. Cumulative skill biography.

**Rewrites / patches:**

- **`references/onboarding-protocol.md`** — announce-structure reversal (reverses the prior "don't announce 8/3" rule); Q1.2 (feeling) accepts open answer; Q1.3 (tempo) sensory examples instead of seconds; Readiness Report plain-language purpose before filename.
- **`references/concierge-setup-flow.md`** — Step 8 opens with structure announcement instead of hidden pacing.
- **`references/phase-progression.md`** — magic-moment checkpoint per phase (0/B/1/1.5/2/2.5/3/4/5) as structural requirements + overview table. Phase 3 cross-ref to Template 7.
- **`SKILL.md`** — voice mandate leads (before role-split). Version 0.6.1 → 0.7.0.
- **`docs/MANUAL.html`** — rebuilt beginner-first 4-step flow (claude.ai/code → terminal → paste setup prompt → follow Claude). 71 KB bilingual → 32 KB Swedish single-language. Setup prompt as the magic centerpiece. "Stuck?" section with 4 paths including screenshot paste.

---

## [v0.6.1] — 2026-05-13

### Snap-docs mirror + MCP tool schemas + v0.6.0 follow-up patches

The skill's first laser-focused knowledge base + canonical MCP reference.

**New files:**

- **`references/snap-docs/`** — 365 markdown pages curated from `developers.snap.com/lens-studio/` (5.x current), organized in 9 must-have buckets (MCP, scripting, assets, scene, AR-tracking, try-on, publishing, performance, overview) + nice-to-have/. `00-INDEX.md` as routing table. `.mirror-meta.md` for inventory + maintenance.
- **`references/mcp-tool-schemas.md`** — empirical capture of all 20 `mcp__lens-studio__*` tool schemas in 6 categories (Scene 3, Asset 6, Panel 2, File/scripting 5, Generation 2, Runtime/Knowledge 2).

**Follow-up patches to v0.6.0** (commit `c8e0a96`):

- `references/body-anchored-calibration.md` — Step 0 "Library-first sourcing" added before hierarchy walk. Feet section leads with library-scan result (Try-On Pack Sneakers + Foot Tracking template).
- `references/mcp-setup.md` — wording note for the `/exit` restart instruction (resolves the "in the terminal where Claude Code runs" confusion).
- `references/concierge-setup-flow.md` Step 7 — inspiration coaching rewrite with value-exchange + Pinterest/AR-filter screenshot examples.

---

## [v0.6.0] — 2026-05-13

### Body-anchored calibration awareness

The skill's first canonical file — universal probe-first protocol for all tracker-driven content (foot, face, head, hand, body, world-anchored).

**New file:**

- **`references/body-anchored-calibration.md`** (committed `74e9b5f`):
  - 8 mandatory steps (hierarchy walk → defensive component disable → asymmetric experiment → tracker-overwrite detection → wrapper-anchor architecture → mesh-pivot awareness → geometry before material → ⌘S handshake)
  - Per-body-part defaults (feet seeded with Try-On Pack Sneakers + Foot Tracking custom component)
  - Real-device pair-test workflow with pair-test-ask pattern (WHY + WHAT + QUESTION + REASSURANCE)
  - Visual judgment requires correct visual context (screen-coord vs world)
  - Empirical data: AABB formula under-compensates X by ~15-20%, Y-axis should be skipped (sole sits at Y=0)
  - First seeded from a foot-tracking Sponsored Lens build.

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
