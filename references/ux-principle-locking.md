# UX-principle locking

Lock 3-5 UX principles before Phase 2 scripting to prevent CC from auto-deriving behavior that drifts from brand intent. UX principles describe HOW a feature should feel, not WHAT it does.

## Contents
- Feature requirement vs UX principle
- Why lock upfront
- Locking template
- Code-audit checklist
- Examples
- Anti-patterns

## Feature requirement vs UX principle

**Feature requirement** (WHAT, captured in TECH-SPEC):
- "User can tap to reveal fortune"
- "User can reroll fortunes"
- "Lens applies face liquify effect"

**UX principle** (HOW it should feel, captured in PROJECT-STATE.md UX section):
- "Reroll never happens automatically — only user-tap triggers it"
- "Face liquify is subtle — playful surprise, not cartoon shock"
- "No countdown timers — feel like invitation, not pressure"
- "Screenshot moments are reachable — user can hold the final state without interruption"
- "Only explicit input drives state changes — no face-event or smile triggers"

The feature requirement says "can reroll". The UX principle says "reroll is explicit, not automatic". Both are needed.

## Why lock upfront

Without explicit UX principles, CC will derive plausible-feeling behavior from feature requirements alone:

- "User can reroll fortunes" → CC adds auto-advance after 5s ("for completeness")
- "Lens applies face liquify" → CC sets magnitude to 2.0x ("most visible setting")
- "Tap to start" → CC adds a countdown to encourage tap ("more engaging")

Each addition is defensible individually. Together they drift from brand intent — the lens that was supposed to feel "playful and inviting" now feels "anxious and pushy".

Locked principles tell CC what to AVOID during script generation. They take precedence over auto-derived behavior.

## Locking template

User-driven, done in PROJECT-STATE.md before Phase 2 starts:

```markdown
## UX principles (locked before Phase 2 scripting)

These take precedence over any auto-derived behavior. If CC's script
generation would violate any of them, surface the conflict and pause
for direction before generating.

1. **<principle name>**: <rule statement>
   - What this rules out: <specific patterns CC must NOT add>

2. **<principle name>**: <rule statement>
   - What this rules out: <patterns to avoid>

[3-5 total]
```

Example locked set for a tap-to-reveal lens with face effect:

```markdown
## UX principles — Spotify pod-recommendation lens

1. **Only explicit input drives state**: every state transition triggered by user tap.
   - What this rules out: setTimeout-based auto-transitions, FaceEvent listeners (smile/blink detection), idle-timer fallbacks.

2. **Invitation not countdown**: prompt-to-tap is continuous (gentle pulse, breathing animation) — never a numeric countdown.
   - What this rules out: visible timer, "tap in 3, 2, 1" copy, progress bars filling.

3. **Screenshot moment respected**: when fortune is revealed, the state holds indefinitely until user-initiated reroll.
   - What this rules out: auto-reset, auto-advance to next state, dismiss-after-N-seconds.

4. **Subtle face effect**: liquify magnitude is "playful surprise", not "cartoon shock". 1.0-1.2x baseline range.
   - What this rules out: magnitude > 1.3x, dramatic deformations, anything that looks like a meme filter.

5. **No artificial constraints**: lens never feels like it's blocking the user.
   - What this rules out: "you can only reroll 3 times" caps, max-display-duration limits, mandatory wait-times between taps.
```

## Code-audit checklist

After CC generates scripts, run this audit BEFORE committing. For each locked principle, grep / scan for the violations:

| Principle | Look for in TS code | If found |
|---|---|---|
| No auto-reset | `setTimeout`, `setInterval`, `DelayedCallbackEvent` (auto-firing) | Remove or replace with user-tap trigger |
| Invitation not countdown | Timer-driven UI updates, copy strings with numbers ("3", "2", "1"), progress-bar tween logic | Remove; replace with continuous animation |
| Only explicit input | `FaceEvent` listeners, face-landmark callbacks, motion-detection inputs | Remove all |
| No time limit | Session timers, max-display guards, `Time.deltaTime` accumulation for cutoffs | Remove cutoff logic |
| Subtle face effect | Magnitude values > principle-stated range (in TweenValue start/end, in setProperty NUMBER writes) | Lower to range |
| No artificial caps | Counter variables limiting reroll/interaction count | Remove cap |
| Screenshot moment | Any state-machine transition not triggered by user input | Audit; user-trigger only |

Run grep examples:

```bash
# Auto-fire callbacks
grep -n "setTimeout\|setInterval\|.cancel()" lens/Assets/Scripts/*.ts

# Face-event listeners
grep -n "FaceEvent\|onSmile\|onBlink\|FaceLandmark" lens/Assets/Scripts/*.ts

# Hardcoded magnitudes (suspicious if not justified)
grep -n "magnitude\|intensity\|amplitude" lens/Assets/Scripts/*.ts

# Auto-state-transitions
grep -n "DelayedCallback\|reset.*\b\(2\.\|3\.\|5\.\)" lens/Assets/Scripts/*.ts
```

If any violations found:
1. Show the violation to user with file:line reference
2. Confirm the locked principle still holds
3. Refactor the code to remove violation
4. Re-audit

## Examples — derived behaviors that locked principles prevent

### Example 1: Auto-advance creep

**Without lock**: CC sees "user can view 3 fortunes" → derives "auto-advance to next fortune after 3s".

**With locked principle** ("only explicit input drives state"): CC pauses, notes conflict, asks user before adding auto-advance.

### Example 2: Magnitude drift

**Without lock**: CC sees "lens applies face liquify" → defaults to maximum visible magnitude (1.8x) for "best demo".

**With locked principle** ("subtle face effect, 1.0-1.2x"): CC sets magnitude to 1.2x default, doesn't experiment with higher.

### Example 3: Time-pressure addition

**Without lock**: CC sees "tap to start" and adds 5s countdown overlay "for engagement".

**With locked principle** ("invitation not countdown"): CC builds continuous pulse instead. No timer overlay.

## Anti-patterns

❌ **Locking too late** — locking AFTER Phase 2 scripts written = post-hoc cleanup, not prevention. Lock before scripting.

❌ **Vague principles** — "feel premium" isn't lockable. Make it concrete: "magnitude ≤ 1.2x", "no UI elements over face during reveal state", "audio (if any) max -12dB".

❌ **Too many principles** — 8+ principles = analysis paralysis. 3-5 is enough.

❌ **Principles that just restate features** — "User can reroll" is a feature, not a principle. Principle would be "reroll is always explicit, never automatic".

❌ **Principles without "what this rules out"** — without the explicit prohibition, CC can defensibly drift. The rules-out clause is the enforcement teeth.

## Good patterns

✅ Lock before Phase 2 scripting starts (during Phase 0 or end of Phase 1)
✅ 3-5 principles, concrete and measurable
✅ Each has explicit "what this rules out" with code patterns
✅ Re-audit at end of Phase 2 before commit
✅ User can amend mid-build if a new principle emerges

## Cross-reference

- Operational Rule 10 (`operational-rules.md`) is the policy version
- Scope-creep detection (`scope-creep-detection.md`) catches feature additions; UX-principle locking catches behavior drift within features
- PROJECT-STATE.md has the "UX principles" section users fill in
- Phase progression (`phase-progression.md`) Phase 1 DoD includes "UX principles locked"
