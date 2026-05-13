# Cubemaps

Cubemaps are special textures that contain six individual 2d textures, one for each face of a cube. Instead of sending all six textures to a material, a single cubemap texture can be assigned and then sampled using a direction vector. Cubemaps are used for a variety of effects such as skyboxes, reflections, creative lighting, and more.

[](/img/lens-studio/cubemap-guide-0.webm)

Lens Studio supports both importing images to use as cubemaps, along with being able to dynamically render onto dedicated cubemap render targets. This guide will show you how to use both of these methods, then you will learn how to sample cubemaps in a material.

Lens Studio 4.43 includes a Cubemap Template and the accompanying [Cubemap Template Guide](/lens-studio/features/graphics/materials/material-templates/cubemap-template.md) as a showcase on how to get started with Cubemaps.

## Importing Cubemaps to Lens Studio[​**](#importing-cubemaps-to-lens-studio "Copy to clipboard")

The easiest way to work with cubemaps in Lens Studio is to import them from an image file. Lens Studio supports horizontal and vertical cross layouts in the following formats;

* `.png`
* `.jpeg`
* `.hdr`

![](/img/lens-studio/cubemap-guide-1.png)

In the diagram above, you can see how both a Horizontal and Vertical cross layouts are represented within Lens Studio.

When you have a cubemap image ready to import,

To import a cubemap, perform the following;

1. In Lens Studio 4.43 or newer, left-click the add (+) button in the `Asset Browser` panel.
2. Type "Cubemap" in the prompt.
3. Select the Cubemap option.

[](/img/lens-studio/cubemap-guide-2.webm)

This will open a file browser where you will select the cubemap image to import. Lens Studio will detect the layout automatically to be either horizontal or vertical based on the image’s aspect ratio.

Now, you have a cubemap in your project ready to be used by a material.

Simply dragging the horizontal or vertical cross image into Studio will not create a cubemap resource. To treat the image as a cubemap, you have to follow the steps above to select Cubemap from the `Asset Browser` panel.

## Creating a Cubemap Texture to Import[​**](#creating-a-cubemap-texture-to-import "Copy to clipboard")

Creating cubemaps from a third party application is relatively simple. There are many approaches, but you will need to end up with either a vertical or horizontal cross image that is laid out as shown in the images above.

One way of doing this is to render your scene with an equirectangular camera, sometimes called an HDRI camera. This will produce an image with equirectangular projection that can then be converted into a horizontal or vertical cross image.

