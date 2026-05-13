# World Depth Texture

**World Depth Texture** in Lens Studio allows you to capture depth for all visible surfaces in the real world. This is useful for creating effects that react to any surface, enabling realistic occlusion and building AR experiences that interact with the user’s environment.

## Getting started with the World Depth Texture[​**](#getting-started-with-the-world-depth-texture "Copy to clipboard")

To use the **World Depth Texture**, add a **World Depth Texture** asset in the `Asset Browser` panel.

![](/assets/images/world-depth-texture-1-d65a7ac3faad3378862053307ede1e22.png)

## Occlude objects using the World Depth Texture[​**](#occlude-objects-using-the-world-depth-texture "Copy to clipboard")

Use the **World Depth Texture** with a virtual scene to get occlusions with the real-world environments.

Select the camera object to which you want to apply the depth occlusions in the `Scene Hierarchy` panel.

![](/assets/images/world-depth-texture-2-9383b1f581a42cbada1756f0886d866d.png)

Set the **Depth Clear Option** to `Custom Texture`. Choose the **World Depth Texture** as the input for the `Custom Texture`.

![](/assets/images/world-depth-texture-3-1ed47aae003e22414a169ce91a1c2514.png)

The calculation for this occlusion will be handled by the camera and the **World Depth Texture**. To see the occlusion in action, add a mesh and place it at a position close to real-world surfaces in your preview.

![](/assets/images/world-depth-texture-4-19ff458fa90d91c9d9a5e3e246e3dd16.png)
