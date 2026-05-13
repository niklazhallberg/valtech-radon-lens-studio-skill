# VFX vs GPU Particles

Previous versions of Lens Studio only had [GPU Particles](/lens-studio/features/graphics/particles/gpu-particles/overview.md) to make visual effects. GPU Particles are still a great choice to make visual effects, but it has many limitations and differences with VFX Editor.

* VFX Editor is a node-based tool for designing your own custom particle system. It offers maximum control over particle behavior and rendering.

* VFX Editor simulates particles non-deterministically, allowing for much more realistic effects. Crucially, it allows for dynamic user interaction with particles.

* VFX Editor comes with dozens of helper [Sub-Graphs](/lens-studio/features/graphics/particles/vfx-editor/vfx-sub-graph-library.md) to quickly create effects systems.

* GPU Particles have a set of pre-defined controls for manipulating its behavior and how it looks.

* GPU Particles is a deterministic system, meaning that it does not take the previous frame’s data into account when animating. While this is more limiting, it can sometimes be more performant than VFX Editor.

In general, it's a good idea to use VFX Editor for most particle systems, but GPU Particles are still a useful tool for quickly creating simple effects that perform well across many devices.

Here are useful links to get you started on each system:

**VFX Editor**

* [VFX Overview](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md)
* [VFX Graph Optimization](/lens-studio/features/graphics/particles/vfx-editor/vfx-graph-optimization.md)
* [VFX Sub-Graphs](/lens-studio/features/graphics/particles/vfx-editor/vfx-sub-graph-library.md)

**Particle System**

* [Particles Guide](/lens-studio/features/graphics/particles/gpu-particles/overview.md)
* [Particle Template](/lens-studio/features/graphics/particles/gpu-particles/gpu-particles-templates/particles.md)
