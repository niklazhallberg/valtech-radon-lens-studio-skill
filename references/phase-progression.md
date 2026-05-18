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

## Magic moments — overview

Every phase has ONE defined "magic moment" where something concrete manifests. CC is **REQUIRED** to stop and do a "come look in LS" invite when it happens — not pass silently. Templates: `mentor-flow-patterns.md` Template 2 (celebration) + Template 3 (LS invite).

| Phase | Magic moment | Where the user looks |
|---|---|---|
| 0 | Three planning documents landed. The project has a skeleton. | the `docs/` folder in the editor |
| B | An uncertain LS API feature works empirically. | the LS Preview panel |
| 1 | First visible asset in the scene — the lens is "real". | Scene Hierarchy + Preview |
| 1.5 | Final copy + custom font renders correctly. | the Preview panel |
| 2 | First tap-to-state cycle works. Interactivity born. | Preview (click to see the transition) |
| 2.5 | Advanced feature toggles without breaking the core loop. | Inspector + Preview in parallel |
| 3 | User signs off in Preview — the lens is polished. Phase 3 closed. | Preview + phone, compare against Day 1 screenshot |
| 4 | The lens lives on a REAL phone for the first time. | the Snapchat app + phone camera |
| 5 | Snap accepted the submission. The review clock is ticking. | Snap Ads Manager → Lenses |

Details per phase: see the respective "Magic moment + invite to look" subsection below.

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
- Surface 2–4 targeted clarifying questions (Phase 0 template — see `prompt-templates.md`)
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
- Treating tracker-driven content as "wired = done" before real-device calibration. Desktop LS Preview cannot reliably render tracker-anchored content (see `body-anchored-calibration.md` → "Desktop LS Preview limitations" matrix). Phone pair-test is mandatory ground truth.

### DoD signal

Specs concrete enough that CC could generate scene-mutation sequence and TypeScript controller code without ambiguity. User has approved drafts.

### Magic moment + invite to look

**WHAT just happened:** Three planning documents landed. The project has bones now — not just a brief, a concrete plan.

**REQUIRED invitation (CC must not skip):**

> "Done — we have a plan. Three documents landed in the `docs/` folder: **TECH-SPEC.md** (what we're building), **USER-EXPERIENCE.md** (what the user experiences second-by-second), **PROJECT-DECISIONS.md** (every small inference I made). Open the `docs/` folder in your editor (VS Code, Cursor, Sublime — whichever you like) and read through so you feel what I've planned. Tell me when you're done."

**Why required:** First time the user can SEE the project as something more than a brief. Skipping the invite misses the project's first concrete artifact moment.

**Patterns:** `mentor-flow-patterns.md` Template 2 (Magic moment celebration) + Template 3 ("Come look" invitation).

---

## Phase B — Capability tests (optional)

**Goal**: empirically validate LS 5.x API patterns the lens depends on, BEFORE generating production scripts.

Skip Phase B if all surfaces are known + documented in `lens-studio-api-gotchas.md`. Run Phase B when introducing a new surface (e.g., first use of FaceLiquify, new package, novel TweenScreenTransform pattern).

### Entry condition

Phase 0 DoD met. TECH-SPEC identifies specific API surfaces production code will use.

### Pre-flight: distinguish Easy Lens panel features from scriptable primitives (LS 5.21+)

LS 5.21+ "Easy Lens X" features — Easy Lens Button, Easy Lens Blur, Easy Lens Colored Background, Easy Lens 2D Physics, Easy Lens SFX library, plus Text3D Animator, Progress Bar, Glasses collection, Bitmoji Stickers, GenAI Body Generator — are **panel-level features** inside the Easy Lens / AI Creator UI, not discrete Asset Library installables. CC cannot drive the Easy Lens panel via MCP — only the underlying primitive CustomComponents.

Before recommending any 5.21 feature to a client, classify it:

1. `scene-graphql { presets(nameContains: "...") }` — does a native preset exist?
2. `ListInstalledPackagesTool` — is the underlying primitive already installed?
3. `SearchLensStudioAssetLibrary([feature name])` — find the closest discrete primitive (e.g. "Easy Lens Button" → `Button` v1.0.1 CustomComponent, probed 2026-05-12).
4. Place the feature into one of:
   - **(a) Native preset present** — script directly via scene-graphql (e.g. `GaussianBlurPreset`).
   - **(b) Primitive installed / installable** — install + script the CustomComponent (e.g. `Button` v1.0.1).
   - **(c) Neither present** — propose install path before script-generation; don't promise the feature until install + probe confirms.

