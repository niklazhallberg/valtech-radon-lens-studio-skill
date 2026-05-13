# Body Mesh

The Body Mesh feature allows you to apply effects to the body that automatically fits the Snapchatter. The assets comes with both an example of applying textures to a [Body Mesh](/lens-studio/features/ar-tracking/body/body-mesh-overview.md), as well as using the body mesh as placeholders to drive effects, such as tapping to instantiate on parts of the body.

[](/img/lens-studio/body-mesh_bodymesh-fullbody.webm)

## Guide[​**](#guide "Copy to clipboard")

This is the documentation page for the `Body Mesh` assets in Lens Studio. In this guide we’ll cover:

* **[Body Mesh Spacesuit](#BodyMeshSpacesuit)** - Using the Body Mesh UV and 3D Objects as references
* **[Body Mesh Tap To Add](#BodyMeshTapToAdd)**- Tapping on the body to append objects to it
* **[Objects On Body Mesh](#ObjectsOnBodyMesh)** - Instantiate one object all across the Body Mesh

Let’s get started!

Find the `Body Mesh Spacesuit`, `Body Mesh Tap To Add` and `Objects On Body Mesh` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library. Once you import the asset from Asset Library, you can find the package in the Asset Browser. Follow the instructions and drag the prefab with `PUT_UNDER_MAIN_CAMERA` tag into Scene Hierarchy under `Camera Object` to create a new Scene Object. You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/img/lens-studio/5-features/body-mesh-import-packages.png)

See how you can simply attach things to the Body Mesh, as well as Download the Body Mesh 3D Model and UV reference in the [Body Mesh Guide](/lens-studio/features/ar-tracking/body/body-mesh-overview.md)!

### Body Mesh Spacesuit[​**](#BodyMeshSpacesuit "Copy to clipboard")

The Body Mesh Spacesuit comes with examples of 2 `Body Mesh` components in the scene. Each of them have a 3D belt object attached to the waist. Feel free to check it out and see how you can attach 3D objects to the body with the `PinToMesh` component.

![](/img/lens-studio/5-features/body-mesh-pin-to-mesh.png)

### Body Mesh Tap To Add[​**](#BodyMeshTapToAdd "Copy to clipboard")

[](/img/lens-studio/5-features/body-mesh-tap-to-add-preview.webm)

The `Tap To Add` asset uses the `TapToAdd` script to let users add random objects from an array to the body mesh when they tap the mesh.

The `TapToAdd` script takes the `uvSampler` render target as a texture input, and gets the pixel color of the render target texture from `UVSampler` based on screen tapped position. The pixel color is determined by the material `renderUV` applied to the `Body Mesh_GENERATE_UV` object.

To see what the `uvSampler` render target looks like, we can quickly create a screen image with the `uvSampler` as a texture.

![](/img/lens-studio/5-features/body-mesh-uv-sampler.png)

In addition, we can see in the `renderUV` material, the color is determined in a way that uv x position determines the red channel and y position determines the green channel of main color of the material.

![](/assets/images/body-mesh_bodymesh_tap_graph-24f5e561e166de9db643799ea10a2d2d.jpg)

Inside the `uvSampler` script, once it gets the pixel color of tapped position, it can then use this color to determine the UV position of the body, and use that with the `PinToMesh` component to attach objects to the body when tapped.

![](/img/lens-studio/5-features/body-mesh-pin-asset.png)

Right click to highlight the flower prefabs and you’ll see each of them have a `PinToMesh` component. The script will set their target to the `TargetMesh` variable (in this case it is the Body Mesh object) and set the pinned position to converted UV position on tap.

Try replacing [prefabs](/lens-studio/lens-studio-workflow/prefabs.md) in the `PinAsset` array to create your own items to be generated when body is tapped!

### Objects On Body Mesh[​**](#ObjectsOnBodyMesh "Copy to clipboard")

[](/img/lens-studio/body-mesh_bodymesh-instantiate.webm)

The Objects On Body Mesh asset allows you to spawn instances of objects along the body based on predetermined UV positions with `PinToMesh`.

Everything under the `InstanceObj_EDIT_ME` object will be duplicated along the body. Try toggling different objects inside this object or add your own!

![](/img/lens-studio/5-features/body-mesh-toggle-objects.png)

The `InstantiateObjectsOnMesh` script uses Reference Points under the `ReferencePoints` object to generate positions on the `Body Mesh`. It is categorized into front, back and inner (places in-between legs and arms and body) points.

![](/assets/images/body-mesh-reference-points-a21cdbd412b0917d9b9667b1476a8aa8.png)

Feel free to toggle the `MirrorPoints`, `AddInlinePoints` and `AddBackPoints` variables to see how it changes the scene!

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
