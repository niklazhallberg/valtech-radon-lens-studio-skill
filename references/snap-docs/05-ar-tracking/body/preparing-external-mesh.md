# External Body Mesh Creation

This guide explains how to prepare meshes to be used as an [External Mesh](/lens-studio/features/ar-tracking/body/external-mesh.md). Automatic fitting for external meshes to the base mesh happens based on vertex proximity or UV coordinate matching. You can edit your external mesh in any 3D tool (e.g. Blender, Maya, Cinema4D etc) to ensure it will fit correctly. To prepare a mesh for use as an external mesh with proximity matching you simply need to align it with a reference mesh in the reference pose, **no rigging is required**!

You can download the [reference models here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Forum-Helpers/3D_Body_Mesh_and_UV.zip) and import the ones you need into your 3D editor.

Two rest poses are available in the reference model pack and for use as an external mesh (T-pose, and A-pose). Modeling your external mesh to match the A-pose usually results in better deformation since the fitting is configured based on the vertex proximity. In additoin, an A-pose ensures reduced stretching of the clothes under arms and better fitting on the legs.

## Preparing the mesh[​**](#preparing-the-mesh "Copy to clipboard")

Import the reference Model FBX file to the 3D editor of your choice:

![](/assets/images/preparing-external-mesh_blender_pose-6ce55883cdde8cd0682b38a8b8d7e541.png)

Then create a 3D model or alter an existing 3D model to fit and align to the reference model.

![](/assets/images/preparing-external-mesh_prep_blender_a_front-42b669a1ca1f4f0e6e95576b061d1de2.png)

For best results using vertex proximity matching, make sure that the mesh you are fitting to the body aligns well to the reference body meshes. Ideally the mesh should fit around the base mesh and not intersect it at any point. Clothes that have to be worn together should also be modeled so they don’t intersect, For example, a hoodie should fit loosely around a t-shirt. For more precise fittings for items such as gloves, use UV matching.

You can add blendshapes to an external mesh. For example this could be used for opening/closing a jacket or adjusting the length of a sleeve

There are some additional steps to take before exporting an external mesh to Lens Studio to minimize further setup.

If you are using `Proximity Matching` all transforms should be reset on the mesh, so its:

* Position is (0, 0, 0)
* Rotation is (0, 0, 0)
* Scale is (1, 1, 1)

To reset all transforms in **Blender**, press Ctrl + A, then click `All Transforms`**.**

![](/assets/images/preparing-external-mesh_blender_apply_transforms-c6d7ecac2f656afca5f389477c7e61d1.png)

To reset all transforms in **Maya**, select the 3D object, click `Modify`, then click `Freeze Transformations`.

![](/assets/images/preparing-external-mesh_maya_freeze-9c14b73899a36df19bb2e0f39daafe22.png)

To reset the transform in **Cinema4D**. Select your object in the `Scene Hierarchy` panel, then in the `Attribute` panel, select the `Coord.` tab and press the `Freeze All` button.

Before resetting or freezing transforms, it is important to make sure that the **object's pivot is at the same point as the reference body's pivot.** As you can see in the image below, the pivot of the object is at the same position (0,0,0) as the pivot of the reference body.

[](/img/lens-studio/preparing-external-mesh_prep_blender_transform.webm)

## Exporting The Mesh[​**](#exporting-the-mesh "Copy to clipboard")

The best way to bring an external mesh into Lens studio is to export it as an FBX file. See the export settings below and refer to the [full guide on exporting for lens studio](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) for more information.

### Blender[​**](#blender "Copy to clipboard")

With the object you wish to use as an external mesh selected click `File -> Export-> FBX`.

Recommended FBX Settings:

* `Scale:` 1
* `Apply Transform`
* `Forward`: **-** Z forward
* `Up`**:** Y up

![](/assets/images/preparing-external-mesh_blender_export_settings-ec05288d3839a35fa1624f4f198c1f0c.png)

### Maya[​**](#maya "Copy to clipboard")

With the object you wish to use as an external mesh selected click `File -> Export Selection`

Recommended FBX Settings:

![](/assets/images/preparing-external-mesh_maya_export-ffc549b3528c0d87cadb45553889e3a2.png)

### Cinema4D[​**](#cinema4d "Copy to clipboard")

Recommended FBX Settings:

![](/assets/images/preparing-external-mesh_Screen-Shot-2021-09-08-at-4.53.46-PM-507f14086bbf8d9d4d88e01740007cf1.png)
