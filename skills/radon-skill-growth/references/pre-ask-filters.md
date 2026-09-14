# Pre-ask filters

The grep dedup check is **filter 0** — does the rule already exist? If not, three more
silent gates run before surfacing the discovery. **Any NO drops the discovery silently** —
no ask, no save-for-later, no CHANGELOG entry. The SKILL-DISCOVERIES path is reserved for
"YES but bad timing", not "no signal at all".

## Gate 1 — Did I observe both the failure AND the fix working?

- **YES requires:** saw the failing state (error, wrong output, perf below threshold) AND
  saw the post-fix state confirm the fix end-to-end.
- **NO when:** fix wasn't empirically verified, the failure was inferred not seen, or the
  fix is "I think this might work / it compiled cleanly / didn't throw".

## Gate 2 — Can I write the general rule in one sentence (≤25 words)?

- **YES requires:** a single declarative sentence naming trigger + symptom + workaround.
  Write it mentally and count.
- **NO when:** too many caveats, conditions too specific, or you find yourself starting
  "well, it depends on...".

## Gate 3 — Did the user signal genuine novelty?

- **YES when:** user expressed surprise ("åh!", "what?", "I didn't know that"), asked
  "why did that happen?" / "how do we avoid this next time?", OR the agent itself was
  wrong and corrected by reality.
- **NO when:** the work was routine and predictable, the fix was already known, or it was
  a normal step in the build.

**All three YES → proceed to in-flow ask. Any NO → silent drop, move on.**
