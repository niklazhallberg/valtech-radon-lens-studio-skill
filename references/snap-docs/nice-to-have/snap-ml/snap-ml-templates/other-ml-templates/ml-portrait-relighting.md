# Portrait Relighting

Portrait relighting introduces the ability to change the light and background of input photos, as well as adding custom lighting to photos. This allows for users to place themselves into virtual environments and enhance the photorealism of 3D assets.

[](/img/lens-studio/ml-portrait-relighting-0.webm)

Portrait Relightening feature is implemented as a custom component that creates a Post Effect object in scene that reacts to the scene lighting.

## Installing the Portrait Relighting Custom Component[​**](#installing-the-portrait-relighting-custom-component "Copy to clipboard")

You can find the Portrait Relighting Component in Lens Studio `Asset Library`.

![](/img/lens-studio/5-features/portrait-relighting-cc.png)

Click on the **Install** button to make it available in your Lens Studio project.

### Adding to Scene[​**](#adding-to-scene "Copy to clipboard")

In a new Lens Studio project, create a new Scene Object or new Screen Transform.

With the newly created object selected, click on the **Add Component** button in the `Inspector` Panel and select `Portrait Relighting`.

![](/img/lens-studio/5-features/portrait-relighting-add-component.png)

Make sure that the `Create Visual` checkbox is checked and that the `Render Order` is set to `1`.

![](/img/lens-studio/5-features/portrait-relighting-render-order.png)

By default, when the `Create Visual` checkbox is checked, the Portrait Relighting component will automatically generate a `Post Effect` component in the scene. Material used for this Post Effect will react to the lights in the scene.

Please note that this component is meant to be used on the portrait camera view only, please make sure to have a Person preview image or video selected.

### Adjusting Lights[​**](#adjusting-lights "Copy to clipboard")

A new lens studio project usually has default lighting set-up that looks like this:

![](/img/lens-studio/5-features/portrait-relighting-default-lighting.png)

You can make some adjustments to make your Portrait Relighting effect look better.

Select the `Light` Scene Object. Rename it to `Ambient Light`. In the `Inspector` Panel, change the **Light Type** from `Directional` to `Ambient` and adjust the **Intensity** slider to `0.2`. Feel free to play with the **Color** and **Intensity** parameters to see how the effect responds to the Light settings.

Make sure the **Layers** setting of the Light components is set to include the same Render Layer that your Portrait Relighting component is on. This can be easily verified by looking at circular color indicators on the right-hand side of the `Inspector` Panel.

![](/img/lens-studio/5-features/portrait-relighting-lighting-layer.png)

