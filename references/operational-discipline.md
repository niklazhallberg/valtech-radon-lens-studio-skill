# Operational discipline — session-opening, checkpoints, prior-knowledge consultation

This file holds the disciplinary spine of the skill. It used to live in `SKILL.md` but was moved here when SKILL.md was condensed (May 2026). The content is non-negotiable and applies to every session.

---

## Session-opening discipline — MANDATORY before first technical reply

Before answering the first technical request in any session that activates this skill, do these three things. They are non-negotiable. Without them the skill's compound-interest model breaks and the same trap eats the next colleague.

1. **Read `references/skill-growth-protocol.md` in full.** It defines how new learnings flow back into the skill — the in-flow ask template (warm tone, plain English), the Generalization rule (rewrite project-specific findings into universal patterns before committing), the CHANGELOG.md prepend format, and what counts as a "discovery". Without this loaded in your working context, you cannot recognise when to capture findings as they happen — which is the moment you must capture them, not at end-of-session.

2. **Read `CHANGELOG.md` as an INDEX of recent learnings — then follow each entry's file pointer to the actual content.** The CHANGELOG is the institutional-memory **table of contents**, not the knowledge itself. Each entry has a "what" line, a "value for user" line, and a `File:` pointer like `references/lens-studio-api-gotchas.md § "Masking Component does not visibly clip Text grandchildren"`. The **full technical pattern, mitigation, and source notes live in the referenced file** — not in the CHANGELOG entry. So the read flow is: scan the last 15-25 CHANGELOG entries → for each that's plausibly relevant to the current project brief, OPEN the referenced file and read that section → load the full pattern into your working context.

   Without this two-step (CHANGELOG → referenced file), the agent gets a misleading sense of being "informed" while still missing the actual technical depth that protects against the trap. **CHANGELOG without referenced-file follow-through is just trivia.** A colleague who is fresh to this skill (no memory from prior sessions) starts ignorant of months of accumulated empirical knowledge unless the agent does both steps. Skipping the follow-through is the failure mode where the agent has "read the headlines but not the articles" — enough to feel updated, not enough to act on it.

3. **Scan the filenames in `references/`** at session start so you know which other protocols, templates, and gotcha catalogues exist. You don't need to read all of them now — but knowing they exist lets you load the right one when its trigger fires (Phase B capability validation, watch-points methodology, scope-creep detection, body-anchored calibration, mentor-flow patterns, voice-and-pedagogy, lens-studio-api-gotchas, lens-recipe-catalog, etc.). A reference you don't know exists is a reference you won't invoke on time.

4. **Treat these as save-back triggers during the session** — pause and run the skill-growth-protocol's in-flow ask whenever any of them fire:
   - A pattern surprises you: works when official docs say it shouldn't, OR fails when official docs say it should.
   - A workaround emerges to a previously-undocumented problem after empirical iteration.
   - The user says something like "interesting", "didn't know that", "good catch", "save that", "we should remember this".
   - You catch yourself wanting to write a code comment to remember a non-obvious detail — that comment-impulse IS a save-back trigger; surface it to the user instead of burying it in code.
   - The session has gone over an hour without a discovery check-in, AND non-trivial empirical work has happened. Confirm "no discoveries today" explicitly before closing the session.

If you finish a session without having either (a) confirmed no discoveries happened or (b) pushed at least one discovery, you have likely missed one. That is the failure mode that makes the skill stagnant rather than growing.

---

## Mandatory checkpoints — re-anchor to the growth protocol at these moments

Session-opening discipline is layer 1. It is insufficient on its own: attention drifts after ~30-45 min of focused build work, and by hour 3 the protocol is no longer in active context. To counter that, treat the moments below as **mandatory re-anchors** — at each one, pause your current train of thought and explicitly ask yourself "has anything surprised me, failed counter to docs, or required empirical iteration since the last checkpoint? if yes, run the skill-growth-protocol in-flow ask now."

### Natural anchors (no clock-watching required — they fire on actual events)

