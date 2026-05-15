# Onboarding protocol

The 4-question / 2-block intake CC runs after concierge setup completes. The structure is ANNOUNCED to the user (designers want a map). Goal: minimum questions, maximum inference, zero redundancy with concierge setup.

**Slimming history:** Previous versions had 8Q / 3-block intake. Vision + lens-mechanics (lens-type, trigger, end-state) are now captured in concierge Step 6; client + ad-policy in Step 3. Deadline + feeling/tempo questions removed — feeling jargon was hard for designers to answer, deadline is asked on demand when polish-pacing matters (Phase 3).

## Contents
- Onboarding philosophy
- The opening — handoff from concierge
- Block 1 — Mechanic (2 frågor: off-limits + audio)
- Block 2 — Assets (2 frågor: INSPIRATION-confirmation + similar-lens, brand-assets)
- Readiness Report gate
- Proactive clarification per phase
- Anti-patterns
- Good patterns
- Cross-references

## Onboarding philosophy

Core principles. For the WHY of each, see `voice-and-pedagogy.md`.

- **Announce roadmap.** Tell the user upfront: 4 frågor, 2 block, ~2–3 min. Don't hide the structure — designers want to know where they are. Implements `voice-and-pedagogy.md` #5 + #7.
- **Show progress between questions.** Between each Q, signal "Block X av Y · Fråga N". Template 1 in `mentor-flow-patterns.md`.
- **Name value-exchange per question.** Each Q says what the user GETS for their input.
- **Ask minimum. Infer maximum.** Designers don't know exact specs — they know feel. After all 4 answered, CC reads INSPIRATION/ + the similar-lens reference and infers concrete design decisions WITHOUT asking.
- **No redundancy with concierge.** Vision, lens-mechanics (lens-type / trigger / end-state), and client + ad-policy are captured in concierge Step 3 + 6. NEVER re-ask in intake.
- **Preserve creative momentum.** Conversational, not bureaucratic. Keep acknowledgments short (1 sentence max between questions).
- **Translate jargon on first use.** Per `glossary-translation.md` first-use-rule. If a term might confuse, drop 1 plain sentence then move on.
- **Allow skip on every question.** Varje Q slutar med `(Skriv 'skip' om du vill hoppa över.)` som en diskret hint i parentes. Om användaren skriver "skip" svarar agenten ENDAST "Ok, då går vi vidare." och fortsätter till nästa fråga — fråga aldrig varför, kommentera aldrig antal, pressa aldrig tillbaka. Skippade frågor landar som `[Ej besvarad]` i Readiness Report.

## The opening — handoff from concierge

(After concierge Step 8 ends and the user has just said "klar" after dropping INSPIRATION/ images.)

CC opens with the structure-announcement:

> CC: "Bra — nu går vi från setup till själva briefen. Jag ställer **4 frågor i två block** — mechanic, assets — det tar 2–3 min. Ju skarpare du svarar, desto mer kan jag dra slutsatser själv senare istället för att fråga dig om småsaker. Skriv 'skip' på en fråga som inte känns relevant — vi går bara vidare till nästa.
>
> **Block 1 av 2 — Mechanic.**
> Fråga 1: Något explicit off-limits? Exempel: 'no face liquify' (brand prefers ungimmicked face), 'no 18+ gating även om kategorin tillåter' (campaign decision), 'must be selfie-only' (no rear camera).
>
> (Skriv 'skip' om du vill hoppa över.)"

Deliberate elements in this opening:
- "4 frågor i två block" — roadmap. User now has a map.
- "2–3 min" — time-commitment expectation, set honestly.
- "Ju skarpare du svarar, desto mer..." — value-exchange. User knows effort is rewarded.
- "Skriv 'skip' på en fråga..." — agency. Pause valve always present. Canonical command is `skip`.
- "Block 1 av 2 — Mechanic" — first progress signal. Sets the pattern.
- Then immediately first question — no further preamble. Headline first.

## Block 1 — Mechanic (2 frågor)

This block captures edges of the spec that can't be inferred safely: off-limits items and audio.

Note on what's NOT here: vision, lens-type, trigger, end-state, and client + ad-policy are all captured in concierge Steg 3 + Steg 6 — re-asking them here is an anti-pattern. Feeling/tempo/deadline are removed entirely (feeling = jargon-heavy, tempo = inferred from INSPIRATION/ + similar-lens, deadline = asked on demand when Phase 3 polish-pacing matters).

