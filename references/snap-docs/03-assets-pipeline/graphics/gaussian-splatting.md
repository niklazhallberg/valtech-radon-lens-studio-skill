# Gaussian Splatting

Gaussian splatting, introduced in the 2023 paper [“3D Gaussian Splatting for Real-Time Radiance Field Rendering”](https://repo-sam.inria.fr/fungraph/3d-gaussian-splatting/), is a modern approach for modeling and rendering 3D scenes. It stands out from Radiance Field methods like NeRFs for its quick setup (training) and faster rendering times, while maintaining or improving visual quality, and being easier to understand and modify.

The data is a cloud of “Splats”, generated automatically from a set of photos from different angles.

## Importing Gaussian Splatting[​**](#importing-gaussian-splatting "Copy to clipboard")

In the `Asset Browser` panel, click on `+`, then `Import Asset`. Next select, the gaussian splatting `.ply` file you want to import.

[](/img/lens-studio/general-5/gaussian-splatting-2.webm)

You can drag a `.ply` file directly into the scene hierarchy to import the asset and create a new visual.

You can see the number of splats, and size that the compressed Gaussian Splatting asset file takes up inside the Lens, in the `Inspector` panel when your asset is selected.

![](data:image/png;base64,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)

PlayCanvas provides a powerful 3D Gaussian Splat editor called [SuperSplat](https://playcanvas.com/supersplat/editor). Additionaly, they provide a guide to [authoring PLY files](https://developer.playcanvas.com/user-manual/graphics/gaussian-splatting/).

## Gaussian Splatting Component[​**](#gaussian-splatting-component "Copy to clipboard")

[This component](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built_In.GaussianSplattingVisual.html) allows you to display the Gaussian splatting itself. Add it to any scene object to see your splats in your scene.

![](/assets/images/gaussian-splatting-7-8c08a3279d4e625b978eec0ee56569be.png)

This is similar to how you would use the `Render Mesh Visual` component to display 3D meshes.

## Gaussian Splatting Material[​**](#gaussian-splatting-material "Copy to clipboard")

![](/assets/images/gaussian-splatting-3-8ece74ca0faea6fe4c9418131ab5e7cf.png) ![](/assets/images/gaussian-splatting-12-2eea282cca945ad31133289f54386cfd.png)

Optionally, you can override the default Gaussian Splatting material with a custom one, to create special effects.

1. Create a new material + shader graph and in the `Asset Browser` panel.
2. In the shader graph, set the `Shader` node to `Gaussian Splatting` mode.
3. Use the material in the `Gaussian Splatting` component.

In Gaussian Splatting mode, there are two new inputs that can be overridden. They are applied in the Vertex shader stage.

1. `Splat Center`: change the location of the splat
2. `GSplat Point Size`: specify the size of the splat, in pixels.

## Examples for custom Gaussian Splatting materials[​**](#examples-for-custom-gaussian-splatting-materials "Copy to clipboard")

### Colorize[​**](#colorize "Copy to clipboard")

[](/img/lens-studio/general-5/gaussian-splatting-5.webm)

![](/assets/images/gaussian-splatting-6-cb62d05d247773238d035d23c51382cd.png)

### Discard by world position[​**](#discard-by-world-position "Copy to clipboard")

[](/img/lens-studio/general-5/gaussian-splatting-8.webm)

![](/assets/images/gaussian-splatting-11-0d510c8fb04a25d44c33842803567c66.png)

### Point Cloud[​**](#point-cloud "Copy to clipboard")

[](/img/lens-studio/general-5/gaussian-splatting-13.webm)

![](/assets/images/gaussian-splatting-9-6fb4740b189ac5261c46bcb99da3ef6d.png)

### Wavy Fruit[​**](#wavy-fruit "Copy to clipboard")

[](/img/lens-studio/general-5/gaussian-splatting-4.webm)

![](/assets/images/gaussian-splatting-1-cbfcec43d76b9d02c610f61e923952df.png)

## GSAF - Gaussian Splatting Animation Frames[​**](#gsaf---gaussian-splatting-animation-frames "Copy to clipboard")

GSAF is a feature of Lens studio that allows the user to import a series of .ply files as frames of a single animated GS asset, effectively creating a volumetric video.

### Importing into Lens studio (Creating the asset)[​**](#importing-into-lens-studio-creating-the-asset "Copy to clipboard")

1. In the `Asset Browser` panel, click on `+` then `Gaussian Splatting from .ply files`.

2. Select the .ply files to use as frames.

3. There are 4 sliders for compression / quality trade-off, one for each attribute, with a range from 4 to 16 bit. Higher settings for these attributes will yield better visual quality at a cost of the GSAF file size and import time. The default configuration is recomended for most use-cases.

4. The import process should take a few seconds, depending on the .ply files’ size, quantity and the attributes settings.

5. Once importing and compression is done, you can inspect the newly added [GSAF asset](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built_In.GaussianSplattingAsset.html). It displays the number of splats and size that the compressed Gaussian Splatting asset file takes up inside the Lens. You will notice a new field which will indicate the total number of frames for this GSAF file as well.

   ![](/assets/images/GSAF_image3-5ab8b999620409f1feaf27d2517b4dfd.png)

### Placing the GSAF visual into the scene (Creating the visual)[​**](#placing-the-gsaf-visual-into-the-scene-creating-the-visual "Copy to clipboard")

1. Placing the newly created GSAF is done by using the same [Gaussian splatting component](https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built_In.GaussianSplattingVisual.html) for a single ply file - just drag the asset into the scene hierarchy.

2. When a GS visual component has a GSAF asset attached, a few additional fields appear: **Active Frame** to indicate the current active frame number for this Gaussian splatting animation file as seen on the image below. **Auto Play** check to automatically load the visual in play mode **FPS** Animation speed in Frames Per Second

   ![](/assets/images/gsaf-visual-7af73f79a8d185463b2c67510d505127.png)
