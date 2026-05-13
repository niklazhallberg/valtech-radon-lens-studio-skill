# VFX Crowds

VFX Crowds is an asset that enables you to make dynamic crowds capable of interacting with the user, each other, and the world!

[](/img/lens-studio/vfx-crowds-intro.webm)

This asset can be found on the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) for Lens Studio version 5.7.0+. To use, download the package from the Asset Library and drag the VFX Crowds prefab into your scene.

This guide will cover:

* How the VFX Crowds asset works
* How to customize crowd behavior
* How to create and import your own custom crowd animations

Creating and importing new animations requires access to Houdini and knowledge of Vertex Animation Textures (VAT). For more information, visit the [VAT Guide](/lens-studio/assets-pipeline/3d/animation/vertex-animation-textures-guide.md).

## How It Works[​**](#how-it-works "Copy to clipboard")

VFX Crowds utilizes a number of advanced rendering techniques to create the crowd effect, including offscreen cameras, depth render target, custom VFX attributes, Jump Flood Algorithm (JFA), and physics. The Crowd Simulation Controller script handles the set-up and implementation of these systems for you.

On a high level, the Crowd Simulation Controller sets the size and position of the Crowd Simulation. Then, it creates extra cameras to capture data about the world stored in a series of textures. The script also uses raycasting and physics to process data from Tap events, allowing users to interact with the crowds directly. Finally, the Crowd Simulation Controller sends all this data to the VFX Crowd asset. The VFX Crowd asset uses this data to calculate its position, velocity, and animation state (using VAT) for each member of the crowd independently within the VFX graph.

Using the Live Preview, you can see the set-up of this script in action.

![](/assets/images/vfx-crowds-live-preview-3aea78d059b55cd36326b6cd43e675ea.png)

## Customizing Crowd Behavior[​**](#customizing-crowd-behavior "Copy to clipboard")

Crowds have a number of controls available for you to use. Additionally, those familiar with the VFX Graph and Lens Scripting can customize this asset even further.

### Built-In Controls[​**](#built-in-controls "Copy to clipboard")

* **`Size / Mass`**:

  <!-- -->

  * The final particle size is determined by combining `Size` by `Mass`.

    <!-- -->

    * This allows you to have smaller particles with smaller mass, and larger ones with bigger mass.
    * Enabling `Mass Affects Velocity` will cause smaller particles to have a slower maximum speed, and larger particles a faster max speed.

* **`Movement`**:

  <!-- -->

  * `Velocity` determines how fast particles can move (cm / s).
  * `Turn Speed` is how quickly particles turn from each other to avoid collision (degrees / frame).
  * `Acceleration Rate` controls how quickly particles return to max velocity after slowing down.
  * `Jump Force` gives the crowds a boost when they jump around in the world. Crowds jump up by combining `Jump Force` with the force needed to reach the height in front of them. (Only applied when using `World Interaction = Jump to Height`).

* **`Forces`**:

  <!-- -->

  * `Gravity Scale` determines how strong gravity pulls particles back down to the ground. (Only applied when using `World Interaction = Jump to Height`).
  * `Boundary Force` is the force applied to particles when they reach the edge of the simulation.
  * `Edge Buffer` is an additional distance from the edge of the simulation at which `Boundary Force` will be applied.

* **`Tap Behavior`**

  * `Reaction Type` determines how particles respond to taps in the world.

    <!-- -->

    * `Force (Attract / Repel)` will use the `Horizontal Force` and `Vertical Force` parameters to push or pull the particles within the tap’s `Radius`. Negative forces will attract particles, while positive ones will repel them.
    * `Play Animation (Jump)` will cause all particles within the tap’s `Radius` to play their Jump animation.

