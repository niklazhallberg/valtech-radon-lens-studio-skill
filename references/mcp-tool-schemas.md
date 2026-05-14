# MCP tool schemas — empirical capture

**Source:** ToolSearch probe via Claude Code MCP connection to Lens Studio
**Captured:** 2026-05-13
**LS version:** 5.x (current at capture)
**Status:** Empirisk. Snap kan ändra detta API utan varsel. Re-probe vid större LS-bumps.
**Use:** Lookup-referens för exakt parameter-struktur när Claude Code anropar MCP-tools.

---

## Viktiga caveats (mentor-ärligt)

1. **JSONSchema ≠ usage example.** Schemas visar parametrar; för HUR-man-använder, läs `snap-docs/01-mcp-and-claude-code/developer-mode.md` + `custom-prompt-for-mcp.md`.
2. **GraphQL-tools har TRUNKERADE beskrivningar.** `scene-graphql` och `asset-graphql` har för långa schema-strängar för ToolSearch att returnera komplett. Jag fångar de queries jag SER och flaggar att fler finns. För ej-listade queries: kör en bad query via tool:en och läs error-output (queries listas där).
3. **Probe live före tillit.** Om en parameter inte beter sig som dokumenterat, anropa med medvetet dåligt värde och inspektera error.
4. **Use-cases är min syntes**, inte officiella Snap-uttalanden. Kontrollera mot live-körning vid tveksamhet.

---

## Tool inventory (20 tools, 6 kategorier)

| Tool | Kategori |
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

# Vad MCP INTE kan göra

MCP-servern täcker introspection, mutation, scripting, asset/music
library, AI-generation — men en del Lens Studio-operationer kan
**inte** drivas via MCP. Att känna gränserna innan probe sparar tid
och frustration.

Källa: Snap's officiella docs (`snap-docs/01-mcp-and-claude-code/custom-prompt-for-mcp.md`,
`snap-docs/01-mcp-and-claude-code/developer-mode.md`) cross-validerat
mot extern kapacitetskartläggning 2026-05-13.

| Operation | Typ | Notering |
|---|---|---|
| Skapa nytt projekt från template | UI-only | New Project-dialogen kan ej triggas via MCP. Använd LS UI; därefter kan MCP ta vid |
| Importera 3D-filer från disk (FBX/GLB/OBJ) | UI-only | Inget `Import3DModel`-tool finns. Drag-and-drop till Asset Browser eller `File → Import Asset`. Alternativ via MCP: `GenerateFast3DAssets` för AI-genererade modeller (ej brand-assets) |
| Öppna FBX Import Options-dialogen | UI-only | Material-, animation-, vertex-color-flaggor sätts via dialogen, ej via MCP |
| Initiera lens-submission | UI-only | Inget `SubmitLens`-tool. Submission via `my-lenses.snapchat.com` eller LS UI |
| Köpa premium-assets från Asset Library | UI-only | Köpflöde kräver UI/webbportal. `InstallLensStudioPackage` hanterar free assets — premium-flödet är ej publikt dokumenterat |
| Redigera Visual Script-grafer | UI-only | Visual Script-noder finns ej i MCP-schema. Påverkar ej TypeScript-agent-flöden |
| Modifiera Material Editor-noder grafiskt | UI-only | PBR-properties (baseColor etc.) kan sättas via `scene-graphql`/`asset-graphql` mutations på `mainMaterial.passInfos.0.*`. Shader-graphens nod-yta kräver UI |
| Paira mobil device med Lens Studio | UI-only | Device-pairing-flow är UI-driven. MCP kan inte trigga QR-kod-generering |
| Ändra Project Settings (lens name, ikon, applicability) | Mestadels UI | `lensApplicability` + `trackingModes` kan sättas via Editor.Model.MetaInfo write-back (se `mcp-setup.md` §Transient-view-persistence). Andra Project Settings-fält oklart |
| Starta/stoppa MCP-servern | UI-only | Kräver AI Assistant → MCP → Configure Server. MCP kan ej omstarta sig själv |
| Trigga ⌘S (spara) | UI-only / manuell | Mutationer lever in-memory. Användaren måste manuellt spara. Se Operational Rule 2 (⌘S-handshake) |

## Desktop Preview-begränsningar (separat från MCP-gränser)

Desktop Preview kör INTE alla ML-modeller — bl.a. foot-tracking. MCP
kan förbereda scenen perfekt, men visuell verifiering kräver real
device via QR-kod preview. Detaljer + per-body-part-matris:
`../body-anchored-calibration.md` §Desktop-preview-limitations.

