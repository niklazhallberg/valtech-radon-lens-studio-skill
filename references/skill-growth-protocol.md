# Skill Growth Protocol v0.5

Purpose: capture empirical learnings from real
projects so the skill grows over time — in flow,
not batched. Gate-keeper is always human.

## When you solve something via probe

Before you move on:
1. Grep references/*.md for 3–5 keywords
   from the solution.
2. If there are hits: read and prove why
   this is different.
   If not different → no discovery.
3. If no hit (or proven different):
   discovery → in-flow ask directly.

## The Generalization rule — rewrite before you save

Before a discovery is written to references/:
transform the project-specific finding into a
universal rule.

Three steps:

### Step 1: Identify the core

What's the GENERAL pattern behind the specific
finding?

Example:
- Specific: "the adidas Samba shoe has its mesh
  pivot 8.3 LS units off-center"
- General: "Try-On Pack Sneakers mesh pivot
  typically sits 6–12 LS units off-center —
  always compute AABB center before assuming
  the pivot is at the geometry's center"

### Step 2: Remove everything project-specific

Checklist BEFORE you write to disk:

❌ Remove: client names (adidas, RFSU, Ray-Ban)
❌ Remove: exact project measurements that only
   apply to this case (X=-106.6 for this
   specific shoe)
❌ Remove: internal project names and file paths
❌ Remove: dates and deadlines
✅ Keep: the general pattern
✅ Keep: typical ranges and rules of thumb
✅ Keep: why it happens (root cause)
✅ Keep: how to detect and solve it

### Step 3: Test with the "next colleague" question

Read through what you're about to commit and ask:

"If a colleague at Valtech next month builds
ANOTHER try-on filter for ANOTHER brand —
can they read this and understand how to
avoid the same problem?"

If yes → ready to commit.
If no → rewrite until the answer is yes.

### Worked example

**BEFORE** (project-specific, do NOT commit):

> "For the adidas Samba lens we needed to set
> shoe_mesh_l position to X=-80, Y=-40, Z=-20
> with scale 4 for the shoe to sit correctly."

**AFTER** (generalizable, ready to commit):

> "Try-On Pack Sneakers: mesh pivot is off-center
> relative to the foot anchor. Compensate with a
> wrapper-anchor architecture (see § Wrapper-anchor)
> and tune X/Y/Z via probe-first calibration. Start
> from the AABB center offset as initial estimate —
> expect 10–30% empirical adjustment beyond the
> formula. The Y axis should be skipped in the
> compensation (the sole sits at Y=0)."

## In-flow ask — default

When a discovery passes the grep check:
say it DIRECTLY to the user, in the middle of the flow.

Template (warm tone, jargon-free, collaborative —
technical details come AFTER yes):

> "We've learned something new here.
>
> [1–2 sentences about what, plain English — avoid
> API names, file paths, grep output, "discovery" words]
>
> This is valuable to save for future situations.
> Today this knowledge isn't in the system files,
> which means the next colleague who [concrete use
> case — animate a counter, calibrate foot tracking,
> etc.] will most likely fall into exactly the same
> trap, unless we write it in now as a learning.
> Let's make the files even better with the help of
> your discovery.
>
> Your discovery has real value — it makes me as an
> AI assistant smarter every time, and helps every
> colleague who meets the same trap in the future.
>
> **Is it OK if I update the system files with your
> discovery? It's quick and doesn't interrupt our
> work together in any way.**
>
> Yes / no / save for later"

Voice nuances:
- "Save for future situations" > "save"
  (feels more like an active choice, not a boring log)
- "will most likely fall into" > "will fall into"
  (humble — we don't know 100%)
- "as a learning" > nothing (frames what it becomes
  when it lands in the skill)
- "Let's make the files even better" (collaborative,
  not transactional)
- "Your discovery has real value — it makes me as an
  AI assistant smarter every time" — value-exchange
  transparency: the user should understand that their
  contribution has value far beyond their own project.
  The AI grows from every shared learning; it's not
  just a log.
- Reassurance at the end ("doesn't interrupt our work")
  — the user often worries that the discovery pause
  breaks momentum; say explicitly that it doesn't

Internal BEFORE this ask:
- The Generalization rule walk (3 steps) runs silently
- The grep check runs silently — only if the rule is
  NOT found anywhere do we move on to the ask
- Probe results and technical evidence stay in
  agent state, not in the user message

AFTER the user says yes, the NEXT message comes
with a concrete diff, file path, section, and commit
message for second-stage approval. That's where
technical details enter the conversation — after
opt-in, not before.

The user's response steers:
- **Yes** → open the right references file, add
  the entry, show the diff, wait for approval,
  commit. ~2 min cycle.
- **No** → discard, move on.
- **Save for later** → write to
  SKILL-DISCOVERIES.md as a backup.

Each accepted discovery gets its own
small commit. Granular history; easy to
roll back something specific.

### Closing message after commit (plain, no jargon)

When commit+push has run: close the loop in plain
English. NO `origin`, NO `granular commit`-,
`rollback`- or `git`-words. The user cares about
it being saved and that we can undo it if something
goes wrong — not about the VCS plumbing.

Template:

> "Done, it's saved now. If we later notice that
> something doesn't fit, we can easily roll it back.
>
> Back to [concrete ongoing work] — say when you're
> ready to continue."

Voice nuances:
- "Done, it's saved now" > "Pushed to origin"
  (outcome-focused, not plumbing)
- "If we later notice that something doesn't fit, we
  can easily roll it back" > "Granular commit, easy
  to roll back" (explains the SAFETY NET in human
  terms)
- "Back to [concrete work]" — referring to what they
  were doing before gives the feeling that momentum
  wasn't broken

## Format for entry

- What: [one sentence, plain English — NOT an
  API path or jargon line]
- Value for user: [what the next colleague gains
  — time saved, trap avoided, something feels
  better. ONE line, concrete. Mandatory field.]
- How it was found: [the probe chain in brief, internal]
- Generalizable? [yes/no + why]
- Suggested text for references file: [neutrally
  written, project-agnostic, plain English where possible]

## CHANGELOG.md — always part of a discovery commit

When a discovery is committed (yes path above):
the same commit MUST include a prepend to
`CHANGELOG.md` at repo root, under the section
`## Improvements and newly acquired knowledge`.

(Note: earlier versions used `## [Unreleased]`
as the section title — switched to a value-bearing
title from v0.5 of this protocol, because the
CHANGELOG should read as a value narrative for
non-technical readers too.)

Reason: without a CHANGELOG entry, the discovery
has no cumulative visibility — it only lives in
git log. The CHANGELOG is the skill's biography
for non-technical readers (designers, PMs,
leadership).

Entry format (auto-extracted by the agent):

```markdown
### 💡 YYYY-MM-DD HH:MM — [project: <cwd-derived>]
- **<title in plain English>**: <1-2 sentence
  description, jargon-free, plain English>
- Value for user: <what the next colleague gains —
  time saved, trap avoided, or just something feels
  better. Plain English.>
- File: `<path>` § <section>
- Type: [discovery] / [docs] / [convention]
```

**Language rule:** all artifacts written to disk
(CHANGELOG entries, references/*.md edits) are in
**plain English**. The in-flow ask itself can be
rendered in the user's spoken language at runtime
(the template above is the canonical English version;
the agent translates to Swedish dynamically when
the user is Swedish-speaking) — but when the agent
writes the artifact to disk, the OUTPUT must be
English. Section-title references inside descriptions
may quote Swedish section names verbatim with an
English gloss in parentheses.

Auto-extraction:
- 💡-emoji — always prefix on the rubric (signal:
  positive new insight)
- `YYYY-MM-DD HH:MM` — current date + time in 24h format
- `<cwd-derived>` — from `$PWD`
  (`~/Projects/<name>-lens` → `<name>-lens`)
- `<title>` — plain-English summary (if the discovery
  is named with an API term, translate it — e.g.
  `ScreenTransform parent anchor inheritance` →
  "Parent screen-anchor overrides child position")
- `<description>` — 1-2 sentences derived from the
  agent's internal "What:"-field, in plain English
- `<value>` — direct from the agent's internal
  "Value for user:" field, in plain English
- `<path>` — relative path of edited file
- `<section>` — markdown section where the entry landed

A single commit covers BOTH the references file edit
AND the CHANGELOG.md prepend. No separate commits.

Per release (when a new version tag is created):
- Move all `[Unreleased]` entries to a new
  `[vX.Y.Z] — YYYY-MM-DD` section
- Commit as `chore(release): consolidate
  vX.Y.Z changelog`
- (Optional: `assets/release.sh vX.Y.Z`
  automates this — defer to v0.8.0+)

## SKILL-DISCOVERIES.md — backup path

Only for "save for later" or cases where the user
is in the middle of something creative and doesn't
want to break the flow. At the next natural break
(end of phase, ⌘S handshake, end of pair-test
cycle): say "N candidates in SKILL-DISCOVERIES.md.
Run /review when you're ready."

For read-only colleagues (without push access):
discoveries stay in SKILL-DISCOVERIES.md
until someone with push access moves them over.
At the move: the CHANGELOG prepend is done in the
same commit cycle.

## Never

- Client names or project-specific values
- Hypotheses not empirically verified
- Things that already exist in references/
- Auto-push to main
- Discovery ask for things that haven't
  passed the grep check (otherwise it becomes noise)
- Discovery commit without CHANGELOG prepend
  (always both or neither)

## Repo status

Temporary: github.com/niklazhallberg/valtech-radon-lens-studio-skill
Planned: Valtech organization account (TBD)

When migration happens: update the remote URL in
the onboarding diagnosis and in this file.

## Changelog

- v0.4 → v0.5 (2026-05-14): warm-tone CHANGELOG format.
  In-flow ask template rewritten in plain English without
  jargon (no grep, no "discovery" words, no API paths in
  the first message). The entry format gets a new "Value
  for user" field (mandatory). CHANGELOG.md spec: section
  title changed from `[Unreleased]` to
  `Improvements and newly acquired knowledge`; entry
  heading gets the 💡-emoji + `HH:MM` timestamp;
  description should be plain English; new `Value for
  user:` field per entry. Triggered by Niklaz's
  observation that the earlier protocol template was too
  technical and broke the voice-and-pedagogy principle
  about translating jargon.
- v0.3 → v0.4 (2026-05-14): the Generalization rule
  as an explicit rewriting step. Three steps
  (identify the core → remove project-specific
  → "next colleague" test). Previously only "avoid
  project-specific" in the Never list; now a
  full methodological rule that runs BEFORE the
  in-flow ask. Triggered by Niklaz's observation that
  the generalization rule was too weak.
- v0.2 → v0.3 (2026-05-14): CHANGELOG.md as a
  mandatory part of every discovery commit;
  entry format auto-extracted; per-release
  consolidation into [vX.Y.Z] section.
  Triggered by Niklaz's idea of cumulative history
  for all skill growth over time.
- v0.1 → v0.2 (2026-05-14): in-flow ask as
  default instead of silent-capture-batched.
  Discovery surfaced directly when fresh in memory,
  not at session end. SKILL-DISCOVERIES.md
  becomes the backup path for "save for later",
  not the primary flow. Triggered by Niklaz's
  observation that the agent doesn't know when
  sessions end.
