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
- **Pass 0 — Image-to-3D Generation: the skill can now mentor the whole
  chain idea → image → 3D → compression → import → publish**: previously,
  the 3D doctrine started at "you have a .glb"; everything upstream was
  a blank box. New reference file `references/image-to-3d-generation.md`
  covers the first step of the pipeline:
  - **Image requirements with "why"** — background, angle, resolution,
    lighting, subject alone; each requirement explained based on how the
    image-to-3D service segments and generates (less guessing = better
    output).
  - **Prompt → image tips** for ChatGPT Image / Midjourney that
    automatically meet the image requirements; with examples of phrases
    to avoid.
  - **Service selection heuristic** (Meshy / Tripo / Hunyuan3D via fal.ai /
    Rodin) — as a table with best-for / weakness / where it runs. Clearly
    flagged as starting points, not gospel; updated as the skill sees
    more empirical data.
  - **Quality checklist before post-process** — poly-count order, texture
    resolution, typical artifacts (hanging mesh tabs, baked-in shadows,
    smeared surfaces, phantom objects, asymmetry, holes) as explicit
    bullet lists.
  - **Decision point regenerate vs optimize further** — criteria for
    both paths + the principle "optimizing a bad mesh gives you a less
    bad mesh, not a good mesh".
- **Library-first sourcing reinforced in the 3D doctrine**: the agent
  should always start with Snapchat Asset Library / Templates / already-
  imported prefabs before custom 3D generation is suggested. Image-to-3D
  is a fallback — not a default — when the library path genuinely doesn't
  match the user's expectations. Snap-official assets are pre-optimized
  and skip the entire Pass 0–Pass 2 chain; skipping the library check is
  the most common reason a lens unnecessarily lands in the 3D pipeline.
  - Addition in `3d-asset-import-doctrine.md` Section A (agent doctrine)
    and a new Pass 0 block in Section D that points to the new file.
  - Addition in `image-to-3d-generation.md` Section A that catches the
    "library-first didn't match" trigger and reminds about the library
    check as default habit.
- Value for user: the next colleague who wants to create their own 3D
  model from scratch gets mentor support from the first pen stroke —
  which source image, which service, what to look for in the output —
  before optimization even starts. And if the colleague starts with "I
  need something in the scene," the agent suggests the library path
  first; image-to-3D comes as a deliberate choice when the library
  isn't enough, not as a default reflex.
- Files: `references/image-to-3d-generation.md` (new),
  `references/3d-asset-import-doctrine.md` (Section A + Section D Pass 0),
  `SKILL.md` (References pointer + version bump 0.9.0 → 0.10.0)
- Type: [doctrine]

### 💡 2026-05-18 14:20 — [project: rfsu-bang-fortune-lens]
- **GLB post-process: switching the recommended tool from `gltf.report` to
  `optimizeglb.com/dashboard`**: empirical finding from the RFSU project where
  the same clean source .glb produced visible mesh artifacts
  (tearing/distortion) after `gltf.report` optimization — even with lossless
  settings, even with PNG instead of JPEG, and even at 2K texture output.
  The artifacts appeared *in the web tool*, before the file even reached
  Lens Studio, and then carried over. The same source .glb through
  `optimizeglb.com/dashboard` produced clean output without artifacts. The
  doctrine is updated: `optimizeglb.com` is now the primary drag-and-drop
  recommendation for designers; `gltfpack`/`gltf-pipeline` remain as CLI
  alternatives; `gltf.report` is flagged with an "avoid for now" note.
- Value for user: the next colleague who takes in an image-to-3D output
  (Hunyuan3D via fal.ai, Meshy, Tripo, etc.) and needs to shrink the file
  before Lens Studio import gets the right tool directly, avoids iterating
  on the same artifact problem that was solved here. The skill also flags
  clearly that the problem arises in the post-process tool — not in Lens
  Studio — so troubleshooting lands in the right place immediately.
- Files: `references/3d-asset-import-doctrine.md` (Pass 1b section)
- Type: [doctrine-correction]

### 💡 2026-05-18 10:49 — [project: rfsu-bang-fortune-lens]
- **GLB-first 3D import doctrine + two-pass optimization — a systematic way
  to keep lens size under Snap's limit when custom 3D models are imported**:
  an RFSU project showed how quickly a hat FBX could blow up the lens from
  ~3 MB to 34 MB. The skill now has a `references/3d-asset-import-doctrine.md`
  that establishes GLB/glTF as the default format (Snap has a dedicated
  import guide for glTF), with FBX and OBJ as fallback formats. The
  doctrine clarifies the difference between Asset Browser import (resource
  only, prefab must be dragged to the scene) and Scene Hierarchy import
  (resource + instance in one step), and separates the optimization into
  two clear passes:
  - **Pass 1 — before import**: optimize mesh, textures, and format in the
    3D source (whether DCC tool or image-to-3D service), preferably GLB
    with Draco compression
  - **Pass 1b — optional post-process**: `gltf.report` recommended for
    designers (drag-and-drop in browser), `gltfpack`/`gltf-pipeline` for
    CLI folks when Pass 1 wasn't enough
  - **Pass 2 — inside Lens Studio**: BC1/BC3 texture compression per asset
    + Resource Inspector open early in the flow, not at publish time
  
  The skill's internal budget per 3D accessory: ~1 MB compressed. Total
  lens size stays within `SKILL.md`'s Performance budget (≤ 4 MB target,
  8 MB hard limit); 3D-heavy lenses can acceptably land up to ~6 MB.
- Value for user: next time the user imports a custom model, the skill
  starts flagging the size risk *before* the import happens, not when the
  Publishing dialog lights up red. The user also gets a mentor checklist
  that answers four core questions (which format is best, how do I import
  in Lens Studio, what affects lens size, which optimization steps should
  be taken before publish) without having to google the Snap docs. The
  doctrine is tool-agnostic, so it works for both Blender folks and
  designers using image-to-3D services like Meshy, Tripo, or Hunyuan3D
  via fal.ai.
- Files: `references/3d-asset-import-doctrine.md` (new), `SKILL.md` (pointer
  in References + inline sentence in Performance budget + version bump
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
