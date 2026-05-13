# Prefabs

When creating Lenses, you may encounter situations that call for the creation of multiple copies of the same Scene Object. While you could duplicate the object manually, you might find it inconvenient to update properties on the individual copies. Prefabs offer a convenient alternative to this process, allowing you to create reusable Scene Objects that share common properties.

![](/assets/images/prefabs_object_prefab_grid-5be9f4681490452ff2a9285a86ef4a64.png)

The advantage to using a Prefab (rather than duplicating a SceneObject) is that you can modify the Prefab and immediately apply your changes to all instances of that Prefab. If you were to simply duplicate the object, you would have to manually apply any changes to all copies yourself.

[](/img/lens-studio/prefabs_prefab_intro_demo.webm)

Prefabs allow you to:

* Instantly propagate changes across several identical SceneObjects
* Dynamically instantiate Scene Objects via scripting
* Export and share a Scene Object across different Lens Studio projects

This guide will cover how to create, edit, and script with Prefabs, as well as how to export Prefabs from a Lens Studio project.

## Example Prefab Use Cases[​**](#example-prefab-use-cases "Copy to clipboard")

Some examples of where separating your Lenses might be helpful

* A try-on experience where you want the user to use one item at a time.
* A game with many levels, where the users may only play some levels.
* A loading/intermediate screen that you might want to reuse in different parts of the experience.
* An experience where you have a UI overlay that can be managed independently from the rest of the Lens.
* An experience where you might jump from section to section. By separating the experience into pieces, you can jump from one section to another easily.
* A common piece that you want to re-use in multiple Lenses.

If you have a Lens that is loading a lot of content, it is a great idea to use prefab, so that your Lens can open fast to entice users, before finally loading the full experience.

## Creating a Prefab[​**](#creating-a-prefab "Copy to clipboard")

You can create a Prefab from an existing Scene Object in your Lens Studio scene. To create a Prefab:

1. In the `Scene Hierarchy` panel, select the Scene Object you want to convert to a Prefab
2. Drag the Scene Object to the `Asset Browser` panel, and release it
3. A Prefab Resource with the same name as the Scene Object will be created

You can also create a prefab by right clicking an object in the `Scene Hierarchy` panel and selecting `Save as Prefab`

The Prefab you create will have the same Components, Transform properties, and Scene Object hierarchy (children) as the Scene Object you originally selected.

Note that the original Scene Object you selected has now been converted to an Instance of the Prefab. This is denoted in the `Inspector` panel by the addition of three new buttons, which you can see when the Scene Object is selected:

* **Highlight**: Selects the Prefab Resource in the `Asset Browser` panel
* **Apply**: Apply any changes made to a Prefab Instance to the Prefab Resource
* **Revert**: Undo any changes made to a Prefab Instance, reverting to the state represented by the Prefab Resource

![](/assets/images/prefabs_prefab-instance-66a6063617cf7b0c9775a4f3ae292640.jpg)

When you create a Prefab, the following properties will be saved in the Prefab Resource:

* Transform properties of every Scene Object that is a child of the root prefab object in the hierarchy
* Components and Component properties of every Scene Object in the hierarchy

A prefab is instantiated into a Lens in two general parts: Loading its content for use, and instantiating its content to be used in the Lens.

There are different methods of loading the contents of a prefab:

* **On Lens Start**: Load the contents of the prefab when the Lens first opens regardless of use.
* **Lazy Load Assets**: Load the contents of the prefab just before instantiating.

You can set how the contents are loaded by selecting the prefab in the `Asset Browser` panel.

In most cases **you will want to use Lazy Loading** to ensure the Lens can start as soon as possible and increase the likelihood of Snapchatters engaging with your Lens.

![](/assets/images/prefabs-lazy-loading-8d5a715bb42afe4c6ee6c12da3572ade.png)

## Using a Prefab[​**](#using-a-prefab "Copy to clipboard")

To include a Prefab in your scene:

1. In the `Asset Browser` panel, select the Prefab Resource you want to add.
2. Drag the Prefab Resource from the `Asset Browser` panel to the `Scene Hierarchy` panel, and release it.
3. A Scene Object with the same name as your Prefab Resource will be added to the Scene, and to the `Scene Hierarchy` panel

