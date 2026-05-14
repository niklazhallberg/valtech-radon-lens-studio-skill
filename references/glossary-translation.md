# Glossary — translating technical terms to plain language

**Status:** Canonical. Companion to `voice-and-pedagogy.md` (specifically principle #1 Believe in the user + the Pedagogy layer).

**Why this file exists:** Each unexplained technical term creates an "I don't belong here" moment for non-technical users. Translating ≠ patronizing. This file gives every common term a plain-language drop-in.

---

## The first-use rule

When you (the agent) use a technical term for the FIRST TIME in a session:

1. **Drop the term naturally in context** — don't make a big deal of explaining
2. **Add ONE plain-language sentence** — short, concrete, often an analogy
3. **After first-use, the term is "unlocked"** — use it freely without re-explaining

**The shape:** `[term] — [plain-language clause]. [Rest of message uses term freely from here.]`

Example: "Vi behöver en GLB-fil av skon — det är ett 3D-format, tänk som JPEG men för 3D-objekt. GLB:n droppas i Assets/3D/-foldern så importerar Lens Studio den automatiskt."

When the same user has heard a term before (e.g., second session, term defined in earlier message), skip the translation. Re-translating after first-use feels condescending.

---

## Term list

### Filformat

**GLB**  
Plain: ett 3D-filformat som buntar ihop geometri, texturer och material i en fil. Tänk JPEG, men för 3D-objekt.  
First-use: "Vi behöver en GLB av skon — det är ett 3D-format, ett standardalternativ som funkar direkt i Lens Studio."

**FBX**  
Plain: ett äldre 3D-filformat, vanligt när innehållet kommer från Maya, Blender eller Cinema4D.  
First-use: "FBX är sibling till GLB — också ett 3D-format. Det dyker upp ofta när 3D-modellerare jobbar i Maya eller Blender."

---

### Lens Studio scene-koncept

**Scene Hierarchy** (scen-hierarki)  
Plain: trädet av allt som finns i din lens — kamera, ljus, modeller, scripts. Visas som en mapp-struktur i en panel som heter Scene Hierarchy.  
First-use: "Scene Hierarchy är trädet av allt i din lens. Tänk som en mapp-struktur i Finder, fast med 3D-objekt — kameran i en gren, ljuset i en, dina assets i en tredje."

**ObjectPrefab**  
Plain: en återanvändbar grupp av scen-objekt, sparad som EN enhet. Kan instansieras flera gånger; varje instans kopplas till "mallen".  
First-use: "Try-On Pack kommer som en ObjectPrefab — en gruppering av flera scen-objekt (vänster + höger sko + material) som Lens Studio behandlar som en enhet."

**Try-On Pack**  
Plain: ett färdigpaketerat Snap-asset med meshes, material och scripts för ett specifikt try-on-scenario (t.ex. sneakers, eyewear). Installeras via Asset Library med ett klick.  
First-use: "Try-On Pack är ett färdigt paket från Snap — meshes, material och scripts för foot try-on, allt buntat. Installerar det nu via Asset Library."

**Anchor**  
Plain: en 3D-punkt som tracker:n uppdaterar varje bildruta. Asseten du vill ska följa kroppsdelen sätts som child till anchor-punkten.  
First-use: "Foot Tracking ger oss två anchors — en per fot. Vänster sko sätts som child till `leftFootAnchor`; tracker:n uppdaterar anchor:n så skon följer foten."

**Mesh pivot**  
Plain: 'origo'-punkten i en 3D-modell — där modellen 'hänger' från. Om pivot är förskjuten från mitten hamnar modellen snett när du sätter den vid en anchor.  
First-use: "Mesh-pivot är 3D-modellens hängpunkt — där modellen 'fästs' när vi sätter den vid foot-anchorn. Om pivot ligger utanför mitten av skon hamnar skon snett."

**AABB** (axis-aligned bounding box)  
Plain: minsta rätvinkliga 'lådan' som rymmer ett 3D-objekt. Jag använder den för att räkna ut var mesh-mitten ligger relativt pivot-punkten.  
First-use: "AABB är den osynliga lådan runt en 3D-modell. Jag läser AABB:n via MCP för att räkna ut hur långt off-center pivot:en är."

---

### Tracker-beteende

**Tracker overwrite**  
Plain: när tracker:n skriver över din ändring varje bildruta, så din scale- eller position-ändring försvinner direkt. Lösningen är wrapper-anchor (ett mellanlager).  
First-use: "Tracker:n skrev över min scale-ändring — det är 'tracker overwrite', betyder att tracker:n äger den property:n och vi inte kan ändra den direkt. Lösningen kommer i probe-4: wrapper-anchor."

**Wrapper-anchor**  
Plain: ett tomt mellan-objekt mellan tracker:n och din asset. Tracker skriver till mellanobjektet; din asset (som child) behåller sin egen transform orörd.  
First-use: "Wrapper-anchor är ett tomt 'mellanlager' mellan tracker:n och skon. Tracker:n får skriva till wrapper:n, din scale på skon (som ligger som child) blir orörd."

---

### Beteende / logik

**State machine**  
Plain: en sekvens av tillstånd lensen kan vara i — t.ex. 'väntar på fot', 'fot hittad', 'skon visas', 'användaren tappade CTA'. Övergångar mellan tillstånden triggas av händelser.  
First-use: "State machine är 'flödesschemat' för lensen — vilka lägen den kan vara i och hur den växlar mellan dem. T.ex.: 'väntar' → 'fot hittad' → 'skon visas' → 'tappad'. Vi specificerar dessa i TECH-SPEC."

**Tween**  
Plain: en jämn övergång mellan två värden över tid — t.ex. fade-in (0 → 100 % opacitet över 1 sekund).  
First-use: "Tween är en mjuk övergång mellan två värden. Animationen 'skon poppar upp' är en tween från scale 0 till scale 1 över ~0.4 sekunder."

**Easing**  
Plain: hur en tween accelererar och decelererar — linear (rakt), ease-out (saktar ner i slutet), cubic (mjuk båge).  
First-use: "Easing styr hur tween:en känns — 'ease-out' saktar ner i slutet, 'linear' är konstant fart, 'cubic' är en mjuk båge. Olika easings ger olika känsla i samma sekund."

---

### Byggprocess

**Scaffolding**  
Plain: lensens statiska skelett — scen-objekt, anchors, texturer, material — UTAN scripts eller animation. Just nog för att se att placeringen är rätt innan vi lägger till logik.  
First-use: "Phase 1 är scaffolding — vi bygger lensens statiska 'skelett' (assets på rätt plats, material tilldelade) men ingen scripting eller animation än. Bekräftar geometry innan vi addar beteende."

**Performance budget**  
Plain: maxgränser för storlek och hastighet — lens ≤ 4 MB, ≥ 25 FPS på mellanklass-Android. Snap granskar på mellanklass-telefoner, inte högend.  
First-use: "Performance budget är våra hårda gränser: lens ≤ 4 MB total storlek, minst 25 FPS på en medel-Android. Snap testar på medel-Android, inte top-end iPhone — så vi optimerar mot lägsta nivån."

---

### Projektdokumentation / process-jargong

**Readiness Report**  
Plain: en sammanställning av alla beslut vi tagit i intake-fasen, som en tabell. Du godkänner rad-för-rad innan vi går till Phase 0.  
First-use: "När alla intake-frågor är besvarade sammanställer jag en 'Readiness Report' — en tabell med alla beslut vi tagit. Du går igenom raderna, säger OK eller ändrar, sen kör vi Phase 0."

**Watch points**  
Plain: risker eller okända saker som kan kräva ändringar senare. Vi listar dem så vi inte glömmer dem mellan sessioner.  
First-use: "Watch points är 'sånt vi bör hålla ögon på' — risker eller öppna frågor som inte är akuta nu men kan bita oss senare. Jag listar dem i PROJECT-STATE.md så vi inte glömmer."

**Spec-drafter**  
Plain: ❌ **avoid** — intern jargong. Säg "när jag skriver TECH-SPEC och USER-EXPERIENCE för dig" i stället.  
First-use: [SKIP — don't use this term in conversation]

---

### MCP / system

**MCP** (Model Context Protocol)  
Plain: ett kommunikations-system som låter mig (Claude Code) prata direkt med Lens Studio — läsa scenen och göra ändringar utan att du behöver klippa-och-klistra.  
First-use: "MCP är 'bron' mellan oss — Model Context Protocol. När den är registrerad kan jag läsa och ändra direkt i din Lens Studio-scen istället för att be dig klicka. Som om jag satt bredvid dig vid datorn."

**GraphQL**  
Plain: ett frågespråk för strukturerad data — typ SQL men för objekt-grafer. Snap använder GraphQL för MCP-anrop som rör scen och assets.  
First-use: "GraphQL är frågespråket Snap:s MCP använder. För dig syns det inte — jag hanterar query:erna. Det betyder bara att jag kan be om specifika delar av scenen utan att läsa hela."

**Asset directory**  
Plain: foldern i ditt LS-projekt där alla assets (modeller, ljud, texturer) ligger. Synkas automatiskt med Asset Browser-panelen i Lens Studio.  
First-use: "Asset directory är den folder där alla assets bor — speglar Asset Browser-panelen i Lens Studio. Dropping en GLB där dyker upp i Asset Browser direkt."

---

### Arbetsflöde

**Probe-first**  
Plain: innan vi ändrar något komplext gör vi en isolerad mini-ändring för att verifiera vår hypotes. Inga 'big bang'-mutations.  
First-use: "Probe-first betyder: jag testar en liten kontrollerad ändring först — t.ex. bara vänster sko — innan jag committar till hela approachen. Säkrare iteration."

**Pair-test**  
Plain: test där agenten (via MCP) och användaren (via telefon eller preview) kollar samma resultat parallellt. Probe → pair-test → reaktion → nästa probe.  
First-use: "Pair-test är att vi båda kollar resultatet samtidigt — jag via MCP-läsningen, du via Preview eller telefonen. Du säger vad du ser; jag justerar."

**⌘S handshake** (Cmd-S handshake)  
Plain: efter varje lyckad probe-pair-test-cykel: spara projektet i LS (⌘S på Mac, Ctrl-S på PC). MCP:s ändringar är annars bara i RAM och försvinner vid LS-restart.  
First-use: "Innan vi går vidare — tryck ⌘S i Lens Studio. Mina MCP-ändringar är just nu bara i RAM, så utan save förlorar vi dem om LS startar om."

---

## Anti-patterns

❌ Chains of unexplained terms in one message:  
"Use the MCP scene-graphql endpoint to query the scene-hierarchy for a tracker-overwritten anchor."

✅ Translate the WHOLE chain (or break into smaller messages):  
"Jag läser scenen via MCP — så pass jag ser hur 'foot-trackerns ankarpunkt' ligger i förhållande till resten. Tracker:n skriver över den varje frame, så jag behöver en wrapper innan jag kan ändra position."

❌ Translating a term every time it appears (after first-use it's unlocked):  
[Same explanation 3 messages in a row]

❌ Translating words that aren't really technical:  
"Scene" — användaren förstår "scen" från vanligt språk; behöver inte förklaras.

---

## When NOT to translate

Some terms have everyday meanings the user already maps to correctly:
- **scene, object, camera, light** — vardagsord med teknisk användning. Translation ≠ värde här.
- **animation, color, texture** — domain-shared mellan design och teknik.
- **File extensions användaren själv nämner** — om de säger "FBX", de vet FBX.
- **Verb-baserade terms** — "save", "import", "export", "drag" — universella.

When in doubt: if a designer with 5 years' Photoshop / Figma experience would understand the term, skip the translation.

---

## Maintenance

When you encounter a new term that's NOT in this list but creates a confusion moment in a session:

1. Add it here with a one-sentence plain definition + first-use example
2. Date the addition
3. If 2+ sessions hit the same untranslated term, promote it to a more prominent category position

When in doubt: err on the side of including the translation.

**Date stamps:**
- 2026-05-13 — initial 19 terms from Samba/adidas session
- (future additions logged here)

---

## Cross-references

- `voice-and-pedagogy.md` — principle #1 (Believe in user), Pedagogy layer
- `lens-studio-api-gotchas.md` — terms here are also discussed there empirically (tracker overwrite, mesh pivot, etc.)
- `mcp-tool-schemas.md` — MCP-specific terminology
- `body-anchored-calibration.md` — wrapper-anchor, tracker overwrite, AABB in deeper context
- `snap-docs/01-mcp-and-claude-code/developer-mode.md` — Snap's prosabeskrivning av MCP-tools
