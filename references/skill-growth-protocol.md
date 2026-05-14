# Skill Growth Protocol v0.3

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

## In-flow ask — default

När en discovery passerar grep-checken:
säg DIREKT till användaren, mitt i flowet.

Template:

> "Vi har en discovery: [en mening, vad det är].
> Den regeln finns inte i [relevant fil]
> (jag kollade). Skriv in i skillen?
> Detta gör skillen bättre och hjälper
> dina kollegor (eller framtida dig) med
> bättre underlag för nästa projekt.
>
> **Ja / nej / spara för senare review.**"

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

- Vad: [en mening]
- Hur hittades: [probe-kedjan kort]
- Generaliserbar? [ja/nej + varför]
- Föreslagen text: [neutralt skriven,
  projektagnostisk]

## CHANGELOG.md — alltid del av discovery-commit

När en discovery committas (ja-path ovan):
samma commit MÅSTE inkludera en prepend till
`CHANGELOG.md` på repo-root, under sektionen
`[Unreleased]`.

Skäl: utan CHANGELOG-entry har discoveryn ingen
kumulativ synlighet — den finns bara i git log.
CHANGELOG är skill:ens biografi för icke-tekniska
läsare (designers, PMs, leadership).

Entry-format (auto-extraherat av agent):

```markdown
### YYYY-MM-DD — [project: <cwd-derived>]
- **<title>**: <one-sentence description>
- File: `<path>` § <section>
- Type: [discovery]
```

Auto-extraction:
- `YYYY-MM-DD` — current date
- `<cwd-derived>` — från `$PWD`
  (`~/Projects/<name>-lens` → `<name>-lens`)
- `<title>` — kort summary
- `<description>` — en mening från
  "Vad:"-fältet i discovery-entryn
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
