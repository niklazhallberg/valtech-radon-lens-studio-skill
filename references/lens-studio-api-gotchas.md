# Lens Studio 5.x API Gotchas

Empirically-validated API surfaces and anti-patterns for Lens Studio 5.x. Each entry comes from production lens projects where the obvious or documented approach failed and the working pattern was discovered through testing.

Use this file as authoritative reference when generating production scripts. When generating LS code, cross-check against this file before trusting any API name from web search or training data.

## Contents

### Foundational (asset, texture, transform)
- Asset import (PNG → FileTexture)
- Texture binding to Image components
- Screen Image rotation (NOT localTransform)
- ScreenTransform anchor format
- `createSceneObject` produces bare SceneObject without ScreenTransform

### setProperty mutation rules (six categories)
- Scalars (NUMBER + dotted path) — reliable
- Compound types (RECT, VEC4, VEC2) — DEPRECATED, silent-drop
- Enums — NUMBER + integer index only
- REFERENCE — requires concrete TS type, not `any`
- Arrays — resize via `.length`
- `Editor.Model.MetaInfo` — requires view write-back

### Tween Manager
- Tween Manager package (must be installed)
- TweenScreenTransform type enum
- Tween cancellation semantics
- `resetObject` does NOT invoke TweenValue callbacks
- TweenValue helper-script pattern (for callbackType=2)
- TweenAlpha `recursive: true` for multi-level groups
- Anchor vec4 component order

### Face effects
- `FaceLiquifyObjectPreset` ships with 1 eye + 1 mouth
- LiquifyVisual must be under perspective Camera

### Hierarchy / render
- `setParent` with same parent is no-op (no sibling reorder)
- `deleteSceneObject` can orphan siblings
- `renderOrder` for layering within parent

### Script / API
- DelayedCallbackEvent cancel() actually works
- `InteractionComponent.onTouchStart` (object-bounded) vs `TapEvent` (screen-wide)
- ScriptComponent inputNames auto-population
- Editor API vs Lens API separation
- Transient-view persistence pattern

### Sponsored Lens compliance
- Touch-blocking via `OnStartEvent` (`global.touchSystem.touchBlocking = true`) to prevent Snap double-tap camera-flip

### MCP / mutation strategy
- Batched alias-mutation pattern (one permission prompt per logical unit)
- ToolSearch deferred-tool loading
- Inspector dropdown discipline (read-back enum changes)
- Read-back rule (success ≠ persistence)

