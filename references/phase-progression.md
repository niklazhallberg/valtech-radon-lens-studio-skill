# Phase progression — phase-by-phase detail

Phase-by-phase reference for Snapchat Lens projects. Read the phase relevant to current project state. Phases are sequential except 2.5 (optional, only if brief requires).

## Contents
- Phase 0 — Spec drafts (TECH-SPEC + USER-EXPERIENCE)
- Phase B — Capability tests (optional, before scripting)
- Phase 1 — Static scaffolding
- Phase 1.5 — Production copy + custom fonts
- Phase 2 — Scripts + animation logic
- Phase 2.5 — Advanced features (optional)
- Phase 3 — Polish iterations
- Phase 4 — Real-device testing
- Phase 5 — Submission prep
- Cross-references

---

## Phase 0 — Spec drafts (TECH-SPEC + USER-EXPERIENCE)

**Goal**: spec docs concrete enough to generate code from, plus git/MCP/project structure in place.

### Entry condition

Concierge mode has completed (LS installed, project folder created, MCP registered, brief captured, INSPIRATION populated). 8-question / 3-group onboarding intake complete. Readiness Report approved.

### Tasks

- Read all `project-info/` files (brief, vision-statement)
- Read all `INSPIRATION/` images, infer concrete design decisions (colors, typography, motion, mood)
- Read `brand-assets/` if present
- Surface inferences in `docs/PROJECT-DECISIONS.md` for user validation
- Surface 2-4 targeted clarifying questions (Phase 0 template — see `prompt-templates.md`)
- After user answers: draft `docs/TECH-SPEC.md` (scene hierarchy, scripts, performance, state machine) and `docs/USER-EXPERIENCE.md` (second-by-second user journey)
- Initial git commit of spec drafts
- Lock `lensApplicability` early (e.g., `[Front]` for selfie-only) — see `lens-studio-api-gotchas.md` Category 6 for transient-view pattern when setting via MCP

### Deliverables

- `docs/TECH-SPEC.md` drafted, reviewed, locked
- `docs/USER-EXPERIENCE.md` drafted, reviewed, locked
- `docs/PROJECT-DECISIONS.md` with all CC inferences logged
- `PROJECT-STATE.md` populated with locked decisions
- Git repo committed with Phase 0 baseline
- LS project saved with `lensApplicability` locked

### Typical watch points

1. **Brief interpretation** — CC's draft matches user's vision. Surface full TECH-SPEC draft for read-through.
2. **User journey accuracy** — USER-EXPERIENCE captures the "moment". Surface for review.
3. **Inferred decisions audit** — top 5 inferences read aloud, user can override.

### Anti-patterns

- Editing `.esproj` YAML directly — use MCP tools
- Committing `Cache/`, `Support/`, `Workspaces/`, `PluginsUserPreferences/`, `BackUp/` — these regenerate; the `lens-folder.gitignore` covers them
- Skipping the `lensApplicability` lock — changing it later is annoying

### DoD signal

Specs concrete enough that CC could generate scene-mutation sequence and TypeScript controller code without ambiguity. User has approved drafts.

---

## Phase B — Capability tests (optional)

**Goal**: empirically validate LS 5.x API patterns the lens depends on, BEFORE generating production scripts.

Skip Phase B if all surfaces are known + documented in `lens-studio-api-gotchas.md`. Run Phase B when introducing a new surface (e.g., first use of FaceLiquify, new package, novel TweenScreenTransform pattern).

### Entry condition

Phase 0 DoD met. TECH-SPEC identifies specific API surfaces production code will use.

### Tasks

- List API surfaces the production code will hit (anchors, tweens, tap detection, face binding, etc.)
- For each unfamiliar surface, build minimal test scaffolding (small Screen Image, throwaway script)
- Run on live LS via MCP or manual preview
- Read-back actual behavior; record findings
- Update `docs/TECH-SPEC.md` — replace any `// VERIFY:` markers with empirical findings
- Update `references/lens-studio-api-gotchas.md` if a new general gotcha emerges
- Clean up all test scaffolding before Phase 1

