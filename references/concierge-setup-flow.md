# Concierge setup flow

The play-by-play conversation script CC follows after concierge mode activates. This file is CC's internal playbook — never quote filenames or this content directly to Anna.

## Contents
- Activation prerequisites
- The setup sequence (Steps 1-8)
- Pacing rules
- Resume-from-partial flow
- Decline patterns ("I'll do it myself")

## Activation prerequisites

Before starting the setup sequence, ensure ALL of these hold:

1. **Trigger matched**: domain keyword + action intent (see `SKILL.md` — concierge entry-point triggers)
2. **Platform confirmation received**: CC asked "I'll help you build a Snapchat Lens Studio project. Is that what you're working on?" and Anna said yes
3. **Environment detection complete**: readiness report surfaced to Anna (see `environment-detection.md`)
4. **Anna agreed to start**: she answered "yes"/"redo"/"go" to the readiness report's closing question

If any prerequisite missing, do not start step 1 — handle the missing piece first.

## The setup sequence

Eight steps. One step per CC message. Wait for explicit confirmation before advancing. Never bundle.

### Step 1: Confirm or install Lens Studio

**If LS already installed** (detection 1 = YES): skip to step 2.

**If LS missing**:

> CC: "Steg 1: Ladda ner Lens Studio 5.20+ från https://ar.snap.com/download. Det tar 5-10 minuter att installera. Säg 'klar' när det är gjort."

Wait for: "klar" / "done" / "installed" / "ja".

If Anna reports problem: use `troubleshooting-decision-tree.md` — section "LS won't open".

### Step 2: Open LS and confirm

> CC: "Bra. Öppna Lens Studio nu. Du ser en welcome-skärm. Klicka 'New Project' så får du en tom scen. Säg 'öppnad' när du ser den."

Wait for: "öppnad" / "open" / "ready".

Don't ask Anna to do project-save yet — that comes after we know the project folder name.

### Step 3: Capture client name, create project folder

Ask one question:

> CC: "Vad heter klienten eller projektet? T.ex. 'spotify', 'olw', 'voi'. Jag använder det för att skapa en projektmapp."

Wait for Anna's answer (e.g., "Spotify").

Then create the folder structure:

```bash
mkdir -p ~/Projects/[name-slug]-lens/{project-info,INSPIRATION/{visual-style,motion-references,color-palette-refs,ui-references},brand-assets,lens,docs}
cd ~/Projects/[name-slug]-lens
```

Slug: lowercase, kebab-case (`spotify` → `spotify`, `H&M Sverige` → `hm-sverige`).

Surface the result:

> CC: "Skapade `~/Projects/spotify-lens/` med sub-foldrar för project-info, INSPIRATION, brand-assets, lens, docs. Nu sparar vi LS-projektet där:
>
> I LS: File → Save As → navigera till `~/Projects/spotify-lens/lens/` → spara projektet som t.ex. `SpotifyLens.esproj`. Säg 'sparat' när du är klar."

Wait for: "sparat" / "saved".

### Step 4: Register MCP

Two-part instruction (one message, but two clear paste actions):

