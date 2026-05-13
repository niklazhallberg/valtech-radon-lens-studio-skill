# Face Mesh

The Face Mesh resource provides a 3D mesh that will mimic the user’s facial expression in real time. It can be used anywhere a mesh may be used. For example, you can use the Head Binding component and the Face Mesh resource to add a 3D face mask on the user. Take a look at the [Face Mesh Template](/lens-studio/features/ar-tracking/face/face-templates/face-mesh.md) for examples on how to use Face Mesh.

## Adding a Face Mesh[​**](#adding-a-face-mesh "Copy to clipboard")

You can automatically add a Face Mesh to a user's head by clicking `+ > Face Mesh` in the `Scene Hierarchy` panel.

![](/assets/images/face-mesh-add-e8ec13a4081cafcdbf75c7269a634e1c.png)

![](/assets/images/face-mesh-demo-5b39a54a4a31a74db3a8cb18d8c56fde.png)

Alternatively, you can add the resource alone by pressing `+ > Face Mesh` in the `Asset Browser` panel.

![](/assets/images/face-mesh-asset-922646371d0161a9e7211b7f9506972a.png)

You can then use this resource in the `Mesh` field of a `Render Mesh Visual` to display it in your Lens.

![](/assets/images/face-mesh-manual-0ee70de5328f761cbc86e3dc30572a8c.png)

## Face Mesh Customization[​**](#face-mesh-customization "Copy to clipboard")

To change the setting of the Face Mesh, select the Face Mesh resource in the `Asset Browser` panel, and adjust its settings in the `Inspector` panel.

You can set which Face in the camera drives the Face Mesh by setting the `Face Index` field. The first face detected by the camera has a face Index of `0`, and the second face has an index of `1`, and so forth.

You can also specify which part of the Face Mesh should be rendered by enabling or disabling the `Face Geometry`, `Eye Geometry`, `Mouth Geometry`, `Skull Geometry` or `Ear Geometry` checkboxes.

[](/img/lens-studio/5-essential/face-mesh-toggle-options.webm)

When using the Skull or Ear options, make sure to use the UV1 option for the textures in your material, as the UV0 option is used for the Face Mesh without the whole skull.

Some ways of doing this:

* You can use the built in Uber PBR material (`Asset Browser -> Uber PBR`) which allows you to set the UV coordinate a texture is using in the material's setting.

  ![](/assets/images/face-mesh-uberpbr-21c7f80f782a8d2c6d7915c35143ccb6.png)

* You can modify a graph material to use a diferrent `Surface UV Coord` node.

  ![](/assets/images/face-mesh-uv1-3d7ac52414898ef25bad5ad71c44a212.png)

* You can modify a graph material's texture parameter to use a different `UV Coords Mode`.

  ![](/assets/images/face-mesh-uv1-2-e85ace1dc4530f1cfe9f4180a78120e6.png)

You can also add `Face Mesh` with the `Skull` option directly by adding `Head Mesh`:

![](/assets/images/face-mesh-add-head-4a52604ddbe9318a132e8802fae249a1.png)

## External Face Mesh[​**](#external-face-mesh "Copy to clipboard")

[](/img/lens-studio/face-mesh_face-morph-guide-1.webm)

In addition to the built in face mesh, you can also provide your own custom mesh for the users face to map to through External Face Mesh.

Through External Face Mesh, you are able to:

* Transition between the built-in face mesh and the custom face mesh
* Add additional Blend Shapes to modify the shape of the face mesh.

[](/img/lens-studio/face-mesh_face-morph-guide-4.webm)

In order for your custom mesh to map correctly to the user’s face, make sure to use the same UV map as the built in Face Mesh. You can download both the UV maps, as well as the 3D model below

To add your own custom mesh, first import your mesh into Lens Studio by dragging your file into the `Asset Browser` panel. Then, select the Face Mesh resource in the `Asset Browser` panel, and in the `Inspector` panel, select the field next to `External Face Mesh`. In the pop-up, choose your newly imported mesh.

[](/img/lens-studio/face-mesh_face-morph-guide-3.webm)

Once imported you will have additional options:

* **External Scale:** scales the custom mesh
* **Expression Multiplier:** how much the user’s expression will affect the mesh
* **Mapping UV:** the UV map to use to map the mesh to Face Mesh

