# World Mesh Example

The World Mesh example allows you to instantiate and occlude virtual objects based on real world surfaces through real-time 3D mesh reconstruction of what your device sees. The example allows you to instantiate objects based on surface types, or based on its orientation.

This example uses the World Mesh, which capabilities can vary across devices. Take a look at the [World Mesh guide](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md) to learn more.

The World Mesh used in this example was previously limited to device with LiDAR. However, starting with Lens Studio 4.10, this capability can be used on devices with LiDAR and recent devices with ARKit or ARCore. This example also comes with a fallback mechanism for devices without World Mesh capability.

[](/img/lens-studio/world-mesh_world-mesh-2.webm)

## Guide[​**](#guide "Copy to clipboard")

You can push the Lens to your device as you would with any other Lens, but your device must support World Mesh. You can preview how it would look on a supported device in Lens Studio using the [Interactive Preview](/lens-studio/lens-studio-workflow/previewing-your-lens.md#interactive-preview) mode in the Preview panel.

[](/img/lens-studio/world-mesh_world-mesh-3.webm)

### Setting up the Example[​**](#setting-up-the-example "Copy to clipboard")

#### Bringing the Example in[​**](#bringing-the-example-in "Copy to clipboard")

Find the `World Mesh - Spawn On Surfaces` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/worldmesh-1-2c013812c1ad2a48e71cb7ce0ce717ca.png)

Follow the instructions and drag the prefab `World Mesh - Spawn On Surfaces__PLACE_IN_SCENE` into Scene Hierarchy to create a new Scene Object.

[](/img/lens-studio/5-features/worldmesh-2.webm)

#### Setting up the scene[​**](#setting-up-the-scene "Copy to clipboard")

Following the note in the prefab (`1. Add Device Tracking - World to [Camera Object]`), we need to add `Device Tracking` to our camera so the Lens knows to track the world.

In the `Objects` panel, select `Camera`. Then, in the `Inspector` panel press `Add Component -> Device Tracking`.

![](/assets/images/worldmesh-3-17e97652102a4d96dffe2695412ef8fd.png)

Then, select `World` in the `Device Tracking` drop down.

![](data:image/png;base64,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)

Learn more in the [World Tracking](/lens-studio/features/ar-tracking/world/overview.md) guide.

Finally, we will tell our spawner about this component. In the `Scene Hierarchy` panel, select `2. WorldMesh Controller [Set Tracker Input]`. Then, in the `Inspector` panel, click on the `Tracker` field, and choose the newly added `Device Tracking` component.

![](/assets/images/worldmesh-5-2e50a4e556ddf066488014a6612fa17b.png)

### How it Works[​**](#how-it-works "Copy to clipboard")

The World Mesh Example demonstrates two of the key features enabled by World Mesh:

* **World Mesh:** A mesh that is automatically generated that represents the real world. You can use this to occlude AR effects based on the real world
* **Hit Test Results:** Using the ray casting or hit test function, you can learn about the mesh that was hit at a certain point, as well as its position, normal. On device with LiDAR, you can also get information on the type of surface that is hit. Learn more about this in the [API documentation](https://developers.snap.com/api/lens-studio/Classes/Components#DeviceTracking--raycastWorldMesh)

Like other Lenses where the user should be able to walk around, this example uses the `World` mode in the `Device Tracking` Component found in the `Camera` object.

You can see the World Mesh being built in this example, by selecting the `World mesh` object, and then changing it's material from `occluder` to one that is visible.

![](/assets/images/worldmesh-7-eae4343003cf0a83678dfd5dd8fa85eb.png)

[](/img/lens-studio/5-features/worldmesh-8.webm)

### Instantiating Objects Based on a Surface's Information[​**](#instantiating-objects-based-on-a-surfaces-information "Copy to clipboard")

The example provides two ways of describing where your virtual objects should be instantiated: by surface type, or by normal orientation.

**By surface type** uses semantic information about the surface it is potentially instantiating on. This is only available on devices with LiDAR. You can specify that a virtual object should only spawned on:

* Wall
* Floor
* Ceiling
* Table
* Seat
* Window
* Door
* None (of the above types)

When a device is unable to semantically describe a surface, it will default to `None`.

The example provides an `All` type which will add a spawner for each type described above, such that you can ensure that an object is spawned everywhere. This is useful when you want an object to spawn regardless of whether the surface type is known or not.

**By normal orientation** uses the orientation of the detected surface to determine what should be instantiated. In other words, you can tell an object to instantiate only on:

* Up facing surfaces (like tables and floors)
* Down facing surfaces (like ceilings)
* Vertical surfaces (like walls)

You can mix and match these two descriptors as needed. Take a look at the [Spawner Setup](#spawnersetup) section below to learn more.

For example, we can select one of the spawner setup, and increase the number of instances.

![](/assets/images/worldmesh-9-953c7b94344b4f1406b8e00af386edde.png)

Then, in the preview panel, we can see how we're instantiating on surfaces with that setting.

[](/img/lens-studio/5-features/worldmesh-10.webm)

### Scene Setup[​**](#scene-setup "Copy to clipboard")

Each object we want to spawn require three things:

* The **Render Mesh Visuals** to spawn
* A **special Graph material** for each Render Mesh Visual that enables instantiation
* A **SpawnerSetup** script which configures how the object should be spawn

By default, the example comes with several objects and their corresponding spawner for each surface type.

* **Desert:** Seat type
* **Clouds:** Wall type
* **Boat:** Floor type
* **Forest:** Table type
* **Stars:** Ceiling type
* **Planets:** None type (surface types we don't know)
* **Clouds:** All vertical surfaces
* **Plane:** All down facing surfaces
* **Trees:** All up facing surfaces

You can play around with the **Interactive Preview**, to see these objects instantiate in your scene as if you were on a device with LiDAR. The classic video and photo preview will demonstrate what the Lens will look like on non LiDAR devices.

You can find the visuals underneath the `Objects Presets` object, and their `SpawnerSetup` underneath the `Objects Controller` object.

![](/assets/images/worldmesh-11-6b7789642ebea511c2e72d2982aaf638.png)

Each referenced Render Mesh Visual has a special graph material. Since we are populating the world with a lot of these objects, it is more efficient to instantiate them through their material (shader), rather than with additional scene objects.

These Graph materials are unique in that they have their `Frustum Culling` with `Extend` option with a large padding so that they don’t disappear when you look away from their origin (since the instantiation can be anywhere), and have parameters that are passed in through the script which describes where they should be instantiated.

![](/assets/images/worldmesh-12-be0d7c93ea8778e057417c6965356e2c.png)

At a high level, the `SpawnerSetup` will tell the special graph material  to instantiate new copies of the Render Mesh Visual, based on the `Hit Test Result`.

### Spawning Your Own Object[​**](#spawning-your-own-object "Copy to clipboard")

#### Bringing in your Assets[​**](#bringing-in-your-assets "Copy to clipboard")

You can import your own 3D object by dragging them into the Scene panel of Lens Studio. Then, drag them under the `Objects Presets` objects in the `Scene Hierarchy` panel.

[](/img/lens-studio/5-features/worldmesh-13.webm)

With the object imported, add the mesh into your scene. Put it under the `Objects Presets [EDIT_CHILDREN]` object.

![](/assets/images/worldmesh-15-6e7a76d9192541ac8bda098bfc927e4f.png)

Learn more in the Export and [Importing 3D content guide](/lens-studio/assets-pipeline/3d/importing-content/overview.md).

#### Applying the Special Material[​**](#applying-the-special-material "Copy to clipboard")

With your objects imported, let's create the special material to apply to it.

You can right-click on the `World Mesh - Spawn On Surfaces` asset in the `Asset Browser` panel, and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/worldmesh-14-7f8b7ab12569a7e405c9be010db06ca9.png)

Duplicate one of the example special graph materials by right clicking on one in the `Asset Browser` panel, and then pressing the `duplicate` button.

![](/assets/images/worldmesh-16-9f40f178932d8b8e6ebccb5361e2f02d.png)

Then assign the new material to the `Render Mesh Visual`of the object you’ve imported.

![](/assets/images/worldmesh-17-3b885c253efdf793580a82d0876e1123.png)

Since the default materials are colored to help differentiate the various instances, you can set the `Base Color` to white so that your texture comes through without color modifications.

![](/assets/images/worldmesh-18-9f055832f36dcbd5e38d05be8695c00f.png)

This example comes with several example materials to help you get started. However, since they are graph materials, feel free to customize them to your needs by double-clicking on your copy in the `Asset Browser` panel to open it in the [Material Editor](/lens-studio/features/graphics/materials/material-editor/introduction-and-concepts.md)!

![](/assets/images/worldmesh-19-07e7c0437732aac44d58580581c006ee.png)

If you want to instead add the special capability to an existing graph material, you can copy all nodes related to the Vertex Shaders, and increase the `Frustum Culling` padding of your material.

Additionally, make all the texture parameters under `Controller by Script` use the `Filtering Mode Nearest` (click the `V` button next to the texture to show the texture’s option). This is important to make sure that the shader can read the precise data passed in by script, rather than a filtered data.

![](/assets/images/world-mesh_world-mesh-11-9233e0dbef6841be8654ce16ee22668c.png)

![](data:image/png;base64,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)

You can see an example of a material which has a custom setup in the material used by the water. In the water material, the water texture is made procedurally rather than through a texture.

#### Adding Spawner Setup[​**](#adding-spawner-setup "Copy to clipboard")

Finally, with your objects set up, we can spawn them with the `SpawnerSetup`.

In the `Scene Hierarchy` panel, create a new object under `Objects Controller`.

![](/assets/images/worldmesh-20-621fb29a97389c4f7df5c074a3534418.png)

Then select the new object, and in the Inspector panel, press `Add Component > SpawnerSetup` script

![](/assets/images/worldmesh-21-5933f9aa28324e3871fba53c19af7cd6.png)

### Spawner Setup[​**](#spawner-setup "Copy to clipboard")

The Spawner Setup script contains several options to configure how you want your objects to be spawned.

* **Objects:** a list of objects with a render mesh visual on them, with the special graph material described above.
* **Group objects:** When this option ticked, all of the listed objects will be positioned in the same place. With it unticked, one of the listed objects will be spawned at random.
* **Surface Type:** The type of surface that you want this object to be spawned on.
* **Ignore World Pos:** Use vec3(0,0,0) as the position of the object instance instead of the position of the object in the Inspector panel.
* **Orientation:** How you want to generate the rotation for each instance.
* **Direction Type:** Whether you want to spawn the object only when the hit test provides a certain orientation.
* **Spacing:** How crowded you want the objects to be. The higher the number, the less crowded. Usually a higher number is better so that you can cover more areas with less objects.
* **Min Scale:** Min value of multiplier for the object’s scale.
* **Max Scale:** Max value of multiplier for the object’s scale.
* **Max Instances:** The max number of objects to be spawned in the world.

![](/assets/images/worldmesh-22-93306940c0be3ebf2478a0eb9388b416.png)

With your Spawner setup, you should now see your objects instantiated around the scene in the `Preview` panel.

Under the `WorldMesh Controller` object in the `Helper Scripts` object inside the `Scene Hierarchy` panel, you can change the Surface Dir Variation such that the `Direction Type` doesn't have to be exact. That is: allow surfaces that are generally facing the expected orientation to pass (e.g. a generally up facing surface will count as an up facing surface).

### Fallback Mode[​**](#fallback-mode "Copy to clipboard")

By default, the example provides a virtual surface for floor, table, and wall objects. You can skip this section if you don't need a specific configuration.

On devices without LiDAR capabilities you can define how you want your objects to populate the world by describing a “virtual surface.”

You can add your own or modify these definitions in the `WorldMeshController` script by defining a generator for a fake `Hit Test Result`.

For example, in the case below, we provide points on a surface between `-125` and `125` in the x-axis, `-50` in the y-axis, and somewhere between `50` to `250` in the z-axis, all of which have a normal is facing `up`, to spawn an object for the surface type `floor`.

```
var fakeFloorResult = {
  isValid: function () {
    return true;
  },
  getWorldPos: function () {
    return new vec3(Math.random() * 250 - 125, -50, Math.random() * 250 - 50);
  },
  getNormalVec: function () {
    return vec3.up();
  },
  getClassification: function () {
    return global.WorldMeshController.surfaceType.Floor;
  },
};
```

Then, all we need to do is add this to the list of possible results:

```
var fakeResultsPool = [fakeFloorResult, fakeTableResult, fakeWallResult];
```

In this way, you can define both several types of surfaces, and even a number of surfaces for each type.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