## Implication för agent-flöden

- **Phase 0 spec**: Notera om brief kräver något UI-only. Om ja:
  planera manuella steg in i timeline.
- **Phase 1 scaffolding**: Vid 3D-asset från klient: pausa för
  user-driven import innan MCP-positionering tar vid.
- **Phase 4 device-test**: Pairing måste vara förberett före
  phase-start.
- **Phase 5 submission**: Submission är 100% manuell. MCP-flödet
  slutar vid "lens fungerar i preview".

---

# Officiella tool-namn ↔ MCP-client-namn

Snap's officiella dokumentation (system-prompt-exempel,
ChatTool API) använder "normalized names" som
`GetLensStudioSceneGraph`, `SetLensStudioProperty`,
`CreateSceneObjectFromPresetTool`. Vår empiriska capture via
ToolSearch ser MCP-client-namn som `scene-graphql`,
`asset-graphql` etc.

Dessa är **samma server, två olika abstraction-lager**:

- **Officiella namn** = procedurella wrappers dokumenterade i
  Snap's agent-system-prompt (se
  `snap-docs/01-mcp-and-claude-code/custom-prompt-for-mcp.md`)
- **MCP-client-namn** = vad Claude Code/Cursor/VS Code faktiskt
  ser via `localhost:[port]/mcp` — primärt GraphQL-transport
  plus specialiserade tools

> **Version-disclaimer:** Tool-namn kan variera mellan
> LS-versioner. Vår capture är från LS 5.x 2026-05-13.
> Verifiera med live probe vid avvikelse.

## Identiska namn (inga aliaser)

| Tool | Funktion |
|---|---|
| `SearchLensStudioAssetLibrary` | Asset Library-sökning |
| `InstallLensStudioPackage` | Installation från Asset Library |
| `SearchLensStudioMusicLibrary` | Musik-sökning |
| `InstallLicensedMusic` | Musik-install |
| `ListInstalledPackagesTool` | Installerade paket-list |
| `RunAndCollectLogsTool` | Preview refresh + log capture |
| `GenerateFast3DAssets` | AI-3D-generering |

## Olika namn, samma funktion

| Snap docs | Vår capture | Sannolik orsak |
|---|---|---|
| `QueryLensStudioRag` | `QueryLensStudioKnowledgeBase` | Namn-evolution; vår empiriska är aktuell per 2026-05-13 |
| `CompileWithLogsTool` | `RecompileTypeScriptTool` | Samma underlying tool; vår exponeras med tydligare action-verb |
| `ReadWriteTextFile` (1 tool) | `FileReadTool` + `FileEditTool` + `FileGrepTool` (3 tools) | Snap's prompt-exempel beskriver konsoliderat read+write; vår client ser tre granulärare ytor |

## Officiella tools → vår client-equivalent (GraphQL-transport)

Många officiella tools är exponerade som GraphQL-queries inom
`scene-graphql` eller `asset-graphql`. Använd dessa GraphQL-
queries i client-anrop.

### Scene-introspektion

| Snap docs | Vår client-väg |
|---|---|
| `GetLensStudioSceneGraph` | `scene-graphql` med `rootSceneObjects { ... }` |
| `GetLensStudioSceneObjectById` | `scene-graphql` med `sceneObject(id) { ... }` |
| `GetLensStudioSceneObjectByName` | `scene-graphql` med `allSceneObjects(nameContains: "X") { ... }` |

### Asset-introspektion

| Snap docs | Vår client-väg |
|---|---|
| `ListLensStudioAssets` | `asset-graphql` med `allAssets { ... }` |
| `GetLensStudioAssetById` | `asset-graphql` med `asset(id) { ... }` |
| `GetLensStudioAssetByPath` | `asset-graphql` med `assetByPath(path) { ... }` |
| `GetLensStudioAssetsByName` | `asset-graphql` med `assetsByName(name) { ... }` |

### Scene-mutation

| Snap docs | Vår client-väg |
|---|---|
| `CreateLensStudioSceneObject` | `scene-graphql` mutation |
| `DeleteLensStudioSceneObject` | `scene-graphql` mutation |
| `RenameLensStudioSceneObject` | `scene-graphql` mutation |
| `DuplicateLensStudioSceneObject` | `scene-graphql` mutation |
| `SetLensStudioParent` | `scene-graphql` mutation |
| `SetLensStudioProperty` | `scene-graphql` mutation (för scene-target) eller `asset-graphql` mutation (för asset-target som material) |
| `CreateLensStudioComponent` | `scene-graphql` mutation |

