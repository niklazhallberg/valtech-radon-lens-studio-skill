# Vertex Animation Textures Guide

The **Vertex Animation Textures** asset, commonly known as VAT, enables you to render simulations from SideFX's Houdini and import them into Lens Studio. This asset is useful for dynamic simulations that would be difficult to animate, such as fluids, or require a lot of data to store and render, such as softbody or rigidbody simulations.

[](/img/lens-studio/vertex-animation-textures-vat_01_all-simulations.webm)

By the end of this guide, you will learn the following:

* How the VAT resource works
* How to export simulations from Houdini into Lens Studio
* How to achieve the best results in Lens Studio.

### Requirements[​**](#requirements "Copy to clipboard")

This guide is an advanced topic that assumes you have an understanding of the following:

* Houdini 18.0
* Particle Simulations and Rendering

You can add a dedicated VAT asset to your project through the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

## How it works[​**](#how-it-works "Copy to clipboard")

The **Vertex Animation Textures** asset uses data stored in one or more textures to animate the vertices of a mesh.

This uses the same underlying technique as [Vertex Animation](/lens-studio/assets-pipeline/3d/animation/vertex-animation.md). However, Vertex Animation uses an FBX and stores data for each vertex using animation keyframes, whereas the **Vertex Animation Textures** asset stores the data in separate textures and animates it using a vertex shader. This can improve both performance and memory costs. The **Vertex Animation Textures** asset also enables you to run simulations with inconsistent topology, such as fluids, and provides additional artistic controls.

First, Houdini processes the simulation and stores it as a mesh and series of textures. Each pixel contains data about the position, rotation, or normals of a vertex during a specific frame in the animation. The types of data stored depend on the type of animation rendered.

[](/img/lens-studio/vertex-animation-textures-vat_02_houdini-to-lens.webm)

Once imported into Lens Studio, the vertex shader in the **Vertex Animation Textures** material processes the texture data and applies it to the vertices in the mesh.

## Exporting a simulation from Houdini using the Labs Vertex Animation Textures (VAT) Node[​**](#exporting-a-simulation-from-houdini-using-the-labs-vertex-animation-textures-vat-node "Copy to clipboard")

Before starting, make sure you can create older versions of the Labs Vertex Animation Texture (VAT) output node. To do this in Houdini:

1. Navigate to: `Houdini FX → Preferences → Shelf Tools and Tab Menu`.

2. Under `TAB Menu and Namespace Filtering`, select `Show All Operators`.

   ![](/assets/images/vertex-animation-textures-vat_03_houdini-show-all-operators-5c0df6e033959139afe7d38a649bfaa6.png)

After you have your simulation ready and older versions of the **Labs Vertex Animation Textures (VAT)** output node available in Houdini, we can export the simulation.

### Exporting the simulation[​**](#exporting-the-simulation "Copy to clipboard")

1. Create a **Labs Vertex Animation Textures (VAT)** node in the `Out` network. The fastest way to do this is to type "VAT" in the tab menu.

Make sure the **Labs Vertex Animation Textures (VAT)** node correct version by clicking the `Info` icon on the node. The node version should be `Labs Vertex Animation Textures Driver (labs::vertex_animation_textures)`, with no numbers following `vertex_animation_textures`. If you see a version number, delete the node and try a different version from the context menu.

![](/assets/images/vertex-animation-textures-vat_04_correct-node-version-1a58cea87dd7b9122de62b99103e9e9a.png)

2. Change the `Method` parameter to an appropriate type for your simulation: Softbody, Fluid, Rigidbody, or Sprite.

The differences between simulation types are:

* **Softbody** maintains consistent topology throughout the simulation that deforms over time, such as draped or waving cloth.
  <!-- -->
  * Outputs: Mesh, Position Map, and Normal Map.
* **Fluid** changes topology between frames, such as fluid or smoke.
  <!-- -->
  * Outputs: Mesh, Position Map, and Normal Map.
* **Rigidbody** maintains consistent geometry using packed geometry pieces with rigidbody physics, such as glass breaking or concrete fracturing.
  <!-- -->
  * Outputs: Mesh, Position Map, and Rotation Map.
* **Sprite** outputs multiple camera-facing quads, such as particle simulations.
  <!-- -->
  * Outputs: Mesh and Position Map.

3. Set the `Export Node` parameter to the Geometry or SOP path that captures your simulation’s final geometry.
   <!-- -->
   1. Optionally, you can change the `Target Texture Size`, which controls the maximum width of the exported texture maps.

