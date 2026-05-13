# Scene Manager

The Scene Manager is a [custom component](/lens-studio/features/scripting/script-components.md) that simplifies organizing your Lens into distinct scenes. This component provides essential functions for scene management, including `loadSceneSync`, `loadSceneAsync`, `unloadScene`, and `unloadSceneByName`. It's a crucial tool for projects requiring multiple scenes, such as multi-level games or multi-layered Lenses.

This guide covers the Scene Manager's core functionalities and their usage. With the Scene Manager, you can:

* Organize your Lens into logical, manageable scenes.
* Load and unload scenes efficiently using simple functions.
* Achieve smooth scene transitions with asynchronous loading.
* Release resources by unloading scenes by name.
* Develop multi-scene experiences like games and interactive stories.

The Scene Manager enables the creation of complex and modular Lens Studio projects. This guide will demonstrate how to effectively use this component in your Lenses, making scenes an integral part of your design.

## Adding the Scene Manager[​**](#adding-the-scene-manager "Copy to clipboard")

![](/assets/images/scene-manager-1-ee2d36b93b42c22c2645a78bb7b30712.png)

To use the Scene Manager:

1. Import the Scene Manager component from the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md), if it's not already in your project.
2. Drag the Scene Manager custom component from the `Asset Browser` panel into your `Scene Hierarchy` panel. This creates a new Scene Object with the Scene Manager component attached.
3. Position the Scene Object containing the Scene Manager at the *top* of your `Scene Hierarchy`. This ensures it initializes before other parts of your project attempt to reference it.
4. Access the Scene Manager in your scripts via the `global.sceneManager` object.

If you've previously installed the Scene Manager, you can add it like any other component:

1. In the `Scene Hierarchy` panel, click "+" > "Scene Object".
2. Select the newly created Scene Object.
3. In the Inspector panel, click "+ Add Component" > "Scene Manager".

## Creating a Scene[​**](#creating-a-scene "Copy to clipboard")

A scene is fundamentally an [Object Prefab](/lens-studio/lens-studio-workflow/prefabs.md). To create a scene:

* Drag a Scene Object from the `Scene Hierarchy` panel into the `Asset Browser` panel.
* Alternatively, right-click a Scene Object in the `Scene Hierarchy` and select "Save as Prefab".

For optimal performance, especially with `loadSceneAsync`, enable "Lazy Asset Loading" on your Object Prefabs. This setting, found in the Inspector panel when a Prefab is selected, delays loading scene assets until they are needed. This drastically improves Lens startup time by avoiding the upfront loading of all scene assets. Instead, only assets associated with the specific prefab/scene are loaded when required.

## Registering Scenes[​**](#registering-scenes "Copy to clipboard")

![](/assets/images/scene-manager-2-d9d27255deb57207e45490450622097f.png)

After creating your scene prefabs:

1. Select the Scene Manager object you added earlier.
2. In the Inspector panel, click the "Add Value" button on the Scene Manager component. This adds a new slot to the scene registry.
3. For each registry item, provide a unique `name` and assign the corresponding `prefab`. You'll use this name (case and space sensitive) to reference the scene later.