### Asset-mutation

| Snap docs | Vår client-väg |
|---|---|
| `CreateLensStudioAsset` | `asset-graphql` med `createAsset(type, name)` |
| `DeleteLensStudioAsset` | `asset-graphql` med `deleteAsset(id)` |
| `RenameAsset` | `asset-graphql` med `renameAsset(id, newName)` |
| `MoveLensStudioAsset` | `asset-graphql` mutation |
| `DuplicateLensStudioAsset` | `asset-graphql` mutation |

### Preset-flöden

| Snap docs | Vår client-väg |
|---|---|
| `GetPresetRegistryTool` | `scene-graphql` med `presets(type?)` eller `asset-graphql` med `presets` |
| `CreateSceneObjectFromPresetTool` | `scene-graphql` mutation med preset-referens |
| `CreateComponentFromPresetTool` | `scene-graphql` mutation med preset-referens |
| `CreateAssetFromPresetTool` | `asset-graphql` mutation med preset-referens |

## Tools i vår capture, ej i Snap's docs

Specialiserade verktyg som inte exponeras som "normalized names"
i Snap's system-prompt-exempel men som finns via ToolSearch.
Operationellt viktiga för agent-flöden:

| Tool | Använd för |
|---|---|
| `SetLensStudioSelection` | Highlight SceneObject i LS Inspector (Inspector handoff) |
| `CapturePanelScreenshotTool` | Visuell verifiering via panel-screenshots |
| `ListAllPanels` | Discover panel-IDs |
| `GetBoundingBox` | AABB-mätning för mesh-pivot/scale-kalibrering |
| `ExecuteEditorCode` | Direkt Editor API-access via TypeScript |
| `GenerateLensIcon` | AI-genererad lens-ikon för draft/WIP |

## Tools i Snap's docs, ej i vår capture

Listade i Snap's system-prompt-exempel men ej fångade via vår
ToolSearch 2026-05-13. Möjligt att de exponeras vid annan LS-
config eller med specifika ChatTool-packages installerade.
Probe live om de behövs:

| Snap docs | Beskriven funktion |
|---|---|
| `GetLensStudioLogsTool` | Ad-hoc log-read utan preview-refresh |
| `InstantiateLensStudioPrefab` | Prefab-instansering i scen |
| `CreatePrefabFromSceneObject` | Konvertera SceneObject till prefab |
| `GenerateThreeDAssetTool` | Detaljerad 3D-AI-generering (vs Fast3D) |
| `GenerateTexture` | AI-texturer från text-prompt |
| `GenerateFaceMaskTexture` | AI-ansiktsmask för face-filter |
| `GetLensStudioContextMenuQueue` | Läsa "Use as AI Context"-kö |
| `CheckAiContextQueue` | Polla AI-context-state |
| `GetAiContextMenuQueue` | Läs AI-context-menu-state |
| `LensStudio` | Allmän miljökontext (env-info) |

---

# Scene mutation / inspection

## `mcp__lens-studio__scene-graphql`

**Kategori:** Scene mutation / inspection
**Description:** Query och mutate Lens Studio scene graph via GraphQL.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | GraphQL query eller mutation som sträng |

**Tillgängliga queries (partial — schema-beskrivningen var trunkerad):**

- `rootSceneObjects(hasComponent?, nameContains?, hasProperty?, limit?, offset?) -> [SceneObject]`
- `allSceneObjects(...)` — alla scene-objekt med filter
- `sceneObject(id) -> SceneObject` — single object by UUID
- `sceneObjectCount(...) -> Int`
- `prefabSceneObjects(prefabId, ...) -> [SceneObject]`
- `presets(type?: ScenePresetType) -> [ScenePreset]`
- `preset(presetName)`
- *(fler finns — schema trunkerades; probe live för komplett lista)*

**Filter-arg-format:**
- `hasComponent`: partial match, case-insensitive (ex. `"Camera"`, `"Foot Tracking"`)
- `nameContains`: partial match, case-insensitive
- `hasProperty: PropertyFilter` — filter by component property key/value

**Use-cases i filter design:**
- Hierarchy walk (step 1 av body-anchored-calibration probe-protokoll)
- Hitta komponenter by type (`hasComponent: "Foot Tracking"`)
- Verifiera mutation-resultat (read-back efter setProperty / createSceneObject)
- Probe-driven calibration

