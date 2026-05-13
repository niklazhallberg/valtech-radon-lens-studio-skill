# glTF, 3D Object Import

Lens Studio supports importing the glTF file format for 3D models. This guide covers how to import a glTF file into a Lens Studio Project.

Please refer to the [Performance and Optimization Details](/lens-studio/publishing/optimization/performance-optimization-guide.md) guide for 3D model performance requirements, [3D Optimization](/lens-studio/publishing/optimization/3d-meshes.md) gide for further compression help.

### Supported Extensions[​**](#supported-extensions "Copy to clipboard")

In addition to the base specification, Lens Studio also supports a number of extensions:

* KHR\_draco\_mesh\_compression
* KHR\_materials\_clearcoat
* KHR\_materials\_transmission
* KHR\_materials\_sheen
* KHR\_materials\_unlit
* KHR\_texture\_transform

## Import glTF into Lens Studio[​**](#import-gltf-into-lens-studio "Copy to clipboard")

### From the Asset Browser Panel[​**](#from-the-asset-browser-panel "Copy to clipboard")

In the `Asset Browser` panel, select `+ -> Import Asset`.

![](/assets/images/import-asset-3d759cb090c70df0198f9163b679e40e.png)

Find the glTF file on your computer, and select `Open`.

### Dragging and Dropping[​**](#dragging-and-dropping "Copy to clipboard")

You can drag and drop glTF files from your computer directly into the `Asset Browser` panel or the `Scene Hierarchy` panel.

If you drag into the `Scene Hierarchy` panel, your glTF will automatically be added to your scene. If you drag into the `Asset Browser` panel, however, your object will only be added as a resource.

To add your model into the scene, open the new folder created by the gLTF import, and drag the prefab from the `Asset Browser` panel into your scene, or `Scene Hierarchy` panel.

![](/assets/images/3d-model-asset-1f366c336c8f46cc284e1ce7e23c22ea.png)

## Import Options[​**](#import-options "Copy to clipboard")

Once you add a glTF file to your project, you'll be presented with a panel of glTF Import Options. You can customize these options to configure the imported glTF resource.

![](/assets/images/gltf-importer-settings-2e7d6d18fd3af346ca3ee5ad9bca6883.png)

* **Use Legacy Importer:** If enabled, Lens Studio will use a different importer. Try this option if you're having issues with latest importer.
* **With Materials:** If enabled, materials will be included.
* **Animation Curve Optimization:** If enabled, applies a size optimization to the model's animation.
* **Custom animation sampling interval:** The frame rate of the imported animation (defaults to 30 frames per second).
* **Import vertex color:** If enabled, includes vertex color information.
* **Import tangents:** If enabled, includes tangent information.
* **Import morph targets animation:** If enabled, includes morph target animation. For more information on playing back mesh animations, visit the guide on [Playing 3D Animation](/lens-studio/features/animation/animation-player.md).
* **Convert meters to centimeters:** If enabled, converts meters to centimeters to meet glTF specification. The units for linear distances in glTF are meters, whereas in Lens Studio they are centimeters.
* **Regenerate Tangents:** If enabled, tangents information will be regenerated.

Once the glTF is imported into Lens Studio, you should see it listed in your `Scene Hierarchy` panel as a new object added to the scene. It will also appear in your `Scene` panel, where it can be manipulated. Finally, your model resource will now be available in the `Asset Browser` panel as well.

![](/assets/images/3d-model-scene-62e1f60cb5ea0a33e3de96d7dd9a4f7f.png)

If your glTF fails to import, check the `Logger` panel for an import error message.
