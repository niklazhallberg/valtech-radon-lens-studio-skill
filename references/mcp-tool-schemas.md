# MCP tool schemas — empirical capture

**Source:** ToolSearch probe via Claude Code MCP connection to Lens Studio
**Captured:** 2026-05-13
**LS version:** 5.x (current at capture)
**Status:** Empirical. Snap can change this API without warning. Re-probe at major LS bumps.
**Use:** Lookup reference for exact parameter structure when Claude Code calls MCP tools.

---

## Important caveats (mentor-honest)

1. **JSONSchema ≠ usage example.** Schemas show parameters; for HOW-to-use, read `snap-docs/01-mcp-and-claude-code/developer-mode.md` + `custom-prompt-for-mcp.md`.
2. **GraphQL tools have TRUNCATED descriptions.** `scene-graphql` and `asset-graphql` have schema strings too long for ToolSearch to return in full. I capture the queries I SEE and flag that more exist. For unlisted queries: run a bad query via the tool and read the error output (queries are listed there).
3. **Probe live before trust.** If a parameter doesn't behave as documented, call it with a deliberately bad value and inspect the error.
4. **Use cases are my synthesis**, not official Snap statements. Verify against a live run when in doubt.

---

## Tool inventory (20 tools, 6 categories)

| Tool | Category |
|---|---|
| `scene-graphql` | Scene mutation / inspection |
| `GetBoundingBox` | Scene mutation / inspection |
| `SetLensStudioSelection` | Scene mutation / inspection |
| `asset-graphql` | Asset mutation / inspection |
| `InstallLensStudioPackage` | Asset mutation / inspection |
| `InstallLicensedMusic` | Asset mutation / inspection |
| `SearchLensStudioAssetLibrary` | Asset mutation / inspection |
| `SearchLensStudioMusicLibrary` | Asset mutation / inspection |
| `ListInstalledPackagesTool` | Asset mutation / inspection |
| `CapturePanelScreenshotTool` | Panel / UI inspection |
| `ListAllPanels` | Panel / UI inspection |
| `FileReadTool` | File / scripting |
| `FileEditTool` | File / scripting |
| `FileGrepTool` | File / scripting |
| `ExecuteEditorCode` | File / scripting |
| `RecompileTypeScriptTool` | File / scripting |
| `GenerateFast3DAssets` | Generation (AI) |
| `GenerateLensIcon` | Generation (AI) |
| `RunAndCollectLogsTool` | Runtime / Knowledge |
| `QueryLensStudioKnowledgeBase` | Runtime / Knowledge |

---

# What MCP CANNOT do

The MCP server covers introspection, mutation, scripting, asset/music
library, AI generation — but some Lens Studio operations **cannot**
be driven via MCP. Knowing the boundaries before probing saves time
and frustration.

Source: Snap's official docs (`snap-docs/01-mcp-and-claude-code/custom-prompt-for-mcp.md`,
`snap-docs/01-mcp-and-claude-code/developer-mode.md`) cross-validated
against external capability mapping 2026-05-13.

| Operation | Type | Note |
|---|---|---|
| Create new project from template | UI-only | The New Project dialog can't be triggered via MCP. Use the LS UI; MCP can take over afterward |
| Import 3D files from disk (FBX/GLB/OBJ) | UI-only | No `Import3DModel` tool exists. Drag-and-drop to Asset Browser or `File → Import Asset`. MCP alternative: `GenerateFast3DAssets` for AI-generated models (not brand assets) |
| Open the FBX Import Options dialog | UI-only | Material, animation, vertex-color flags are set via the dialog, not via MCP |
| Initiate lens submission | UI-only | No `SubmitLens` tool. Submission via `my-lenses.snapchat.com` or the LS UI |
| Buy premium assets from Asset Library | UI-only | The purchase flow requires UI/web portal. `InstallLensStudioPackage` handles free assets — the premium flow is not publicly documented |
| Edit Visual Script graphs | UI-only | Visual Script nodes are not in the MCP schema. Doesn't affect TypeScript agent flows |
| Modify Material Editor nodes graphically | Mostly UI | PBR properties (baseColor etc.) can be set via `scene-graphql`/`asset-graphql` mutations on `mainMaterial.passInfos.0.*`. The shader graph's node surface requires UI |
| Pair a mobile device with Lens Studio | UI-only | The device-pairing flow is UI-driven. MCP cannot trigger QR code generation |
| Change Project Settings (lens name, icon, applicability) | Mostly UI | `lensApplicability` + `trackingModes` can be set via Editor.Model.MetaInfo write-back (see `mcp-setup.md` §Transient-view-persistence). Other Project Settings fields unclear |
| Start/stop the MCP server | UI-only | Requires AI Assistant → MCP → Configure Server. MCP cannot restart itself |
| Trigger ⌘S (save) | UI-only / manual | Mutations live in-memory. The user has to save manually. See Operational Rule 2 (⌘S handshake) |

