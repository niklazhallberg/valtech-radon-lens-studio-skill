# Image-to-3D Generation — Pass 0 för custom 3D-content

Load this when the user wants to create a custom 3D-modell från en bild eller idé och inte har en .glb-fil än. Skippa den här filen om användaren redan har modellfilen — då börjar du direkt i `3d-asset-import-doctrine.md` Pass 1b (post-process) eller Pass 2 (Lens Studio-import).

Den här filen täcker steget *innan* `3d-asset-import-doctrine.md`: hur man tar sig från idé eller källbild till en användbar .glb-fil. När .glb finns, lämnar denna doktrin över till Pass 1b.

---

## A. När denna fil gäller

- *Användaren har en idé eller källbild men ingen 3D-fil* — t.ex. "jag vill ha en stiliserad hatt som matchar varumärkets identitet" eller "kan vi göra en 3D-version av den här produkten?".
- *Library-first sourcing landade inte rätt* — vi kollade Snapchat Asset Library, Lens Studio Templates och eventuella import-pack först, men inget motsvarade användarens förväntningar (estetik, varumärke, specifikt motiv). Då lyfter agenten image-to-3D som fallback-väg. Kom ihåg att fortfarande föreslå library-checken om den inte redan gjorts — pre-optimerade Snap-assets slipper hela Pass 0–Pass 2-kedjan.
- *Användaren använder en image-to-3D-tjänst* — fal.ai/Hunyuan3D, Meshy, Tripo, Rodin, Luma Genie m.fl.
- *Inte aktuellt om* användaren redan har en .glb från DCC-verktyg (Blender, Maya, Cinema 4D) eller från Snapchat Asset Library — då är vägen rakt in i Pass 1b/Pass 2.

**Library-first som default-vana:** innan agenten föreslår image-to-3D, ska den ha gått igenom (eller åtminstone nämnt) library-alternativen. Image-to-3D är inte fel — men det är dyrare i tid och risk än en färdig Snap-prefab. Reservera Pass 0 för när library-vägen genuint inte räcker.

---

## B. Pipeline overview

`idé → källbild → image-to-3D-tjänst → .glb-fil → Pass 1b post-process → Pass 2 Lens Studio-import → publish`

Den här filen ansvarar för de tre första pilarna. När .glb-filen finns lämnar vi över till `3d-asset-import-doctrine.md`.

**Varför separera Pass 0 från Pass 1b:** problem som dyker upp tidigt i pipelinen (dålig källbild → konstig mesh → konstiga texturer) går inte att fixa nedströms. Post-process-verktyg som `optimizeglb.com` komprimerar en bra mesh till en mindre fil; de räddar inte en mesh som blev fel från start. När någon i pipelinen är trasig vill du veta vilken — annars optimerar du på fel ställe.

---

## C. Bildkrav — vad gör en bra källbild

Image-to-3D-tjänster "ser" en 2D-bild och gissar 3D-formen bakom. Ju mindre tjänsten behöver gissa, desto bättre output. Varje krav nedan finns för att minska gissningsmängden.

### Bakgrund
Ren, enfärgad eller transparent — gärna kontrasterande mot motivet (mörk bakgrund för ljust objekt, ljus för mörkt).

**Varför:** tjänsten segmenterar objektet från bakgrunden innan den genererar mesh. Otydlig kant → tjänsten tar med delar av bakgrunden i meshen, eller hugger av delar av objektet.

### Vinkel
Front- eller 3/4-vy. Hela objektet synligt, centrerat i bilden, inte beskuret i kanterna.

**Varför:** bortre sidan av objektet är alltid en gissning baserad på framsidan. 3/4 ger tjänsten lite mer information om djup än rak front — men *bara om* den fortfarande visar de viktigaste detaljerna tydligt. Profilvy där ena halvan av objektet är dold ger sämre resultat än rak front.

### Upplösning
Minst 1024×1024, gärna 2048×2048. Skarp i fokus.

**Varför:** texturen som hamnar på meshen baseras direkt på källbilden. Suddig eller lågupplöst bild → suddig textur på 3D-modellen som inte går att rädda i optimeringen nedströms.

