# Bitmoji Integration (LS 5.20+)

API surface, scripting patterns, and rules for integrating Snapchat users' Bitmoji avatars into lenses. Covers Bitmoji 2D (textures), Bitmoji 3D (rigged avatars), Bitmoji Head (face-mirroring head), Bitmoji Face Animator (emotion states), and the Bitmoji 3D animation pipeline.

Compiled 2026-05-20 from Snap's official Bitmoji Avatar documentation.

## CRITICAL: Bitmoji is NOT allowed in Sponsored Lenses

**Snap's explicit rule** (from Bitmoji 3D documentation): *"Bitmoji avatars cannot be used for commercial purposes, including Ads."*

**Implication for the agent**: When a Sponsored Lens brief mentions Bitmoji — "let's use the user's Bitmoji to make it personal" — the agent MUST flag this at Phase 0. Bitmoji is for **organic / community lenses only**. Common mistake: brand teams see Snap's own marketing showcasing Bitmoji and assume it's available for ads. It isn't.

**Re-scoping options the agent can offer**:
- Use a generic stylised character that resembles a "Bitmoji vibe" but is owned by the brand
- Use Face Mesh / Face Effects to drive a branded character via the user's expressions
- Use the GenAI Suite or Face Generator for a personalised but non-Bitmoji avatar
- Reserve the Bitmoji concept for organic / community-lens distribution outside the ad campaign

See `sponsored-lens-submission.md` → "Bitmoji not allowed in Sponsored Lenses" for the canonical rule.

For **organic / community lenses**, Bitmoji is freely available — the rest of this file covers the technical integration.

## Contents

1. API surface — modules and components
2. Bitmoji 2D
3. Bitmoji 3D
4. Animating Bitmoji 3D — Maya / Blender / Mixamo pipelines
5. Bitmoji Face Animator
6. Bitmoji Head (face-mirroring)
7. Cross-recipe applications (organic lenses only)
8. Common gotchas
9. Cross-references

## 1. API surface

### Core modules

| Module | Purpose |
|---|---|
| `UserContextSystem` | Accesses current user, friends, MyAI avatars |
| `BitmojiModule` | `requestBitmoji2DResource()`, `requestBitmoji3DResourceWithOptions()` |
| `RemoteMediaModule` | Async fetches the resource as Image Texture (2D) or glTF Asset (3D) |
| `Friends Component` | Accesses friends' `SnapchatUser` data |

### Bitmoji components / assets

| Asset | Use |
|---|---|
| Bitmoji 2D | 2D texture stickers (Screen Image-based) |
| Bitmoji 3D | Fully-rigged 3D avatars |
| Bitmoji Head | Face-mirroring head-only avatar |
| Bitmoji Face Animator | 10 predefined emotion states with blending |
| Bitmoji Attachment Props | Wearable objects on the avatar |
| Bitmoji Suite Plugin | Editor-side: clothes customisation, animation creation, prop generation |
| Friends Component | Access friends' data for friend-Bitmoji UX |

### Snapchat login dependency

ALL Bitmoji access requires the user to be **logged into Snapchat** in Lens Studio (`My Lenses → Login`). Without login, all requests fail silently or return placeholder data.

## 2. Bitmoji 2D

### What it is

A 2D texture of the user's Bitmoji, applied to a Screen Image. There is **no dedicated "Bitmoji 2D" prefab** — instead you create a Screen Image and load the texture via script.

### Install + scene setup

1. `+` in Scene Hierarchy → `Screen Image`
2. Attach a script that calls `BitmojiModule.requestBitmoji2DResource()` and binds the result to the Screen Image's texture

### Script pattern (load own Bitmoji as Screen Image)

```typescript
const options = Bitmoji2DOptions.create();
userContextSystem.getCurrentUser((user) => {
  options.user = user;
  bitmojiModule.requestBitmoji2DResource(options, (bitmoji2DResource) => {
    remoteMediaModule.loadResourceAsImageTexture(
      bitmoji2DResource,
      (texture) => {
        screenImage.mainPass.baseTex = texture;
      },
      (error) => { /* fallback */ }
    );
  });
});
```

### Editor limitation + mandatory fallback

> *"You will only see the 2D Bitmoji on device, that's why a placeholder texture field is provided."*

In LS Preview, the actual 2D texture cannot be retrieved. **A fallback texture is mandatory** — assign a generic Bitmoji-shaped placeholder in the editor so design QA can proceed. Skipping the fallback = invisible content in Preview.

### Common pitfalls

