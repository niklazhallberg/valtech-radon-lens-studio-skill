# docs/ — publik mapp

**⚠️ Allt i denna mapp serveras live på Netlify-URL:en.**

Det betyder: vem som har URL:en kan läsa filerna här. URL:en är inte offentligt listad (delas riktat via Slack/mejl), men det finns ingen autentisering på Netlifys gratisplan. Behandla `docs/` som "halv-publik".

## Vad som hör hemma här

- HTML-manualer som kollegor ska kunna läsa innan de installerar skill:en (Steg 0 i onboarding).
- Statiska assets som manualerna refererar till (`assets/fonts/`, ev. bilder).
- Markdown som är OK att vara nåbar med en URL.
- `_redirects` — Netlify path-rewrites.
- `index.html` — router-sidan som listar de tre manual-varianterna.

## Vad som INTE hör hemma här

- `skill.md`, `CHANGELOG.md`, `project-info/` — lärdomar och intern dokumentation. De ligger en nivå upp.
- `ONBOARDING-SNIPPET.md` — interna Slack-mallar. Ligger i repo-roten.
- `references/snap-docs/` — 365 sidor mirror av Snaps docs, för stor och delvis känslig. Stannar utanför.
- Säljmaterial, klient-specifikt content, kommersiellt känslig data.

## Path-struktur (Netlify rewrites)

| URL-path | Källfil | Tonläge |
|----------|---------|---------|
| `/` | `index.html` | Router — välj manual |
| `/en/` | `MANUAL-EN.html` | Engelska, full guide för förstagångare |
| `/sv/` | `MANUAL.html` | Svenska, full guide för förstagångare |
| `/advanced/` | `MANUAL-SIMPLE.html` | Engelska, kortform för tekniska användare |

Path-rewrites styrs av `_redirects`-filen.

## Innan du commitar filer till docs/

Stanna upp och fråga: *"är det här OK att en kollega utanför Valtech ser om URL:en läcker?"*. Om svaret är nej eller "vet inte" — flytta ut.