### Deliverables

- Test scaffolding confirming each surface works as expected
- All `// VERIFY:` markers in TECH-SPEC resolved
- Scene clean of test artifacts before Phase 1

### Full protocol

See `capability-validation-protocol.md` for the validation methodology, common failure modes, and stop conditions.

### DoD signal

All blocking API patterns validated. Production code generation in Phase 2 will not encounter "this method doesn't exist" or silent-drop surprises.

### When to skip

- All API surfaces are already documented in `lens-studio-api-gotchas.md`
- TECH-SPEC has zero `// VERIFY:` markers
- LS version unchanged from previous successful build

---

## Phase 1 — Static scaffolding

**Goal**: static "frozen" scene representing the closed-state of the lens — no animation, no scripts.

### Entry condition

Phase 0 DoD met. Phase B done (or skipped with confidence).

### Asset preparation

Standard sizes for Sponsored Lens 2D builds:

| Asset type | Size | Format | Notes |
|---|---|---|---|
| Hero objects (pack, prop) | 1024×1024 | PNG-24 transparent | Soft edges, drop shadow baked in if needed |
| Backgrounds / large surfaces | 1024×512 or 1024×1024 | PNG-24 transparent | Larger dimension along visible axis |
| UI elements (note bg, badges) | 1024×512 typical | PNG-24 transparent | Subtle drop shadow OK |
| Lens icon | 320×320 | PNG | **Simplified graphic — NOT a product photo.** Verify exact spec at developers.snap.com/businesshelp before submission. |

Compression: ASTC, max texture size 1024.

### Scene Hierarchy pattern

Standard layout for tap-to-reveal interactions (adapt per brief — drag mechanics or face-tracking layouts differ):

```
Scene
├─ Camera Object              (default — keep; perspective camera for face-anchored)
├─ Lighting                   (default — keep)
└─ Orthographic Camera        (one new — 2D Sponsored-Lens overlay)
   └─ Full Frame Region
      ├─ [Background/Reveal Group]    (renders behind via renderOrder)
      ├─ [Hero Object Group]          (renders in front, masking the reveal)
      ├─ UI Group                     (always on top — prompts, hints)
      └─ Logic                        (ScriptComponent host, added in Phase 2)
```

z-order via `renderOrder` on visual components (see `lens-studio-api-gotchas.md` → "renderOrder for layering within parent"). NOT via sibling-index manipulation — there's no `setSiblingIndex` mutation.

### Tasks

- Set front-facing camera as default (or per brief — back-facing for some product reveals)
- Build empty Scene Hierarchy with named groups
- Import PNG assets, set ASTC compression and max texture size 1024
- Place objects per composition spec from `docs/USER-EXPERIENCE.md`
- Apply anchors via NUMBER scalar writes (Category 1, NOT RECT compound)
- Lock UX principles per `ux-principle-locking.md` BEFORE Phase 2
- Verify "frozen" closed-state scene visually

### Deliverables

- Static scene matching closed-state of TECH-SPEC
- All assets imported, ASTC-compressed, ≤1024px
- Project size under 2 MB at this stage
- UX principles locked in `PROJECT-STATE.md`
- `lens-studio-snapchat-filter` `.gitignore` patterns in place — verify with `git status`

### Typical watch points

1. **Asset import audit** — table of asset name / size / format / compression status. Pause.
2. **Closed-state layout review** — Preview screenshot, pause for "ok" or adjustment.
3. **Pulse animation feel** (if pulse is in spec) — 3-frame screenshot, pause for magnitude direction.

### Mutations: typical ~20-25

Per RFSU project metrics. Roughly: scene-hierarchy creates (5-8) + asset imports (3-5) + anchor sets (8-12) + initial renderOrder/visual properties (2-5).

### DoD signal

Scene visually matches the post-interaction frozen state from USER-EXPERIENCE.md. No scripts attached yet.

---

## Phase 1.5 — Production copy + custom fonts