**Cross-ref:** `../snap-docs/01-mcp-and-claude-code/developer-mode.md`; `../body-anchored-calibration.md` (hierarchy-walk).

### Edge case: `allSceneObjects(offset:)` + destructive mutations

> ⚠️ DEMO ENTRY — added 2026-05-14 to demonstrate skill-growth-flow.
> Not empirically verified. Safe to remove.

Vid iteration med `offset` över flera anrop, om en mutation deletes
en SceneObject mellan anropen, skiftar offset-referensen — iteratorn
hoppar över nästa item.

**Workaround:** re-query `rootSceneObjects` efter varje destructive
batch (delete, setParent som flyttar mellan grenar). Acceptera att
"snapshot during iteration"-mönstret bryts vid mutation.

---

## `mcp__lens-studio__GetBoundingBox`

**Kategori:** Scene mutation / inspection
**Description:** Få en single axis-aligned bounding box (AABB). Returnerar EN encompassing boundary för ett objekt, flera objekt, eller hela scenen.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `action` | enum | ✅ | `"get_object_bounds"` eller `"get_scene_bounds"` |
| `boundingObjectIds` | string[] | conditional | För `get_object_bounds`: ett eller flera scene object UUIDs; resultatet är single encompassing AABB av alla |
| `includeChildren` | boolean | optional (default false) | Inkludera givna objekt + alla descendants |
| `includeDisabled` | boolean | optional (default false) | Inkludera disabled scene-objekt + disabled components |
| `colliderOnly` | boolean | optional (default false) | Endast collider-bounds; om false, prefererar collider men faller tillbaka till mesh sen transform AABB |

**Use-cases i filter design:**
- Probe FileMesh AABB innan scale mutations (body-anchored-calibration step 6 — mesh-pivot awareness)
- Verifiera att content är inom scen-bounds
- Center-of-mass-beräkning för objekt-grupper

**Cross-ref:** `../body-anchored-calibration.md` step 6 (AABB-formel + scale-dependent compensation).

---

## `mcp__lens-studio__SetLensStudioSelection`

**Kategori:** Scene mutation / inspection
**Description:** Hanterar current selection i Lens Studio. Stödjer 3 modes: `set` (replace), `add` (add to), `clear`. För `set` och `add`: bara items av samma typ (scene objects ELLER assets, inte mix).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `mode` | enum | optional (default `"set"`) | `"set"` / `"add"` / `"clear"` |
| `ids` | string[] | conditional | UUIDs att välja. Krav för `set` och `add`. Alla samma typ. Ej krav för `clear`. |

**Use-cases i filter design:**
- Highlight ett objekt i Scene Editor för användaren ("titta på den här noden")
- Sätta selection innan en manuell action i LS (t.ex. innan användaren ska kolla Inspector)
- Cleanup mellan probes

**Cross-ref:** `../snap-docs/04-scene-and-components/lens-studio-interface/`.

---

# Asset mutation / inspection

## `mcp__lens-studio__asset-graphql`

**Kategori:** Asset mutation / inspection
**Description:** Query och mutate Lens Studio project assets via GraphQL.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | GraphQL query eller mutation som sträng |

**Tillgängliga queries (partial):**

- `allAssets(typeFilter?, nameContains?, pathFilter?, showPackedContent?, limit?, offset?) -> [Asset]`
- `asset(id) -> Asset` — single by UUID
- `assetByPath(path) -> Asset` — t.ex. `"Assets/Materials/MyMaterial.mat"`
- `assetsByName(name, exactMatch?) -> [Asset]`
- `assetTypes -> [String]` — valid creatable types
- `assetCount(...) -> Int`
- `presets -> [AssetPreset]`
- `preset(presetName) -> AssetPreset`

**Tillgängliga mutations (partial):**

- `createAsset(type, name, destinationPath?) -> AssetMutationResult`
- `renameAsset(id, newName) -> AssetMutationResult`
- `deleteAsset(id) -> AssetMutationResult` — raderar även underliggande fil för file-backed assets
- *(fler finns — schema trunkerades)*

**Use-cases i filter design:**
- Probe FileMesh properties innan scale mutations
- Inspect material properties innan mutation
- Create runtime assets (materials, render targets)
- Asset audit innan Phase 5 submission

**Cross-ref:** `../snap-docs/03-assets-pipeline/asset-library/`; `../body-anchored-calibration.md` (AABB-read step 6).

---

