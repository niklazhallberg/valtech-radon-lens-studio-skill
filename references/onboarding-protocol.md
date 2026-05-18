# Onboarding protocol

The 4-question / 2-block intake CC runs after concierge setup completes. The structure is ANNOUNCED to the user (designers want a map). Goal: minimum questions, maximum inference, zero redundancy with concierge setup.

**Slimming history:** Previous versions had 8Q / 3-block intake. Vision + lens mechanics (lens-type, trigger, end-state) are now captured in concierge Step 6; client + ad-policy in Step 3. Deadline + feeling/tempo questions removed — feeling jargon was hard for designers to answer, deadline is asked on demand when polish-pacing matters (Phase 3).

## Contents
- Onboarding philosophy
- The opening — handoff from concierge
- Block 1 — Mechanic (2 questions: off-limits + audio)
- Block 2 — Assets (2 questions: INSPIRATION confirmation + similar-lens, brand-assets)
- Readiness Report gate
- Proactive clarification per phase
- Anti-patterns
- Good patterns
- Cross-references

## Onboarding philosophy

Core principles. For the WHY of each, see `voice-and-pedagogy.md`.

- **Announce roadmap.** Tell the user upfront: 4 questions, 2 blocks, ~2–3 min. Don't hide the structure — designers want to know where they are. Implements `voice-and-pedagogy.md` #5 + #7.
- **Show progress between questions.** Between each Q, signal "Block X of Y · Question N". Template 1 in `mentor-flow-patterns.md`.
- **Name value-exchange per question.** Each Q says what the user GETS for their input.
- **Ask minimum. Infer maximum.** Designers don't know exact specs — they know feel. After all 4 are answered, CC reads INSPIRATION/ + the similar-lens reference and infers concrete design decisions WITHOUT asking.
- **No redundancy with concierge.** Vision, lens mechanics (lens-type / trigger / end-state), and client + ad-policy are captured in concierge Step 3 + 6. NEVER re-ask in intake.
- **Preserve creative momentum.** Conversational, not bureaucratic. Keep acknowledgments short (1 sentence max between questions).
- **Translate jargon on first use.** Per `glossary-translation.md` first-use rule. If a term might confuse, drop 1 plain sentence then move on.
- **Allow skip on every question.** Every Q ends with `(Type 'skip' if you want to skip it.)` as a discreet hint in parentheses. If the user types "skip", the agent ONLY answers "OK, moving on." and continues to the next question — never ask why, never comment on the count, never push back. Skipped questions land as `[Not answered]` in the Readiness Report.

## The opening — handoff from concierge

(After concierge Step 8 ends and the user has just said "done" after dropping INSPIRATION/ images.)

CC opens with the structure announcement:

> CC: "Good — now we move from setup to the actual brief. I'll ask **4 questions in two blocks** — mechanic, assets — it takes 2–3 min. The sharper you answer, the more I can infer on my own later instead of asking about small things. Type 'skip' on a question that doesn't feel relevant — we just move on to the next.
>
> **Block 1 of 2 — Mechanic.**
> Question 1: Anything explicitly off-limits? Examples: 'no face liquify' (brand prefers ungimmicked face), 'no 18+ gating even though the category allows it' (campaign decision), 'must be selfie-only' (no rear camera).
>
> (Type 'skip' if you want to skip it.)"

Deliberate elements in this opening:
- "4 questions in two blocks" — roadmap. The user now has a map.
- "2–3 min" — time-commitment expectation, set honestly.
- "The sharper you answer, the more..." — value-exchange. The user knows effort is rewarded.
- "Type 'skip' on a question..." — agency. Pause valve always present. Canonical command is `skip`.
- "Block 1 of 2 — Mechanic" — first progress signal. Sets the pattern.
- Then immediately first question — no further preamble. Headline first.

## Block 1 — Mechanic (2 questions)

This block captures edges of the spec that can't be inferred safely: off-limits items and audio.

Note on what's NOT here: vision, lens-type, trigger, end-state, and client + ad-policy are all captured in concierge Step 3 + Step 6 — re-asking them here is an anti-pattern. Feeling/tempo/deadline are removed entirely (feeling = jargon-heavy, tempo = inferred from INSPIRATION/ + similar-lens, deadline = asked on demand when Phase 3 polish-pacing matters).

