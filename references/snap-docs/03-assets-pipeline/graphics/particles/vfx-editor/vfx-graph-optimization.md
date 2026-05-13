# VFX Graph Optimization

## Introduction[​**](#introduction "Copy to clipboard")

This documentation provides information to help you tackle performance issues while working with VFX Graph.

## VFX Optimizations[​**](#vfx-optimizations "Copy to clipboard")

For this section we are going to talk about things you could look into within and around your VFX graph that could be improved.

* **Particle Count:** Always start less. If you have a massive amount of particles, your lens could run slow on devices, even in Lens Studio. One common pitfall is to increase the particle count to compensate for very small, transparent, or otherwise hard to see particles. Make sure you are seeing all the particles you expect to see before cranking up the particle count (for example, temporarily turning off blending can help visualize things).

* **Reduce overdraw:** Overdrawn pixels means drawing the same pixels multiple times in the same frame. As mentioned above, users should avoid overlapping particles as much as possible for better performance. Imagine a stack of cards on top of each other, although you can’t see that one card on the bottom of the stack, the system still needs to draw it, which is unnecessary, so our goal here is to reduce unneeded particles.

To check overdraw particles, you could set the Output Quad Blend Mode to Add, and set particle pixel color to (0.1, 0.1, 0.1, 1.0). As you can see below, there is a blown out area in the middle of the screen, the brighter the area indicates more overlapping is happening, which is not ideal. Smaller hotspots may be ok, large ones will hurt performance.

[](/img/lens-studio/vfx-graph-optimization_vfxgog02.webm)

You may also place a black background behind the effect to make the overdraw view more exact. To change the background of the preview panel, click on the dropdown and select `+ From Files`.<br /><!-- --> ![](/assets/images/vfx-graph-optimization_vfxgog01-8cddd4b4136b2d3179a92d972ffb470c.png)

Below is a screenshot demonstrating a better scenario and what you should aim for to achieve better VFX performance.<br />![](/assets/images/vfx-graph-optimization_vfxgog03-87bb8bea8bbb9daac07a8fba25f5d9f7.png)

* **Particle ( Kill ):** Try to kill unnecessary particles. Utilizing `Particle ( Kill )` to remove particles that are too close to the camera could help you to reduce the amount of overdraw. Note that `Discard` does not kill particles, but it can still help when used in `Output`>`Set Pixel Color`.

* **Check your textures:** It could be costly using a high resolution texture such as 512x512 or above, if you use a high resolution texture on particles that are tiny and will never get too close to the camera, it means you are using a texture with too many details that no one will ever see on a phone screen. Try to reduce textures to 256x256 or even lower like 128x128. Your goal is to have the size of the texture almost the same as the size of particles on screen. Mipmaps should be enabled to mitigate this, unless you are sure your textures are never minified.

* **Avoid Custom Attributes:** When it’s possible to calculate something directly (ex: based on elapsed time rather than delta time). `Custom Attributes` need space allocated in the simulation buffers, and read and written several times per frame, so they can be more costly than evaluating some simple math.

* **Avoid excessive use of Particle Random:** Avoid using `Particle Random` or `Random` in `Output Quad`>`Set Pixel Color`. This will cause `rand()` to be called for every pixel for every particle. Instead, start by reusing an existing attribute, for example setting a random color on spawn, then using `Particle (Get Attribute)`>`Color`. If your particles are spawning chaotically, `Particle (Get Attribute)`>`IndexRatio` is also a good option to mimic randomness.

### Batching[​**](#batching "Copy to clipboard")

In Lens Studio 5.0, multiple instances of the same VFX Asset in the scene will automatically be batched into a single draw call. This improves performance and makes VFX graphs easier to work with since you no longer need to clone an asset to get unique world space simulation behaviors.

Since batching improves performance, it can be useful to try and combine similar VFX into a single asset. For example, if you have two systems that just need different colors, you can use `Particle (Get Attribute)`>`Copy ID` to treat batched copies differently from one another.

![](/assets/images/vfx-copy-id-2565bf4d1de618d0b523bc5092355377.png)

Batching is limited to 32 copies of any one VFX Asset. If you need to add more, you will have to clone the asset.

## Besides VFX[​**](#besides-vfx "Copy to clipboard")

Something else could also living in your project affecting the performance but not VFX related, let’s take a look:

* **Textures:** Once again, check the resolution of all the textures being used in your project, and reconsider whether you can resize them to be smaller. In Lens Studio no texture should exceed 2048 x 2048 resolution.
* **Meshes:** We encourage users to keep models in an average budget of 10,000 triangles for best performance on most of the devices. Lens Studio will not allow you to import a model that has more than 65,535 vertices. Each object you add to your project has an impact on performance. If you need to push beyond this, you'll see a significant lag on the performance.
* **Script:** When writing scripts, try to tie logic to events rather than Frame Update. Only use the script update event if you're unable to get the desired functionality from the other events available.
* **Blend Modes:** Blending is relatively more expensive operation than opaque or alpha tested rendering because it introduces GPU synchronization with previously rendered fragments into framebuffers, double check any blend modes being used or any Blend node within either Material or VFX Graph. Using “Disabled” Blend Mode can also improve overdraw issues.
