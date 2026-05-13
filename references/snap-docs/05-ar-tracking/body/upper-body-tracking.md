# Upper Body Tracking

When developing Lenses for the front camera, developers often need to use 3D body tracking for tasks like neck movements, attachments, and collisions. While [Face Mesh](/lens-studio/features/ar-tracking/face/face-mesh.md), [Body Mesh](/lens-studio/features/ar-tracking/body/body-mesh-overview.md), and full [3D Body Tracking](/lens-studio/features/ar-tracking/body/object-tracking-3d.md#3d-body-tracking) can address these needs, 3D Body Tracking is typically more suited for tracking a person who is fully in frame. To optimize for selfie use cases, a lighter version has been introduced - Upper Body Tracking 3D.

![](/assets/images/upper-body-mesh-4-2ac1f9adffe3b2fd242832ba9b427121.png)

## Upper Body Tracking 3D[​**](#upper-body-tracking-3d "Copy to clipboard")

**Upper Body Tracking 3D** asset provides a subset of humanoid attachment points, such as the hips, spine bones, neck, head, shoulders, and upper arms. Other than this you may add to scene and use [Object Tracking 3D](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) component as usual.

![](/assets/images/upper-body-mesh-2-73c33cdfe3fe7a6dedf7a5a780aa4596.png)

## Upper Body Mesh[​**](#upper-body-mesh "Copy to clipboard")

This feature also introduces a specialized version of [Body Mesh](/lens-studio/features/ar-tracking/body/body-mesh-overview.md) called Upper Body Mesh.

![](/assets/images/upper-body-mesh-1-017c49b76ba7a68d009ce66611a46fc1.png)

When you add the Upper Body Mesh in the Scene Hierarchy panel, several scene objects are automatically added to your scene. These include:

* **Head Component**
  * with a **Head Mesh** attached to it (which is a Face Mesh with the skull enabled).
* **3D Object Tracking** configured with **Upper Body Tracking** asset
  <!-- -->
  * And **Upper Body Mesh** attached to it.

![](/assets/images/upper-body-mesh-3-b391aa01895b0f5b9d56a349f30199c2.png)

This creates a full, seamless-looking mesh of a person’s upper body, ideal for developing selfie (front camera) lenses. It can be used in various cases, such as an occluder for different body accessories or a collider for physics, and it allows for seamless texturing of the face and neck.

Please note that Upper Body Mesh doesn’t support external mesh.

### Changing Face / Body index[​**](#changing-face--body-index "Copy to clipboard")

To change the body index of a combination of the Upper Body Mesh and Head, follow these steps:

1. Set the `Face Index` on the `Head Mesh` asset.
2. Set the `Face Index` on the `Upper Body` Mesh asset.
3. Set the `Face Index` on the `Head Binding` component.

### Texturing Upper Body Mesh and Face Mesh[​**](#texturing-upper-body-mesh-and-face-mesh "Copy to clipboard")

You can find a reference model and UV map layout [here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/5-0/Upper%20Body%20Reference.zip). Use any 2D or 3D editor of your choice to create textures for the model.

![](/assets/images/upper-body-mesh-0-e9c3790a9d1b904e425f3b0860382ae6.png)

Once your textures are ready, follow these steps to apply them to the **Upper Body Mesh**:

1. Import the exported texture files into Lens Studio.
2. Create a new material that allows you to adjust the mesh UV index. For example, use a new Uber PBR material and name it **Body Material**.
3. Configure the material by setting the input parameters with the imported textures.
4. Select the **Upper Body Mesh** scene object and assign **Body Material** to the render mesh visual component attached to it.

To apply textures to the **Head Mesh**:

1. Duplicate **Body Material** and rename it to Head Material.
2. Select **Head Material** and change texture UV to `Mesh UV 1` for all texture inputs.
3. Assign **Head Material** to the **Head Mesh**.

[](/img/lens-studio/upper-body-mesh-5.webm)

You need a separate material because We need to use a second UV channel for the Face mesh.

Try combining Upper Body Mesh with skin segmentation map applied to the camera to create tattoo effects.

## Quick Links[​**](#quick-links "Copy to clipboard")

[Upper Body Reference Model](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/5-0/Upper%20Body%20Reference.zip)
