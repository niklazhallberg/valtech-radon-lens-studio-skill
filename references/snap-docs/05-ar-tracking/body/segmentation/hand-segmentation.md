# Hand and Nails Segmentation

To see examples of Hand Segmentation, take a look at the [Hand Segmentation](/lens-studio/features/ar-tracking/hand/hand-tracking-templates/hand-segmentation.md) template.

To see examples of Nails Segmentation, take a look at the `Nails Try-On` or `Nails Polish` objects in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

![](/img/lens-studio/hand-nails-segmentation-0.png)

The Hand Segmentation feature allows you to segment effects to within or around the hand or nails. It is similar to other types of Segmentations, except that it does it over a region rather than the full screen.

## Adding Hand or Nails Segmentation[​**](#adding-hand-or-nails-segmentation "Copy to clipboard")

To add Hand or Nails Segmentation into your project:

1. In the `Scene Hierarchy` panel, press the **+** button.
2. Select **Hand Segmentation**.
3. Select either Hand Segmentation or Nails Segmentation.

![](/img/lens-studio/hand-nails-segmentation-1.png)

This will add a new setup in your scene that will display a texture segmented within the Hand or Nails.

This setup for both hand and nails has an Image component that contains a special material that uses the Hand or Nails Segmentation as a mask for Texture. This object is a child of a Rectangle Setter which positions the segmented area to be tracked to the hand. Finally, the Rectangle Setter is a child of an Orthographic Camera, which renders these objects which are in screen space.

![](/img/lens-studio/hand-nails-segmentation-2.png)

### Applying a texture inside the Hand[​**](#applying-a-texture-inside-the-hand "Copy to clipboard")

In the `Scene Hierarchy` panel, select the `Hand Segmentation` object. Then, drag your texture from the `Asset Browser` panel into the `Texture` field.

[](/img/lens-studio/hand-nails-segmentation-3.webm)

Alternatively, you can click on the Texture field to bring up the texture selector pop up.

Take a look at the [Import](/lens-studio/assets-pipeline/importing-and-exporting-resources.md) guide to learn how you can bring your texture into Lens Studio.

Additionally, you can select the `Object Segmentation Texture Default` material to modify additional options around how your texture is displayed.

* **Segmentation Texture:** The Hand Segmentation texture (`Asset Browser` panel > + > Hand Segmentation)
* **Base Color:** choose a color to multiply your texture with
* **TextureUV:** choose how your texture is displayed within the Image
* **Radius & Softness:** choose how you want to smooth out the segmentation

![](/img/lens-studio/hand-nails-segmentation-4.png)

The `Object Segmentation Texture Default` material is a graph material. Double-click on it in the `Asset Browser` panel to open it in the Material Editor and see how it works.

![](/img/lens-studio/hand-nails-segmentation-5.png)

### Changing Nails color[​**](#changing-nails-color "Copy to clipboard")

To change the color of the nails:

1. In the `Scene Hierarchy` panel, select the `Nails Segmentation` object.
2. Right click on the materials and click **Select**.
   <!-- -->
   1. Alternatively, you can find `Nails Segmentation Texture Default` in the `Asset Browser` panel.

After selecting the material, you can change the `Base Color` property in the **Inspector** panel.

### Using the Hand Segmentation as an Occluder or with 3D objects[​**](#using-the-hand-segmentation-as-an-occluder-or-with-3d-objects "Copy to clipboard")

The Hand Segmentation texture is a texture that segments out the portion of the camera feed where the hand is, so by default it is used with an Orthographic camera as shown above.

However, you can also use this texture with 3D objects, as well as to occlude 3D objects. Take a look at the [Hand Segmentation template](/lens-studio/features/ar-tracking/hand/hand-tracking-templates/hand-segmentation.md) to learn how you can do this.

### Realistic Nails polish effects[​**](#realistic-nails-polish-effects "Copy to clipboard")

To see examples of Nails Segmentation, take a look at the `Nails Try-On` or `Nails Polish` objects in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Use `Nails Try-On` preset for textured nails and `Nails Polish` for solid color nails.