**Goal**: replace placeholder copy with final approved strings; bind custom fonts.

### Entry condition

Phase 1 DoD met. Final copy approved by user/client.

### Tasks

- Import font files to `lens/Assets/` (TTF/OTF)
- Configure Text components: font, size, line spacing, color
- Replace placeholder strings with final approved copy
- Verify rendering in Preview (font kerning, line breaks)
- Handle manual line breaks (`\n` in text) where needed
- Commit (atomic — copy/fonts is its own logical unit, Rule 4)

### Deliverables

- Final copy renders correctly in all Text components
- Custom fonts loaded and applied
- Locked in PROJECT-STATE.md "Locked decisions" → typography

### Typical watch points

1. **Copy fidelity** — every Text component shows exactly the approved copy. Surface inline.
2. **Typography correctness** — font, size, line breaks per spec. Visual verification.

### Mutations: typical ~5-10

Font imports + Text component property writes.

### DoD signal

User signs off that copy + fonts render as approved by client.

---

## Phase 2 — Scripts + animation logic

**Goal**: TypeScript controllers + handlers + Inspector wiring; core loop works in Preview.

### Entry condition

Phase 1.5 DoD met. UX principles locked. TECH-SPEC state machine documented.

### Standard outputs

```
lens/Assets/Scripts/
├─ [ControllerName].ts   — state machine, timing, animation orchestration
├─ [HandlerName].ts      — input handling (tap, gesture, etc.)
└─ data.json             — content data (copy variants, message pool, etc.)
```

### Generation rules

- Use validated patterns from `lens-studio-api-gotchas.md` and Phase B findings
- Never generate based on web search or training-data assumptions about LS API surfaces
- All `@input` fields explicitly declared with concrete LS classes (Category 4)
- Use `BaseScriptComponent` and `@component` decorators
- Audio hooks as commented stubs ready for Phase 2.5 (only if brief includes audio)
- Honor locked UX principles — no auto-reset, no countdown, no face-event triggers unless explicit

### Prompt template

```
Generate Lens Studio 5.x scripts for [project description]:

[ControllerName].ts — state machine: [list states]
  @input fields for: [list scene objects + timing values]
[HandlerName].ts — [interaction] handling, gates input during animation
data.json — [content array]

Use validated patterns from lens-studio-api-gotchas.md.
Honor UX principles locked in PROJECT-STATE.md.
```

### Inspector wiring (via MCP after script generation)

After `setProperty(scriptAsset, ..., REFERENCE)`:
- The `inputNames` array auto-populates with each `@input` from the script
- Each name becomes a direct `propertyPath` (no `inputs.X` wrapper)

```graphql
mutation {
  setProperty(id: "<script-component-id>" propertyPath: "<inputName>" valueType: REFERENCE value: "<target-sceneobject-uuid>") { success }
}
```

Run UX-principle code-audit (see `ux-principle-locking.md`) BEFORE committing — grep for `setTimeout`, `FaceEvent`, hardcoded magnitudes outside locked ranges.

### Tasks

- CC generates files based on TECH-SPEC + locked UX principles
- Manual review for LS API method names (cross-check `lens-studio-api-gotchas.md`)
- `RecompileTypeScriptTool` to verify compile success
- Save to `lens/Assets/Scripts/`
- Refresh LS project, then wire @inputs via MCP
- Read-back each @input to confirm REFERENCE bindings stuck (Rule 11)
- Verify core loop in Preview

### Deliverables

- Working lens in LS Preview — tap-to-final-state cycle works
- All @inputs wired with concrete-typed slots filled
- Tween Manager components configured
- UX-principle code-audit passed

### Typical watch points

1. **Script-spec match** — generated TS honors TECH-SPEC state machine. Surface summary, ask "matches?"
2. **@input wiring** — all @input fields populated correctly. Read-back table.
3. **Core loop verification** — 3 key frames of tap → animation → end-state. Surface screenshots.

### Mutations: typical ~30+ + 4-6 script files

Component creation + Inspector wiring + Tween Manager config.