- No fallback texture → invisible in Preview, can pass review but breaks the brief
- Missing Snapchat login → no data, no error
- Async loading not handled → reading `mainPass.baseTex` immediately returns null

## 3. Bitmoji 3D

### Install

Asset Library → search `Bitmoji 3D` → Install → drag into Scene Hierarchy.

### Script pattern

```typescript
const options = Bitmoji3DOptions.create();
options.user = currentUser;
bitmojiModule.requestBitmoji3DResourceWithOptions(options, (bitmoji3DResource) => {
  remoteMediaModule.loadResourceAsGltfAsset(
    bitmoji3DResource,
    (gltfAsset) => { /* bind to MeshVisual */ },
    (error) => { /* fallback */ }
  );
});
```

The resource comes back as glTF.

### Scale + visibility gotcha

If the Bitmoji is invisible on first load: **set the parent object's scale to `100, 100, 100`**. This is a documented gotcha — Bitmoji 3D ships at a non-default unit scale relative to LS scene units.

### Performance cost — IMPORTANT

> *"Each next Bitmoji asset significantly affects lens load time and overall performance."*

- 1 Bitmoji 3D: tolerable, accept the load-time hit
- 2+ Bitmoji 3D: significant degradation on mid-range devices
- Many Bitmoji 3D in one lens: avoid — re-scope to 2D where possible

**Concrete agent guidance**: if a brief calls for "show me + my 5 friends as Bitmoji 3D characters", push back — propose 2D for the friends + 3D only for the user.

### Sponsored Lens

Not allowed — see "CRITICAL" section at top.

## 4. Animating Bitmoji 3D — Maya / Blender / Mixamo

Three supported animation pipelines:

### Autodesk Maya (professional rig)

- Use Snap's proprietary Maya rig with advanced controls
- Set scene to **30 FPS**
- Minimum animation length: 2 frames (frames 0-2)
- Export to `.fbx` (preferred) or `.glb` using Snap's converter script
- When **importing `.glb` into LS**: disable "Use Legacy Importer" and disable "Convert Meters to Centimeters"

### Blender (community pipeline)

- Compatible with Blender 4.3.2 on macOS + Windows
- Generates `.fbx` for the body animation
- Optional `_prop.fbx` for separate prop animations on the same skeleton

### Mixamo (third-party library)

- Upload Snap's custom-provided `.fbx` skeleton model to Mixamo
- Download any Mixamo animation applied to that skeleton
- Output `.fbx` only (static 1-frame poses currently unsupported)
- In LS: enable **`Adapt to Mixamo`** checkbox on the Bitmoji 3D component

### LS import workflow (all sources)

1. Drag animation file(s) into Asset Browser
2. Add Bitmoji 3D component to scene object
3. Add **Animation Player** component (NOT deprecated `AnimationMixer`)
4. Select animation clip via `Add Clip`
5. Set Animation Player blend mode to `Default` (not `Additive`)

### Animation State Manager (optional)

For multi-clip blending (idle / walk / run), install `Animation State Manager` from Asset Library — provides easy state-machine control without custom script.

### Common pitfalls

- Using deprecated `AnimationMixer` → migrate to `AnimationPlayer` per `deprecated-api-migration.md`
- 1-frame static poses from Mixamo → not supported, animate at least 2 frames
- Skipping `Adapt to Mixamo` checkbox → skeleton mismatches, no animation transfer
- Wrong `.glb` import flags → broken scale or wrong unit conversion

## 5. Bitmoji Face Animator

### What it is

Drives Bitmoji 3D facial expressions through 10 predefined emotion states with smooth blending. Like a state machine for emotion playback.

### Install

Asset Library → `BitmojiFaceAnimator` → Install. Add via `+` button in Asset Browser. **Must be on the same SceneObject as the Bitmoji 3D component.**

### Emotion states (complete list, 10)

`Idle`, `Happy`, `Laughing`, `Angry`, `Confused`, `Amused`, `Curious`, `Scared`, `Sad`, `Crying`

### Script API

```typescript
// Generic setter
faceAnimator.setState(stateName: string, transitionDuration: number): void;

// Convenience methods
faceAnimator.setStateHappy();
faceAnimator.setStateAngry();
faceAnimator.setStateCrying();
// ... one per emotion state

// Inspect
faceAnimator.getState(): string;
```

### Behaviour

- `Transition Duration` (seconds) controls blend time between emotions; defaults apply if unspecified per-call
- `Return to Idle` toggle: when on, non-idle animations play once then revert to `Idle`

