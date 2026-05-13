# Gemstone Rendering

This guide walks you through gem rendering in Lens Studio. Gem Rendering reproduces the lighting effects that occur in gemstones. The unique ways in which light reflects and refracts gives gems their characteristic faceted patterns, highlights, and depth. Gem Rendering can be used to depict diamonds, emeralds, rubies, and other precious stones.

[](/img/lens-studio/gem-rendering-0.webm)

In Lens Studio, this is achieved with a Custom Component and an accompanying Gem Rendering Material. Snap has also developed a modified version of the Sparkles Post Effect that works perfectly with Gem Rendering to give the asset high definition glints and glimmers.

## Structure[​**](#structure "Copy to clipboard")

The goal was to make Gem Rendering as easy to use as possible, so Snap are offering the Custom Component as a standalone asset, as well as the Gem Rendering Material as a separate asset on the Asset Library. This allows for maximum flexibility when creating complex projects with a lot of different gems.

By default, every new Gem Rendering Custom Component instance will depict a white diamond gem with Ring Light lighting. By itself, the custom component has very limited functionality for changing the look of the gem. For that, you will need to get the Gem Rendering Material which is available as a separate download on the Asset Library as well as in the Gem Rendering template.

Finally, a unique Sparkles post effect designed specifically for use with Gem Rendering gives the finishing touch of glints and glimmers seen in cut gemstones. This custom effect can be found in the Gem Rendering template.

### Meshes[​**](#meshes "Copy to clipboard")

The first thing to consider when rendering your gem is the mesh itself. Nearly all of the optical effects that occur in gemstones are due to the way they are cut– in other words, their shape. We have provided a new Gemstones Pack asset on the Asset Library (shown here) that has several examples of popular gem cuts found in real life.

![](/img/lens-studio/gem-rendering-1.jpg)

There are a few requirements for creating your own meshes for Gem Rendering to work properly:

* Gems need to be their own separate mesh. Jewelry pieces should be broken up into multiple pieces so that the gems are independent from other parts such as metal prongs or chains. Multiple gemstones in the same mesh will not work.
* Convex geometry works best.
* Meshes should not have any holes (aka "watertight").

Beyond those requirements, we have a few recommendations when modeling to ensure high quality visuals and high performing lenses:

* Geometry that is extremely long or thin will not work well (for example, trying to make a gem out of a flagpole or dinner plate).
  <!-- -->
  * Similarly, geometry with appendages will not look good (while also breaking the convex rule).
* Gemstones should be modeled at the origin and their pivot in the geometric center of the object.
* The mesh should be modeled with faceted normals.

![](/img/lens-studio/gem-rendering-2.jpg)

## Custom Component[​**](#custom-component "Copy to clipboard")

The Gem Rendering Custom Component is the main entrypoint for gem rendering. Here is where the material and meshes are assigned, as well as some quality and debugging controls.

![](/img/lens-studio/gem-rendering-3.png)

The Custom Component only works on one unique gem mesh at a time. Using Mesh Array or Instancing, you can render the same mesh multiple times, but you will need a new instance of Gem Rendering for different source meshes or different materials.