### DoD signal

User can tap in Preview → animation plays → end-state reached → reroll/loop cycle works (if applicable). No FPS issues in Preview yet (test phase comes Phase 4).

---

## Phase 2.5 — Advanced features (optional)

**Goal**: layer in advanced features (face effects, ML packages, audio) without breaking core loop.

### Entry condition

Phase 2 DoD met. Core loop works in Preview. Brief explicitly requires advanced feature.

**Skip if**: brief is core-loop-only, no audio/face-effects/ML mentioned in TECH-SPEC.

### Typical advanced features

- **Face Liquify** — see `lens-studio-api-gotchas.md` → "FaceLiquifyObjectPreset ships with 1 eye + 1 mouth" (mandatory child-2 fix) and "LiquifyVisual must be under perspective Camera"
- **ML packages** (Face Geometry Modification, Hand Detection, etc.) — init-timing fragility; SceneObject must be enabled at scene start if using `onLoadingFinished` callback
- **Audio** — `AudioComponent`, `AudioTrackAsset` import, volume-tuning for mobile playback, sound-on/off detection (many Snap users have sound off)
- **Particle effects** — Visual / particle emitter components
- **AnimationAsset playback** — for prerendered animations

### Tasks

- Add feature components via MCP (`addComponent`, `createSceneObjectFromPreset`)
- For preset-spawned: query full hierarchy immediately + fix child mismatches (see preset gotchas)
- For face effects: verify under perspective Camera Object
- For ML: verify init-timing (enabled SceneObject required for `onLoadingFinished`)
- Test toggle isolation: enable feature → verify core loop still works → disable → verify still works

### Deliverables

- Each advanced feature toggles cleanly without breaking core loop
- Magnitude / intensity within locked UX principle ranges (see `ux-principle-locking.md`)
- Entanglement check: removing the feature doesn't break others (see `error-recovery.md` → "ML / face-tracking entanglement")

### Typical watch points

1. **Feature toggle isolation** — enable, test, disable, test.
2. **ML init timing** — read-back component state to verify enabled at scene start if using callbacks.
3. **Entanglement check** — verify face effects still work after deleting unrelated face-tracking-driven assets.

### Mutations: typical ~20-30

### DoD signal

Each advanced feature works independently. Core loop unaffected by feature toggle.

---

## Phase 3 — Polish iterations

**Goal**: magnitude tuning, feel calibration. User approves each iteration via Inspector handoff.

### Entry condition

Phase 2.5 (if applicable) or Phase 2 DoD met.

### Tasks

- For each parameter user wants to tune (magnitude, easing, color, position fine):
  - Use `SetLensStudioSelection` to direct user to the right SceneObject
  - Hand off to Inspector for live slider tuning (Guiding Principle 7)
  - Read back final values via scene-graphql when user signals "ok"
  - Log decisions in `docs/PROJECT-DECISIONS.md`
- Iterate one dimension at a time (see `prompt-templates.md` Phase 3 template)

### Deliverables

- User-approved magnitudes, easings, colors, positions
- All values logged in PROJECT-DECISIONS.md
- Atomic commit per polish iteration (Rule 4)

### Typical watch points

1. **Magnitude review** per feature — Inspector handoff, user signs off.
2. **Timing review** — Inspector handoff for tween durations.

### DoD signal

User says "lens feels right in Preview". All Phase 3 iterations approved. Ready for device testing.

---

## Phase 4 — Real-device testing

**Goal**: verify on iPhone + mid-range Android. Snap reviews on mid-range Android — desktop preview lies.

### Entry condition

Phase 3 DoD met. User has both an iPhone and a mid-range Android available.

### Tasks

- Pair Lens Studio to phone via Snapchat app
- Test on iPhone first (easier baseline)
- Test on mid-range Android (critical — Snap reviews on these)
- Check FPS in Performance panel (target ≥ 25 on Android, ≥ 30 ideal)
- Verify lens size in Performance panel (≤ 4 MB target, hard limit 8 MB)
- Take screenshots — verify they look "shareable"

