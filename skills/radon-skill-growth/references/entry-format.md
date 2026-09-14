# Entry format & CHANGELOG spec

## Internal entry fields (agent state, before the ask)

- **What:** one sentence, plain English — NOT an API path or jargon line
- **Value for user:** what is gained — time saved, trap avoided, something feels better.
  ONE line, concrete. Mandatory.
- **How it was found:** the probe chain in brief, internal
- **Generalizable?** yes/no + why
- **Suggested references text:** neutral, project-agnostic, plain English

## CHANGELOG.md — always part of a discovery commit

A discovery commit MUST prepend `CHANGELOG.md` at repo root under
`## Improvements and newly acquired knowledge`. Without it the discovery has no cumulative
visibility — it only lives in git log. The CHANGELOG is the skill's biography.

Entry format (auto-extracted):

```
### 💡 YYYY-MM-DD — [project: <cwd-derived>]
- **<title in plain English>**: <1-2 sentence description, jargon-free>
- Value for user: <what is gained — plain English>
- File: `<path>` § <section>
- Type: [discovery] / [docs] / [convention]
```

Auto-extraction: 💡 prefix always; `YYYY-MM-DD` current date, no time; `<cwd-derived>`
from `$PWD`; `<title>` plain-English (translate API jargon); `<description>` from internal
"What:"; `<value>` from "Value for user:"; `<path>` relative; `<section>` where it landed.

**A single commit covers BOTH the references edit AND the CHANGELOG prepend. No separate
commits.**

## Emoji conventions

- 💡 — discovery / new learning (most entries)
- 🌱 — structural change (repo skeleton, framework, scaffolding)
- 🔧 — refactor or convention change (no new knowledge)
- 🚨 — correction (something previously documented was wrong)

## Per release (version tag)

Move `## Improvements and newly acquired knowledge` entries to a new
`[vX.Y.Z] — YYYY-MM-DD` section. Commit as `chore(release): consolidate vX.Y.Z changelog`.

## Never

- Client names or project-specific values
- Hypotheses not empirically verified
- Things that already exist in `references/`
- Auto-push to main (solo can push, but always an explicit "yes" first)
- Discovery ask for things that haven't passed the grep check
- Discovery commit without CHANGELOG prepend (always both or neither)