[](/img/lens-studio/hand-nails-segmentation-6.webm)

To change base nail texture:

1. Select "Nails Try-On" scene object.
2. Click and drag your texture from the `Asset Browser` panel into the `Overlay` field.
   <!-- -->
   1. Alternatively you can change contents rendered by the “\[Support] Particles” camera.

To change nail color:

1. Select `Nails Try-On` scene object.
2. Right click on the materials and click **Select**.
   <!-- -->
   1. Alternatively, you can find “NailsTryOn” in the `Asset Browser` panel. Then change the `OverlayColor` field.

## Hand and Nails Normal Maps[​**](#hand-and-nails-normal-maps "Copy to clipboard")

With Lens Studio 4.46, Nails Try-On now supports built-in textures with hand and nails normal maps. These normals can now can be used to understand the facing direction of the surface.

To see examples of Hand and Nails Normal Maps usage, take a look at the "Holographic Nails" or “Futuristic Nails” objects in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md)

![](/img/lens-studio/hand-nail-normals-0.png)

There is no additional performance cost to using both at the same time. You are also able to use these normal maps with Hand or Nails Segmentation and [2D Hand Tracking](/lens-studio/features/ar-tracking/hand/hand-gestures.md).

Take a look at [Person Normals and Depth](/lens-studio/features/graphics/person-normals-and-depth.md#body-normals-texture) for more cases of normal maps usage.

### Adding Hand or Nails Normals[​**](#adding-hand-or-nails-normals "Copy to clipboard")

To add Hand or Nails Normals into your project:

1. In the `Asset Browser` panel, press the **+** button.
2. Select **Hand Normals**.
3. Select either **Hand Normals Texture** or **Nails Normals Texture**.

![](/img/lens-studio/hand-nail-normals-1.png)

This will add a new texture resource in your project. You can pass the normal map to a material.

#### Hand or Nails Normal Maps Positioning[​**](#hand-or-nails-normal-maps-positioning "Copy to clipboard")

The map needs to be positioned as a hand. To achieve this you should use such a hierarchy with a Rectangle Setter.

![](/img/lens-studio/hand-nail-normals-2.png)

1. Make a child Rectangle Setter object to an Orthographic Camera.
2. Pass the Normals texture to the Rectangle Setter.

![](/img/lens-studio/hand-nail-normals-3.png)

3. Make a child Image to the Rectangle Setter.
4. The Scene Object with the Image should also contain Screen Transform.
   <!-- -->
   1. After adding it the map will be positioned correctly.

![](/img/lens-studio/hand-nail-normals-4.png)

### Nails Assets[​**](#nails-assets "Copy to clipboard")

To see examples of Hand and Nails Normal Maps, take a look at the `Futuristic Nails` or `Holographic Nails` objects in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

#### Futuristic Nails[​**](#futuristic-nails "Copy to clipboard")

[](/img/lens-studio/hand-nail-normals-5.webm)

To change nail’s color you can find **Nails Material** in the `Asset Browser` panel. After selecting the material, you can change **Nail color**, **Glow color** or **Highlight color**. You can also play with the rest of the material’s parameters by changing animation speed, tilting amplitude, nail density and more.

![](/img/lens-studio/hand-nail-normals-6.png)

To change the color of the glow on the hand, select **Nails Material** and change the value of **Hand Glow 0** and **Hand Glow 1** colors.

![](/img/lens-studio/hand-nail-normals-7.png)

#### Holographic Nails[​**](#holographic-nails "Copy to clipboard")

[](/img/lens-studio/hand-nail-normals-8.webm)

To change the nails colors, you can select the object **Color Animator** in the `Scene Hierarchy` panel and disable it to control manually or change the script contents to control the animation.

To control the colors manually after turning off the controlling script, select material **Nails Material** in the `Asset Browser` panel. Change properties **Base Gradient 0**, **Base Gradient 1** and **Highlight Color**.

![](/img/lens-studio/hand-nail-normals-9.png)