### LS 5.21+ features
- Easy Lens panel features vs MCP-scriptable primitives (Button v1.0.1 worked example, `animtionType` typo'd-key gotcha)

### Coordinate system reminders

### Part 2 — Research-derived gotchas (Snap official docs, LS 5.x)
- Event ordering & frame timing (`OnAwake` / `OnStart` race, deferred-`OnAwake` on disabled objects, post-instantiate `OnStart` timing, `Studio.log` silent no-op)
- ScreenTransform additions (Render Order = 0 default, Canvas 1-pixel-bug, z ≥ 1 clipping disappearance, zero-bounds-without-ortho-parent)
- Material / shader binding (Parameter copy-paste resets Script Name, `.mainPass` required, `.lso` re-import duplicates shaders)
- TypeScript decorator behaviour (`new` on `@component` is silent fail, `@input` defaults Inspector quirk, `getComponent` base-class returns null, `require()` literal-only)
- Tween + VFX (TweenManager must be first in hierarchy, GPU particle External Time per-material)
- Prefab (root Transform not saved, Asset-Browser-created prefabs empty + crash risk, `.lso` deprecated + render layers dropped)
- Asset loading + migration (`requireAsset` hard-fails, `.lso` export drops prefab refs, `.lsproj` unopenable in LS 5, pre-4.53 GPU particles need shader+mesh swap, `Physics.WorldSettingsAsset` missing default)

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

## `InteractionComponent.onTouchStart` (object-bounded) vs `TapEvent` (screen-wide)

Two distinct tap-detection paths in LS. They are NOT interchangeable — pick the right one for the intent.

**`InteractionComponent.onTouchStart`** — fires only when the user taps inside the bounds of an object's visible `meshVisuals`. The component is added to a SceneObject, given one or more `meshVisuals` references, and exposes `onTouchStart` / `onTouchEnd` events. Use this for tap-on-this-thing detection (buttons, packs, cards, character tap-to-react).

```typescript
@input interactionComponent!: InteractionComponent;

onAwake() {
  this.interactionComponent.onTouchStart.add(() => {
    // Tapped inside the object's mesh bounds
  });
}
```

**`script.createEvent("TapEvent")`** — fires on ANY tap anywhere on the screen. No bounds, no targeting. Use this for "tap anywhere to advance" / "tap anywhere to reveal" UX.

```typescript
const tap = script.createEvent("TapEvent");
tap.bind(() => {
  // Tapped anywhere on screen
});
```

**Common confusion**: reaching for `TapEvent` when the brief wants tap-on-the-object (then debugging why off-object taps also fire), or reaching for `InteractionComponent` for "tap anywhere" (and discovering the bounds excluded the area the user actually tapped).

**Anti-pattern**: empty `meshVisuals` array on the InteractionComponent. The component is added, the event is bound, but no bounds = no hits — taps silently no-op. Detection: after adding the component, query `meshVisuals` length; if 0, the binding will never fire and the issue isn't in the handler.

**Use case**: Phase 1.5 capability validation. Test both paths in isolation under a throwaway SceneObject before Phase 2 scripts depend on them. This is one of the more common "the handler ran in isolation, why doesn't it run here?" debug paths.

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

## `createSceneObject` produces bare SceneObject without ScreenTransform

**Working pattern**: `scene-graphql`'s `createSceneObject(name, parentId)` creates a SceneObject with **no components at all** — it does NOT auto-add a `ScreenTransform`. If used as parent of a Screen Image, the children's anchors have no parent rect to resolve against and silently fail to render. Children remain *enabled*, materials bound, textures wired — they just don't draw.

```graphql
mutation {
  group: createSceneObject(name: "My Group" parentId: "<parent>") { success }
}
# Returns the new SceneObject id — query that next.

# Then in a follow-up batch:
mutation {
  st: addComponent(id: "<new id>" componentType: "ScreenTransform") { success }
}

# Then set anchors (RECT compound writes drop top/bottom — use NUMBER scalars):
mutation {
  l: setProperty(id: "<st-id>" propertyPath: "anchor.left"   valueType: NUMBER value: "-1") { success }
  r: setProperty(id: "<st-id>" propertyPath: "anchor.right"  valueType: NUMBER value: "1")  { success }
  t: setProperty(id: "<st-id>" propertyPath: "anchor.top"    valueType: NUMBER value: "1")  { success }
  b: setProperty(id: "<st-id>" propertyPath: "anchor.bottom" valueType: NUMBER value: "-1") { success }
}
```

**Alternative**: `createSceneObjectFromPreset("ScreenImageObjectPreset", ...)` auto-adds ScreenTransform — but also auto-adds Image + Material + shader graph. If you only want a Group container (no visual on the parent itself), the preset spawns more than needed. Bare `createSceneObject` + explicit `addComponent ScreenTransform` is the cleaner Group pattern.

**Detection heuristic**: when a screen-anchored child unexpectedly stops rendering after `setParent` to a different SceneObject, query the new parent's components: `sceneObject(id: "<parent>") { components { id type } }`. If `components: []` and the parent is supposed to host Screen-Image children, that's the bug.

---

## setProperty mutation rules — six categories

Six categories of property writes, each with different reliability. Cross-check against this before any non-trivial mutation.

### Category 1: Scalars (NUMBER + dotted path) — RELIABLE

```graphql
setProperty(id: "<id>" propertyPath: "intensity" valueType: NUMBER value: "1.5") { success }
```

Numeric values passed as strings. Works for `position.x`, `anchor.left`, `intensity`, `radius`, `alpha`, etc.

### Category 2: Compound types (RECT/VEC4/VEC2) — DEPRECATED (silent-drop)

```graphql
# WRONG — silent-drop on fields 3+
setProperty(... valueType: RECT value: "{left:-1,right:1,top:1,bottom:-1}")
```

Returns `success: true` but only first 2 fields persist. Fix: replace with 4 scalar NUMBER writes.

### Category 3: Enums — NUMBER + integer index only

```graphql
# Step 1: query property's options to find desired value's index
query { sceneObject(id: "<id>") { components { ... on HeadBinding { attachmentPoint { options } } } } }
# Result: options[3] = "LeftEyeballCenter"

# Step 2: write the NUMBER index
mutation { setProperty(id: "<id>" propertyPath: "attachmentPoint" valueType: NUMBER value: "3") { success } }

# Step 3: read back (Rule 11)
```

| Syntax | Result |
|---|---|
| `valueType: STRING, value: "LeftEyeballCenter"` | Returns `success: true/false` inconsistently; value doesn't apply |
| `valueType: ENUM, value: "LeftEyeballCenter"` | Returns `success: false` |
| `valueType: ENUM, enumType: "..."` | Returns `success: true` BUT applies wrong value |
| `valueType: NUMBER, value: "3"` (integer index) | Returns `success: true` AND correct value applies |

### Category 4: REFERENCE — requires concrete TS type, not `any`

```typescript
// WRONG — generic slot, REFERENCE silently drops to null
@input fortunes!: any;

// RIGHT — concrete slot, REFERENCE sticks
@input fortunes!: JsonAsset;
```

TS type drives slot resolution in LS Inspector — the `// @input Asset.X` comment annotation does NOT override it. If TS type is `any`, slot becomes `AssignableType_1` (anonymous generic). REFERENCE bindings return `success: true` but read-back shows `null`.

**Detection**: read back component properties; if any @input shows `"type": "AssignableType_1"`, the TS declaration uses `any`. Fix: use concrete LS class (`Texture`, `JsonAsset`, `BinAsset`, `AudioTrackAsset`, etc. from `Support/StudioLib.d.ts`).

### Category 5: Arrays — resize via `.length` first

```graphql
mutation {
  resize: setProperty(id: "<id>" propertyPath: "rollIntervals.length" valueType: NUMBER value: "18") { success }
}
```

Without explicit length resize, writes to indices beyond current length fail silently.

### Category 6: `Editor.Model.MetaInfo` — view write-back required

```typescript
project.history.executeAsGroup("update metaInfo", () => {
  const meta = project.metaInfo;
  meta.lensApplicability = [Editor.Model.LensApplicability.Front];
  (project as any).metaInfo = meta;  // REQUIRED: reassign
});
```

See "Transient-view persistence pattern" above for full context.

---

## `resetObject` does NOT invoke TweenValue callbacks

When resetting a TweenValue tween, the apply-callback is NOT invoked — the internal float resets to startFloat but the visual property stays at the last tween-end value.

```typescript
tweenManager.resetObject(target, "rotation_L_v1");  // resets internal float
// BUT: setRotation callback NOT invoked — Image.rotationAngle stays at last value
```

**Fix**: direct property write alongside `resetObject`:

```typescript
tweenManager.resetObject(this.leftHalf, "pack_split_L");
if (this.leftImage) this.leftImage.rotationAngle = 0;  // explicit write needed
```

**Use case**: reroll / restart mechanics. If only TweenScreenTransform is used (Anchors/Position/Scale), `resetObject` works correctly because those tweens write the property directly. The callback gap is specific to TweenValue with `callbackType=2`.

---

## TweenValue helper-script pattern (callbackType=2)

For TweenValue with `callbackType=2` (calls a function on a target script every frame), use a dedicated helper script. Cleaner than inline callbacks.

```typescript
@component
export class RotationApplier extends BaseScriptComponent {
  @input image!: Image;  // concrete type per Category 4

  onAwake() {
    if (!this.image) throw new Error("RotationApplier requires Image input");
  }

  setRotation(angle: number): void {
    this.image.rotationAngle = angle;
  }
}
```

In TweenValue Inspector wiring:
- `callbackType` = 2
- `funcTargetScript` = `<RotationApplier instance>`
- `funcName` = `"setRotation"`

Each frame, tween calls `applier.setRotation(currentAngle)`. Benefits:
- Validation in `onAwake` (no silent null-deref)
- Multiple TweenValues can target the same applier for symmetric animations
- Code review can audit apply logic in one place

---

## TweenAlpha `recursive: true` for multi-level groups

When fading a group containing children at different depths, TweenAlpha needs `recursive: true` to walk past one level.

```graphql
mutation {
  setProperty(id: "<tween-alpha-id>" propertyPath: "recursive" valueType: NUMBER value: "1") { success }
}
```

(Numeric "1" for true; setProperty BOOL valueType has been inconsistent — NUMBER is reliable.)

**Anti-pattern**: leaving `recursive: false` for a Note Group with Image + Text children at different nesting levels. Only direct children fade; nested children stay opaque.

---

## Anchor vec4 component order

For `TweenScreenTransform` `type=3` (Anchors), `anchorsParam=0` (Bounds), the start/end vec4 values map as:

```
vec4 { x, y, z, w }  →  { left, right, top, bottom }
```

NOT the intuitive `x=left, y=top, z=right, w=bottom`. Discovered via deliberate asymmetric test → read-back → confirmation.

When setting tween start/end values:
- `startVec4.x` = startLeft
- `startVec4.y` = startRight
- `startVec4.z` = startTop
- `startVec4.w` = startBottom

Use the same pattern for `endVec4`.

---

## `FaceLiquifyObjectPreset` ships with one eye + one mouth

**Empirical**: LS preset description claims "LiquifyVisual attached to left and right eye centers." Actual instantiation:

- Child #1: Head Binding → `RightEyeballCenter` (4) ✓
- Child #2: Head Binding → `MouthCenter` (5) ⚠️ NOT LeftEyeballCenter

**Mandatory fix on instantiation**:
1. Query the full child hierarchy + every Head Binding `attachmentPoint`
2. For child #2, change attachmentPoint to `LeftEyeballCenter` (NUMBER index 3) via enum-write pattern (Category 3)
3. Read back to verify

**Lesson**: trust nothing from preset descriptions until read-back confirms.

---

## LiquifyVisual must be under perspective Camera

Face-anchored visual effects (LiquifyVisual + Head Binding, FaceMeshVisual) must live under the perspective Camera Object to render correctly. Under the Orthographic Camera they silently fail — face tracking has no path to apply landmarks to orthographic render pass.

**Misleading transient success**: if another scene component is driving face tracking globally (e.g., Face Geometry Modification's MLComponent), face effects under Orthographic Camera may render correctly because the ML pipeline provides face data. Success disappears when the providing component is removed.

**Fix**: `setParent` the face-effect root SceneObject to the perspective Camera Object.

**Verification**: test face effects in isolation after removing unrelated face-tracking-driven assets. Don't trust transient success.

---

## `setParent` with same parent is no-op (no sibling reorder)

Calling `setParent(id, parentId)` where `parentId` is the current parent does NOT re-order siblings. LS rendering: last sibling renders on top, so wrong sibling index = unwanted occlusion. There is no `setSiblingIndex` mutation in scene-graphql schema.

**Workarounds (priority order)**:
1. `renderOrder` on visual component (canonical, no scene-tree disruption)
2. Re-parent trick: move to different parent, then back (risky for ScreenTransform — anchors may need re-application)
3. Delete + re-create in desired position (most invasive)

---

## `deleteSceneObject` can orphan siblings

Deleting one SceneObject can leave a sibling unparented while still existing.

**Defensive practice**: after any `deleteSceneObject`, query parent's children list to confirm nothing else was orphaned.

```graphql
mutation { delete: deleteSceneObject(id: "<target>") { success } }

# Immediately after:
query { sceneObject(id: "<parent-id>") { children { id name } } }
```

If a known sibling is missing, query its UUID directly (it still exists) and explicit `setParent` to restore.

---

## `renderOrder` for layering within parent

Lower value = drawn first (behind), higher = drawn last (on top). Default: 0.

```graphql
mutation {
  setProperty(id: "<image-component-id>" propertyPath: "renderOrder" valueType: NUMBER value: "-100") { success }
}
```

**Real example**: Face Modifier Image from Face Geometry Modification package auto-instantiated as last child of Orthographic Camera, drew on top of UI. Fix: set `renderOrder = -100` (no re-parenting needed).

| Situation | Use |
|---|---|
| Multiple SceneObjects under same parent, one needs to render behind | `renderOrder` |
| Different parent needed for logical organization, render order matters | `renderOrder` (safer than re-parenting) |
| Cross render pass (perspective vs orthographic) | Move SceneObject to different parent/camera (renderOrder won't cross passes) |

---

## Batched alias-mutation pattern

`scene-graphql` mutations support GraphQL alias batching. Use for any logically-coherent set of related mutations — one CC permission prompt per logical unit instead of per-mutation.

```graphql
mutation {
  l: setProperty(id: "<st-id>" propertyPath: "anchor.left"   valueType: NUMBER value: "-1") { success }
  r: setProperty(id: "<st-id>" propertyPath: "anchor.right"  valueType: NUMBER value: "1")  { success }
  t: setProperty(id: "<st-id>" propertyPath: "anchor.top"    valueType: NUMBER value: "1")  { success }
  b: setProperty(id: "<st-id>" propertyPath: "anchor.bottom" valueType: NUMBER value: "-1") { success }
}
```

Each alias (`l`, `r`, `t`, `b`) returns its result independently. Use human-readable aliases for traceability in logs.

**Use case**: anchor sets, color components, multi-property sync, bulk apply after probe-and-verify (Rule 6).

---

## ToolSearch deferred-tool loading

Many MCP tools have deferred schemas — listed by name in `system-reminder` but not callable until ToolSearch loads the schema. Common deferred LS tools: `SetLensStudioSelection`, `RunAndCollectLogsTool`, certain `asset-graphql` mutations.

```
ToolSearch(query: "select:mcp__lens-studio__SetLensStudioSelection")
```

After ToolSearch returns, the tool is callable. Load lazily — only when actually needed; each loaded schema consumes context.

**Anti-pattern**: trying to call a deferred tool directly without ToolSearch — fails with InputValidationError.

---

## Inspector dropdown discipline

User clicks an enum dropdown in LS Inspector → visual checkmark appears on hover/highlight option → user assumes value committed → scene-graphql read-back shows different value.

**Symptom**: "I set attachmentPoint to LeftEyeballCenter" but read-back shows `RightEyeballCenter` (or previously selected value).

**Recipe**: after ANY user-driven Inspector change involving enums, run scene-graphql read-back to verify.

```graphql
query { sceneObject(id: "<id>") { components { ... on HeadBinding { attachmentPoint { value index } } } } }
```

UX-level issue with LS Inspector, not specific to MCP. Verify-after-user-action regardless of who made the change.

---

## Read-back rule — `success: true` ≠ persistence

See `operational-rules.md` Rule 11 for the policy. Quick reference:

After ANY mutation in these categories, read back the actual stored value:
- Compound types (RECT, VEC4, VEC2)
- Enum writes
- REFERENCE bindings (especially to @input fields)
- `Editor.Model.MetaInfo` field mutations
- Any pattern from web search / training data (per probe-and-bulk discipline)

For simple NUMBER/STRING scalar writes to known-reliable properties (position.x, intensity, alpha), read-back is optional.

---

## Coordinate system reminders

For completeness, since these come up constantly:

- LS uses **right-handed coordinate system**: +X right, +Y up, -Z forward
- World units are **centimeters (cm)**
- Rotations are **degrees** in most APIs, but some operate in **radians** — verify per API
- Screen Transforms use **anchors (-1..1)** plus **offsets** for 2D/UI layout
- Prefer anchor-based sizing over offset-based for responsive layouts

---

## Easy Lens panel features vs MCP-scriptable primitives (LS 5.21+)

"Easy Lens X" labels in the LS 5.21 release notes (https://ar.snap.com/download) refer to **panel-level features** in the Easy Lens / AI Creator UI, NOT to discrete Asset Library installables. CC cannot drive the Easy Lens panel via MCP. The actionable path is to identify and script the underlying primitive CustomComponent; designer-facing visual editing (shape, color, pressed-behavior tuning via the panel UI) is hands-off — that's a designer task in the Easy Lens panel inside LS.

**Empirical example: "Easy Lens Button" maps to `Button` v1.0.1 primitive** (probed 2026-05-12):

- `SearchLensStudioAssetLibrary(["Easy Lens Button"])` → no exact match. Closest discrete primitive: `Button` v1.0.1 CustomComponent.
- Install via `InstallLensStudioPackage("https://assets.ctfassets.net/.../Button.v1.0.1.lsc")`. Asset lands at `Packages/Button.lsc/Button.ts`. Bundle includes 3 prefabs (Text / Background / Icon) + texture + material + shader graph.
- Layout constraint: child of an Orthographic Camera (screen-space hierarchy).

**Configurable inputs (Button v1.0.1)**:

| Key | Type | Notes |
|---|---|---|
| `defaultBackgroundColor`, `pressedBackgroundColor`, `disabledBackgroundColor` | vec4 | RGBA per state |
| `defaultLabelColor`, `pressedLabelColor`, `disabledLabelColor` | vec4 | RGBA per state |
| `animtionType` | number | **TYPO'D KEY** — missing 'a' in "animation". 0=None, 1=Bounce, 2=Squish, 3=Transform |
| `renderOrder`, `textSize`, `buttonScale` | number | |
| `buttonCenter` | vec2 | |
| `backgroundEnabled` | boolean | |

**Methods**: `isPressed()`, `isActive()`, `enableInteractable()`, `disableInteractable()`, `setTransformType(type, default, pressed, disabled)` — type: 0=OffsetPos / 1=AnchorPos / 2=Rotation / 3=Scale.

**Events** (`.add(callback)`): `onEnabledInteractable`, `onDisabledInteractable`, `onPressUp`, `onPressDown`, `onPress`.

**Critical CC gotcha — typo'd input key**: `animtionType` is the published API name. `setProperty(buttonId, "animationType", NUMBER, "1")` will silent-drop (treated as an unknown property). Match the typo'd key as published:

```graphql
mutation { setProperty(id: "<button-id>" propertyPath: "animtionType" valueType: NUMBER value: "1") { success } }
```

**Working pattern for any "Easy Lens X" brief**:

1. `SearchLensStudioAssetLibrary([feature name])` — see what discrete primitive (if any) maps to the changelog label.
2. `InstallLensStudioPackage(<URI>)` for the primitive.
3. `ListInstalledPackagesTool` to confirm install (package count delta + description field is the canonical API doc for that primitive).
4. Script the primitive's input/event surface directly via `setProperty` / `script.<event>.add(cb)`.
5. Hand off visual-tuning the panel exposes (but the script doesn't) to the user via Inspector / Easy Lens panel.

**Anti-pattern**: promising a client the Easy Lens "visual editing" experience via CC. That UX lives in the Easy Lens panel inside LS; CC's deliverable is the scriptable primitive + Inspector handoff.

**Use case**: any 5.21+ client brief mentioning "Easy Lens X" or Easy-Lens-generated content. Map the changelog label to the underlying primitive before promising CC delivery.

---

## Sponsored Lens compliance — touch-blocking

For Sponsored Lenses, Snap's default in-camera touch handling includes **double-tap-to-flip-camera** and other system shortcuts that pre-empt your handlers. If your lens depends on tap input (most do), the second tap of any rapid double-tap can fire the camera-flip before your handler runs — breaking interaction unpredictably and producing inconsistent QA reports.

**Working pattern**: bind an `OnStartEvent` callback that sets `global.touchSystem.touchBlocking = true`:

```typescript
const onLensStart = script.createEvent("OnStartEvent");
onLensStart.bind(() => {
  global.touchSystem.touchBlocking = true;
});
```

This blocks Snap's default touch shortcuts (double-tap camera flip, certain swipe gestures) while preserving your `InteractionComponent` and `TapEvent` handlers. Apply once at lens turn-on — no per-tap re-application.

> **Migration note**: the legacy `"LensTurnOnEvent"` string and `TurnOnEvent` class are **deprecated** as of LS 5.8+ and will eventually block publishing. Old snippets, forum posts, and AI-generated code will use the legacy form — translate to `"OnStartEvent"` at paste time. See `deprecated-api-migration.md`.

**Applies to**: ALL Sponsored Lenses. Community Lenses don't strictly require it but benefit from the same predictability — recommend by default unless the brief specifically wants Snap's defaults.

**Anti-pattern**: omitting touch-blocking and accepting "sometimes the second tap doesn't fire" as a quirk. The bug is intermittent (depends on tap-cadence + Snap's internal debounce) which makes it look like a handler bug; Snap reviews catch it as inconsistent interaction.

**Verification**: tap-tap rapidly on the lens on a real device. Without touch-blocking, the camera flips on the second tap (or shortly after). With touch-blocking, both taps reach your handler as intended. Desktop preview does NOT reproduce the camera-flip behavior — must test on device.

**Use case**: Phase 1 scaffolding — add the `OnStartEvent` touch-blocking handler as part of the static scene setup before any interaction logic. One-line install with no Phase-2 dependency; the earlier it lands, the fewer "intermittent tap bug" red herrings appear in later phases.

---

## Try-On Pack Sneakers — Foot Tracking calibration (full empirical record)

> See `body-anchored-calibration.md` for the universal probe-first protocol that applies to ALL tracker-driven content. This section covers Try-On Pack Sneakers + Foot Tracking-specific empirical findings (first validated 2026-05-13 on a Sponsored Lens foot try-on build).

**Working pattern**: Snap's "Try On Pack - Sneakers" (asset id `eafc3816-061e-4cd1-99c2-626ee19d33f4`) + Foot Tracking custom component (asset id `0d0a080f-37d1-401d-be96-f14684516652`) install + wire cleanly via MCP. But the resulting lens is NEVER ready for real-device review at default values. Three independent calibrations are required, in this order: geometry placement (scale → position → mirror) → material color.

### Empirical observations

**1. Foot Tracking overwrites entire `localTransform` on its anchor references each frame** — not just position+rotation. Setting scale or position directly on `shoe_mesh_l/r` as referenced by `leftFootAnchor` / `rightFootAnchor` is overwritten before next render. Verified: scale=(4,4,4) showed zero visual delta vs untouched right shoe. Manual UI-side scale change (2 in inspector) also did not persist visually.

**2. Wrapper-anchor architecture is mandatory** for any property you want to control. Sequence (3 steps — NOT atomic, read-back after each):

```graphql
# Step 1: Create empty wrapper SceneObject under FootTracker
mutation { createSceneObject(name: "LeftFootAnchor" parentId: "<FootTracker-id>") { id success } }

# Step 2: Re-parent shoe under wrapper
mutation { setParent(id: "<shoe_mesh_l-id>" parentId: "<new-anchor-id>") { success } }

# Step 3: Re-wire tracker's leftFootAnchor reference (Category 4 REFERENCE)
mutation { setProperty(id: "<FootTracker-ScriptComponent-id>" propertyPath: "leftFootAnchor" valueType: REFERENCE value: "<new-anchor-id>") { success } }
```

Then apply `localTransform` (scale, position) on the shoe — it now persists because tracker writes to wrapper, not to child. Mirror to right shoe ONLY after left side calibration locks + user signs off.

**3. Try-On Pack Sneakers mesh-pivot is NOT at foot-center.** FileMesh bbox values via `asset-graphql` on FileMesh asset `b08d829a-e7cd-4fc5-88dd-44e6a1539aea`:

| Axis | aabbMin | aabbMax | Mesh-center offset from pivot (0,0,0) |
|---|---|---|---|
| X (lateral) | 19.74 | 33.56 | **26.65** — mesh entirely +X of pivot |
| Y (vertical) | 0.007 | 19.27 | 9.64 — sole sits at pivot Y ≈ 0 |
| Z (toe-heel) | -6.99 | 25.38 | 9.19 — pivot near heel-end |

At scale 4× the X-offset becomes 4 × 26.65 = 106.6 LS units lateral displacement (~1m visually). Pivot-compensation formula: `position = -1 × scale × mesh-center-offset`. The X-component is the dominant displacement source; Z is secondary; Y is anatomically correct (sole-at-pivot) and usually doesn't need compensation EXCEPT for the tracker-anchor-Y offset described in point 4.

**4. Tracker anchor Y-position is at ANKLE level (~40 LS units above floor), NOT at sole.** Empirical: Y=0 places mesh-sole at ankle-height = shoes float ~40 cm above floor. Y=-40 drops sole to floor at scale 4. This is foot-tracker-specific; verify per body-part-tracker. The "sole-at-pivot mesh + tracker-at-ankle" mismatch is hidden until first device test.

**5. AnimationPlayer defensive disable** on Sneakers prefab root. Try-On Pack ships with `autoplay=true` and clip "BaseLayer" with `end=0 frames` — likely no-op but eliminates a potential overwrite source. Use `setEnabled(id, enabled: false)`, never `deleteComponent` (delete is destructive, can break dependent references).

**6. DefaultMtl baseColor ships at `(0.4, 0.4, 0.4, 1)` (40% gray, NOT white)** at path `passInfos.0.baseColor`. Both shoes share the *same* material instance — single mutation affects both. Material is cosmetic, tackle ONLY after geometry is locked.

**7. Pre-made colorway alternatives exist** in Try-On Pack package — often higher fidelity than mutating DefaultMtl baseColor:

| Material asset | Asset id | Notes |
|---|---|---|
| `DefaultMtl` | `a2d908f2-266a-403e-8c36-b8fb104761a6` | Flat 40% gray, no textures, shared between both shoes |
| `sneakers_blue.mat` | `2a288760-49f9-4517-869c-af0768575a5e` | Textured blue colorway with diffuse + normal + params maps, ShaderGraph shader |
| `sneakers_red.mat` | `558f3992-0e90-4ac1-bc5a-25d1753f8983` | Textured red colorway with diffuse + normal + params maps, ShaderGraph shader |

Material swap is a single setProperty per shoe (REFERENCE valueType on `materials[0]` of the RenderMeshVisual component) — replaces flat gray with textured colorway. For brand-authentic looks (when the brief specifies a particular colorway), swap-to-pre-made often beats tuning DefaultMtl.

### Foot-specific verification protocol (mandatory before declaring Phase 1 done)

1. **Hierarchy walk** via `scene-graphql` — output object names + IDs + localTransforms + materials + script-wiring at each level. Confirm FootTracker script's `leftFootAnchor` / `rightFootAnchor` REFERENCES point to `shoe_mesh_l/r` initially.
2. **Bbox-read** via `asset-graphql` on shoe_mesh_l FileMesh — record `aabbMin/aabbMax/aabbSize` before any scale mutation. Pivot-compensation formula depends on these.
3. **Defensive disable** AnimationPlayer on Sneakers prefab root.
4. **Asymmetric scale probe** on shoe_mesh_l only (no wrapper yet) — verify on phone whether scale persists.
   - No visible delta → tracker overwrites → proceed to step 5 (wrapper).
   - Left shoe bigger than right → scale layer is yours (rare for Foot Tracking; document the surprise).
5. **Wrapper-anchor installation** for left foot (LeftFootAnchor created, shoe_mesh_l re-parented, tracker.leftFootAnchor re-wired). Read-back after each of the 3 mutations.
6. **Pivot-compensation probes** on shoe_mesh_l within wrapper — use formula `-scale × bbox-center` as starting estimate, then tune empirically (10-30% adjustment typical, especially in X-axis where bbox-center under-estimates real pivot location).
7. **Y-offset compensation** for tracker-anchor-at-ankle vs sole — try Y=-40 first (verified ankle height for Foot Tracking custom component at typical scales 2-4×).
8. **Mirror geometry to right side** — create RightFootAnchor wrapper for shoe_mesh_r, re-wire tracker.rightFootAnchor, apply same localTransform values. ONLY AFTER left side locks + user signs off.
9. **NOW probe material** in correct visual context (shoes sitting on feet). Choose: tune DefaultMtl baseColor (small step first, 0.4 → 0.6) OR swap to sneakers_blue.mat / sneakers_red.mat for textured look.
10. **⌘S** after each successful probe-test cycle.

### Anti-patterns

- **"Wired = done"** — skipping real-device calibration. Desktop LS Preview can't reliably render foot-tracking ML; what looks fine in LS reads as broken in Snapchat.
- **Mutating `shoe_mesh_l/r` directly** as tracker-references without first checking what the tracker overwrites per frame.
- **Tuning material before geometry locks** — judgments made in wrong visual context.
- **Skipping bbox-read before scale mutation** — pivot-offset amplifies linearly with scale, surprises you at scale ≥ 2.
- **Trusting MP4 video as Preview source** for foot-tracking visual validation — inpainting/Shoe Removal pipeline runs on MP4 input, but content rendering is unreliable in desktop preview regardless of input source. **Phone pair-test is the single source of truth.**
- **Treating bbox-center as exact** — formula `-scale × bbox-center` is *starting estimate*. Real pivot can diverge 10-30% from aabbCenter due to geometry distribution. Expect to tune.
- **Predicting which world-axis a mesh-local mutation will display as** — tracker rotation + body orientation + camera angle stack into an unpredictable chain. Probe + observe, don't pre-reason.

### When inpainting works but content renders offset (diagnosis pattern)

If `useInpainting: true` produces clean foot removal (Snap visibly knows where feet are) BUT virtual shoe renders displaced from feet — that is NOT a tracking bug. It is mesh-pivot offset (the FBX's authored pivot point isn't at the anatomical anchor point Snap's tracker writes to). Inpainting/Shoe Removal pipeline uses pixel-space foot mask; content-rendering uses SceneObject anchor REFERENCE. The two paths can be perfectly aligned in tracker-space but visibly offset in screen-space due to pivot-vs-anchor mismatch.

**Diagnose**: bbox-read the FileMesh; the mesh-center offset from (0,0,0) tells you how much position-compensation to apply. **Cure**: position-offset on wrapper-child as documented above.

### Calibration camera-pose discipline

User pair-tests in *typical user-position* (~30-45° down for foot-tracking), NOT rakt-nedåt. A lens calibrated for one camera angle can fail in another. Document final calibration values alongside the camera pose they were validated in.

### Why empirically validated

First validated on a Snapchat Sponsored Lens foot try-on build, 2026-05-13. First device test showed shoes at ~⅓ foot size, floating ~20 cm above actual feet, gray against wooden floor. Diagnosis sequence: hierarchy walk → AnimationPlayer disable → scale probe (tracker overwrote → wrapper installation) → bbox-read → position-compensation tuning → mirror to right → material decision. Y=-40 ankle-vs-sole compensation discovered empirically. Bbox-formula under-compensated X by ~15-20% (real pivot slightly inside the mesh from aabbCenter). Per-foot wrapper positions caused *asymmetric* visual displacement under partial compensation (left shoe drifted toward body center, right shoe drifted outward from body) — required full pivot-compensation magnitude (`scale × bbox-center`) to land both shoes on respective feet simultaneously.

---

## Part 2 — Research-derived gotchas (Snap official docs, LS 5.x)

> Part 1 above comes from empirical project work — each entry was hit during a real lens build and validated by the symptom → fix cycle. The entries below come from a targeted research pass against Snap's official documentation and corroborating community threads (compiled 2026-05-20). They have **higher source-trust** (official Snap docs) but **lower project-trust** (not yet hit in our own builds). Verify on first encounter and promote to Part 1 once project-validated. STALE markers are kept where the only source predates LS 5.x.

### Event ordering & frame timing

#### `OnAwake` order is deterministic; `OnStart` sibling order is NOT

**Pattern**: When multiple components are constructed together (scene load, `ObjectPrefab.instantiate()`), `OnAwakeEvent` fires in strict hierarchy order, but `OnStartEvent` order between sibling components is explicitly undefined.

**Mitigation**: Use `OnAwake` for self-initialisation; use `OnStart` only to read state that *other* components set during *their* `OnAwake`. Never assume sibling-A's `OnStart` runs before sibling-B's just because A appears higher in the hierarchy.

**Source**: https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.OnAwakeEvent + SceneEvents_List — official, accessed 2026-05.

**Confidence**: official docs.

**Why generalizable**: Cross-component coordination that depends on `OnStart` ordering silently races after any unrelated hierarchy refactor — symptom looks like a heisenbug, not a code bug.

---

#### `OnAwake` does NOT fire on disabled components until first enable

**Pattern**: If a SceneObject or component is disabled at scene-load time (including via a disabled parent), its `OnAwakeEvent` is deferred until the first `setEnabled(true)` — not at startup with other components.

**Mitigation**: Code that calls `setEnabled(true)` on a previously-disabled object and immediately reads its scripted API will see uninitialised state. Either guard with null-checks at the call site, or trigger initialisation explicitly via a public method rather than relying on `OnAwake`.

**Source**: https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.OnAwakeEvent — official.

**Confidence**: official docs (multi-source).

**Why generalizable**: "Disable for perf, enable later" is a common pattern; the deferral creates a recurring class of confused-state bug.

---

#### `OnStart` on a newly-instantiated component runs AFTER the calling scope exits

**Pattern**: After `createComponent()` or `ObjectPrefab.instantiate()` returns, the new component's `OnStartEvent` has not yet fired — it fires later in the same frame after the entire calling code block exits.

**Mitigation**: Don't read script outputs of a freshly-instantiated component from the calling scope. Move consumer code into the *consumer's* `OnStart`. The old "wait one frame" community workaround is unnecessary if the consumer subscribes properly.

**Source**: https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.OnStartEvent — official, 2024-2026.

**Confidence**: official docs.

**Why generalizable**: This is the cause of most "I called instantiate then read .api, got undefined" reports — across years of community threads.

---

#### `Studio.log` is NOT implemented in LS 5.x — silently fails, no output

**Pattern**: `Studio.log()` (a logging helper from older LS 4.x docs) has not been implemented in LS 5.x. Migrated code using it produces no output and no error — debugging appears completely silent.

**Mitigation**: Replace every `Studio.log` call with `print()` during 4.x → 5.x migration. The absence of output is the only signal that the call is broken.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official migration guide.

**Confidence**: official docs.

**Why generalizable**: 4.x helper-scripts pasted into 5.x projects look fine, run without errors, and produce no debug output. Easy to miss for hours.

---

### ScreenTransform / anchor / pivot positioning

#### Default Render Order is `0` in LS 5.x (auto-increment is gone)

**Pattern**: In LS 4.x, new objects received an auto-incrementing Render Order. In LS 5.x, every new object defaults to `0`, so a new object added on top of an LSO-imported object (whose order was baked at import) may render *behind* it with no warning.

**Mitigation**: Set Render Order explicitly on every visual object in projects that mix imported 4.x assets with new 5.x objects.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official.

**Confidence**: official docs (multi-source).

**Why generalizable**: Any project that imports `.lso` from 4.x and then adds new 5.x objects silently produces wrong layering.

---

#### Orthographic Camera Canvas defaults make Image Carousel (and other UI) render as a single pixel

**Pattern**: Adding an Image Carousel (or other Asset Library UI components) under an Orthographic Camera with the default Canvas component renders the carousel as a single pixel because the Canvas `Unit Type` defaults to a non-World value.

**Mitigation**: Either set the Canvas `Unit Type` to `World`, or delete/disable the Canvas component. Looks like a missing texture; is actually a unit-type config issue.

**Source**: https://developers.snap.com/lens-studio/features/ui/ui-image-carousel — official, accessed 2025.

**Confidence**: official docs (multi-source).

**Why generalizable**: Every studio that drops a stock UI component onto a standard ortho camera setup hits this. Symptom diagnosis is non-obvious.

---

#### `ScreenTransform.position.z ≥ 1.0` silently disappears behind the ortho clipping plane

**Pattern**: The orthographic camera's near clipping plane defaults to `-1` in LS 5.x. Any `ScreenTransform` with z position ≥ 1.0 (set programmatically, or carried over via LSO import) is behind the camera and not rendered — no error.

**Mitigation**: Keep `screenTransform.position.z` between `-1` and `1` (exclusive at boundaries). The community-validated safe default for "in front of everything" is `z = -1` (subject to wrapping back into bounds — verify).

**Source**: Migration guide + "Lens Studio 5.0 Screen Transform Problems and Solutions" YouTube, Jan 2025.

**Confidence**: official docs (multi-source).

**Why generalizable**: Dynamic UI placement via `screenTransform.position.z = X` can push objects out of frustum with no diagnostic — looks like the object stopped existing.

---

#### `ScreenTransform` outside an Orthographic Camera produces zero-size bounds (invisible)

**Pattern**: A `ScreenTransform`-based object parented as a child of a 3D (perspective) camera, or at the scene root, has zero-size bounds — the object is invisible with no logger output.

**Mitigation**: Always parent `ScreenTransform` containers under an Orthographic Camera. If you instantiate one from code, set the parent explicitly to an ortho camera SceneObject — never rely on default parenting.

**Source**: https://developers.snap.com/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-properties — official.

**Confidence**: official docs.

**Why generalizable**: Prefab-based UI systems that instantiate `ScreenTransform` containers from scripts silently fail when parented to the scene root — common in code-driven UI layouts.

---

### Material / shader binding between script and visual graphs

#### Copy-pasting a Shader Graph Parameter node silently RESETS its Script Name

**Pattern**: When you duplicate a Parameter node in the Shader Graph editor (copy-paste), the `Script Name` field is silently reset to a new generated token. Any script that addresses the old name (e.g. `material.mainPass.myColor`) writes to a non-existent property with no error.

**Mitigation**: After every Parameter copy-paste, immediately re-set the `Script Name` to the intended value. Verify by reading the parameter back from script after a write.

**Source**: https://developers.snap.com/lens-studio/features/graphics/materials/material-editor/parameters-guide — official, 2024.

**Confidence**: official docs.

**Why generalizable**: Shader parameter `Script Name` is the only bridge between TypeScript and the visual material graph. This rename is the single most common cause of "my script writes to the material but nothing changes" bugs.

---

#### Material script access MUST go through `.mainPass` — direct property access silently fails

**Pattern**: Shader parameters exposed to scripts are accessed via `material.mainPass.<scriptName>`. Setting them on the material object directly (`material.<scriptName> = value`) writes to a JS object wrapper that never propagates to the GPU. No error, no warning.

**Mitigation**: Always go through `.mainPass`. TypeScript can't catch this — `mainPass` is typed as `any`.

```typescript
// WRONG — silent no-op
material.hue = 0.5;

// CORRECT
material.mainPass.hue = 0.5;
```

**Source**: https://developers.snap.com/lens-studio/features/graphics/materials/material-editor/parameters-guide — official.

**Confidence**: multi-source.

**Why generalizable**: Material is unchanged, no error, no compile warning. Pure-by-inspection bug.

---

#### Re-importing an `.lso` may DUPLICATE the shader inside a material

**Pattern**: Re-importing an `.lso` (or right-click → reimport on an existing 3D model) doesn't update the component's shader reference in place. It creates a second identical shader asset; the material may now point at the old or new copy unpredictably.

**Mitigation**: After every re-import, manually delete the duplicate shader in the Asset Browser and re-link the material via the Inspector. Or migrate the workflow off `.lso` to `.lspkg`.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official.

**Confidence**: official docs.

**Why generalizable**: CI/CD pipelines that re-import `.lso` automatically accumulate shader duplicates over time — project bloat + material-mismatch risk.

---

### TypeScript decorator behaviour

#### `@component` classes must NEVER be instantiated with `new` — only via `createComponent`

**Pattern**: Any class extending `BaseScriptComponent` or decorated with `@component` will fail silently if instantiated with `new`. Lens Studio manages component lifecycle internally; correct construction is `sceneObject.createComponent('ScriptComponent')`.

**Mitigation**: Treat `new MyController()` as a hard ban for `@component` classes. The class will accept it syntactically but `OnAwake` / `OnStart` / scene events never fire.

**Source**: https://developers.snap.com/lens-studio/features/scripting/script-components — official, 2024.

**Confidence**: official docs.

**Why generalizable**: Developers from Unity, React, or plain TS write `new MyController()` instinctively. LS 5 accepts the syntax but the component is dead.

---

#### `@input` defaults for Components and SceneObjects ONLY work in the Script *Component* Inspector, not Script *Asset* Inspector

**Pattern**: `@input` fields typed as Components or SceneObjects can only be wired up per-instance in the **Script Component Inspector**. Attempts to set defaults in the **Script Asset Inspector** are silently ignored for these types. Asset-type inputs (Texture, Material, Mesh) DO support asset-level defaults — so the inconsistency is non-obvious.

**Mitigation**: Wire Component/SceneObject inputs at the prefab or scene-instance level, not as Script Asset defaults. Prefab templates with unset Component/SceneObject inputs silently produce `null` at runtime.

**Source**: https://developers.snap.com/lens-studio/features/scripting/script-components — official.

**Confidence**: official docs.

**Why generalizable**: The inconsistency between asset-type and non-asset-type input defaults is a common confusion point during template authoring.

---

#### `getComponent()` with a BASE class returns `null` — registry is keyed on concrete class name

**Pattern**: `sceneObject.getComponent(MyBaseClass)` where `MyBaseClass` is a parent class (not the concrete class registered with `@component`) returns `null` in LS 5.x TypeScript. The component registry keys on the concrete class name string, not the inheritance chain.

**Mitigation**: To find components by base class, iterate `getComponents("Component")` and filter with `instanceof`:

```typescript
const matches = sceneObject.getComponents("Component")
  .filter(c => c instanceof MyBaseClass);
```

**Source**: https://localjoost.github.io/Getting-components-by-their-base-class-name-in-Lens-Studio/ — community blog, Dec 2025.

**Confidence**: multi-source.

**Why generalizable**: Component architectures using polymorphism (e.g. `Interactable` base + multiple concrete types) silently retrieve nothing without this workaround.

---

#### `require()` MUST receive a string literal — dynamic paths fail at scene load

**Pattern**: LS's CommonJS-style `require()` and `requireAsset()` only accept static string literals at call time. Wrapping the path in a variable or building it via concatenation/template literal (`require('./assets/' + name)`) produces a module-not-found error at scene load — no compile-time warning.

**Mitigation**: All asset paths must be statically known at authoring time. For "dynamic-by-data" patterns, eagerly `require()` all candidates at module top-level and pick at runtime.

**Source**: https://developers.snap.com/lens-studio/features/scripting/script-modules — official, 2024.

**Confidence**: official docs.

**Why generalizable**: Lazy-loading patterns from web JS (load texture by array index, lazy-load scene modules) are entirely unsupported. Easy trap for developers ported from web/Unity.

---

#### `@input` decorator order matters — annotations must come AFTER `@input`, not before

**Pattern**: Inspector-display decorators (`@hint("tooltip text")`, `@label("Custom Label")`, `@widget(...)`) modify the most-recently-declared `@input` field. Writing them in the wrong order — e.g., `@hint("...") @input myField` — silently does nothing; the field appears in Inspector with no hint, no warning.

**Mitigation**: Always write `@input` FIRST, then any modifier decorators on the lines BELOW the field. Treat the order as a one-way pipeline: declare → annotate.

```typescript
// CORRECT
@input
@hint("Speed in units per second")
@label("Move Speed")
public speed: number = 1.0;

// WRONG — annotations are dropped silently
@hint("Speed in units per second")
@label("Move Speed")
@input
public speed: number = 1.0;
```

**Confidence**: VERIFY-tag — pattern observed in LS 5.x community examples; exact ordering rule not in the official docs page. Validate empirically before relying on it in production.

**Why generalizable**: TypeScript decorators in mainstream JS frameworks (Angular, NestJS) are commutative; LS-decorator ordering is positional. Easy trap on first use.

---

#### `@input` typed as a custom class requires `@component` AND the class file to be loaded before the prefab

**Pattern**: A field like `@input public controller: MyController` where `MyController` is another `@component` class only resolves correctly if `MyController`'s script asset is referenced from the scene before the consuming script tries to read the input. If the consumer is the only thing referencing `MyController`'s asset, the Inspector dropdown for that input shows the class but assigning a SceneObject at runtime may yield `null` on read.

**Mitigation**: Have at least one direct SceneObject reference to the `MyController` component (e.g., a placeholder Visual or empty SceneObject hosting it) so its module is loaded ahead of the consumer. Alternatively, pass the controller via a runtime `findByName` lookup instead of an `@input` field.

**Confidence**: VERIFY-tag — load-order behaviour partially documented; empirical reports in community forums match this pattern but no Snap source confirms it explicitly. Probe before trusting.

**Why generalizable**: Architectures with cross-referencing components and lazy-loaded modules silently produce nulls without this awareness.

---

#### `@input` boolean defaults work in Script Asset; numeric/string defaults set there are overridden by the Script Component Inspector

**Pattern**: For an `@input` boolean with a `= true` initializer, the default propagates to new Script Component instances. For numeric and string `@input` with initializers, the **Script Component Inspector** shows an empty/zero field on first attach — the class-level default is *not* applied to the component instance unless the user opens the Inspector and explicitly sets a value (or unless the field is wired via `setProperty` at component-add time).

**Mitigation**: Don't rely on class-level initializers as runtime defaults for numeric/string `@input` fields. Either initialize defensively in `onAwake` (`if (this.speed === 0) this.speed = 1.0`), or set the value programmatically when creating the component via `ExecuteEditorCode`.

**Confidence**: VERIFY-tag — observed in LS 5.20+ for some types; precise rules differ by LS version. Worth a 1-minute probe at start of any project that depends on it.

**Why generalizable**: TS class initializers are intuitive defaults; LS's two-Inspector model (Asset vs Component) makes them unreliable.

---

#### Underscore-prefixed `@input` fields ARE shown in Inspector — they're not "private"

**Pattern**: Many JS/TS codebases use `_` prefix to mean "internal, don't touch from outside". For `@input` fields, this convention has no effect — `@input public _internalState: number` shows in the Script Component Inspector exactly the same as `state: number`. There is no hide-from-Inspector decorator for `@input`.

**Mitigation**: If a value should be persisted but never exposed in Inspector, don't decorate it with `@input`. Use a plain `private` field initialized in `onAwake`. If a value needs both persistence and Inspector hiding, redesign — LS treats `@input` as the public-Inspector contract.

**Source**: https://developers.snap.com/lens-studio/features/scripting/script-components — official.

**Confidence**: official docs.

**Why generalizable**: The "underscore means private" convention is widely held but doesn't apply at the Inspector boundary.

---

#### Shader Graph / VFX Graph / Script Graph node structure is NOT editable via the public Editor API (LS 5.21, empirically verified)

**Pattern**: The three graph editors (Material/Shader Graph, VFX Graph, Visual Scripting / Script Graph) are authored exclusively in their own UI panels. The Editor Scripting API exposes:

- `ShaderGraphPass` as an asset type with only `id`, `type`, `meta`, `getOwnedEntities`, `getDirectlyReferencedEntities`, `name`, `fileMeta`, `cacheFile` as enumerable properties. No `graph`, no `nodes`, no `connections`.
- `Material` asset's `passInfos[i]` exposes render-state flags (`blendMode`, `twoSided`, `depthWrite`, `cullMode`, `defines`, etc.) — but no path into the underlying graph nodes.
- `Editor.Graph.convertGraphToYaml` / `convertYamlToGraph` exist at runtime but are **NOT in the public TypeScript types** (`keyof typeof Editor.Graph` resolves to `string`, namespace declared empty). Their two-argument signature is undocumented; calling with various plausible inputs (asset, asset id, cacheFile, asset+null, asset+undefined, asset+self) all return "Object is null".
- The on-disk format `.ss_graph` is **binary**, not text/YAML — direct file-write workarounds are impractical (magic bytes + tag-value blocks for MetaData/Nodes/ChildNodes).
- `createAsset(type: "ShaderGraphPass", ...)` is not supported via `asset-graphql` — the type is not in the `assetTypes` list.

**What CAN be done programmatically**:

- Material **parameter values** (tint, threshold, texture bindings) — via runtime `material.mainPass.X = value` or via `scene-graphql` setProperty on the Visual component.
- VFX **property values** — via runtime `script.vfx.asset.properties['name'] = value`.
- Visual Script **asset binding** — assign which `.vs` asset a `VisualScriptComponent` references, enable/disable the component.
- Material **add/remove passes** (`addPass`, `passInfos[i]` render-state mutations).
- Material **creation/deletion** via `asset-graphql` `createAsset(type: "Material")` — but the new material has 0 passes by default; a shader preset has to be applied via the UI.

**What CANNOT be done programmatically**:

- Adding, deleting, renaming, or reconnecting nodes in any of the three graph editors.
- Reading the graph's node/wire structure for analysis or diff.
- Programmatically applying a different shader preset to an existing Material (must be drag/drop in UI).

**Mitigation**: Treat graph authoring as a **user-only surface**. Use MCP `SetLensStudioSelection` to direct the user to the right asset, then verbally describe the node-level change you want — let them make it in the UI. For Phase 3 polish on a custom shader, lock the graph structure once and iterate only on parameter values (which CC can drive).

**Confidence**: empirically verified — direct probe against LS 5.21 via `ExecuteEditorCode` and asset-graphql, May 2026. Recheck on future LS versions in case Snap adds a public graph-mutation API.

**Why generalizable**: A common misconception is that since CC can mutate scene objects and component properties via MCP, it should also be able to author graphs. The line is precisely between "things that have public Editor API" (scene, components, asset metadata) and "things authored in dedicated graph panels" (Shader/VFX/Script Graph). CC cannot cross that line.

---

#### `@input` of type `Asset` resolves to a typed runtime reference — but only AFTER `onAwake`; `onStart` is safer

**Pattern**: An `@input public tex: Texture` field is *not* fully populated when the `@component` constructor runs. Reading `this.tex` before `onStart` (i.e., inside the constructor, or in any code path called before LS's lifecycle dispatches `OnStartEvent`) may yield `null` even when the asset is wired in Inspector.

**Mitigation**: Touch `@input` asset references in `onStart` or later, not in the constructor or top-level field initializers. For `onAwake`-time reads, immediately null-check and treat null as a transient state, not an error.

**Confidence**: VERIFY-tag — applies broadly across LS 5.x but exact lifecycle ordering varies. Safe default: defer asset access to `onStart`.

**Why generalizable**: Constructor-time logic ported from other TS/JS contexts breaks silently on LS asset inputs.

---

### Tween + VFX

#### Tween Manager MUST be the very first item in the Scene Hierarchy

**Pattern**: The `TweenManager` object must be the first item in the Scene Hierarchy panel. If other scripts initialise before TweenManager, any tween triggered on lens start throws `"Tween [name] is not found. Ensure that [name] is on 'Lens Turn On' and that Tween Manager is at the top of the Objects Panel"` and silently skips playback.

**Mitigation**: After any hierarchy refactor (especially grouping objects under root folders), verify TweenManager is still at the top of the Objects panel. This isn't enforced by the editor.

**Source**: https://fritz.ai/tween-manager-in-lens-studio/ (Jan 2024) + AR Bootcamp + community forum.

**Confidence**: multi-source.

**Why generalizable**: Refactoring the hierarchy for organisational reasons silently reactivates the bug. Easy to introduce, hard to spot in code review.

---

#### GPU particle `External Time` must be checked per-material — `ExternalTimeController.js` doesn't toggle it

**Pattern**: `ExternalTimeController.js` only controls a GPU particle material's time if the `External Time` checkbox on that specific material is enabled in the Inspector. The script does NOT toggle this flag itself and provides no warning if it's missing — the particle plays from its own internal timer as if the script weren't attached.

**Mitigation**: For every particle effect intended to be script-controlled, manually check `External Time` on each material in the Inspector. There's no TypeScript-accessible API equivalent — invisible to code review.

**Source**: https://developers.snap.com/lens-studio/features/graphics/particles/gpu-particles/overview — official.

**Confidence**: official docs.

**Why generalizable**: Inspector-only configuration that affects runtime behaviour bypasses both code review and TypeScript type-checking.

---

### Prefab behaviour

#### Prefab root Transform is NOT saved — only children's transforms persist

**Pattern**: In LS 5.x, the Transform (position, rotation, scale) of the **root** prefab object is intentionally not persisted in the Prefab Resource. Only children's transforms are saved. The Apply button doesn't activate for root Transform changes; root-scale edits take effect in the editor but are lost on save/reopen.

**Mitigation**: For any resizable prefab (e.g. a UI element that should scale per-instance), nest everything one level deep and apply Transform changes to a child wrapper, not the prefab root.

**Source**: https://www.reddit.com/r/Spectacles/comments/1r6faj7/lens_studio_more_updating_prefab_woes_scale/ — Feb 2026, **Snap team confirmed as intentional** + https://developers.snap.com/lens-studio/lens-studio-workflow/prefabs.

**Confidence**: official docs (multi-source, Snap-confirmed).

**Why generalizable**: Prefab-based component systems that expect the root to carry its own scale will silently lose the scale on every save — easy to miss until a colleague reports "my prefab keeps resetting".

---

#### Prefabs created via Asset Browser (instead of Scene Hierarchy) are EMPTY and can crash LS on exit

**Pattern**: Creating a prefab directly in the Asset Browser panel, adding sub-objects/components there, then dragging to the Scene Hierarchy results in an empty prefab in the scene — Asset-Browser-only edits aren't tracked by LS's save system. Quitting LS while this state persists can crash.

**Mitigation**: Always build in the Scene Hierarchy first, then drag the assembled object to the Asset Browser to create the prefab. Any editor-scripting automation that creates prefabs via Asset Browser API must validate output before use.

**Source**: https://www.reddit.com/r/Spectacles/comments/1qseml9/creating_a_prefab_via_the_asset_browser_doesnt_work/ — Jan 2026, Snap staff confirmed.

**Confidence**: single-source (but Snap-confirmed).

**Why generalizable**: A natural workflow ("create asset where assets live") silently produces broken state + crash risk.

---

#### `.lso` is deprecated — `.lspkg` is the LS 5.x native format; `.lso` imports drop custom Render Layers

**Pattern**: `.lso` is deprecated in LS 5.x; `.lspkg` (Native Package) is its replacement. When importing an `.lso` containing non-default Render Layers (anything other than `Default` and `Orthographic`), the custom layer names aren't imported and the objects silently revert to the Default layer.

**Mitigation**: For new asset distribution use `.lspkg`. For legacy `.lso` imports, audit the Render Layer assignments after import and re-create custom layers manually.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official.

**Confidence**: official docs.

**Why generalizable**: Studios sharing assets between LS 4 and LS 5 projects via `.lso` (still common during migration) silently break layer isolation.

---

### Asset loading & migration traps

#### `requireAsset()` resolves SYNCHRONOUSLY at scene load — missing assets HARD-error, no graceful null

**Pattern**: `requireAsset('./MyTexture')` resolves at script evaluation time during `OnAwake`. If the asset file is missing or the path is wrong, LS throws a hard error that prevents the entire script from running — no try/catch recovery, no fallback null return.

**Mitigation**: Treat asset paths as build-time constants. After any rename/move in the Asset Browser, immediately update all `requireAsset()` callers — TypeScript won't warn at compile time.

**Source**: https://developers.snap.com/lens-studio/api/lens-scripting/functions/Built-In.requireAsset — official.

**Confidence**: official docs.

**Why generalizable**: Asset paths are common refactoring targets. The hard-fail-on-load behaviour means one rename can take down the entire script.

---

#### LSO export does NOT include prefab references unless a script has `@input Asset.ObjectPrefab` pointing to it

**Pattern**: Exporting an `.lso` containing a prefab will NOT include the prefab asset itself in the export unless at least one script in the hierarchy has a declared `@input Asset.ObjectPrefab` reference. Otherwise only the instantiated objects are exported — re-importing the `.lso` in another project yields the scene without prefab linkage.

**Mitigation**: Before exporting `.lso` for asset sharing, ensure at least one script has an `@input Asset.ObjectPrefab` reference to every prefab you want included. Or migrate to `.lspkg`, which bundles everything correctly.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official.

**Confidence**: official docs.

**Why generalizable**: Studio asset-sharing workflows that rely on `.lso` for prefab distribution silently drop the prefab definition. Receiver gets a broken scene with no diagnostic.

---

#### `.lsproj` (LS 4) projects CANNOT be opened in LS 5 — no in-place upgrade

**Pattern**: LS 5 uses `.esproj`. LS 4 `.lsproj` files can't be opened in LS 5 directly. The only migration path is export from LS 4 (as `.lso` / `.lsmat`) and import into a fresh LS 5 project.

**Mitigation**: Maintain parallel LS 4 and LS 5 installs during migration projects (they can run simultaneously — open LS 4 first). Don't promise "we'll port the old project to 5.x" in under a day; it's a manual asset-by-asset migration.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official.

**Confidence**: official docs.

**Why generalizable**: Sets a hard scope-expectation for any "port the old lens to current LS" brief — it's never a one-click upgrade.

---

#### GPU Particles from before LS 4.53 need BOTH shader AND mesh replaced after migration

**Pattern**: Migrating pre-4.53 GPU particle effects to LS 5 requires (1) swapping the material shader to the new `gpu_particles` shader AND (2) updating the `Render Mesh Visual` mesh to the new `GPUParticlesMesh`. Doing only the shader swap leaves a visually broken effect with no editor error — the old mesh is accepted without validation.

**Mitigation**: When porting a legacy GPU particle, change both assets and verify on device. Version-stamp particle assets in your project documentation so future maintainers know what generation they belong to.

**Source**: https://developers.snap.com/lens-studio/overview/migrating-to-lens-studio/migrating-to-lens-studio-5 — official.

**Confidence**: official docs.

**Why generalizable**: Long-lived particle effects (built across multiple LS generations) pass editor validation but render incorrectly on device — exactly the class of bug that escapes desktop QA.

---

#### `Physics.WorldSettingsAsset` is NOT added by default in LS 5.x — physics-using lenses may fail publish

**Pattern**: In LS 4.x, a `Physics World Settings` asset was automatically present in every project. LS 5.x doesn't add it by default. Physics-using components use engine defaults silently in the editor but may surface `"Factory found an inaccessible type: Physics.WorldSettingsAsset"` when publishing to older Snapchat clients.

**Mitigation**: For any physics-using lens, explicitly add `Asset Browser → + → Physics World Settings` as a required project setup step. Add to the Phase 1 checklist if physics is in the brief.

**Source**: https://developers.snap.com/lens-studio/features/physics/physics-component — official.

**Confidence**: official docs (multi-source).

**Why generalizable**: Physics works in preview, fails on publish, silently — exactly the "shipped a broken lens" failure mode that should never happen.

---

#### Masking Component does not visibly clip Text grandchildren in LS 5.21 (confirmed regression)

**Pattern**: Snap's official documentation for Masking Component states that Screen Text placed under a Masking parent should be clipped to the parent's bounds. Empirical testing in Lens Studio 5.21 contradicts this: a `MaskingComponent` on any SceneObject — whether with or without a child Image as stencil shape, whether the Text is a direct child or a grandchild — fails to visibly clip the Text. The text either renders without any clipping (when Masking is disabled) or fails to render entirely (when Masking is enabled with the default material setup).

**Anti-pattern**: Following the documented setup `ScreenTransform → MaskingComponent → [child ScreenTransform → Text]`, then expecting the Text to be pixel-clipped at the parent's anchor bounds. Adding an Image to define the mask shape (with any standard material — `ImageMaterialPreset` clone, etc.) does not fix it; the Image either obscures the Text visually or has no effect on rendering at all.

**Mitigation**: Use a script-based "fully fits" alpha gate as an `UpdateEvent` during animation: per-frame, compute each Text slot's effective bbox (slot anchors plus an asymmetric margin for text overflow), test whether it fits inside the intended viewport's anchor range, and set `textFill.color.w` to 1 (inside) or 0 (outside). An asymmetric margin (`topMargin > bottomMargin`) keeps two-line-wrap text from leaking past the top edge while still letting slots enter smoothly from below. Trade-off: slots pop in/out at viewport edges rather than being pixel-clipped mid-glyph.

**Snap's own acknowledgment**: The official Masking Component docs page states: *"Currently, there is a known bug with masking interactions. This will be addressed in an upcoming Lens Studio release."* Snap also documents that Masking "depends on stencil buffer usage" and "may conflict with any other features that depend on the stencil buffer" — but does not list which features. Empirically the failure is not specific to any one conflicting component: it reproduces in a freshly-created SceneObject under `Full Frame Region` with no other components nearby.

**Source**: https://developers.snap.com/lens-studio/lens-studio-workflow/scene-set-up/2d/masking-component — official docs; "known bug" acknowledgment quoted verbatim from the live page as of 2026-05-26.

**Confidence**: empirical, verified across multiple isolated probes (vanilla Text + Masking under Full Frame Region, Text + Masking + Image with default material, Text grandchild under an intermediate parent transform).

**Alternative path not yet validated**: For genuine pixel-perfect masking the recommended fallback is a custom shader via Material Editor or Shader Graph using an Opacity Texture on the Text's own material — bypasses the Masking Component / stencil pipeline entirely. Multi-hour investment; defer if the script-based alpha gate is acceptable for the project.

**Why generalizable**: Many lens designs need clipped-text effects — scrolling tickers, slot-machine reels, scrollable lists, rolling counters. The documented Masking + Screen Text pattern is the obvious first try, and currently fails in LS 5.21. Future colleagues lose hours unless this gotcha is captured.

---

#### Asset Library custom components built for older LS versions may fail with `Cannot find module ./XYZ_NNN` errors

**Pattern**: Older Asset Library custom-component `.lsc` files (e.g. UI Scroll View v4.49, Roulette UI v4.53) embed versioned references to helper modules — for example `./EventModule_101`, `./DestructionHelper_100`. In LS 5.21 these versioned references don't resolve even after installing the corresponding standalone module packages (`Event_Module.lspkg`, `Destruction_Helper_Module.lspkg`) — the standalone module's internal name does not match the version-suffixed reference embedded in the older `.lsc`. The Preview pauses with `InternalError: Cannot find module: ./EventModule_101` and the lens cannot run.

**Mitigation**: Before committing to an Asset Library custom component as a project foundation, install it in isolation against a vanilla Screen Text in a side scene. If the Preview pauses with module-resolution errors, the asset is incompatible with the current LS version — fall back to building the equivalent feature from primitives or to a newer asset.

**Source**: empirical (Lens Studio 5.21.0.26050122), reproduced with multiple Asset Library `.lsc` components.

**Confidence**: empirical, definitively reproduced.

**Why generalizable**: Asset Library is the obvious first stop for any "I want X custom UI behaviour" brief. When the asset's `.lsc` version is older than the current LS major/minor, this failure surfaces silently — designers and engineers waste time wiring inputs before discovering the asset doesn't run.

---

## Adding new findings

When a new API gotcha is discovered during a lens project, add an entry here with:

- Working pattern (code example)
- Anti-pattern (what looked correct but failed)
- Use case (when this comes up)
- Optional: validation method (how it was confirmed)

Keep entries concise. The value of this file is fast lookup, not exhaustive documentation.