### Edge cases to test

- Tap during opening animation (should be ignored or queued correctly per UX principle)
- 10+ rapid interactions in a row (no memory leak, no slowdown)
- Lens loaded in poor lighting (face tracking still works?)
- Different face sizes/distances (if face-tracking)
- Lens loaded right after Snapchat cold start (slowest case)

### Iterate on

- Tween timings if anything feels rushed or sluggish on device
- Scene object positions if user's face gets covered
- Text size if readability fails on small screens
- Texture compression if Performance panel shows oversized assets

### Typical watch points

1. **iPhone baseline** — works as designed. User reports.
2. **Mid-range Android perf** — FPS ≥ 25, lens ≤ 4MB. User reads Performance Panel, surfaces numbers.
3. **Rapid-tap stress** — no memory leak. User performs + reports.

### Phase 4 Definition of Done

Before moving to Phase 5, all must be true:

- [ ] Lens loads in under 2s on mid-range Android (cold start)
- [ ] All interactions trigger correct animations on iPhone
- [ ] All interactions trigger correct animations on mid-range Android
- [ ] FPS ≥ 25 on test Android (verified in Performance panel)
- [ ] Lens size ≤ 4 MB (verified in Performance panel)
- [ ] RAM under 80 MB during sustained use
- [ ] Tap during animation handled gracefully (per locked UX principle)
- [ ] 10+ rapid interactions produce no slowdown or memory leak
- [ ] Lens still functions in poor lighting
- [ ] Screenshots look shareable ("would I post this?" test)

If any item fails, return to iteration. Don't proceed to Phase 5 with open issues — Snap review will catch them and the campaign will be delayed 1-2 weeks (or longer for regulated categories).

---

## Phase 5 — Submission prep

**Goal**: project ready for Snap Ads Manager upload.

### Entry condition

Phase 4 DoD met fully (no exceptions).

### Tasks

- Replace any placeholder content with final approved copy + assets
- Replace placeholder lens icon with final brand-approved design
- Verify lens icon spec — 320×320, simplified graphic, not product photo. Verify exact requirement at developers.snap.com/businesshelp at submission time
- Run final asset audit: no unused files, all textures ASTC-compressed, no test scaffolding remaining
- Generate handover docs (CC produces `client-handover.md` and `submission-checklist.md`)
- Export lens from Lens Studio: `File → Publish Lens`
- Record final preview video for client approval
- Hand over to client / media agency:
  - Lens project file (zipped)
  - Documentation
  - Final preview video
  - Submission checklist
- Media agency uploads to Snap Ads Manager
- Snap ad-review (1-3 business days for general categories; 1-2 weeks for regulated like Sexual Wellness, Alcohol, Gambling, Pharmaceutical)

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
- [ ] If category-restricted (Sexual Wellness, Alcohol, Gambling, Pharmaceutical): copy reviewed against Snap's category policy and US-conservative content guidelines

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
- [ ] Snap Ad Account permissions verified (target Org accessible in Submit panel dropdown)
- [ ] Handed off to media agency for Snap Ads Manager upload

If any item is open, the project is not done — even if it "feels" done. Snap's review process catches gaps and adds 1-2 weeks of delay. Be disciplined here.

### Typical watch points

1. **Icon spec match** — visual review of 320×320 PNG.
2. **Ad-account verification** — confirm dropdown shows expected org.

---

## Cross-references

- `operational-rules.md` — 11 locked policies that apply across all phases
- `watch-points-methodology.md` — how to declare 3-5 watch points per phase
- `ux-principle-locking.md` — lock principles before Phase 2 scripting
- `scope-creep-detection.md` — discipline against feature drift mid-build
- `capability-validation-protocol.md` — full Phase B protocol
- `lens-studio-api-gotchas.md` — API patterns for Phase 1+ implementation
- `mcp-setup.md` — MCP registration + tool patterns
- `error-recovery.md` — when builds break
- `prompt-templates.md` — proven prompts per phase
