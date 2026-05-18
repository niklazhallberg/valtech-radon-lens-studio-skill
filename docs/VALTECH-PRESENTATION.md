# `lens-studio-snapchat-filter` — översikt v1.0

> 📌 Detta är en snapshot från v0.7.1 (2026-05-14). Skillen är nu på **v0.10.0**. Se [CHANGELOG.md](../CHANGELOG.md) för aktuellt läge.

Skillens version vid skrivande stund: **v0.7.1**
Underhålls inom Valtech RADON.

Detta dokument är en självständig översikt över skillen — vad den är, hur den används, hur den växer, hur den hanterar säkerhet och vilket affärsvärde den representerar. Tänkt att läsas av en designer, teamlead, teknikchef eller beslutsfattare — alla får relevant information.

---

## 1. Vad är detta — Executive Summary

`lens-studio-snapchat-filter` är en AI-assisterad arbetsmetod som låter en designer på Valtech Radon — utan tidigare Snapchat-erfarenhet — bygga ett produktionsklart Sponsored Lens-filter åt en kund på dagar istället för veckor.

Tekniskt: en "skill" som plug:ar in i Claude Code (Anthropics utvecklarverktyg) och förvandlar AI:n från en generell assistent till en **specialiserad mentor** för Snapchat Lens Studio. Skillen kan vår process, vår kvalitetsnivå, och fångar löpande in kunskap från riktiga projekt.

**Affärsvärdet i en mening:** Vi går från "kunskapen sitter hos enskilda personer" till "kunskapen är en produkt som växer med varje projekt".

---

## 2. Alla kunskapslager

Skillen är byggd i **7 lager**. Varje lager existerar för att lösa ett specifikt problem som annars kostar tid eller orsakar fel.

### a) Officiell Snap-dokumentation (365 sidor)
**Vad:** Hela `developers.snap.com/lens-studio/` curaterat och organiserat lokalt i 9 buckets (MCP, scripting, assets, scene, AR-tracking, try-on, publishing, performance, overview).
**Vad det kostar att INTE ha det:** Designern googlar fragmenterat, fastnar på inaktuella StackOverflow-svar, blandar API-versioner från olika år.
**Värde:** ~2–4 timmar/projekt sparad sök-tid. AI:n citerar rätt källa istället för att hallucinera.

### b) Empirisk kunskap från verkliga projekt
**Vad:** `lens-studio-api-gotchas.md` (~21 entries) + `body-anchored-calibration.md` — saker som **inte** finns i Snaps officiella docs. T.ex. att Try-On Pack Sneakers har mesh-pivot 6–12 units off-center, eller att MCP-token roterar vid varje LS-restart.
**Vad det kostar att INTE ha det:** Varje designer hittar samma fallgrop på nytt. På pilotprojektet kostade en specifik gotcha ~3 timmar att hitta.
**Värde:** Det här lagret är skillens **moat** — det är inte googlebart.

### c) MCP capability map (20 tools)
**Vad:** Komplett schema för alla 20 verktyg som Claude Code kan anropa i Lens Studio (scene-mutationer, asset-hantering, screenshots, GraphQL-queries).
**Vad det kostar att INTE ha det:** AI:n provar fel verktyg, får cryptiska fel, ger upp.
**Värde:** Sparar minuter per tool-anrop × hundratals anrop per projekt.

### d) Voice + pedagogik — "mentor mode" (v0.7.0)
**Vad:** 3 lager (Voice/Pace/Pedagogy) × 8 principer som styr **hur AI:n pratar**. Översätt jargong vid första användning, fira magic moments, var ärlig om osäkerhet, ge agency till designern.
**Vad det kostar att INTE ha det:** Designern känner sig dum, drar sig ur halvvägs, ger upp på AI:n.
**Värde:** Det här är skillens **affärslogik**. Tekniken är medel — mentorrollen är produkten.

### e) Onboarding-system
**Vad:** Concierge mode (8 steg setup) + onboarding intake (8 frågor i 3 grupper, ~7 minuter) + Readiness Report.
**Vad det kostar att INTE ha det:** Designern kastas in i Lens Studio, vet inte var de börjar, frågar någon kollega om hjälp.
**Värde:** En kollega kan starta ensam. Ingen enskild person blir flaskhals.

### f) Self-growth protocol
**Vad:** `skill-growth-protocol.md` v0.4 — protokoll för hur **nya lärdomar fångas i flowet** under riktiga projekt och flödar in i skillen.
**Vad det kostar att INTE ha det:** Skillen stagnerar efter dag 1. Kunskap från projekt 2, 3, 4 hamnar i folks huvuden eller Slack-trådar och försvinner.
**Värde:** Compound interest. Se sektion 4.

