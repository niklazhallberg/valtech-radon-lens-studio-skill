# OBJ, 3D Object Import

Lens Studio supports importing the OBJ file format for 3D models. The OBJ file format supports 3D geometry and texture but does not support animation. Generally speaking, if you're exporting your own models, it's recommended to use the FBX format by following our [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guides.

Please refer to the [Performance and Optimization](/lens-studio/publishing/optimization/overview.md) guide for 3D model performance requirements.

### From the Asset Browser Panel[​**](#from-the-asset-browser-panel "Copy to clipboard")

In the `Asset Browser` panel, select `+ -> Import Asset`.

![](/assets/images/import-asset-3d759cb090c70df0198f9163b679e40e.png)

Find the OBJ file on your computer, and select `Open`.

### Dragging and Dropping[​**](#dragging-and-dropping "Copy to clipboard")

You can drag and drop OBJ files from your computer directly into the `Asset Browser` panel or the `Scene Hierarchy` panel.

If you drag into the `Scene Hierarchy` panel, your OBJ will automatically be added to your scene. If you drag into the `Asset Browser` panel, however, your object will only be added as a resource.

To add your model into the scene, open the new folder created by the OBJ import, and drag the prefab from the `Asset Browser` panel into your scene, or `Scene Hierarchy` panel.

![](/assets/images/obj-model-asset-31198446964c050f05111cfb77b1288e.png)

If your OBJ fails to import, check the `Logger` panel for an import error message.
