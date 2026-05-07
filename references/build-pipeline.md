# Build Pipeline — Phase Detail

Phase-by-phase reference for Snapchat Lens projects. Read the phase relevant to current project state. Phases are sequential — don't skip without reason.

## Contents
- Phase 0 — Setup
- Phase 1 — Scene Hierarchy + assets
- Phase 1.5 — Capability validation
- Phase 2 — Script generation
- Phase 3 — Inspector wiring + animation config
- Phase 4 — Device test + iterate
- Phase 5 — Submission prep

---

## Phase 0 — Setup

Goal: clean project structure with git, Claude Code, and Lens Studio project initialized.

### Tasks

- Create project folder: `~/Projects/[client]-[concept]-lens/`
- `git init`
- Two-layer `.gitignore`: one at repo root, one inside `lens/[ProjectName]/` covering LS-managed paths (`Cache/`, `Support/`, `Workspaces/`, `PluginsUserPreferences/`, `BackUp/`)
- `.gitattributes` with light LFS for `.psd`, `.psb`, `.mov`, `.mp4`
- Create `docs/` folder with project documentation stubs (see `assets/project-template/`)
- Open Lens Studio 5.x → new blank project → save as `lens/[ProjectName]/`
- Lock lens-level decisions early (e.g., `lensApplicability: [Front]` for selfie-only) — see `lens-studio-api-gotchas.md` for the transient-view pattern when setting via MCP
- Start Claude Code from project root
- Set up Lens Studio MCP — see `mcp-setup.md`

### Deliverables

- Working git repo with two-layer ignore strategy
- LS project saved to disk with default scene + camera + lighting rig
- CC running with `lens-studio` MCP server registered and verified `✓ Connected`

### Anti-patterns

- Editing `.esproj` YAML directly — use MCP tools to modify state
- Committing `Cache/` or `Support/` — these regenerate
- Skipping the lens-applicability lock — changing it later is annoying

---

## Phase 1 — Scene Hierarchy + assets

Goal: static "frozen" scene representing the final lens — no animation, no scripts.

### Asset preparation

Standard sizes for Sponsored Lens 2D builds:

| Asset type | Size | Format | Notes |
|---|---|---|---|
| Hero objects (pack, prop, etc.) | 1024×1024 | PNG-24 transparent | Soft edges, drop shadow baked in if needed |
| Backgrounds / large surfaces | 1024×512 or 1024×1024 | PNG-24 transparent | Larger dimension along the visible axis |
| UI elements (note bg, badges) | 1024×512 typical | PNG-24 transparent | Subtle drop shadow OK |
| Lens icon | 320×320 | PNG | **Simplified graphic — NOT a product photo.** Verify exact spec at developers.snap.com/businesshelp before submission. |

Compression: ASTC, max texture size 1024.

### Scene Hierarchy pattern

Standard layout for tap-to-reveal interactions:

```
Scene
├─ Camera Object              (default — keep)
├─ Lighting                   (default — keep)
└─ Orthographic Camera        (one new — 2D Sponsored-Lens overlay)
   └─ Full Frame Region
      ├─ [Background/Reveal Group]    (renders behind)
      ├─ [Hero Object Group]          (renders in front, masking the reveal)
      ├─ UI Group                     (always on top — prompts, hints)
      └─ Logic                        (ScriptComponent host, added in Phase 2)
```

z-order via Scene Hierarchy position — first child renders behind. Use this for "reveal" mechanics instead of separate slide-up tweens.

### Tasks

- Set front-facing camera as default (or other per brief)
- Build empty Scene Hierarchy with named groups
- Import PNG assets, set ASTC compression and max texture size 1024
- Place objects per composition spec from project's USER-EXPERIENCE.md
- Verify "frozen" scene visually before Phase 1.5

### Deliverables

- Static scene that looks like the post-interaction state of the lens
- All assets imported and properly compressed
- Total project size under 2 MB at this stage

---

## Phase 1.5 — Capability validation

Goal: empirically confirm the LS API patterns the lens depends on, BEFORE generating production TypeScript.

This phase is non-negotiable. See `capability-validation-protocol.md` for the full protocol.

Quick rationale: catching a wrong API name now costs 10 minutes; catching it during Phase 2 means rewriting half the controller. LS 5.x API surfaces shift across minor versions and external docs lag. The live LS instance is ground truth.

### Output of this phase

- Test scaffolding (small Screen Images, throwaway scripts) confirming each API the production code will use
- Updates to project's TECH-SPEC.md replacing any `// VERIFY:` markers with empirical findings
- All test scaffolding cleaned up before Phase 2

---

## Phase 2 — Script generation

Goal: TypeScript files ready to drag into Lens Studio.

### Standard outputs

```
lens/Assets/Scripts/
├─ [ControllerName].ts   — state machine, timing, animation orchestration
├─ [HandlerName].ts      — input handling (tap, gesture, etc.)
└─ data.json             — content data (fortunes, copy variants, etc.)
```

### Generation rules

- Use validated patterns from `lens-studio-api-gotchas.md` and the empirical findings from Phase 1.5
- Never generate based on web search or training-data assumptions about LS API surfaces
- All `@input` fields explicitly declared with types matching the Inspector wiring planned in Phase 3
- Use `BaseScriptComponent` and `@component` decorators in TypeScript
- Audio hooks as commented stubs ready for v2 enhancement

### Prompt template

```
Generate Lens Studio 5.x scripts for [project description]:

[ControllerName].ts — state machine: [list states]
  @input fields for: [list scene objects + timing values]
[HandlerName].ts — [interaction] handling, gates input during animation
data.json — [content array]

Use validated patterns from the lens-studio-snapchat-filter skill's
references/lens-studio-api-gotchas.md.
```