Look for `Face Reprojection` in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) to see examples of this. See the [Face Morph](/lens-studio/features/ar-tracking/face/face-templates/face-morph.md) to learn more about those examples.

You can generate these morphs using GenAI Assistant. Learn more in the [Head Morph in Lens Studio](/lens-studio/features/genai-suite/head-morph-generation.md) guide!.

## Hiding Parts of the Face Mesh[​**](#hiding-parts-of-the-face-mesh "Copy to clipboard")

In some cases you may want to hide parts of the Face Mesh. You can do this by using an `Opacity Mask` on a PBR material and use that material for the Face Mesh, similar to how you would on other meshes.

To create a PBR material, in the `Asset Browser` panel, press `+ > Uber PBR`.

![](/assets/images/face-mesh-add-uberpbr-d259a8cffc9d5ac4a65e309c9e210cbd.png)

Then select your Face Mesh object in the `Scene Hierarchy` panel, and in the `Inspector` panel, set the material of the Render Mesh Visual component, to be the new material.

![](/assets/images/face-mesh-set-uberpbr-9ba5b54d3a4646e71dcf32c424119da6.png)

Then, in the `Asset Browser` panel, select the PBR material, and set its `Blend Mode` to `Normal` so the material can have transparency. Next, enable the `Opacity Texture` checkbox and a `Texture` field will be enabled.

You can set this `Texture` field to your own texture. The texture should correspond to the Face Mesh UV, which you can find in the next section.

![](/assets/images/face-mesh-setup-uberpbr-19702a05eb2ee96b6308129f3a11f18b.png)

For example, if we use this mask:

![](data:image/png;base64,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)

The final Face Mesh will look like:

![](/assets/images/face-mesh_face-mesh-a10-fda94275b6aae75e6555a2c3b2d6ae27.png)

[Download example Face Mesh Opacity Textures](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/jbanbO_WIj2p3i_2_3_0/files/face-mesh-opacity-example.zip)

## Download the Face Mesh UV[​**](#download-the-face-mesh-uv "Copy to clipboard")

![](/assets/images/face-mesh_face-mesh-a11-e6ce06bf1c4d605dc1c9ab7b55ad6ea6.png)

The Face Mesh UV file provides a reference on how 2D textures are applied to the Face Mesh. These textures can be used to modify how your Face Mesh appears. For example, you can use it to create an opacity mask texture to hide parts of the Face Mesh from appearing in your Lens as in the previous section, or create a normal map texture to add additional details to the Face Mesh. Take a look at the [Materials guide](/lens-studio/features/graphics/materials/overview.md) for more information on how different textures can be used to create a material in Lens Studio.

[Download Face Mesh UV Reference](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/jbanbO_WIj2p3i_2_3_0/img/face-mesh-a11.png)

When the Skull or Ear property is enabled, you will need to use the UV1 set as these properties contains additional polygons.

![](/assets/images/face-mesh_FaceMeshSkullUV-9c49ba7cb8577b997d3a2a70aabc2b60.png)

## Download the Face Mesh 3D model[​**](#download-the-face-mesh-3d-model "Copy to clipboard")

![](/assets/images/face-mesh_face_mesh_3d_image-e9a232f7b2dfc98731c1d16e34d039ce.png)

You can also download a 3D model of the Face Mesh to view your content in other 3D software. For example, you can use it as a reference to paint on in software such as Substance Painter. Take a look at the [Substance Painter texturing guide](/lens-studio/assets-pipeline/3d/texturing/substance-texturing.md) for more information on how to create textures to use on a material in Lens Studio.

[Download Face Mesh 3D Model](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/jbanbO_WIj2p3i_2_3_0/files/Face-Mesh.obj.zip)

[Download Face Mesh with Skull 3D Model](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/Aafd4e_3_3/SkullAndFace.zip)

[Download Face Mesh with Skull 3D Model and Ears](/assets/files/faceSkullEarsUvs-9b66e9161191a6f65fe4cb1b77dd9e21.obj)

At this time it’s not possible to replace Face Mesh object in the Lens Studio with other face mesh 3D models outside of the Lens Studio.
