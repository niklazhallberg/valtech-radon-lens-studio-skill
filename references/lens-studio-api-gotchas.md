# Lens Studio 5.x API Gotchas

Empirically-validated API surfaces and anti-patterns for Lens Studio 5.x. Each entry comes from production lens projects where the obvious or documented approach failed and the working pattern was discovered through testing.

Use this file as authoritative reference when generating production scripts. When generating LS code, cross-check against this file before trusting any API name from web search or training data.

## Contents
- Asset import (PNG → FileTexture)
- Texture binding to Image components
- Screen Image rotation (NOT localTransform)
- ScreenTransform anchor format
- Tween Manager package (must be installed)
- TweenScreenTransform type enum
- Tween cancellation semantics
- DelayedCallbackEvent cancel() actually works
- ScriptComponent inputNames auto-population
- Editor API vs Lens API separation
- Transient-view persistence pattern

---

## Asset import (PNG → FileTexture)

**Working pattern**:

```typescript
AssetManager.importExternalFile(new Editor.Path(absPath))
```

Returns a `FileTexture` asset, not a generic `Texture`.

**Anti-pattern**: Searching for `Texture` in `assetTypes` — that asset type does not exist in LS 5.x. The `FileTexture` wrapper is auto-created by LS on import; you don't construct it directly.

**Use case**: Phase 1 asset import for PNG hero objects, backgrounds, UI elements.

---

## Texture binding to Image components

**Working pattern**: Bind texture from a runtime script:

```typescript
script.image.mainPass.baseTex = texture;
```

Texture lives on the first material's `mainPass.baseTex`.

**Anti-pattern**: Trying to access texture directly on `Editor.Components.Image` — Editor-API access to image textures is brittle and uses a transient view. The runtime-script path is canonical and survives reloads.

**Use case**: Setting up Screen Images programmatically after Phase 1 asset import.

---

## Screen Image rotation (NOT localTransform)

**Working pattern**: Use `Image.rotationAngle` (degrees) for screen-space rotation:

```typescript
imageComponent.rotationAngle = 15; // degrees
```

**Anti-pattern**: Setting `sceneObject.localTransform.rotation.z`. This is 3D world rotation and has NO visual effect on Screen Images, which render in 2D screen space.

**Use case**: Tween rotation on 2D pack halves, prop tilts, UI element rotation.

**Note**: Earlier Tween table specs that listed `rotation.z` are wrong. Always use `Image.rotationAngle` for Screen Images.

---

## ScreenTransform anchor format

**Working pattern**: Anchors are a singular `Rect` with `left`, `right`, `top`, `bottom` properties in normalized coordinates (`-1` to `+1`):

```typescript
// Via setProperty with valueType: RECT
{
  left: -0.5,
  right: 0.5,
  top: 0.5,
  bottom: -0.5
}
```

**Anti-pattern**: Treating anchors as plural (`anchors`) or as separate scalar values. The API accepts a single Rect object.

**Hierarchy gotcha**: Anchor coordinates are relative to the parent's screen region. `(0, -2.0)` is only off-screen if the parent is full-screen. If the parent has its own anchor constraints, off-screen positions need different values. Test under production hierarchy, not under temporary test parents.

**Use case**: Positioning Screen Images, building tween animations between two anchor states.

---

## Tween Manager package (must be installed)

**Working pattern**: Tween Manager is NOT built into LS — install it as a package:

- Scene Hierarchy panel → `+` → Scripts → Tween Manager

After installation:
- A `TweenManager__PLACE_IN_SCENE` SceneObject appears in scene
- Nine supporting JS assets are added to project
- Do NOT delete `TweenManager__PLACE_IN_SCENE` — it's required for runtime
- The `[REMOVE_ME]` example objects shipped with the package CAN and SHOULD be deleted (per package docs)

**Anti-pattern**: Assuming `TweenScreenTransform` and `tm.startTween()` are available without package installation. Scripts will compile but fail at runtime.

**Use case**: Any scene using `TweenScreenTransform`, `TweenTransform`, or related tween components.

---

## TweenScreenTransform type enum

The `type` parameter on `TweenScreenTransform` is a numeric enum, not a string:

| Value | Meaning |
|---|---|
| 0 | Position |
| 1 | Rotation |
| 2 | Scale |
| 3 | Anchors |
| 4 | Offsets |

For `type=3` (Anchors), `AnchorsParam` is a separate enum:

| Value | Meaning |
|---|---|
| 0 | Center |
| 1 | Bounds |
| 2 | Size |

**Anti-pattern**: Passing `"Anchors"` as a string. Will not match any enum case.

