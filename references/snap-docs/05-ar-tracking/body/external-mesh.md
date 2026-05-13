# External Body Mesh

External Body Mesh is an extension of the [body mesh](/lens-studio/features/ar-tracking/body/body-mesh-overview.md) feature that allows you to fit meshes, such as clothes, onto the tracked user body. External meshes deform and move without any rigging and also automatically conform to tracked bodies. Adding an external mesh is an easy approach to fit any mesh approximating a human body to the base mesh.

[](/img/lens-studio/external-mesh_guide_hero_small.webm)

You can add the entire External Body Mesh setup which will be tracked to the body by going to the `Scene Hierarchy > +` and selecting `Full Body Mesh`.

## Adding an External Mesh[​**](#adding-an-external-mesh "Copy to clipboard")

Please refer to [this guide](/lens-studio/features/ar-tracking/body/preparing-external-mesh.md) to create or alter a 3D model that can be used as external mesh. Once you have prepared a 3D model you can proceed with importing it into the Lens Studio to use as an external mesh.

To import an external mesh, select a `Full Body Mesh` resource in the `Asset Browser` panel. If you haven't already created a `Full Body Mesh` - you can create one by pressing the `+` button in the top left of the `Asset Browser` panel.

Then, In the `Inspector` panel, select the field next to `External Mesh`. Drag the imported mesh you wish to deform to the body into this field.

[](/img/lens-studio/external-mesh_guide_import.webm)

### Fields[​**](#fields "Copy to clipboard")

![](/assets/images/external-mesh_mesh_subparts-72fb567846be1846b37f27a60b2bd927.png)

* **Body Index:** The tracked body index for which this body mesh will deform to match the pose and size.
* **Part submeshes:** Selectively enable or disable submeshes for the Body, Left Hand, Right Hand and Head.

Try disabling the hands for garments with long sleeves to prevent hands from affecting the external mesh.

* **Mesh Pose:** Specifies the pose that will be used when aligning an external mesh to the refrence mesh. This should be the same as the rest pose of your external mesh.
* **External Mesh:** Specifies the mesh that the Body Mesh should be deformed too.

When an External Mesh is provided, the following additional settings will be available:

* **Matching mode:** Specifies the algorithm used to calculate how the external mesh vertices deform relative to the reference Body Mesh.
* **Proximity Matching Mode** matches your external mesh to the base mesh based on the distance between the vertices of each.
* **Max Distance:** Controls the maximum distance under which a body mesh vertex can match to an external mesh vertex.
* **Max Count:** Controls the maximum number of vertices on the base mesh that can match to an external mesh vertex.

When using proximity matching on looser garments try higher values of max distance. Also for looser garments you can try higher values of max count to make the deformations to your external mesh more smooth along the base body mesh.

![](/assets/images/external-mesh_transform-b48b232a8398d7b6cc7c8310bdc01059.png)

* **Transform**: Offset, rotate and scale the external mesh to align it with the base mesh before matching.

Make sure to export your model with a transform such that the position and rotation are uniformly 0 and the scale is uniformly 1.  Alternatively, you can adjust the transform with the Transform attribute.

* **UV Matching Mode** uses the selected UV channel to map your external mesh onto the body mesh. This setup is very similar to the setup of UVs for using an [External Face Mesh](/lens-studio/features/ar-tracking/face/face-mesh.md) except we now create UVs for the entire body, not just the face.

### Usage[​**](#usage "Copy to clipboard")

Once you've imported and configured your external mesh it will be processed and should appear in the viewport. If your external mesh requires a material you can apply the material to the `Render Mesh Visual` you created in the `Scene Hierachy` panel for the `Full Body Mesh` asset.

[](/img/lens-studio/external-mesh_guide_material_add.webm)

You’ll notice that a new blendshape was added to your `Render Mesh Visual` called `ExternalMesh`. You can use this to morph between the base mesh and your external mesh.

![](/assets/images/external-mesh_blendshapes-c11192e14637103e050397386d97d911.png)

If the model seems to be missing some details, make sure that Blend Normals option is turned on on the Render Mesh Visual.

It’s possible to set up multiple body meshes with multiple external meshes and have them run at the same time. For example, you could have separate meshes for pants and a shirt. Simply duplicate the Full Body Mesh resource and set up the object tracking for it the same as you did for the first one.

## Next Steps[​**](#next-steps "Copy to clipboard")

Take a look at the [Clothing Try-On](/lens-studio/features/try-on/clothing-try-on.md) for examples on how to use this functionality.