## `mcp__lens-studio__InstallLensStudioPackage`

**Kategori:** Asset mutation / inspection
**Description:** Installerar ett package från en URI. Funkar med både lokala och remote URIs. Använd detta för att importera/installera assets från Asset Library. Note: Vissa packages auto-instantieras i scenen efter install — använd scene-introspection före instantiation för att undvika dubbletter.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `packageUri` | string | ✅ | URI av package att installera |
| `assetName` | string | optional | Asset-bibliotek-name (om filnamnet inte är tydligt nog) |

**Use-cases i filter design:**
- Installera Try-On Pack Sneakers från Asset Library (foot-tracking startpunkt)
- Installera Foot Tracking template
- Installera Snap-curerade Try-On Packs för andra body-parts
- Installera ML-modeller från Snap's bibliotek

**Cross-ref:** `../body-anchored-calibration.md` Step 0 (Library-first sourcing); `../snap-docs/03-assets-pipeline/asset-library/`.

---

## `mcp__lens-studio__InstallLicensedMusic`

**Kategori:** Asset mutation / inspection
**Description:** Installerar en licensed music track från music library i projektet som en LicensedAudioTrack asset. Musikfilerna laddas ner automatiskt vid behov; lagras inte permanent (legal compliance).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `musicAsset` | object | ✅ | Music asset-objekt från search-resultat (assetUUID + name minimum) |
| `folderPath` | string | optional | Target folder path i projektet |

`musicAsset`-objektets fält:
- `assetUUID` (string, ✅) — unique ID
- `name` (string, ✅) — track-namn
- `artistName`, `bpm`, `duration`, `genre`, `mood`, `isExplicit` (alla optional)

**Use-cases i filter design:**
- Lägga till bakgrundsmusik / sound-design till en lens
- Snap-policy-compliant ad-soundtrack för Sponsored Lens
- Match-musik till lens-tempo (snappy / cinematic)

**Cross-ref:** `../snap-docs/02-scripting-api/audio/`; `SearchLensStudioMusicLibrary` (för att hitta musiken först).

---

## `mcp__lens-studio__SearchLensStudioAssetLibrary`

**Kategori:** Asset mutation / inspection
**Description:** Söker LS asset library efter assets som matchar specificerade filters. Resultat paginerade (limit=20, offset = index av första). `onlyMostRecent` returnerar bara senaste versionen (reducerar duplikater).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `keywordFilter` | string[] | ✅ | Keywords (broad — t.ex. `["cat", "dog"]` returnerar assets som matchar ENDERA) |
| `onlyMostRecent` | boolean | ✅ | True = bara senaste versionen per asset |
| `offset` | number | optional | Pagination-offset |

**Use-cases i filter design:**
- Library-first sourcing (body-anchored-calibration Step 0) — söka existerande Try-On Packs innan custom-modellering
- Hitta sample-meshes, materials, ML-modeller
- Inventory inför Phase 1 scaffolding

**Cross-ref:** `../body-anchored-calibration.md` Step 0; `InstallLensStudioPackage` (för att installera ett hittat asset).

---

## `mcp__lens-studio__SearchLensStudioMusicLibrary`

**Kategori:** Asset mutation / inspection
**Description:** Söker LS music library efter licensed music tracks och audio assets. Använd för musik, songs, audio tracks, eller när användare nämner artister / låttitlar.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `keywordFilter` | string[] | optional | Keywords (song titles, artists, descriptive terms som 'upbeat', 'calm') |
| `genreFilter` | string | optional | Genre (`"Pop"`, `"Rock"`, `"Electronic"`, etc.) |
| `moodFilter` | string | optional | Mood (`"Happy"`, `"Sad"`, `"Energetic"`, etc.) |
| `explicitContentFilter` | enum | optional (default `"exclude"`) | `"include"` / `"exclude"` / `"only"` |
| `countryCode` | string | optional | 2-char (för geographic licensing — auto-detect om ej angivet) |
| `onlyMostRecent` | boolean | optional (default true) | |

