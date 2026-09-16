# Lens Studio Snapchat Filter — Användarhandbok

> Read in English: [`MANUAL-EN.md`](MANUAL-EN.md)

Den här guiden är för dig som funderar på att använda skill:en `lens-studio-snapchat-filter` för ett kundprojekt. Läs den **innan** du installerar något — den ska hjälpa dig avgöra om verktyget passar din uppgift och vad du faktiskt får ut av det.

---

## 1. Vad är detta?

`lens-studio-snapchat-filter` är ett **skill** för Claude Code (Anthropics terminalverktyg för utvecklare). Skill:en lär Claude hela arbetsflödet för att bygga Snapchat-lenser — från första brief till submission i Snap Ads Manager. När du har installerat den och startar Claude i din projektmapp, vet Claude:

- Vad ett Snapchat-lensprojekt typiskt innehåller och hur det ska struktureras
- Vilka API-mönster som faktiskt fungerar i Lens Studio (och vilka som misslyckas tyst)
- Hur du som designer arbetar fram en lens från grund-vision till färdig submission
- När den ska fråga dig om beslut, och när den ska bara köra på

**Vad skill:en ersätter**: manuell Lens Studio-handpåläggning genom hela pipelinen. Istället för att klicka, dra och Inspector-greja varje detalj själv, beskriver du vision och feel — Claude bygger scen, scripts, animationer och tekniska specifikationer åt dig. Du tar besluten; Claude tar friktion.

**Vem är det för**: dig som är digital designer, creative technologist eller account manager på Valtech RADON. Du har designkompetens men kanske inte kodvana. Du behöver inte kunna terminal, JavaScript eller GraphQL för att använda skill:en — men du behöver en grundförståelse för Snapchat-lenser som format (vad de gör, hur folk använder dem, vad Snap accepterar i ad-review).

---

## 2. Vad kan du bygga?

Skill:en är ärlig om vad som går och vad som inte går. Vi delar in i tre tier:

### Tier 1 — Claude bygger helt själv

Ingen extern asset krävs utöver kundens logo och brand-typsnitt. Claude hanterar scen, kod, animationer, submission. Bygg-tid: **3–5 dagar** beroende på iterationsmängd.

Exempel:
- 2D-overlays på ansikte (färgton, ögontextur, läpp-effekt)
- Tap-interaktioner med text- eller bildavslöjanden
- Fortune / quiz / horoskop-lenser
- Text-baserade lenser med custom-typsnitt
- Enkla partikel-effekter (regn, glitter, hjärtan)
- Basic face tracking med bildoverlays
- Klickbara knappar (med skill:ens `Button` v1.0.1 primitive)
- Blur-effekter (frostat glas, oskärpa)
- Ljud-uppspelning vid tap

**Konkret exempel — en tidigare sponsrad Lens-produktion**: byggdes med skill:en på cirka 5 dagar. En "tappa-för-att-öppna-en-förpackning"-lens där användaren tappar på en brandad förpackning som öppnas, och en slumpmässig kort text avslöjas med en decelererande callback-rytm (känns som ett ödeshjul som landar på ett svar). Tier 1 från första till sista dag. Ingen 3D-artist, inga ML-modeller, ingen Snap-intern teknik.

### Tier 2 — Claude bygger om du levererar asset:en

Claude hanterar all kod och scen-uppbyggnad. Du (eller en specialist) levererar en specifik tillgång.

Exempel:
- 3D-objekt på ansikte → kräver FBX eller glTF från en 3D-artist
- ML-effekt baserad på kundens egen tränade modell → kräver `.dnn`-fil från kunden
- Licensierad karaktär som PNG-overlay → kunden levererar bilden

Bygg-tid: **1–2 veckor**, men hänger på asset-leverans, inte på Claude.

### Tier 3 — Inte möjligt med standard byråproduktion

Vissa lenser kräver Snap-intern teknik som ingen byrå utanför Snap har tillgång till. **Mer budget löser inte detta** — det är en strukturell gräns, inte en kostnadsfråga.