* **Gem Material:** The material used for Gem Rendering. This must be a Gem Material that comes with the Custom Component or can be downloaded separately from the Asset Library. For more information, see the [Gem Material](#gem-material) section below.

* **Mesh Assignment:**

  * ***Mesh Visual*** will use the supplied Render Mesh Visual and its assigned mesh, and if nothing is assigned it will look at the current Scene Object for a Render Mesh Visual to use.
  * ***Mesh Visual Array*** is similar to ***Mesh Visual***, but it takes an array of Mesh Visuals and turns them all into gem rendering objects. This is useful for when you have more than one of the same gem in the scene but not enough to warrant instancing.
    <!-- -->
    * Note that only the first Render Mesh Visual’s mesh will be used for all the elements in the array.
  * ***Instancing*** uses GPU instancing to render many gems in one pass (see below).

* **Refraction Resolution:** The resolution of the internal refraction texture. Larger resolutions reduce aliasing at the cost of performance.

* **Faceted Normals:** Forces faceted normals. The quality of this can vary and is best to do on the original mesh before importing.

* **Debug:** Renders a sphere in place of the gem object with the gem’s refraction normals and depth rendered on it, useful for debugging issues with refraction data.

## Instancing[​**](#instancing "Copy to clipboard")

[](/img/lens-studio/gem-rendering-4.webm)

If you need to render a lot of gems, it can be a good idea to use instancing. Instancing efficiently renders many copies of a mesh and its material, but each instance can have its own unique transform (translation, rotation, scale). This method can greatly reduce the number of draw calls, but it comes with a little bit of upfront cost when loading the Lens, and its vertex shader is more costly.

Individual instances can not be moved separately at runtime. Their initial positions are saved when the Lens starts, but after that only the transform hierarchy coming from their parent transforms are updated every frame. Additionally, individual instances can not be enabled or disabled at runtime.

As a rule of thumb, consider switching to instancing if you have more than around `10` of the same gem mesh in your scene.

Instancing comes with a few additional requirements on the modeling side:

* Instances are represented by individual Scene Objects with transform information on them. In Maya these are called Null or Locator objects.
* Every instance Scene Object should be grouped under a single parent Scene Object.

When *Instancing* is selected for **Mesh Assignment** on the Custom Component, some additional parameters are available:

* **Instancing Root:** the Scene Object group that contains children to be converted to instances.
* **Gem Mesh:** the mesh resource that will be used for instanced gem rendering.

## API[​**](#api "Copy to clipboard")

The Gem Rendering Custom Component can be set up and controlled from another script via its script API.

You must use either `setRenderMeshVisual()`, `setRenderMeshVisualArray()`, or `setInstancing()` after creating the custom component via script.

* **getRefractionResolution()** Gets the refraction resolution.
* **getMaterial()** Gets the gem material.
* **getRenderMeshVisual()** Gets the render mesh visual being used for gem rendering.
* **setRefractionResolution(int resolution)** Sets the refraction resolution.
* **setMaterial(Asset.Material material)** Sets the gem material.
* **setRenderMeshVisual(Component.RenderMeshVisual)** Sets the mesh visual.
* **setRenderMeshVisualArray(Component.RenderMeshVisual\[])** Sets the mesh visual array.
* **setInstancing(SceneObject instanceRoot, Asset.RenderMesh mesh)** Sets up instancing for gem rendering.
* **toggleFacetedNormals(bool)** Toggles faceted normals.
* **toggleDebug(bool)** Toggles debugging.

### Gem Material[​**](#gem-material "Copy to clipboard")

![](/img/lens-studio/gem-rendering-5.png)

The gem material is where the look of the gem is defined. Since it is currently not possible to duplicate assets that are bundled with Custom Components, you must do this yourself by either downloading it from the Asset Library, or starting with the Gem Rendering Template which has several gem material examples.

* **Ray Bounces:** The number of ray bounces inside the gem. Higher numbers are more expensive.
* **Correction Steps:** The number of passes to fix inaccuracies in the refraction. Lower numbers are faster at the cost of accuracy. If the refraction doesn’t feel quite right, try increasing this.
* **Index of Refraction:** The index of refraction of the gem. Diamonds have an index of refraction of 2.417
* **Gem Color:** The gem color after light absorption. The absorption parameter needs to be greater than zero for color to be visible.
* **Absorption:** Light absorption factor. More absorption makes the gem darker and more saturated. Visible only when Gem Color is not white.
* **Lighting Type:** offers both **Ring Light** and **Soft Skydome**, both sample a neutral virtual environment dome that’s been designed to look good for many gem types. Environment Light samples the Envmap in the scene. See below for more lighting information and tips.
* **Fill Amount:** Adds value to darker areas, useful for keeping Ray Bounces lower without making the gem too dark.
* **Sparkle Amount:** Controls the sparkle response when used with the gem-specific Sparkles asset (see below). Does not affect the base gem rendering.
* **Background Refraction:** When enabled, sample the background to give the gem a feeling of transparency.
* **Background:** The texture to sample for background refraction.
* **Intensity:** The strength of the refraction.
* **Dispersion:** Adds color separation along refracted edges (chromatic aberration).
* **Chroma Brightness:** The brightness of the chromatic aberration.

### Gem Sparkles[​**](#gem-sparkles "Copy to clipboard")

![](/img/lens-studio/gem-rendering-6.jpg)

The Gem Sparkles asset is similar to the one found on the Asset Library, but it has been modified and optimized to work specifically with gem rendering.

The main difference is that it leverages a form of HDR to put sparkles on values greater than 1.0. The HDR is encoded into the Alpha channel of the render target, so gem sparkles can not be used in the same layer as other materials that write to the alpha channel.

There are a few new features, including:

* **Rotate with Object:** rotates the sparkles when a given Scene Object is rotated
* **Post Filter:** reduces flickering that occurs with very small highlights, but may result in fewer sparkles overall

## Lighting[​**](#lighting "Copy to clipboard")

Just like in real life, lighting plays a big role in how the gem looks. Changing the lighting can have a dramatic effect on the absorption, highlights, and sparkles. Gem Materials can be configured to use three different light types: Ring Light, Soft Skybox, and Environment Light.

![](/img/lens-studio/gem-rendering-7.png)

The first two modes, Right Light and Soft Skybox, draw virtual skyboxes around the gem in world space. These skyboxes are relatively fast to compute and work well at showing off refraction patterns. Ring Light tends to have slightly more contrast than Soft Skybox. Both depend on the angle of the gem, the camera angle, the gem geometry, and its material settings.

Selecting the Environment Light option will sample the first Environment Light in the project. This can produce incredible looking gems that integrate beautifully with the rest of the scene. The highlights tend to be brighter which can lead to more sparkles, so you may need to reduce Sparkle Amount to compensate. It is a little more expensive than the two skybox options.

Try Gem Rendering and Environment Light together with [Dynamic Envmap](/lens-studio/features/graphics/ml-environment-matching.md#dynamic-environment-map). When used on your mobile device, the results can be bring some amazing results.

### Optimization[​**](#optimization "Copy to clipboard")

Gem rendering is relatively efficient for such a complex effect, but it’s always a good idea to optimize your project as much as possible. Here are some tips on ways you can improve the performance of your gem rendering lenses:

* Use the lowest Refraction Resolution, Ray Bounces, and Correction Steps that you can get away with. Tiny gems that don’t take up a lot of space on the screen do not need a large resolution or a lot of ray bounces. Even for big gems, just 5 or 6 bounces is enough to produce a great looking result.
* Experiment with using a lower number of ray bounces while increasing the Fill Amount to compensate for areas that appear too dark. The fewer the bounces, the faster the performance.
* Use instancing if you need to render the same kind of gem more than about 10 times. Some pieces of jewelry have dozens or even hundreds of the same kind of gemstone. You can reduce the number of draw calls dramatically by using Gem Rendering’s instancing feature.
* When using instancing, keep the polycount as low as possible. Instancing can become slow when there are a lot of vertices to process. The total number of vertices can quickly add up when the source geometry has a lot of polygons and there are a lot of instances.
