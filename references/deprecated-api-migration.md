# Deprecated LS API → Modern Replacement Migration

Translation table for legacy Lens Studio APIs that still appear in forum threads, old sample projects, AI-generated code trained on pre-2024 docs, and 4.x project ports. When a colleague pastes code containing any pattern in this file, translate it to the current 5.x equivalent before running it.

**Authoritative source**: https://developers.snap.com/api/lens-api-deprecation — if there's any conflict between this file and the live page, the live page wins.

## Why this matters

- **LS 5.8.0+** shows deprecation warnings on these APIs at runtime / in the Logger.
- **A future LS release will hard-block** them (Snap has signalled this on the deprecation page).
- Lenses built on deprecated APIs may **fail Sponsored Lens submission review** if the reviewer's LS instance refuses to open them.
- LS 5.20+ continues to enforce the same deprecation list (no additions known as of Perplexity research 2026-05).

If the agent unknowingly produces deprecated patterns (e.g. echoing a forum snippet), the colleague's lens will collect warnings, may break on a future LS update, and may fail submission. Catch it at paste time.

## Migration table

| Deprecated | Current replacement | Notes |
|---|---|---|
| `Animation` (class) | `AnimationPlayer` | Whole animation system reworked — not a one-line rename. |
| `AnimationMixer`, `AnimationMixerLayer` | `AnimationPlayer` + `AnimationAsset` + `AnimationTrack` | Mixer-less architecture; tracks play directly. |
| `AnimationClip.playbackSpeed` (via mixer) | `AnimationTrack.playbackSpeed` | Speed is per-track now, not per-layer. |
| `BlendShapes` (standalone component) | `RenderMeshVisual.blendShapesEnabled` (property) | No separate component anymore — toggle on the mesh visual. |
| `Camera.enableClearColor` | `ColorRenderTarget.clearColorOption` | Moved off the camera onto the render-target. |
| `SceneObject.getAllComponents()` | `SceneObject.getComponents()` | Returns array; iterate normally. |
| `SceneObject.getFirstComponent("Component.X")` | `getComponent(ComponentType)` or `getComponents()[0]` filtered by typename | String-typed lookup is gone — use typed accessor. |
| `SceneObject.getComponentByIndex(i)` | `SceneObject.getComponents()[i]` | Array index access. |
| `ScriptComponent.api` (per-script wrapper) | `global.api`, or expose surface via `@input` decorators on a typed class | The per-script `api` object is no longer the pattern. |
| `VideoTextureProvider.getStatus()` (method) | `VideoTextureProvider.status` (property) | Property access — drop the parentheses. |
| `VideoTextureProvider.setOnReady(cb)` | `VideoTextureProvider.onPlaybackReady` (event) | Subscribe to the event instead of a one-shot callback. |

## Code translation examples

### `getFirstComponent` → typed `getComponent`

```typescript
// Deprecated (string-typed lookup)
const visual = script.getSceneObject().getFirstComponent("Component.MeshVisual");

// Current (typed)
const visual = script.getSceneObject().getComponent(MeshVisual.getTypeName());
```

If you only have a string typename available (e.g. from data), filter the array:

```typescript
const visual = script.getSceneObject()
  .getComponents()
  .find(c => c.getTypeName() === "Component.MeshVisual");
```

### `script.api` → `@input` decorators

```typescript
// Deprecated
script.api.setForm = function (idx) { /* ... */ };
script.api.value = 42;

// Current — declare on a decorated class
@component
export class FormController extends BaseScriptComponent {
  @input value: number = 42;

  setForm(idx: number) { /* ... */ }
}
```

The clean 5.x pattern is: every public surface a script wants to expose is either an `@input` (editor-tunable) or a method on the decorated class (callable from other scripts via `getComponent` + cast).

### Animation system

The old triad `Animation` + `AnimationMixer` + `AnimationLayer` collapses to three concepts:

- **`AnimationAsset`** — the data (the curves)
- **`AnimationTrack`** — what plays, with per-track speed/blend
- **`AnimationPlayer`** — the component bound to the SceneObject that drives playback

No clean one-line translation — when porting old animation code, redesign around the player and tracks instead of mixer-layers. See current Snap docs at `https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.AnimationPlayer.html`.

### `VideoTextureProvider` readiness

```typescript
// Deprecated
provider.setOnReady(() => { /* video ready */ });
if (provider.getStatus() === VideoStatus.Playing) { /* ... */ }

// Current
provider.onPlaybackReady.add(() => { /* video ready */ });
if (provider.status === VideoStatus.Playing) { /* ... */ }
```

## When to apply this migration

Translate to current API the moment any of these triggers:

- Code pasted from a Snap **community forum** thread older than ~12 months
- Code pasted from **`Snapchat/lens-studio-templates`** (the abandoned GitHub repo; targets LS 2.3)
- Code pasted from **`FrozenAtlas/OLC-Repo`** or other community grab-bags (mostly LS 4.x)
- Code from **AI tools trained on pre-2024 LS docs** (Cursor, Copilot, ChatGPT may all default to deprecated patterns)
- **LS 4.x project ports** — the developer.snap.com migration page is the authoritative checklist
- **Snap's own legacy sample projects** that haven't been migrated

If you spot deprecated code that the colleague wants to use as-is, say so explicitly and offer the modern translation — don't silently rewrite.