**Q1 — Off-limits:**

> "Question 1: Anything explicitly off-limits? Examples: 'no face liquify' (brand prefers ungimmicked face), 'no 18+ gating even though the category allows it' (campaign decision), 'must be selfie-only' (no rear camera).
>
> (Type 'skip' if you want to skip it.)"

Key rule: don't ask "any constraints?" generically — ask explicitly for off-limits items. Open questions get empty answers; specific examples prompt specific answers.

**Q2 — Audio:**

> "Question 2: Audio — yes or no? If yes: music, sound effects, or an existing sonic asset (client jingle)?
>
> (Type 'skip' if you want to skip it.)"

Why this is now an explicit question (NEW): Previous versions silently defaulted to no audio. But branded lenses often have a sonic identity (jingle, branded SFX) that can't be inferred from images. Asking saves a Phase 2 surprise rework. Skip is fine — default behavior is silent.

Inference notes:
- "no" → silent default, no Audio Component in scene
- "music" → CC picks a royalty-free / licensed track based on tempo + feeling inferred from INSPIRATION/
- "SFX" → CC plans short triggered cues at key animation beats
- "existing sonic asset" → ask user to drop the file in `brand-assets/audio/`

## Block 2 — Assets (2 questions)

Block transition:

> "Good. Two questions left.
>
> **Block 2 of 2 — Assets.** Here I look through the inspiration images you dropped and you help me fill in the gaps."

CC says one friendly context line so Anna understands why bash output is about to appear (Template 6 in `mentor-flow-patterns.md` — embodied screenshot narration applies here too):

> "Looking through the inspiration images you put in..."

Then CC runs:

```bash
ls ~/Projects/[client]-lens/INSPIRATION/
find ~/Projects/[client]-lens/INSPIRATION/ -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.mp4" \) | head -20
```

CC extracts visual signals via reading the images (color analysis, composition, motion characterization).

When surfacing findings, present them naturally — never "I ran find ~/Projects/... and found 5 files" but "You have 5 images. I see dark tones, neon accents, and minimalist style...".

**Q3 — Inspiration confirmation + similar-lens reference:**

> "Question 3: The INSPIRATION/ folder has [N] images. I see [extracted summary — e.g. 'dark moody color palette with neon accents, slow motion, minimalist composition, Spotify brand elements']. Does that match your direction, or am I reading the wrong signals?
>
> Is there an existing Snapchat lens you've seen that resembles what you want to build? A Snapcode or link helps a lot — it's worth five other inference questions.
>
> (Type 'skip' if you want to skip it.)"

User confirms/corrects the visual summary AND (optionally) provides a Snapcode/link to a comparable lens.

The similar-lens reference is high-value: it gives CC a concrete benchmark for motion feel, interaction pattern, polish level, and tween character. If the user provides one, CC analyzes it (Snapcode → Snap web preview or frame extraction) and snaps Phase 0–3 defaults to match. Worth far more than an open "what tempo?" question.

**Q4 — Brand assets:**

> "Question 4: Anything specific in `brand-assets/` I should know? Logos, brand colors, fonts the client has locked?
>
> (Type 'skip' if you want to skip it.)"

If `brand-assets/` is empty → CC will infer brand from INSPIRATION/ + client name. If populated → CC uses those as authoritative over inference.

## Readiness Report gate

After all 4 questions are answered, CC drafts a Readiness Report. The table consolidates everything from Step 3, Step 6, the 4 intake answers, plus CC's inferences from INSPIRATION/ + similar-lens reference.

CC opens with:

> "Done — all 4 questions answered. Now I'll summarize a **Readiness Report** — a table with all the decisions we've made. You go through row-by-row, say OK or change, then I'll run Phase 0 (specs)."

Then the table (markdown):

