# Onboarding protocol

The 8-question / 3-block intake CC runs after concierge setup completes. **v0.7.0 update:** the 8/3 structure is now ANNOUNCED to the user (reverses prior "internal pacing" rule). Goal: minimum questions, maximum inference, but the user always knows where they are in the flow.

## Contents
- Onboarding philosophy (v0.7.0)
- The opening — handoff from concierge
- Block 1 — Vision (3 frågor)
- Block 2 — Ramar (3 frågor)
- Block 3 — Assets (2 frågor)
- Readiness Report gate
- Proactive clarification per phase
- Anti-patterns
- Good patterns
- Cross-references

## Onboarding philosophy (v0.7.0)

Shifts from prior versions summarized here. For the WHY of each shift, see `voice-and-pedagogy.md`.

- **Announce roadmap.** Tell the user upfront: 8 frågor, 3 block, ~5-10 min. Don't hide the structure to "feel conversational" — designers want to know where they are. Implements `voice-and-pedagogy.md` #5 (Connect over time) + #7 (Value-exchange transparency).
- **Show progress between questions.** Between each Q, signal "Block X av Y · Fråga N". Template 1 in `mentor-flow-patterns.md`.
- **Name value-exchange per question.** Each Q says what the user GETS for their input. Implements #7.
- **Ask minimum. Infer maximum.** Designers don't know exact specs — they know feel. After all 8 answered, CC reads INSPIRATION/ and infers concrete design decisions WITHOUT asking.
- **Preserve creative momentum.** Even with announced structure, intake is conversational — not bureaucratic. Keep acknowledgments short (1 sentence max between questions).
- **Translate jargon on first use.** Per `glossary-translation.md` first-use-rule. If a term might confuse, drop 1 plain sentence then move on.

## The opening — handoff from concierge

(After concierge Step 8 ends and the user has just said "klar" after dropping INSPIRATION/ images.)

CC opens with the structure-announcement:

> CC: "Bra — nu går vi från setup till själva briefen. Jag ställer ungefär **8 frågor i tre block** — vision, ramar, assets — det tar 5-10 min. Ju skarpare du svarar, desto mer kan jag dra slutsatser själv senare istället för att fråga dig om småsaker. Du kan alltid säga 'hoppa över' eller 'jag vet inte än'.
>
> **Block 1 av 3 — Vision.**  
> Fråga 1: Beskriv lensen i 1-2 meningar — vad ska hända för användaren?"

Deliberate elements in this opening:
- "8 frågor i tre block" — roadmap. User now has a map.
- "5-10 min" — time-commitment expectation, set honestly.
- "Ju skarpare du svarar, desto mer..." — value-exchange. User knows effort is rewarded.
- "Du kan alltid säga 'hoppa över'" — agency. Pause valve always present.
- "Block 1 av 3 — Vision" — first progress signal. Sets the pattern.
- Then immediately first question — no further preamble. Headline first.

## Block 1 — Vision (3 frågor)

**Q1.1 — The moment:**

> "Fråga 1: Beskriv lensen i 1-2 meningar — vad ska hända för användaren?"

Example expected answer: *"User holds up phone, lens detects mood from expression, suggests Spotify podcast. Tap-to-confirm reveals podcast art with play button."*

Why open-ended: at this point, CC has no design constraints to work from. Forcing a tight schema here loses creative range.

**Q1.2 — The feeling (open answer + invitation):**

> "Fråga 2: Vilken känsla ska lensen lämna efter sig? Ett ord räcker (lekfull / mystisk / energisk / lugn / surrealistisk / nostalgisk / filmisk / kaotisk) — men säg gärna mer om du har det i huvudet. Två meningar om varför är guld, det styr hur jag väljer rörelse, färgmättnad och easing senare."

Key change from prior version: NOT "one word only". User can give one word OR a sentence OR a paragraph. The value-exchange ("två meningar om varför är guld, det styr X") makes the invitation legible.

Inference rules:
- 1-word answer → CC drives motion + color + easing defaults from mood-keyword alone
- Sentence answer → CC pulls additional design-direction (e.g., "premium men inte stel" → muted color saturation, slower easing)
- Paragraph → CC writes a clear `mood-direction.md` snippet for the Readiness Report

**Q1.3 — Tempo (sensory examples + reference clip invitation):**