The "all 5.21 features are Asset Library blocks" framing is a working hypothesis, NOT a confirmed pattern — classify each feature individually. Cross-references: `lens-studio-api-gotchas.md` → "Easy Lens panel features vs MCP-scriptable primitives" for the empirical Button v1.0.1 surface (and the `animtionType` typo'd-key gotcha); `capability-tiers.md` → "Tier 1 nuance" for the Tier 1 boundary; SKILL.md → "Feature intent detection" for the natural-language-to-primitive mapping.

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

### Magic moment + invite to look

**WHAT just happened:** An LS API feature you were uncertain about WORKS empirically — verified in your specific LS version, not just assumed from docs.

**REQUIRED invitation (CC must not skip):**

> "Phase B done — [feature/API] works empirically in your LS version. Open the Preview panel and you'll see the test artifact running. We now know [feature] isn't a silent-drop or a stale-doc feature, so Phase 2 can generate production code without worry. The test scaffolding is cleaned up before we move to Phase 1 — the scene is empty again."

**Why required:** Phase B is where uncertainty becomes certainty. Passing that turning point silently leaves the user without visual confirmation of the learning that just landed.

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

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

- **If TECH-SPEC includes body-anchored / tracker-driven content** (Foot Tracking, Face Mesh, Head Binding, Hand Tracking, full-body, world-anchored): read `body-anchored-calibration.md` FIRST and follow its probe-first protocol. This is mandatory before any other Phase 1 scaffolding for tracker-driven content.
- Set front-facing camera as default (or per brief — back-facing for some product reveals)
- Build empty Scene Hierarchy with named groups
- Import PNG assets, set ASTC compression and max texture size 1024
- Place objects per composition spec from `docs/USER-EXPERIENCE.md`
- Apply anchors via NUMBER scalar writes (Category 1, NOT RECT compound)
- Lock UX principles per `ux-principle-locking.md` BEFORE Phase 2
- Verify "frozen" closed-state scene visually
- For tracker-driven content: complete real-device calibration using the probe-first protocol from `body-anchored-calibration.md` BEFORE moving to Phase 1.5

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

### Mutations: typical ~20–25

Per RFSU project metrics. Roughly: scene-hierarchy creates (5–8) + asset imports (3–5) + anchor sets (8–12) + initial renderOrder/visual properties (2–5).

### DoD signal

Scene visually matches the post-interaction frozen state from USER-EXPERIENCE.md. No scripts attached yet.

**Additional DoD for tracker-driven content**: real-device calibration completed using the probe-first protocol from `body-anchored-calibration.md`. For paired-symmetry content (left/right shoes, earrings, rings, etc.): both sides calibrated and user signs off in phone pair-test (not desktop preview). Final calibration values + camera-pose documented.

### Magic moment + invite to look

**WHAT just happened:** First visible asset is now in your scene. The lens has a *body* — not just a spec on paper. Phase 1's scaffolding is real.

**REQUIRED invitation (CC must not skip):**

> "The Phase 1 scaffolding landed — **your lens scene is real now**. Camera + [asset-name] + lighting, all in place.
>
> Open Scene Hierarchy (left panel in LS) — you see the [asset-name] node under camera. Click it and it's selected in Scene Editor; properties show up in Inspector (right).
>
> Then Preview (or the panel showing render output) — you see the asset onscreen. This is the skeleton we'll build on.
>
> Tell me when you've oriented yourself and we'll keep going."

**Why required:** Phase 1 is the first time the user sees their lens as ONE object in the world. Passing silently past first-visible-asset breaks `voice-and-pedagogy.md` #4 (Celebrate progress) + #8 (Embodied voice).

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

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

### Mutations: typical ~5–10

Font imports + Text component property writes.

### DoD signal

User signs off that copy + fonts render as approved by client.

### Magic moment + invite to look

**WHAT just happened:** Final copy + custom fonts render. The text looks the way it should in production.

**REQUIRED invitation (CC must not skip):**

> "Phase 1.5 done — final copy + fonts landed. Open Preview and read through all the texts. Typeface, position, line breaks, size — everything matches the spec. This is how the lens will read for the end user. Say if anything doesn't sit right; otherwise we move on to scripting."

**Why required:** Typography is a sensitive design decision. The user has the final word on typeface + line breaks; passing this moment without an invite robs the user of design agency (`voice-and-pedagogy.md` #6).

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

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

### Mutations: typical ~30+ + 4–6 script files

Component creation + Inspector wiring + Tween Manager config.

### DoD signal

User can tap in Preview → animation plays → end-state reached → reroll/loop cycle works (if applicable). No FPS issues in Preview yet (test phase comes Phase 4).

### Magic moment + invite to look

**WHAT just happened:** First tap-to-state cycle works. Interactivity born. The lens reacts to you now — not just hangs there.

**REQUIRED invitation (CC must not skip):**

> "Phase 2 done — **the core loop is alive**. Open Preview and tap anywhere on it. You see [animation/state-change] — the lens reacts to you now. Tap again to see the reroll/loop cycle (if there is one).
>
> This is the heart of the lens — if this feels right, the rest is fine-tuning. Tell me what you see; if anything feels off-feel, that goes to Phase 3 polish."

**Why required:** First interactive cycle is one of the biggest emotional moments in the entire project. The lens has crossed from "static scene" to "responsive thing". Silence here = robot voice (`voice-and-pedagogy.md` #4 + #8).

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

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

### Mutations: typical ~20–30

### DoD signal

Each advanced feature works independently. Core loop unaffected by feature toggle.

### Magic moment + invite to look

**WHAT just happened:** Advanced feature toggles without breaking the core loop. Complexity handled without destroying what was already working.

**REQUIRED invitation (CC must not skip):**

> "Phase 2.5 done — [feature] works in parallel with the core loop. Open Inspector, toggle the [feature] component on/off — Preview switches live. Confirms that Phase 2's logic still holds even with extra complexity on top. Tell me when you've verified and we'll move to Phase 3 polish."

**Why required:** Phase 2.5 is a double-risk moment — it could have broken the core loop. NOT inviting the user to confirm isolation = leaves them unsure about the build's stability.

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

---

## Phase 3 — Polish iterations

**Goal**: magnitude tuning, feel calibration. User approves each iteration via Inspector handoff.

### Entry condition

Phase 2.5 (if applicable) or Phase 2 DoD met.

### Tasks

- For each parameter user wants to tune (magnitude, easing, color, position fine):
  - Use `SetLensStudioSelection` to direct user to the right SceneObject
  - Hand off to Inspector for live slider tuning — apply `mentor-flow-patterns.md` Template 7 (Inspector handoff) for the invite-pattern: name the panel, frame it as a learning moment, ask for screenshot/values back
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

### Magic moment + invite to look

**WHAT just happened:** User signs off in Preview — the lens is polished. Phase 3 closed.

**REQUIRED invitation (CC must not skip):**

> "Take one last look in Preview and on the phone. Compare against the Day 1 screenshot if you have it. Say 'approved' when you're happy — then Phase 3 is done and we package for submission."

**Why required:** Phase 3 is the endpoint of the entire polish journey. Passing silently past end-of-phase = the emotional payoff for all the iteration work disappears.

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

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

### Magic moment + invite to look

**WHAT just happened:** The lens lives on a REAL phone for the first time. **THIS is the moment everything turns** — from Lens Studio Preview to a real phone, real light, real hands.

**REQUIRED invitation (CC must not skip):**

> "Phase 4 first pair-test — **THIS is the moment everything turns**.
>
> Open the Snapchat app on the phone, scan the pair code (or find the lens in your Try tab). You see your filter in the camera NOW, in real life. Turn the phone, move in front of the camera, tap.
>
> Stop reading this for a moment — live with the lens in the world for a couple of minutes before you come back. Tell me what happens (FPS, feel, edge cases) when you're done."

**Why required:** Phase 4 first device test is THE watershed moment in the entire lens project. The skill's voice mandate (Celebrate progress + Embodied voice) is literally written FOR this moment. Skipping it = the entire mentor-tone effort is wasted.

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

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
- Snap ad-review (1–3 business days for general categories; 1–2 weeks for regulated like Sexual Wellness, Alcohol, Gambling, Pharmaceutical)

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

If any item is open, the project is not done — even if it "feels" done. Snap's review process catches gaps and adds 1–2 weeks of delay. Be disciplined here.

### Typical watch points

1. **Icon spec match** — visual review of 320×320 PNG.
2. **Ad-account verification** — confirm dropdown shows expected org.

### Magic moment + invite to look

**WHAT just happened:** Snap accepted the submission. The review clock is ticking. All the work is submitted.

**REQUIRED invitation (CC must not skip):**

> "Phase 5 done — **the lens is submitted**. Open Snap Ads Manager (ads.snapchat.com) → Lenses → [client]. You see the lens listed with Status: 'Pending Review' or 'In Review'. Snap's team reviews within 1–3 days (general category) or 1–2 weeks (regulated).
>
> When the status flips to 'Approved' or 'Live' — that's when the project is actually done. Until then: breathe out. You've shipped."

**Why required:** Phase 5's magic is the "submitted" moment. Passing silently past it = the user loses the feeling of "done" stamp on the project.

**Patterns:** `mentor-flow-patterns.md` Template 2 + Template 3.

---

## Cross-references

- `operational-rules.md` — 11 locked policies that apply across all phases
- `watch-points-methodology.md` — how to declare 3–5 watch points per phase
- `ux-principle-locking.md` — lock principles before Phase 2 scripting
- `scope-creep-detection.md` — discipline against feature drift mid-build
- `capability-validation-protocol.md` — full Phase B protocol
- `lens-studio-api-gotchas.md` — API patterns for Phase 1+ implementation
- `body-anchored-calibration.md` — MANDATORY for any tracker-driven content (foot, face, hand, head, full-body, world-anchored). Universal probe-first protocol + per-body-part defaults. Read FIRST for Phase 1 builds involving body or world tracking.
- `mcp-setup.md` — MCP registration + tool patterns
- `error-recovery.md` — when builds break
- `prompt-templates.md` — proven prompts per phase
