# World Mesh and Depth Texture

World Mesh provides a real-time 3D reconstruction of the real world based on what your device sees. This allows your experience to better match and respond to the environment that it’s in.

[](/img/lens-studio/world-mesh-and-depth-texture_world-mesh-guide-0.webm)

In 2021, Snap AR released the first version of World Mesh in Lens Studio for all devices. However, the technology was limited in its accuracy and precision. As part of Lens Studio version 4.55, Snap has released World Mesh 2.0; an update that represents a significant improvement in the accuracy, support, and precision of reconstructed meshes. Our novel approach to increasing mesh accuracy flips the script on why non-LiDAR world mesh wasn’t a developer’s first choice. In doing so, we also increased the number of supported phones with access to high-quality, 3D meshing in real time.

World Mesh is a beta feature and is not available on all devices. Its capabilities vary depending on the device it is running on. However, you can start developing today as your Lens will automatically be updated to run on more devices and with the latest World Mesh as it arrives.

## World Mesh Capabilities[​**](#world-mesh-capabilities "Copy to clipboard")

When a device provides a World Mesh, you have access to the following:

* **World Mesh:** An automatically generated mesh that represents the real world in 3D. You can use this to occlude AR effects based on the real world. Use it as you would any other mesh.
* **Hit Test Results:** Using the ray casting or hit test function, you can learn about the mesh that was hit at a certain point, as well as its position, normal. Learn more about this in the API documentation or in the scripting section below.
* **Depth Texture:** You can get a texture representing the depth of the world in the camera view.

When using World Mesh, your Camera object should contain a Device Tracking component with the **World** option such that it can accurately map the generated mesh to the real world.

### Availability[​**](#availability "Copy to clipboard")

World Mesh is available on devices with:

* Devices with LiDAR
* Recent devices with ARKit and ARCore
* Spectacles

However, there are some differences to note:

* On non-LiDAR devices and Spectacles, the World Mesh will change over time as the Lens continues to refine its understanding of the surfaces it sees.
* When LiDAR is available, doing a Hit Test will provide you with semantic information about the surface hit. Types provided are: wall, floor, ceiling, table, seat, window, door and none.

On slower devices, the generation of the World Mesh will be slower. This means that it may take longer for the Lens to receive a mesh. Older devices without support for OpenGL ES 3.0 will also not work.

In general, LiDAR will work better and be more accurate given the dedicated sensor. For example: World Mesh currently works better indoors than outdoors on devices without LiDAR. In addition, Depth Texture data will be more accurate on devices with LiDAR.

<!-- -->

<!-- -->

## World Mesh in Action[​**](#world-mesh-in-action "Copy to clipboard")

The following are some examples of World Mesh in action.

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/world/world-templates/world-mesh.md)

[World Mesh Example](/lens-studio/features/ar-tracking/world/world-templates/world-mesh.md)

[The World Mesh example allows you to instantiate and occlude virtual objects based on real world surfaces through real-time 3D mesh reconstruction of what your device sees. It also comes with an example of designing a fallback for devices which does not yet have World Mesh.](/lens-studio/features/ar-tracking/world/world-templates/world-mesh.md)

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/world/world-templates/simple-world-mesh.md)

[Simple World Mesh](/lens-studio/features/ar-tracking/world/world-templates/simple-world-mesh.md)

[The Simple World Mesh Template showcases different ways you can take advantage of the World Mesh to understand the world around you and add effects that respond to them.](/lens-studio/features/ar-tracking/world/world-templates/simple-world-mesh.md)

[![](/img/lens-studio.svg)](/lens-studio/features/graphics/materials/material-templates/depth-materials)

[Depth Materials](/lens-studio/features/graphics/materials/material-templates/depth-materials)

[World Mesh provides a real-time 3D reconstruction of the real world based on what your device sees. This allows your experience to better match and respond to the environment that it’s in.](/lens-studio/features/graphics/materials/material-templates/depth-materials)

[![](/img/lens-studio.svg)](/lens-studio/features/graphics/materials/material-templates/depth-materials)

[Instant World Hit Test](/lens-studio/features/graphics/materials/material-templates/depth-materials)