## Desktop Preview limitations (separate from MCP limits)

Desktop Preview does NOT run all ML models — including foot tracking. MCP
can prepare the scene perfectly, but visual verification requires a real
device via QR code preview. Details + per-body-part matrix:
`./body-anchored-calibration.md` §Desktop-preview-limitations.

## Implication for agent flows

- **Phase 0 spec**: Note if the brief requires anything UI-only. If yes:
  plan manual steps into the timeline.
- **Phase 1 scaffolding**: For 3D assets from the client: pause for
  user-driven import before MCP positioning takes over.
- **Phase 4 device test**: Pairing must be prepared before
  phase-start.
- **Phase 5 submission**: Submission is 100% manual. The MCP flow
  ends at "lens works in preview".

---

# Official tool names ↔ MCP client names

Snap's official documentation (system-prompt examples,
ChatTool API) uses "normalized names" like
`GetLensStudioSceneGraph`, `SetLensStudioProperty`,
`CreateSceneObjectFromPresetTool`. Our empirical capture via
ToolSearch sees MCP client names like `scene-graphql`,
`asset-graphql`, etc.

These are **the same server, two different abstraction layers**:

- **Official names** = procedural wrappers documented in
  Snap's agent system prompt (see
  `snap-docs/01-mcp-and-claude-code/custom-prompt-for-mcp.md`)
- **MCP client names** = what Claude Code/Cursor/VS Code actually
  sees via `localhost:[port]/mcp` — primarily GraphQL transport
  plus specialized tools

> **Version disclaimer:** Tool names may vary between
> LS versions. Our capture is from LS 5.x 2026-05-13.
> Verify with a live probe on discrepancy.

## Identical names (no aliases)

| Tool | Function |
|---|---|
| `SearchLensStudioAssetLibrary` | Asset Library search |
| `InstallLensStudioPackage` | Installation from Asset Library |
| `SearchLensStudioMusicLibrary` | Music search |
| `InstallLicensedMusic` | Music install |
| `ListInstalledPackagesTool` | List installed packages |
| `RunAndCollectLogsTool` | Preview refresh + log capture |
| `GenerateFast3DAssets` | AI 3D generation |

## Different names, same function

| Snap docs | Our capture | Likely reason |
|---|---|---|
| `QueryLensStudioRag` | `QueryLensStudioKnowledgeBase` | Name evolution; our empirical is current as of 2026-05-13 |
| `CompileWithLogsTool` | `RecompileTypeScriptTool` | Same underlying tool; ours is exposed with a clearer action verb |
| `ReadWriteTextFile` (1 tool) | `FileReadTool` + `FileEditTool` + `FileGrepTool` (3 tools) | Snap's prompt example describes consolidated read+write; our client sees three more granular surfaces |

## Official tools → our client equivalent (GraphQL transport)

Many official tools are exposed as GraphQL queries within
`scene-graphql` or `asset-graphql`. Use these GraphQL
queries in client calls.

### Scene introspection

| Snap docs | Our client path |
|---|---|
| `GetLensStudioSceneGraph` | `scene-graphql` with `rootSceneObjects { ... }` |
| `GetLensStudioSceneObjectById` | `scene-graphql` with `sceneObject(id) { ... }` |
| `GetLensStudioSceneObjectByName` | `scene-graphql` with `allSceneObjects(nameContains: "X") { ... }` |