Currently the Portrait Relighting Component supports Envmap, Ambient, Point and Directional [types of light sources](/lens-studio/features/graphics/light-and-shadow.md#types-of-light-sources). Spotlight is NOT supported.

You can experiment with adding more light sources to get different results:

1. Click on the `+` button in the `Scene Hierarchy` panel and select `Light`. Rename this new light to `Point Light`.

2. In the Inspector Panel, set the `Light Type` to `Point`, set the position to `0, 0, 20`, and change the color parameter to the color of your liking.

   ![](/img/lens-studio/5-features/portrait-relighting-lighting-settings.png)

Try experimenting with the placement of the Point Light. In the `Scene` Panel, click on the Point Light. If the Move Tool doesn’t appear, press the **W** button on your keyboard to turn it on. Play around with moving the Point Light on the X (red) and Y (green) axes. Notice how the lighting changes in the `Preview` Panel.

[](/img/lens-studio/5-features/portrait-relighting-point-light.webm)

### Creating and Using Proxy Textures[​**](#creating-and-using-proxy-textures "Copy to clipboard")

The Portrait Relighting Component is built upon a ML model that produces several output textures which can be used to build custom materials. They are:

* **Albedo:** A full screen texture with normalized light values
* **Normals:** A full screen normals texture
* **Opacity:** A full screen portrait segmentation texture

The `Create Proxy Textures` setting allows you to plug in textures into the Portrait Relighting Component. The easiest way to do this is to use Proxy Textures (empty textures).

You can also assign textures through scripting by assigning control property of one texture to another: `destinationTexture.control = sourceTexture.control`

Let’s go through the steps to add Proxy Textures to the Portrait Relighting Component:

1. Select the Scene Object with the Portrait Relighting Component and enable the `Create Textures` checkbox.

2. In the `Asset Browser` panel, click the `+` button and type in `Proxy Texture`. Press Enter to add a Proxy Texture to the `Asset Browser` panel.

3. Rename this Proxy Texture to **Albedo Texture**.

4. Repeat steps 2 and 3 two more times, and name the new Proxy Textures **Normal Texture** and “Opacity Texture”, respectively.

   [](/img/lens-studio/5-features/portrait-relighting-proxy-texture.webm)

5. Select the Portrait Relighting Custom Component in the `Inspector` Panel. Drag and drop the newly created Proxy Textures from the `Asset Browser` panel into the corresponding inputs in the `Inspector` Panel.

   ![](/img/lens-studio/5-features/portrait-relighting-proxy-texture.png)

Now you can use these textures in your own materials as usual.

### Building Example Material[​**](#building-example-material "Copy to clipboard")

You can start by building a simple material using the Proxy Textures that we created previously.

First, select the Portrait Relighting Component and disable **Create Visual**.

You should now see that the Portrait Relighting effect is no longer visible in the Preview Panel. Now you will set up a custom Post Effect where we will input the Albedo, Normal, and Opacity Proxy Textures:

1. In the `Asset Browser` panel, click the `+` button, type in `Empty Material`, and Add an Empty Material into your project.

2. Double click on the newly created Empty Shader to open up the Graph view. There should only be one node in the graph, the **Shader** node.

3. Select `Shader` node to reveal the properties in the `Inspector` Panel.

4. Change **Type** from `3D` to `Post Effect`.

   ![](/img/lens-studio/5-features/portrait-relighting-post-effect-node.png)

5. Right click on some empty space in the Material Editor, click on `Add Node`, type in `PBR` and press Enter.

6. Click on the new PBR node. In the `Preview Panel` set **Mode** from `Diffuse and Specular` to `Diffuse Only`.

   ![](/img/lens-studio/5-features/portrait-relighting-pbr-node.png)

7. Add three **Texture 2D Parameter** Nodes. Using the `Preview` Panel, rename the Nodes to `Albedo`, `Opacity`, and `Normal`, respectively.

8. Connect the Texture 2D Parameter nodes to their corresponding slots in the PBR Node.

   ![](/img/lens-studio/5-features/portrait-relighting-shader-graph.png)

9. Assign `Albedo`, `Opacity`, and `Normal` textures to the Material and change the `Blend Mode` from `Disabled` to `Normal`.

   ![](/img/lens-studio/5-features/portrait-relighting-material-setting.png)

Now that the Post Effect Material is complete, you can apply this Material to our Scene.

1. In the `Scene Hierarchy` panel, right click on the Camera and create a new Scene Object.

2. Rename the new Scene Object to **Relighting Post Effect**.

3. With Relighting Post Effect selected, click on **+ Add Component** in the `Inspector` Panel and add a new “Post Effect”.

4. Drag and drop the Portrait Relighting Material into the **Material** slot on the Post Effect Component.

   ![](/img/lens-studio/5-features/portrait-relighting-post-effect-setting.png)

Congrats! You now have a Post Effect Material that uses the Proxy Textures generated by the Portrait Relighting Component. Use this Material as a jumping-off point for more advanced effects.

Check out Asset Library for more examples!

Please note that this Post Effect is a 2D Full Screen effect, and in order to overlay it with different 2D and 3D objects you will need to create multiple cameras. The next section will provide an example of setting up a complex scene with 3D head attachments and different types of Light sources.

## Portrait Relighting With Lights Asset[​**](#portrait-relighting-with-lights-asset "Copy to clipboard")

In the previous sections, You have already walked you through creating a Portrait Relighting effect from scratch. Now, let’s take a look at the Portrait Relighting With Lights Asset.

Find the `Portrait Relighting With Lights Asset` asset in the `Asset Library` and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the `Asset Library`. Once you import the asset from `Asset Library`, you can find the package in the `Asset Browser`. Follow the instructions and drag the prefab `Portrait Relighting With Lights__PLACE_IN_SCENE` into `Scene Hierarchy` to create a new Scene Object and add `Layer 1` to Camera Render Layers.

![](/img/lens-studio/5-features/portrait-relighting-camera-render-layers.png)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

The asset demonstrates how to create a simple lighting setup using an Environment Map and an Ambient Light. Try adjusting the `Envmap [EDIT ME]` Light Source with a new Environment Map:

1. Make sure that `Envmap [EDIT ME]` is selected in the `Scene Hierarchy` panel
2. Add a different Diffuse and Specular map to the **Light Source** component of the `Envmap [EDIT ME]` by dragging and dropping a new `Diff` and `Specular` file found in the `Asset Browser` panel > Environment Maps.
3. Adjust the **Rotation** slider. Notice how the lighting changes when you do so.

Now, let’s add a new Directional Light to this example. Look at the `[ADD LIGHT]` Scene Object in the `Scene Hierarchy` panel for instructions on how to do so.

1. Create a new Scene Object that is a child of the `Lights - Simple` Scene Object.
2. Rename the new Scene Object to `Directional Light`.
3. With `Directional Light` selected, click on **+ Add Component** in the `Inspector` Panel. Add a new “Light Source”.
4. Change **Light Type** to `Directional`.
5. Click on the **Layers** dropdown and make sure that the `Layer 1` Layer is selected.