The Scene Manager also supports Prefabs designated as remote assets. Adding a remote asset prefab creates a "Remote Scene" registry item. Only asynchronous loading (`loadSceneAsync`) is permitted for Remote Scenes, as the scene must be downloaded first.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAATIAAACuCAMAAACCy3F7AAAA3lBMVEU0OEDCxsx5fow2OUHBxsuQlJu/xMlESFA4O0P///9VWWA/Qkqcn6VmaXBSVFyAhIp6foRHSlKorLK2u8BcYGc9QEm7v8VKTVW8wca5vcNvc3k6PkdobHKrr7VgY2pYXGSjqK6KjpS9w8ieoah4fISHjJKChoygpKuNkph0eH5iZm1OUllMUFdCRk2tsLazuL1qbnSSl51ydnyYnaJ9gYiwtbtTV16usrmWmqB2eoGlqq9scHdkaG86PEShpaxaYGuFiZDx8fNuc39TVmLa3ODLzdLn5+nU1dkKDA8jJy3BSjInAAANpUlEQVR4XuzQMQEAAAgDoMXT/oXMsMMPIpAt8VKmDGXKlClTRqbEsXfuzaki3R5ev4BIRFEQRTXiLd5v8RZjNHucmfOe8/2/0dHuLhuMZrtn8ibuqn7+CmKz4lNNsyD1M3QbKBQKhUKhUCgUCoVCobCeU6nEiASzZjNOIdL5Wpw+n3i7uXKHJJG1b56gqeNAZ0uMGPAc9qkDGbqWEoDinko99faxsRUAJEgia9842g5HutoZZeU8sPmp9vGYvyeDI50yfcACQKU7+h2V1QEYL5nMtAFgKpVJvG7GvGJypY/Kms2mW/iZsyTQI8bvpszTgZVDe0YugO0//LWlMmHibaEDKbrMGBj9nspqQH5ADKcIjIUyzVu3e0LcMAg0/obNIl1y5Gq0WSy2bNMJukAyCOJSGZu+LaJB4JG1TS80ItKCdXsd8J+CIhAEHu0xE6V0r5ojita+VRwd6Idn3IApe3jFgaQpTiF2FWsZAKDXiSE2URsR7cBJh5U9AxWiDjDTAZhE9hIHls9EcQhGRFX+srEhOql9m8yAidyqAI9MmQCxkLI0pJjw5sSnNjiLsDIfyDJlDJOcCThZh0ZSmaeDo5fopPZtkgaScmsK1LmyQtrrTwH0jsqeANSDoA7gQTQT063Xzh68lv000PX9cljZFphzZeO1l6CyC6xKidIKqJjk+BPA9x2iJuA+2KUfwCud1r5JunzSCNbAC1f2IAxWjspcoE17dkCTTUh+eQ2AhnVm+afcClgzZa8W7emz6UXkF3k3NoZBB146zThfIYzcae2bZA6U5FaK6YgxcXvKRRimUGYamLCuTcujSPRmoMhbiBJb2sPKuoPBwFtnAWPAlD2I+SwqPTKpQpmkCQze1b5FYsAiMsvmTNmaGB3gWShLAKgzADhUBZoX+zKBkeKHiIs+DD/Y+BUQiyiLPy123RdwZdHat0ibSZICxVoWHPuEjVBWQoiAZkDrJ8qWKWHdogMTSGohZVYSAgxOa9/qFXMZuWJmmDJ5t/kglG0AuAw0XJuegO4lZZPMnqc4UUTZEhi7DLh1qcxcAjCWbkcoi9a+RXxA90iQMAA7fLK6wFAoG0TPxCHgXu7+JVLZS/geXCrzgELflGtZtPZN4gJFhxjxLJ9yMcA1mRcDeU0o0wooWvxtvsMuAsaA9mix5rTMlNU/VpaBkPHm+zmpLC2uvGaBK4vWvkn6AFzmIlcD8MSU8c9frgC1Y5NRA2oHkYkGjDc2KVY5biJrsq5t/LEyD9D7BzcvQFoqy/B+zJwCGJzWvlGmAPL13rqVB5AkoQxurDsBjOpRWaIALOu7qcHbADsPZLvtH+JhWhWA2x58oEx7AYzkIr0C9IFUZgPoZNIupDJZ+0YxpzgyLwtlK3BKoRumvg5OhTnwDHCSOSIqLwEg/YEyMmvyzkgq05LixQYwOKl9u2xcoaKkidZCtxcFANkehZTRlr2vuMgRI3gFoK8WfNAgVmjoaaLeyWdNsqaeYXULAPQOnz2vyPPZ1yoCWG670P1o7ZtmGGye+gMKow2HvnZsPeLEGNnDEUks28/JLTNnafQxpj8cmPQO33fO1P590Tz80q2LIpcF4NL1KEYAClW6HkVuGlvE6etRKBQKhUKhUCgUCoVCoVAoFAqFQqFQKBQKhUKhUCgUitwff90d+euPHP0Exd+PdxEe/6YPUfxx944/6F+jxQVxiy6zfe1oZ7ei5OJl+oeUnaH26XPs7gx/f0bIRLCkyzwC2tmtKC7m9A9pASW6Hsce0c/IPd6dI0f/khQEmPx7ZRUk6Z+hFa/M4chKv3paxvKxzzk1U8C6yhh8p7I+AN2nqxlfUemviLHWn/d/8uvmJyhLhCMQZPU3CZMY2uDhaaCRkGQFJftEWfwhKF9WJoebtmBANLTjfKztR3PboRjyKNhUc+Ig9mYr4hOy3sjOwrVtjT7kLsL/3Atld5+qrIVsSwewZBb7WQDIB1zSLA9g0gsp61d0wOjEzymLDt9CgKFWECfgK7J0xDLQfcWSQnFgI3Oo8ZAHAHdIkXpTMKq/oCx7f3//47+iTLB8I6qCY1SZJI7ePyp7LoDhls8oiw73GgwAPr1AF19cEItkkL0ehAMXKBQBrPn5mjWArBmpV28AaDTs65W97I3h7tOUtUoMnykrBuW+C/RZWreXc9JAmytrOaNHIG8JZWYWes/yX4D6WWVyeMhLjFnoEdEa8OjIKybaSOcR7CEL7iXyqBwOYniU6wLbcL0r17LQqt/+8/7+f+8+T5lgwZRtiSgBrInslEd0MNNhkuZiGnpCWYKNILOC8VllcrhMY7smkZZFTUgKp693RE3k34g5XRzMpRJELoo5IjNI5U7qXa9sv+rv7v6zn2SxT1SmFxmzgxE9d9Cg87y4mehvekCNSQrEZ1sLZTNg8bRnCZTfK4sMZ4wmLJjNisTJ4SUEaeCZqMRz+A6gJ0s+HegCk7bHjh+u92vK7v/j7o2thLDPX/7pQOOgrMxSlODKRMxQMxATyro4Yr9XFhnORnagM+tkAz1ahzP3WhaYz+cdICkEAqj0NCJ/AgCF6YBO6l2vzL1n/N/dFyjrAMi+NoUy+MTnX1coqwO1H3tW6DjvlUWGH9gBmaPYGtXwSkc8HGE9fbU7gYiaW7OaAaA4jNS7VpnoLvb8ufsCZZaO8bNGNBbKtmKGzISyEjC43MpGhxM9AHPt2AnrCR0zOhIDmq09E2BNHH9XgMFP+LfUK5CO1PslZd2DsuTdFyirAi0ieoZQ5r7xPHhCKLPBu4RNd6e9VxYdToMCVjkSxHUsYVjh73x0uRx2lay20jnu0dfSrYDnHKcn9caiiXM8jUjzfdaHl883GcX7+8Ld5yprPzC8k1lmIPtgl/JCGdBM9aesY+PKtBUQ6yfaBlYhZasHjhkZnlsB2+Eevqg3gfD9+xOfXFyTTRmgmbC2WUy0tyKMUtyfAqWTejVgYRPZBpIslx5QLo+ldv6GaSWX/k+6YRJMospoDo5QZuBAwT62sn4WDCMgqUwAOzJcFrHFWYotHWlCd4gRAC2yiuCsiRbgLK2Tem3e/c+APNEYaLPW2TlzW/75T8wCCDAmSovpXkSGyIwVdDTSL2gSzVDwKtAbzYCIbWlEZE+zOvROItyRCvRhZHgQen3Pm46iGX6I8YMYomeLzwvQ9TGTulnqOopTi07q5erFAqrkTAo7onW++ExmpdH8ioc/H6M5vkmSkVOmE+L+23XDJXKdu4zmx4/HzTnO2XpaOXeowSqYrE75ykeMvx9WMIbh3NCD7NtnyVqur+Hv33mOSbL57E5Tf5T7Fd40+i1RKBQKhUKhUCgUCoVCoVAoFAqFQqFQKBQKlcdUeUyVxyzTdfQKbvnScehqnl6TdIHma+pdTvM285h6pW7RCaZt0ykroH/pODZdSxoNugCQuTKneQN5zMro/a5nOqGu50cX8wOfpOzKnOZ35jF7iUS/WwRiFOXhnAWrTF+g7Jqc5rfnMa2siP1q1Q3PfQwWQImHJ0deybP4ZGcpyqFd1uxN37msTEtsElo0l8nJbZ9srkwWE9ilwJLKTnOaMpsp+eY8Zpdlbswpi12uiYZgNImsmPy/c2nkiXJAKwtAr2vnlb2xo+Snbye5TBo1DQCdLlMmix2YTQDkZ1LZaU5TZjMl35vHjLE0zBScJ3IKANB4IWqCkySiNgpEFgSYnVWmzcGZa9FcplkDhyuTxYgCHYIMnctpRrOZgu/IY0pldgFFoh7w+lzeFmA4x7VsCFSGpreCUQ4pi8WdtA73rLJHoFI1qxXgMZrLXBx2lL0JUxYplssDmZGzk8pOcpqRbCbjO/OY3cfHdAVAmiiJ7IiYrNRRmZlKxXnmtCqVuRoRJZE/q6yJvE9Efh7NaC6zw3ckDDQoWqwqkrBzqSya04xkMxnfmccUzN+IitCf9pSAtlDGcIKH0gvgSWU74hEP7ZyyIl5E8LcYzmXKHTU0KFpsLUJdnlQWzWnKbKbk+/KY+eUyDzb545ACpTJvBYZUJhaxzHllcSAtPjHi4VymA7Gji8ZJsS50Zn8EZC7kNGU2k/PNecwqsDTZL4wfB+Aujso8HdArncnVykZAm8QstEK5TLkjhsZJsTp0Nn8cIHMppymzmYzvzmMmeVptgpd3rWwdyFjMyZXKaCIyhklMornMrNjhonFSbAY8i9Y1cymnKbOZjO/OYw50FC2iOfI2EVn1rseUPfH4bpk1Dlcrm7OOgqoG5tFcZpLvSAENihZLAEmNyHSBzPmcZiibeTGH+WV5zIRoy3ZEG2Ayq/YrTJYHuFuLdkCsWn3Bx8pkrtOmJyA782ZZ4Cka6yyxHes8UxYpZi6BaT+VBJA5n9MMZTMv5zC/II8plTkNGP5BCaepEY0KrPtPGLhu+RfM5VHaFI11UizUykaL2QX+OpA5n9MMZzMv5jC/KI+pD8RajQyRlnk1dBTT/FanhkKHXTF1uE/6wW0GWaKygQ3t6aFwJtc5PcisGbpRyxBFY51k7lbQjdYCRaKTYl6yoWNcLaB3Kacps5mXcpjflcfMOXFZtWzSHssZ0S9Sdsrnc5kjx7xQ7O3jKjKbeSmH+ZV5TPUgW3E5j6mcqD/KKRQKhUKhUCgUCoVCoVAoFAqFQvH/8yARjAIGTxLBKBiRQTYaZKNBNhpko0E2CgDG4t2bAVJX4gAAAABJRU5ErkJggg==)

