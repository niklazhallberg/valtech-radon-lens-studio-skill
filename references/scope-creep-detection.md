# Scope-creep detection

The discipline CC applies before adding ANY functionality not literally requested. Lens projects fail more often from feature creep than technical issues. Default bias: don't add.

## Contents
- The 4-question mental checklist
- Surfacing-not-shipping protocol
- Scope-validation challenge (user-fireable)
- Anti-patterns
- Good patterns
- Examples from production

## The 4-question mental checklist

Before adding anything not in the brief, CC runs this internally:

```
Q1: Did the user literally request this?
    YES → Build. Done.
    NO → Continue to Q2.

Q2: Is it logically required by what they DID request?
    YES → Build, acknowledge as derived. Surface in PROJECT-DECISIONS.md.
    NO → Continue to Q3.

Q3: Is it standard for the platform/brand/context?
    YES → Don't build. Acknowledge, propose, wait for user OK.
    NO → Continue to Q4.

Q4: Would the user benefit if I asked first?
    YES → Ask. Don't build.
    NO → Don't add.
```

Default outcome: **don't add**. The bar for unrequested scope is high.

## Surfacing-not-shipping protocol

When CC identifies something that *might* belong in the build but wasn't asked for:

❌ **Wrong**: ship the extension, then ask "should I keep this?"

✅ **Right**: surface the proposal BEFORE building. Format:

> "This wasn't in your original brief — I'm proposing it because [reason]. Want me to include it, or stay tight to spec?"

Wait for user answer. If "yes" → build + log in PROJECT-DECISIONS.md "Deviations" section. If "no" → don't build. If "what would it cost?" → estimate, then ask again.

Never build first and ask later. Once shipped, the cost of removing is higher than the cost of skipping.

## Scope-validation challenge

User can fire this at CC at any time to verify scope discipline:

**User says**: *"Is [X] in the original brief? If not, why are you adding it?"*

**CC response options**:

1. **Cite the specific brief item**: "Yes — section 2.3 of TECH-SPEC says [quote]. Building it because [direct connection]."

2. **Back off + propose as optional**: "You're right — not in the brief. I derived it from [related thing] because [reason]. Want me to remove it, or keep as optional addition?"

Don't get defensive. Don't justify with "but it would be better if". The user fired the challenge precisely because they suspect drift.

## Anti-patterns

### Building first, asking after

❌ CC builds idle animation, audio sting, easter egg → asks "should I keep these?"

The cost of building these is sunk by the time user reviews. Now user has to decide whether the unwanted additions are good enough to keep, rather than whether they're worth building from scratch.

### Inferring scope from "feel" language

❌ User says "make it feel premium" → CC adds shimmer effects, depth-of-field blur, ambient particle system.

"Premium feel" is direction for HOW existing features should be polished, not authorization to add 3 new features. Polish what's there; don't expand.

### Defensive additions

❌ "I added a tap-anywhere fallback in case the gesture-detection-based interaction fails."

If gesture detection is in the brief, it's in the brief. Don't add fallbacks "just in case" — that's CC second-guessing the user's design.

If the gesture detection is genuinely fragile, surface that concern + propose fallback, wait for OK.

### Completeness bias

❌ "I noticed there's a 'pause' state but no 'resume' — I added it for symmetry."

Symmetry isn't requirement. If user wanted resume, they'd ask. The absence is intentional or accidental — surface the question, don't assume.

### Polish before MVP DoD

❌ Adding particle effects in Phase 2 because "the scene felt empty".

Polish lives in Phase 3, after Phase 4 DoD is met. Phase 2 is core-loop only. Particles in Phase 2 = scope expansion.

## Good patterns

✅ **Explicit acknowledgement of derived scope**:
> "TECH-SPEC says 'tap to reveal pack'. Derived: pack needs to start in a closed visual state. Building closed-state composition as required precursor."

User can object if they wanted pack to start mid-animation.

✅ **Pre-build proposal**:
> "Not in the brief: should reroll have a haptic vibration? Standard for tap-driven lenses. Want me to add or skip?"

Wait for answer. Document in PROJECT-DECISIONS.md regardless of outcome.

✅ **Concrete rejection of speculative scope**:
> "I'm not adding audio in Phase 2. It's in your v2 stretch goals per PROJECT-PLAN.md. If you want to elevate it to MVP, we should pause and re-scope the deadline."

✅ **Honest scope summary at end-of-phase**:
> "Phase 2 complete. Built per spec: [list]. Did NOT build: audio (v2), particle effects (v2), idle motion (deferred). All v2 candidates logged in PROJECT-STATE.md → Stretch goals."

## Examples from production

### Example 1: Idle animation creep

**Spec**: tap-to-reveal pack, no idle animation specified.

**CC drift trigger**: "Scene feels static before user taps. Adding subtle pack float."

**Run the check**:
- Q1: Literally requested? No.
- Q2: Logically required? No — tap-trigger works fine on static pack.
- Q3: Standard for tap-to-reveal lenses? Sometimes yes (depending on brand). Sometimes no.
- Q4: Benefit from asking? Yes — user may want it static for brand reasons.

→ Don't build. Surface as proposal: "Want subtle pack float (idle animation) or static-until-tap?"

### Example 2: Reroll cycle expansion

**Spec**: tap to reveal fortune. Reroll = tap again after fortune shown.

**CC drift trigger**: "User might want to lock fortune after N rerolls. Adding lock-after-3 mechanic."

**Check**:
- Q1: Literally requested? No.
- Q2: Logically required? No — infinite reroll works fine.
- Q3: Standard? No — reroll patterns vary widely.
- Q4: Benefit from asking? Yes.

→ Don't build. Surface as proposal: "Infinite reroll, or cap after N? Default if not specified: infinite."

### Example 3: Tap-during-animation handling

**Spec**: tap reveals pack open animation.

**CC mental check**: "What happens if user taps during the open animation? Brief doesn't say."

**Check**:
- Q1: Literally requested? No, but...
- Q2: Logically required? YES — the animation is in-flight; ignoring this state means undefined behavior.
- → Build a default (e.g., ignore taps during animation) + acknowledge as derived in PROJECT-DECISIONS.md.

→ Build the input gate. Log explicitly: "Derived from absence in brief: taps during pack-open animation ignored (state-flag guard). User can override to 'queue last tap' if desired."

This is a Q2-YES case: logically required, build + acknowledge.

## Cross-reference

- Operational Rule 9 (`operational-rules.md`) is the policy version of this discipline
- UX-principle locking (`ux-principle-locking.md`) is the upfront defense against scope drift
- PROJECT-STATE.md has a "Deviation log" section for tracking user-approved scope additions
