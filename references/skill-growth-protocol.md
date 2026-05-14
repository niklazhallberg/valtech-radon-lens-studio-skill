# Skill Growth Protocol v0.5

Syfte: fånga empiriska lärdomar från verkliga
projekt så skillen växer över tid — i flow,
inte batchat. Gate-keeper är alltid människa.

## När du löser något via probe

Innan du går vidare:
1. Grep references/*.md för 3-5 keywords
   från lösningen.
2. Om träffar finns: läs och bevisa varför
   detta är annorlunda.
   Om inte annorlunda → ingen discovery.
3. Om ingen träff (eller bevisat annorlunda):
   discovery → in-flow ask direkt.

## Generaliseringsregeln — skriv om innan du sparar

Innan en discovery skrivs till references/:
omvandla det projektspecifika fyndet till en
universell regel.

Tre steg:

### Steg 1: Identifiera kärnan

Vad är det GENERELLA mönstret bakom det
specifika fyndet?

Exempel:
- Specifikt: "adidas Samba-skon har mesh-pivot
  8.3 LS-units off-center"
- Generellt: "Try-On Pack Sneakers mesh-pivot
  ligger typiskt 6-12 LS-units off-center —
  räkna alltid AABB-center innan du antar att
  pivot sitter i geometrins mitt"

### Steg 2: Ta bort allt projektsspecifikt

Checklist INNAN du skriver till disk:

❌ Ta bort: klientnamn (adidas, RFSU, Ray-Ban)
❌ Ta bort: exakta projektmått som bara gäller
   detta case (X=-106.6 för just denna sko)
❌ Ta bort: interna projektnamn och filsökvägar
❌ Ta bort: datum och deadlines
✅ Behåll: det generella mönstret
✅ Behåll: typiska ranges och tumregler
✅ Behåll: varför det händer (root cause)
✅ Behåll: hur man detekterar och löser det

### Steg 3: Testa med "nästa kollega"-frågan

Läs igenom det du ska committa och fråga:

"Om en kollega på Valtech nästa månad bygger
ett ANNAT try-on-filter för ett ANNAT varumärke
— kan de läsa detta och förstå hur de undviker
samma problem?"

Om ja → redo att committa.
Om nej → skriv om tills svaret är ja.

### Worked example

**BEFORE** (projektspecifikt, ska EJ committas):

> "För adidas Samba-lensen behövde vi sätta
> shoe_mesh_l position till X=-80, Y=-40, Z=-20
> med scale 4 för att skon skulle sitta rätt."

**AFTER** (generaliserbart, ska committas):

> "Try-On Pack Sneakers: mesh-pivot är off-center
> relativt foot-anchor. Kompensera med wrapper-
> anchor arkitektur (se § Wrapper-anchor) och
> tuning av X/Y/Z via probe-first kalibrering.
> Starta från AABB-center-offset som initial
> estimate — förvänta dig 10-30% empirisk
> justering utöver formeln. Y-axeln ska skippas
> i kompensationen (sole sitter vid Y=0)."

## In-flow ask — default

När en discovery passerar grep-checken:
säg DIREKT till användaren, mitt i flowet.

Template (warm tone, jargong-fri — tekniska detaljer
kommer EFTER ja):

> "Vi har lärt oss något nytt här.
>
> [1-2 meningar om vad, i plain svenska — undvik
> API-namn, filsökvägar, grep-output, "discovery"-ord]
>
> Det här är värdefullt att spara. Idag är det inte
> med i skillen, men [konkret konsekvens för nästa
> kollega om vi inte skriver in det — t.ex. "fastnar
> i samma fälla 1-2 timmar" eller "slutresultatet
> känns mindre proffsigt"].
>
> **Är det OK att jag uppdaterar systemfilerna med
> din upptäckt?**
>
> Ja / nej / spara för senare"

Internt INNAN denna ask:
- Generaliseringsregeln-walk (3 steg) körs tyst
- Grep-check körs tyst — bara om regeln INTE finns
  någonstans går vi vidare till ask
- Probe-resultat och tekniska bevis stannar i
  agent-state, inte i user-meddelandet

EFTER att användaren sagt ja kommer NÄSTA meddelande
med konkret diff, fil-path, sektion och commit-
meddelande för second-stage-approval. Det är där
tekniska detaljer släpps in i konversationen — efter
opt-in, inte före.

Användarens svar styr:
- **Ja** → öppna rätt references-fil, lägg
  in entry, visa diff, vänta på godkännande,
  commit. ~2 min cykel.
- **Nej** → skroppa, gå vidare.
- **Spara för senare** → skriv till
  SKILL-DISCOVERIES.md som backup.

Varje accepterad discovery får en egen
liten commit. Granular history; lätt att
rulla tillbaka något specifikt.

## Format för entry

- Vad: [en mening, plain svenska — INTE en
  API-path eller jargong-rad]
- Värde för användare: [vad nästa kollega vinner
  — tid sparad, fälla undviken, något känns bättre.
  EN rad, konkret. Obligatoriskt fält.]
- Hur hittades: [probe-kedjan kort, internt]
- Generaliserbar? [ja/nej + varför]
- Föreslagen text för references-fil: [neutralt
  skriven, projektagnostisk, plain svenska där möjligt]

## CHANGELOG.md — alltid del av discovery-commit

När en discovery committas (ja-path ovan):
samma commit MÅSTE inkludera en prepend till
`CHANGELOG.md` på repo-root, under sektionen
`## Improvements and newly acquired knowledge`.

(Notera: tidigare versioner använde `## [Unreleased]`
som sektionstitel — bytt till värde-bärande titel
från v0.5 av detta protokoll, eftersom CHANGELOG
ska läsas som värde-narrativ av icke-tekniska läsare
också.)

Skäl: utan CHANGELOG-entry har discoveryn ingen
kumulativ synlighet — den finns bara i git log.
CHANGELOG är skill:ens biografi för icke-tekniska
läsare (designers, PMs, leadership).

Entry-format (auto-extraherat av agent):

```markdown
### 💡 YYYY-MM-DD HH:MM — [project: <cwd-derived>]
- **<title i plain svenska>**: <1-2 meningar
  beskrivning, jargong-fri>
- Value for user: <vad nästa kollega vinner — tid
  sparad, fälla undviken, eller bara något känns
  bättre>
- File: `<path>` § <section>
- Type: [discovery] / [docs] / [convention]
```

Auto-extraction:
- 💡-emoji — alltid prefix på rubriken (signal:
  positiv ny insikt)
- `YYYY-MM-DD HH:MM` — current date + tid i 24h-format
- `<cwd-derived>` — från `$PWD`
  (`~/Projects/<name>-lens` → `<name>-lens`)
- `<title>` — plain-svenska summary (om discovery
  namns med API-term, översätt — t.ex. "ScreenTransform
  parent anchor inheritance" → "Skärm-anker tar över
  barnens position")
- `<description>` — 1-2 meningar från "Vad:"-fältet,
  plain svenska
- `<value>` — direkt från "Värde för användare:"-fältet
  i entry-formatet ovan
- `<path>` — relativ path av edited fil
- `<section>` — markdown-section där entryn hamnade

Single commit täcker BÅDE references-file-edit
OCH CHANGELOG.md-prepend. Inga separata commits.

Per release (när nya version-tag skapas):
- Move alla `[Unreleased]`-entries till ny
  `[vX.Y.Z] — YYYY-MM-DD`-sektion
- Commit som `chore(release): consolidate
  vX.Y.Z changelog`
- (Optional: `assets/release.sh vX.Y.Z`
  automatiserar detta — defer till v0.8.0+)

## SKILL-DISCOVERIES.md — backup-path

Bara för "spara för senare" eller fall där
användaren är mitt i något kreativt och inte
vill bryta flowet. Vid nästa naturliga break
(fas-slut, ⌘S handshake, slut av pair-test-
cykel): säg "N kandidater i SKILL-DISCOVERIES.md.
Kör /review när du är redo."

För read-only kollegor (utan push-access):
discoveries stannar i SKILL-DISCOVERIES.md
tills någon med push-access flyttar över dem.
Vid flytt: CHANGELOG-prepend görs i samma
commit-cykel.

## Aldrig

- Klientnamn eller projektspecifika värden
- Hypoteser som inte verifierats empiriskt
- Saker som redan finns i references/
- Auto-push till main
- Discovery-ask för saker som inte
  passerat grep-check (annars blir det brus)
- Discovery-commit utan CHANGELOG-prepend
  (alltid båda eller ingen)

## Repo-status

Temporärt: github.com/niklazhallberg/lens-studio-snapchat-filter-skill
Planerat: Valtech-organisationskonto (TBD)

När migrering sker: uppdatera remote-URL i
onboarding-diagnosen och i denna fil.

## Changelog

- v0.4 → v0.5 (2026-05-14): warm-tone CHANGELOG-format.
  In-flow-ask-template omskriven till plain svenska utan
  jargong (no grep, no "discovery"-ord, no API-paths i
  första meddelandet). Format-för-entry får nytt "Värde
  för användare"-fält (obligatoriskt). CHANGELOG.md-spec:
  section-titel ändrad från `[Unreleased]` till
  `Improvements and newly acquired knowledge`; entry-rubrik
  får 💡-emoji + `HH:MM`-timestamp; description ska vara
  plain svenska; nytt `Value for user:`-fält per entry.
  Triggad av Niklaz observation att tidigare protokoll-
  template var för teknisk och bröt mot voice-and-pedagogy
  principen om att translatera jargon.
- v0.3 → v0.4 (2026-05-14): Generaliseringsregeln
  som explicit omskrivningssteg. Tre steg
  (identifiera kärnan → ta bort projektspecifikt
  → "nästa kollega"-test). Tidigare bara "undvik
  projektspecifikt" i Aldrig-listan; nu en
  fullständig metodologisk regel som körs INNAN
  in-flow ask. Triggad av Niklaz observation att
  generaliseringsregeln var för svag.
- v0.2 → v0.3 (2026-05-14): CHANGELOG.md som
  obligatorisk del av varje discovery-commit;
  entry-format auto-extraherat; per-release
  konsolidering till [vX.Y.Z]-sektion.
  Triggad av Niklaz idé om kumulativ historik
  för all skill-tillväxt över tid.
- v0.1 → v0.2 (2026-05-14): in-flow ask som
  default istället för silent-capture-batched.
  Discovery surfaced direkt när färsk i minnet,
  ej vid sessionsslut. SKILL-DISCOVERIES.md
  blir backup-path för "spara för senare",
  ej primärflöde. Triggad av Niklaz observation
  att agenten inte vet när sessions slutar.
