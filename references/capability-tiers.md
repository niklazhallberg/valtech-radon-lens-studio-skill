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

### Tier 1 nuance: "Easy Lens X" features ≠ MCP-scriptable (LS 5.21+)

"Easy Lens X" labels in the LS 5.21 changelog (https://ar.snap.com/download) — Easy Lens Button, Easy Lens Blur, Easy Lens Colored Background, Easy Lens 2D Physics, Easy Lens SFX library, etc. — are **panel-level features inside the Easy Lens / AI Creator UI**, not Tier 1 via CC. CC cannot drive the Easy Lens panel via MCP.

What stays Tier 1 (CC can script directly):

- **Underlying primitive CustomComponents** that the panel wraps. Empirical example: "Easy Lens Button" wraps `Button` v1.0.1 (Asset Library), which CC can install + script. The same pattern likely applies to other Easy Lens features (verify per-feature via `SearchLensStudioAssetLibrary` + install + probe).
- **Native presets already in the preset registry** that share the feature name. Example: "Easy Lens Blur" overlaps with `GaussianBlurPreset` (native, scriptable via scene-graphql).

What drops out of Tier 1 (Inspector / designer task, not CC):

- **Panel-level visual tuning** — shape pickers, color swatches, pressed-behavior previews, in-canvas drag handles in the Easy Lens UI. Hand off to the user via Inspector / Easy Lens panel.

When a brief uses "Easy Lens X" language, decompose into "scriptable primitive surface" (Tier 1 via CC) and "visual tuning surface" (Inspector handoff). Don't promise the Easy Lens panel UX via CC.

See `lens-studio-api-gotchas.md` → "Easy Lens panel features vs MCP-scriptable primitives" for the empirical Button v1.0.1 surface and the `animtionType` typo'd-key gotcha.

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

> "The filter you describe actually can't be produced with standard Lens Studio — not for us, not for any normal agency. [Reference] required specialized AI tools that Snap built internally, with resources that aren't available outside Snap. What we can build is: [Tier 1 proposal]. Want us to move forward with that?"

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