> "Fråga 3: Tempo — hur snabbt ska saker hända?
> - **Snabbt / snäppigt** — saker poppar in direkt, som en TikTok-transition eller en notis som flyger in. Bra för humor och energi.
> - **Medel** — saker rör sig som i en välgjord app-onboarding, märkbart men inte hastigt.
> - **Långsamt / filmiskt** — saker svävar in, som en filmtrailer eller en parfymreklam. Bra för mystik, lyx, drömskt.
>
> Har du klipp eller filter du sett som har rätt tempo? Släng in en länk eller skärmdump i INSPIRATION/ — då matchar jag exakt istället för att gissa."

Key change from prior version: NO numeric tween durations in the question. They map to numbers internally for CC:
- snabbt → 0.2-0.4s tweens, sharp easing
- medel → 0.5-0.8s, standard ease-in-out
- långsamt → 0.8-1.5s, soft easings (cubic, sine)

The user picks the SENSORY label; CC handles the numbers in PROJECT-DECISIONS.md / TECH-SPEC.md.

If user provides a reference clip: CC analyzes (frame-by-frame if possible) and snaps tween durations + easing curves to match.

## Block 2 — Ramar (3 frågor)

Block transition (Template 1 from `mentor-flow-patterns.md`):

> "Klart — vi har visionen pinned. Tre frågor kvar att jobba med: ramar, assets, sen Readiness Report.
>
> **Block 2 av 3 — Ramar** (handlar om klient, deadline, off-limits).  
> Fråga 4: Vilken klient + ad-policy-kategori?"

**Q2.1 — Client + ad-policy category:**

> "Fråga 4: Vilken klient + ad-policy-kategori? T.ex. 'adidas, sportswear (general)' eller 'RFSU, sexual wellness (regulated)'. Påverkar Snap:s review-tid (1-3 dagar för general, 1-2 veckor för regulated)."

Value-exchange explicit: tells user WHY this matters (review timeline).

**Q2.2 — Off-limits:**

> "Fråga 5: Något explicit off-limits? Exempel: 'no face liquify' (brand prefers ungimmicked face), 'no 18+ gating även om kategorin tillåter' (campaign decision), 'must be selfie-only' (no rear camera)."

Key rule: don't ask "är det några constraints?" generically — ask explicitly for off-limits items. Open questions get empty answers; specific examples prompt specific answers.

**Q2.3 — Deadline:**

> "Fråga 6: När ska lensen vara live? Ett datum eller en vecka. Styr hur många Phase 3 polish-iterationer vi hinner med och om vi behöver hoppa över Phase 2.5 advanced features."

Value-exchange: explicit about how the answer shapes the plan.

## Block 3 — Assets (2 frågor)

Block transition:

> "Bra. Två frågor kvar.
>
> **Block 3 av 3 — Assets.** Här kollar jag igenom inspiration-bilderna du droppade och du hjälper mig fylla i luckorna."

CC says one friendly context line so Anna understands why bash output is about to appear (Template 6 in `mentor-flow-patterns.md` — embodied screenshot narration applies here too):

> "Kikar igenom inspiration-bilderna du la in..."

Then CC runs:

```bash
ls ~/Projects/[client]-lens/INSPIRATION/
find ~/Projects/[client]-lens/INSPIRATION/ -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.mp4" \) | head -20
```

CC extracts visual signals via reading the images (color analysis, composition, motion characterization).

When surfacing findings, present them naturally — never "I ran find ~/Projects/... and found 5 files" but "Du har 5 bilder. Jag ser mörka toner, neon-accenter, och minimalistisk stil...".

**Q3.1 — Inspiration confirmation:**

> "Fråga 7: INSPIRATION/-foldern har [N] bilder. Jag ser [extracted summary — t.ex. 'mörk moody färgpalett med neon-accenter, långsam motion, minimalistisk komposition, Spotify-brand-element']. Matchar din vision, eller läser jag fel signaler?"

User confirms or corrects. CC adjusts inference.

**Q3.2 — Brand assets:**

> "Fråga 8: Något specifikt i `brand-assets/` jag bör veta? Logos, brand-färger, fonts klienten har låst?"

If `brand-assets/` empty → CC will infer brand from INSPIRATION/ + client name. If populated → CC uses those as authoritative over inference.

## Readiness Report gate

