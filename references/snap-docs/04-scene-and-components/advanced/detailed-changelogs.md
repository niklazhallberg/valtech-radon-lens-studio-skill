# Detailed Changelogs

This page summarizes changes in Lens Studio API, nodes, and features.

***

## What's New in Lens Studio 5.18[​**](#whats-new-in-lens-studio-518 "Copy to clipboard")

### ✨ Highlights[​**](#-highlights "Copy to clipboard")

#### Character Skin Generator Plugin - NEW[​**](#character-skin-generator-plugin---new "Copy to clipboard")

The [Character Skin Generator](/lens-studio/features/genai-suite/character-skin-generator.md) plugin enables the creation of Lenses powered by ML models that transform users into full-body digital characters with pixel-level accuracy.

#### Body Generator: Quality Upgrade[​**](#body-generator-quality-upgrade "Copy to clipboard")

The [Body Generator](/lens-studio/features/genai-suite/body-morph-generation.md) plugin has been updated to a new version, bringing higher quality textures and better image-based generations.

#### Segmentation Texture: TextureTrackingScope Support[​**](#segmentation-texture-texturetrackingscope-support "Copy to clipboard")

Segmentation texture now supports **TextureTrackingScope**, allowing you to segment bodies or portrait hair from sources like dual camera or camera roll (media picker).

#### Keyboard Input Support[​**](#keyboard-input-support "Copy to clipboard")

Keyboard input support has been added for testing in Lens Studio:

* The [Bitmoji Player Package](/lens-studio/features/games/character-controller.md) and [Input Action](/lens-studio/features/games/input-action.md) component have been updated to utilize keyboard controls
* Map keyboard keys (for example, `W`, `A`, `S`, `D`, space bar) to movement and actions
* New D-Pad style input for movement

#### Bitmoji Game Sample Project - NEW[​**](#bitmoji-game-sample-project---new "Copy to clipboard")

The **Bitmoji Game sample project** demonstrates building a complete 3D platformer game with Character Controller, featuring:

* Bitmoji-themed level assets
* Keyboard testing support
* Game mechanics including checkpoints, collectibles, hazards, portals, and leaderboard integration

#### Scene Editor Improvements[​**](#scene-editor-improvements "Copy to clipboard")

| Feature                   | Description                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------- |
| **Orthographic View**     | Toggle between perspective and orthographic views using the navigation cube for precise alignment |
| **Frame Tool**            | Press `T` to activate the Frame tool for quick sizing and positioning of objects in 3D space      |
| **Move Object to Camera** | Move selected object to editor camera position: `Shift+Cmd+F` (Mac), `Shift+Ctrl+F` (Windows)     |
| **Double-Click to Zoom**  | Zoom to an object by double-clicking it in the Scene Hierarchy or pressing `F`                    |
| **Maximize Panel**        | Expand any panel to fill the workspace for easier inspection and editing                          |

#### Camera Kit SDK Lens Templates - NEW[​**](#camera-kit-sdk-lens-templates---new "Copy to clipboard")

Camera Kit SDK Lens templates have been added to showcase the SDK's AR capabilities.

#### Asset Library: Sorting & Filtering[​**](#asset-library-sorting--filtering "Copy to clipboard")

New sorting and filtering options have been added to the Asset Library for easier asset discovery.

#### Simplified Lens Blocks - NEW[​**](#simplified-lens-blocks---new "Copy to clipboard")

New Simplified Lens Blocks for rapid prototyping:

| Block                        | Description                                                                       |
| ---------------------------- | --------------------------------------------------------------------------------- |
| **Zoom**                     | Scale picture with different speed and duration, loop, zoom in/out features       |
| **Selfie Widget**            | Add small picture of you in different shapes to games and interactive experiences |
| **Parallax**                 | Add depth to your photos and videos                                               |
| **Color Correction Library** | Part of the Adjust block                                                          |
| **Face Parts**               | Add eyes or mouth on any position on screen or attach to your face                |

#### SafeSnapchatUser API - NEW[​**](#safesnapchatuser-api---new "Copy to clipboard")

New [SafeSnapchatUser](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.SafeSnapchatUser.html) class and related APIs allow loading friend Bitmojis in any context, including Lenses with Leaderboards, Turn Based Component, Remote APIs, and more.