### Belysning
Jämn, mjuk, neutral. Inga skarpa skuggor mot objektet, inga starka highlights.

**Varför:** tjänsten skiljer inte alltid på "skugga på objektet" och "form i objektet". Skarp skugga under ett hattbrätte kan tolkas som ett hål eller en utskjutning. Mjukt allmänljus ger renast mesh.

### Motivet ensamt
Inga hjälpobjekt, ingen hand som håller, inga reflekterade ytor i bakgrunden.

**Varför:** allt som syns i bilden är kandidat att bli mesh. En hand som håller ett smycke kan resultera i en hand-formad utskjutning i 3D-output.

### Prompt → bild (om källbilden genereras med ChatGPT Image / Midjourney)
Skriv prompten så att kraven ovan uppfylls automatiskt. Användbara fraser:
- "studio lighting, soft even illumination, no harsh shadows"
- "isolated on plain [white/black/transparent] background"
- "front view, centered, full object visible"
- "high resolution, sharp focus, product photography style"

Skippa fraser som ofta skapar problem: "dramatic lighting", "lifestyle shot", "in use", "held in hand".

**Varför detta:** prompten är där du har mest kontroll i hela pipelinen. Ett par minuter på en bättre prompt sparar ofta en hel iteration nedströms.

---

## D. Tjänsteval — heuristik per objekt-typ

| Tjänst | Bäst för | Svaghet | Var den körs |
|--------|----------|---------|--------------|
| **Hunyuan3D (via fal.ai)** | Stiliserade/cartoony objekt, accessoarer (hatt, glasögon, prop) | Realistiska material kan bli platta | `fal.ai/models/hunyuan3d` |
| **Meshy** | Realistiska props, breddare motiv-typer | Texture-detaljer kan bli mjuka | `meshy.ai` |
| **Tripo** | Snabba iterationer, lägre poly default | Mindre fin-kontroll | `tripo3d.ai` |
| **Rodin** | Hög-detalj sculpts, karaktärer | Långsammare; större output | `hyperhuman.deemos.com` |

**Detta är startpunkter, inte facit.** Heuristiken bygger på den empiri skillen har just nu. Förvänta dig att uppdatera den när du provat ett par tjänster på samma motiv — och flagga gärna nya insikter så att CHANGELOG kan fånga dem.

**När du är osäker:** prova två tjänster på samma källbild parallellt. Det är billigare än att försöka rädda en dålig generering med optimering nedströms.

**Varför detta är heuristik och inte regel:** image-to-3D-tjänsterna förändras snabbt (modellversioner, prismodeller, kapacitet). En tjänst som var bäst för accessoarer i januari kan vara omsprungen sex månader senare. Behandla tabellen som ett startbet, inte ett facit.

---

## E. Kvalitetschecklista innan post-process

Innan du tar .glb-filen vidare till `optimizeglb.com` (Pass 1b) — kontrollera följande direkt i tjänstens preview eller via `optimizeglb.com`-dashboarden som också visar mesh-statistik.

### Poly-count (i ordning för en accessoar)
- *Under 5k tris:* ofta för lågt — risk att modellen ser kantig ut nära kameran.
- *5k–50k tris:* normalzon för image-to-3D-output. Hanterbart att komprimera till accessoar-budget i Pass 1b.
- *50k–100k tris:* går att jobba med, men kräver mer aggressiv mesh-reduktion i Pass 1b.
- *Över 100k tris:* tjänsten gav rik default-output. Funkar fortfarande, men det är ett tecken på att be tjänsten om lägre poly om alternativet finns.

**Varför detta är första kollen:** poly-count är det enklaste att mäta och säger snabbt om meshen är i rätt storleksordning för en Snap-lens.

### Texturupplösning
- *512×512 eller 1024×1024:* idealiskt för en accessoar.
- *2048×2048:* OK, kommer komprimeras ner i Pass 1b/Pass 2.
- *4096×4096+:* onödigt stort för Snap; tjänsten levererar default-print-kvalitet. Pass 1b fixar det, men det är ett tecken på att du kan be tjänsten om lägre upplösning från start om alternativet finns.

**Varför textur också mäts här:** texturer är ofta största boven i lens size. Att veta storleken redan i Pass 0 gör att du kan justera tjänstens inställningar eller välja en annan tjänst innan optimeringen ens börjar.

