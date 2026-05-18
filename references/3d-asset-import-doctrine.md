# 3D Asset Import Doctrine — GLB-first + Two-pass Optimization

Load this when the user mentions a 3D-object, GLB/FBX/OBJ files, "lens size too big", custom modeller, or any AR accessory (hatt, glasögon, smycke, prop). Also load proactively in Phase 0/1 when the brief mentions custom 3D content.

Snap officially supports **FBX, glTF/GLB, and OBJ** for 3D import. Snap has a dedicated official glTF import guide and glTF is the format the platform pipeline is built around. This doctrine reflects that preference order — without locking the skill to any specific upstream tool.

---

## A. Agent doctrine — när användaren vill lägga till ett 3D-objekt

Detta är mina (agentens) beslutsregler, *inte* en checklista jag dumpar på användaren.

- *Jag föredrar GLB/glTF som default-format för egna 3D-objekt.* Snap har en dedikerad importguide för glTF/GLB och formatet är native-stöttat. FBX och OBJ är giltiga fallback-format, inte förstahandsval.
- *Jag kontrollerar lens-size-risk tidigt — så snart 3D-objekt nämns i briefen.* Många 3D-källor (särskilt image-to-3D-tjänster) producerar default rik geometri och stora texturer som kan blåsa upp en Snap lens snabbt. Jag flaggar risken innan användaren kommit långt i sin pipeline.
- *Jag tänker i två pass när jag resonerar om size.* (i) Före import: mesh/format/texturer från valfri 3D-källa, ev. post-process. (ii) Inne i Lens Studio: texture compression + Resource Inspector. När storleken sticker iväg vet jag direkt vilket pass som behöver fixas.
- *Jag behandlar texturer som sannolik huvudbov.* Texturer är ofta största boven i en 3D-assets storlek. Jag börjar diagnostisera där, inte med meshen.
- *Jag frågar kort om källa när det spelar roll för nästa steg.* Image-to-3D-service, asset-bibliotek, eller DCC-verktyg? Annars antar jag inget specifikt verktyg.
- *Jag använder skillens interna budget för att flagga risk.* Om en enskild accessoar markant överstiger ~1 MB komprimerat, eller hela lensen närmar sig 6 MB, flaggar jag. Detta är *skillens* arbetsbudget; Snap:s hårda tak är 8 MB (se Performance budget-tabellen i `SKILL.md` för skillens default-target).
- *Jag börjar alltid med library-first sourcing.* Innan jag föreslår custom 3D-generering kollar jag Snapchat Asset Library, Lens Studio Templates och redan importerade prefabs. Snap-officiella assets är pre-optimerade och slipper hela Pass 0–Pass 2-kedjan. När library/templates inte motsvarar användarens förväntningar — *då* lyfter jag image-to-3D som väg framåt och hänvisar till `image-to-3d-generation.md`. Att hoppa över library-checken är den vanligaste anledningen till att en lens onödigt landar i 3D-pipelinen från början.

---

## B. Format priority — GLB-first doctrine

| Format | Roll | När |
|--------|------|-----|
| `.glb` / `.gltf` | **Förstahandsval** | Default för alla egna 3D-objekt. Aktivera Draco-kompression om källan stödjer det. |
| `.fbx` | Fallback | När källan inte kan exportera GLB rent. Bocka av "Embed Media" om möjligt; leverera texturer separat. |
| `.obj` | Fallback | Endast för enkla statiska props utan PBR-material eller animation. |

**Varför denna ordning:**
- **GLB** är binärt, kompakt och designat för web/AR-delivery. Det är formatet Snap:s import-pipeline är optimerad för.
- **FBX** är ett DCC-mellanlagringsformat — bra för utbyte mellan modelleringsverktyg, mindre bra för slutleverans. Embeddade texturer komprimeras inte automatiskt.
- **OBJ** är ett legacy-format utan modern material-stöd (ingen PBR, ingen animation).

**Om Draco-kompression:** kan ge betydande reduktion av geometri-data — typisk vinst varierar med modellens komplexitet, ofta halvering eller mer. Inte ett hårt löfte, men en värdefull default när källan tillåter det.

---

## C. User playbook — så här importerar du 3D i Lens Studio

Två tydliga vägar in. Snap dokumenterar båda i den officiella importguiden.

### Asset Browser (vanligast — flexibel)

1. I Asset Browser-panelen: klicka `+` → `Import Asset`, eller drag-and-drop din `.glb`-fil direkt på Asset Browser.
2. Resultat: filen blir en **resource** i `Assets/`. Den syns *inte* i scenen ännu.
3. För att placera den i scenen: dra prefaben från Asset Browser → Scene Hierarchy.

