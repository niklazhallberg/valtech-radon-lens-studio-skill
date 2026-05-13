# Lens Studio for Unity Developers

As AR technology has evolved, many developers and designers are migrating from Unity Game Engine to Lens Studio, a top of the line platform specifically designed for AR development. While Lens Studio may seem similar at first, there are many differences that you should be aware of. This guide serves as a way to help translate content and workflows from Unity to Lens Studio, covering various aspects such as physics, VFX graphs, scripting, and user interfaces.

Whether you are new to Lens Studio or have been using it for a while, this document can be used as a comprehensive resource or a quick reference guide.

"Unity" and some of its feature names may be trademarks of Unity Technologies or its affiliates.

## Unity to Lens Studio Glossary[​**](#unity-to-lens-studio-glossary "Copy to clipboard")

Listed below are some of the common terminology used in Unity and what it is called in Lens Studio.

| Category      | Unity                                 | Lens Studio       | Note                                                                                       |
| ------------- | ------------------------------------- | ----------------- | ------------------------------------------------------------------------------------------ |
| Interface     | Hierarchy                             | Objects           |                                                                                            |
|               | Project (Assets)                      | Resources         |                                                                                            |
|               | Scene                                 | Scene             |                                                                                            |
|               | Game                                  | Preview           |                                                                                            |
|               | Inspector                             | Inspector         |                                                                                            |
|               | Console                               | Logger            |                                                                                            |
| Types         | GameObject                            | SceneObject       |                                                                                            |
|               | Component                             | Component         |                                                                                            |
|               | Prefab                                | Prefab            |                                                                                            |
| Materials     | ShaderGraph                           | Material Editor   |                                                                                            |
|               | Unity Visual Effect Graph (VFX Graph) | VFX               |                                                                                            |
| UI Components | Canvas                                | Canvas\*          | In Lens Studio, Canvas component's sole purpose is to display UI elements in "World Space" |
|               | Rect Transform                        | Screen Transform  |                                                                                            |
| Animation     |                                       |                   |                                                                                            |
| Scripting     | MonoBehaviour                         | ScriptComponent   | Lens Studio supports JavaScript, and TypeScript                                            |
| Physics       | RigidBody                             | PhysicsBody       |                                                                                            |
|               | Collider                              | Collider          |                                                                                            |
|               | Joint                                 | PhysicsConstraint |                                                                                            |

## The Editor UI Comparison[​**](#the-editor-ui-comparison "Copy to clipboard")

![image alt text](/assets/images/lens-studio-unity-0-4d21d97ec4a894def803e446dd18c685.png)

The default layout of Lens Studio is similar to Unity. There are six main panels in the Lens Studio interface:

* **[Scene Hierarchy](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#scene-hierarchy)**
* **[Asset Browser](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#asset-browser)**
* **[Scene](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#scene)**
* **[Logger](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#logger)**
* **[Inspector](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#inspector)**
* **[Preview](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#preview)**

Along with the Editor layout above, there are three editing panels for Script, Material, and VFX editing.

All panels can be dragged to your desired position and you can also reset those panels to default through the toolbar by selecting **Window** then **Panels** and select **Default layout**.

You can learn more about the panels in Lens Studio in the [Panels](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#objects) guide.

### Scene Hierarchy vs Hierarchy[​**](#scene-hierarchy-vs-hierarchy "Copy to clipboard")

![image alt text](/assets/images/lens-studio-unity-1-d2f97e34b4661224ccc32780d77f4571.png)

The `Scene Hierarchy` panel displays the hierarchy of all objects in your current scene, and allows you to enable or disable objects. The `Scene Hierarchy` panel also determines the render order and script execution order for objects in your scene. Objects at the bottom of the hierarchy will be rendered last, making them appear in front of objects at the top of the hierarchy.

The active scene is displayed after the colon, such as "Scene Hierarchy: Scene". When you have a Prefab activated as the current scene, you will have "Scene Hierarchy: PrefabName" displayed. To go back to your main scene, find the Scene object in your `Asset Browser` panel and double-click it.

It’s easy to get confused by the term “scene” because it’s used in several ways in Lens Studio:

* "Scene" Asset – The default main top-level container of your Lens, often simply called “Scene.”
* "Scene" Panel – The 2D or 3D editing viewport where you move, rotate, and modify objects.
* "Scene" as Prefab – In Lens Studio, prefabs can be opened in isolation, effectively as a scene.

### Asset Browser vs Project (Assets)[​**](#asset-browser-vs-project-assets "Copy to clipboard")

![image alt text](data:image/png;base64,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)

In Lens Studio, the `Asset Browser` panel serves the same purpose as the Project panel in Unity. It lists all the resources (assets) that are currently available in the project, including Meshes, Materials, Textures, Scripts, Sounds, and more.

To add a new resource to the project, you can drag and drop a valid file into the `Asset Browser` panel.

### Scene vs Scene[​**](#scene-vs-scene "Copy to clipboard")

![image alt text](/assets/images/lens-studio-unity-3-ac350142a50ed2624e4495d107bf6f44.png)

The `Scene` panel is where you can place and manipulate the objects in your scene. You can use the `Scene` panel to visually move, rotate, and scale objects, as well as access various camera controls through the panel's toolbar.

#### 2D Scene and 3D Scene[​**](#2d-scene-and-3d-scene "Copy to clipboard")

![image alt text](data:image/png;base64,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)

![image alt text](/assets/images/lens-studio-unity-5-a9e1980fdaa28cab7f8a4dbe44878c9b.png)

In Lens Studio, in addition to the default `Scene` view, there are a series of feature-specific editors available. You can find them under the `Window` -> `Editors` menu.

For example, the 2D Editor is for moving and editing Screen Transforms, making editing UI much more intuitive. Any objects with Screen Transform instead of regular Transform will be shown here.

![available feature-specific editors](/assets/images/special-editors-7429dd10a3a47596c1c6a775901c40f5.png)

For information on manipulating objects in both scene modes, you can refer to the [Toolbar and Shortcuts](/lens-studio/lens-studio-workflow/lens-studio-interface/toolbar-and-shortcuts.md#toolbar)guide.

### Preview vs Game[​**](#preview-vs-game "Copy to clipboard")

![image alt text](/assets/images/lens-studio-unity-6-bcce426b132d745856abbde98cda14e7.png)

The Preview panel in Lens Studio allows you to see what your Lens will look like within Snapchat without having to upload it to a device. One major difference from Unity is that often there is no need to constantly play and stop the run in Lens Studio. By default, the Preview panel runs constantly and updates in real-time as you make changes to your scene, such as through scripting, material editing, or altering scene objects. You could choose to stop the run, but it is often unnecessary. You can also pair your device to Lens Studio to view your Lens on your mobile device. Once you've paired Lens Studio with your device, you can easily transfer your lens to the Snapchat app for further previewing.

[Previewing Your Lens](/lens-studio/lens-studio-workflow/previewing-your-lens.md)

You can also switch to webcam preview mode to view your lens through your device's camera.

### Inspector vs Inspector[​**](#inspector-vs-inspector "Copy to clipboard")

![image alt text](/assets/images/lens-studio-unity-7-4194114924b47f8482bdf6639155fcb4.png)

There is no difference between Lens Studio and Unity. The Inspector panel allows you to add and edit components on the selected object.

[./panels#inspector](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#inspector)

### Logger vs Console[​**](#logger-vs-console "Copy to clipboard")

![image alt text](data:image/png;base64,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)

The Logger panel provides insights into the state of your Lens as well as Lens Studio itself.

[./panels#logger](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#logger)

## Scene Objects and Prefabs[​**](#scene-objects-and-prefabs "Copy to clipboard")

### From GameObjects to Scene Objects[​**](#from-gameobjects-to-scene-objects "Copy to clipboard")

In Unity, GameObjects are the fundamental objects representing characters, props, and scenery. In Lens Studio, Scene Objects serve a similar function as containers for various built-in components, including image, audio, interaction, and script.

Every Scene Object has a non-deletable Transform component. Additional components that enhance functionality can be added by clicking the `Add Component` button in the Inspector panel. Depending on the type of object you're creating, you can add different combinations of components to a Scene Object.

![Scene Object Components](/assets/images/lens-studio-unity-9-71c462bca354bcfee6a83ce743955f27.png)

### Prefab and Multi-scene Setup[​**](#prefab-and-multi-scene-setup "Copy to clipboard")

In Lens Studio, the [Prefab](/lens-studio/lens-studio-workflow/prefabs.md) system allows for the creation of reusable components, similar to Unity's prefabs. Lens Studio treats prefabs as scenes, enabling a multi-scene setup. Like Unity's scene files, you can double-click a prefab to open it in the current hierarchy, making it the active scene for editing.

To create a prefab, drag any Scene Object from the `Scene Hierarchy` panel to the `Asset Browser` panel. Prefab components can be instantiated at runtime or in the editor and exported as an `.lspkg` file, similar to Unity's `.unitypackage`, including all dependencies.

In Lens Studio, use the ObjectPrefab API to access prefab components or utilize the [Scene Manager](/lens-studio/lens-studio-workflow/scene-set-up/scene-manager.md) to manage multiple scenes in your project.

#### Editing a Prefab[​**](#editing-a-prefab "Copy to clipboard")

![Prefab Editing in Scene Hierarchy](/assets/images/lens-studio-unity-prefab-scene-editing-718fd200a70a303c2d28707ea9c6ad39.png)

Similar to Unity, you can edit a prefab by opening it as a scene or by editing an instance of the prefab within a scene. Changes made to a prefab can be applied to all instances by clicking the `Apply` button in the Inspector panel. You can also revert changes to the prefab by clicking the `Revert` button.

![Prefab Apply and Revert Options](/assets/images/lens-studio-unity-10-8342f64bec82de51c4d23e51c4cfa37e.png)

### Scene Management[​**](#scene-management "Copy to clipboard")

As mentioned earlier, Lens Studio treats prefabs as scenes. This means you can switch, instantiate, and delete scenes at runtime by loading and unloading prefabs. The Scene Manager, a custom component available in the Asset Library, helps manage multi-scene operations in your project. For more information, refer to the [Scene Manager](/lens-studio/lens-studio-workflow/scene-set-up/scene-manager.md) guide.

### Exported Packages: .lspkg[​**](#exported-packages-lspkg "Copy to clipboard")

Exported packages facilitate the modularization of larger projects, the transportation of standalone packages for troubleshooting, sharing with other creators, or publishing online for easy access. In most cases, exporting in Lens Studio generates a `.lspkg` file, while exporting a Custom Component results in a `.lsc` file. For more details, visit the [Asset Packages Introduction](/lens-studio/features/package-management/asset-packages-introduction.md).

## Asset Library vs Asset Store[​**](#asset-library-vs-asset-store "Copy to clipboard")

The Unity Asset Store and Lens Studio Asset Library are both repositories of assets and tools that can be used to create or enhance projects in their respective platforms. The Unity Asset Store contains a wide range of assets, including textures, models, animations, entire project examples, tutorials, and editor extensions, and is available for use in any project created in Unity. Some assets in the Unity Asset Store are free, while others are commercial and require payment.

In contrast, everything in the Lens Studio Asset Library is free to use. The Lens Studio Asset Library is specifically tailored for use in creating Lenses in Lens Studio and includes assets such as simple reusable assets and machine learning models. While assets from the Unity Asset Store can be used in other engines, those from the Lens Studio Asset Library can only be used within Lens Studio.

## Persistent Storage and PlayerPrefs[​**](#persistent-storage-and-playerprefs "Copy to clipboard")

Unity provides a built-in feature, known as PlayerPrefs, to preserve game data across sessions. PlayerPrefs is commonly employed to retain game progression and player configuration settings, with the load and save system being a prevalent use case.

Similarly, Lens Studio offers a comparable feature, known as the Persistent Storage system. In its default configuration, script variables hold their value only while the Lens is active. To transfer data between Lens sessions, one may use the Persistent Storage system by writing and retrieving data from storage. To illustrate, consider the following example:

```
var store = global.persistentStorageSystem.store;
var scoreKey = 'totalScore';
//read data
var currentGameScore = store.getInt(scoreKey);
//write data
store.putInt(scoreKey, 10);
```

To learn more about Persistent Storage, check out this [page](/lens-studio/features/persistent-cloud-storage/persistent-storage.md).

## Scripting[​**](#scripting "Copy to clipboard")

Lens Studio uses the ECMAScript 2019 version of JavaScript and [TypeScript](/lens-studio/features/scripting/typescript.md).

Before diving into specific scripting content, you can view the [full API list](https://developers.snap.com/lens-studio/api/lens-scripting/documents/Full_API_List.html) in the following link.

### Getting Started with Sample Projects[​**](#getting-started-with-sample-projects "Copy to clipboard")

Lens Studio offers a series of sample projects that can be a great way to start your journey with Lens Studio. While Lens Studio has its own unique legacy and way of doing things that may be different from Unity. Here are a few tips to help ease you in:

1. Start from the top, and work your way down. This is due to the Lens Studio [Execution Order](#execution-order).
2. Lens Studio encourages creators to reuse existing helper scripts. Sometimes people trade a "perfect" design pattern in exchange for reusing a helper script to avoid repetitive work. So when you open a new sample project, the first thing you can do is to spend a bit more time in the editor, try finding all the Behavior and Tween scripts being used. For more information, take a look at the [Official Helper Script](#script-module-and-asset-library) section.

### Execution Order[​**](#execution-order "Copy to clipboard")

In Lens Studio, the order in which scripts are executed can be determined by the location of their associated SceneObjects in the `Scene Hierarchy` panel. SceneObjects at the top of the panel will have their scripts executed before those attached to SceneObjects lower in the hierarchy. This is why you may see helper scripts, such as TweenManager, placed at the top of the `Scene Hierarchy` panel. This ensures that necessary functions and variables are initialized before they are called upon by other scripts. In contrast, Unity has a Script Execution Order setting in the Project Settings to adjust the order in which scripts are run.

![image alt text](/assets/images/lens-studio-unity-11-98f447e1e21584fdbce1f3d365dcd2e2.png)

### Script Module and Asset Library[​**](#script-module-and-asset-library "Copy to clipboard")

If you are familiar with JavaScript, you may already know that it is a dynamically-typed language that does not use preprocessors like "include" or have the concept of "namespaces." However, it does have tools for modularization and connecting different scripts together. In Lens Studio, the Script Module feature allows you to structure your code in a more logical and organized way. It is highly recommended that you take advantage of this tool to streamline your workflow.

You can find more information about Script Modules in this [link](/lens-studio/features/scripting/script-modules.md) .

In Lens Studio's Asset Library, you can find a section dedicated to Script Modules, which includes some common modules that you may use frequently.

![image alt text](/assets/images/lens-studio-unity-12-c8226d44bb04b9e63050bded1118ec5d.png)

### The `global` object[​**](#the-global-object "Copy to clipboard")

#### Built-in Global Methods and Properties[​**](#built-in-global-methods-and-properties "Copy to clipboard")

The global object in Lens Studio is a powerful tool that allows you to access built-in methods and properties, as well as store your own variables, functions, and prototypes. Some examples of built-in global methods and properties include:

1. [`global.scene`​](/lens-studio/api/lens-scripting/classes/Built-In.ScriptScene.html) : [`ScriptScene`](/lens-studio/api/lens-scripting/classes/Built-In.ScriptScene.html)

Returns the global [ScriptScene](/lens-studio/api/lens-scripting/classes/Built-In.ScriptScene.html) object, which offers information and controls for the current scene.

1. [`global.getTime() : number`](/lens-studio/api/lens-scripting/functions/Built-In.getTime.html)\`

Returns the time in seconds since the lens was started.

You can find the full list [here](/lens-studio/api/lens-scripting/functions/Built-In.isNull.html).

#### Store your own things on `global`[​**](#store-your-own-things-on-global "Copy to clipboard")

You can use the global object to store and access your own variables and functions in Lens Studio. This is useful because it allows you to access these values and functions from anywhere in your code, similar to how you use static classes and functions in C#. In the next few examples, you can see how you can utilize the global object including storing variables, and accessing them from anywhere in your code. You can also create and store global functions. Additionally, you can register your prototypes or classes on the global object for easy access throughout your project.

You can register/store variables on it, make them accessible from wherever you want. Similar to how you make static classes in C#.

```
global.myScore = 0;
//inside another script
global.myScore++;
```

You can register/store a set of functions in it, making those functions global. Again, similarly to how you use static functions.

```
global.makeBox = function(){//make a box}
```

You can register your prototypes/classes on it.

```
global.Car = function (color) {
  //do
};
global.Car.prototype.createNewCar = function () {
  //do
};
var newCar = new global.Car(red);
```

### Event Listeners[​**](#event-listeners "Copy to clipboard")

Event listeners allow you to respond to specific events in your code. There are two ways to create event listeners in Lens Studio:

* The Asset Library's Script Modules section features the Event Module, which enables you to design custom events. You can refer to the script header for helpful examples on how to utilize it effectively. To provide a brief overview of its usage, here is a minimal example:

  ```
  //import the module
  var EventModule = require('EventModule');
  //create a new event
  var onScoreChange = new EventModule.EventWrapper();
  //register a listener to the event
  onScoreChange.add(function (newScore) {
    print('score changed, new score is ' + newScore);
  });
  //call the event. all listeners added to the event get executed too
  onScoreChange.trigger(10);
  ```

* Listening to built-in events, such as `InteractionComponent.onTap`, by using the `.add(function)` method to add your callback functions to the event.

### Helper Scripts[​**](#helper-scripts "Copy to clipboard")

When coming from Unity, the idea of relying on helper scripts may be an unfamiliar workflow. It's important to note that while this approach may result in slightly different design patterns, it is generally a good trade off for AR apps, which tend to be less complex than Unity games.

You don't need to fully understand the inner workings of helper scripts in order to use them effectively.

You can find helper scripts through the **Plus (+)** sign at the top left corner of the `Scene Hierarchy` panel.

![image alt text](/assets/images/lens-studio-unity-13-e990605bc0879a3eebad7b106c254d0e.png)

#### Behavior.js[​**](#behaviorjs "Copy to clipboard")

The Behavior script is a common type of helper script that can be found in many projects. It allows users to incorporate a wide range of common tasks into their projects without writing any code. The behavior script acts as a "if \[trigger] then do \[response]" system, with a variety of triggers and responses available. Even experienced developers can benefit from using the behavior script.

#### Tween[​**](#tween "Copy to clipboard")

Tweening is a common technique in front-end JavaScript that is used to animate the position, scale, or other attributes of an element over time. If you have experience with front-end development, you may already be familiar with tweening as a way to add visual interest or polish to a project. While the primary function of tweening is often cosmetic, it can also be an important tool in interaction design, as it can significantly impact the user experience of a project. You can

### Life Cycle Events[​**](#life-cycle-events "Copy to clipboard")

In Lens Studio, scripts that are attached to SceneObjects are typically triggered by an event, such as onAwake or onTouch. However, it is recommended to leave the trigger in the Inspector set to the default onAwake and bind actual triggers in the script. This can be done using the createEvent and bind functions, which allow you to create a `Start()` and `Update()` function similar to those found in Unity.

To create an update function and bind it to the UpdateEvent, you can use the following code:

```
function update() {
  // write your update code here
}
var updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(update);
```

By standardizing your script triggers this way can help improve the clarity of your code and make it easier for others to understand the trigger for each script without needing to switch back and forth between the Lens Studio editor.

For more information, please visit [Script Events | Docs](/lens-studio/features/scripting/script-events.md#introduction)

### Reference to other scripts and components[​**](#reference-to-other-scripts-and-components "Copy to clipboard")

#### Assign Reference in Inspector[​**](#assign-reference-in-inspector "Copy to clipboard")

Similar to Unity, Lens Studio provides ways to expose variables in the Inspector panel you could drag other objects, no matter if it is a Prefab, a texture, a SceneObject or another script to the slots.

To create a script level object while exposing it in the `Inspector` panel, you can use the `//@input` keyword. The property is automatically added to the `script` object, and is treated as public, meaning it can be accessed by other scripts.

Here are few examples:

```
//primitive types
//@input bool myBool;
//@input vec3 myVec;

//Components
//@input Component.Animation myAnimation;
//@input Component.Image myImage;

//a Asset
//@input Asset.ObjectPrefab myPrefab;
//@input Asset.LocationAsset myLocAsset;

//you can access them by

var ani = script.myAnimation;
var prefab = script.myPrefab;
```

There isn’t a complete list of all the acceptable object types, but you could check out the [Input Type list](/api/lens-studio/InputTypes.md) for all the primitive types, and[the Component list](https://developers.snap.com/lens-studio/api/lens-scripting/documents/Components_List.html) for all the Component types, and [the Asset list](https://developers.snap.com/lens-studio/api/lens-scripting/documents/Assets_List.html) for all the Asset types.

#### Cross Referencing Scripts[​**](#cross-referencing-scripts "Copy to clipboard")

As of 4.0, there is no way to access a script specifically by name. You would just use `getComponent("Component.ScriptComponent")`. In the case that there are several scripts on the same scene object, you can use `getComponents()` which will return an array of components of that type. Once you have the list of ScriptComponents, you could check if a given script has a certain property of function to determine its "type."

```
/* ======================== */
/* main.js */
var scriptsComponents = myObject.getComponents('Component.ScriptComponent');
var targetScript;
scriptsComponents.forEach(function (sc) {
  if (sc.isFoo === true) {
    targetScript = sc;
  }
});

/* ======================== */

/* script Foo.js */

script.isFoo = true;
```

## Physics[​**](#physics "Copy to clipboard")

Lens Studio contains a fully featured built-in physics system for running physics solutions in real-time. The physics system contains some differences in organization compared to other physics engines, such as Unity.

### PhysicsBody vs PhysicsCollider[​**](#physicsbody-vs-physicscollider "Copy to clipboard")

For simplicity, you can think of Lens Studio's PhysicsBody as similar to Unity's Rigidbody, and Lens Studio's PhysicsCollider as similar to Unity's Collider. However, in Lens Studio, a PhysicsBody comes with a collider integrated by default and cannot exist without one. This means that if an object already has a PhysicsBody, you do not need to add a separate PhysicsCollider to it. On the other hand, you can turn a PhysicsBody into a collider-only object by disabling the **Dynamic** checkbox.

### Physics Constraint (Joint)[​**](#physics-constraint-joint "Copy to clipboard")

Lens Studio has three types of physics-based joints: **Fixed**, **Point**, and **Hinge**. These are sufficient for most cases, and are known as Physics Constraints in Lens Studio. Like in Unity, a Physics Constraint (joint) requires a PhysicsBody (rigidbody) to function.

### Physics World Settings[​**](#physics-world-settings "Copy to clipboard")

In Unity, world settings are located in the Project Settings under the Physics tab. In Lens Studio, Physics World Settings are assets that can be created and customized. You can add this setting via `Asset Browser > + > Physics World Settings`. To use the settings, in the `Asset Browser` panel, click on the `Scene` asset, and set it as the `Physics Root Settings`. Additionally, each `Physics World` component can optionally reference a specific `Physics World Settings` asset, or use the `Physics Root Settings` of the `Scene` by default. Lastly, WorldSettings can be applied per-collider.

To learn more, check out [the Physics Asset and Components](/lens-studio/features/physics/physics-component.md#physics-collider) guide

## UI[​**](#ui "Copy to clipboard")

### World Space vs. Screen Space[​**](#world-space-vs-screen-space "Copy to clipboard")

[Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) is the fundamental building block for displaying UI elements in Lens Studio, similar to Unity's RectTransform. In Unity, there is a Canvas component that has three different modes: Screen space (overlay), Screen space (camera), and World space. In Lens Studio, there is an equivalent to Screen space (camera), and World space. However, these modes are not consolidated under a single component like in Unity.

#### Screen Space (Camera)[​**](#screen-space-camera "Copy to clipboard")

In Lens Studio, to have screen space UI elements, you need to first have an Orthographic Camera, and then you can start adding Screen Transforms under it. Remember to set the layers of those Screen Transforms to Orthographic.

#### World Space[​**](#world-space "Copy to clipboard")

Lens Studio introduced the Canvas component in version 4.31. Canvas works similarly to Unity's Canvas, serving as a parent for other Screen Transforms like Text and Images. Because they are shown in the 3D world, you do not need to set their layers to Orthographic.

You can also add an Image or Text component directly into the world without using Canvas, as long as they have a regular Transform component instead of a Screen Transform. However, if you do this, your project will not be benefiting from the powerful layout tools that come with Screen Transform.

### UI Elements[​**](#ui-elements "Copy to clipboard")

Lens Studio provides a set of [Custom UI Components](/lens-studio/features/ui/ui-widgets.md) for creating common UI components like UI Button,, UI Toggle, UI Color Picker, Ui Scroll View, etc. You can find these Custom Components in the Asset Library.

### Layout Elements[​**](#layout-elements "Copy to clipboard")

Similar to Unity’s [Auto Layout](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/comp-UIAutoLayout.html) tools, Lens Studio provides Horizontal Layout and Vertical Layout components for automatic layout. However, unlike in Unity, only children elements that have a Layout Element component are affected by the Horizontal Layout or Vertical Layout. For more information, you can refer to this [documentation](/lens-studio/features/ui/flexbox.md).

## Rendering and Effects[​**](#rendering-and-effects "Copy to clipboard")

As a mobile facing, all-tier friendly tool, Lens Studio provides standard rendering features for creating flexible, light-weight graphics.

### Rendering Order and Passes vs Render Targets[​**](#rendering-order-and-passes-vs-render-targets "Copy to clipboard")

In Lens Studio, the order in which objects are rendered is determined by their position in the Object hierarchy. Objects at the top of the hierarchy are rendered first, followed by those below them. The number next to the enabled checkbox indicates an object's position in the render order, with 0 being the first and 1 being the second, and so on.

Unlike Unity, Lens Studio only supports Forward Rendering. However, you can still customize your rendering by using Render Targets (which are similar to Unity's Render Textures) or [Screen Texture](/lens-studio/features/graphics/screen-texture-provider.md) (which is an implicit reference to the current render target). By organizing your Scene Objects in the `Scene Hierarchy` panel from top to bottom, you can effectively create a customized rendering "pipeline".

### Case Study: Obtain the Depth Data[​**](#case-study-obtain-the-depth-data "Copy to clipboard")

The Material and VFX editors in Lens Studio provide a Depth node, which returns the depth for a specific vertex or fragment. However, if you want to use depth data in your script, such as to manipulate UVs, you can follow these steps:

1. Create a `Depth Render Target` in the `Asset Browser` panel.
2. Assign the newly added `Depth Render Target` to the `Depth Render Target` field on the camera from which you want to obtain depth data.
3. Lens Studio will automatically write depth data to the render target.
4. You can access the depth data in scripts, materials, VFX, or any other location where you may need it.

Learn more in the [Depth Render Target](/lens-studio/features/graphics/materials/material-templates/depth-render-target.md) guide.

The `Depth Render Target` assigned to the camera will contain the depth data of the `Camera` component, in contrast to the `Depth Texture`, which holds the depth data from the device's camera.

### Materials and Shaders[​**](#materials-and-shaders "Copy to clipboard")

Unity introduced ShaderGraph in 2019 and it allows users to construct materials in a node-based graph system. Lens Studio has something very similar called the [Material Editor](/lens-studio/features/graphics/materials/material-editor/welcome-to-material-editor.md). Unlike in Unity where you can create custom materials both with written shaders in HLSL/ShaderLab and the ShaderGraph, the Material Editor is the only way to create custom shaders/materials in your Lens Studio project.

While you must use the Material Editor to create shaders and materials, you can still write shader code within the Material Editor using the [Custom Code node](/lens-studio/features/graphics/materials/material-editor/code-node/code-node-guide.md). While Unity uses HLSL, the Custom Code node uses GLSL along with some special formatting for variables. All standard GLSL functions are available within Code Node.

### VFX and Particle System[​**](#vfx-and-particle-system "Copy to clipboard")

Lens Studio has a Visual Effects (VFX) Graph system that is similar to Unity's VFX Graph. The VFX editor in Lens Studio is a node-based editor that allows you to modify properties of particles at three stages: spawn, update, and output. Unity's VFX Graph has four stages: spawn, initialize, update, and output.

In addition to nodes, the VFX editor also has access to the Custom Code node, which allows you to write custom GLSL code to affect your particles.

While Lens Studio does not have a particle system that works directly with in-scene physics colliders like Unity's Particle System, the VFX Graph does provide several ways to create collisions for your particle systems similar to Unity's approaches. For more information, you can refer to the [VFX Collisions documentation](/lens-studio/features/graphics/particles/vfx-editor/vfx-collisions.md).

#### Asset "Particles"[​**](#asset-particles "Copy to clipboard")

Additionally, you can use the Particles asset, which uses a specialized material instead of the VFX graph to create a particle system. You can create the Particles asset by clicking the plus button on the `Scene Hierarchy` panel and selecting "Particles." This material already has options for many common particle attributes available to modify in the Particles material, such as spawn options, color ramps, noise, and velocity.

To learn more, here is where you can learn the basics of VFX in Lens Studio: [Learn More](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md#getting-started)

### Post Effects[​**](#post-effects "Copy to clipboard")

Lens Studio has a built-in system for adding post effects to your projects. To use this feature, you can add a Post Effect component to a Scene Object. There are many pre-made post effects available in Lens Studio, such as Smoothing, Blur, HalfTone, and Edge. You can access these by clicking the plus button on the `Scene Hierarchy` panel and hovering over the Post Effect option. In addition to these ready-made effects, you can also create and edit your own Post Effect materials using the Material Editor with an output Shader node set to "Post Effect."

To learn more about Post Effect, you can check out [this page](/lens-studio/features/graphics/materials/post-effects.md).

## Build and Release[​**](#build-and-release "Copy to clipboard")

Build and release in Lens Studio is simple and straightforward. Your Lenses will be hosted through one of the environments:

* Snapchat (Android and iOS)
* Spectacles (Wearable)
* [Camera Kit](https://ar.snap.com/camera-kit) (publication process may vary)

You can publish your lens through the **Publish Lens** button in Lens Studio. For more detailed steps, checkout this [guide](/lens-studio/publishing/submitting/submitting-your-lens.md). Although your lens has to exist on one of Snap's platforms, once it’s published, your AR application will be available to a vast global audience of active users.
