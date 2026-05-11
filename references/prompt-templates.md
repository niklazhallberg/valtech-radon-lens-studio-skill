# Prompt templates

Proven prompts the user fires (or CC self-triggers in response to context). Each template includes example input/output pairs so CC sees exactly what behavior is expected, not just an abstract description.

## Contents
- Mutation discipline: "go probe X", "go bulk X"
- Two-step git gate: "go commit", "go push"
- Inspector handoff
- Scope-validation challenge
- Phase 0 — concept clarification
- Phase 1 — scene placement
- Phase 2 — animation timing + trigger
- Phase 2.5 — advanced features
- Phase 3 — polish iteration
- Phase 5 — submission prep

## Mutation discipline

### "go probe X" — single mutation verification

**Example user prompt**:
> "go probe — apply ONE setProperty on the lens icon's anchor.left, then read back the full anchor surface to verify the value actually persisted (not just success:true). If correct, surface the working pattern before applying to the rest."

**Expected CC response sequence**:
1. Apply one mutation:
   ```graphql
   mutation { setProperty(id: "<icon-st-id>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success } }
   ```
2. Run read-back:
   ```graphql
   query { sceneObject(id: "<icon-st-id>") { components { ... on ScreenTransform { anchor { left right top bottom } } } } }
   ```
3. Compare actual vs intended value
4. Surface result inline:
   > "Probe verified — anchor.left persisted as -0.5 (target was -0.5). Pattern: NUMBER + dotted path 'anchor.left'. Ready to bulk-apply to 4 remaining fields. Say 'go bulk' to proceed."
5. Wait for "go bulk" or correction.

### "go bulk X" — apply tested pattern to N-1 remaining targets

**Example user prompt**:
> "go bulk — apply the same anchor.left=-0.5 pattern to the remaining 4 icons (pack-1, pack-2, prop-icon, prompt-icon), single batched alias mutation. Then read back all 5 to confirm symmetry."

**Expected CC response**:
1. Apply batched alias-mutation:
   ```graphql
   mutation {
     p1: setProperty(id: "<pack-1-st>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
     p2: setProperty(id: "<pack-2-st>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
     pr: setProperty(id: "<prop-icon-st>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
     pm: setProperty(id: "<prompt-icon-st>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
   }
   ```
2. Read back all 5 anchors (including original probe target)
3. Surface symmetry table:
   > "Bulk applied + verified. 5/5 anchors confirmed at -0.5: [table]. Done."

If any of the 5 didn't take: that target needs individual diagnosis, not silent retry.

## Two-step git gate

### "go commit" — stage + commit + pause

**Example user prompt**:
> "go commit — Phase 1 scaffolding complete. Stage everything under lens/ and create the commit."

**Expected CC response**:
1. Stage:
   ```bash
   git add lens/
   ```
2. Check status:
   ```bash
   git status
   ```
3. ⌘S handshake (if scene was mutated):
   > "Before committing — switch to LS and ⌘S. Type 'saved' when done."
4. After 'saved', verify disk diff:
   ```bash
   git diff --cached --stat
   ```
5. Commit:
   ```bash
   git commit -m "<concise message reflecting the phase milestone>"
   ```
6. Surface:
   ```bash
   git log --oneline -3
   git show --stat HEAD
   ```
7. Pause: "Commit landed locally. Hash: abc123. Review the diffstat above. Say 'go push' when ready, or 'amend' / 'fix message' if not."

### "go push" — push + verify

**Example user prompt**:
> "go push — push to origin/main."

**Expected CC response**:
1. Push:
   ```bash
   git push origin main
   ```
2. Surface old..new ref:
   > "Pushed. Updated abc123..def456 on origin/main."

Don't bundle with commit. Each push is its own gate.

## Inspector handoff

### Use when: tuning "feel" parameters (magnitude, easing, color, position fine-tuning)

**Example user prompt** (or CC self-trigger):
> "We're polishing the eye liquify intensity. Hand off to LS Inspector for live tuning."

**Expected CC response**:
1. Identify the relevant SceneObject + component
2. Use SetLensStudioSelection to direct user there:
   ```graphql
   mutation { setLensStudioSelection(mode: "set" ids: ["<liquify-component-uuid>"]) { success } }
   ```
3. Surface instructions:
   > "The MCP screenshot loop is ~15s per iteration. The LS Inspector's slider gives 60fps live feedback. For liquify intensity, drag the slider directly in LS Inspector (I've selected the right SceneObject for you). Tell me when it looks right, and I'll read back the final value."
4. Wait for user "ok" + value.
5. Read back the final committed value:
   ```graphql
   query { sceneObject(id: "<id>") { components { ... on LiquifyVisual { intensity radius } } } }
   ```