### Asset introspection

| Snap docs | Our client path |
|---|---|
| `ListLensStudioAssets` | `asset-graphql` with `allAssets { ... }` |
| `GetLensStudioAssetById` | `asset-graphql` with `asset(id) { ... }` |
| `GetLensStudioAssetByPath` | `asset-graphql` with `assetByPath(path) { ... }` |
| `GetLensStudioAssetsByName` | `asset-graphql` with `assetsByName(name) { ... }` |

### Scene mutation

| Snap docs | Our client path |
|---|---|
| `CreateLensStudioSceneObject` | `scene-graphql` mutation |
| `DeleteLensStudioSceneObject` | `scene-graphql` mutation |
| `RenameLensStudioSceneObject` | `scene-graphql` mutation |
| `DuplicateLensStudioSceneObject` | `scene-graphql` mutation |
| `SetLensStudioParent` | `scene-graphql` mutation |
| `SetLensStudioProperty` | `scene-graphql` mutation (for scene target) or `asset-graphql` mutation (for asset target like material) |
| `CreateLensStudioComponent` | `scene-graphql` mutation |

### Asset mutation

| Snap docs | Our client path |
|---|---|
| `CreateLensStudioAsset` | `asset-graphql` with `createAsset(type, name)` |
| `DeleteLensStudioAsset` | `asset-graphql` with `deleteAsset(id)` |
| `RenameAsset` | `asset-graphql` with `renameAsset(id, newName)` |
| `MoveLensStudioAsset` | `asset-graphql` mutation |
| `DuplicateLensStudioAsset` | `asset-graphql` mutation |

### Preset flows

| Snap docs | Our client path |
|---|---|
| `GetPresetRegistryTool` | `scene-graphql` with `presets(type?)` or `asset-graphql` with `presets` |
| `CreateSceneObjectFromPresetTool` | `scene-graphql` mutation with preset reference |
| `CreateComponentFromPresetTool` | `scene-graphql` mutation with preset reference |
| `CreateAssetFromPresetTool` | `asset-graphql` mutation with preset reference |

## Tools in our capture, not in Snap's docs

Specialized tools not exposed as "normalized names" in Snap's
system-prompt examples but present via ToolSearch.
Operationally important for agent flows:

| Tool | Use for |
|---|---|
| `SetLensStudioSelection` | Highlight SceneObject in LS Inspector (Inspector handoff) |
| `CapturePanelScreenshotTool` | Visual verification via panel screenshots |
| `ListAllPanels` | Discover panel IDs |
| `GetBoundingBox` | AABB measurement for mesh-pivot/scale calibration |
| `ExecuteEditorCode` | Direct Editor API access via TypeScript |
| `GenerateLensIcon` | AI-generated lens icon for draft/WIP |

## Tools in Snap's docs, not in our capture

Listed in Snap's system-prompt examples but not captured via our
ToolSearch 2026-05-13. Possible they're exposed under a different LS
config or with specific ChatTool packages installed.
Probe live if needed:

| Snap docs | Described function |
|---|---|
| `GetLensStudioLogsTool` | Ad-hoc log read without preview refresh |
| `InstantiateLensStudioPrefab` | Prefab instantiation in scene |
| `CreatePrefabFromSceneObject` | Convert SceneObject to prefab |
| `GenerateThreeDAssetTool` | Detailed 3D AI generation (vs Fast3D) |
| `GenerateTexture` | AI textures from text prompt |
| `GenerateFaceMaskTexture` | AI face mask for face filter |
| `GetLensStudioContextMenuQueue` | Read the "Use as AI Context" queue |
| `CheckAiContextQueue` | Poll AI context state |
| `GetAiContextMenuQueue` | Read AI context menu state |
| `LensStudio` | General environment context (env info) |

---

# Scene mutation / inspection

## `mcp__lens-studio__scene-graphql`

**Category:** Scene mutation / inspection
**Description:** Query and mutate the Lens Studio scene graph via GraphQL.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | GraphQL query or mutation as a string |

**Available queries (partial — the schema description was truncated):**