**Q1 — Off-limits:**

> "Fråga 1: Något explicit off-limits? Exempel: 'no face liquify' (brand prefers ungimmicked face), 'no 18+ gating även om kategorin tillåter' (campaign decision), 'must be selfie-only' (no rear camera).
>
> (Skriv 'skip' om du vill hoppa över.)"

Key rule: don't ask "är det några constraints?" generically — ask explicitly for off-limits items. Open questions get empty answers; specific examples prompt specific answers.

**Q2 — Audio:**

> "Fråga 2: Ljud — ja eller nej? Om ja: musik, sound effects, eller en befintlig sonic asset (klient-jingle)?
>
> (Skriv 'skip' om du vill hoppa över.)"

Why this is now an explicit question (NEW): Previous versions silently defaulted to no audio. But branded lenses often have a sonic identity (jingle, branded SFX) that can't be inferred from images. Asking saves a Phase 2 surprise rework. Skip is fine — default behaviour is silent.

Inference notes:
- "no" → silent default, no Audio Component in scene
- "music" → CC picks a royalty-free / licensed track based on tempo + feeling inferred from INSPIRATION/
- "SFX" → CC plans short triggered cues at key animation beats
- "existing sonic asset" → ask user to drop the file in `brand-assets/audio/`

## Block 2 — Assets (2 frågor)

Block transition:

> "Bra. Två frågor kvar.
>
> **Block 2 av 2 — Assets.** Här kollar jag igenom inspiration-bilderna du droppade och du hjälper mig fylla i luckorna."

CC says one friendly context line so Anna understands why bash output is about to appear (Template 6 in `mentor-flow-patterns.md` — embodied screenshot narration applies here too):

> "Kikar igenom inspiration-bilderna du la in..."

Then CC runs:

```bash
ls ~/Projects/[client]-lens/INSPIRATION/
find ~/Projects/[client]-lens/INSPIRATION/ -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.mp4" \) | head -20
```

CC extracts visual signals via reading the images (color analysis, composition, motion characterization).

When surfacing findings, present them naturally — never "I ran find ~/Projects/... and found 5 files" but "Du har 5 bilder. Jag ser mörka toner, neon-accenter, och minimalistisk stil...".

**Q3 — Inspiration confirmation + similar-lens reference:**

> "Fråga 3: INSPIRATION/-foldern har [N] bilder. Jag ser [extracted summary — t.ex. 'mörk moody färgpalett med neon-accenter, långsam motion, minimalistisk komposition, Spotify-brand-element']. Stämmer det med din riktning, eller läser jag fel signaler?
>
> Finns det en befintlig Snapchat-lens du sett som liknar det du vill bygga? Snapcode eller länk hjälper massor — det är värt fem andra inferensfrågor.
>
> (Skriv 'skip' om du vill hoppa över.)"

User confirms/corrects the visual summary AND (optionally) provides a Snapcode/link to a comparable lens.

The similar-lens reference is high-value: it gives CC a concrete benchmark for motion-feel, interaction-pattern, polish-level, and tween-character. If the user provides one, CC analyzes it (Snapcode → Snap web preview or frame extraction) and snaps Phase 0–3 defaults to match. Worth far more than an open "what tempo?" question.

**Q4 — Brand assets:**

> "Fråga 4: Något specifikt i `brand-assets/` jag bör veta? Logos, brand-färger, fonts klienten har låst?
>
> (Skriv 'skip' om du vill hoppa över.)"

If `brand-assets/` empty → CC will infer brand from INSPIRATION/ + client name. If populated → CC uses those as authoritative over inference.

## Readiness Report gate

After all 4 questions answered, CC drafts a Readiness Report. The table consolidates everything from Steg 3, Steg 6, the 4 intake-answers, plus CC's inferences from INSPIRATION/ + similar-lens reference.

CC opens with:

> "Klart — alla 4 frågor besvarade. Nu sammanställer jag en **Readiness Report** — en tabell med alla beslut vi tagit. Du går igenom rad-för-rad, säger OK eller ändrar, sen kör jag Phase 0 (specs)."

Then the table (markdown):