The conversion can be done using various online tools, for example the excellent [HDRI-to-CubeMap tool](https://matheowis.github.io/HDRI-to-CubeMap/) by [Mateusz Wisniowski](https://github.com/matheowis).

![](/img/lens-studio/cubemap-guide-3.png)

You can also render all six faces of the cube with six cameras oriented along each axis. Each camera should be set to render with a 90 degree field of view with a 1:1 aspect ratio. Once you have all six images, you can arrange them into a horizontal or vertical cross layout using an image editor or compositor.

You can use the Cubemap Camera Custom Component in Lens Studio to import a camera rig that is already configured to render cubemaps.

![](/img/lens-studio/cubemap-guide-4.png)

An example of a cubemap rendering setup.

## Rendering Cubemaps in Lens Studio[​**](#rendering-cubemaps-in-lens-studio "Copy to clipboard")

Rendering into a cubemap render target is handled similar to normal rendering in Studio. The main three differences are:

1. The render target `textureType` is set to `TextureCubemap`.
2. The render target needs to be a square ratio.
3. Six cameras are needed, one for each cube face, and each one having its `renderTargetCubemapFace` property set appropriately.

First, any regular render target can be turned into a cubemap by setting the `textureType` on its `RenderTargetProvider:`

```
myCubemapRenderTarget.control.textureType =
  RenderTargetProvider.TextureType.TextureCubemap;
```

Next, the render target’s width and height needs to be the same so that it’s square. An example of this can be shown below:

```
myCubemapRenderTarget.control.resolution = new vec2(256, 256);
```

Finally, you will need to set up six cameras, one for each cube face. Each camera needs to have a 90 degree field of view and a square aspect ratio.

Shown below is an example of the camera settings required to render the Negative Z cube face:

```
myCameraComponent.devicePropertyUsage = Camera.DeviceProperty.None;
myCameraComponent.aspect = 1.0;
myCameraComponent.fov = (90 * Math.PI) / 180.0;
myCameraComponent.renderTargetCubemapFace = Camera.CubemapFace.NegativeZ;
myCameraComponent.renderTarget = myCubemapRenderTarget;
```

Setting the `renderTargetCubemapFace` will not orient the camera in any particular direction. This property tells Lens Studio which face of the cubemap render target the camera will render into. The camera’s position and direction is entirely up to you.

There is currently no way to set up cubemap rendering in the Lens Studio GUI, it must be done using Script.

### Cubemap Camera Custom Component[​**](#cubemap-camera-custom-component "Copy to clipboard")

Setting up all six cameras to create a seamless cubemap environment can be a bit tricky. However, you can use the Cubemap Camera Custom Component to speed up the process.

This Custom Component will convert a camera into a cubemap rendering rig with all the settings and rotations handled automatically. It also creates a cubemap render target that can be sent to mesh visuals, materials, VFX assets, and VFX components.

To use this custom component, you will need to install it to your Lens Studio project.

1. Navigate to the Asset Library
2. Search for Cubemap Camera
3. click the Install button.

Once installed, you will need to add the custom component to a Scene Object that has a Camera component.

![](/img/lens-studio/cubemap-guide-5.png)

Doing this will turn the camera on that Scene Object into a cubemap rendering camera. The existing camera’s position, rotation, and layer assignments are all transferred to the cubemap rendering setup and can be manipulated at runtime.

The custom component has the following options:

* **Resolution:** the width and height resolution of each cubemap face. The smaller this is, the faster the scene will render.
* **Use External Camera:** When disabled, the CC will modify the camera that is on the same Scene Object as itself to become a cubemap camera. When enabled, a Camera Component input is shown where a camera can be supplied from anywhere in the scene hierarchy.
* **Cubemap Receivers:** Materials/VFX Assets/Mesh Visuals/VFX Components are array inputs that allow you to enter any number of materials, VFX assets, mesh visuals, and VFX components that need to sample the cubemap render target. Each asset and component has its own Script Name string input where the Texture Cube Parameter’s script name from each respective object should be supplied.

Additionally, the custom component has a script API that allows it to be created and controlled from another script:

* `getResolution()` Returns the cubemap resolution (per-face)
* `getCubemapRenderTarget()` Returns the cubemap render target
* `setResolution(int resolution)` Sets the cubemap resolution (per-face)
* `addMeshVisual(Component.MaterialMeshVisual meshVisual, string scriptName)` Add a mesh visual component to receive the cubemap render target
* `addVFXComponent(Component.VFXComponent vfxComponent, string scriptName)` Add a VFX component to receive the cubemap render target
* `addMaterial(Asset.Material material, string scriptName)` Add a material to receive the cubemap render target
* `addVFXAsset(Asset.VFXAsset vfxAsset, string scriptName)` Add a VFX asset to receive the cubemap render target

![](/img/lens-studio/cubemap-guide-6.png)

## Using Cubemaps in Materials[​**](#using-cubemaps-in-materials "Copy to clipboard")

Now that you have either a cubemap imported, or a camera rig configured to render cubemaps, you will learn how to sample it in a material.

The main point of cubemaps is that they are sampled with a 3d direction vector that points to a position on the cube. The vector does not need to be normalized.

![](/img/lens-studio/cubemap-guide-7.png)

In the diagram above, the blue arrow represents the UVW coordinate vector that is sampling into a cubemap. The red square represents the position on the cubemap face that’s being sampled.

In order to sample the cubemap in a material, you will need to create an Empty Material. In this material, create the following nodes:

* Texture Cube Object Parameter
  <!-- -->
  * You should give it a memorable Script Name, for example "cubemapTexture" in order to find the name easier.
* Texture Cube Sample
* Surface Position
  <!-- -->
  * The space needs to be set to Object

Once all nodes are created, you will need to wire up the nodes as shown in the image below:

![](/img/lens-studio/cubemap-guide-8.png)

Next, You will assign a cubemap texture to the input. This can be one that you imported from a horizontal or vertical cross image, or from the Cubemap Camera custom component by assigning the material to a Cubemap Receiver array input and supplying the Script Name you used for the Texture Cube Object Parameter ("cubemapTexture" in the above example).

Once you have assigned the input, you can now assign the material to a sphere or a cube.

[](/img/lens-studio/cubemap-guide-9.webm)

This will sample the cubemap from the object space positions of the mesh that the material was assigned to. This technique is a common way of creating environment domes and skyboxes.

If you notice seams along cube faces, try setting the wrap mode for the cubemap texture parameter to Clamp to Edge for both U and V.
