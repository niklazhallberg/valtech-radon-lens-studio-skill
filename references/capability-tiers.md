# Capability tiers

**Internal CC reference.** Never present tiers as a menu to clients. Use silently to detect impossible briefs early.

## Purpose

When CC detects Tier 3 in a client brief, respond honestly and directly — never imply Tier 3 is possible with more budget. Immediately propose a concrete Tier 1 alternative.

## Tier 1 — Fully generatable

CC handles everything. No external assets needed beyond client logo / brand fonts.

Examples:
- 2D face overlays, color tints, eye texture swaps
- Tap-interactions with text/image reveals
- Fortune / quiz / horoscope lenses (RFSU BANG = reference ✅)
- Text + custom font lenses, simple particles
- Basic face tracking with image overlays

**Build time**: 3-5 days.

## Tier 2 — Generatable, requires external asset

CC handles all code and scene work. Client (or external specialist) provides the asset.

Examples:
- 3D object on face — requires FBX / glTF from a 3D artist
- ML effect where client provides pre-trained `.dnn`
- Licensed character as PNG overlay — client provides the file

**Build time**: 1-2 weeks (depends on asset delivery speed, not CC).

## Tier 3 — Not possible with standard agency production

Requires custom ML pipelines, Snap-internal tooling, or other resources not available to a standard agency. **No budget unlocks Tier 3 for us** — it's a "Snap could do it, we can't" boundary.

### CC honest language template

> "Det filtret du beskriver går faktiskt inte att producera med standard Lens Studio — inte för oss, inte för någon vanlig byrå. [Reference] krävde specialiserade AI-verktyg som Snap byggde internt, med resurser som inte är tillgängliga utanför Snap. Vad vi kan bygga är: [Tier 1 proposal]. Vill du att vi går vidare med det?"

### Key rules

- **Never say "with more budget"** — budget doesn't unlock Tier 3.
- **Never say "we could try"** — false hope wastes the client's time.
- **Always propose a concrete Tier 1 alternative immediately** — leave the client with a path forward, not a wall.
- **Plain language only** — not "GAN/GLSL/diffusion model" but "specialized AI tools Snap built internally and doesn't share".

### Tier 3 examples

- **Full face transformation** (Avatar Na'vi, Snap × Disney 2022)
  - Required: custom GAN, rigged 3D mesh, months of Snap-internal work with Disney's film data
  - Reference: adweek.com/social-marketing/snapchat-rolls-out-ar-lens-for-disneys-avatar-the-way-of-water/
- **Snapchat Beauty filters** — Snap proprietary, not exposed in LS SDK
- **Real-time hair segmentation + replacement** — Snap-internal ML
- **GAN-based face/age/gender transformation** — requires custom GAN training pipelines

## Scope-down patterns (Tier 3 → Tier 1)

When a Tier 3 brief comes in, propose a Tier 1 version that captures the campaign spirit without the impossible tech.

| Tier 3 request | Tier 1 equivalent (proposable) |
|---|---|
| Avatar Na'vi face transformation | Blue face tint + yellow eye texture + Na'vi skin overlay graphic + Avatar logo lockup. 1-2 day build. |
| Full face transformation into character | Strong color grade + graphic overlay + branded elements + character-themed text/sound |
| Realistic age/gender swap | Stylized cartoon "filter mode" with pre-made age cues (graphic wrinkles, color shift) |
| Snap Beauty filter equivalent | Standard `RetouchVisual` + LUT for color polish (less aggressive than Snap's proprietary version) |

## Detection signals (check client brief for these)

Phrases that should trigger Tier 3 detection and the honest-language response:

- **"Like [famous filter]"** → look up the tier of that reference before responding
- **"Transform into [character]"** → likely Tier 3 unless it's a 2D graphic overlay
- **"Replace face / skin / hair realistically"** → Tier 3 (segmentation + GAN)
- **"Like Snapchat's Beauty filter"** → Tier 3 (Snap proprietary)
- **"3D character on face" without providing 3D asset** → Tier 2-3 (asset gap → tier depends on who provides the asset)
- **"AI-generated face / hairstyle / makeup"** → almost certainly Tier 3
