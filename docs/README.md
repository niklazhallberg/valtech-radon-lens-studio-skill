# docs/ — publik mapp

**⚠️ Hela repo:t är publikt — inte bara den här mappen.**

Repositoriet är publikt under Valtech RADON-organisationen. Vem som helst kan läsa alla filer i repo:t (inklusive `references/`, `CHANGELOG.md`, m.m.). Historiskt var det bara `docs/` som exponerades via Cloudflare, men efter enterprise-migreringen är hela repo:t offentligt.

Behandla **hela repo:t** enligt reglerna nedan — inte bara `docs/`.

## Vad som hör hemma i docs/ specifikt

- HTML-manualer som kollegor ska kunna läsa innan de installerar skill:en (Steg 0 i onboarding).
- Statiska assets som manualerna refererar till (`docs/assets/fonts/`, ev. bilder).
- Markdown som är OK att vara nåbar med en URL.
- `_redirects` — path-rewrites (Cloudflare-syntax, identisk med Netlify).
- `index.html` — router-sidan som listar de tre manual-varianterna.

## Vad som INTE hör hemma i repo:t (någonstans)

Eftersom hela repo:t är publikt gäller den här regeln överallt, inte bara i `docs/`:

- Klient-konfidentiell information (klientnamn i konkreta kontexter, brief-detaljer, kampanjbudgetar).
- Personuppgifter.
- Credentials, API-nycklar, tokens.
- Icke-godkända tredjeparts-material.
- Säljmaterial, klient-specifikt content, kommersiellt känslig data.

Se `NOTICE.md` i repo-roten för den fullständiga internal-use-noteringen.

## Path-struktur (rewrites)

| URL-path | Källfil | Tonläge |
|----------|---------|---------|
| `/` | `index.html` | Router — välj manual |
| `/fullguide-en` | `MANUAL-EN.html` | Engelska, full guide för förstagångare |
| `/fullstandigguide-sv` | `MANUAL.html` | Svenska, full guide för förstagångare |
| `/nosmalltalk` | `MANUAL-SIMPLE.html` | Engelska, kortform för tekniska användare |

Path-rewrites styrs av `_redirects`-filen.

> **TODO (enterprise migration):** Bekräfta att `_redirects`-syntaxen fungerar på den kanoniska Valtech RADON-hostingdomänen (som ännu inte är levererad).

## Innan du commitar

Fråga: *"är det här OK att alla på internet kan läsa?"* — inte bara *"är det OK att en kollega ser?"*. Om svaret är nej eller "vet inte" — commit:a inte.
