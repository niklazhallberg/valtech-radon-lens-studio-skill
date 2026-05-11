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
- ScriptComponent inputNames auto-population
- Editor API vs Lens API separation
- Transient-view persistence pattern

### MCP / mutation strategy
- Batched alias-mutation pattern (one permission prompt per logical unit)
- ToolSearch deferred-tool loading
- Inspector dropdown discipline (read-back enum changes)
- Read-back rule (success ≠ persistence)

### Coordinate system reminders

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

## Adding new findings

When a new API gotcha is discovered during a lens project, add an entry here with:

- Working pattern (code example)
- Anti-pattern (what looked correct but failed)
- Use case (when this comes up)
- Optional: validation method (how it was confirmed)

Keep entries concise. The value of this file is fast lookup, not exhaustive documentation.
