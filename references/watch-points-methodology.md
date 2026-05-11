# Watch-points methodology

Pre-declared soft pauses within a phase. The user's explicit gates where CC pauses and surfaces material for review. Not the same as phase gates (which are hard stops between phases).

## Contents
- Definition: watch points vs phase gates
- Declaration template
- 5-question framework for identifying watch points
- Examples per phase
- Anti-patterns

## Definition: watch points vs phase gates

**Phase gate** (hard stop): the boundary between phases. CC does not cross it without explicit "go phase N+1" from user. Phase-DoD-driven.

**Watch point** (soft pause): a checkpoint INSIDE a phase where CC stops mid-work to surface output and wait for user verification before continuing. User-declared per-phase.

Example contrast in Phase 1 (Static scaffolding):

- **Phase gate**: cannot enter Phase 2 until all of Phase 1 DoD met
- **Watch points within Phase 1**:
  1. After importing assets but before placing them in scene
  2. After building scene hierarchy but before applying anchors
  3. After Closed-State layout but before pulse animation

User declares the 3 watch points at Phase 1 start. CC honors them — pauses + surfaces at each.

## Declaration template

User-facing format (CC reads this from `PROJECT-STATE.md` "Watch points" section):

```markdown
## Watch points (user-tracked checkpoints — do NOT skip)

Active for Phase [N].

1. **<name>** — Watch: <what>. When: <which step>. Action: CC <what>.
2. **<name>** — Watch: <what>. When: <which step>. Action: CC <what>.
3. **<name>** — Watch: <what>. When: <which step>. Action: CC <what>.
```

CC commits to honoring these exactly. When CC reaches the "When" condition, it stops, runs the "Action", and waits for user signal to continue.

Example concrete declaration (Phase 1 of a tap-to-reveal lens):

```markdown
## Watch points — Phase 1

1. **Asset import audit** — Watch: all PNGs imported as FileTexture, ASTC-compressed, max 1024px. When: after asset import. Action: CC surfaces table of asset name → size → format → compression status. Pause for "ok".

2. **Closed-state layout review** — Watch: pack centered, prop tucked, prompt visible. When: after positioning but before animation wiring. Action: CC takes preview screenshot via CapturePanelScreenshotTool and surfaces inline. Pause for "ok" or position adjustment direction.

3. **Pulse animation feel** — Watch: pulse is inviting, not aggressive. When: after pulse tween wired. Action: CC takes 3-frame screenshot sequence + surfaces. Pause for "feels right" or magnitude direction.
```

## 5-question framework for identifying watch points

At the start of each phase, ask:

| Question | Purpose | Typical watch-point output |
|---|---|---|
| 1. What's the highest-risk single decision in this phase? | Identify architectural risk | "Watch point: scene hierarchy structure before anchors applied" |
| 2. Where will CC drift from spec? | Catch scope creep | "Watch point: after script generation, before Inspector wiring — confirm @input fields match spec" |
| 3. What's the most likely silent failure mode? | Prevent undetectable bugs | "Watch point: after every compound-type setProperty — read-back check" |
| 4. What needs real-device testing CC can't simulate? | Platform-specific issues | "Watch point: Phase 4 Android FPS verification — user runs on Pixel 4a + reports" |
| 5. What doc sync issues could occur? | Prevent stale specs | "Watch point: end-of-phase — confirm TECH-SPEC + PROJECT-STATE updated to match implementation" |

Aim for 3-5 watch points per phase. Fewer than 3 = probably missing something. More than 5 = probably over-controlled, will slow CC unnecessarily.

## Examples per phase

### Phase 0 (Spec drafts) — typical watch points

1. **Brief interpretation** — Watch: CC's draft of TECH-SPEC matches user's vision. When: after first TECH-SPEC draft. Action: surface full draft for user read-through.
2. **User journey accuracy** — Watch: USER-EXPERIENCE.md captures the "moment" user described. When: after first USER-EXPERIENCE draft. Action: surface for review.
3. **Inferred decisions audit** — Watch: PROJECT-DECISIONS.md lists every inference made (colors, fonts, motion). When: after specs drafted. Action: read aloud the top 5 inferences, ask "anything to override?"

### Phase 1 (Static scaffolding) — typical watch points

1. Asset import audit (see above)
2. Closed-state layout review (see above)
3. Pulse animation feel (see above)

### Phase 2 (Scripts + animation) — typical watch points

1. **Script-spec match** — Watch: generated TypeScript honors TECH-SPEC state machine. When: after CC generates controller. Action: surface state-machine summary, ask "matches?"
2. **@input wiring** — Watch: all @input fields populated with correct types and concrete LS classes. When: after wiring via setProperty. Action: read-back each @input field, surface table.
3. **Core loop verification** — Watch: tap → animation → end-state cycle works in Preview. When: after wiring complete. Action: surface CapturePanelScreenshotTool output of 3 key frames.

### Phase 2.5 (Advanced features) — typical watch points

1. **Feature toggle isolation** — Watch: face liquify can be toggled without breaking core loop. When: after liquify wired. Action: enable, test, disable, test.
2. **ML init timing** — Watch: ML callbacks register correctly (SceneObject must be enabled at scene start if using onLoadingFinished pattern). When: after ML component added. Action: read-back component state, verify enabled.

### Phase 3 (Polish) — typical watch points

1. **Magnitude review** — Watch: liquify intensity / radius feel right per brief. When: after first magnitude tweak. Action: hand off to Inspector via SetLensStudioSelection.
2. **Timing review** — Watch: tween durations match "pace" direction. When: after first tween tweak. Action: same — Inspector handoff.

### Phase 4 (Device test) — typical watch points

1. **iPhone baseline** — Watch: lens works as designed on iPhone. When: first device test. Action: user reports + surfaces issues.
2. **Mid-range Android perf** — Watch: FPS ≥ 25, lens ≤ 4MB. When: after Android pair. Action: user reads Performance Panel, surfaces numbers.
3. **Rapid-tap stress** — Watch: 10+ rapid taps don't cause memory leak or slowdown. When: after baseline test. Action: user performs + reports.

### Phase 5 (Submission) — typical watch points

1. **Icon spec match** — Watch: 320×320, simplified graphic not photo. When: before submission. Action: visual review.
2. **Ad-account verification** — Watch: correct Snap Ad Account selected in Submit panel. When: at submission. Action: confirm dropdown shows expected org.

## Anti-patterns

❌ **No watch points declared** — CC builds blind, drifts, surfaces final state. User has no mid-process visibility.

❌ **Too many watch points** (10+) — CC pauses constantly, no flow. User decision fatigue.

❌ **Vague watch points** — "Watch the animation" without specifying WHEN or what ACTION. CC can't honor it.

❌ **Skipping a declared watch point** — "I'll just keep going through this since the last 3 went well." NO. The user declared them deliberately; CC honors every one.

❌ **Watch points only at phase boundaries** — defeats the purpose. The point is mid-phase visibility. Phase boundaries are phase gates, separate concept.

## Good patterns

✅ 3-5 watch points per phase, specific and actionable
✅ Each watch point has explicit "When" trigger condition
✅ Each watch point has clear "Action" CC takes (surface screenshot / read-back / drag user to Inspector / etc.)
✅ CC pauses BEFORE the natural next step at each watch point — doesn't accidentally continue past
✅ User can amend watch points mid-phase if a new risk emerges

## Cross-reference

- Watch points work together with operational rules (`operational-rules.md`) — both are user-tracked safeguards
- Phase progression (`phase-progression.md`) lists the typical watch points per phase as suggestions
- PROJECT-STATE.md template has a "Watch points" section users fill in per phase