**Varför två steg:** det skiljer på "filen finns i projektet" (resource) och "filen är aktiverad i scenen" (instans). Du kan ha tunga assets liggandes som resources utan att de räknas i scenens render-budget, så länge de inte är instansierade. Bra för att hålla scenen ren medan du experimenterar med olika varianter.

### Scene Hierarchy (snabb — direkt-instans)

1. Dra GLB-filen *direkt* från Finder/Explorer på Scene Hierarchy-panelen.
2. Resultat: filen importeras som resource *och* instansieras i scenen i ett steg.

**Varför detta:** kortast väg till "objekt i scenen". Använd när du vet att du vill ha objektet i scenen direkt och inte behöver flera varianter.

---

## D. Två-pass-optimering (verktygsagnostisk)

### Pass 0 — Generering av .glb (om användaren inte redan har filen)

Om användaren inte har en .glb än utan vill *skapa* en custom modell från bild/idé — t.ex. för att Snapchat Asset Library inte hade något passande, eller för att varumärket kräver något unikt — börja i `image-to-3d-generation.md`. Den filen täcker bildkrav, prompt → bild, tjänsteval (Meshy/Tripo/Hunyuan3D/Rodin) och kvalitetschecklista innan .glb-filen tas vidare till Pass 1b.

Hoppa över Pass 0 om användaren redan har en .glb (från DCC-verktyg, asset-bibliotek eller annan källa) — då börjar du direkt i Pass 1 nedan.

### Pass 1 — Före import (i 3D-källan, oavsett verktyg)

**Mål:** producera så liten och välformad asset som möjligt *innan* den når Lens Studio.

- **Format:** exportera/ladda ner som `.glb` när möjligt. Aktivera Draco-kompression om källan stödjer det.
- **Mesh:** håll polygon-antalet så lågt som visuell kvalitet tillåter. För en liten accessoar (hatt, glasögon, mindre prop) är en rimlig **målzon 1k–3k trianglar** — en riktlinje för accessoarer, inte en universell regel. Större eller mer detaljerade objekt får ta mer, men gör ett aktivt val baserat på hur stort objektet är i bilden.
- **Texturer:** målzon **1024×1024**, eller **512×512** för mindre objekt. JPG om alpha inte behövs, PNG bara när transparens faktiskt krävs. Slå ihop till en PBR-atlas om källan tillåter, istället för flera separata texturer.

**Pipeline-kontext:** Snap stöder många 3D-källor. DCC-verktyg (Blender, Maya, Cinema 4D), Snapchat Asset Library, eller image-to-3D-services (Meshy, Tripo, Luma Genie, Rodin, Hunyuan3D via fal.ai m.fl.) är alla legitima starter. Många image-to-3D-tjänster har begränsade export-parametrar — använd vad som finns och förlita dig på Pass 1b vid behov.

### Pass 1b — Valfri post-process på .glb-filen

Om Pass 1 inte räckte hela vägen (vanligt med image-to-3D-output som tenderar mot rik geometri och stora texturer), kör .glb-filen genom ett post-process-verktyg innan Lens Studio-import:

