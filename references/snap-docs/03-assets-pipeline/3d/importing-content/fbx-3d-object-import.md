# FBX, 3D Object Import

Lens Studio supports the import of 3D models in the FBX format. This guide covers how to import an FBX file into a Lens Studio project.

For information on creating a FBX to import, visit the [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guide.

## Adding the FBX Object[​**](#adding-the-fbx-object "Copy to clipboard")

There are three ways to add an FBX resource to your project:

* From the `Asset Browser` panel
* Dragging and Dropping

### From the Asset Browser Panel[​**](#from-the-asset-browser-panel "Copy to clipboard")

In the `Asset Browser` panel, select `+ -> Import Asset`.

![](/assets/images/import-asset-3d759cb090c70df0198f9163b679e40e.png)

Find the FBX file on your computer, and select `Open`.

### Dragging and Dropping[​**](#dragging-and-dropping "Copy to clipboard")

You can drag and drop FBX files from your computer directly into the `Asset Browser` panel or the `Scene Hierarchy` panel.

If you drag into the `Scene Hierarchy` panel, your FBX will automatically be added to your scene. If you drag into the `Asset Browser` panel, however, your object will only be added as a resource.

To add your model into the scene, open the new folder created by the FBX import, and drag the prefab from the `Asset Browser` panel into your scene, or `Scene Hierarchy` panel.

![](/assets/images/3d-model-scene-62e1f60cb5ea0a33e3de96d7dd9a4f7f.png)

## Import Options[​**](#import-options "Copy to clipboard")

Once you add an FBX file to your project, you'll be presented with a panel of FBX Import Options. You can customize these options to configure the imported FBX resource. In most cases, you will not need to change anything.

![](/assets/images/fbx-importer-settings-d3bd928058c831716535c6e055cf3932.png)

* **Use Legacy Importer:** If enabled, Lens Studio will use a different importer. Try this option if you're having issues with latest importer.
* **With Materials:** If enabled, materials will be included.
* **Animation Curve Optimization:** If enabled, applies a size optimization to the model's animation.
* **Custom animation sampling interval:** The frame rate of the imported animation (defaults to 30 frames per second).
* **Import vertex color:** If enabled, includes vertex color information.
* **Import tangents and binormals:** If enabled, includes tangent and binormal information.
* **Regenerates tangents and binormals:** If enabled, Lens Studio will generate new tangent and binormal information.
* **Import blend shape animation:** If enabled, includes blend shape animation. For more information on playing back mesh animations, visit the guide on [Playing 3D Animation](/lens-studio/features/animation/animation-player.md).
* **Import vertex animation:** If enabled, includes vertex animation. For more information on Vertex Animation, visit the [Vertex Animation](/lens-studio/assets-pipeline/3d/animation/vertex-animation.md) guide. For more information on playing back mesh animations, visit the guide on [Playing 3D Animation](/lens-studio/features/animation/animation-player.md).
* **Generate pivots:** If enabled, includes Scene Objects in the hierarchy that recreate the model's transform pivots. Otherwise, all model pivots will be placed at the world origin.
* **Regenerate normals for skinned meshes:** If enabled, the normals of the model's skinned meshes will be recalculated.
* **Triangulate NURBS:** If enabled, nurbs surfaces and curves in this object will be triangulated.
* **Use legacy FBX loader:** If enabled, object will be loaded with an older version of fbx loader.

## Scene Object[​**](#scene-object "Copy to clipboard")

Once the FBX is imported into Lens Studio, you should see it listed in your `Scene Hierarchy` panel as a new object added to the scene.

![](/assets/images/3d-model-scene-only-8c654669f0ed19329a5737609eb9c00c.png)

It will also appear in your `Scene` panel, where it can be manipulated.

![](/assets/images/fbx-3d-object-import_3d-red-panda-scene-bccc81a233688b2bffa03ca0eab85de8.jpg)

## Resources[​**](#resources "Copy to clipboard")

Your model's resources (meshes, textures, materials, and animations) will now be available in the `Asset Browser` panel.

![](/assets/images/3d-model-asset-1f366c336c8f46cc284e1ce7e23c22ea.png)

If your FBX fails to import, check the `Logger` panel for an import error message. For more information, review the [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guide.