```markdown
## Readiness Report — [client] Lens

| Decision | Value | Source | |
|---|---|---|---|
| Vision | [one-line lens description] | Step 6 | ✔ |
| Lens-type | [transformation / overlay / try-on / world-lens] | Step 6 | ✔ |
| Trigger | [expression / tap / always-on / product-recognition] | Step 6 | ✔ |
| End-state | [one-shot-payoff / loop / game-loop] | Step 6 | ✔ |
| Client + category | [client name, ad-policy category] | Step 3 | ✔ |
| Off-limits | [intake Q1] | Intake | ✔ |
| Audio | [intake Q2 — yes (music/SFX/asset) or no] | Intake | ✔ |
| Similar-lens reference | [Snapcode/link from intake Q3, or '[Not answered]'] | Intake | ✔ |
| **CC inference (from INSPIRATION/ + similar-lens)** | | | |
| Color palette | [3-5 hex codes] | Inferred | ✔/✏️ |
| Motion feel | [ambient / sharp / elastic / etc.] | Inferred | ✔/✏️ |
| Mood signals | [extracted from imagery + reference] | Inferred | ✔/✏️ |
| Typography | [modern / classic / playful / etc.] | Inferred | ✔/✏️ |
| Composition | [centered / dramatic / minimal / etc.] | Inferred | ✔/✏️ |
| **Defaults** | | | |
| Reset | No auto-reset (user controls re-trigger) | Default | ✔/✏️ |
| Camera | Front-only (selfie) | Default | ✔/✏️ |
```

**Skipped questions:** if the user typed "skip" on a question, that row shows `[Not answered]` in the Value column. CC does NOT re-ask at Readiness Report stage — if the user wanted to fill it in, they would have. CC may suggest sensible defaults during phase work where the missing answer would otherwise block, but never frames it as "you missed question N".

**After the table, CC explains the docs that come next — plain language FIRST, filename SECOND:**

> "Once you say OK on the table, I'll create three planning documents:
>
> - **A spec for the tech** — scene hierarchy, scripts, performance targets. Stored as `docs/TECH-SPEC.md`.
> - **A second-by-second journey** — what the user sees and experiences from 0 to lens close. Stored as `docs/USER-EXPERIENCE.md`.
> - **A log of every decision we make** — each small inference I make lands here so you can challenge it later. Stored as `docs/PROJECT-DECISIONS.md`.
>
> Reply:
> - **'go phase 0'** if all rows look right
> - **'change [row]: [new value]'** for an adjustment
> - Or say your position on open questions if I've flagged any"

Wait for "go phase 0" before drafting. If the user replies with "change X: Y", update the relevant row, re-surface the table, wait again.

## Proactive clarification (per-phase, 2–4 questions max)

At the start of every phase, CC runs this protocol (unchanged from prior versions — patterns here were already mentor-toned):

1. Read all user-provided files relevant to the phase
2. Identify what's truly UNCLEAR or MISSING — not what could be inferred
3. Surface 2–4 targeted questions BEFORE building
4. Each question has options + a recommendation. Don't ask open-ended.
5. Wait for answers
6. Document answers in `PROJECT-DECISIONS.md`
7. Proceed

### Phase 0 template — concept clarification

Trigger is now captured in Step 6 (concierge), so the only remaining Phase 0 question is reset behavior:

> "Reading brief + inspiration. Before I draft the specs, one thing to clarify:
>
> **Reset**: tap to reset to baseline, or no-reset (the effect persists until the lens is closed)? Default: no-reset.
>
> Answer with one word. Then I'll get going."

### Phase 1 template — scene placement

> "Building the static scene. 2 placement confirmations:
>
> 1. **Primary element placement**: chest height or face height? Default from inspiration: face height.
> 2. **Background treatment**: full effect or partial overlay? Default: partial overlay (face still visible)."

### Phase 2 template — animation timing + trigger

> "Animations need direction:
>
> 1. **Tween timing**: fast (0.3s), medium (0.6s), or slow (1.0s)? Default from your tempo answer: [extracted].
> 2. **End state**: held until tap, auto-reset after N seconds, or user-choice loop? Default: held until tap (matches the no-reset principle).
> 3. **Gating during animation**: ignore taps mid-tween (cleaner), or queue them (responsive but choppy)? Default: ignore."

### Phase 2.5 template — advanced features