**Use-cases i filter design:**
- Hitta brand-passande musik för Sponsored Lens
- Mood-matchad audio (match user's pace-input — snappy/medium/slow-cinematic)
- Pre-flight licensing-check (countryCode-aware)

**Cross-ref:** `InstallLicensedMusic` (för att installera valt track); `../snap-docs/02-scripting-api/audio/`.

---

## `mcp__lens-studio__ListInstalledPackagesTool`

**Kategori:** Asset mutation / inspection
**Description:** Listar alla packages installerade i Lens Studio. Useful för att förstå vilka capabilities som finns i nuvarande projekt.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `includeDetails` | boolean | optional (default true) | Inkludera detaljerad info per package inkl. README |

**Use-cases i filter design:**
- Audit av installed packages vid project-resume
- Identifiera om Try-On Pack redan finns (innan re-install)
- Avgöra capability-yta innan Phase 1 scaffolding

**Cross-ref:** `InstallLensStudioPackage`; `../snap-docs/03-assets-pipeline/package-management/`.

---

# Panel / UI inspection

## `mcp__lens-studio__CapturePanelScreenshotTool`

**Kategori:** Panel / UI inspection
**Description:** Fångar screenshot av en dock-panel som base64-encoded JPEG. För Preview-panelen: bara renderad lens-output (ingen chrome).

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `pluginId` | string | ✅ | Panel plugin-ID. Använd `ListAllPanels` om osäker. |
| `detail` | enum | optional (default `"auto"`) | `"auto"` / `"low"` / `"high"` — bild-kvalitet för AI-reasoning |

**Vanliga `pluginId`-värden:**
- `Snap.Plugin.Gui.PreviewPanel` — lens-output
- `Snap.Plugin.Gui.SceneEditor` — 3D-viewport
- `Snap.Plugin.Gui.InspectorPanel` — properties för vald objekt

**Use-cases i filter design:**
- Visuell verifiering efter mutation (screenshot Preview)
- Dokumentera calibration-state (före/efter probe)
- Debug när API-state ser rätt ut men visual fel

**Cross-ref:** `../body-anchored-calibration.md` (image-interpretation reliability — visa screenshot till användaren, lita på deras text-rapport för screen-coord-judgments).

---

## `mcp__lens-studio__ListAllPanels`

**Kategori:** Panel / UI inspection
**Description:** Returnerar lista av alla panel plugin-IDs i dock manager. Inga argument; returnerar array av available panel IDs.

**Parameters:** Inga.

**Use-cases i filter design:**
- Discover panel-IDs innan `CapturePanelScreenshotTool`
- Diagnostik vid icke-standard LS-konfigurationer

**Cross-ref:** `CapturePanelScreenshotTool`.

---

# File / scripting

## `mcp__lens-studio__FileReadTool`

**Kategori:** File / scripting
**Description:** Läs file contents eller listar directory entries. Stödjer line-based slicing för stora filer. Kräver URI-scheme. Skippar binary files.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `uri` | string | ✅ | URI av fil/directory. Schemes: `assets://` (project assets), `packages://` (installed `.lspkg`, read-only), `project://` (project root, read-only). Append `/` för directory listing. |
| `offset` | number | optional | 0-indexed line att starta från. Negativ = från slutet (t.ex. `-10` = last 10 lines). |
| `limit` | number | optional | Max lines (eller directory entries) att returnera |

**Use-cases i filter design:**
- Läsa script-filer i `assets://Scripts/`
- Inspect installed package README via `packages://`
- Audit project-state via `project://`

**Cross-ref:** `FileEditTool`, `FileGrepTool`; `../snap-docs/02-scripting-api/scripting/`.

---

## `mcp__lens-studio__FileEditTool`

**Kategori:** File / scripting
**Description:** Skapa nya filer eller applicera targeted edits via en `edits`-array. Stödjer både overwrite (hela filen) och surgical modifications (replace/insert_before/insert_after/delete) via text-match eller line-number.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `uri` | string | ✅ | URI av fil. ENDAST `assets://`-scheme. Filer inuti sealed packages (`.lsc`/`.lspkg`) är read-only. |
| `edits` | array | ✅ | Ordnad lista av edit-operations |

Per edit-objekt:
- `action` (enum, ✅) — `"overwrite"` / `"replace"` / `"insert_before"` / `"insert_after"` / `"delete"`
- `target` (string) — locator. För `text`-match: exakt sträng. För `line`-match: 0-indexed line eller range (t.ex. `"10-15"`).
- `match` (enum) — `"text"` (default) eller `"line"`
- `content` (string) — ny content. Required för overwrite/replace/insert_*; ignored för delete.
- `occurrence` (int, default 1) — vilken match (1-indexed); `0` = alla.

**Use-cases i filter design:**
- Skapa nya TypeScript-controllers i Phase 2
- Surgical edit av existerande scripts
- Multi-edit i ett anrop (atomic semantik per fil)

**Cross-ref:** `../snap-docs/02-scripting-api/scripting/`; `RecompileTypeScriptTool` (efter edit).

---

## `mcp__lens-studio__FileGrepTool`

**Kategori:** File / scripting
**Description:** Sök efter text patterns i project files via regex. Returnerar matching lines med optional context. Defaults till `assets://`.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `pattern` | string | ✅ | Regex pattern (undvik nested quantifiers — performance) |
| `uri` | string | ✅ | Schemes: `assets://`, `packages://`, `project://` |
| `caseInsensitive` | boolean | optional | Default false |
| `fileExtensions` | string[] | optional | T.ex. `[".ts", ".js", ".json"]` |
| `contextLinesBefore`, `contextLinesAfter` | number | optional (default 0, max 5) | |
| `maxDepth` | number | optional (default 25, max 100) | Directory depth |
| `maxFileSize` | number | optional (default 1 MB) | Skip files larger than this |
| `maxResults` | number | optional (default 50, max 200) | Max matching lines |
| `multiline` | boolean | optional | `^`/`$` matchar line start/end |
| `offset` | number | optional | Pagination |
| `includeDebug` | boolean | optional | Include debug info |

**Use-cases i filter design:**
- Hitta var en specifik component-typ används i scripts
- Audit för deprecated API-calls
- Söka efter TODO/FIXME-comments

**Cross-ref:** `FileReadTool`, `FileEditTool`.

---

## `mcp__lens-studio__ExecuteEditorCode`

**Kategori:** File / scripting
**Description:** Compile + execute TypeScript-kod inside LS editor. Koden körs som async function body med `pluginSystem` som single available parameter. Type-checked mot Editor API (`editor.d.ts`). Returnerar `{ status, returnValue, console }` vid success eller `{ status, errors/error, console }` vid failure.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `code` | string | ✅ | TypeScript att compile + execute. Använd `pluginSystem.findInterface()` för Editor-APIs. `return <value>` för att producera result. |
| `timeoutMs` | number | optional (default 30000) | Max ms för compile + execute |

**Use-cases i filter design:**
- Editor-level introspektion bortom GraphQL-API
- Köra one-off TypeScript-snutts utan att skapa permanent fil
- Probe Editor-API-funktioner som inte exponeras via andra MCP-tools

**Risker:** Detta är full Editor-API access — använd med disciplin. Vid tveksamhet, probe scene-graphql först innan ExecuteEditorCode.

**Cross-ref:** `../snap-docs/02-scripting-api/scripting/`; `RecompileTypeScriptTool`.

---

## `mcp__lens-studio__RecompileTypeScriptTool`

**Kategori:** File / scripting
**Description:** Triggar forced TypeScript-recompilation. Returnerar `{ status: 'succeeded' | 'failed', errors?: string[], logFile?: string }`. Vid failure: `errors` innehåller compiler error-meddelanden. Använd `Read`/`Grep` på `logFile` för deeper log-analys.

**Parameters:** Inga.

**Use-cases i filter design:**
- Efter `FileEditTool`-edits av `.ts`-filer — recompile innan probe
- Verifiera att script-ändringar inte bröt typing
- Diagnostik vid runtime-errors

**Cross-ref:** `FileEditTool`; `RunAndCollectLogsTool`.

---

# Generation (AI)

## `mcp__lens-studio__GenerateFast3DAssets`

**Kategori:** Generation (AI)
**Description:** Genererar 3D-assets via AI. Supports multiple assets i en request. Varje generation tar ~60s; parallell-genereras. Använd när detail-kvalitet inte är primärt. **SCALE NOTE:** Generated meshes är uniformly scaled så longest axis = 1 cm. Vid import som prefab appliceras default scale 100 per axis (=> ~100 cm longest axis). Justera prefab-scale efter instantiation till expected real-world size.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `assets` | array | ✅ | Array av asset-objekt att generera |
| `assetDirectory` | string | optional (default `"GeneratedModels"`) | Folder för saved assets |

Per asset-objekt:
- `simpleName` (string, ✅) — t.ex. `"oak tree"`, `"yellow car"`
- `prompt` (string, ✅) — text att beskriva modellen
- `negativePrompt` (string, optional) — vad som INTE ska vara med
- `shadowless` (boolean, optional, default true)

**Use-cases i filter design:**
- Snabba placeholder-assets innan custom 3D landar
- Genererat content för Phase 1 scaffolding
- Procedural variants (t.ex. 5 olika trees-variations)

**Risker:** Detaljer är ofta dåliga. Använd EJ för brand-specifika assets (logos, characters). Library-first (`SearchLensStudioAssetLibrary`) före AI-generation.

**Cross-ref:** `../body-anchored-calibration.md` Step 0 (Library-first); `../snap-docs/01-mcp-and-claude-code/ai-cc-example.md`.

---

## `mcp__lens-studio__GenerateLensIcon`

**Kategori:** Generation (AI)
**Description:** Genererar image för lens icon från text-prompt och sätter den till project metainfo.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `prompt` | string | ✅ | Descriptive prompt (t.ex. `"hot-dog"`, `"dragon"`, `"anime"`) |

**Use-cases i filter design:**
- Generera placeholder-ikon för WIP-projekt
- Snabba ikon-variants för A/B-test
- Phase 5 submission-prep (om ingen brand-ikon finns ännu)

**Risker:** Brand-projekt (typ adidas) kräver brand-approved ikon — AI-genererad funkar EJ för final submission. Använd för WIP/draft only.

**Cross-ref:** `../snap-docs/07-publishing/configuring/` (icon-spec).

---

# Runtime / Knowledge

## `mcp__lens-studio__RunAndCollectLogsTool`

**Kategori:** Runtime / Knowledge
**Description:** Refreshar alla preview-paneler och väntar på lens reset-signal. Returnerar `{ status, logFile, byteOffset }`. Efter successful reset: använd `Read` eller `Grep` på `logFile` (från `byteOffset`) för runtime output + errors.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `timeoutMs` | number | optional (default 10000) | Max ms att vänta för preview-reset + log-collection |

**Use-cases i filter design:**
- Verifiera att scripts exekverar utan runtime errors
- Läsa state-machine transition-logs
- Fånga `console.log`-output från controllers
- Force Preview-refresh efter script-recompile

**Cross-ref:** `RecompileTypeScriptTool`; `FileGrepTool` (för log-search); `../snap-docs/04-scene-and-components/previewing-your-lens.md`.

---

## `mcp__lens-studio__QueryLensStudioKnowledgeBase`

**Kategori:** Runtime / Knowledge
**Description:** **DEFINITIVE SOURCE** för Lens Studio documentation och internal scripting repos. Använd för LS APIs, AR Development, code debugging. **Do NOT rely on prior knowledge** för LS-specifika detaljer.

**Parameters:**

| Name | Type | Required | Description |
|---|---|---|---|
| `q` | string | ✅ | Search query. Extract core technical concepts (t.ex. `"AudioComponent API"`). Om paginerar via `offset`: ANVÄND EXAKT SAMMA query-sträng. |
| `source` | enum | optional (default `"doc"`) | `"doc"` (web docs, ~300-word chunks, fast) eller `"script"` (internal repos, full files, high latency — använd sparingly). |
| `limit` | integer | optional (default 3) | Number of snippets. För `script`: max 3 för att undvika context-limit-errors. |
| `offset` | integer | optional (default 0) | Pagination. Bara använd om previous results var relevanta men inkompletta. |

**Auth note:** `source: "doc"` är unauthenticated. För `source: "script"`: kräver Snap-login i LS (`My Lenses → Login`).

**Use-cases i filter design:**
- Hitta exakt API-syntax för en LS-component
- Verifiera att antagande om en feature stämmer innan probe
- Debug deprecated API-error genom KB-search
- Cross-check när snap-docs-mirror är stale

**Cross-ref:** `../snap-docs/` (curated mirror — KB är mer komplett); `../snap-docs/01-mcp-and-claude-code/developer-mode.md`.

---

# Maintenance

**Re-probe trigger:** Vid större LS-version-bump, eller när ett tool börjar bete sig oväntat.

**Re-probe procedure:**
1. Kör ToolSearch på alla 20 tool-namn (`select:mcp__lens-studio__<name>,...`)
2. Jämför mot detta dokument — diff parameter-strukturer
3. Notera vilka tools som ändrats; uppdatera sektioner + bump datestamp
4. Commit som `chore(v0.6.x): re-probe MCP schemas YYYY-MM-DD`

**Truncation workaround för GraphQL-tools:**
- För komplett query-lista i `scene-graphql` / `asset-graphql`: anropa tool:en med bad query (`{ invalidField }`) och läs error — Snap returnerar lista över valid queries i error-meddelandet.
- Alternativt: använd `QueryLensStudioKnowledgeBase` med `q: "scene-graphql queries"` för bredare prosa-coverage.