## Loading and Unloading Scenes[​**](#loading-and-unloading-scenes "Copy to clipboard")

Scenes are loaded using one of two methods. Key parameters are explained below:

```
// ** Sample Code with All Parameters **
// Load a scene synchronously
global.sceneManager.loadSceneSync('scenename', {
  // Optional parameters
  additive: true, // Default value: true
  enabled: true, // Default value: true
  parent: undefined, // Default value: undefined (Scene Manager's object)
});

// Load a scene asynchronously
global.sceneManager.loadSceneAsync('scenename', {
  // Optional parameters
  additive: true, // Default value: true
  enabled: true, // Default value: true
  parent: undefined, // Default value: undefined (Scene Manager's object)
  onProgress: (percentage) => {
    print(`Loading progress: ${percentage * 100}%`);
  }, // Default value: null
  loadingScene: 'scenename', // Optional loading scene name
  onComplete: (loadedScene) => {
    print('Scene has been loaded successfully');
  }, // Default value: null
  onFailure: (errorMsg) => {
    print('ERRPR: Scene loading failed: ' + errorMsg);
  }, // Default value: null
});
```

### Additive vs. Non-Additive Loading[​**](#additive-vs-non-additive-loading "Copy to clipboard")

The Scene Manager supports two scene loading modes: additive and non-additive.

