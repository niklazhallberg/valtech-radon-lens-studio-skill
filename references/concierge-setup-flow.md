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

### Step 7: Inspiration folder coaching

This is the **non-expert coaching moment** — don't jargon her into the sub-folder taxonomy.

> CC: "Jag behöver inspiration-bilder för att förstå hur lensen ska kännas. **3-5 bilder räcker att börja med**. De kan vara:
> - Screenshots från andra appar / filter du gillar
> - Foton som fångar stämningen (färger, känsla)
> - Logos / branding-element från klienten
>
> Drop dem i `~/Projects/spotify-lens/INSPIRATION/` (samma folder vi precis skapade). Säg 'klar' när du har minst 3 där."

Wait for: "klar".

Then validate:

```bash
ls ~/Projects/spotify-lens/INSPIRATION/visual-style/ ~/Projects/spotify-lens/INSPIRATION/ 2>/dev/null
```

If fewer than 3 images: ask for more. If 3+: continue.

(Skip the sub-folder taxonomy unless Anna asks. CC can sort images into sub-folders later if helpful, but don't burden her with it upfront.)

### Step 8: Handoff to onboarding intake

Now move from concierge mode to onboarding-protocol.md:

> CC: "Bra — vi har allt vi behöver för att börja. Nu går vi igenom briefen mer noggrant. **8 frågor i 3 grupper, ~7 minuter.** Sen draftar jag specs och vi börjar bygga.
>
> Grupp 1 är 'Vision'. Första frågan:
> **Beskriv lensen i 1-2 meningar — vad gör den, vad är 'momentet'?**"

This transitions CC from concierge mode into the standard 8-question intake. See `onboarding-protocol.md` for the full intake protocol.

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