### Tasks

- CC generates files
- Manual review for LS API method names (CC sometimes invents these — gotchas file is the cross-check)
- Save to `lens/Assets/Scripts/`
- Refresh LS project to detect new files

---

## Phase 3 — Inspector wiring + animation config

Goal: connect scripts to scene objects, configure tweens to feel right.

### Tasks

- Drag controller script onto a "Logic" Scene Object
- Drag handler script onto the relevant input target
- Add InteractionComponent or TouchComponent as needed
- Fill all `@input` fields by dragging scene objects into Inspector slots, OR via MCP using `setProperty` with REFERENCE valueType
- Configure Tween Manager components per validated tween table from Phase 1.5
- Tune timing values to match project's TECH-SPEC

### Wiring via MCP

After `setProperty(scriptAsset, ..., REFERENCE)`, the `inputNames` array auto-populates with each `@input` from the script, and each name becomes a direct `propertyPath` on the component (no `inputs.X` wrapper). See `lens-studio-api-gotchas.md`.

### Deliverables

- Working lens in Lens Studio preview
- All animations triggered correctly
- Reroll/loop cycles work (if applicable)

---

## Phase 4 — Device test + iterate

Goal: verify on real devices, fix issues, polish feel.

### Why device testing matters

Desktop preview runs at 60+ FPS on any modern computer. Snap's review team and end users primarily use mobile devices, including older Android phones. A lens that runs perfectly in preview can stutter on a 2020 mid-range Android. Mid-range Android testing is non-negotiable for sign-off.

### Tasks

- Pair Lens Studio to phone via Snapchat app
- Test on iPhone first (easier baseline)
- Test on mid-range Android (critical — Snap reviews on these)
- Check FPS in Performance panel (target ≥ 25 on Android)
- Verify lens size in Performance panel (≤ 4 MB target)
- Take screenshots — verify they look "shareable"

### Edge cases to test

- Tap during opening animation (should be ignored or queued correctly)
- Many rapid interactions in a row (no memory leak, no slowdown)
- Lens loaded in poor lighting
- Different face sizes/distances (if face-tracking)
- Lens loaded right after Snapchat cold start (slowest case)

### Iterate on

- Tween timings if anything feels rushed or sluggish
- Scene object positions if user's face gets covered
- Text size if readability fails on small screens

### Phase 4 Definition of Done

Before moving to Phase 5, all must be true:

- [ ] Lens loads in under 2s on mid-range Android (cold start)
- [ ] All interactions trigger correct animations on iPhone
- [ ] All interactions trigger correct animations on mid-range Android
- [ ] FPS ≥ 25 on test Android (verified in Performance panel)
- [ ] Lens size ≤ 4 MB (verified in Performance panel)
- [ ] RAM under 80 MB during sustained use
- [ ] Tap during animation handled gracefully (ignored or queued)
- [ ] 10+ rapid interactions in a row produce no slowdown or memory leak
- [ ] Lens still functions in poor lighting
- [ ] Screenshots look shareable (the "would I post this?" test)

If any item fails, return to iteration. Don't proceed to Phase 5 with open issues — Snap review will catch them and the campaign will be delayed 1–2 weeks.

---

## Phase 5 — Submission prep

Goal: project ready for Snap Ads Manager upload.

### Tasks

- Replace placeholder content with final approved copy and assets
- Replace placeholder lens icon with final brand-approved design
- Verify lens icon spec — 320×320 documented; verify exact requirement at developers.snap.com/businesshelp at submission
- Run final asset audit: no unused files, all textures compressed, no test scaffolding
- Generate handover docs (CC can produce `client-handover.md` and `submission-checklist.md`)
- Export lens from Lens Studio: `File → Publish Lens`
- Record final preview video for client approval
- Hand over to client/media agency:
  - Lens project file
  - Documentation
  - Final preview video
  - Submission checklist
- Media agency uploads to Snap Ads Manager
- Snap ad-review (1–3 business days; longer for regulated categories like Sexual Wellness, Alcohol, Gambling)

### Phase 5 Definition of Done

Submission-ready when ALL of these are true:

**Build quality** (carries over from Phase 4):
- [ ] Lens loads in under 2s on mid-range Android
- [ ] FPS ≥ 25 on test Android
- [ ] Lens size ≤ 4 MB
- [ ] All interactions work as designed

**Content & branding**:
- [ ] All placeholder copy replaced with client-approved final copy
- [ ] All placeholder assets replaced with client-approved final assets
- [ ] Lens icon meets spec (320×320, simplified graphic, not product photo)
- [ ] Brand voice and tone reviewed against client guidelines
- [ ] If category-restricted (Sexual Wellness, Alcohol, Gambling): copy reviewed against Snap's category policy

**Documentation & handover**:
- [ ] `client-handover.md` generated with project overview, file map, edit instructions
- [ ] `submission-checklist.md` generated with everything the media agency needs
- [ ] Final preview video recorded for client approval
- [ ] No unused assets in project
- [ ] All textures ASTC-compressed
- [ ] No test scaffolding remaining in scene
- [ ] Repo committed with clean history, final tag applied

**Submission**:
- [ ] Lens published from Lens Studio (`File → Publish Lens`)
- [ ] Snap Ad Account permissions verified (target Org accessible)
- [ ] Handed off to media agency for Snap Ads Manager upload

If any item is open, the project is not done — even if it "feels" done. Snap's review process catches gaps and adds 1–2 weeks of delay. Be disciplined here.
