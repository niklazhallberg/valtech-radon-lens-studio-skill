# 3D Hand VFX

You can find this sample project in the [homescreen](https://developers.snap.com/lens-studio/lens-studio-workflow/lens-studio-interface/home) of Lens Studio.

The 3D Hand VFX Sample Project uses [3D Hand Tracking](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) and the [VFX](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md) graph to create interactive experiences that are both visually stunning and engaging to play with.

[](/img/lens-studio/3d-hand-vfx_3dhand_vfx_fishswarm.webm)

## Guide[​**](#guide "Copy to clipboard")

This sample project has 3 VFX examples to explore around. Each uses a unique aspect of 3D Hand Tracking and the VFX graph. These examples are perfect for learning more about 3D Hand Tracking and the VFX graph, as well as finding inspiration on how to combine the two.

* [Fish Swarm Example](#fishswarm) - Using left & right hands as repelling & attracting force to influence a swarm of sardines.
* [Bioluminescence](#biolum) - Using acceleration of hands to add color highlight and force to a VFX graph.
* [Flower Shooters](#flowershooter) - Using joint positions to give direction to the VFX graph which creates a 'shooting' effect.

### The Fish Swarm Example[​**](#fishswarm "Copy to clipboard")

[](/img/lens-studio/3d-hand-vfx_3dhand_vfx_fishswarm1.webm)

The Fish Swarm example allows you to influence a fish swarm created in the scene with your left and right hand. Our right hand attracts the fish swarm and left hand repels it. You can explore the `Fish Swarm` graph to see how the sardine swarm effect is made.

Double-click the `Fish Swarm` asset inside the `VFX` folder in the `Asset Browser` panel

![](/assets/images/3d-hand-vfx-1-6f25f488f2918d7be4f74b215ebfae82.png)

In the green comment boxes are parameters modified by external scripts, such as:

* **IsAttracting:** a boolean parameter determining whether an attracting or repelling force is applied to the swarm.
* **isIdle:** a boolean parameter determining whether there is external influence on the fish swarm.
* **InfluencePosition:** position input for influencing the force of the fish swarm.

All these parameters are affected in real time in the scripts attached to the `Fish Swarm` object.

For example, the tracked 3D Hand position is changing the `InfluencePosition` of the VFX graph with the `HandPositiontoVFX` script.

![](/assets/images/3d-hand-vfx-2-b18e7b73b7b34a7110b1f95e848e0e71.png)

This script can be used to assign any joint position to any parameters of a VFX graph, try using it with your own custom VFX graph!

You will find more customizable parameters of the `Fish Swarm VFX` asset in the `Inspector` panel.

![](/img/lens-studio/5-features/3d-hand-vfx-3.png)

Here in this example, we are using the same texture (checked by the`Use Same Texture` checkbox) for both attracting and repelling examples.

Color A to E is a set of gradients that you can apply to the texture when the repel action is happening.

### The Bioluminescence Example[​**](#biolum "Copy to clipboard")

[](/img/lens-studio/3d-hand-vfx_3dhand_vfx_biolum.webm)

The Bioluminescence example mimics bioluminescent creatures in our oceans. It uses `SimplexNoise` as an influence force to create a beautiful boids movement of thousands of small circles.

![](/assets/images/3d-hand-vfx-4-d18debda11e06305d1ed787f5ce3efe9.png)

Similar to the Fish Swarm example, data from external scripts are found inside the green box in the VFX graph. It includes:

* **isIdle:** a boolean parameter determining whether there is external influence on the fish swarm.
* **Velocity:** velocity of hands movement from external script.
* **Position:** position input for the influencing force of the fish swarm. This is applied in the script `HandPositionToVFX` with tracked 3D Hand position.

In this example, we are using the velocity of our hand in `CustomVFX_Bioluminescence` to add velocity influence to the graph. See this script to learn how it works.

Right-click on a script in a `Script` component and choose `Select` to find that script in the `Asset Browser` panel. Then, double-click on the script to open it.

![](/assets/images/3d-hand-vfx-5-7b03a28d4720ef321379b110efc5d8b8.png)

### The Flower Shooter Example[​**](#flowershooter "Copy to clipboard")

[](/img/lens-studio/3d-hand-vfx_3dhand_flowers.webm)

The Flower shooter example shoots out flowers and grass from the index finger.

The `HandPositionToVFX` is used to assign a custom position to the VFX graph.

In both the `Flower Emitter` and `Leaf Emitter` VFX graphs, there are `SpawnPosition` and `DirectionPosition` input parameters. The `HandPositionToVFX` script assigns the index tip’s position to `SpawnPosition` and the index middle’s position to `DirectionPosition` so that the shooters always shoot to where the index finger is pointing. Feel free to change these parameters and see what happens.

![](/assets/images/3d-hand-vfx-6-33df6abb32121d0cba24bfd4db501cc7.png)

The Flower Emitter and Leaf Emitter graphs have similar configurations. Just like the other VFX examples in this template, you can find all external inputs inside the green box on the graph, including the following:

* **SpawnPosition:** position of origin of the VFX.
* **DirectionPosition:** opposite direction of where the VFX is shooting at.
* **PauseSpawn:** if Determines whether or not a particle should spawn or not (this is set to active when hand tracking is lost)
* **Noise Texture:** noise texture to be applied to randomize movement of the VFX.
* **Main Texture:** main texture (flipbook) of the VFX.

![](/assets/images/3d-hand-vfx-7-9ce0e03eb7bd4e63e0ac616b92ab0b1a.png)

Feel free to edit these parameters to further customize this VFX!

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Lens experience in Snapchat! To do so follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