The Scene Object created will have the same Components, Transform properties, and Scene Object hierarchy (children) as the Prefab you selected from the `Asset Browser` panel.

You can use prefabs dynamically: that is instantiate them in the Lens at run time. Take a look at the [Scripting with Prefabs](#scripting-with-prefabs) section, or take a look at [Scene Manager](/lens-studio/lens-studio-workflow/scene-set-up/scene-manager.md) to see how you can do this with no code!

## Applying Changes to a Prefab[​**](#applying-changes-to-a-prefab "Copy to clipboard")

One of the key advantages to working with Prefabs is the ability to apply changes to all instances of a Prefab while editing only one instance of the prefab.

Double click on a prefab in the Asset Browser to edit it in isolation. This will open the prefab in its own Scene Hierarchy and Scene panel. Click “Apply” in the Inspector to save changes to the prefab and have them take effect in the project. To return to the main Scene Hierarchy / Scene, double click on the Scene asset in the Asset Browser.

![](/img/lens-studio/whats-new-with-lens-studio-27.png)

To apply changes to a Prefab:

1. Select an instance of the Prefab in your Scene
2. Modify the selected Scene Object or its children
3. In the `Inspector` panel, select `Apply`

[](/img/lens-studio/prefabs_prefab-apply-1.webm)

All instances of the Prefab in your scene will reflect the changes you made, with the following exceptions:

* Changes to position of the Prefab’s root Scene Object will only be applied to new instances. Existing instances will not change their position
* Changes to rotation of the Prefab’s root Scene Object will only be applied to new instances. Existing instances will not change their rotation
* Changes to scale of the Prefab’s root Scene Object will be applied to both new and existing instances
* Changes to position, rotation, and scale of the Prefab’s child Scene Objects will be applied to both new and existing instances

## Reverting a Prefab[​**](#reverting-a-prefab "Copy to clipboard")

If you’ve made unwanted changes to an instance of a Prefab, you can undo them to prevent them from being applied to the Prefab Resource and other Prefab instances.

1. Select the Prefab instance you want to revert in the `Objects` pan

   [](/img/lens-studio/prefabs_prefab-select-reverb.webm)

2. In the `Inspector` panel, select `Revert`

   [](/img/lens-studio/prefabs_prefab-reverb.webm)

Any changes you made to the Scene Object will be reverted. Its state should reflect the state of its Prefab resource.

## Highlighting a Prefab[​**](#highlighting-a-prefab "Copy to clipboard")

You can find a Prefab instance’s Prefab resource. To do so:

1. Select a Scene Object. If it's an instance of a Prefab, you should see the `Highlight` button in the `Inspector` panel.
2. Select the `Highlight` button, and the Prefab Resource used to create the Scene Object will be automatically highlighted in the `Asset Browser` panel.

## Scripting with Prefabs[​**](#scripting-with-prefabs "Copy to clipboard")

You can instantiate Prefabs with script to create more complex experiences--this will allow you to dynamically instantiate the prefab as you need it.

There are different methods of instantiating a prefab.

* **Synchronously**: blocks anything from happening while the prefab is instantiated.
* **Asynchronously**: load the prefab and get a callback when it’s done.

In most cases, when using prefabs as a container for different scenes in your Lenses, you will want to load your prefab with lazy loading, and asynchronously, to ensure that the prefab will only affect the Lens when you are using it.

### Synchronous[​**](#synchronous "Copy to clipboard")

The following example creates an instance of a Prefab every time the user touches the screen.

```
//@input Component.Camera camera
//@input Asset.ObjectPrefab myPrefab
script.createEvent('TouchStartEvent').bind(onTouchStart);
function onTouchStart(e) {
  if (script.camera) {
    var touchPosition = e.getTouchPosition();
    var worldPosition = script.camera.screenSpaceToWorldSpace(
      touchPosition,
      200
    );
    var mySceneObject = createObjectFromPrefab();
    mySceneObject.getTransform().setWorldPosition(worldPosition);
  }
}
function createObjectFromPrefab() {
  if (script.myPrefab) {
    var instanceObject = script.myPrefab.instantiate(script.getSceneObject());
    return instanceObject;
  } else {
    return undefined;
  }
}
```

[](/img/lens-studio/prefabs_prefab_scripting_example.webm)

This script makes use of the ObjectPrefab API to instantiate a Prefab defined by the user in the script's input properties. The key lines to focus on in the above example is adding the Asset.ObjectPrefab to the script inputs and then calling instantiate to create the new object.

```
//@input Asset.ObjectPrefab myPrefab
var instanceObject = script.myPrefab.instantiate(script.getSceneObject());
```

Prefabs can contain objects with scripts that will be run when the object is instantiated. That said, when instantiating prefabs in script, any script bound to the `Lens Turned On` event within the prefab will not be run because at that point, the Lens has already been turned on. If you want a script in a prefab to be run when you instantiate it, make sure to bind your logic to the `Initialized` event.

### Asynchronous[​**](#asynchronous "Copy to clipboard")

Since the performance of a Lens is commonly correlated with its engagement, when possible, you will only want to load a prefab when you need it. This will ensure a Lens can start as soon as possible, and you’re doing everything you can to ensure a great experience for your users.

When working on a Large Lens project, you can use prefabs to break up your Lens into smaller pieces. This makes it more manageable to build, as well as allows you to load the Lens in pieces and improve its performance. Take a look at [Scene Manager](/lens-studio/lens-studio-workflow/scene-set-up/scene-manager.md) to see how you can do this with no code!

To instantiate asynchronously, as before we start by getting a reference to the prefab we want to instantiate:

```
// @input Asset.ObjectPrefab myPrefab
```

Next we will define what we want to do when we try to instantiate this prefab:

```
function onResolve(instantiatedObject) {
  Studio.log('We got the prefab!');
}
function onReject(error) {
  Studio.log(error);
}
function onProgress(percentage) {
  Studio.log(percentage);
}
```

In Lens Studio, the prefab will always load fast since it’s always in memory. You can see the big difference when you push it to the device!

Finally, we will instantiate the prefab asynchronously!

```
var parent = script.getSceneObject();
script.myPrefab.instantiateAsync(parent, onResolve, onReject, onProgress);
```

Take a look at [Scene Manager](/lens-studio/lens-studio-workflow/scene-set-up/scene-manager.md) to see how you can do this with no code!

## Sharing Prefabs Across Projects[​**](#sharing-prefabs-across-projects "Copy to clipboard")

Prefab resources can be exported and shared across different Lens Studio projects, like any other Resource.

Changes made to an imported Prefab will not affect the Prefab in the project from which the Prefab was exported.

### Exporting a Prefab[​**](#exporting-a-prefab "Copy to clipboard")

To export a Prefab:

1. In the `Asset Browser` panel, select the Prefab you want to export.

   [](/img/lens-studio/prefabs_prefab-select-box.webm)

2. Right-click on the Prefab and select `Export`

   [](/img/lens-studio/prefabs_prefab-export.webm)

3. Select a location to save the `.oprfb` file and select `Save`

### Importing a Prefab[​**](#importing-a-prefab "Copy to clipboard")

To import a Prefab:

1. In the `Asset Browser` panel, select `+ -> From Files`
2. Navigate to the location of the `.oprfb` file, select it, and select `Open`
3. The Prefab resource should now be in your `Asset Browser` panel. To add it to your scene, you can drag it from the `Asset Browser` panel to the `Scene Hierarchy` panel

## Prefab Pro-Tips[​**](#prefab-pro-tips "Copy to clipboard")

Prefabs are extremely powerful ways to make your Lens dynamic. Consider the tips below to ensure a great experience with Prefabs.

### Destroy Created Objects[​**](#destroy-created-objects "Copy to clipboard")

If your prefab create objects (or even more prefabs), they will not be automatically cleaned up when you delete your prefabs, unless they are a child of the prefab.

One way you can clean up any created objects is by destroying them `onDestroyEvent` of a script inside your prefab.

In the Asset Library, you can import the `Destruction Helper` that can help you do this.

With `Destruction Helper` imported, you can replace the `createSceneObject` line with the following:

```
var DestructionHelper = require('DestructionHelper');
var manager = new DestructionHelper(script);
var blurObject = manager.createSceneObject(null);
```

The `Destruction Helper` manager will then automatically destroy any scene object created under it when it is destroyed.