[You can use world depth texture to get an instanenous hit test, and then use World Mesh to get a more accurate result when it's available.](/lens-studio/features/graphics/materials/material-templates/depth-materials)

## Using World Mesh and Depth Textures[​**](#using-world-mesh-and-depth-textures "Copy to clipboard")

There are a variety of ways you can integrate geometric understanding of the world into your Lens!

### Adding a World Mesh[​**](#adding-a-world-mesh "Copy to clipboard")

You can add a World Mesh by pressing `+ > World Mesh` in the `Asset Browser` panel

![](/assets/images/world-mesh-and-depth-texture_world-mesh-guide-1-9ac0dea7cc07c6d34acff3a3c5b10b6c.png)

You can treat this mesh as you would with any other mesh. For example, you can display the World Mesh:

![](/assets/images/world-mesh-and-depth-texture_world-mesh-guide-2-1bb51d1cfd83be226616bf88a22064d1.png)

You can quickly display a mesh by adding it from the `Scene Hierarchy` panel > `+ > World Mesh`

Once a World Mesh is added, you can modify its settings via its [API](/api/lens-studio/Classes/Providers.md#worldrenderobjectprovider), or through the World Mesh resource in the `Asset Browser` panel.

![](/assets/images/world-mesh-and-depth-texture_world-mesh-guide-3-37e8d0cc6274ff2f48bc37cc16ac4610.png)

* **Use Normals:** whether surface normal information should be baked into the mesh.
* **Classification** (for devices with LiDAR)**:** whether classification should be baked into the mesh. Note that in Lens Studio classification data will always be provided.

### Adding a Depth Texture[​**](#adding-a-depth-texture "Copy to clipboard")

In some cases, you may only need depth data, rather than a constructed mesh, such as to do a depth of field effect.

You can access the Depth Texture by going into the `Asset Browser` panel > `+ > Depth Texture`

![](data:image/png;base64,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)

You can use this depth texture as an input into the [Material Editor](/lens-studio/features/graphics/materials/material-editor/introduction-and-concepts.md) to create a shader based depth effect.

[](/img/lens-studio/world-mesh-and-depth-texture_world-mesh-guide-5.webm)

Like World Mesh, Depth Texture can come from a variety of sources. For example, you may get depth data from a device with depth sensors in the front camera, through Spectacles' dual cameras, or through AR Core’s depth data. When World Mesh is used, depth data will be provided by World Mesh.

### Scripting and World Mesh[​**](#scripting-and-world-mesh "Copy to clipboard")

With [scripting](/lens-studio/features/scripting/script-overview.md), you can get additional information about the World Mesh so that your Lens can respond to surfaces that it sees.

For example the script below would send a ray from the center of the screen into the world until it hits a mesh. Then, it would print out information about the vertex of the mesh at that location.

```
// @input Component.DeviceTracking tracker
// @input Component.RenderMeshVisual worldMesh
// Screen position we want to do a hit test on
var centerOfScreenPos = new vec2(0.5, 0.5);
// Check if World Mesh is available
if (script.tracker.worldTrackingCapabilities.sceneReconstructionSupported) {
  // Get the world mesh API
  var worldTrackingProvider = script.worldMesh.mesh.control;
  // Set up world mesh to check classification
  // Note: Only available on devices with LiDAR
  worldTrackingProvider.meshClassificationFormat =
    MeshClassificationFormat.PerVertexFast;
  worldTrackingProvider.useNormals = true;
  // Do a hit test
  var hitTestResults = script.tracker.hitTestWorldMesh(centerOfScreenPos);

  hitTestResults.forEach(function (hitTestResult) {
    // Get vertex information
    var position = hitTestResult.position;
    var normal = hitTestResult.normal;

    // Classification possibilities at:
    // /api/classes/TrackedMeshFaceClassification/
    var classification = hitTestResult.classification;
    // Do something with data
    print(
      'Hit mesh at ' +
        position +
        ' with normal of ' +
        normal +
        ' and classification of: ' +
        classification
    );
  });
}
```

Show more▼

Try using this data to modify the position and rotation of an object so that it is always facing up from the surface!

If you are building for Spectacles, consider the `WorldQueryModule` which allows you to raycast to the world without waiting for World Mesh, and reduce performance cost.

### Passing World Mesh Data[​**](#passing-world-mesh-data "Copy to clipboard")

In addition to using the World Mesh itself, you can use the World Mesh as a source of data. For example, you can use it to understand normals and surfaces in the world such that [VFXs](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md) can collide with the real world!

Take a look at the [Simple World Mesh](/lens-studio/features/ar-tracking/world/world-templates/simple-world-mesh.md) template to see various examples of this in action!

[](/img/lens-studio/world-mesh-and-depth-texture_world-mesh-guide-7.webm)