```markdown
## Readiness Report — [client] Lens

| Decision | Value | Source | |
|---|---|---|---|
| Vision | [one-line lens description] | Steg 6 | ✔ |
| Lens-type | [transformation / overlay / try-on / world-lens] | Steg 6 | ✔ |
| Trigger | [expression / tap / always-on / product-recognition] | Steg 6 | ✔ |
| End-state | [one-shot-payoff / loop / game-loop] | Steg 6 | ✔ |
| Client + category | [client name, ad-policy category] | Steg 3 | ✔ |
| Off-limits | [intake Q1] | Intake | ✔ |
| Audio | [intake Q2 — yes (music/SFX/asset) or no] | Intake | ✔ |
| Similar-lens reference | [Snapcode/link from intake Q3, or '[Ej angiven]'] | Intake | ✔ |
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

**Skipped questions:** if the user typed "skip" on a question, that row shows `[Ej besvarad]` in the Value column. CC does NOT re-ask at Readiness Report stage — if the user wanted to fill it in, they would have. CC may suggest sensible defaults during phase work where the missing answer would otherwise block, but never frames it as "you missed question N".

**After the table, CC explains the docs that come next — plain language FIRST, filename SECOND:**

> "När du sagt OK på tabellen skapar jag tre planerings-dokument:
>
> - **En spec för tekniken** — scen-hierarki, scripts, performance-mål. Lagras som `docs/TECH-SPEC.md`.
> - **En sekund-för-sekund-resa** — vad användaren ser och upplever från 0 till lens-stängning. Lagras som `docs/USER-EXPERIENCE.md`.
> - **En logg över alla beslut vi tar** — varje liten inference jag gör hamnar här så du kan ifrågasätta senare. Lagras som `docs/PROJECT-DECISIONS.md`.
>
> Svara:
> - **'go phase 0'** om alla rader ser rätt ut
> - **'ändra [rad]: [nytt värde]'** för en justering
> - Eller säg din position på öppna frågor om jag flaggat några"

Wait for "go phase 0" before drafting. If user replies with "ändra X: Y", update the relevant row, re-surface the table, wait again.

## Proactive clarification (per-phase, 2-4 questions max)

At the start of every phase, CC runs this protocol (unchanged from prior versions — patterns here were already mentor-toned):

1. Read all user-provided files relevant to the phase
2. Identify what's truly UNCLEAR or MISSING — not what could be inferred
3. Surface 2-4 targeted questions BEFORE building
4. Each question has options + a recommendation. Don't ask open-ended.
5. Wait for answers
6. Document answers in `PROJECT-DECISIONS.md`
7. Proceed

### Phase 0 template — concept clarification

Trigger is now captured in Steg 6 (concierge), so the only remaining Phase 0 question is reset behavior:

> "Reading brief + inspiration. Innan jag drar specs, en sak att klargöra:
>
> **Reset**: tap för att återställa till baseline, eller no-reset (effekten kvarstår tills lens stängs)? Default: no-reset.
>
> Svara med ett ord. Sen kör jag."

### Phase 1 template — scene placement

> "Bygger statisk scen. 2 placerings-bekräftelser:
>
> 1. **Primär elementplacering**: bröst-höjd eller ansikts-höjd? Default från inspiration: ansikts-höjd.
> 2. **Bakgrunds-behandling**: full effekt eller delvis overlay? Default: delvis overlay (ansikte fortfarande synligt)."

### Phase 2 template — animation timing + trigger

> "Animationer behöver riktning:
>
> 1. **Tween-timing**: snabbt (0.3s), medel (0.6s), eller långsamt (1.0s)? Default från ditt tempo-svar: [extracted].
> 2. **Slut-tillstånd**: hålls tills tap, auto-reset efter N sekunder, eller user-choice loop? Default: hålls tills tap (matchar no-reset-principen).
> 3. **Gating under animation**: ignorera taps mitt-i-tween (renare), eller queue:a dem (responsivt men hackigt)? Default: ignorera."

### Phase 2.5 template — advanced features

> "För [feature — t.ex. face liquify]:
>
> 1. **Magnitud**: subtil (1.0x baseline) / måttlig (1.2x) / dramatisk (1.5x+)? Default från känsla-svar: [extracted].
> 2. **Trigger**: automatiskt på lens-öppning, eller user-tap? Default: automatiskt.
> 3. **Reset på tap**: ja/nej? Default: nej (effekten kvarstår)."

### Phase 3 template — polish iteration

> "Polish-pass. Från din inspektion av [feature] i Preview, vad känns fel?
>
> Vanliga dimensioner: magnitud (för stark/svag), timing (rushat/sluggish), färg (mättat/dämpat), position (occlusion/tomrum), easing (linear/elastic/cubic).
>
> Säg ETT specifikt fel du vill fixa. Jag iterar, sen surfacar för re-check."

### Phase 5 template — submission prep

> "Ready för submission. 3 bekräftelser:
>
> 1. **Ad-account target**: [client] eller [agency]? Pulla från Submit-panel dropdown.
> 2. **Lens-name** (final, inte 'Untitled' från LS): ?
> 3. **Preview-video**: jag genererar via LS Preview-recording, eller du ger en polerad version?
>
> Snap submission är oåterkallelig — bekräfta noga."

## Anti-patterns

❌ Asking the 4 frågor i en wall-of-text utan progress-signal
❌ Återfråga lens-type, trigger eller end-state under intake (redan fångat i Steg 6 — anti-redundans)
❌ Återfråga client eller ad-policy category (redan fångat i Steg 3 — anti-redundans)
❌ Fråga "vilken känsla?" med jargong-ordval ("lekfull / mystisk / energisk / lugn") — orden är svåra för designers att svara på; använd visuella referenser (INSPIRATION/ + similar-lens) istället
❌ Fråga om deadline preemptivt — vänta tills det matters (Phase 3 polish-pacing eller om användaren själv nämner urgency)
❌ "I need exact hex codes for primary and secondary brand colors" (infer from INSPIRATION/ instead)
❌ "What's your preferred easing function?" (jargon for non-experts — translate or skip)
❌ "Are there any constraints?" (too open — ask explicitly for off-limits)
❌ Building blind without asking when ambiguity is genuine
❌ Surfacing 10 inferences in PROJECT-DECISIONS.md without asking user to confirm the critical ones
❌ Status-log voice during transitions: "Q1 captured. Moving to Q2." (use `mentor-flow-patterns.md` Template 1 instead)
❌ Numeric tween durations in user-facing questions (use sensory examples or rely on similar-lens reference)
❌ Asking "varför skippade du Q2?" — never re-probe skipped questions
❌ Status-log on skips: "✅ Skipped Q2" (use "Ok, då går vi vidare." istället)
❌ Counting skips and commenting: "Du har skippat 4 frågor — vill du gå tillbaka?"

## Good patterns

✅ Announce structure upfront ("4 frågor i 2 block, ~2–3 min")
✅ Progress signal between questions ("Block 1 av 2 — Mechanic. Fråga 2...")
✅ Value-exchange in every question ("Snapcode hjälper massor — det är värt fem andra inferensfrågor")
✅ Sensory examples instead of numbers ("Som en TikTok-transition" vs "0.3s ease-out")
✅ Plain-language file-purpose before filename ("En logg över alla beslut" → "Lagras som PROJECT-DECISIONS.md")
✅ "Pulled palette from INSPIRATION/: deep blue (#1e5d8c), teal (#3a9ab8), coral (#e89880). Matchar?"
✅ "Bubbles: ambient (always) eller triggered (on tap/smile)?" — genuine ambiguity, no inference possible
✅ Discreet skip-hint i parens längst ner i varje fråga: `(Skriv 'skip' om du vill hoppa över.)`
✅ Single-line acknowledgment på skip: "Ok, då går vi vidare." — inget mer
✅ Skipped fields → `[Ej besvarad]` i Readiness Report, aldrig re-prompted

## Cross-references

- `voice-and-pedagogy.md` — 8 principles each section here implements
- `mentor-flow-patterns.md` — Template 1 (progress-bar) in every block-transition; Template 6 (embodied screenshot) when reading INSPIRATION/
- `glossary-translation.md` — translate any technical term on first-use (GLB/FBX/state-machine/etc.)
- `concierge-setup-flow.md` — Step 8 (handoff to onboarding) opens with the structure-announcement above
- `body-anchored-calibration.md` — applied per-phase when project involves tracker-driven content
- `phase-progression.md` — Readiness Report → Phase 0 transition; per-phase clarification templates referenced above