After all 8 questions answered, CC drafts a Readiness Report. **v0.7.0 update:** explain each output file in plain language BEFORE naming the file (per `voice-and-pedagogy.md` Pedagogy layer + `glossary-translation.md` first-use rule).

CC opens with:

> "Klart — alla 8 frågor besvarade. Nu sammanställer jag en **Readiness Report** — en tabell med alla beslut vi tagit i intake. Du går igenom rad-för-rad, säger OK eller ändrar, sen kör jag Phase 0 (specs)."

Then the table (markdown):

```markdown
## Readiness Report — [client] Lens

| Decision | Value | |
|---|---|---|
| Vision | [Q1.1 verbatim] | ✔ |
| Feeling | [Q1.2] | ✔ |
| Pace | [Q1.3] | ✔ |
| Client + category | [Q2.1] | ✔ |
| Off-limits | [Q2.2] | ✔ |
| Deadline | [Q2.3] | ✔ |
| **CC inference** | | |
| Color palette | [3-5 hex codes from INSPIRATION/] | ✔/✏️ |
| Motion feel | [characterized: ambient/sharp/elastic/etc.] | ✔/✏️ |
| Mood signals | [extracted from imagery] | ✔/✏️ |
| Typography | [inferred: modern/classic/playful/etc.] | ✔/✏️ |
| Composition | [centered/dramatic/minimal/etc.] | ✔/✏️ |
| **Defaults** | | |
| Audio | Silent (no ambient track) | ✔/✏️ |
| Interaction | Tap-anywhere primary trigger | ✔/✏️ |
| Reset | No auto-reset (user controls re-trigger) | ✔/✏️ |
| Camera | Front-only (selfie) | ✔/✏️ |
```

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

> "Reading brief + inspiration. Innan jag drar specs, 2 saker att klargöra:
>
> 1. **Trigger-modell**: tap-anywhere för att starta effekten, eller always-on (effekten startar när lensen öppnas)? Default: always-on (matchar 'lugn + filmisk' pace).
> 2. **Reset**: tap för att återställa till baseline, eller no-reset (effekten kvarstår tills lens stängs)? Default: no-reset.
>
> Svara med ett ord per fråga. Sen kör jag."

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

## Anti-patterns (v0.7.0)

❌ Asking 8 frågor i en wall-of-text utan progress-signal
❌ "I need exact hex codes for primary and secondary brand colors" (infer from INSPIRATION/ instead)
❌ "What's your preferred easing function?" (jargon for non-experts — translate or skip)
❌ "Are there any constraints?" (too open — ask explicitly for off-limits)
❌ Building blind without asking when ambiguity is genuine
❌ Surfacing 10 inferences in PROJECT-DECISIONS.md without asking user to confirm the critical ones
❌ Status-log voice during transitions: "Q1.1 captured. Moving to Q1.2." (use `mentor-flow-patterns.md` Template 1 instead)
❌ Numeric tween durations in user-facing Q1.3 (use sensory examples — TikTok-transition vs parfymreklam)

## Good patterns (v0.7.0)

✅ Announce structure upfront ("8 frågor i 3 block, ~5-10 min")
✅ Progress signal between questions ("Block 1 av 3 — Vision. Fråga 3...")
✅ Value-exchange in every question ("Två meningar om varför är guld, det styr...")
✅ Sensory examples instead of numbers ("Som en TikTok-transition" vs "0.3s ease-out")
✅ Plain-language file-purpose before filename ("En logg över alla beslut" → "Lagras som PROJECT-DECISIONS.md")
✅ "Pulled palette from INSPIRATION/: deep blue (#1e5d8c), teal (#3a9ab8), coral (#e89880). Matchar?"
✅ "Bubbles: ambient (always) eller triggered (on tap/smile)?" — genuine ambiguity, no inference possible

## Cross-references

- `voice-and-pedagogy.md` — 8 principles each section here implements
- `mentor-flow-patterns.md` — Template 1 (progress-bar) in every block-transition; Template 6 (embodied screenshot) when reading INSPIRATION/
- `glossary-translation.md` — translate any technical term on first-use (GLB/FBX/state-machine/etc.)
- `concierge-setup-flow.md` — Step 8 (handoff to onboarding) opens with the structure-announcement above
- `body-anchored-calibration.md` — applied per-phase when project involves tracker-driven content
- `phase-progression.md` — Readiness Report → Phase 0 transition; per-phase clarification templates referenced above
