# Lens Studio UX patterns

Reusable interaction-design patterns extracted from production lens projects. These are PATTERNS (rhythm, shape) — not specific values. Use as templates and tune per brief.

## Contents

- Decelerating callback-chain (reveal moments)

---

## Decelerating callback-chain (reveal moments)

For "spin wheel / decision moment / reveal" UX feelings, you don't need a visually spinning wheel. The FEELING comes from a callback chain with growing intervals — the user senses the system "settling" on an answer through rhythm alone.

**Pattern** (pseudo-code — tune values per brief):

```typescript
// Growing-interval array, ~7-10 steps totaling ~2-3 seconds
const intervals: number[] = [/* e.g. nine values where each is ~1.3-1.5x the previous */];
const reveals: string[] = [/* one value per step — text, state, item, etc. */];

let i = 0;
function tick() {
  if (i >= intervals.length) {
    settleOnFinal();   // final state, longer dwell
    return;
  }
  swapTo(reveals[i]);  // text / state swap on this step
  const delay = script.createEvent("DelayedCallbackEvent");
  delay.bind(() => { i++; tick(); });
  delay.reset(intervals[i]);
}
tick();
```

**Why growing intervals work**: Equal-spaced intervals feel mechanical (typewriter, ticking clock). Growing intervals (each step longer than the last) feel like deceleration — the system is "deciding". Total duration in the 2–3s band is the sweet spot: long enough to build anticipation, short enough to keep the user engaged.

**Tuning guidance** (start here, adjust per brief):

| Parameter | Typical range | Why |
|---|---|---|
| Total duration | 2–3 s | <2s feels rushed, >3s feels slow |
| Step count | 7–10 | Fewer = jumpy, more = excessive |
| Growth ratio between adjacent intervals | ~1.3–1.5× | Natural deceleration; pure exponential feels over-engineered |
| Final settle (after last step) | Longer than the last interval | Gives the answer weight |

**Use cases**:

- Quiz reveals ("what X are you", personality tests, alignment quizzes)
- Decision moments (fortune teller, prediction, advice, oracle UX)
- "Loading" with character (not a literal spinner — a values-rolling effect)
- Game outcomes (which prize, what fate, which character)

**Anti-patterns**:

- Equal-spaced intervals — feels like a typewriter, not a wheel.
- Linear deceleration to a hard stop — feels like a machine breaking.
- Pure exponential growth — feels over-engineered; the final intervals get too long and the user disengages.
- Visual spinning ON TOP of a values-rolling effect — overdrawn; the rhythm carries the feeling by itself.

**Implementation notes**:

- `DelayedCallbackEvent.cancel()` works as documented — see `lens-studio-api-gotchas.md` → "DelayedCallbackEvent cancel() actually works". Use it for reroll / restart mechanics where the user can interrupt the reveal mid-chain.
- Avoid `onUpdate` for this — frame-rate-coupled callbacks burn FPS budget. The chain pattern is event-driven and FPS-neutral.
- See `phase-progression.md` → Phase 2 for where reveal callback chains wire into the lens state machine.
- For belt-and-suspenders cancellation (state-critical interrupts), also set a `cancelled` flag the callback checks — see the same gotcha entry's "belt-and-suspenders" note.

---

## Adding new patterns

When a new interaction-design pattern emerges during a lens project, add an entry here with:

- The pattern's intent (what feeling does it create?)
- Pseudo-code (no project-specific values)
- Tuning guidance (typical ranges, not exact numbers)
- Use cases (what kinds of briefs does this fit?)
- Anti-patterns (what looks similar but doesn't work?)

Keep entries focused on the PATTERN, not the values from any single project. Project-specific values stay in the project's `TECH-SPEC.md` / `USER-EXPERIENCE.md`.
