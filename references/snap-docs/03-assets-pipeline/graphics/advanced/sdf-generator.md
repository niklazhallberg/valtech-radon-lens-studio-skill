# Signed Distance Field Generator

Signed Distance Fields(SDFs), are a powerful data format that stores distance values in a 3D texture. These distance values are a measurement of how far away a sampled position is from a surface. Lens Studio allows you to generate an SDF 3D texture from your own meshes. This opens the door to advanced techniques that were not possible before, such as fast and accurate collisions and volumetric effects. Let’s dive in!

## Creating an SDF Texture[​**](#creating-an-sdf-texture "Copy to clipboard")

To create an SDF texture, [import a 3D](/lens-studio/assets-pipeline/3d/importing-content/overview.md) model into Lens Studio.

It’s important that your mesh is 3D (two dimensional planes won’t work) and is a continuous surface without intersecting or non-manifold geometry.

For this example, we will use the `Trophy` found on the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md):

![](/assets/images/sdf-generator_sdfg_01-9c848d4559fe6c645afc2f1d6d65ea6c.png)

In the `Asset Browser` panel, click the **`+`** button, navigate to the `Texture` tab, and select `3D Texture` > `Signed Distance Field`. You can also type `signed distance field` or `SDF` into the search bar to quickly filter the selection.

[](/img/lens-studio/sdf-generator_sdfg_02_211019_210607.webm)

This opens the `SDF Generator` window. To add your mesh, click on the Mesh input and navigate to your mesh resource.

[](/img/lens-studio/sdf-generator_sdfg_03_211019_210609.webm)

Click `Bake` to start the generation process.

Note that, depending on the complexity of your model and the settings chosen in the `SDF Generator` window, the baking process can take a long time to compute. This is ok.

When the generation process is completed, a new SDF resource appears in your `Asset Browser` panel. When you click on the texture in the `Asset Browser` panel, it should look something like this on the `Inspector` panel:

![](/assets/images/sdf-generator_sdfg_04-ab4e8a0449b136617f2f675e0ab96f9e.png)

Congratulations, you just created an SDF texture!

## SDF Generator Parameters[​**](#sdf-generator-parameters "Copy to clipboard")

![](/assets/images/sdf-generator_sdfg_05-6935cf6c837a8665d27405bb2f0abbb3.png)

|                                |                                                                                                                                                                                                                                                   |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Mesh**                       | The mesh to generate an SDF texture from.                                                                                                                                                                                                         |
| **Format**                     | Byte - UNorm stores distance data as an 8-bit value and will result in the smallest file size, but with less precision. Short - UNorm stores the distance data as a 16-bit value and will result in a larger file size, but with more precision.  |
| **Sample Ray Count**           | The number of rays to cast from each voxel to sample the distance to the nearest surface of the mesh. The higher this number is, the more accurate the results will be (at the expense of longer generation time).                                |
| **Bounding Scale**             | Increases the bounds of the texture relative to the bounds of the mesh. A value of 1.0 will perfectly fit the mesh into the texture bounds.                                                                                                       |
| **Max Texture Size**           | When enabled, automatically sets the width, height, and depth of the SDF texture to the maximum allowed size while keeping the dimensions proportional to the mesh’s bounding box. When disabled, this allows for manual setting of texture size. |
| **Texture Width/Height/Depth** | When Max Texture Size is disabled, this sets the resolution of the SDF texture. Width x Height x Depth should not exceed 2048 x 2048 which is the maximum size of 2D images we support.                                                           |

## Usage in Materials and VFX[​**](#usage-in-materials-and-vfx "Copy to clipboard")

`Signed Distance Field` textures are used in materials and VFX assets to create unique and interesting effects. We provide SDF examples on the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md), with more to come in the future:

* **SDF Visualizer Material:** a material for inspecting an SDF texture
* **SDF Slicer:** use an SDF texture to slice a 3d object and draw a cap over the hole
* **SDF Volumetric Glitter VFX:** scattering particles within an SDF volume
* **SDF Collisions VFX:** particle collision with an SDF volume

Use the **SDF Visualizer Material** to inspect the SDF texture that you just created. Open the `Asset Library`, search for `SDF Visualizer`, and import it to your project.

This asset comes with the Trophy SDF described above, but you can add your own by dropping it onto the `SDF Texture` input on the `SDF Visualizer` material.

This material lets you scan through the 3d SDF texture and displays the result on a 2d plane. You can select which axis to scan through. The `Distance Min/Max` parameter remaps the sampled distance value from the given range to 0-1, letting you see more detail.

[](/img/lens-studio/sdf-generator_sdfg_06.webm)

The value returned by a sampled SDF texture is the distance from the sampled position to the surface of the mesh that it was generated from. Since the range of values stored in our textures is 0-1, a value of 0.5 maps to a distance of 0, or directly on the surface. Values less than 0.5 are inside the surface, and values greater than 0.5 are outside the surface.

In Lens Studio, SDF Textures are treated as generic 3D textures. 3D textures are just like 2D textures, except you sample them using 3D coordinates. The texture coordinates are assumed to be in the range of 0-1.

![](/assets/images/sdf-generator_sdfg_07-deee95b7b9c35e6b732c3edfe5e7907b.png)

To get an SDF to relate to an object in 3d space, you must map the sample position relative to the object’s bounding box and 3d transformations. You can find various ways to do this in the `SDF Slicer`, `SDF Volumetric Glitter VFX`, and `SDF Collisions VFX` assets on the Asset Library.