* **Non-Additive Scenes:** When a non-additive scene is loaded, any currently active *non-additive* scene is automatically unloaded. This is analogous to switching levels in a game. Only one non-additive scene can be active at a time. This is ideal for major sections of your Lens, such as different gameplay areas or distinct UI screens.

* **Additive Scenes:** Additive scenes load *on top* of existing scenes, acting like layers. This allows you to build complex experiences by combining multiple scenes. This is suitable for elements like UI overlays, special effects, or additional content that shouldn't replace the main scene. Multiple additive scenes can be stacked.

### Custom Scene Root (Parent)[​**](#custom-scene-root-parent "Copy to clipboard")

By default, loaded scenes become children of the Scene Manager's Scene Object. However, you can specify a different parent for a loaded scene using the `parent` parameter in `loadSceneSync` and `loadSceneAsync`. This provides finer control over your Scene Hierarchy and ensures correct functionality, especially for scenes using Screen Transforms or Orthographic Cameras that might require specific parent objects (like a camera).

```
global.sceneManager.loadSceneSync('myScene', { parent: myCameraObject });
```

Alternatively, you can achieve the same result without code using the Behavior component's "Scene Manager: Load Scene" action. Set the "Scene Root Object" field to the desired parent.

### Asynchronous Loading and Loading Scenes[​**](#asynchronous-loading-and-loading-scenes "Copy to clipboard")

