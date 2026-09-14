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

## Capability matrix — common requests by body-part and intent

Use this matrix when triaging a brief. Each row is a typical lens
feature request; the columns split it by tier. The matrix is **silent
brief analysis** — never copy/paste to the client. CC scans it, locks
the tier internally, and either confirms feasibility (Tier 1/2) or
moves to the Tier 3 honest-language response.

### Face

| Request | Tier | Why |
|---|---|---|
| Face tint / color filter | 1 | RetouchVisual + LUT |
| Eye color swap | 1 | Eye texture material on Face Inset |
| Makeup overlay (lipstick, blush, eyeshadow) | 1 | Texture overlay on FaceMesh region UVs |
| Face accessory (hat, glasses, mustache) — 2D | 1 | PNG/sprite anchored to head + landmark |
| Face accessory — 3D model | 2 | Client/3D artist provides FBX/glTF |
| Liquify / stretch / squish | 1 | FaceLiquifyVisual with preset + custom params |
| Eye expand / mouth distortion (cartoon) | 1 | FaceLiquify preset variants |
| Full face transformation into character (Na'vi-style) | 3 | Snap-internal GAN |
| Age / gender swap (realistic) | 3 | Snap-internal segmentation + GAN |
| Beauty filter equivalent (skin smoothing, jaw narrowing) | 3 | Snap proprietary |
| Toon / cartoon shading on real face | 2-3 | Custom material possible (Tier 2 if 2D shader); fully convincing 3D toon is Tier 3 |
| Face swap with another face | 3 | Requires Snap-internal pipeline |

### Body

| Request | Tier | Why |
|---|---|---|
| Hand-anchored 2D overlay | 1 | Hand Tracking + sprite |
| Hand-anchored 3D object | 2 | Hand Tracking + external 3D asset |
| Body silhouette outline | 2-3 | Body segmentation is Tier 2 in LS 5.21+ via prebuilt template; custom mask is Tier 3 |
| Foot-anchored sneaker / shoe | 1-2 | Foot Tracking + `Try-On Pack Sneakers` template; client model = Tier 2. Calibration is hard — see foot-tracking gotcha |
| Full-body 3D outfit replacement | 3 | Requires body mesh fitting Snap doesn't expose |
| Hair color / replacement | 3 | Hair segmentation is Snap proprietary |

### Environment / world

| Request | Tier | Why |
|---|---|---|
| 2D image background swap | 1 | Background Segmentation + image |
| Animated background loop | 1 | Background Segmentation + video texture |
| 3D object placed via world tap | 1 | World Mesh Tracking + native preset |
| World mesh occlusion (object hides behind real object) | 2 | World Mesh + custom material |
| Realistic 3D scene replacement | 3 | Requires depth/scene reconstruction Snap doesn't expose |

### UI / interaction

| Request | Tier | Why |
|---|---|---|
| Tap to reveal text / image | 1 | InteractionComponent + tween |
| Random fortune / quiz / reroll | 1 | JSON asset + script (RFSU BANG = reference) |
| Slot machine / scrolling reel | 1 | Script-based clipping + tween (see `lens-recipe-catalog.md` D-13 + masking gotcha) |
| Drag-to-rotate / drag-to-pan | 1 | TouchSystem + ScreenTransform math |
| Multi-step UI flow (3+ screens) | 1 | Script state machine + tween between layouts |
| Real-time multiplayer / share state with friend | 3 | Snap Connected Lenses is partner-only |

### Audio

| Request | Tier | Why |
|---|---|---|
| Preset SFX on tap / event | 1 | AudioComponent + asset |
| Custom voice / music (royalty-free) | 1-2 | Client provides licensed audio = Tier 2 |
| Licensed music (Snap library) | 1 | Snap's music library via Asset Library (LS 5.21+ surface) |
| Voice-controlled trigger | 2 | Voice ML template, may need custom tuning |
| Real-time pitch/voice modulation | 2 | Audio FX components, but full vocoder is Tier 3 |

### Visual effects

| Request | Tier | Why |
|---|---|---|
| Particles (sparkles, hearts, confetti) | 1 | VFX Editor with preset emitter |
| Custom-look particle (branded shape) | 1-2 | Client provides art = sprite-based Tier 1; custom mesh = Tier 2 |
| Color grade / LUT | 1 | Material Editor + LUT texture |
| Custom material (stylized look) | 1 | Material Editor graph |
| Animated text reveal | 1 | Text3D Animator block (5.21+) or TweenTransform fallback |
| Glitch / VHS / film effect | 1 | Native preset OR Material Editor graph |
| Realistic physics (cloth, fluid) | 2-3 | 2D physics is Tier 1 (Easy Lens 2D Physics in 5.21+); cloth/fluid 3D physics is Tier 3 |

### ML / AI

| Request | Tier | Why |
|---|---|---|
| Object detection on existing class (face, body, hand) | 1 | Native tracking |
| Custom object detection (specific product) | 2 | Client provides trained `.dnn` |
| GenAI 3D body / character | 2 | GenAI Body Generator (5.21+) creates the asset; integration is Tier 2 |
| GenAI face transformation | 3 | Snap-internal |
| Style transfer | 3 | Snap-internal |
| Pose detection (yoga, dance reps) | 2 | Body Pose ML template; production tuning may be Tier 2 |

### How to use this matrix

1. Read the brief and underline the visual outcomes.
2. Map each outcome to a row (or the closest row).
3. If any outcome is Tier 3, run the honest-language response.
4. If all outcomes are Tier 1/2, confirm the asset gap for any Tier 2 items.
5. If a row is Tier 1-2 ambiguous (e.g., "custom-look particle"),
   clarify with the user — "do you have art for this, or do we make
   it from scratch?"

### Notes on the matrix's freshness

- LS 5.21+ surfaces shift the line between Tier 1 and 2 in some places
  (GenAI tools moving more capability into the editor itself). Re-check
  Snap's release notes when a feature near the boundary comes up.
- This matrix reflects what an external agency with standard LS + MCP
  can produce. Snap-internal teams and partners may have access to
  features marked Tier 3.

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