**Use case**: Configuring anchor-based tweens in Phase 3 Inspector wiring.

---

## Tween cancellation semantics

**Working pattern**:

```typescript
tm.stopTween(target, name);  // halts in-flight tween
tm.resetObject(target);      // resets to original state
tm.startTween(target, name); // can start new tween cleanly
```

**Critical behavior**: When a tween is stopped via `stopTween`, the original `onComplete` callback does NOT fire. Production state machines must not rely on `onComplete` for cleanup if the tween can be cancelled. Use explicit cleanup before calling `stopTween`.

**Anti-pattern**: Treating `stopTween` as "let the current tween finish naturally." It halts immediately.

**Use case**: Reroll mechanics, interrupting animations on user input, state machine transitions.

---

## DelayedCallbackEvent cancel() actually works

**Working pattern**:

```typescript
const handle = script.createEvent("DelayedCallbackEvent");
handle.bind(() => { /* ... */ });
handle.reset(2.5); // schedule 2.5s from now
// Later:
handle.cancel(); // halts before callback fires
```

**Status**: `cancel()` is real and works. Earlier documentation hedges about needing a no-op-rebind workaround were unnecessary — they were based on speculation, not testing.

**Belt-and-suspenders pattern**: For state-critical cancellation, also set a `cancelled` flag the callback checks. Defends against any edge case where `cancel()` racing with the scheduler.

**Use case**: Decelerating callback chains for fortune-roll animations, scheduled reveals, timeout patterns.

---

## ScriptComponent inputNames auto-population

**Working pattern**: After `setProperty(scriptAsset, ..., REFERENCE)`:
- The `inputNames` array on the component auto-populates with each `@input` from the script
- Each name becomes a direct `propertyPath` on the component
- No `inputs.X` wrapper needed

```typescript
// After setProperty assigns the script asset:
component.propertyPath = "myInputName"; // direct, not "inputs.myInputName"
```

**Anti-pattern**: Wrapping property paths with `inputs.` prefix or trying to set inputs before the script asset is assigned. Order matters: assign script first, then inputs become available.

**Use case**: Phase 3 Inspector wiring via MCP. Auto-population means you can iterate `inputNames` to discover what slots need filling.

---

## Editor API vs Lens API separation

These are two completely separate APIs serving different purposes. Mixing them is a common error.

**Lens API (StudioLib)**:
- Used for all lens project scripts (TypeScript or JavaScript)
- Runs at runtime inside the lens
- Examples: `script.image`, `BaseScriptComponent`, `@input` decorators

**Editor API (editor.d.ts)**:
- Used only to control the Lens Studio application itself
- Modifies project settings, performs app actions
- Written in TypeScript only
- Examples: `Editor.Model.IModel`, `Editor.Path`, `AssetManager`

**Anti-pattern**: Calling Editor API methods from a runtime script (won't compile or won't execute), or trying to use Lens API in MCP-driven editor automation (wrong scope).

**Validation rule**: When validating an API surface, validate against the API the *production code* will use, not whichever is convenient for testing.

---

## Transient-view persistence pattern

Some Editor API operations return a transient view that does not persist back to the model unless explicitly reassigned.

**Canonical example**: Setting `lensApplicability` via MCP:

```typescript
// Read returns transient view
const proj = Editor.Model.IModel.project;
const meta = proj.metaInfo;

// Modify
meta.lensApplicability = ["Front"];

// Reassign back to persist
proj.metaInfo = meta;

// Save with ⌘S to flush to disk
```

**Verification**: Reload LS and check on-disk YAML. If the change reverts, transient-view reassignment was missed.

**Symptoms when missed**:
- MCP write appears to succeed
- Live LS shows updated value
- LS reload reverts to previous value
- On-disk YAML never updates

**Use case**: Any project meta-level setting (lens applicability, tracking modes, render settings) modified via MCP.

---

## Coordinate system reminders

For completeness, since these come up constantly:

- LS uses **right-handed coordinate system**: +X right, +Y up, -Z forward
- World units are **centimeters (cm)**
- Rotations are **degrees** in most APIs, but some operate in **radians** — verify per API
- Screen Transforms use **anchors (-1..1)** plus **offsets** for 2D/UI layout
- Prefer anchor-based sizing over offset-based for responsive layouts

---

## Adding new findings

When a new API gotcha is discovered during a lens project, add an entry here with:

- Working pattern (code example)
- Anti-pattern (what looked correct but failed)
- Use case (when this comes up)
- Optional: validation method (how it was confirmed)

Keep entries concise. The value of this file is fast lookup, not exhaustive documentation.
