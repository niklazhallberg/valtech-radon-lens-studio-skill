# Substance Texturing

## Using Substance Painter[​**](#using-substance-painter "Copy to clipboard")

Lens Studio supports high quality physically based rendering (PBR). [Adobe's Substance 3D Painter](https://www.adobe.com/products/substance3d-painter.html) is a tool built for creating PBR textures. The below guide will walk through how to configure Substance Painter for Lens Studio use. This allows you to visualize your model in Substance Painter as it would appear in Lens Studio and Snapchat. And then, how to export your PBR textures to be easily loaded into Lens Studio.

### The Mesh[​**](#the-mesh "Copy to clipboard")

You should import the exact same mesh file into Substance Painter that you will import into Studio. In order for normal maps to look as intended, the tangent space on the mesh must match in both packages.

### New Project, Lens Studio[​**](#new-project-lens-studio "Copy to clipboard")

When creating a new Substance project, use the Lens Studio template.

![](/assets/images/substance-texturing_substance-lens-studio-template-14e94cc562786ea1bd1b954e1729eaad.png)

If you are not starting a new project, but have an existing project:

* Select `Edit -> Project Configuration...` and verify that the `Normal map format` drop down is set correctly to `OpenGL`. Additionally, make sure the `Compute tangent space per fragment` checkbox is checked.

![Normal Map Format](/assets/images/substance-texturing_substance_texturing_edit_normal_map_format-fc5229f3331ee5becd3954604ef77104.png)

* Switch the preview shader to the Lens Studio shader in `Window -> Views -> Shader Settings`.

![](/assets/images/substance-texturing_substance-lens-studio-shader-ae98f4069e827064ebf4c9e898379b1b.png)

If you are importing a normal map texture into Substance, you need to make sure your normal map's `Color space` setting is set to `OpenGL normal` and not `auto`.

![](/assets/images/substance-texturing_pbr_material_edit_normal_color_space-6053b37738f457a0fd13d3f78eb65336.png)

### Export Textures[​**](#export-textures "Copy to clipboard")

To export your textures, go to `File -> Export Textures...`. This will open the `Export` window. Select `Lens Studio` in the `Config` drop down. Finally, select your desired export directory and click the export button.

![Export Textures](/assets/images/substance-texturing_substance_texturing_export-d805f80c360dfcef522b1b28baadf52d.png)

This will export three textures that are ready to be added to Lens Studio.

* One of the textures is your `Base Texture`

* Another is your `Normal Map`

* Finally, the `Material Params Texture` is unique to our engine. It is a single texture that represents Metallic, Roughness and Ambient Occlusion in the red, green and blue color channels respectively.

## Lens Studio PBR Material[​**](#lens-studio-pbr-material "Copy to clipboard")

To use your PBR textures in Lens Studio, first import them to the project by dragging them into your `Asset Browser` panel. Next, create a new PBR material by selecting `+ -> Material -> PBR` in the `Asset Browser` panel.

![](/assets/images/texturing-1-4f54e9e8ecd94f3d55adf84c5c6b05c7.png)

With your new material selected, link all three textures to the appropriate channels in the `Inspector` panel.

![](/assets/images/substance-texturing_trophy_tex-75dbfaedd61c7d851952b52ad8660a4e.jpg)

Now, assign your material to an imported mesh. For more information on importing meshes, follow the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide.

![](/assets/images/texturing-2-e2c4ee4c2b8dde326f12085187d9311f.png)

You now have a high quality PBR material with textures inside Lens Studio!

![](/assets/images/substance-texturing_substance_texturing_final-72bc5ba51734dff813c188c60288667d.png)

### Environment Maps[​**](#environment-maps "Copy to clipboard")

Environment maps enhance the effect of PBR lighting. If you use the same environment map in Substance and in Lens Studio, your rendering should look identical in both packages. Lens Studio uses a particular environment map by default, but you may choose from several built-in environment maps, or import your own.

To import your own environment map, make sure it is an .hdr or .exr image in latitude/longitude (latlong) format. Simply drag the file to the resources tab in Lens Studio. Substance uses the same environment map formats, so you can import the same environment into Substance, and vice versa.

If you would like to use a built-in environment map, you may choose it from `Asset Browser -> + -> Texture`

![](/assets/images/texturing-3-2e087cd580469ec21712df99f0b1af7d.png)

After import, two textures will be generated: a diffuse and a specular environment map. Select the Envmap light source and replace the textures with your newly generated diffuse and specular textures.

![](/assets/images/texturing-4-a39af003c073866abf447af7abdad023.png)

### Debugging High Res to Low Res Normal Map Baking[​**](#debugging-high-res-to-low-res-normal-map-baking "Copy to clipboard")

It is notoriously difficult to bake high res to low res normal maps and have the results match in different software packages. The vertex normals and tangents must match exactly (see notes at the top of this document), but sometimes various packages drop the tangents and calculate their own tangents, or use mikktspace tangents, etc. DirectX normal maps have the green channel inverted versus OpenGL normal maps (Lens Studio expects OpenGL format). The normal map baker even needs to take into account whether the target engine computes tangents in the pixel shader or in the vertex shader (Lens Studio computes them in the pixel shader). Having a mismatch anywhere along the line will cause strange lighting, including seams. We find it useful to validate the full pipeline with a simple test scene.

The simplest test case is to bake a high res cube with hard normals onto a low res cube with soft normals. The low res cube with soft normals lights like a sphere, but once the normal map is baked to it, it will look like a cube again. It should look like a cube in Substance, and once it's imported into Studio, it should still look like a cube with flat sides. If your result looks like a cube in Lens Studio, you can be confident that your workflow is correct. If the sides of the cube look warped, revisit all of the points above to find the source of the mismatch.

![](/assets/images/substance-texturing_LS-normalmaps-2bf155f060515849fea5cd5204732d4c.png)