6. Confirm: "Captured. Intensity: 1.12, radius: 0.18. Logged in PROJECT-DECISIONS.md."

## Scope-validation challenge

### User can fire this at any time

**Example user prompt**:
> "Is the idle pack-float animation in the original brief? If not, why are you adding it?"

**Expected CC response (option A — cite brief)**:
> "Yes — TECH-SPEC.md § 2.3 says 'pack should feel alive while idle, before user tap'. Built per spec."

**Expected CC response (option B — back off + propose)**:
> "You're right — not literally in the brief. I derived it from 'feels playful and inviting' (vision-statement). Want me to remove it, or keep as optional addition? My recommendation: remove for MVP, add as v2 if there's time."

Don't get defensive. Don't justify with "but it would be better if". User fired the challenge because they suspect drift; respect that signal.

## Phase 0 — concept clarification

**Example CC prompt to user** (at Phase 0 start):
> "Reading brief + inspiration. Before drafting specs, 2 clarifications:
>
> 1. **Trigger model**: tap-anywhere to start the effect, or always-on (lens starts immediately on open)? Default from inspiration: always-on (calm cinematic pace).
> 2. **Reset**: tap to reset to baseline, or no-reset (effect persists until lens close)? Default: no-reset.
>
> Answer with single words. I'll proceed."

**Expected user response**: short, single words.
> "always-on, no-reset"

**Expected CC follow-up**:
> "Locked. Drafting TECH-SPEC + USER-EXPERIENCE now. Surface in ~5 min for your review."

## Phase 1 — scene placement

**Example CC prompt**:
> "Building static scene. 2 placement confirmations:
>
> 1. **Primary element placement**: chest level (anchor.top ≈ 0) or face-level (anchor.top ≈ 0.4)? Default from inspiration: face-level.
> 2. **Background treatment**: full effect (covers face) or partial overlay (face visible behind)? Default: partial overlay.
>
> Single-word answers."

**Expected user response**:
> "face-level, partial overlay"

## Phase 2 — animation timing + trigger

**Example CC prompt**:
> "Animations need direction. 3 quick:
>
> 1. **Tween timing**: snappy (0.3s), medium (0.6s), or slow (1.0s)? Default from your 'cinematic' pace: 1.0s.
> 2. **End state**: held until tap, auto-reset after N seconds, or user-choice loop? Default: held until tap (matches no-reset principle).
> 3. **Gating during animation**: ignore mid-animation taps (cleaner), or queue them (responsive but choppy)? Default: ignore.
>
> Single-word answers per line."

**Expected user response**:
> "slow / held until tap / ignore"

## Phase 2.5 — advanced features

**Example CC prompt** (only if brief includes face effects, ML, or audio):
> "For face liquify:
>
> 1. **Magnitude**: subtle (1.0-1.1x), moderate (1.2x), dramatic (1.5x+)? Default from 'subtle' UX principle: 1.1x.
> 2. **Trigger**: automatic on lens open, or user-tap to enable? Default: automatic.
> 3. **Reset on tap**: yes/no? Default: no (effect persists).
>
> Confirm or override."

## Phase 3 — polish iteration

**Example CC prompt**:
> "Polish pass. From your inspection of the eye liquify in Preview, what feels off?
>
> Common dimensions:
> - **Magnitude**: too strong / too weak
> - **Timing**: rushed / sluggish
> - **Color**: oversaturated / muted
> - **Position**: occlusion / empty space
> - **Easing**: linear-feel / over-elastic
>
> Surface ONE specific change. I'll iterate, then re-check."

**Expected user response (concrete, one dimension)**:
> "magnitude — too strong on right eye, looks alien. Bring it down by 30%."

**Expected CC follow-up**:
1. Read current value
2. Apply 30% reduction
3. Surface new value + screenshot

## Phase 5 — submission prep

**Example CC prompt**:
> "Ready for submission. 3 confirmations:
>
> 1. **Ad-account target**: confirm the Snap Ad Account dropdown in LS Submit panel shows the right org. Which?
> 2. **Lens name** (final, not 'Untitled' from LS): what should it be called in Snap Ads Manager?
> 3. **Preview video**: I generate via LS Preview recording, or you provide a polished version?
>
> Snap submission is irreversible — confirm carefully."

**Expected user response (explicit)**:
> "1. Spotify Sweden AB. 2. 'Mood Match — Podcast Picker'. 3. You generate, I'll review before upload."

## Cross-reference

- All templates honor operational rules in `operational-rules.md` (especially two-step gate Rule 1, read-back Rule 11)
- Onboarding-protocol.md has the initial 8-question template
- Scope-validation challenge ties to `scope-creep-detection.md`
- Inspector handoff ties to Guiding Principle 7 in SKILL.md