Lens Studio cannot import images larger than 2048x2048 pixels.

4. Change the `Position Map Path` file extension from EXR to PNG.

   [](/img/lens-studio/vertex-animation-textures-vat_05_position-exr-to-png.webm)

5. Ensure `Normalize Data to 0-1` space is checked.

6. For **Softbody** and **Fluid** simulations, set up the Normal Map parameters.

   1. Uncheck `Pack Normal into Alpha`.
   2. Change the `Normal Map Path` file extension from EXR to PNG.

   [](/img/lens-studio/vertex-animation-textures-vat_06_uncheck-pack-normal.webm)

7. For **Rigidbody** simulations, set up the Rotation Map parameters.

   1. Change the `Rotation Map Path` file extension from EXR to PNG.
   2. Right-click on the **Labs Vertex Animation Textures (VAT)** output node and click `Allow Editing of Contents`.
      <!-- -->
      [](/img/lens-studio/vertex-animation-textures-vat_07_allow-editing-of-contents.webm)
   3. Double-click on the **Labs Vertex Animation Textures (VAT)** node to dive into the network. 4. Find the **Rigidbody** group and select the `RENDER_ORIENT` node. 5. On the `RENDER_ORIENT` node’s parameters, go to the `Metadata` tab, and change the `PNG/TGA Premultiplication` parameter to `Unpremultiplied`.

   ![](/assets/images/vertex-animation-textures-vat_08_rigidbody-unpremultiplied-fd21b65454d17dbc179759f3b6d80a31.png)

Alternatively, you can export the **Rigidbody** Rotation Map as an EXR image and convert it to unpremultiplied alpha using the SideFX Image Viewer. To do this:

* Open the Rotation Map EXR file in SideFX Image Viewer.
* Navigate to `File → Save Frame As`.
* Set the Rotation Map's `Format` to `PNG`, `Image is` to `Unpremultiplied`, and enable `Convert to Image Format's Colorspace`.

8. Click `Render`.

9. After the simulation has rendered, note the information under `Data for Realtime Shader`. This data will be used to set up the **Vertex Animation Textures** material in Lens Studio.

   ![](/assets/images/vertex-animation-textures-vat_09_houdini-data-for-realtime-shader-fcaaf140e10220298c5ed50922d19df4.png)

## Importing the Vertex Animation Texture simulation into Lens Studio[​**](#importing-the-vertex-animation-texture-simulation-into-lens-studio "Copy to clipboard")

Now that your simulation has been exported from Houdini, you can import it into Lens Studio.

1. Add the **Vertex Animation Textures** asset to your project through the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

2. Import the mesh and texture map(s) into Lens Studio by clicking `File → Import` and selecting the relevant assets.

3. Click on the imported texture map(s) in the `Asset Browser` panel and change the `Compression Settings → Optimization Type` to `None`.

   [](/img/lens-studio/vertex-animation-textures-vat_10_texture-optimization-off.webm)

4. In the **Object Hierarchy**, adjust the imported mesh’s `Scale` as necessary (typically by a factor of `0.01` to `0.1`).

5. Create a **Vertex Animation Textures** material by modifying or duplicating a **VAT Template material** from the `Asset Browser` panel. Alternatively, you can copy and paste the `Vertex Animation Texture` subgraph and associated parameters into another material, and connect the `Position` and `Normal` outputs to the `Position` and `Normal` ports on the `Shader 3D` node.

6. On your **Vertex Animation Textures** material, adjust the following material parameters:

   * Change `Mesh Type` to match your simulation type.
   * Assign the Position Map texture to the `Position Map` parameter.
   * Assign any other relevant maps (such as Rotation or Normal maps).
   * Enter the values for `Number of Frames` and `BBOX Max/Min` from Houdini's `Data for Realtime Shader` output.
   * For **Rigidbody** simulations, enter `BBOX Max1/Min1` from Houdini's `Data for Realtime Shader` output.
   * Optionally, you can adjust any other `Vertex Animation Textures` material parameters as you see fit. Example optional parameters include `Interpolation`, `Speed`, and `Sprite Scale`.

7. Fine-tune your **Vertex Animation Textures** material as needed to achieve the result you are looking for.

   [](/img/lens-studio/vertex-animation-textures-vat_11_final-sim-in-lens.webm)

## Parameters[​**](#parameters "Copy to clipboard")

Some parameters within the **Vertex Animation Textures** subgraph only affect specific simulation types. The subgraph hides irrelevant parameters by default.

### Inputs[​**](#inputs "Copy to clipboard")

#### Mesh Type[​**](#mesh-type "Copy to clipboard")

The type of simulation being rendered. This should match the export parameter used in Houdini. The four mesh types are:

* **Softbody** maintains consistent topology throughout the simulation that deforms over time, such as draped or waving cloth.
* **Fluid** changes topology between frames, such as fluid or smoke.
* **Rigidbody** maintains consistent geometry using packed geometry pieces with rigidbody physics, such as glass breaking or concrete fracturing.
* **Sprite** outputs multiple camera-facing quads, such as particle simulations.

#### Position Map[​**](#position-map "Copy to clipboard")

A PNG file that contains the Position Map created by Houdini. Position is used by all 4 simulation types.

#### Normal Map[​**](#normal-map "Copy to clipboard")

***(Softbody and Fluid only)*** a PNG file that contains the Normal Map created by Houdini.

#### Rotation Map[​**](#rotation-map "Copy to clipboard")

***(Rigidbody only)*** a PNG file that contains the Rotation Map created by Houdini.

#### Interpolate[​**](#interpolate "Copy to clipboard")

***(Softbody and Rigidbody only)*** When enabled, creates a smoother animation by linearly interpolating data between frames. You can also use interpolation to optimize your projects by using less data from Houdini. See the Tips section for more information.

#### Interpolation Rate[​**](#interpolation-rate "Copy to clipboard")

***(Rigidbody only)*** Useful for reducing jitter in Rigidbody animations. A value of 1 creates linear interpolation between every frame, 2 between every 2 frames, 3 between every 3 frames, and 4 between every 4 frames. Though higher `Interpolation Rate` values create smoother animations, they may cause your animation to look less lively.

[](/img/lens-studio/vertex-animation-textures-vat_12_interpolation-comparison.webm)

#### Speed[​**](#speed "Copy to clipboard")

The playback speed of the animation. The default speed of `1.0` plays the animation at normal playback speed.

By default, Houdini animations play at 24 FPS, while Lenses play at 30 FPS. To get more consistent results between software, you can change Houdini’s FPS to 30.

#### Number of Frames[​**](#number-of-frames "Copy to clipboard")

The total number of frames in the simulation. Houdini’s **Labs Vertex Animation Texture (VAT)** output node provides `Number of Frames` under `Data for Realtime Shader` after rendering a simulation.

#### BBOX Max/Min[​**](#bbox-maxmin "Copy to clipboard")

The bounding box for the animation. Houdini’s **Labs Vertex Animation Texture (VAT)** output node provides `BBOX Max/Min` under `Data for Realtime Shader` after rendering a simulation.

#### BBOX Max1/Min1[​**](#bbox-max1min1 "Copy to clipboard")

***(Rigidbody only)*** The secondary bounding box for the animation. Houdini’s **Labs Vertex Animation Texture (VAT)** output node provides `BBOX Max1/Min1` under `Data for Realtime Shader` after rendering a Rigidbody simulation.

#### Sprite Scale[​**](#sprite-scale "Copy to clipboard")

***(Sprite only)*** the size of the quads used for Sprite simulations. This enables you to scale the entire simulation and the size of the Sprites independently.

#### Manual Playback[​**](#manual-playback "Copy to clipboard")

Toggle used to play the animation at a specific frame. This is useful for controlling animations via script and debugging.

#### Frame[​**](#frame "Copy to clipboard")

The frame shown while `Manual Playback` is enabled.

### Outputs[​**](#outputs "Copy to clipboard")

#### Position[​**](#position "Copy to clipboard")

The final worldspace Position of each vertex. This should be connected to the `World Position` port of the `Shader 3D` node in your material. If you want to perform additional vertex animations (such as adjusting position based on noise), these operations should be done after the **Vertex Animation Texture** subgraph.

#### Normal[​**](#normal "Copy to clipboard")

The final worldspace Normal of each vertex. This should be connected to the `World Normal` port of the `Shader 3D` node in your material.

#### Current Texture Coordinate[​**](#current-texture-coordinate "Copy to clipboard")

The UV coordinate used to calculate vertex animation data from a texture. This can be used to read additional texture maps, such as Color Maps, exported by the Houdini’s **Labs Vertex Animation Texture (VAT)** output node. It can also help control additional effects on a per-vertex or per-frame basis. Each UV coordinate corresponds to a specific vertex (U) at a specific frame (V).

[](/img/lens-studio/vertex-animation-textures-vat_13_color-by-vertex-time.webm)

The “Color by Vertex” simulation (left) uses the U coordinate to control a gradient, which assigns a different color to each vertex particle in the simulation. The U coordinate is the normalized 0-1 value of the index of a vertex (vertex ID / total vertices). It can be used in similar ways to [Particle Index Ratio](/lens-studio/references/vfx-editor/nodes/particles/node_main_particle_force.md) in the VFX graph.

The “Color by Time” simulation (right) uses the V coordinate to control the color over the animation’s time. The V coordinate is a normalized 0-1 value indicating the current place within the animation (current animation frame / `Number of Frames`).

The **Labs’s Vertex Animation Texture (VAT)** output node stores frames from top to bottom (1 to 0 on the V axis). By default, this means that the V coordinate uses a value of 1 for the start of the animation and 0 for the end of the animation. In Lens Studio, you can use a One-Minus node in your material to make V go from 0 to 1 instead. The Sprite example within the **Vertex Animation Textures** asset shows this method.

## Tips[​**](#tips "Copy to clipboard")

While **Vertex Animation Textures** are generally a great way to render complex animations, they can still take up a lot of space relative to the 8MB limit of Lenses. Here are a few ways to help optimize your projects:

* **Reduce the number of vertices of the original simulation within Houdini.** This can include reducing the original number of points on the geometry for Softbody and Rigidbody simulations, using dynamic remeshing with multiple iterations on Fluid simulations, reducing the detail of Rigidbody fracturing, and reducing the number of particles per frame for Sprite simulations.

* ***(Rigidbody and Softbody only)*** **Use** `Interpolate` **to calculate data between frames.** Within Houdini, you can increase the timescale of the simulation by 2 to output every other frame of the original animation. Note that you may need to increase the number of substeps when increasing the timescale. Then, within Lens Studio, use the `Interpolate` toggle on your material to compute the middle frames. You may need to change the `Speed` of your animation by half to correct the timing. This can effectively halve the amount of data needed to render the simulation while maintaining visual quality.

* ***(Softbody and Fluid only)*** **Use Screen Space Normals instead of Normal Maps.** Normal maps often have a large memory footprint in Fluid and Softbody simulations. Using **Screen Space Normals** instead of the Normal Map texture allows you to reduce the total size of your Lens. However, this can also sometimes reduce visual quality. See the [Screen Space Normals Generation guide](/lens-studio/features/graphics/advanced/screen-space-normals-generation.md) as well as the Fluid Screen Space Normals example in the **Vertex Animation Textures** asset to see implementation of this technique.

  [](/img/lens-studio/vertex-animation-textures-vat_14_normal-map-vs-ssn.webm)

You can also use **Screen Space Normals** on Rigidbody and Sprite simulation. However, Rigidbody and Sprite simulations calculate their normals during VAT processing instead of using a Normal Map, so this may not grant any additional performance benefits.

## Troubleshooting[​**](#troubleshooting "Copy to clipboard")

Here are solutions to a few common issues that might occur while working with the **Vertex Animation Textures** asset:

* **The simulation looks chunky, spiky, or glitchy**: Double check that the texture map’s `Compression Settings → Optimization` is set to `None`.

  * Lens Studio may ask you if you want to optimize your project on load, which can also cause this effect on your textures even if they previously had optimization off. Make sure you carefully read dialogue pop ups when they appear so as to not accidentally compress resources.

    [](/img/lens-studio/vertex-animation-textures-vat_15_fix-chunky-mesh.webm)

  * You can also disable compression on import in Lens Studio by going to `Preferences` and un-checking `Auto Compress Textures`.

    ![](/assets/images/vertex-animation-textures-vat_16_disable-import-optimization-d0b92c0e49cdbfa2fbc48ee8d5c16fc4.png)

* **The simulation disappeared or drastically changed after making a change in the Material Editor**: Check that your material’s parameters are all set to the correct values for your simulation. Sometimes changing settings within a parameter or renaming it will cause the parameter to revert to its default value. This can cause unexpected behavior in the animation such as moving, disappearing, or stopping.

* **The simulation’s normals or UVs look incorrect**: Make sure that your normals or UVs have been explicitly created within Houdini before exporting.

* **Houdini will not exit the Compositing stage after clicking** `Render`: When you click Render, the button will turn blue as it is rendering, then return to gray once rendering has finished. You can safely click `Interrupt` on the **Interrupt** pop-up once `Render` has returned to gray. You can also click `Render` a second time, and the **Interrupt** pop up will not appear as long as you have made no changes to the simulation.

  [](/img/lens-studio/vertex-animation-textures-vat_17_interrupt-composite.webm)