- `rootSceneObjects(hasComponent?, nameContains?, hasProperty?, limit?, offset?) -> [SceneObject]`
- `allSceneObjects(...)` — all scene objects with filter
- `sceneObject(id) -> SceneObject` — single object by UUID
- `sceneObjectCount(...) -> Int`
- `prefabSceneObjects(prefabId, ...) -> [SceneObject]`
- `presets(type?: ScenePresetType) -> [ScenePreset]`
- `preset(presetName)`
- *(more exist — the schema was truncated; probe live for a complete list)*

**Filter arg format:**
- `hasComponent`: partial match, case-insensitive (e.g. `"Camera"`, `"Foot Tracking"`)
- `nameContains`: partial match, case-insensitive
- `hasProperty: PropertyFilter` — filter by component property key/value

**Use cases:**
- Hierarchy walk (step 1 of the body-anchored-calibration probe protocol)
- Find components by type (`hasComponent: "Foot Tracking"`)
- Verify mutation result (read-back after setProperty / createSceneObject)
- Probe-driven calibration

**Cross-ref:** `./snap-docs/01-mcp-and-claude-code/developer-mode.md`; `./body-anchored-calibration.md` (hierarchy walk).

---

## `mcp__lens-studio__GetBoundingBox`

**Category:** Scene mutation / inspection
**Description:** Get a single axis-aligned bounding box (AABB). Returns ONE encompassing boundary for an object, multiple objects, or the whole scene.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `action` | enum | ✅ | `"get_object_bounds"` or `"get_scene_bounds"` |
| `boundingObjectIds` | string[] | conditional | For `get_object_bounds`: one or more scene object UUIDs; the result is a single encompassing AABB of all |
| `includeChildren` | boolean | optional (default false) | Include given objects + all descendants |
| `includeDisabled` | boolean | optional (default false) | Include disabled scene objects + disabled components |
| `colliderOnly` | boolean | optional (default false) | Only collider bounds; if false, prefers collider but falls back to mesh + transform AABB |

**Use cases:**
- Probe FileMesh AABB before scale mutations (body-anchored-calibration step 6 — mesh-pivot awareness)
- Verify that content is within scene bounds
- Center-of-mass calculation for object groups

**Cross-ref:** `./body-anchored-calibration.md` step 6 (AABB formula + scale-dependent compensation).

---

## `mcp__lens-studio__SetLensStudioSelection`

**Category:** Scene mutation / inspection
**Description:** Manages the current selection in Lens Studio. Supports 3 modes: `set` (replace), `add` (add to), `clear`. For `set` and `add`: only items of the same type (scene objects OR assets, not a mix).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `mode` | enum | optional (default `"set"`) | `"set"` / `"add"` / `"clear"` |
| `ids` | string[] | conditional | UUIDs to select. Required for `set` and `add`. All the same type. Not required for `clear`. |

**Use cases:**
- Highlight an object in Scene Editor for the user ("look at this node")
- Set selection before a manual action in LS (e.g., before the user is going to check Inspector)
- Cleanup between probes

**Cross-ref:** `./snap-docs/04-scene-and-components/lens-studio-interface/`.

---

# Asset mutation / inspection

## `mcp__lens-studio__asset-graphql`

**Category:** Asset mutation / inspection
**Description:** Query and mutate Lens Studio project assets via GraphQL.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | GraphQL query or mutation as a string |

**Available queries (partial):**

- `allAssets(typeFilter?, nameContains?, pathFilter?, showPackedContent?, limit?, offset?) -> [Asset]`
- `asset(id) -> Asset` — single by UUID
- `assetByPath(path) -> Asset` — e.g. `"Assets/Materials/MyMaterial.mat"`
- `assetsByName(name, exactMatch?) -> [Asset]`
- `assetTypes -> [String]` — valid creatable types
- `assetCount(...) -> Int`
- `presets -> [AssetPreset]`
- `preset(presetName) -> AssetPreset`

**Available mutations (partial):**

- `createAsset(type, name, destinationPath?) -> AssetMutationResult`
- `renameAsset(id, newName) -> AssetMutationResult`
- `deleteAsset(id) -> AssetMutationResult` — also deletes the underlying file for file-backed assets
- *(more exist — the schema was truncated)*

