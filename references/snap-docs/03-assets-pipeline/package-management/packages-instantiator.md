# Package Instantiators

### Overview[​**](#overview "Copy to clipboard")

Often after adding an asset to Studio, developers have to manually perform certain steps to set up the asset for it to work as expected. Asset Package Instantiator allows to include and execute specific editor code when your package is instantiated.

**Asset Package Instantiator** (as well as [Script Asset Instantiator](#script-asset-instantiator)) is a special type of plugin that allows to invoke a setup script attached to Asset Package (Script/Custom Component).

### How It Works[​**](#how-it-works "Copy to clipboard")

Users can now specify write a specific editor script (using Lens Studio Editor API) and include it in the package. This setup script will be executed when the asset is imported (file dragged into Scene panel or imported from Asset Library).

![](/assets/images/package_instantiator_1-66454834af0de7b14c0369967026f1c5.png)

Setup script needs to return a function:

```
/**
 *
 * @param {Editor.Assets.Asset} asset - The asset to instantiate (e.g., a script or prefab).
 * @param {Editor.Assets.Scene} scene - The scene where the button will be added.
 * @param {Editor.Model.SceneObject|null} target - The target scene object to parent the button to, or null.
 * @param {SetupScriptInterface} instantiator - Utility object providing helper methods for instantiation.
 * @returns {SceneObject|Component|null} The instantiated component or scene object.
 *
**/
return function instantiate(asset, scene, target, instantiator) {
...
}
```

More details in [Scripting](#scripting) section.

This functionality is enabled with built-in `Instantiator - Asset Package` Plugin that executes `Setup Script` for packages that have it. For developers who do not want their packages instantiated, they can disable it from the `Plugins Manager`.

![](/assets/images/package-management_22-09620cd52df7fe0b64c50d295a695300.png)

Let's look at example for World Object Controller. As you may know it requires several steps to set up. Here is how the setup script could look like for it:

```
/**
 * Instantiates a World Object Controller prefab in the scene and sets up device tracking.
 *

 *
 * This function:
 * - Locates the World Object Controller prefab relative to the asset's path.
 * - Loads the prefab asset.
 * - Instantiates the prefab in the scene.
 * - Ensures device tracking is set up and assigns it to the prefab's script component.
 */
return function instantiate(asset, scene, target, setupScriptInterface) {
  try {
    let prefabFile = asset.fileMeta.sourcePath.parent.appended(
      'World Object Controller__ADD_TO_SCENE.prefab'
    );

    const prefab = setupScriptInterface
      .getAssetManager()
      .getFileMeta(prefabFile).primaryAsset;

    let sceneObject = setupScriptInterface
      .getScene()
      .instantiatePrefab(prefab, null);

    const deviceTracking = setupScriptInterface
      .getUtils()
      .getOrAddDeviceTracking(setupScriptInterface.getScene());

    sceneObject.getComponent('ScriptComponent').worldTrackingComponent =
      deviceTracking;
  } catch (e) {
    console.log(
      e,
      "Couldn't add asset to scene automatically, please add prefab to scene"
    );
  }
};
```

Show more▼

**How to See It in Action**

To see this in action, set the setup script input and export the package. Then, import it into an empty project by dragging it directly into the Scene Hierarchy panel:

[](/img/lens-studio/package-management/package_instantiator_2.webm)

The setup script automatically creates the necessary scene tweaks for the asset to be used instantly.

### Prefabs Within Packages[​**](#prefabs-within-packages "Copy to clipboard")

Oftentimes, Asset Packages (particularly those in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md)) include prefabs with specific instructions (such as `__PLACE_IN_SCENE`, `__PLACE_IN_ORTHO_CAM`, or `__PLACE_UNDER_MAIN_CAM`). The Asset Instantiator allows you to add the prefab to a specific place in the scene and create supplementary scene objects if needed (for example, a Screen Transform hierarchy). You may use these instruction prefixes to automatically instantiate prefabs included in the asset package.

### Script Asset Instantiator[​**](#script-asset-instantiator "Copy to clipboard")

Once exported from Lens Studio, a Custom Component is also represented with an [asset package](/lens-studio/features/package-management/asset-packages-introduction.md) and supports a setup script as well. This functionality is enabled with the built-in `Instantiator - Script Asset` plugin that executes the `Setup Script` for custom components that have it.

Please note that the setup script must be set in the script asset within the custom component bundle.

#### Example: UI Button Setup Script[​**](#example-ui-button-setup-script "Copy to clipboard")

Let's take a look at a UI Button example:

**Before:** When a script asset is instantiated, the script component is added to the scene. This results in an incomplete setup and doesn't allow you to see the button in the Preview panel right away.

[](/img/lens-studio/package-management/package-instantiator-ui-bitton-before.webm)

**After:** The setup script allows you to add custom logic to add the script asset to the Scene Hierarchy, add a screen transform hierarchy, and set an appropriate screen transform size:

[](/img/lens-studio/package-management/package-instantiator-ui-bitton-after.webm)

![](/assets/images/package-instantiator-button-result-6d967c3dfc577b20f68bf706ba3a7b56.png)

Now let's see how the setup script looks in this case:

```
const BUTTONSIZE = new vec2(300, 50); // Default size for the button
/**
 * Instantiates a UI Button in the scene with default size and anchor settings.
 *
 * @param {Editor.Assets.Asset} asset - The asset to instantiate (e.g., a script or prefab).
 * @param {Editor.Assets.Scene} scene - The scene where the button will be added.
 * @param {Editor.Model.SceneObject|null} target - The target scene object to parent the button to, or null.
 * @param {SetupScriptInterface} instantiator - Utility object providing helper methods for instantiation.
 * @returns {ScriptComponent|null} The instantiated script component, or null if instantiation fails.
 *
 * This function:
 * - Creates a screen transform object for the button.
 * - Sets the button's name.
 * - Instantiates the asset as a script component on the button.
 * - Configures anchors and offsets for proper sizing and positioning.
 * - Sets constraints to fix the button's width and height.
 */
return function instantiate(asset, scene, target, instantiator) {
  try {
    const screenTransform = instantiator
      .getUtils()
      .createScreenTransformObject(scene, target);

    screenTransform.sceneObject.name = 'UI Button';
    const scriptComponent = instantiator.defaultInstantiate(
      asset,
      scene,
      screenTransform.sceneObject
    );
    // configure anchors for the screen transform
    let anchors = new Editor.Rect();
    anchors.left = 0;
    anchors.right = 0;
    anchors.top = 0;
    anchors.bottom = 0;
    screenTransform.anchor = anchors;

    let offset = new Editor.Rect();
    offset.left = -BUTTONSIZE.x / 2;
    offset.right = BUTTONSIZE.x / 2;
    offset.top = BUTTONSIZE.y / 2;
    offset.bottom = -BUTTONSIZE.y / 2;
    screenTransform.offset = offset;

    let constraints = screenTransform.constraints;
    constraints.fixedWidth = true;
    constraints.fixedHeight = true;

    screenTransform.constraints = constraints;
    return scriptComponent;
  } catch (e) {
    console.error('Error instantiating UIButton: ', e);
    return null;
  }
};
```

Show more▼

## Scripting[​**](#scripting "Copy to clipboard")

Setup script is required to export a function as follows:

```
/**
 *
 * @param {Editor.Assets.Asset} asset - The asset to instantiate (e.g., a script or prefab).
 * @param {Editor.Assets.Scene} scene - The scene where the button will be added.
 * @param {Editor.Model.SceneObject|null} target - The target scene object to parent the button to, or null.
 * @param {SetupScriptInterface} instantiator - Utility object providing helper methods for instantiation.
 * @returns {SceneObject|Component|null} The instantiated component or scene object.
 *
**/
return function instantiate(asset, scene, target, instantiator) {
...
}
```

### Setup Script Interface[​**](#setup-script-interface "Copy to clipboard")

The `SetupScriptInterface` is designed to simplify asset instantiation and scene management in Lens Studio editor scripting. It provides a set of helper methods that allow you to:

| Function             | Arguments                                                                                          | Return Type                 | Description                                                                                                                                             |
| -------------------- | -------------------------------------------------------------------------------------------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `defaultInstantiate` | `asset: Editor.Assets.Asset, scene: Editor.Assets.Scene, target: Editor.Model.SceneObject \| null` | `any`                       | Invoke default instantiate behavior for the given asset (e.g., script or asset package) in the specified scene, optionally under a target scene object. |
| `getAssetManager`    | *(none)*                                                                                           | `Editor.Model.AssetManager` | Returns the asset manager reference                                                                                                                     |
| `getScene`           | *(none)*                                                                                           | `Editor.Assets.Scene`       | Returns the current scene object.                                                                                                                       |
| `getUtils`           | *(none)*                                                                                           | `typeof InstantiatorUtils`  | Provides access to utility/helper functions for common setup tasks (e.g., creating screen transform objects).                                           |

These methods are available on the `SetupScriptInterface` object passed to your setup scripts.

### Instantiator Utils[​**](#instantiator-utils "Copy to clipboard")

The structure of setup script is pretty strict and doesn't now allow external imports. In order to make it easier to reuse code you may utilize `getUtils()` api of a SetupScriptInterface to access InstantiatorUtils object that provides some common api as well as access to `LensStudio:AssetUtils` and `LensStudio:HierarchyUtils` editor scripting modules.

| Method Name                                  | Description                                                                                   | Parameters             | Returns                |
| -------------------------------------------- | --------------------------------------------------------------------------------------------- | ---------------------- | ---------------------- |
| `getAssetUtils()`                            | Returns the AssetUtils module.                                                                | None                   | AssetUtils module      |
| `getHierarchyUtils()`                        | Returns the HierarchyUtils module.                                                            | None                   | HierarchyUtils module  |
| `addToOrthoCamera(scene, sceneObject)`       | Adds a scene object to the orthographic camera.                                               | `scene`, `sceneObject` | void                   |
| `addToMainCamera(scene, sceneObject)`        | Adds a scene object to the main camera.                                                       | `scene`, `sceneObject` | void                   |
| `getOrAddDeviceTracking(scene)`              | Gets or adds a DeviceTracking component to the main camera.                                   | `scene`                | DeviceTracking or null |
| `createScreenTransformObject(scene, target)` | Creates a Screen Transform object and attaches it to the orthographic camera's screen region. | `scene`, `target`      | ScreenTransform        |