- **Before every commit.** A commit closes a chapter — perfect last chance to surface a discovery from that chapter before it's archived.
- **Before every ⌘S handshake.** Same logic: state about to be persisted is state worth scanning for discoveries.
- **Before every phase transition** (Phase 0→1, 1→1.5, 2→2.5, etc.). Each phase ends with an implicit "what did we learn?" — make it explicit.
- **After 3+ empirical probes on the same problem.** If you have run probe / re-test / probe again three or more times in a row, you have done research — the result (positive OR negative) is almost certainly a save-back candidate.
- **After a user "magic moment" reaction.** When the user says "interesting", "didn't know that", "good catch", "save that", "we should remember this", "oj" / "intressant" — that's an explicit save-back trigger. Do not let the moment pass without surfacing the protocol.
- **Before context compression** (when conversation length grows or a `[ctx-compress]` signal appears). Compression discards everything you don't actively pull forward — discoveries that aren't formalised before compress are likely lost.
- **At session-close.** Before the user says "klart för idag" / "tack" / equivalent, do one final pass: "Has anything we learned today been captured? If not, propose it now."

### Hard-fallback time/count anchors (fire mechanically when natural anchors haven't been hit)

- **30-minute iteration checkpoint.** If 30 minutes have passed since the last commit OR the last skill-growth-protocol invocation, AND non-trivial empirical work has happened in that window, STOP and run the protocol's in-flow ask before continuing. The user explicitly asked for this fallback after a session where natural anchors all failed to fire during a long debugging loop ("vi har gått djupt utan att stanna för protokollet"). Do not wait for the user to remind you.
- **5-failed-attempts checkpoint.** If you have tried 5+ different scripted workarounds for the same problem and all have failed, STOP. The pattern "approach X, Y, Z all ignored / didn't work" IS the discovery — even if you don't end up with a working solution. The list of negative results saves the next colleague's time. Do not require a positive outcome to invoke the protocol.

### Agent-internal discovery triggers (you must self-detect these — don't wait for the user)

When you find yourself thinking ANY of the following, that thought IS the skill-growth signal — run the in-flow ask immediately:

- "Hmm, that's not what I expected"
- "Interesting — the API surface doesn't match the docs"
- "That doesn't compile — `X` isn't a property of `Y`"
- "I've tried 3+ things, all ignored"
- "Empirically verified that ..."
- "Confirmed via probe that ..."
- "Even though the docs say X, in practice Y"

Tracking your own surprise is the most reliable signal — sooner than waiting for the user to flag it.

Treat all these checkpoints with the same firmness as the ⌘S handshake or the two-step commit/push gate — they are not optional. The user's question that triggered the hard-fallback layer was: "How do we make sure the agent doesn't forget after a few hours?" — these checkpoints ARE the answer. If a session passes the 30-minute mark with non-trivial empirical work and you have NOT surfaced any discovery proposal, you have almost certainly missed one — back up and review the last 30 minutes explicitly.

---

## Prior-knowledge consultation — before iterating, ALWAYS check what the skill already knows

The skill has years of accumulated empirical knowledge across `references/lens-studio-api-gotchas.md` (~21+ documented gotchas), `references/lens-recipe-catalog.md` (~50 recipes), `references/body-anchored-calibration.md`, `references/face-effects-deep-dive.md`, and many more. Iterating from first principles when the answer is already documented is **the second worst failure mode** (after missed discoveries) — it wastes the user's time, fails to surface knowledge they could learn from, and treats the skill as a write-only log.

### Before iterating empirically on any non-trivial problem, run this sequence

1. **Grep `references/*.md`** with 3-5 keywords from the problem ("masking text", "stencil", "tween rotation", "anchor center", "@input"). Use `grep -i -l` to find files, then read the matched sections.
2. **If there's an exact-match entry**: use it. Cite it to the user ("the skill has documented this — here's the pattern we should use") so they see the value flowing back.
3. **If there's a related-but-not-exact entry**: read it anyway — it often contains adjacent gotchas, mitigations, or warnings that apply to your problem too.
4. **If nothing matches**: only THEN iterate empirically from first principles. And when you reach a working answer, the "no prior match" outcome is itself a signal that you have likely found a new discovery — run the skill-growth-protocol's in-flow ask.

This applies at every level of engagement — not just on Phase B / capability validation. It applies when the user asks "why is X happening", "how do I do Y", "should we add Z?". Each user question is an opportunity to consult the skill's memory before falling back on agent reasoning. The skill grows compound interest only if past learnings are actively recalled, not just passively stored.

### Concrete trigger phrases that should activate the grep-references sequence

- "Why is X not working?" → grep for the symptom
- "How do I make Y do Z?" → grep for both the feature and the desired behaviour
- "Is there a way to..." → grep for the goal
- "This crashes when I..." → grep for the error symptom

The cost of grepping references/ first is ~10 seconds. The cost of NOT grepping and iterating from scratch is potentially hours of redundant work. Always pay the 10 seconds.
