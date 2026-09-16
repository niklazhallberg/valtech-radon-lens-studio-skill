# In-flow ask

When a discovery passes the grep check and all three pre-ask gates: say it DIRECTLY to
the user, mid-flow. Warm, plain language, no jargon. Technical details come AFTER yes.

## Template (solo tone — "you"/"future-you", never "the team")

> We've learned something new here.
>
> [1–2 sentences about what, plain English — avoid API names, file paths, grep output,
> "discovery" words.]
>
> This is worth saving so future-you (and any future project in this domain) won't fall
> into the same trap. Right now this isn't in the skill files yet, so next time the same
> symptom shows up, you'd be re-diagnosing it from scratch.
>
> Saving it also makes me sharper every time we work in this domain — your empiry is what
> the skill grows on.
>
> Is it OK if I save it as a learning to the skill files? Quick, doesn't break our flow.
>
> Yes / no / save for later

## Voice nuances

- "Save so future-you won't fall in" > "save" — frames the value, not a boring log.
- "Won't fall into" > "will fall into" — humble; we don't know 100%.
- "As a learning" — frames what it becomes when it lands.
- "Makes me sharper every time" — the value-exchange line, kept from LS v0.6 but pointed
  at the personal system, not a team. This is the one line carried back from the team
  version because it tells the truth: the skill compounds on your empiry.
- "Doesn't break our flow" — reassurance that the pause is fast.

## Before the ask (silent)

Generalization walk, grep check, and the three pre-ask gates all run silently. Probe
results and technical evidence stay in agent state, not in the user message.

## After yes — second stage

The NEXT message carries: a concrete diff, file path + section, commit message. Second
approval before commit + push. For your own HIGH-confidence empiry, this stage may
collapse into the first — propose the diff inline with the ask.

- **Yes** → open the right `references/*.md`, add the entry, show the diff, wait, commit. ~2 min.
- **No** → discard, move on.
- **Save for later** → write to `SKILL-DISCOVERIES.md`, surface at next natural break.

## Closing message after commit (plain, no git words)

> Done, it's saved now. If we later notice the entry doesn't quite fit, we can easily roll
> it back.
>
> Back to [concrete ongoing work] — say when you're ready to continue.

"Done, it's saved" > "Pushed to origin". The user cares that it's saved and reversible,
not about VCS plumbing.

## Language rule

All artifacts written to disk (CHANGELOG, references edits) are in plain English. The ask
itself may render in Swedish at runtime when the user is speaking Swedish — but the
on-disk OUTPUT is always English. Swedish section names may be quoted verbatim with an
English gloss in parentheses.