### g) CHANGELOG + discovery history
**Vad:** Skillens biografi. Varje release + varje discovery loggad med datum, källa, motivering.
**Vad det kostar att INTE ha det:** Ingen synlighet i hur skillen växer. Ingen ROI-spårbarhet. Nya kollegor förstår inte varför reglerna ser ut som de gör.
**Värde:** Spårbarhet. Auditerbarhet. Story-telling till nästa kund.

---

## 3. Användarvänlighet — hur fungerar det i praktiken

### Dag 1 — designer Anna, har aldrig byggt ett Snap-filter

1. **00:00** — Anna öppnar `MANUAL.html` i webbläsaren. 4 steg på svenska. Klistrar in en setup-prompt i terminalen.
2. **00:05** — Claude Code aktiverar skillen automatiskt när Anna nämner "Snapchat-filter åt [kund]". Bekräftar platform.
3. **00:10** — Concierge mode kör miljödetektering. Säger "✅ LS installerat, ❌ MCP ej registrerat — vill du att jag fixar det?". Ett steg i taget.
4. **00:30** — Setup klar. Onboarding intake börjar: 8 frågor om vision, känsla, tempo, målgrupp. Anna får löpande "vad du får tillbaka för svaret"-feedback.
5. **00:45** — Readiness Report genererad. Phase 0 (spec-drafts) börjar. AI:n drar TECH-SPEC och USER-EXPERIENCE från briefen + inspirationsbilderna.
6. **Dag 1 slut** — Anna har Phase 1 scaffolding live i Lens Studio. Något syns. Magic moment firat.

### Under projektet — hur skillen guidar

- **9 faser med tydliga DoD** (definition of done). Ingen "vad ska jag göra nu?"-känsla.
- **Watch points per fas** — 3–5 explicita pauser där Anna får godkänna.
- **Probe-first discipline** — AI:n provar EN sak, läser tillbaka resultatet, bekräftar att det funkade, innan den applicerar i bulk.
- **Inspector handoff** — När det handlar om "feel" (animationskurvor, färg, position-tuning) skickar AI:n över rodret till Anna i LS Inspector. AI:n vet sin gräns.

### Vid problem

- **Troubleshooting decision tree** — clarify → fix → escalate.
- **Silent-drop recovery** — när MCP säger "success: true" men ingenting hände, finns det ett protokoll för det.
- **Mentor-mode under setbacks** — AI:n säger "jag tror" istället för att fejka säkerhet. Inga gas-lit moments.

### BEFORE / AFTER

| | UTAN skillen | MED skillen |
|---|---|---|
| Setup-tid (designer utan Snap-erfarenhet) | 1–2 dagar googling + kollege-frågor | **30 min concierge** |
| Första filter live i Preview | 3–5 dagar trial-and-error | **~Dag 1 eftermiddag** |
| Antal blockerande frågor till senior kollega | 10–20 per projekt | **1–3** |
| Risk för dolda gotchas i submission | Hög (Snap rejection vanlig) | Lägre — gotchas-fil fångar de kända |

---

## 4. Hur skillen blir smartare över tid

### När en designer löser något nytt

1. AI:n märker att en lösning inte finns i `references/`. Grep:ar för att bevisa det.
2. Den säger **mitt i flowet** till designern: "Vi har en discovery: X. Den regeln finns inte i skillen. Ska vi skriva in den?"
3. Designern säger ja / nej / spara för senare.
4. Vid ja: **Generaliseringsregeln** kör (se sektion 5b nedan) — den projektspecifika lösningen skrivs om till en universell regel.
5. Diff visas. Designern godkänner. Commit + CHANGELOG-entry. **~2 minuter**.

### Hur kunskapen når nästa kollega

Nästa designer som gör `git pull` får automatiskt alla nya regler. AI:n läser dem som kontext nästa session. **Ingen utbildning, ingen Slack-tråd, ingen wiki att underhålla parallellt.**

### Vad det kräver av designern

Två minuter av godkännande mitt i ett projekt. Inget batch-arbete vid sessionsslut. Inget separat dokumentationsmoment.

### Generaliseringsregeln — varför kritisk

Utan den landar discoveries som **anekdoter** ("för det här projektet behövde vi X=-80"). Med den landar de som **regler** ("Try-On Pack-pivoten är typiskt off-center, så här detekterar och löser du det").

Det är skillnaden mellan en logg och en lärobok.

### CHANGELOG.md om 12 månader

Om Valtech kör 10–20 lens-projekt per år och varje projekt bidrar 2–5 discoveries, har vi om ett år en CHANGELOG med **40–100 entries**. Varje entry är en regel som någon kollega lärde sig på riktig produktionstid. Det är compound interest på investerad tid.