The Scene Manager enables asynchronous scene loading, meaning the loading process occurs in the background without blocking the rest of your Lens. This is particularly useful for large or complex scenes that might take some time to load. While a scene loads asynchronously, you can display a "loading scene" to provide feedback to the user.

A loading scene is simply a regular scene (prefab) registered with the Scene Manager. Specify the loading scene using the `loadingScene` parameter in `loadSceneAsync`. It's crucial that your loading scene is *lightweight and optimized*. Complex animations or heavy assets in the loading scene can defeat its purpose.

You can also set a minimum display time for the loading scene using the `minLoadingTimeInSeconds` property of the Scene Manager. This ensures the loading scene is visible for a specified duration, even if the main scene loads quickly, contributing to a smoother user experience.

## Scene Hooks (Pre-Unload)[​**](#scene-hooks-pre-unload "Copy to clipboard")

Scene hooks allow you to execute custom logic *before* a scene unloads. This is valuable for cleanup tasks, playing animations, or saving data. Currently, the Scene Manager supports only the `preUnloadHook`.

The `preUnloadHook` is a function defined in a script attached to the *root object* of the scene you intend to unload. This function *must* return a `Promise`. The Scene Manager will wait for this `Promise` to resolve before unloading the scene.

```
// In a script attached to the root object of your scene:
script.preUnloadHook = function () {
  return new Promise((resolve) => {
    // Perform some action, e.g., an animation or data saving.
    // ...
    resolve(); // Resolve the Promise when the action is complete.
  });
};
```