> CC: "Steg 4 — vi kopplar LS till mig så jag kan göra ändringar direkt i scenen.
>
> I LS-menyn: **AI Assistant → AI Model Context Protocol (MCP) → Configure Server**. Du ser en URL (något i stil med http://localhost:50040/mcp) och en Bearer-token (lång slumpmässig sträng).
>
> Klistra in **både URL och token** här i chatten."

Wait for Anna to paste. Parse the URL and token from her message.

CC runs:

```bash
claude mcp add --transport http --scope local lens-studio [URL] --header "Authorization: Bearer [TOKEN]"
claude mcp list
```

If `✓ Connected`: continue. If `✗ Failed`: use `troubleshooting-decision-tree.md` — section "MCP not connecting".

> CC: "✅ MCP connected. LS pratar med mig nu."

### Step 5: Create PROJECT-STATE.md

Single CC action, no Anna involvement except confirmation. Copy template:

```bash
cp ~/.claude/skills/lens-studio-snapchat-filter/assets/project-template/PROJECT-STATE.md ./PROJECT-STATE.md
cp ~/.claude/skills/lens-studio-snapchat-filter/assets/project-template/.gitignore ./.gitignore
```

> CC: "Setup klar. Jag skapade `PROJECT-STATE.md` som vi fyller i tillsammans medan vi går igenom briefen. Och en `.gitignore` så vi inte committar LS:s cache."

No wait — proceed directly to step 6.

### Step 6: Capture client brief

One question:

> CC: "Berätta i ett par meningar vad lensen ska vara. T.ex.: 'Spotify pod-kampanj. Användaren håller upp telefonen, får poddtips baserat på vilken humör de visar.' Vad är din motsvarighet?"

Wait for Anna's brief. Save to `project-info/client-brief.md`.

**Silent tier detection.** After receiving the brief, CC silently analyzes it against the capability-tier framework (see `references/capability-tiers.md`). The tier check is invisible to Anna — never mention "tiers" or present them as a menu.

- **Tier 1 or Tier 2 detected** → proceed to Step 7 as normal. No mention of tiers.
- **Tier 3 detected** (custom GAN, Snap-internal ML, realistic face/skin/hair replacement, GAN-based age/gender swap, "Snapchat Beauty filter" equivalent) → CC responds honestly using the language template:

  > CC: "Det filtret du beskriver går faktiskt inte att producera med standard Lens Studio — inte för oss, inte för någon vanlig byrå.
  >
  > [Explain WHY in plain language — no jargon. 1-2 sentences. Example: 'Avatar Na'vi-filtret krävde specialiserade AI-verktyg som Snap byggde internt tillsammans med Disney, med tillgång till film-data som inte finns utanför Snap.']
  >
  > Vad vi däremot kan bygga är:
  >
  > [Concrete Tier 1 version that captures campaign spirit — e.g., 'Blå face-tint + gula ögon-texturer + Na'vi-skin overlay + Avatar-logo lockup. 1-2 dagars bygge.']
  >
  > Vill du att vi går vidare med det?"

  Key rules: never say "with more budget", never say "we could try", always propose a concrete Tier 1 alternative immediately, use plain language. Full language templates + detection signals + scope-down patterns in `references/capability-tiers.md`.

  If Anna accepts the Tier 1 alternative → save the SCOPED brief (not the original) to `project-info/client-brief.md` and continue to Step 7.

  If Anna declines / wants to negotiate budget / claims "another agency could do it" → use the troubleshooting decision tree (see `references/troubleshooting-decision-tree.md` for the "client pushes back on Tier 3 refusal" pattern).

### Step 7: Inspiration folder coaching

This is the **non-expert coaching moment** — don't jargon her into the sub-folder taxonomy, and don't assume she knows what "inspiration" means in this context. Spell it out + show the value-exchange.

> CC: "Nu behöver jag inspiration-bilder. Med 'inspiration' menar jag inte mockups eller färdiga designer av lensen — det är referenser som visar mig *känslan* du vill att lensen ska ha. Sånt som:
>
> - **Screenshots** från andra AR-filter du gillar (Snap, TikTok, Insta — vad som helst)
> - **Foton** som fångar stämningen — Pinterest-bilder, kampanjbilder, Instagram-fynd, streetstyle, produktfoton
> - **Färgreferenser** — paletter, gradients, en bild med 'rätt' färgkänsla
> - **Rörelseklipp** — om du har sett en animation/transition du gillar, droppa screenshot eller länk
> - **Logos / brand-element** från klienten (om sådana finns)
>
> Vad det INTE behöver vara: mockups, wireframes, eller färdiga lens-designer. Råmaterial räcker.
>
> **Value-exchange — vad jag gör med dem:**
> - **3 bilder**: jag drar en grov tonalitet (mörkt/ljust, varmt/kallt, lugnt/energiskt) och föreslår en startpalett — du får godkänna eller justera senare.
> - **6-8 bilder**: jag kan dra slutsatser om motion-feel (mjukt vs snabbt), kompositionstyp (centrerat vs dramatiskt), och typografi-känsla — färre frågor till dig senare.
> - **10+ bilder**: jag har mycket mer underlag att korsreferera; risken för 'fel tonalitet'-överraskningar i Phase 1 blir nästan noll. Lönsamt om du har materialet redan.
>
> **3-5 bilder räcker för att börja**. Drop dem i `~/Projects/spotify-lens/INSPIRATION/` (samma folder vi precis skapade — undermapparna är frivilliga, släng dem i huvudmappen om du inte vill sortera). Säg 'klar' när du har minst 3 där."

Wait for: "klar".

Then validate:

```bash
ls ~/Projects/spotify-lens/INSPIRATION/visual-style/ ~/Projects/spotify-lens/INSPIRATION/ 2>/dev/null
```

If fewer than 3 images: ask for more. If 3+: continue.

(Skip the sub-folder taxonomy unless Anna asks. CC can sort images into sub-folders later if helpful, but don't burden her with it upfront.)

### Step 8: Handoff to onboarding intake

Move from concierge mode to onboarding-protocol.md. **v0.7.0 update — REVERSAL of prior rule:** the 8/3 structure is now ANNOUNCED to Anna. See `onboarding-protocol.md` "Onboarding philosophy (v0.7.0)" for the why-reversal (designers want a map; hiding the structure broke trust in user-testing).

Open with the structure-announcement, then immediately go into Q1.1:

> CC: "Bra — nu går vi från setup till själva briefen. Jag ställer ungefär **8 frågor i tre block** — vision, ramar, assets — det tar 5-10 min. Ju skarpare du svarar, desto mer kan jag dra slutsatser själv senare istället för att fråga dig om småsaker. Du kan alltid säga 'hoppa över' eller 'jag vet inte än'.
>
> **Block 1 av 3 — Vision.**  
> Fråga 1: Beskriv lensen i 1-2 meningar — vad ska hända för användaren?"

Deliberate elements (full breakdown in `onboarding-protocol.md` § "The opening"):
- "8 frågor i tre block" — roadmap. Anna now has a map.
- "5-10 min" — honest time-commitment.
- "Ju skarpare du svarar..." — value-exchange (`voice-and-pedagogy.md` #7).
- "Du kan alltid säga 'hoppa över'" — agency (#6).
- "Block 1 av 3 — Vision" — first progress signal. Sets pattern for remaining blocks.
- Immediate first question — no further preamble. Headline first.

This transitions CC from concierge mode into the announced 8-question intake. Full intake protocol (block-progress between Qs, value-exchange per Q, plain-language Readiness Report) lives in `onboarding-protocol.md`.

After intake completes and Readiness Report is approved, CC enters Phase 0.

## Pacing rules

- One user action per CC message
- Wait for explicit confirmation signal (typed value, "done", "saved", "klar", file paste, etc.)
- Never say "do steps 1-3 then say done" — always serialize
- Acknowledge each completion briefly ("✅ klart" or similar) before moving to next step
- If Anna seems lost: pause, ask "var fastnar du?", troubleshoot 1-2 fixes, escalate if needed

## Resume-from-partial flow

If Anna abandons setup mid-flow and comes back later (new session, same project):

1. Re-run environment detection
2. Compare with expected post-step state — which steps are done?
3. Surface to Anna: "Vi var mitt i setup. ✅ LS installerat, ✅ projekt-folder skapat, ❌ MCP inte konfigurerat än. Fortsätter vi från MCP?"
4. Wait for "ja"/"fortsätt"
5. Resume at the first incomplete step

If `PROJECT-STATE.md` exists: read it to confirm the resume point. If `PROJECT-STATE.md` shows phase is past setup (Phase 1+), skip concierge entirely.

## Decline patterns — "I'll do it myself"

If Anna explicitly opts out of guidance:

- "Just give me the install steps"
- "Är det ingen manual jag kan läsa?"
- "Show me everything upfront, I'll figure it out"

Respond:

> CC: "Klart. Komplett self-service-guide: `docs/INSTALL-REFERENCE.md` (i skill-foldern). Den täcker LS-installation, MCP-registrering, projekt-folder-struktur, och INSPIRATION-coaching.
>
> Om du fastnar nånstans, kom tillbaka hit och säg 'hjälp på steg X' så hoppar jag in interaktivt."

Do NOT continue the stepped sequence after a decline. Anna chose self-service; respect it.

If she returns later mid-task ("MCP-tokenen funkar inte"), enter troubleshooting decision tree directly — don't restart concierge from step 1.
