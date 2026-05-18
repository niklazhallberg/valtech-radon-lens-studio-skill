# Säkerhet och sekretess

> Detta dokument beskriver hur skillen `valtech-radon-lens-studio-skill` hanterar säkerhet, sekretess och kunddata. Tänkt att läsas av säkerhets-, legal- eller compliance-ansvariga inom Valtech RADON — eller den kollega som vill förstå hur projektdata isoleras från skill-repot. Originalkällan är `docs/VALTECH-PRESENTATION.md` sektion 5; här bryts den ut för att kunna granskas och delas isolerat.

## Vad lagras i skill-filen?

**Finns i repot:**

| Typ | Innehåll | Risknivå |
|---|---|---|
| Snaps publika dokumentation | 365 markdown-sidor mirrored från `developers.snap.com` | Noll — redan publikt |
| Empiriska protokoll | `body-anchored-calibration.md`, `lens-studio-api-gotchas.md` etc. — generaliserade mönster, **inga projektspecifika värden** | Noll — Generaliseringsregeln säkrar detta (se nedan) |
| MCP tool schemas | Tekniska API-signaturer för Lens Studio MCP-server | Noll — teknisk info, ej känslig |
| Voice-principer | Pedagogiska riktlinjer på svenska | Noll — metodologi, inte data |

**Finns INTE i repot — bekräftat genom genomgång:**

- ❌ Inga klientnamn i empiriska protokoll
- ❌ Inga projektspecifika värden (X-koordinater, kampanjbudgetar, leveransdatum)
- ❌ Inga personuppgifter
- ❌ Ingen Valtech-intern affärsinformation
- ❌ Inga API-nycklar, tokens, credentials

## Generaliseringsregeln som aktiv säkerhetsmekanism

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

Protokollet kan granskas i [`references/skill-growth-protocol.md`](../references/skill-growth-protocol.md) rad 18–82.

## Repo-säkerhet

| Aspekt | Status idag |
|---|---|
| Repo-typ | **Privat GitHub-repo** |
| Access idag | Begränsad — på personligt GitHub-konto hos underhållaren |
| Plan | Migrera till Valtech-organisationskonto |
| Framtid | `@valtech.com` SSO-autentisering |
| Auto-push | **Avstängt** — varje push kräver explicit godkännande |

Migration till Valtech-org är en öppen punkt i [VALTECH-PRESENTATION.md sektion 7](VALTECH-PRESENTATION.md#7-rekommenderade-nästa-steg).

## Vad händer med kunddata under ett projekt?

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

## Jämförelse med alternativet

Risken om Valtech **inte** har ett system som detta:

| Risk utan skill | Konsekvens |
|---|---|
| Designers googlar fritt | Okontrollerade källor, okontrollerade kodsnuttar in i kundprojekt |
| Kunskap stannar hos individen | Om personen är otillgänglig → tyst dataförlust |
| Slack-trådar som "wiki" | Sökbar bara av interna, inget audit-trail, inget format-skydd |
| Inget audit-trail på lärdomar | Ingen synlighet i vad agenten lär sig från projekt till projekt |

**Skillen är inte en ny säkerhetsrisk — den är en strukturerad lösning på en risk som redan existerar.**
