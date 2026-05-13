# Simple World Mesh

The Simple World Mesh Example showcases a way you can take advantage of the [World Mesh](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md) to understand the world around you and add effects that respond to them.

This example uses the World Mesh, which capabilities can vary across devices. Take a look at the [World Mesh guide](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md) to learn more.

[](/img/lens-studio/simple-world-mesh_image-0.webm)

## Guide[​**](#guide "Copy to clipboard")

Find the `Spawn Object at World Mesh on Tap` asset in the `Asset Library` and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets from the `Asset Library`.

Once you import the asset from `Asset Library`, you can find the package in the `Asset Browser`.

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/spawn-object-world-mesh-1-064b3f6f92cadb2e38798c981a8797ce.png)

Follow the instructions and drag the prefab `Spawn Object at World Mesh on Tap` into `Scene Hierarchy` to create a new Scene Object.

![](/assets/images/spawn-object-world-mesh-2-da62cc1b74f47e03c7c9d8f5d64452d1.png)

This asset requires a device tracking component. First, select the main `Camera Object` and add a `Device Tracking` component. Next, ensure you assign the Device Tracking to the `Device Tracking` field in the Script Component on the `Spawn Object at World Mesh on Tap` scene object.

![](/assets/images/spawn-object-world-mesh-3-bae62ba85380c82bb4a88f27a6045707.png)

You can push the Lens to your device as you would with any other Lens, but your device must support World Mesh. You can preview how it would look on a supported device in Lens Studio using the [Interactive Preview](/lens-studio/lens-studio-workflow/previewing-your-lens.md#interactive-preview) mode in the Preview panel.

### Tap To Spawn Example[​**](#tap-to-spawn-example "Copy to clipboard")

This example allows you to spawn any prefab in the world. You can simply tap on the screen and see your prefab spawns in the world.

[](/img/lens-studio/simple-world-mesh_image-0.webm)

#### Set up Object Spawning[​**](#set-up-objectspawning "Copy to clipboard")

To change the spawning object, first we need to create a [prefab](/lens-studio/lens-studio-workflow/prefabs.md) from the object that we want to spawn. The easiest way of making a prefab resource is to right click on your object in the `Scene Hierarchy` panel and then selecting Save as Prefab. As soon as you click you can see the new prefab added to the `Asset Browser` panel.

[](/img/lens-studio/5-features/spawn-object-world-mesh-4.webm)

Since we have a backup of our object as a prefab in the `Asset Browser` panel, you can simply delete the one in the `Scene Hierarchy` panel. However, make sure to keep the one in the `Asset Browser` panel.

[](/img/lens-studio/5-features/spawn-object-world-mesh-5.webm)

Now that we have our prefab ready, let’s modify the example so we can spawn our own prefab into the world. To do that first select the `Spawn Object at World Mesh on Tap` object, then in the `Inspector panel`, replace the prefab input with the prefab that we just created.

![](/assets/images/spawn-object-world-mesh-6-183d9441e07d673b82a317b5040a7eda.png)

[](/img/lens-studio/5-features/spawn-object-world-mesh-7.webm)

Now we can tap on the screen and see our new object is getting spawned in the world!

#### Set up Scene Effect[​**](#set-up-scene-effect "Copy to clipboard")

This example also comes with a custom graph material that lets you easily design patterns and attach it to the world.

[](/img/lens-studio/simple-world-mesh_image-7.webm)

You can find this material by selecting the `World Mesh Visualization` object in the `Scene Hierarchy` panel. Then in the `Inspector` panel, right click on `world_mesh_visualization` material and click the `Select` option.

[](/img/lens-studio/5-features/spawn-object-world-mesh-8.webm)

Now you can change the `Pattern` input to your own image to create your own pattern and apply it to the world.

[](/img/lens-studio/simple-world-mesh_image-9.webm)

Feel free to play around with values to create your own amazing pattern!

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
