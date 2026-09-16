# Source confidence

Gate 1 accepts two evidence types, but the entry must declare which. Both can be saved;
the reader must always see what kind of evidence is behind a claim. Don't average them
into a single "HIGH" — be explicit.

## Own empiry (observed in this skill's production work)

- **Confidence:** HIGH
- **Format:** `**Source:** <project>, <YYYY-MM-DD> | **Confidence:** HIGH (<one-line evidence note>)`
- No re-check obligation — the agent saw the fix work end-to-end.

## External research (forum, paper, vendor announcement, blog)

- **Confidence:** MEDIUM max — never HIGH from external alone
- **Format:** `**Source:** [<title>](<URL>) | Date: <published> | **Confidence:** MEDIUM (<note>)`
- MUST include a re-check line: `**Status: verify before relying — source dated YYYY-MM-DD; re-check vendor notes / forum if this trips you up.**`

## Dual-sourced (own empiry + external corroboration)

- **Confidence:** HIGH
- **Format:** cite both — own observation + corroborating link — `| **Confidence:** HIGH (dual-sourced)`
- No re-check obligation, but keep the external link for depth.

## Why this matters

"We saw it fail and fixed it" is a different kind of evidence from "someone on a forum
said this is how it works." A future reader acting on a HIGH entry should be safe; a
MEDIUM entry tells them to verify first. The world moves underneath external claims
(build numbers, library versions, vendor policy) — own empiry between writing and reading
does not.

## Solo note

Single-user: you may be more aggressive with HIGH on your own empiry and collapse the
two-stage approval to one. The grading still earns its place — distinguishing "I saw it"
from "a forum said it" protects future-you, who won't remember which was which.