**`Tap Behavior`** uses [raycasting](/lens-studio/features/physics/raycast.md) to correctly place the tap in the world. Make sure to put [Physics Colliders](/lens-studio/features/physics/physics-component.md#physics-collider) on all objects you want to be tappable.

* **`Simulation`**

  * `Start Event` controls whether or not particles start automatically (`Start Event = On Start`), or wait for the user to tap the screen (`Start Event = On Tap`).
    <!-- -->
    * `Start Event = On Tap` is useful when using World Mesh and Device Tracking World, as it allows users to build out the world mesh first before starting the particle system.
  * `Simulation Size` is the total width and depth of the particle simulation (cm).
  * By default, the simulation starts wherever the Main Camera is located. You can offset this value by adjusting `Start Position Offset`. Usually a depth of at least half the `Simulation Size` ensures particles are placed in front of the camera when the simulation starts.
  * `Min Height` and `Max Height` controls the total height of the simulation, in worldspace. Usually a range within \[-1000, 1000] is good.

* **`Collision Avoidance`**

  * `Search Distance` is the distance (cm) that particles look in front of them for other nearby particles and changes in world height.
  * If another particle is detected nearby and is less than `Collision Distance` (cm), then particles will begin turning away based on `Turn Speed` to avoid collisions.
  * `Stop Distance` is the distance (cm) at which particles will reach their minimum velocity (usually 0), and focus on turning away to avoid collision.

* **`World`**

  * `Interaction Type` determines how particles move in the world.

    <!-- -->

    * `Jump and Fall` will cause particles search in front of them based on `Search Distance`, and if the next height is higher than `Height Threshold`, they will jump to the next height using a combination `Jump Force` and the force needed to reach the next height.

    * `Stick to Ground` lets particles use depth data to stick to the height of the ground beneath them. If there is no ground, then they will stick to `Min Height`.

    * The `Objects` array contains a list of scene objects that you want the particles to be able to see using the heightmap.

      <!-- -->

      * enabling `Add All Children` will add the main object and all of its children into the array. Note that it uses recursion, so if you have a lot of nested objects, you may want to add objects one by one into the array instead for performance.
      * enabling `Update Every Frame` will check every frame for new objects, which is useful for prototyping. Note that this only runs in Lens Studio.

* **`Animation`**

  * `Randomize Start Frame` will ensure that all particles start with a slightly different frame of their starting animation when loaded.
  * `Playback Speed` is how quickly the animations play, defaulting to 30fps.
  * When particle speed is below the `Animation Jump Threshold`, they will play their `Jump` animation.

Additional controls for appearance and Particle Count can be found on the VFX Asset:

* Number of Particles

  * Change the number of particles by changing the `Particle Count` on the `Emit` block within the VFX graph. For more information about the `Emit` stage, see the [VFX Guide](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md#container-nodes).

  * By default, the VFX Crowds system emits the max number of particles with a very long lifespan.

    ![](/assets/images/vfx-crowds-particle-count-ec694caa5d75c9854b635a4e20900f38.png)

* Appearance

  * Change the color of particles by adjusting the `Color Ramp` `Min` and `Max` values. This will randomize the appearance of each crowd member slightly.

    ![](/assets/images/vfx-crowds-color-settings-97f4f9579bf4244b889e30825b39447d.png)

### Advanced Customization Tips[​**](#advanced-customization-tips "Copy to clipboard")

* World Mesh and World Tracking
  <!-- -->
  * Particles can interact with the real world through the **World Mesh** and **Device Tracking**. Try this for yourself by make sure adding a **Device Tracking** component set to `World` to your main camera. The, enable the `World Mesh` example under the `Worlds [TRY_ALL_CHILDREN]` scene object. Use the **Live Preview** to test particle interaction with the world.

Learn more about World Tracking by visiting the [Device Tracking](/lens-studio/features/ar-tracking/world/tracking-modes.md) page.

[](/img/lens-studio/vfx-crowds-world-interaction.webm)

* Shadows

  <!-- -->

  * Shadows can be enabled with **Directional** and **Spot** lights in the scene. Check out the [Light and Shadows](/lens-studio/features/graphics/light-and-shadow.md) guide for more info.
  * To get accurate shadows you made need to customize the `Frustum Size` and `Position` of your light. You can see an example of this on the `Directional Light [Shadow Caster - Try Me]` scene object.

* Customizing Behavior
  <!-- -->
  * Additional forces and interactivity can be added by editing the VFX Crowds asset in the [VFX Graph](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md).

When adding custom functionality to your VFX, make sure the `Crowd Controller` subgraph is always *last* in the order in the `Update` container. VFX behavior is calculated from left to right, top to bottom, so ensuring all other forces have been applied lets the `Crowd Controller` use these forces while still ensuring Crowds stay within simulation bounds and avoid collisions. You can see an example of this in the `Tap Behavior` section of the graph.

![](/assets/images/vfx-crowds-tap-behavior-graph-1fa40b29a1c378a30cc18ac7d190d47f.png)

### Debugging Resources[​**](#debugging-resources "Copy to clipboard")

The World Mesh and Debug Image materials can be helpful for adjusting your Crowd behavior. These visualizers have also been added to the `Debug -> Data Visualiztion` section of the Crowd Simulation Controller Script. You can change which visualization is being applied by using the drop-down menu associated with each visual.

* `Particle Search Distance`: visualizes the Search and Collision distances used by particles. `Collision Distance` is shown as a red circle, and `Search Distance` is shown as a blue circle.
* `Voronoi`: creates a Voronoi diagram using Particle ID. Particle colors will match the “Debug (Voronoi)” option on Crowd VFX asset.
* `World Height`: shows the world height texture.
* `Particle Data Tex`: shows the Particle Data Texture. This is the location of each particle in the simulation from a top-down view.
  <!-- -->
  * Particles will always try to take up 1-2 pixels of data on the texture, so you may not see it if you have a very large Particle Data Tex size and a small image.
* `JFA Packed Value`: shows the raw JFA value calculated by the JFA script, which is used as a distance field.

## Adding Custom Crowd Animations[​**](#adding-custom-crowd-animations "Copy to clipboard")

You can create your own VFX Crowd characters and animations using Houdini and VAT. To learn more about VAT, check out the [Vertex Animation Textures Guide](/lens-studio/assets-pipeline/3d/animation/vertex-animation-textures-guide.md).

### Quick Start Guide[​**](#quick-start-guide "Copy to clipboard")

1. Export your animation sequences from Houdini using VAT

   <!-- -->

   1. Use the `Deforming Object` shelf tool to convert your animation into a simulation
   2. Export using the `Softbody` settings

2. Import VAT resources (mesh & textures) into Lens Studio

3. Enable `Edit Animation Data` on the Crowd Simulation Controller script.

4. Assign the VAT resources and and update the export info.

5. Adjust the `Frame Data` to match your animations

### Exporting Animations from Houdini[​**](#exporting-animations-from-houdini "Copy to clipboard")

1. Ensure your animations are correctly set up and stored in a single FBX.

   <!-- -->

   1. Keep your animations as short as possible.
   2. Animations should be 30fps, which is the default FPS for Snapchat and Lens Studio.

2. Prepare the mesh for export.

   <!-- -->

   1. VAT exports need to be a single mesh. If you have multiple meshes, you can combine them using a Merge node in Houdini.
   2. Make any additional adjustments, such as reducing the scale or adding extra UV sets.

3. Convert the mesh into a simulation.

   <!-- -->

   1. Select your mesh using the `Deforming Object` shelf tool.
   2. This should create a `Static Object` node which already has the settings `Use Deforming Geometry`, `Re-evaluate SOPS to Interpolate Geometry`, `Use Object Transform` enabled.

4. In the Output menu, export your animation as a `Softbody` Animation.

![](/assets/images/vfx-crowds-static-object-settings-50023db16dc843e01ac2cacb039ed3c4.png)

### Importing Animations into Lens Studio[​**](#importing-animations-into-lens-studio "Copy to clipboard")

1. Import the resources created by Houdini. Make sure the textures are set to `Optimization = None`

2. Enable `Edit Animation Data` on the Crowd Controller Script

3. Assign the information from Houdini to the script: mesh, position map, normal map, `BBOX info`, and `Number of Frames`.

4. Adjust the frames for each animation sequence under `Animation Data -> Frame Data` on the Crowd Simulation Controller script.

5. (Optional) Test your animations.

   <!-- -->

   1. This setting will cause the VFX to only play the selected test sequence.

   2. Additionally, a test mesh will be created so you can get a better view of each animation.

      [](/img/lens-studio/vfx-crowds-test-animation-sequences.webm)

## Tips, Tricks, and Troubleshooting[​**](#tips-tricks-and-troubleshooting "Copy to clipboard")

* Storing additional mesh data:

  <!-- -->

  * `UV0` and `UV2-UV7` will be automatically exported by Houdini.
    <!-- -->
    * `UV1` is used by VAT export, and should not be overridden.
  * Vertex Color can be added using the attributes `Cd_v` and `Alpha_v`.

* Optimization:

  <!-- -->

  * When creating new animations, try to use as low of a vertex count as is possible. More vertices and longer animations results in larger VAT textures, which cannot be compressed. The example Radish model has 2k vertices, which is a good benchmark.
  * Try to reduce the scale of your animation in Houdini before exporting.
    <!-- -->
    * Houdini tends to create large meshes, which can cause precision loss during playback in Lens Studio. Usually a size that results in a `BBOX Max/Min` of \[-100,100] is good.
  * Increasing the size of the `Data Tex Size` and `JFA Width` (`Crowd Controller Script -> Advanced`) settings will increases the amount of pixels drawn and processing passes needed to run JFA, respectively. These things can which can slow performance. Try to use the lowest values possible to achieve your goal.
  * Due to the graphical complexity of the asset, VFX Crowds may not be suitable for low end devices.

* Common issues:

  <!-- -->

  * Particle collision is acting weird:

    <!-- -->

    * using the Debugging tools to view how big each area is.
    * adjust the collision values: particles could be either failing to see other particles in front of them, or checking so far ahead that they are essentially always colliding.
    * increase the `JFA Width` or reduce the `Data Tex Size` settings; it could be that there are not enough passes for JFA to provide accurate data for the particles to calculate collision.

  * Particles seem to jitter as they move in the world, instead of moving smoothly:

    <!-- -->

    * the World Texture size may not be big enough to provide accurate data; try increasing the size using the `Advanced -> World Tex Size` setting.
    * Adjust the `Height Limit` setting to be a little higher: particles could be trying to jump every frame and immediately landing.

  * Particle Size is acting strange (jittering or vanishing):

    <!-- -->

    * your exported mesh could be too big
    * you may need to adjust the precision of the Particle Size attribute in the VFX graph.