### Common pitfalls

- Place `BitmojiFaceAnimator` AFTER the main Animation Player if overriding existing face animations — otherwise the main player will overwrite
- Camera Kit support is "limited" — flag for any non-Snapchat distribution brief

## 6. Bitmoji Head (face-mirroring)

### What it is

Bitmoji **head-only** avatar that mirrors the user's facial expressions in real time via face tracking. Use case: "make a Bitmoji react with the user's actual face" — a personalised reaction-cam effect.

### Install

Asset Library → search `Bitmoji Head` → Install → add via `+` button.

### Required configuration

- **Bitmoji 3D** reference (Bitmoji Head depends on Bitmoji 3D being in the scene)
- **Camera** reference
- **`Attach To Head`** toggle — when on, head auto-attaches and follows the user's head movements (face tracking required)
- **`Rotate Head`** — alternative when `Attach To Head` is off

### Critical gotchas

- **Render Layer mismatch**: Bitmoji Head MUST share the same render layer as Bitmoji 3D — otherwise conflicting lighting sources cause overlighting
- **Hierarchy order**: The Bitmoji 3D object MUST be placed **above** the Bitmoji Head object in Scene Hierarchy
- Face tracking is a hard dependency — without face detection, the head doesn't animate

## 7. Cross-recipe applications (organic lenses only)

Bitmoji integrations the agent can compose for **organic / community lenses** (NOT Sponsored):

- **"Personality quiz that shows your Bitmoji"** = `lens-recipe-catalog.md` D-2 Quiz + Bitmoji 2D for result reveal
- **"Friend-tag lens"** = Bitmoji 2D + Friends Component to show friends' Bitmoji
- **"Reaction-cam with my Bitmoji mirroring my expressions"** = Bitmoji Head + face tracking + emotion mapping
- **"Multi-friend group photo"** = Bitmoji 3D (one for user) + Bitmoji 2D (others) under Ortho cam grid
- **"Bitmoji dance party"** = Bitmoji 3D + Animation Player + Mixamo dance animation + Beat Sync from `audio-in-lenses.md`
- **"Animated head reacts to score"** = Bitmoji Face Animator + score-event Behavior wiring
- **"User and friends as 3D characters in a mini-game"** = Bitmoji 3D + Character Controller (Games Suite) + Leaderboard (recipe D-6)

For **Sponsored Lens** equivalents of these patterns: do NOT use Bitmoji. Re-scope to brand-owned characters or Face Mesh-driven branded avatars.

## 8. Common gotchas across the Bitmoji surface

- **Snapchat login is required** for all Bitmoji data — `My Lenses → Login` in LS
- **Async loading** — Bitmoji resources load asynchronously via `RemoteMediaModule`; design UI around loading states (placeholder texture, spinner, "loading your Bitmoji…")
- **No Bitmoji fallback** — if the user has not created a Bitmoji or denies access, Snap doesn't document explicit fallback behaviour. **Build your own** — detect null Bitmoji response and show a generic placeholder + optional CTA to "Create your Bitmoji"
- **Editor placeholder during Preview** — Bitmoji 2D and 3D show placeholder content in LS Preview, never the actual user's avatar. Always test on device
- **Camera Kit support is limited** — for any brief targeting Camera Kit distribution (lens in client's own app), flag that Bitmoji may not render correctly
- **Performance cost compounds with multiple Bitmoji 3D** — re-scope to 2D for non-primary avatars

## 9. Cross-references

- `sponsored-lens-submission.md` → "Bitmoji not allowed in Sponsored Lenses" (canonical rule)
- `lens-recipe-catalog.md` → D-6 LeaderboardInfo references Bitmoji image slots (organic-lens use)
- `deprecated-api-migration.md` → AnimationMixer → AnimationPlayer migration applies to Bitmoji 3D animation pipeline
- `lens-studio-api-gotchas.md` → Asynchronous asset loading patterns (RemoteMediaModule) follows same race-condition principles as `requireAsset()` gotcha
- `audio-in-lenses.md` → Beat Sync for Bitmoji dance / music-reactive avatar briefs
- `asset-library-guide.md` → Bitmoji 3D / Face Animator / Head install paths all go through Asset Library

## Adding new findings

When a Valtech project surfaces a Bitmoji behaviour not in this file:

1. **Pattern** — one sentence
2. **Lens type** — organic / community (Sponsored is blocked per Snap rule)
3. **Source** — Snap docs URL or empirical record
4. **Confidence** — official-docs / multi-source / single-source / valtech-validated