Exempel:
- Full ansiktstransformation (typ Avatar-Na'vi, Snap × Disney 2022) — krävde custom GAN och månader av Snap-internt arbete med Disneys film-data
- Snapchat Beauty filters (Snap-proprietärt, inte exponerat i LS SDK)
- Realtidsbaserad hår-segmentering + ersättning (Snap-intern ML)
- GAN-baserad ålders- eller könstransformation

Om ett kundbrief innehåller en Tier 3-referens svarar Claude ärligt: *"Det filtret du beskriver går faktiskt inte att producera med standard Lens Studio — inte för oss, inte för någon vanlig byrå. [Referensen] krävde specialiserade AI-verktyg som Snap byggde internt. Vad vi kan bygga istället är: [Tier 1-förslag]. Vill du att vi går vidare med det?"*

Tier 3-detektering är skill:ens viktigaste tjänst i den första kund-konversationen. Den skyddar dig från att lova något som inte kan levereras.

---

## 3. Vad ger det för värde?

### Tidsbesparing

Erfarenheten från seed-projektet är konkret: en lens som med manuellt Lens Studio-arbete tagit 2–3 veckor att bygga, blev klar på 5 dagar med skill:en. Tidsvinsten kommer från:

- **Scen-hierarki sätts upp en gång**, inte itererat fram via trial-and-error.
- **Scripts genereras från specifikation**, inte handskrivna med syntax-jakt.
- **Inspector-wiring drivs av Claude**, du justerar bara magnituder i Phase 3-polering.
- **Submission-checklistor är förvalidade** mot Snap Ads Manager-flödet.

### Ansvarsfördelning — vad Claude tar, vad du behåller

Du tar **vision, godkännande och feel-beslut**. Claude tar **exekvering, struktur och teknisk korrekthet**. Konkret:

| Du gör | Claude gör |
|---|---|
| Levererar brief, vision, INSPIRATION-mapp | Läser allt och utleder konkreta designbeslut |
| Tar beslut om feeling, pace, off-limits | Sätter defaults för tween-tider, easing, layouting |
| Godkänner specifikationer innan Phase 1 | Skriver TECH-SPEC.md och USER-EXPERIENCE.md |
| Säger "go" för att gå vidare en fas | Bygger scen, scripts, animationer per fas |
| Justerar feel i Phase 3 via Inspector | Förbereder Inspector-handoff med rätt SceneObject markerad |
| Testar lensen på din egen telefon | Förbereder allt inför device-test |
| Klickar Submit i Snap Ads Manager | Producerar icon (320×320), preview-video, metadata |

Det handlar om **arbetsdelning, inte automation**. Du är fortfarande creative director — Claude är teknisk + grafisk exekutor.

### Kvalitet — produktionstestat, inte trial-and-error

Skill:en är empiriskt validerad från riktiga produktionsbyggen. När den säger "använd den här tween-pattern" är det för att alternativen testats och misslyckats. När den varnar för en silent-drop-bugg i `setProperty`, är det för att teamet redan blött näsa på den buggen. Du får inte mer än ett års worth of LS-arbete kondenserat i agent-form.

---

## 4. Hur kommer du igång?

### Förutsättningar

- **macOS, Windows eller Linux** med ~10 GB ledigt diskutrymme
- **Claude Code** installerat (kör `curl -fsSL https://claude.ai/install.sh | bash` i terminalen)
- **Lens Studio 5.21+** installerat (https://ar.snap.com/download)
- **Admin-rättigheter** för att installera applikationer

### Installation i tre steg (översikt)

1. **Installera skill:en** i `~/.claude/skills/`. **Ingen publik klon-URL är tillgänglig ännu** — en skill-maintainer överlämnar en lokal kopia av plugin:et till dig. Placera den så att `~/.claude/skills/lens-studio-snapchat-filter/SKILL.md` existerar.
2. **Skapa en projektmapp** för ditt kundprojekt, t.ex. `~/Projects/[kund]-lens/`.
3. **Registrera Lens Studio MCP-server** med Claude Code så att Claude kan styra LS direkt.

> **De fullständiga, steg-för-steg-instruktionerna** finns i [`INSTALL-REFERENCE.md`](INSTALL-REFERENCE.md). Den dokumentet är gjort för att följas rakt av — bash-kommandon, verifieringssteg, fallback-lösningar. Använd den när du faktiskt installerar; manualen du läser nu är för att förstå vad du köper in dig på.

### Vad MCP är (kort förklaring)

MCP står för **Model Context Protocol**. Det är en teknik som låter Claude prata direkt med Lens Studio — läsa scen-grafen, lägga till objekt, ändra properties, köra TypeScript-kod i editor:n. Utan MCP får du fortfarande hjälp av Claude, men du måste själv klicka och dra i Lens Studio efter Claudes instruktioner. Med MCP gör Claude förändringarna åt dig direkt. **Token roterar varje gång du startar om Lens Studio** — det är en återkommande operativ detalj du behöver känna till (mer i sektion 8).

### Vad du säger till Claude för att starta

I terminalen, från din projektmapp:

```
claude
```

Sedan, första meddelandet till Claude:

> *"Jag vill bygga en Snapchat-lens för [kund]. Här är briefen: [klistra in 1–2 paragrafer]."*

Claude tar det därifrån — initierar concierge-läge, läser din miljö, ber dig om INSPIRATION-bilder och startar onboarding-intaget. Du behöver inte säga "använd skill:en" — Claude detekterar det själv från ämnesorden i ditt meddelande.

---

## 5. Hur pratar Claude med dig?

### Concierge-läge

När du startar Claude i en tom projektmapp och säger "jag vill bygga en lens", aktiveras **concierge-läge**. Det är ett strukturerat samtal som tar dig från noll till "redo att börja bygga". Concierge-läge är designat för att vara **lugnt och tydligt**, inte överväldigande:

- **En åtgärd per meddelande**. Claude ber dig göra en sak, väntar på "klar"/"done", går vidare. Inga listor av "gör A, B och C sen säg klar".
- **Klarspråk**, ingen jargong. "Lägg 3–5 bilder som fångar känslan" istället för "kuratera INSPIRATION/ med kategoriserade subfolders".
- **Adaptiv felsökning**. Om något krånglar säger du bara det, så switchar Claude till felsökningsläge tills det funkar.

### Miljödetektering (vad Claude kollar först)

Innan Claude börjar fråga dig saker kontrollerar den vad du redan har på plats:

- Är Claude Code installerat? (Du pratar med den, så ja.)
- Är Lens Studio installerat? Vilken version?
- Finns en projektmapp redan, eller behöver vi skapa en?
- Finns ett `.esproj`-projekt redan?
- Är MCP-servern registrerad och uppkopplad?

Du får en **readiness-rapport** (✅/❌ per item) innan något annat. Om något fattas, går Claude in i den 8-stegsguide som finns i `INSTALL-REFERENCE.md` (men live, med dig som följer med).

### Setup-samtalet — ett steg i taget

Setup-flödet är 8 steg. Du klarar varje steg, säger "done" eller "klar", och Claude går vidare. Typiska steg är att lägga in kundens brief som textfil, populera INSPIRATION-mappen, sätta upp git, registrera MCP. Total tid: ~25–30 min för en första uppsättning.

### Onboarding-intaget — 8 frågor i 3 grupper

När setup är klar går Claude in i **onboarding-intaget**: 8 frågor uppdelade i 3 logiska grupper. Hela samtalet tar ~7 minuter. Den 3-gruppsstrukturen är INTERNT för att Claude ska hålla pace; från ditt perspektiv är det bara ett naturligt samtal.

**Grupp 1 — Vision (3 frågor)**: handlar om vad lensen är och vad användaren upplever.
- *"Beskriv lensen i 1–2 meningar. Vad är ögonblicket för användaren?"*
- *"Primär känsla? Ett ord: playful / mysterious / energetic / calm / surreal / nostalgic / cinematic / chaotic?"*
- *"Pace: snappy / medium / slow-cinematic?"*

**Grupp 2 — Constraints (3 frågor)**: handlar om kund-, kategori- och deadline-villkor.
- *"Kund + ad-policy-kategori?"* (t.ex. en musikstreaming-brand i kategorin 'general', eller en sexuell hälsa-organisation i kategorin 'regulated')
- *"Något off-limits?"* (t.ex. "ingen face liquify", "endast selfie-kamera")
- *"Deadline?"* (driver hur många polish-iterationer som hinns med)

**Grupp 3 — Asset-validering (2 frågor)**: Claude läser INSPIRATION-mappen och föreslår vad den ser.
- *"INSPIRATION-mappen har 5 bilder. Jag ser mörka toner, neon-accenter, minimalistisk stil. Matchar din vision, eller läser jag fel signaler?"*
- *"Något i brand-assets/ jag bör veta? Logos, brand-färger, låsta typsnitt?"*

**Varför just denna struktur?** Frågorna är designade så att designers inte behöver känna till tekniska specifikationer. Du säger "cinematic" — Claude sätter tween-tider till 0.8–1.5s, soft easings. Du säger "snappy" — Claude sätter 0.2–0.4s, sharp easings. Du behöver inte säga "0.4 sekunder med cubic-easing". Beslut görs på rätt abstraktionsnivå.

### Readiness-rapporten

Efter onboarding-intaget visar Claude en **readiness-rapport** som en tabell — en rad per beslut, med en checkmarkering eller redigeringsmarkering bredvid. Du kan skanna och hitta EN fel rad på 10 sekunder utan att läsa prosa:

```markdown
| Beslut | Värde | |
|---|---|---|
| Vision | [din vision-mening] | ✔ |
| Feeling | calm | ✔ |
| Pace | slow-cinematic | ✔ |
| Färgpalett | #1e5d8c, #3a9ab8, #e89880 | ✔/✏️ |
| Tween-defaults | 0.8–1.2s, ease-in-out | ✔/✏️ |
...
```

Du svarar antingen med **"go phase 0"** (alla rader ser bra ut, börja bygga) eller **"ändra [rad]: [nytt värde]"** (en specifik rad behöver justeras). Claude uppdaterar och visar tabellen igen tills du säger "go".

### Feature intent detection — Claude tolkar din mening

Claude förstår att du beskriver vad du **vill ha**, inte vad API:t heter. Om du säger:

- "klickbar sak" → Claude tolkar det som `Button` v1.0.1
- "oskarp bakgrund" → `GaussianBlurPreset`
- "snurra och avslöja text" → decelererande callback-chain-pattern
- "spela ett ljud när man tappar" → `AudioComponent`

Innan Claude installerar eller skriver kod konfirmerar den:

> *"Jag tolkar det som att du vill ha en klickbar knapp. Jag kan lägga till `Button` v1.0.1 som primitive — du får då en knapp med animation (Bounce/Squish/Transform), customisable färger per state, och tap-event som triggar din handler. Stämmer det, eller menar du något annat?"*

Du säger "ja" eller beskriver om. Inget installeras innan du bekräftat.

---

## 6. Fas-för-fas: hur bygger Claude lensen?

Skill:en delar in bygget i nio sekventiella faser (en del valfria). Du behöver inte memorera dem — Claude guidar dig genom varje. Här är vad som händer i varje fas, vad du gör, och vad du ser.

### Phase 0 — Specdrafts (30–60 min)

**Claude gör**: skriver `docs/TECH-SPEC.md` (scen-hierarki, scripts, performance-mål) och `docs/USER-EXPERIENCE.md` (sekund-för-sekund-resa för användaren). Drar inferens från brief + INSPIRATION + onboarding-svar.

**Du gör**: läser och godkänner (eller ber om ändringar i specifika rader). Ingen kod körs förrän du sagt "go phase 1".

**Du ser**: två markdown-filer i `docs/`-mappen.

### Phase B — Capability-tester (valfri, 30 min–1 h)

**Claude gör**: testar empiriskt att de specifika API-yt som lensen ska använda fungerar. Hoppas över om alla yt redan finns dokumenterade i skill:ens gotchas-fil.

**Du gör**: vanligtvis inget — Claude kör testerna och rapporterar.

**Du ser**: en kort sammanfattning typ "Alla 5 API-mönster validerade. Kör vidare till Phase 1."

### Phase 1 — Statisk scaffolding (2–3 h)

**Claude gör**: bygger scen-hierarkin, lägger in alla anchors, importerar texturer, sätter "closed state" (lensen innan användaren interagerar med den). Ingen animation, inga scripts — bara statisk struktur.

**Du gör**: tittar i LS Preview-panel när Claude säger "Phase 1 done". Du ska se den första visuella komponenten på rätt plats med rätt textur.

**Du ser**: en bild i Preview som matchar din vision för "innan användaren tappar".

### Phase 1.5 — Produktionskopior + typsnitt (~30 min)

**Claude gör**: byter ut placeholder-text mot din produktionstext, importerar custom-typsnitt om sådana finns.

**Du gör**: levererar slutgiltig text om du inte gjort det än, bekräftar typsnitt.

**Du ser**: rätt copy + rätt typografi i Preview.

### Phase 2 — Scripts + animationslogik (2–3 h)

**Claude gör**: skriver TypeScript-scripts som driver interaktion och animationer. Wire-ar `@input`-fält i Inspector via MCP. Sätter upp tap-handlers, tween-chains, state machine.

**Du gör**: godkänner UX-principer innan Phase 2 startar (skill:en kräver detta — 3–5 principer som "no breaking of touch-feedback-loop", "always show progress", etc.) och säger "go phase 2".

**Du ser**: i Preview kan du klicka på lensen och se tap-till-final-state-cykeln fungera. Det är inte poleratet än — bara att hela flödet körs igenom.

**Konkret exempel från seed-projektet**: för en tappa-för-att-öppna-förpackning-lens blev Phase 2 där förpacknings-animationen kopplades till tap, text-roll-callbacken med växande intervaller implementerades, och reroll-mekaniken sattes upp.

### Phase 2.5 — Avancerade features (valfri, 1–2 h)

**Claude gör**: face-effekter, ML-baserade features, audio — om briefen kräver det. Hoppas över annars.

**Du gör**: testar att advanced features inte bryter core-loopen.

**Du ser**: face-effekt eller annat avancerat aktivt i Preview, togglade på korrekt sätt.

### Phase 3 — Polish-iterationer (variabel)

**Claude gör**: ändrar magnituder, tween-tider, färger, easings — baserat på vad du säger ser fel ut. Phase 3 är där feel-finetuning händer.

**Du gör**: titta i Preview, peka ut EN sak som känns fel, säg det. Claude justerar.

**Du ser**: live-feedback i Preview när du justerar Inspector-sliders (skill:en gör detta — den lämnar magnitude-tuning till live-Inspector istället för MCP, eftersom Inspector ger 60fps preview).

### Phase 4 — Device-testning (1–2 h)

**Claude gör**: förbereder export, ger dig instruktioner för att testa på riktig telefon.

**Du gör**: kör lensen på iPhone + mid-range Android. **Detta är manuellt — Claude kan inte ansluta till din telefon.** Du rapporterar FPS, eventuella visuella fel, lens-storlek.

**Du ser**: lensen på två riktiga enheter. Mål: ≥25 FPS på Android, lens ≤4 MB.

### Phase 5 — Submission (1 h)

**Claude gör**: producerar icon (320×320 PNG, simplified graphic — inte foto), preview-video (genom LS Preview-recording), submission-metadata.

**Du gör**: går in i Snap Ads Manager, klickar Submit, väljer ad-account.

**Du ser**: en submitted lens som väntar på Snap-review.

---

## 7. Vad gör du — vad gör Claude?

Sammanfattningsmatris för ansvar:

| **Du (creative director)** | **Claude (teknisk + grafisk exekutor)** |
|---|---|
| Vision och feel | Scen-hierarki, kod, animationer |
| Brief, INSPIRATION-bilder, brand-assets | Inferens av designbeslut från det du levererar |
| Godkännande av varje fas innan nästa börjar | Specdrafts, scripts, mutationer, error recovery |
| "go"-kommandon för att avancera | Submission-prep (icon, preview, metadata) |
| Justering av feel via Inspector i Phase 3 | MCP-orkestrering, ⌘S-handshakes, git-arbete |
| Device-testning på riktig telefon | Allt som händer i Lens Studio och kod |
| Submit-klick i Snap Ads Manager | Allt fram till Submit-knappen |

**Det Claude INTE gör**: tar kreativa beslut åt dig, godkänner egen output, klickar Submit, testar på din telefon, kontaktar kund, hanterar Snap Ad Account-permissions.

---

## 8. Begränsningar — var går gränsen?

Skill:en är ärlig om vad den inte gör. Här är de viktigaste:

### Easy Lens panel-features (LS 5.21+)

Lens Studio 5.21 introducerade en "Easy Lens"-panel — ett AI-drivet creator-UI inuti Lens Studio där designers kan generera lenser visuellt. **Claude kan INTE styra Easy Lens-panelen.** Den manipulerar de underliggande primitive-komponenterna direkt.

Konkret betyder det:
- "Easy Lens Button" i changeloggen → Claude använder `Button` v1.0.1 CustomComponent (samma underliggande sak, men scriptable)
- "Easy Lens Blur" → Claude använder `GaussianBlurPreset` (native scene preset)
- Designerdefinierad visuell tuning i Easy Lens-panelens UI är **hands-off** för Claude

Om en kund ber om "Easy Lens look" levererar Claude funktionen via primitives + lämnar visuell finetuning till dig i LS-panelens UI.

### Tier 3-features

Som beskrevs i sektion 2: vissa lenser kräver Snap-intern teknik. Inget budget löser det. När Claude detekterar Tier 3 i en brief säger den det rakt — och föreslår alltid en Tier 1-alternativ. Detta är **inte hopplöshet — det är heders-disciplin**. Du sparar kunden en lång väg mot en omöjlig leverans.

### MCP-token roterar dagligen

Varje gång du startar om Lens Studio får MCP-servern en ny Bearer-token. Din existerande registrering använder den gamla och slutar funka. Lösningen är en ~3-minuters reconnect-rutin som Claude guidar dig genom om du säger "MCP funkar inte". Inget allvarligt — bara en operativ rutin du behöver känna till.

### Device-testning är manuellt

Claude kan inte ansluta till din telefon. Phase 4 är där du tar fram två riktiga enheter (iPhone + mid-range Android, **inte bara iPhone**) och testar lensen. Det är icke-förhandlingsbart — Snap reviewar lenser på mid-range Android, och desktop Preview är **misslednade optimistiskt** vad gäller performance.

### Snap review-SLA

När du klickat Submit:
- **General-kategorier** (musik, lifestyle, sport, gaming) → 1–3 arbetsdagar review
- **Reglerade kategorier** (Sexual Wellness, Alcohol, Gambling, Pharmaceutical) → 1–2 veckor review
- **Avslagen som behöver resubmission** → addera ytterligare 1–2 veckor

Planera kampanjtimingen efter detta. Skill:en flaggar reglerad kategori under onboarding (fråga 2.1).

### Vad skill:en INTE är gjord för

- **TikTok Effect House**-projekt (helt annan plattform, andra API:er)
- **Meta Spark / Instagram-filter** (annan plattform)
- **Unity / Unreal AR** (annan tech-stack)
- **Apple Vision Pro / Quest / HoloLens** (XR, inte mobil-AR)
- **Spectacles AR Object**-projekt (Snap, men annan toolset)

Om kunden vill ha en lens till en annan plattform, säger Claude det direkt och hänvisar dig vidare. Skill:en aktiveras inte för fel plattform.

---

## 9. Tips för bästa resultat

### INSPIRATION-mappen — minst 5 bilder

Den enskilt största hävstången för kvalitet är **vad du lägger i INSPIRATION-mappen**. Claude läser bilderna och extraherar färgpalett, motion-feel, kompositionsval, mood. Tom INSPIRATION-mapp = Claude gissar mer; rik INSPIRATION-mapp = Claude träffar rätt på första iterationen.

Lägg minst 5 bilder. Mer är bättre. Subfolders får finnas men behövs inte — Claude sorterar retroaktivt om du levererar flat.

Exempel från seed-projektet: INSPIRATION-mappen innehöll referenser från fortune cookies, retro-spelmaskiner, neon-skyltar och magic 8-balls. Claude utledde "playful + slumpmässighet + lekfullt nostalgisk vibe" — och det stämde.

### Var specifik om känsla, inte specs

❌ "100ms tweens med cubic-easing"
✅ "Energiskt, snappy, ska kännas som att något *händer*"

❌ "Färgkod #1e5d8c som primärfärg"
✅ "Lugn djupblå, som havet en kväll" (Claude extraherar exakta hex från INSPIRATION)

Designers ska kunna prata om feel utan att veta exakta värden. Claude omsätter feel till specs.

### Ett brief = en lens

Resist scope expansion mid-projekt. Skill:en flaggar scope-creep proaktivt:

> *"Den nya idén du nämnde (audio-reaktiv partikel) finns inte i den ursprungliga briefen. Vill vi (a) lägga till det som v1-feature och pusha deadline, (b) parkera som v2-kandidat, eller (c) lägga till och skippa Phase 3 polish?"*

Du tar beslut; Claude följer.

### "go" och "ändra X"-mönster

Två kommandon du kommer använda hela tiden:

- **"go [phase X]"** eller bara **"go"** → avancera till nästa fas / godkänn nuvarande output / starta nästa steg
- **"ändra [rad]: [nytt värde]"** eller **"ändra X"** → justera en specifik sak

Försök vara specifik. "Ändra färgen" är öppet — Claude måste fråga vilken. "Ändra primary color: lite varmare djupblå" är actionable.

### Om Claude föreslår något du inte gillar

Säg det rakt. *"Den där tween-tiden känns rusad."* eller *"Den blå är för mörk."* Claude justerar och visar igen. Det är iteration — inga "you broke it" eller "skip this", bara *"så här istället"*.

---

## 10. Vanliga frågor

**Behöver jag kunna koda?**
Nej. Skill:en är designad för designers utan kodvana. Du behöver kunna skriva text till Claude och läsa markdown-filer. Det är allt.

**Behöver jag kunna Lens Studio?**
Inte för att börja. Phase 1 kräver att du tittar i Preview-panelen, vilket är intuitivt. Phase 3 har du nytta av att kunna Inspector-sliders (Claude markerar rätt SceneObject åt dig så du vet vad du justerar). Phase 5 kräver att du kan klicka i Snap Ads Manager. Mer än så krävs inte.

Om du vill djupdyka senare är det bra — men det är inget krav.

**Vad händer om Claude gör något fel?**
Säg det direkt: *"Det där blev fel, [beskriv]."* Claude har en error recovery-rutin som baktrackar, identifierar rotorsaken, och fixar. Om något verkligen kraschar finns rollback-mekaniker — git-historik, scaffold-checkpoint, möjlighet att gå tillbaka till tidigare scenstate.

**Kan jag använda detta för Community Lenses (icke-sponsrade)?**
Ja. Bygg-faserna 0–4 är identiska. Phase 5 (submission) skiljer sig — Community Lenses submits via My Lenses i LS-app, inte via Snap Ads Manager. Skill:en täcker primärt Sponsored Lens-flödet, men technical pipeline är samma.

**Hur uppdaterar jag skill:en när det kommer en ny version?**
Två varianter:
- Om du klonade från git: `cd ~/.claude/skills/lens-studio-snapchat-filter && git pull`
- Om du fick en `.skill`-fil: byt extension till `.zip`, packa upp över befintlig mapp

Skill-maintainer-teamet på Valtech RADON underhåller skill:en. Nya versioner släpps när lärdomar från nya projekt validerats empiriskt.

**Vad händer om Lens Studio uppdateras och något bryter?**
Skill:en är pinnad till LS 5.20+ men testas mot senaste version. Om en LS-uppdatering bryter ett mönster, fångas det i nästa skill-uppdatering. Mellan uppdateringar: säg till Claude *"LS uppdaterades till X.Y.Z och nu fungerar inte [Z]"* — Claude probar empiriskt och rapporterar.

**Vad gör jag om kunden vill ha något som verkligen är Tier 3?**
Säg ärligt: *"Det filtret kräver Snap-intern teknik som ingen byrå har tillgång till. Vi kan inte bygga den. Här är vad vi KAN bygga som fångar samma kampanjanda: [Tier 1-förslag]."* Det är samma språkmall som Claude använder internt — använd den med kund. Trustvärd och tydlig.

**Är data privat? Hamnar något hos Anthropic / Snap?**
Claude Code skickar konversationen till Anthropics modell för bearbetning, enligt deras vanliga produktvillkor. Lens Studio MCP körs lokalt på din maskin — ingen lens-data eller scene-data skickas till Snap utöver det som händer när du själv klickar Submit. INSPIRATION-bilder läses lokalt av Claude.

**Vad kostar det?**
Skill:en själv är gratis (internt Valtech-distribuerad). Du betalar för Claude Code (Anthropic-abonnemang) och Lens Studio (gratis från Snap). Inga andra licenser.

---

## 11. Teknisk bakgrund (för den nyfikne)

### Vad är Claude Code?

Claude Code är Anthropics terminalverktyg för utvecklare. Det är samma Claude-modell som driver claude.ai, men kör i din terminal och kan läsa filer, skriva filer, köra kommandon, och interagera med andra verktyg via MCP. Skill:er som `lens-studio-snapchat-filter` är paketerade kunskapsbaser som lär Claude specifika arbetsflöden.

### Vad är MCP och varför spelar det roll?

MCP (Model Context Protocol) är en öppen standard som låter AI-modeller prata med externa verktyg. För Lens Studio betyder det att Claude kan:

- Läsa scengrafens nuvarande tillstånd
- Lägga till, ta bort, flytta SceneObjects
- Ändra component-properties
- Köra TypeScript-kod inuti LS-editorn
- Begära screenshots från Preview-panelen
- Söka i LS Asset Library

Utan MCP får du fortfarande instruktioner — men du måste själv klicka och dra i LS efter Claudes guidning. Med MCP gör Claude förändringarna direkt, och du verifierar i Preview.

### Hur byggdes den här skill:en?

Skill:en växte fram under produktion av ett Valtech RADON Sponsored Lens-bygge under första halvan av 2026. Varje gång ett LS-mönster misslyckades och rätt lösning hittades, dokumenterades det i en projektintern gotchas-fil. Varje gång ett fasprotokoll behövde justering, uppdaterades phase-progression-mallen. När projektet var klart, extraherades all generaliserbar kunskap från projektmappen — med Generaliseringsregeln som filter mot kund, kampanj och projektspecifik detalj — och paketerades som denna skill.

Specifika 5.21-features (Text3D Animator, Easy Lens Button, etc.) validerades empiriskt via Phase B-capability-tests och dokumenterades i skill:ens `references/lens-studio-api-gotchas.md`. Skill:en är **inte spekulativ** — varje mönster i den har testats i produktion.

### Hur bidrar jag tillbaka när jag lär mig något nytt?

Om du under ett projekt upptäcker:
- En ny LS API-gotcha som inte finns i skill:en
- Ett UX-pattern som funkat bra och som andra borde kunna återanvända
- En process-lärdom som skulle hjälpa nästa team

… så pinga skill-maintainern. Tröskeln för att skill:en ska uppdateras är: **passar lärdomen i andra kundprojekt också?** Om ja → migreras in i skill:en via en pull request (efter att Generaliseringsregeln har filtrerat bort projektspecifik detalj). Om bara projektspecifikt → stannar i projektets egna docs.

Den filtreringen håller skill:en kvalitativt hög utan att svälla.

---

## Vidare läsning

- **När du faktiskt ska installera**: [`INSTALL-REFERENCE.md`](INSTALL-REFERENCE.md) — fullständiga steg-för-steg-instruktioner med bash-kommandon och verifieringspunkter
- **När något inte funkar efter installation**: [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) — detaljerad debug-guide med rotorsaker och fix-recept
- **Engelsk version av denna manual**: [`MANUAL-EN.md`](MANUAL-EN.md)
- **Skill:ens interna kunskapsbas** (CC läser dessa internt — du behöver normalt inte): `references/`-mappen i skill:ens rot

---

*Senast uppdaterad: 2026-05-12 mot skill version 0.4.3+. Frågor eller feedback: pinga skill-maintainer-teamet på Valtech RADON.*