> "For [feature — e.g. face liquify]:
>
> 1. **Magnitude**: subtle (1.0x baseline) / moderate (1.2x) / dramatic (1.5x+)? Default from feeling answer: [extracted].
> 2. **Trigger**: automatically on lens open, or user tap? Default: automatic.
> 3. **Reset on tap**: yes/no? Default: no (the effect persists)."

### Phase 3 template — polish iteration

> "Polish pass. From your inspection of [feature] in Preview, what feels wrong?
>
> Common dimensions: magnitude (too strong/weak), timing (rushed/sluggish), color (saturated/muted), position (occlusion/empty space), easing (linear/elastic/cubic).
>
> Say ONE specific thing you want to fix. I iterate, then surface for re-check."

### Phase 5 template — submission prep

> "Ready for submission. 3 confirmations:
>
> 1. **Ad-account target**: [client] or [agency]? Pull from the Submit panel dropdown.
> 2. **Lens name** (final, not 'Untitled' from LS): ?
> 3. **Preview video**: I generate via LS Preview recording, or you provide a polished version?
>
> Snap submission is irreversible — confirm carefully."

## Anti-patterns

❌ Asking the 4 questions in a wall-of-text without a progress signal
❌ Re-asking lens-type, trigger, or end-state during intake (already captured in Step 6 — anti-redundancy)
❌ Re-asking client or ad-policy category (already captured in Step 3 — anti-redundancy)
❌ Asking "what feeling?" with jargon word choices ("playful / mysterious / energetic / calm") — the words are hard for designers to answer; use visual references (INSPIRATION/ + similar-lens) instead
❌ Asking about deadline preemptively — wait until it matters (Phase 3 polish-pacing or if the user themselves mentions urgency)
❌ "I need exact hex codes for primary and secondary brand colors" (infer from INSPIRATION/ instead)
❌ "What's your preferred easing function?" (jargon for non-experts — translate or skip)
❌ "Are there any constraints?" (too open — ask explicitly for off-limits)
❌ Building blind without asking when ambiguity is genuine
❌ Surfacing 10 inferences in PROJECT-DECISIONS.md without asking the user to confirm the critical ones
❌ Status-log voice during transitions: "Q1 captured. Moving to Q2." (use `mentor-flow-patterns.md` Template 1 instead)
❌ Numeric tween durations in user-facing questions (use sensory examples or rely on similar-lens reference)
❌ Asking "why did you skip Q2?" — never re-probe skipped questions
❌ Status-log on skips: "✅ Skipped Q2" (use "OK, moving on." instead)
❌ Counting skips and commenting: "You've skipped 4 questions — want to go back?"

## Good patterns

✅ Announce structure upfront ("4 questions in 2 blocks, ~2–3 min")
✅ Progress signal between questions ("Block 1 of 2 — Mechanic. Question 2...")
✅ Value-exchange in every question ("A Snapcode helps a lot — it's worth five other inference questions")
✅ Sensory examples instead of numbers ("Like a TikTok transition" vs "0.3s ease-out")
✅ Plain-language file-purpose before filename ("A log of every decision" → "Stored as PROJECT-DECISIONS.md")
✅ "Pulled palette from INSPIRATION/: deep blue (#1e5d8c), teal (#3a9ab8), coral (#e89880). Matches?"
✅ "Bubbles: ambient (always) or triggered (on tap/smile)?" — genuine ambiguity, no inference possible
✅ Discreet skip hint in parentheses at the bottom of every question: `(Type 'skip' if you want to skip it.)`
✅ Single-line acknowledgment on skip: "OK, moving on." — nothing more
✅ Skipped fields → `[Not answered]` in Readiness Report, never re-prompted

## Cross-references

- `voice-and-pedagogy.md` — 8 principles each section here implements
- `mentor-flow-patterns.md` — Template 1 (progress-bar) in every block transition; Template 6 (embodied screenshot) when reading INSPIRATION/
- `glossary-translation.md` — translate any technical term on first use (GLB/FBX/state machine/etc.)
- `concierge-setup-flow.md` — Step 8 (handoff to onboarding) opens with the structure announcement above
- `body-anchored-calibration.md` — applied per phase when the project involves tracker-driven content
- `phase-progression.md` — Readiness Report → Phase 0 transition; per-phase clarification templates referenced above