- **`optimizeglb.com/dashboard`** (https://optimizeglb.com/dashboard) — **rekommenderat förstahandsval för designers.** Drag-and-drop i browser, kör mesh- och textur-kompression på din .glb och ger en optimerad fil tillbaka. Empiriskt verifierat i Valtech-projekt: bevarar visuell kvalitet rent utan synliga artifakter på image-to-3D-output.
- **`gltfpack`** (CLI, för advanced/batch): `npm install -g gltfpack`, sedan `gltfpack -i in.glb -o out.glb -cc -tc`. Flaggorna: `-cc` = mesh compression (meshopt), `-tc` = texture compression.
- **`gltf-pipeline`** (CLI, Cesium): alternativ med liknande kapacitet om gltfpack saknar något specifikt.

**Detta steg är en rekommendation, inte ett universalkrav** — men ofta praktiskt när 3D-källan inte gav full kontroll över output-storleken.

**Verktyg att undvika just nu:** `gltf.report` (https://gltf.report) har observerats introducera synliga artifakter (tearing/distortion i mesh-ytor) i optimize-output även när källans .glb är ren och även med lossless-inställningar. Artifakterna uppstår i webbverktyget — innan filen ens når Lens Studio — och följer sedan med vidare. Använd `optimizeglb.com` istället tills detta är verifierat löst.

### Pass 2 — Inne i Lens Studio

1. Importera den optimerade .glb-filen (via Asset Browser eller Scene Hierarchy, se C ovan).
2. Markera varje textur i Resources → Inspector → sätt Texture Compression till `BC3` (med alpha) eller `BC1` (utan). **Aldrig `RGBA8 Uncompressed`** — det är default-fällan som ger 4–8× för stora texturer.
3. Öppna **Resource Inspector** / Lens Stats **tidigt i flödet**, inte vid publish. Sortera på "Compressed Size" och bekräfta att den enskilda 3D-asseten ligger inom skillens budget för accessoarer (se E nedan).

**Varför Resource Inspector tidigt:** vid publish är det för sent att fixa något billigt. Tidigt i flödet kan du iterera per asset — testa en kompressionsinställning, läs av resultatet, justera. Det förvandlar optimering från "krisåtgärd när röd siffra dyker upp" till "kontinuerlig design-disciplin".

---

## E. Skillens interna arbetsbudget för 3D

Detta är **skillens budget för att hålla marginal mot Snap:s 8 MB-tak**, inte gränser satta av Snap.

| Komponent | Skillens målvärde |
|-----------|-------------------|
| 3D-modell (accessoar) inkl. texturer | ~1 MB komprimerat |
| Face Mesh / Head occluder | ~0.2 MB |
| HDR / environment | ~1 MB (eller skippa, använd Ambient Light) |
| Skript + UI | ~0.3 MB |
| Scene/material/graphs | ~0.5 MB |
| Headroom för fonts, ljud, etc. | resten |

**Total lens size — referera till `SKILL.md`'s Performance budget-tabell:**
- **Target:** ≤ 4 MB (skillens default; för enkla lenser)
- **Acceptabel marginal:** upp till 6 MB för 3D-tunga lenser där de extra megabytena är väl-investerade i visuell kvalitet
- **Hård gräns:** 8 MB (Snap:s tak — alltid)

När budgeten sprängs → tillbaka till Pass 1, inte Pass 2. Du kan inte komprimera ner kvalitet som aldrig genererades; du kan alltid skala ner något som blev för stort.

---

## F. Vad skillen ska hjälpa användaren förstå (mentor-mål)

Innan publish ska användaren självständigt kunna svara på fyra frågor. Den här doktrinen finns för att stödja det.

### 1. Vilket format är bäst för mitt 3D-objekt?

GLB/glTF som förstahandsval — helst Draco-komprimerat. FBX och OBJ är fallback-format som Snap stöder, men glTF är det format Lens Studios pipeline är byggd kring.

**Varför det spelar roll:** rätt format tar bort en hel klass av storleksproblem från start. Att börja med fel format gör allt arbete nedströms svårare.

### 2. Hur importerar jag filen i Lens Studio?

Två vägar:
- **Asset Browser-import** (`+ → Import Asset` eller drag-and-drop på panelen): filen blir en **resource** först — du måste dra prefaben till Scene Hierarchy för att den ska bli synlig i scenen.
- **Scene Hierarchy-import** (drag-and-drop direkt på panelen): filen importeras som resource *och* instansieras i scenen i ett steg.

**Varför skillnaden spelar roll:** Asset Browser-vägen ger dig flexibilitet att ha resources liggandes som inte räknas i scenens budget. Scene Hierarchy-vägen är snabbast när du vet vad du vill.

### 3. Vad påverkar lens size?

- **Texturer** — ofta största boven (upplösning, format, kompression)
- **Polygon-antal** — meshens komplexitet
- **Filformat** — GLB komprimerar bättre än FBX
- **Lens Studios kompressionsinställningar per textur** — `RGBA8 Uncompressed` vs `BC1/BC3` kan ge 4–8× skillnad

**Varför detta är värt att förstå:** när du vet att texturer dominerar lär du dig kolla dem först. Det sparar tid varje gång storleken sticker iväg.

### 4. Vilka optimeringssteg ska tas innan publish?

1. **Pass 1** — optimera mesh, texturer och format i källan, gärna GLB
2. **Pass 1b** — valfri post-process (`gltf.report` rekommenderas för designers) om output är för stor
3. **Pass 2** — i Lens Studio: sätt BC1/BC3 på alla texturer + öppna Resource Inspector **tidigt**, inte vid publish
4. **Publish-check** — Publishing-dialogen ska visa grön Lens Size under 8 MB; siktet är ≤ 4 MB target, 6 MB max för 3D-tung lens

**Varför ordningen är viktig:** Pass 1 är billigast och mest effektiv. Pass 2 kompletterar men kan inte fixa fundamentala problem i källan. Att hoppa över Pass 1 är den vanligaste fällan.

---

## G. När doktrinen INTE gäller

- **Snapchat Asset Library-objekt** importerade som färdiga prefabs — Snap har redan optimerat dem. Du behöver inte gå igenom doktrinen för dessa, bara verifiera i Resource Inspector att de inte oväntat sticker ut.
- **Pre-bundlade Templates** från Lens Studio — samma sak.
- **Snap-officiella SnapML-modeller** — räknas separat (SnapML-budget på 10 MB är skild från Lens Size-budgeten på 8 MB).

För allt annat eget 3D-content gäller GLB-first + två-pass-flödet.