### Typiska artefakter att leta efter
- *Hängande mesh-flikar* — bitar av geometri som sticker ut från objektet, ofta från otydlig kant mot bakgrund i källbilden.
- *Konstiga skuggor inbakade i texturen* — om källbilden hade skarpa skuggor hamnar de ofta som mörka fläckar i texturen som inte går att lyfta bort senare.
- *Smetade ytor* — låg textur-detalj i områden där källbilden var suddig eller överbelyst.
- *Phantom-objekt* — geometri som motsvarar något som *inte* var huvudmotivet (hand, bakgrundsdetalj, reflektion).
- *Asymmetri som inte fanns i källan* — tjänsten gissade fel på bortre sidan. Vanligt vid ren frontvy utan 3/4-information.
- *Hål i meshen* — saknad geometri i områden tjänsten inte kunde tolka (typiskt under hattbrätten eller bakom utskjutande detaljer).

### Proportioner
Jämför mot källbilden. Tjänsten skalar ibland om objektet på oväntade sätt, särskilt i djupled (objektet blir grundare eller djupare än det "borde" vara).

---

## F. Generera om vs optimera vidare — beslutspunkten

Det här är den viktigaste frågan i Pass 0. När du har en .glb och har gått igenom checklistan ovan, finns det två vägar framåt.

**Generera om (tillbaka till källbild eller tjänst)** — om något av detta stämmer:
- Hängande mesh-flikar eller phantom-objekt i meshen
- Smetade/oläsbara texturer i synliga områden
- Proportionerna är märkbart fel jämfört med källbilden
- Hål i mesh där det inte ska vara hål
- Inbakade skuggor som dominerar texturen
- Asymmetri som inte fanns i källan och som syns från fram-/sidvy

→ Justera *källbilden* (renare bakgrund, mjukare ljus, bättre vinkel) eller *byt tjänst*. Optimering nedströms räddar inte detta.

**Gå vidare till Pass 1b** — om alla dessa stämmer:
- Mesh-formen är korrekt, även om poly-count är högt
- Texturen är läsbar, även om upplösningen är stor
- Inga phantom-objekt eller synliga hål
- Proportioner stämmer mot källbilden

→ Filen är redo för `optimizeglb.com` enligt `3d-asset-import-doctrine.md` Section D Pass 1b.

**Varför detta beslut spelar roll:** att optimera en dålig mesh ger en mindre dålig mesh, inte en bra mesh. Tio minuters omgenerering är nästan alltid billigare än en timmes försök att rädda en trasig output i Lens Studio. När du står och tvekar — generera om.

---

## G. Vanliga fallgropar

- *Reflekterande material i källbilden* — chrome, glas, blank metall förvirrar mesh-genereringen. Be tjänsten om matt referens, eller måla över reflektionerna i källbilden innan upload.
- *Tunna detaljer försvinner* — glasögonbågar, smycken, smala remmar. Gör dem märkbart tjockare i källbilden än de "borde" vara; tjänsten tappar tunna strukturer.
- *Transparens fungerar inte automatiskt* — alpha-effekter måste byggas i Lens Studio som material-inställning, inte förväntas från generationen.
- *Animation finns inte i output* — image-to-3D ger statisk mesh. Behöver du animation, behöver du rigging i ett DCC-verktyg eller en animation-pack från Snapchat Asset Library.
- *Service-prompt vs bild-prompt* — om tjänsten har ett separat text-fält ("describe the object"), använd det. Det ger tjänsten en andra signal vid sidan av bilden.
- *Att optimera först, generera om sen* — fel ordning. Optimera bara när Pass 0 är grön, annars optimerar du på fel underlag.

---

## H. Handover till Pass 1b

När checklistan i E är grön och beslutet i F pekar mot "gå vidare":

→ `3d-asset-import-doctrine.md` Section D Pass 1b — kör .glb-filen genom `optimizeglb.com/dashboard` för mesh- och textur-kompression innan Lens Studio-import.

Allt nedströms (Pass 1b → Pass 2 → publish) hanteras av `3d-asset-import-doctrine.md`.
