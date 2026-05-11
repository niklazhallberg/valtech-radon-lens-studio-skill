# Error recovery

Triage matrix, silent-drop recovery patterns, and rollback decision matrix for when builds break. Distinct from `troubleshooting-decision-tree.md` (which is concierge-style 1-2 question diagnosis for non-experts) — this is the deeper technical reference for CC's own recovery logic.

## Contents
- Triage matrix (first action by symptom)
- Silent-drop discovery + retry
- Rollback decision matrix
- Defensive practices
- Recovery patterns by failure category

## Triage matrix — first action when something breaks

| Symptom | First action |
|---|---|
| Mutation returns `success: false` | Read error response, classify (auth / schema / value range / missing component) |
| Mutation returns `success: true` but no visual change | Read-back to detect silent-drop or pending state (Rule 11) |
| Preview freezes or doesn't reflect changes | `RunAndCollectLogsTool` to force refresh + check logs for errors |
| Script compile fails | `RecompileTypeScriptTool` for exact error, then read log file for stack |
| Scene inconsistency (orphans, moved objects) | Query `rootSceneObjects` + targeted UUIDs to map current state |
| Effect renders in wrong region | Read back all landmark + magnitude params, compare to intent |
| MCP calls intermittently fail | Check `claude mcp list` for `✓ Connected`; LS restart = token rotation |
| `git diff` shows nothing after MCP mutations | ⌘S not done; mutations only in LS memory |
| Anna reports "it worked before, now doesn't" | Run env detection; compare to last known state in PROJECT-STATE.md commit |

## Silent-drop discovery + retry

The four silent-drop categories. For each: detection method + recovery pattern.

### Compound types (RECT, VEC4, VEC2)

**Detection**: write compound value via `valueType: RECT` etc., then query the property — only first 2 fields persist, rest silent-drop.

**Recovery**: replace with scalar NUMBER writes using dotted paths.

```graphql
# WRONG (silent-drop top + bottom)
mutation { setProperty(... valueType: RECT value: "{left:-1,right:1,top:1,bottom:-1}") }

# RIGHT (4 scalar writes in alias-batch)
mutation {
  l: setProperty(... propertyPath: "anchor.left" valueType: NUMBER value: "-1") { success }
  r: setProperty(... propertyPath: "anchor.right" valueType: NUMBER value: "1") { success }
  t: setProperty(... propertyPath: "anchor.top" valueType: NUMBER value: "1") { success }
  b: setProperty(... propertyPath: "anchor.bottom" valueType: NUMBER value: "-1") { success }
}
```

### Enum STRING writes

**Detection**: enum write with `valueType: STRING` (e.g., "LeftEyeballCenter"). Returns `success: true` but value doesn't apply or applies wrong value.

**Recovery**: read the property's `options` array, find the desired value's 0-based index, write with `valueType: NUMBER`.

```graphql
# Step 1: discover index
query { sceneObject(id: "<id>") { components { ... on HeadBinding { attachmentPoint { options } } } } }
# Result: options[3] = "LeftEyeballCenter"

# Step 2: write index
mutation { setProperty(id: "<id>" propertyPath: "attachmentPoint" valueType: NUMBER value: "3") { success } }

# Step 3: verify (Rule 11)
```

### REFERENCE to generic @input

**Detection**: REFERENCE write returns `success: true` but read-back shows `null`. Component's `inputs` query shows the @input slot type is `AssignableType_1` (generic).

**Recovery**: edit the TS source — change @input type from `any` to concrete LS class.

```typescript
// WRONG — generic slot, REFERENCE binding silently drops
// @input Asset.JsonAsset fortunes
@input fortunes!: any;

// RIGHT — concrete slot, REFERENCE binding sticks
// @input Asset.JsonAsset fortunes
@input fortunes!: JsonAsset;
```

After fix: `RecompileTypeScriptTool` → re-attempt REFERENCE write → read-back to confirm.

### `Editor.Model.MetaInfo` view drift

**Detection**: write `lensApplicability` (or other MetaInfo field). Read-back in same call shows new value; reading in a new call shows old value; saving + reloading LS shows old value.

**Recovery**: use the view write-back pattern.

```typescript
project.history.executeAsGroup("update metaInfo", () => {
  const meta = project.metaInfo;
  meta.lensApplicability = [Editor.Model.LensApplicability.Front];
  (project as any).metaInfo = meta;  // REQUIRED: reassign to canonical slot
});
```

See also `mcp-setup.md` → "Transient-view persistence pattern".

## Rollback decision matrix

When mutations were applied and need to be undone, recovery method depends on commit/save state:

| State | Rollback method | Destructive? |
|---|---|---|
| Mutations made, NOT ⌘S'd | LS: File → Revert (reload `.scene` from disk) | No — in-memory only, disk unchanged |
| Mutations ⌘S'd, NOT committed | `git checkout HEAD -- lens/Assets/Scene.scene` + LS reload | Discards in-memory + disk-saved changes |
| Mutations ⌘S'd + committed (NOT pushed) | `git reset --hard HEAD~1` + LS reload | Yes — destroys local commit. User-confirm before running. |
| Mutations pushed to origin | `git revert <hash>` + push | Safe — preserves history. Never force-push to main. |

**Rules for destructive rollbacks** (rows 2-3):
1. Get user "go reset" confirmation
2. Show what will be lost: `git log --oneline -3` + `git diff HEAD~1 HEAD` so user sees the commit being destroyed
3. Suggest backup branch first: `git branch backup-before-reset`
4. Then proceed

Never execute `git reset --hard` or `git restore` without user confirmation and visibility on what's being destroyed.

## Defensive practices

Six habits that catch errors before they propagate:

1. **Recompile after script edits, before scene-graphql wiring**:
   ```
   RecompileTypeScriptTool() → check for errors → then wire @inputs
   ```
   Wiring against a script with compile errors = silent failure (the new fields don't exist yet).

2. **Read-back after enum changes via Inspector**: Anna may click an Inspector dropdown without committing. Visual checkmark ≠ committed. Always scene-graphql read-back after user-driven Inspector enum changes.

3. **Query parent's children after `deleteSceneObject`**: deletes can orphan siblings. Verify nothing else moved unexpectedly.

4. **⌘S after every natural sub-milestone**: cost = 2 seconds. Cost of LS crash mid-build = 30+ minutes redo.

5. **Read-back ANY compound/enum/REFERENCE write**: Rule 11. Cheap insurance against the four silent-drop categories.

6. **Snapshot before risky operations**: about to do bulk mutation? Commit current state first. Local commit takes 5 seconds; provides instant rollback.

## Recovery patterns by failure category

### Category A: API mismatch (training-data drift)

**Symptom**: CC tries a method that "should exist" per training data; returns `success: false` or `method not found`.

**Recovery**:
1. Query LS KB: `mcp__lens-studio__QueryLensStudioKnowledgeBase("<feature> setProperty pattern")` (requires Snap login active in LS)
2. Compare returned pattern with what CC tried
3. Update `references/lens-studio-api-gotchas.md` with the verified pattern
4. Retry

### Category B: Hierarchy gotcha

**Symptom**: scene-graphql mutation succeeds, but element doesn't render or renders in wrong place.

**Recovery**:
1. Query parent's components — does it have ScreenTransform? (Bare `createSceneObject` doesn't.)
2. Query the failing element's anchor — are values within parent's rect?
3. Check render order — is something else drawing on top? Use `renderOrder` setProperty to layer correctly.

See `references/lens-studio-api-gotchas.md` → "createSceneObject produces bare SceneObject".

### Category C: Tween Manager not initialized

**Symptom**: TweenValue / TweenScreenTransform / TweenAlpha components exist but don't animate.

**Recovery**:
1. Query scene for `TweenManager__PLACE_IN_SCENE` SceneObject — does it exist?
2. If NO: Tween Manager package not installed. Install: Scene Hierarchy → + → Scripts → Tween Manager.
3. If YES but tweens still not firing: check tween's `target` field — is it set correctly? Read-back.

See `references/lens-studio-api-gotchas.md` → "Tween Manager package".

### Category D: ML / face-tracking entanglement

**Symptom**: face effect worked, then stopped after deleting a different SceneObject.

**Recovery**:
1. Query scene for any remaining ML components, face-tracking-driving assets
2. If the deleted SceneObject was driving face tracking globally (e.g., Face Geometry Modification package's MLComponent): face effect lost its data source
3. Either re-add the ML component or move face effect to perspective Camera + verify it has its own face-tracking trigger

See `references/lens-studio-api-gotchas.md` → "LiquifyVisual must be under perspective Camera".

### Category E: Performance regression

**Symptom**: lens was 28fps on Android, now 18fps after recent changes.

**Recovery**:
1. `git log --oneline -10` — what changed recently?
2. Run Performance Panel — which metric regressed (FPS, RAM, lens size)?
3. Common culprits: new texture without ASTC compression, new `onUpdate` loop, new Tween running every frame
4. Bisect: revert most-recent commit, re-test. If FPS recovers, that commit is the culprit. Refactor and re-commit.

## Cross-reference

- Operational rules `operational-rules.md` (especially Rule 11 — read-back)
- API gotchas `lens-studio-api-gotchas.md` — the empirical patterns recovery references
- Troubleshooting decision tree `troubleshooting-decision-tree.md` — concierge-style Anna-facing diagnosis
- MCP setup `mcp-setup.md` — connection failures, token rotation