**Ärligt:** Idag är endast **ett** projekt faktiskt seedat in. Mekaniken är bevisad — volymen är inte. Det är det nästkommande projekt får visa.

---

## 5. Säkerhet och sekretess

### 5a. Vad lagras i skill-filen?

**Finns i repot:**

| Typ | Innehåll | Risknivå |
|---|---|---|
| Snaps publika dokumentation | 365 markdown-sidor mirrored från `developers.snap.com` | Noll — redan publikt |
| Empiriska protokoll | `body-anchored-calibration.md`, `lens-studio-api-gotchas.md` etc. — generaliserade mönster, **inga projektspecifika värden** | Noll — Generaliseringsregeln säkrar detta (se 5b) |
| MCP tool schemas | Tekniska API-signaturer för Lens Studio MCP-server | Noll — teknisk info, ej känslig |
| Voice-principer | Pedagogiska riktlinjer på svenska | Noll — metodologi, inte data |

**Finns INTE i repot — bekräftat genom genomgång:**

- ❌ Inga klientnamn i empiriska protokoll
- ❌ Inga projektspecifika värden (X-koordinater, kampanjbudgetar, leveransdatum)
- ❌ Inga personuppgifter
- ❌ Ingen Valtech-intern affärsinformation
- ❌ Inga API-nycklar, tokens, credentials

### 5b. Generaliseringsregeln som aktiv säkerhetsmekanism

`skill-growth-protocol.md` har en **trestegs-checklist som körs INNAN något committas**:

**Steg 1 — Identifiera kärnan.** Vad är den generella regeln bakom det specifika fyndet?

**Steg 2 — Explicit borttagnings-checklist:**
```
❌ Ta bort: klientnamn
❌ Ta bort: exakta projektmått som bara gäller detta case
❌ Ta bort: interna projektnamn och filsökvägar
❌ Ta bort: datum och deadlines
```

**Steg 3 — "Nästa kollega"-test (gate):**
> "Om en kollega på Valtech nästa månad bygger ett ANNAT try-on-filter för ett ANNAT varumärke — kan de läsa detta utan att veta vilket projekt det kom från?"

**Två lager av godkännande:**
1. AI:n som gate-keeper kör checklistan
2. **Människa godkänner varje commit explicit** — inget auto-push, inget auto-commit

Protokollet kan granskas i `references/skill-growth-protocol.md` rad 18–82.

### 5c. Repo-säkerhet

| Aspekt | Status idag |
|---|---|
| Repo-typ | **Privat GitHub-repo** |
| Access idag | Begränsad — på personligt GitHub-konto hos underhållaren |
| Plan | Migrera till Valtech-organisationskonto |
| Framtid | `@valtech.com` SSO-autentisering |
| Auto-push | **Avstängt** — varje push kräver explicit godkännande |

Migration till Valtech-org är **steg 1 i nästa steg-listan** (sektion 7).

### 5d. Vad händer med kunddata under ett projekt?

Det här är viktigt att förstå rent strukturellt:

1. **Skillen körs LOKALT** på designerns dator. Inget skickas till GitHub utan explicit godkännande.
2. **Lens Studio-projektet** (med kundens 3D-modeller, briefer, kampanjmaterial) finns i en HELT SEPARAT mapp, t.ex. `~/Projects/<klient>-lens/`. **Denna mapp pushas ALDRIG till skill-repot.**
3. **Discovery-protokollet** filtrerar bort allt projektspecifikt INNAN något ens föreslås för commit (Steg 2-checklistan).
4. Det enda som flödar från projekt till skill är **det generaliserade mönstret** — inte data.

Konkret exempel ur `skill-growth-protocol.md`:

```
BEFORE (skulle INTE committas):
"För <klient>-lensen behövde vi sätta
shoe_mesh_l position till X=-80, Y=-40, Z=-20..."

AFTER (committas):
"Try-On Pack Sneakers: mesh-pivot är off-center
relativt foot-anchor. Kompensera med wrapper-
anchor arkitektur..."
```

### 5e. Jämförelse med alternativet

Risken om Valtech **inte** har ett system som detta:

| Risk utan skill | Konsekvens |
|---|---|
| Designers googlar fritt | Okontrollerade källor, okontrollerade kodsnuttar in i kundprojekt |
| Kunskap stannar hos individen | Om personen är otillgänglig → tyst dataförlust |
| Slack-trådar som "wiki" | Sökbar bara av interna, inget audit-trail, inget format-skydd |
| Inget audit-trail på lärdomar | Ingen synlighet i vad agenten lär sig från projekt till projekt |