## Behavior Script Integration (No-Code Scene Management)[​**](#behavior-script-integration-no-code-scene-management "Copy to clipboard")

The Scene Manager integrates seamlessly with Behavior scripts, allowing you to load and unload scenes without writing any code. The "Scene Manager: Load Scene" action in Behavior provides options to specify the scene, loading mode (additive/non-additive), and other parameters. This makes the Scene Manager accessible to users less familiar with scripting.

Learn more about Behavior scripts [here](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md).

![](/assets/images/scene-manager-11-0d512960b7600999d75cb37f6d817c02.png)

## API Reference[​**](#api-reference "Copy to clipboard")

The Scene Manager provides a set of properties and methods accessible through the `global.sceneManager` object.

### Properties[​**](#properties "Copy to clipboard")

* `verbose`: `boolean` (Read/Write) - Controls verbose logging.
* `extensions`: `Array<SceneManagerExtension>` (Read-Only) - An array of extensions added to the Scene Manager.
* `minLoadingTimeInSeconds`: `number` (Read/Write) - The minimum display time (in seconds) for loading screens.
* `root`: `SceneObject` (Read-Only) - The root Scene Object where scenes are loaded (by default, the Scene Manager's object).
* `onSceneLoaded`: `Event<LoadedScene>` (Read-Only) - An event triggered when a scene is loaded.
* `onSceneUnloaded`: `Event<LoadedScene>` (Read-Only) - An event triggered when a scene is unloaded.

### Methods[​**](#methods "Copy to clipboard")

#### `loadSceneSync(name: string, options?: Object): LoadedScene`[​**](#loadscenesyncname-string-options-object-loadedscene "Copy to clipboard")

Loads a scene synchronously.

**Parameters:**

* `name` (string, required): The name of the scene (as defined in the Scene Manager's registry).

* `options` (object, optional): An object with optional parameters:

  <!-- -->

  * `additive`: `boolean` (default: `true`) - Whether to load the scene additively.
  * `enabled`: `boolean` (default: `true`) - Whether the scene should be enabled after loading.
  * `parent`: `SceneObject` (default: `undefined`) - The parent Scene Object for the loaded scene. If `undefined`, the Scene Manager's object is used.

**Returns:**

* `LoadedScene`: A `LoadedScene` object representing the newly loaded scene.

#### `loadSceneAsync(name: string, options?: Object): Promise<LoadedScene>`[​**](#loadsceneasyncname-string-options-object-promiseloadedscene "Copy to clipboard")

Loads a scene asynchronously.

**Parameters:**

* `name` (string, required): The name of the scene.

* `options` (object, optional): An object with optional parameters:

  <!-- -->

  * `additive`: `boolean` (default: `true`) - Whether to load additively.
  * `enabled`: `boolean` (default: `true`) - Whether the scene should be enabled after loading.
  * `parent`: `SceneObject` (default: `undefined`) - The parent Scene Object.
  * `onProgress`: `(percentage: number) => void` (default: `null`) - A callback function called with the loading progress (0 to 1).
  * `loadingScene`: `string` (default: `null`) - The name of a scene to display while loading.
  * `onComplete`: `(loadedScene: LoadedScene) => void` (default: `null`) - A callback function called when loading is complete.
  * `onFailure`: `(errorMsg: string) => void` (default: `null`) - A callback function called if loading fails.

**Returns:**

* `Promise<LoadedScene>`: A Promise that resolves with the `LoadedScene` object when loading is complete or rejects with an error message if loading fails.

#### `registerScene(registryItem: SceneRegistryItem, override?: boolean): SceneRegistryItem | undefined`[​**](#registersceneregistryitem-sceneregistryitem-override-boolean-sceneregistryitem--undefined "Copy to clipboard")

Registers a new scene in the Scene Manager's registry.

**Parameters:**

* `registryItem`: `SceneRegistryItem`, The item to register.
* `override`: `boolean`, optional, if true and there is a naming conflict, will override existing item.

**Returns:** `SceneRegistryItem` if successfully registered, otherwise returns `undefined`.

#### `unregisterScene(sceneName: string): void`[​**](#unregisterscenescenename-string-void "Copy to clipboard")

Unregisters a scene from the registry.

**Parameters:**

* `sceneName`: `string`, The name of the scene to be unregistered.

**Throws:** Error, if scene name is not found in registry.

#### `findSceneByPrefab(prefab: ObjectPrefab): SceneRegistryItem | undefined`[​**](#findscenebyprefabprefab-objectprefab-sceneregistryitem--undefined "Copy to clipboard")

Finds a registered scene by its prefab.

#### `findScenePrefabByName(sceneName: string): SceneRegistryItem | null`[​**](#findsceneprefabbynamescenename-string-sceneregistryitem--null "Copy to clipboard")

Finds a registered scene by its name.

#### `getCurrentScene(requester: SceneObject): {myScene: LoadedScene, climbCount: number}`[​**](#getcurrentscenerequester-sceneobject-myscene-loadedscene-climbcount-number "Copy to clipboard")

Gets the current parent scene of a given Scene Object.

#### `unloadSceneByName(registryName: string): void`[​**](#unloadscenebynameregistryname-string-void "Copy to clipboard")

Unloads all instances of a scene, given its registry name.

#### `unloadScenes(scenes: LoadedScene[], onUnloadCompleteCallbacks?: Function[]): void`[​**](#unloadscenesscenes-loadedscene-onunloadcompletecallbacks-function-void "Copy to clipboard")

Unloads an array of `LoadedScene` objects.

#### `unloadScene(scene: LoadedScene, onUnloadComplete?: Function): void`[​**](#unloadscenescene-loadedscene-onunloadcomplete-function-void "Copy to clipboard")

Unloads a single `LoadedScene`.

#### `isLoaded(sceneName: string): LoadedScene[] | false`[​**](#isloadedscenename-string-loadedscene--false "Copy to clipboard")

Checks if a scene with the given name is currently loaded.

#### `dontDestroyOnUnload(sceneObject: SceneObject): void`[​**](#dontdestroyonunloadsceneobject-sceneobject-void "Copy to clipboard")

Marks a Scene Object to prevent it from being destroyed when its parent scene unloads.

### Object Types[​**](#object-types "Copy to clipboard")

These are the primary object types used by the Scene Manager:

#### `SceneRegistryItem`[​**](#sceneregistryitem "Copy to clipboard")

Represents a registered scene.

* `sceneName`: `string` (Read-Only) - The name of the scene.
* `sceneAsset`: `ObjectPrefab | RemoteReferenceAsset` (Read-Only) - The prefab or remote asset associated with the scene.
* `type`: `"Asset.ObjectPrefab" | "Asset.RemoteReferenceAsset"` (Read-Only) - The type of asset.
* `objectPrefab`: `ObjectPrefab | undefined` - Cached prefab (if `type` is `"Asset.ObjectPrefab"`).

#### `LoadedScene`[​**](#loadedscene "Copy to clipboard")

Represents a scene that has been loaded.

* `manager`: `SceneManager` (Read-Only) - The Scene Manager instance that loaded the scene.
* `loadedTime`: `number` (Read-Only) - The timestamp when the scene was loaded.
* `sceneRoot`: `SceneObject` (Read-Only) - The root Scene Object of the loaded scene.
* `source`: `SceneRegistryItem` (Read-Only) - The `SceneRegistryItem` from which the scene was loaded.
* `isAdditive`: `boolean` (Read-Only) - Whether the scene was loaded additively.
* `state`: `string` - The current state of the loaded scene.