**Use cases:**
- Probe FileMesh properties before scale mutations
- Inspect material properties before mutation
- Create runtime assets (materials, render targets)
- Asset audit before Phase 5 submission

**Cross-ref:** `./snap-docs/03-assets-pipeline/asset-library/`; `./body-anchored-calibration.md` (AABB read step 6).

---

## `mcp__lens-studio__InstallLensStudioPackage`

**Category:** Asset mutation / inspection
**Description:** Installs a package from a URI. Works with both local and remote URIs. Use this to import/install assets from Asset Library. Note: Some packages auto-instantiate in the scene after install — use scene introspection before instantiation to avoid duplicates.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `packageUri` | string | ✅ | URI of the package to install |
| `assetName` | string | optional | Asset library name (if the filename isn't clear enough) |

**Use cases:**
- Install Try-On Pack Sneakers from Asset Library (foot tracking starting point)
- Install Foot Tracking template
- Install Snap-curated Try-On Packs for other body parts
- Install ML models from Snap's library

**Cross-ref:** `./body-anchored-calibration.md` Step 0 (Library-first sourcing); `./snap-docs/03-assets-pipeline/asset-library/`.

---

## `mcp__lens-studio__InstallLicensedMusic`

**Category:** Asset mutation / inspection
**Description:** Installs a licensed music track from the music library into the project as a LicensedAudioTrack asset. Music files are downloaded automatically on demand; not stored permanently (legal compliance).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `musicAsset` | object | ✅ | Music asset object from search results (assetUUID + name minimum) |
| `folderPath` | string | optional | Target folder path in the project |

`musicAsset` object fields:
- `assetUUID` (string, ✅) — unique ID
- `name` (string, ✅) — track name
- `artistName`, `bpm`, `duration`, `genre`, `mood`, `isExplicit` (all optional)

**Use cases:**
- Add background music / sound design to a lens
- Snap-policy-compliant ad soundtrack for Sponsored Lens
- Match music to lens tempo (snappy / cinematic)

**Cross-ref:** `./snap-docs/02-scripting-api/audio/`; `SearchLensStudioMusicLibrary` (to find the music first).

---

## `mcp__lens-studio__SearchLensStudioAssetLibrary`

**Category:** Asset mutation / inspection
**Description:** Searches the LS asset library for assets matching the specified filters. Results are paginated (limit=20, offset = index of first). `onlyMostRecent` returns only the most recent version (reduces duplicates).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `keywordFilter` | string[] | ✅ | Keywords (broad — e.g. `["cat", "dog"]` returns assets matching EITHER) |
| `onlyMostRecent` | boolean | ✅ | True = only the most recent version per asset |
| `offset` | number | optional | Pagination offset |

**Use cases:**
- Library-first sourcing (body-anchored-calibration Step 0) — search existing Try-On Packs before custom modeling
- Find sample meshes, materials, ML models
- Inventory before Phase 1 scaffolding

**Cross-ref:** `./body-anchored-calibration.md` Step 0; `InstallLensStudioPackage` (to install a found asset).

---

## `mcp__lens-studio__SearchLensStudioMusicLibrary`

**Category:** Asset mutation / inspection
**Description:** Searches the LS music library for licensed music tracks and audio assets. Use for music, songs, audio tracks, or when the user mentions artists / song titles.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `keywordFilter` | string[] | optional | Keywords (song titles, artists, descriptive terms like 'upbeat', 'calm') |
| `genreFilter` | string | optional | Genre (`"Pop"`, `"Rock"`, `"Electronic"`, etc.) |
| `moodFilter` | string | optional | Mood (`"Happy"`, `"Sad"`, `"Energetic"`, etc.) |
| `explicitContentFilter` | enum | optional (default `"exclude"`) | `"include"` / `"exclude"` / `"only"` |
| `countryCode` | string | optional | 2-char (for geographic licensing — auto-detect if not provided) |
| `onlyMostRecent` | boolean | optional (default true) | |

**Use cases:**
- Find brand-fitting music for Sponsored Lens
- Mood-matched audio (match the user's pace input — snappy/medium/slow-cinematic)
- Pre-flight licensing check (countryCode-aware)

**Cross-ref:** `InstallLicensedMusic` (to install the chosen track); `./snap-docs/02-scripting-api/audio/`.

---

## `mcp__lens-studio__ListInstalledPackagesTool`

**Category:** Asset mutation / inspection
**Description:** Lists all packages installed in Lens Studio. Useful for understanding which capabilities exist in the current project.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `includeDetails` | boolean | optional (default true) | Include detailed info per package incl. README |

**Use cases:**
- Audit installed packages on project resume
- Identify whether Try-On Pack is already installed (before re-install)
- Determine capability surface before Phase 1 scaffolding

**Cross-ref:** `InstallLensStudioPackage`; `./snap-docs/03-assets-pipeline/package-management/`.

---

# Panel / UI inspection

## `mcp__lens-studio__CapturePanelScreenshotTool`

**Category:** Panel / UI inspection
**Description:** Captures a screenshot of a dock panel as a base64-encoded JPEG. For the Preview panel: only rendered lens output (no chrome).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `pluginId` | string | ✅ | Panel plugin ID. Use `ListAllPanels` if unsure. |
| `detail` | enum | optional (default `"auto"`) | `"auto"` / `"low"` / `"high"` — image quality for AI reasoning |

**Common `pluginId` values:**
- `Snap.Plugin.Gui.PreviewPanel` — lens output
- `Snap.Plugin.Gui.SceneEditor` — 3D viewport
- `Snap.Plugin.Gui.InspectorPanel` — properties for the selected object

**Use cases:**
- Visual verification after mutation (screenshot Preview)
- Document calibration state (before/after probe)
- Debug when API state looks right but visual is wrong

**Cross-ref:** `./body-anchored-calibration.md` (image interpretation reliability — show screenshot to user, trust their text report for screen-coord judgments).

---

## `mcp__lens-studio__ListAllPanels`

**Category:** Panel / UI inspection
**Description:** Returns a list of all panel plugin IDs in the dock manager. No arguments; returns an array of available panel IDs.

**Parameters:** None.

**Use cases:**
- Discover panel IDs before `CapturePanelScreenshotTool`
- Diagnostics in non-standard LS configurations

**Cross-ref:** `CapturePanelScreenshotTool`.

---

# File / scripting

## `mcp__lens-studio__FileReadTool`

**Category:** File / scripting
**Description:** Read file contents or list directory entries. Supports line-based slicing for large files. Requires a URI scheme. Skips binary files.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `uri` | string | ✅ | URI of file/directory. Schemes: `assets://` (project assets), `packages://` (installed `.lspkg`, read-only), `project://` (project root, read-only). Append `/` for directory listing. |
| `offset` | number | optional | 0-indexed line to start from. Negative = from the end (e.g., `-10` = last 10 lines). |
| `limit` | number | optional | Max lines (or directory entries) to return |

**Use cases:**
- Read script files in `assets://Scripts/`
- Inspect installed package README via `packages://`
- Audit project state via `project://`

**Cross-ref:** `FileEditTool`, `FileGrepTool`; `./snap-docs/02-scripting-api/scripting/`.

---

## `mcp__lens-studio__FileEditTool`

**Category:** File / scripting
**Description:** Create new files or apply targeted edits via an `edits` array. Supports both overwrite (whole file) and surgical modifications (replace/insert_before/insert_after/delete) via text match or line number.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `uri` | string | ✅ | URI of the file. ONLY `assets://` scheme. Files inside sealed packages (`.lsc`/`.lspkg`) are read-only. |
| `edits` | array | ✅ | Ordered list of edit operations |

Per edit object:
- `action` (enum, ✅) — `"overwrite"` / `"replace"` / `"insert_before"` / `"insert_after"` / `"delete"`
- `target` (string) — locator. For `text` match: exact string. For `line` match: 0-indexed line or range (e.g., `"10-15"`).
- `match` (enum) — `"text"` (default) or `"line"`
- `content` (string) — new content. Required for overwrite/replace/insert_*; ignored for delete.
- `occurrence` (int, default 1) — which match (1-indexed); `0` = all.

**Use cases:**
- Create new TypeScript controllers in Phase 2
- Surgical edit of existing scripts
- Multi-edit in one call (atomic semantics per file)

**Cross-ref:** `./snap-docs/02-scripting-api/scripting/`; `RecompileTypeScriptTool` (after edit).

---

## `mcp__lens-studio__FileGrepTool`

**Category:** File / scripting
**Description:** Search for text patterns in project files via regex. Returns matching lines with optional context. Defaults to `assets://`.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `pattern` | string | ✅ | Regex pattern (avoid nested quantifiers — performance) |
| `uri` | string | ✅ | Schemes: `assets://`, `packages://`, `project://` |
| `caseInsensitive` | boolean | optional | Default false |
| `fileExtensions` | string[] | optional | E.g. `[".ts", ".js", ".json"]` |
| `contextLinesBefore`, `contextLinesAfter` | number | optional (default 0, max 5) | |
| `maxDepth` | number | optional (default 25, max 100) | Directory depth |
| `maxFileSize` | number | optional (default 1 MB) | Skip files larger than this |
| `maxResults` | number | optional (default 50, max 200) | Max matching lines |
| `multiline` | boolean | optional | `^`/`$` matches line start/end |
| `offset` | number | optional | Pagination |
| `includeDebug` | boolean | optional | Include debug info |

**Use cases:**
- Find where a specific component type is used in scripts
- Audit for deprecated API calls
- Search for TODO/FIXME comments

**Cross-ref:** `FileReadTool`, `FileEditTool`.

---

## `mcp__lens-studio__ExecuteEditorCode`

**Category:** File / scripting
**Description:** Compile + execute TypeScript code inside the LS editor. The code runs as an async function body with `pluginSystem` as the only available parameter. Type-checked against the Editor API (`editor.d.ts`). Returns `{ status, returnValue, console }` on success or `{ status, errors/error, console }` on failure.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `code` | string | ✅ | TypeScript to compile + execute. Use `pluginSystem.findInterface()` for Editor APIs. `return <value>` to produce a result. |
| `timeoutMs` | number | optional (default 30000) | Max ms for compile + execute |

**Use cases:**
- Editor-level introspection beyond the GraphQL API
- Run one-off TypeScript snippets without creating a permanent file
- Probe Editor API functions not exposed via other MCP tools

**Risks:** This is full Editor API access — use with discipline. When in doubt, probe scene-graphql first before ExecuteEditorCode.

**Cross-ref:** `./snap-docs/02-scripting-api/scripting/`; `RecompileTypeScriptTool`.

---

## `mcp__lens-studio__RecompileTypeScriptTool`

**Category:** File / scripting
**Description:** Triggers a forced TypeScript recompilation. Returns `{ status: 'succeeded' | 'failed', errors?: string[], logFile?: string }`. On failure: `errors` contains compiler error messages. Use `Read`/`Grep` on `logFile` for deeper log analysis.

**Parameters:** None.

**Use cases:**
- After `FileEditTool` edits of `.ts` files — recompile before probing
- Verify that script changes didn't break typing
- Diagnostics on runtime errors

**Cross-ref:** `FileEditTool`; `RunAndCollectLogsTool`.

---

# Generation (AI)

## `mcp__lens-studio__GenerateFast3DAssets`

**Category:** Generation (AI)
**Description:** Generates 3D assets via AI. Supports multiple assets in one request. Each generation takes ~60s; generated in parallel. Use when detail quality isn't primary. **SCALE NOTE:** Generated meshes are uniformly scaled so the longest axis = 1 cm. On import as a prefab, default scale 100 per axis is applied (=> ~100 cm longest axis). Adjust the prefab scale after instantiation to the expected real-world size.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `assets` | array | ✅ | Array of asset objects to generate |
| `assetDirectory` | string | optional (default `"GeneratedModels"`) | Folder for saved assets |

Per asset object:
- `simpleName` (string, ✅) — e.g. `"oak tree"`, `"yellow car"`
- `prompt` (string, ✅) — text describing the model
- `negativePrompt` (string, optional) — what should NOT be included
- `shadowless` (boolean, optional, default true)

**Use cases:**
- Quick placeholder assets before custom 3D lands
- Generated content for Phase 1 scaffolding
- Procedural variants (e.g., 5 different tree variations)

**Risks:** Details are often poor. Do NOT use for brand-specific assets (logos, characters). Library-first (`SearchLensStudioAssetLibrary`) before AI generation.

**Cross-ref:** `./body-anchored-calibration.md` Step 0 (Library-first); `./snap-docs/01-mcp-and-claude-code/ai-cc-example.md`.

---

## `mcp__lens-studio__GenerateLensIcon`

**Category:** Generation (AI)
**Description:** Generates an image for the lens icon from a text prompt and sets it in the project metainfo.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `prompt` | string | ✅ | Descriptive prompt (e.g. `"hot-dog"`, `"dragon"`, `"anime"`) |

**Use cases:**
- Generate placeholder icon for WIP project
- Quick icon variants for A/B testing
- Phase 5 submission prep (if no brand icon exists yet)

**Risks:** Brand projects require a brand-approved icon — AI-generated does NOT work for final submission. Use for WIP/draft only.

**Cross-ref:** `./snap-docs/07-publishing/configuring/` (icon spec).

---

# Runtime / Knowledge

## `mcp__lens-studio__RunAndCollectLogsTool`

**Category:** Runtime / Knowledge
**Description:** Refreshes all preview panels and waits for the lens reset signal. Returns `{ status, logFile, byteOffset }`. After a successful reset: use `Read` or `Grep` on `logFile` (from `byteOffset`) for runtime output + errors.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `timeoutMs` | number | optional (default 10000) | Max ms to wait for preview reset + log collection |

**Use cases:**
- Verify that scripts execute without runtime errors
- Read state-machine transition logs
- Capture `console.log` output from controllers
- Force Preview refresh after script recompile

**Cross-ref:** `RecompileTypeScriptTool`; `FileGrepTool` (for log search); `./snap-docs/04-scene-and-components/previewing-your-lens.md`.

---

## `mcp__lens-studio__QueryLensStudioKnowledgeBase`

**Category:** Runtime / Knowledge
**Description:** **DEFINITIVE SOURCE** for Lens Studio documentation and internal scripting repos. Use for LS APIs, AR Development, code debugging. **Do NOT rely on prior knowledge** for LS-specific details.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `q` | string | ✅ | Search query. Extract core technical concepts (e.g. `"AudioComponent API"`). If paginating via `offset`: USE THE EXACT SAME query string. |
| `source` | enum | optional (default `"doc"`) | `"doc"` (web docs, ~300-word chunks, fast) or `"script"` (internal repos, full files, high latency — use sparingly). |
| `limit` | integer | optional (default 3) | Number of snippets. For `script`: max 3 to avoid context-limit errors. |
| `offset` | integer | optional (default 0) | Pagination. Only use if previous results were relevant but incomplete. |

**Auth note:** `source: "doc"` is unauthenticated. For `source: "script"`: requires Snap login in LS (`My Lenses → Login`).

**Use cases:**
- Find exact API syntax for an LS component
- Verify that an assumption about a feature holds before probing
- Debug deprecated API error via KB search
- Cross-check when the snap-docs mirror is stale

**Cross-ref:** `./snap-docs/` (curated mirror — the KB is more complete); `./snap-docs/01-mcp-and-claude-code/developer-mode.md`.

---

# Maintenance

**Re-probe trigger:** On a major LS version bump, or when a tool starts behaving unexpectedly.

**Re-probe procedure:**
1. Run ToolSearch on all 20 tool names (`select:mcp__lens-studio__<name>,...`)
2. Compare against this document — diff parameter structures
3. Note which tools have changed; update sections + bump datestamp
4. Commit as `chore(v0.6.x): re-probe MCP schemas YYYY-MM-DD`

**Truncation workaround for GraphQL tools:**
- For a complete query list in `scene-graphql` / `asset-graphql`: call the tool with a bad query (`{ invalidField }`) and read the error — Snap returns a list of valid queries in the error message.
- Alternatively: use `QueryLensStudioKnowledgeBase` with `q: "scene-graphql queries"` for broader prose coverage.