**Skillen är inte en ny säkerhetsrisk — den är en strukturerad lösning på en risk som redan existerar.**

---

## 6. Affärsvärde — konkret ROI

### Tid sparad per projekt

| Moment | UTAN skill | MED skill | Sparat |
|---|---|---|---|
| Designer-onboarding (Snap-specifikt) | 1–2 dagar | 30 min concierge | **~12 h** |
| Setup (LS, MCP, project struktur) | 4–6 h trial-and-error | 30 min | **~5 h** |
| Troubleshooting kända gotchas | 2–4 h × N gotchas | <30 min | **~3–6 h** |
| Kalibrering (foot-tracking, face, hand) | 1–2 dagar med tracker-överraskningar | 4–6 h med protokoll | **~8–12 h** |
| **Totalt per lens-projekt** | ~5–7 dagar setup/troubleshoot | ~1–2 dagar | **~3–5 arbetsdagar** |

Vid Valtech-rate ~10–12k SEK/dag = **30–60 kSEK sparat per projekt**.

### Kunskapsbevaring

Idag bor stora delar av kunskapen i enskilda personers huvuden. Om en ansvarig kollega är sjuk, på semester eller upptagen i annat projekt under leverans — är kunskapen otillgänglig.

Med skillen: kunskapen är **kod**. Den finns i git, den följer med kollegor, den finns kvar.

**Bus factor: går från 1 till N.**

### Skalbarhet

Idag är Snap-projekt beroende av en eller två seniorer.

Med skillen + 2–3 utbildade designers: **3–5 parallella lens-projekt** möjliga.

### Competitive advantage

Inget motsvarande har observerats från andra svenska byråer. Det här är inte en hemlighet att gömma — det är en **kapacitet att paketera**.

Pitch-värde mot kunder: "Vi har en intern AI-mentor som garanterar kvalitet och konsistens på alla våra Snap-leveranser, oavsett vilken designer som bygger."

### Ärlighetsdisclaimer

- **v0.7.1** är 2 dagar gammal. Seedet är **ETT** verkligt projekt (ett Sponsored Lens-projekt).
- Volymvärdet ovan är **extrapolerat**, inte bevisat över portfölj.
- Det vi vet: pipelinen funkade för pilotprojektet i realtid. Mentor-läget upplevdes av designern som starkt nog att fortsätta investera.
- Det vi inte vet ännu: hur kraftigt compound interest blir när 5–10 projekt har kört igenom. Det är vad nästa 6 månader bevisar.

---

## 7. Rekommenderade nästa steg

### Nu (denna vecka)

1. **Säkerhetsgranskning** — låt relevant funktion läsa `skill-growth-protocol.md` + detta dokument. Konfirma att Generaliseringsregeln + manuella commit-godkännanden möter Valtechs policy.
2. **Migrera repo till Valtech-organisationskonto** på GitHub. Två klick. Eliminerar "personligt konto"-frågetecknet.
3. **Sätt upp 30-min demo** för 2–3 utvalda designers + 1 stakeholder. Live walk-through av onboarding-flödet.

### Snart (denna månad)

4. **Pilotprojekt nr 2** — välj ett kommande Snap-lens-uppdrag och kör det med skillen från dag 1, med en designer som inte var med på första pilotprojektet. Verkligt empiriskt test av onboarding.
5. **CONTRIBUTING.md** för kollegor — guide för hur man bidrar discoveries.
6. **`@valtech.com` SSO** för repo-access via GitHub Enterprise eller motsvarande.
7. **Slack-kanal** (`#lens-studio-skill` eller liknande) för skill-updates, discoveries och frågor.

### Framöver (detta kvartal)

8. **Mät ROI på riktigt** efter 3–4 körda projekt. Jämför verklig tid mot estimaten i sektion 6.
9. **Utforska generalisering** — kan samma skill-arkitektur lyfta över till TikTok Effect House? Meta Spark? Frågan är öppen, men growth-protokollet skulle vara identiskt.
10. **Story-paketering mot kunder** — om mätningen i steg 8 håller, paketera som sales-narrative för Sponsored Lens-erbjudanden.

---

## Slutord

Det som finns idag är en **fungerande v0.7.1** seeded från ett verkligt projekt, med en mekanik för att växa under varje framtida projekt. Det är inte färdigt — det är **levande**.

Det starka: voice-mandatet är **kod**, inte kultur som dör med personalomsättning. Generaliseringsregeln gör skill-tillväxt **säker by default**, inte som en eftertanke.

Det ärliga: empirin är tunn. Mekaniken är bevisad, volymen är inte. Nästa 3–6 månader bevisar (eller motbevisar) hypotesen.