***

### 💻 Scripting API Updates[​**](#-scripting-api-updates "Copy to clipboard")

See the [Lens Scripting API Reference](https://developers.snap.com/lens-studio/api/lens-scripting/) for full details.

#### Keyboard Input API - NEW[​**](#keyboard-input-api---new "Copy to clipboard")

| Class                                                                                                                   | Description                                                   |
| ----------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| [**KeyboardManager**](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.KeyboardManager.html) | Central manager for keyboard input handling                   |
| [**KeyPressEvent**](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.KeyPressEvent.html)     | Event triggered when a key is pressed                         |
| [**KeyReleaseEvent**](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.KeyReleaseEvent.html) | Event triggered when a key is released                        |
| [**KeyModifiers**](https://developers.snap.com/lens-studio/api/lens-scripting/enums/Built-In.KeyModifiers.html)         | Enumeration for key modifiers (Shift, Control, Alt, and more) |

#### JsonAsset - NEW[​**](#jsonasset---new "Copy to clipboard")

* New [JsonAsset](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.JsonAsset.html) class for working with JSON data assets
* Module resolution now supports JSON files, `Index.json` files, and `@input Asset.JsonAsset` types

#### Vector API Additions[​**](#vector-api-additions "Copy to clipboard")

New methods added to `vec2`, `vec3`, and `vec4`:

* `clone()` - Create a copy of the vector
* `fill()` - Fill vector with a value
* `copyFrom()` - Copy values from another vector

All vector functions that previously allocated new objects now have **in-place alternatives** to reduce memory overhead and improve performance.

#### Hierarchy Search APIs[​**](#hierarchy-search-apis "Copy to clipboard")

New methods added to `SceneObject` for optimized hierarchy searches:

* `getComponentInAncestors()` / `getComponentsInAncestors()`
* `getComponentInDescendants()` / `getComponentsInDescendants()`
* `isDescendantOf()`

#### Bitmoji 3D Options - NEW[​**](#bitmoji-3d-options---new "Copy to clipboard")

* [**BaseBodyParams**](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.Bitmoji3DOptions.BaseBodyParams.html) - Configure body parameters
* [**BodyType**](https://developers.snap.com/lens-studio/api/lens-scripting/enums/Built-In.Bitmoji3DOptions.BodyType.html), [**Gender**](https://developers.snap.com/lens-studio/api/lens-scripting/enums/Built-In.Bitmoji3DOptions.Gender.html) - Enumerations for body customization

***

### 🛠️ Editor Scripting API Updates[​**](#️-editor-scripting-api-updates "Copy to clipboard")

See the [Editor Scripting API Reference](https://developers.snap.com/lens-studio/api/editor-scripting/) for full details.

#### Asset Library API - NEW[​**](#asset-library-api---new "Copy to clipboard")

* [**GetAssetsByIdsService**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.LensStudio_AssetLibrary.GetAssetsByIdsService.html) - Fetch assets by their IDs
* [**Creator**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.LensStudio_AssetLibrary.Creator.html) - Asset creator information
* [**Subcategory**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.LensStudio_AssetLibrary.Subcategory.html) - Asset subcategory data

#### Shader Pass API - NEW[​**](#shader-pass-api---new "Copy to clipboard")

* [**PassBinding**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.Editor.Assets.PassBinding.html) - Shader pass bindings
* [**PassUiData**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.Editor.Assets.PassUiData.html) - Pass UI configuration
* [**PassBindingType**](https://developers.snap.com/lens-studio/api/editor-scripting/enums/Editor_Scripting.Editor.Assets.PassBindingType.html), [**ShaderType**](https://developers.snap.com/lens-studio/api/editor-scripting/enums/Editor_Scripting.Editor.Assets.ShaderType.html) - Related enumerations

#### UI Components - NEW[​**](#ui-components---new "Copy to clipboard")

* [**SearchableMenu**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.LensStudio_Ui.SearchableMenu.html) - Menu with search functionality
* [**Splitter**](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.LensStudio_Ui.Splitter.html) - Resizable panel divider
* [**CursorShape**](https://developers.snap.com/lens-studio/api/editor-scripting/enums/Editor_Scripting.LensStudio_Ui.CursorShape.html) - Cursor shape options

#### Package Export - NEW[​**](#package-export---new "Copy to clipboard")

New Package Export options to add a version range on export.

***

### 🔄 Improvements[​**](#-improvements "Copy to clipboard")

#### GenAI Suite[​**](#genai-suite "Copy to clipboard")

* **[Selfie Attachments](/lens-studio/features/genai-suite/selfie-attachments.md)** - New "Styles" customization: Default (balanced), Cartoon (stylized), or Realistic (high-fidelity)
* **AI Portraits Component** - See [the tutorial](/lens-studio/features/genai-suite/combining-gen-ai-components/ai-portraits-and-more.md) to learn how to replace the default transition, add post effects, and combine AI Portraits with other components.

#### Glam & Glitter[​**](#glam--glitter "Copy to clipboard")

* Valentine's content pack added
* Improved Makeup Stickers and Sparkles functionality
* New sparkle presets including hearts
* Paint makeup directly on face using stickers with color, opacity, mirroring, and erasing controls

#### VFX Editor[​**](#vfx-editor "Copy to clipboard")

* **High precision render targets** - More efficient particle data storage, better performance, higher accuracy with no drift
* World space systems can now simulate to several kilometers and beyond
* Added support for VFX Container Node items duplicate and copy & paste

#### Character Controller[​**](#character-controller "Copy to clipboard")

* Actions with and without animations can optionally be interrupted by other actions or by moving the character
* Actions can now use remote animation assets for publishing lighter lenses
* Two new animation types: **Fall** and **Squat**
* New APIs for changing jump speed and velocity programmatically

#### Input Action[​**](#input-action "Copy to clipboard")

* New Character Controller responses for handling movement parameters
* New D-Pad style input

#### Script Inputs UI[​**](#script-inputs-ui "Copy to clipboard")

* Custom Type Inputs now support Custom Component types

* The `showIf` flag now supports reference properties:

  <!-- -->

  * `{"showIf": "[ref_property]"}`–visible when the reference is valid
  * `{"showIf": "[ref_property]", "showIfValue": false}`–visible when the reference is invalid

#### Simplified Lens Blocks[​**](#simplified-lens-blocks "Copy to clipboard")

* **Hair Color** - Changed shader for more natural and saturated look
* **Eye Color** - Added ability to change eye color for each eye separately
* **Stickers on Face** - Now you can map stickers to 3D mesh
* **Background Block** - Added ability to use UPA (User Provider Assets)

***

### 🐛 Bug Fixes[​**](#-bug-fixes "Copy to clipboard")

#### Selfie Attachments[​**](#selfie-attachments "Copy to clipboard")

* Resolved a critical issue that prevented lenses with animated attachments from being published

#### Character Controller[​**](#character-controller-1 "Copy to clipboard")

* No longer crashes if a scene object considered as ground is destroyed at runtime
* Dash direction is now updated properly if a dash is requested while moving the character
* Fixed animation not playing correctly if Character Controller initialized before the Bitmoji's idle animation was loaded

#### Scene Editor[​**](#scene-editor "Copy to clipboard")

* Fixed face meshes not appearing when the face index was not 0
* Fixed unresponsive scale gizmo on Windows
* Fixed issue where using the Text3D frame tool did not update the text component in the model
* Fixed multiple crashes

***

### ⚠️ Known Issues[​**](#️-known-issues "Copy to clipboard")

* TypeScript will not allow comparison between `mat2` and `mat4`

***

## What's New in Lens Studio 5.17[​**](#whats-new-in-lens-studio-517 "Copy to clipboard")

### ✨ Highlights[​**](#-highlights-1 "Copy to clipboard")

#### Selfie Attachments: Animated Support[​**](#selfie-attachments-animated-support "Copy to clipboard")

**[Selfie Attachments](/lens-studio/features/genai-suite/selfie-attachments.md) now supports creating animated attachments.** Bring your selfie experiences to life with dynamic, moving elements that respond and animate in real-time.

**New Animation Workflow:**

* Add an animation description in the new **Animation Prompt** field
* Preview four animated variations before generating the final asset
* Switch between **Static** and **Animated** tabs to compare results
* Animate existing static attachments using **Add animation**

**Animation Component Properties:**

* **Start Events**–Define events that trigger the animation
* **Delay**–Set delay time before animation starts
* **Playback Speed**–Control animation speed relative to original
* **Loop Options**–Configure repeat behavior (continuous, ping-pong)
* **Infinite Loop**–Enable endless playback

#### Head Generator: Next-Gen Upgrade[​**](#head-generator-next-gen-upgrade "Copy to clipboard")

The **[Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) has been updated to a new version**, delivering:

* **Higher fidelity character heads** with improved detail and realism
* **Better image prompt following** for more accurate results from your inputs
* **New preview workflow** - Generate four previews, then select your favorite before creating the final asset
* **Regenerate option** - Get four new preview options if the initial results don't match expectations
* **Copy settings** - Quickly iterate on prompts while preserving the original asset in Gallery
* **Position adjustment** - Quickly modify transform coordinates to align the 3D head with the user's face

Image Reference now produces the highest-quality assets. The plugin delivers best results with non-human subjects like animals, creatures, objects, or stylized characters.

#### Character Controller: Major Enhancements[​**](#character-controller-major-enhancements "Copy to clipboard")

The [Character Controller](/lens-studio/features/games/character-controller.md) component receives significant upgrades for game development:

| Feature                    | Description                                                                                    |
| -------------------------- | ---------------------------------------------------------------------------------------------- |
| **Jump Buffering**         | Queue jumps before landing for responsive controls                                             |
| **Coyote Time**            | Brief grace period to jump after leaving a platform                                            |
| **Multiple Jumps**         | Support for double jumps and beyond                                                            |
| **Remote Assets**          | Animations can now use cloud storage, reducing Lens size                                       |
| **NPC Proxy**              | New proxy version for Non-Player Characters                                                    |
| **Connected Lens Support** | Replicating remote players with prediction algorithms for enhanced performance                 |
| **New API Methods**        | `getMoveVelocity()` for horizontal-only velocity, `getActiveActions()` to query active actions |

**[Input Action](/lens-studio/features/games/input-action.md) Update:** New response type "Move To Position" allows users to move characters to a point with tap input.

> *Source: [character-controller](/lens-studio/features/games/character-controller.md)*

#### Game Lenses: Fullscreen Mode[​**](#game-lenses-fullscreen-mode "Copy to clipboard")

**Game Lenses now automatically enter Fullscreen mode** when the user taps the screen. This exclusive feature allows you to:

* Build immersive fullscreen experiences with full screen real estate for game UI
* Block default touch behavior to prevent accidental swipe-outs during gameplay

> *Source: [games-overview](/lens-studio/features/games/games-overview.md)*

#### Turn Based Component: Smart Capture & Recovery[​**](#turn-based-component-smart-capture--recovery "Copy to clipboard")

New intelligent features for [turn-based games](/lens-studio/examples/lens-examples/turn-based-game.md):

* **Auto Capture** - The Lens fully controls when a snap is taken, automatically capturing when `endTurn()` is called
* **Turn Data Cache & Restore** - Recover turn data when reopening a Turn Based Lens from an incomplete turn
* **Score Tracking** - New `setScore()` and `getScore()` methods to include scores in turn data
* **Retry Disclaimer** - New `showRetryDisclaimer()` method to prompt users to send incomplete snaps

> *Source: [turn-based](/lens-studio/features/games/turn-based.md)*

***

### 🎨 Glam & Glitter Plugin: Expanded Features[​**](#-glam--glitter-plugin-expanded-features "Copy to clipboard")

The [Glam & Glitter plugin](/lens-studio/extending-lens-studio/plugins/glam-and-glitter-plugin.md) receives a major update with exciting new capabilities:

#### New Features[​**](#new-features "Copy to clipboard")

* **Glitter Controls for Makeup** - Add an extra dimension of sparkle to your makeup effects.

* **Custom Texture Support** - Upload your own textures for:

  <!-- -->

  * Gem stamps
  * Makeup
  * Stickers
  * Sparkles

* **Sample Project** - A new sample project is now available as a convenient starting point

#### UV Map References[​**](#uv-map-references "Copy to clipboard")

We've added comprehensive UV texture references to help you create perfectly aligned custom makeup:

* **Face UV for Blush** - Reference texture showing how blush textures wrap around the Face Mesh
* **Eye UV for Eyeshadow and Eyeliner** - Precise mapping for eye-area cosmetics
* **Mouth UV for Lips** - Accurate lip texture alignment guide

These UV maps serve as visual guides when creating your own custom makeup textures, helping you align details accurately with the Face Mesh.

> *Source: [glam-and-glitter-plugin](/lens-studio/extending-lens-studio/plugins/glam-and-glitter-plugin.md)*

***

### 🔧 Material Editor & VFX Editor: Enhanced Node Capabilities[​**](#-material-editor--vfx-editor-enhanced-node-capabilities "Copy to clipboard")

#### Transform Vector Node (v1.2)[​**](#transform-vector-node-v12 "Copy to clipboard")

The [Transform Vector](/lens-studio/references/material-editor/nodes/functions/util/node_math_transform_v1_2.md) node has been upgraded with **two powerful new properties**:

| New Property       | Description                                                    |
| ------------------ | -------------------------------------------------------------- |
| **Apply Blending** | When enabled, vertex blending is applied during transformation |
| **Apply Skinning** | When enabled, vertex skinning is applied during transformation |

These additions give you finer control over how positions are transformed between coordinate spaces, especially useful for animated and skinned meshes.

> *Source: [node\_math\_transform\_v1\_2](/lens-studio/references/material-editor/nodes/functions/util/node_math_transform_v1_2.md)*

#### Skin Matrix Node (v1.1)[​**](#skin-matrix-node-v11 "Copy to clipboard")

The [Skin Matrix](/lens-studio/references/material-editor/nodes/inputs/engine/node_effect_global_skin_matrix_v1_1.md) node has been updated with a new **combined skin matrix** option:

**What's New:**

* **Combined Skin Matrix** - Get the full skinning transform without manual per-bone calculation
* **Per Bone Matrix** property (bool) - Toggle between combined matrix mode and per-bone mode

Previously, the node only provided per-bone matrices requiring a bone index. Now you can get the combined matrix directly for simpler skinning workflows, while still having access to per-bone matrices when needed.

> *Source: [node\_effect\_global\_skin\_matrix\_v1\_1](/lens-studio/references/material-editor/nodes/inputs/engine/node_effect_global_skin_matrix_v1_1.md)*

#### Surface Nodes: New Space Property[​**](#surface-nodes-new-space-property "Copy to clipboard")

Three vertex input nodes now include a **Space property** dropdown, giving you control over which coordinate space your values are returned in:

| Node                                                                                                                                   | What It Returns                         |
| -------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| [**Surface Normal (v1.1)**](/lens-studio/references/material-editor/nodes/inputs/vertex/node_effect_global_surface_normal_v1_1.md)     | Normal direction vector of the surface  |
| [**Surface Position (v1.2)**](/lens-studio/references/material-editor/nodes/inputs/vertex/node_effect_global_surface_position_v1_2.md) | Position of the surface                 |
| [**Surface Tangent (v1.2)**](/lens-studio/references/material-editor/nodes/inputs/vertex/node_effect_global_surface_tangent_v1_2.md)   | Tangent direction vector of the surface |

This is particularly valuable when you need surface data in a specific coordinate system (Object, World, Camera, etc.) for your shader logic.

> *Source: [node\_effect\_global\_surface\_normal\_v1\_1](/lens-studio/references/material-editor/nodes/inputs/vertex/node_effect_global_surface_normal_v1_1.md), [node\_effect\_global\_surface\_position\_v1\_2](/lens-studio/references/material-editor/nodes/inputs/vertex/node_effect_global_surface_position_v1_2.md), [node\_effect\_global\_surface\_tangent\_v1\_2](/lens-studio/references/material-editor/nodes/inputs/vertex/node_effect_global_surface_tangent_v1_2.md)*

#### Position From Depth Node: Custom Camera Support[​**](#position-from-depth-node-custom-camera-support "Copy to clipboard")

The [Position From Depth](/lens-studio/references/material-editor/nodes/functions/util/node_util_position_from_depth.md) node now supports **custom camera properties**, unlocking new possibilities for depth-based effects:

**New Inputs:**

* Near Plane
* Far Plane
* FOV (Radians)
* Aspect Ratio
* View Inverse Matrix

**New Property:**

* **Use Custom Camera** - When enabled, the node uses your custom camera properties to transform depth from screen space to world/view space

This is especially useful for multi-camera setups or when you need to reconstruct positions from depth textures captured by different cameras.

> *Source: [node\_util\_position\_from\_depth](/lens-studio/references/material-editor/nodes/functions/util/node_util_position_from_depth.md)*

***

### 💻 Scripting API Updates[​**](#-scripting-api-updates-1 "Copy to clipboard")

See the [Lens Scripting API Reference](https://developers.snap.com/lens-studio/api/lens-scripting/) for full details.

#### Camera: New Matrix Methods[​**](#camera-new-matrix-methods "Copy to clipboard")

Access camera matrices directly for advanced rendering and projection calculations. See the [Camera API Reference](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.Camera.html).

| Method                      | Returns | Description                                     |
| --------------------------- | ------- | ----------------------------------------------- |
| `getProjectionMatrix()`     | `mat4`  | Returns the projection matrix for this camera   |
| `getViewMatrix()`           | `mat4`  | Returns the view matrix for this camera         |
| `getViewProjectionMatrix()` | `mat4`  | Returns the combined view and projection matrix |

New properties for advanced render target control:

| Property                  | Type     | Description                                          |
| ------------------------- | -------- | ---------------------------------------------------- |
| `renderTargetMipmapLevel` | `number` | Sets the mipmap level for the camera's render target |
| `renderTargetSlice`       | `number` | Sets the slice index for the camera's render target  |

#### Gaussian Splatting: Full Data Access[​**](#gaussian-splatting-full-data-access "Copy to clipboard")

Manipulate Gaussian Splat data programmatically with new getter and setter methods. See the [GaussianSplattingAsset API Reference](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.GaussianSplattingAsset.html).

**Read Splat Data:**

* `getSplatColors()` - Returns colors as `Float32Array` (r, g, b, a per splat)
* `getSplatPositions()` - Returns 3D positions as `Float32Array` (x, y, z per splat)
* `getSplatRotations()` - Returns quaternion rotations as `Float32Array` (w, x, y, z per splat)
* `getSplatScales()` - Returns 3D scale values as `Float32Array` (x, y, z per splat)

**Write Splat Data:**

* `setSplatColors(rgbaArray)` - Set all splat colors
* `setSplatPositions(vec3Array)` - Set all splat positions
* `setSplatRotations(quatsWxyzArray)` - Set all splat rotations
* `setSplatScales(vec3Array)` - Set all splat scales

This enables dynamic Gaussian Splat effects, procedural modifications, and data-driven visualizations.

**Example Usage:** *(illustrative)*

```
// Read positions
var positions = gaussianSplat.getSplatPositions();

// Modify and write back
for (var i = 0; i < positions.length; i += 3) {
  positions[i + 1] += Math.sin(getTime()); // Animate Y position
}
gaussianSplat.setSplatPositions(positions);
```

#### GLTF Asset: Static Composition Info[​**](#gltf-asset-static-composition-info "Copy to clipboard")

New method to retrieve asset statistics after instantiation. See the [GltfAsset API Reference](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.GltfAsset.html).

**Example Usage:** *(from API source)*

```
var info = gltfAsset.getStaticComposition();
if (info) {
  var infoObj = JSON.parse(info.value());
  print('Triangles: ' + infoObj.triangleCount);
  print('File size: ' + infoObj.fileSizeBytes + ' bytes');
}
```

Returns JSON with: file size, triangle count, vertex count, mesh count, texture count, texture memory size, material count, animation count, and node count.

***

### 🛠️ Editor Scripting API Updates[​**](#️-editor-scripting-api-updates-1 "Copy to clipboard")

See the [Editor Scripting API Reference](https://developers.snap.com/lens-studio/api/editor-scripting/) for full details.

#### Audio Support - NEW[​**](#audio-support---new "Copy to clipboard")

Full audio component support in Editor Scripting:

**New Components:**

* `AudioComponent` - Configurable audio playback with spatial audio, distance effects, and more
* `AudioTrackAsset` - Base asset class for audio tracks
* `LicensedAudioTrack` - Licensed audio with metadata (artistName, trackName, trackId)

**AudioComponent Properties:**

* `volume`, `recordVolume` - Volume controls
* `enableSpatialAudio` - Enable 3D audio positioning
* `enableDistanceEffect` - Audio falloff over distance
* `minDistance`, `maxDistance` - Distance effect range
* `curveType` - Distance falloff curve (Linear, Inverse, Logarithm, InverseLogarithm)

#### Logger Module - NEW[​**](#logger-module---new "Copy to clipboard")

New logging infrastructure for plugins:

**Example Usage:** *(illustrative)*

```
import * as Logger from 'LensStudio:Logger';

const logCollector = this.pluginSystem.findInterface(Logger.IUserLogCollector);
logCollector.onRevealLogRequest.connect((message) => {
  console.log(message);
});
```

The `IUserLogCollector` interface enables custom log handling with `onRevealLogRequest` signal support.

#### Asset & Package Management[​**](#asset--package-management "Copy to clipboard")

**[AssetImportMetadata](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.Editor.Model.AssetImportMetadata.html) additions:**

* `assetTreePath` - Get the asset's tree path in the project
* `isPackedPackageItem` - Check if the asset is part of a packed package

**[Model](https://developers.snap.com/lens-studio/api/editor-scripting/modules/Editor_Scripting.Editor.Model.html) additions:**

* `unpack()` - Unpack native packages programmatically

#### UI Improvements[​**](#ui-improvements "Copy to clipboard")

**[ProgressBar](https://developers.snap.com/lens-studio/api/editor-scripting/classes/Editor_Scripting.LensStudio_Ui.ProgressBar.html) widget enhancements:**

* `setPrimaryColor(color)` - Customize the primary bar color
* `setSecondaryColor(color)` - Customize the secondary bar color

***

### ⌨️ Expanded Keyboard Shortcuts[​**](#️-expanded-keyboard-shortcuts "Copy to clipboard")

We've expanded keyboard shortcut coverage across multiple panels to make common actions faster and navigation more consistent:

* **Scene Editor** - New shortcuts for scene manipulation
* **Scene Hierarchy** - Faster navigation and object management
* **Asset Browser** - Quick access to common asset operations
* **Graph Editor** - Streamlined node editing workflows

These improvements provide a more consistent experience across panels and platforms.

***

### 🔄 Improvements[​**](#-improvements-1 "Copy to clipboard")

#### UI & Workflow[​**](#ui--workflow "Copy to clipboard")

* **Joystick Component** - Three new texture presets added
* **[Character Controller](/lens-studio/features/games/character-controller.md)** - Updated idle, walk, and run animations
* **Logger Panel** - Double-click on an issue to navigate directly to the script asset
* **[Turn Based Game Sample Project](/lens-studio/examples/lens-examples/turn-based-game.md)** - Added auto capture and contextual score in chat

***

### 🐛 Bug Fixes[​**](#-bug-fixes-1 "Copy to clipboard")

#### Stability Fixes[​**](#stability-fixes "Copy to clipboard")

* Fixed a crash in [Character Controller](/lens-studio/features/games/character-controller.md) when resolving overlaps with other colliders
* Fixed a crash in Leaderboard component when its scene object is disabled between initialization start and initialized state
* Fixed application crash when scene was removed due to project corruption
* Fixed application crash when SceneObject with AnimationPlayer is deleted
* Fixed application crash on quick start/stop of video recording from Preview
* Fixed application crash when importing VFX.LSO from old Lens Studio versions
* Fixed application crash when some old projects were corrupted

#### Component & Feature Fixes[​**](#component--feature-fixes "Copy to clipboard")

* **Leaderboard Component** - Can now be used with multiple instances without conflicts
* **Custom Node** - Fixed issue where connections could be lost on project reopen
* **Diffuse Radiance Map** - Fixed noisy map creation
* **Screen Transform** - Moving the transform now properly updates Position fields
* **Material Editor** - Fixed issue where not all compatible nodes were present when creating connections
* **2D Editor** - Fixed issue preventing it from working
* **Face Crop Texture** - `copyFrame()` now crops the correct region
* **Flipbook Node** - Now updates Max frames field interactively
* **Script Graph** - Fixed import issues from old Lens Studio versions
