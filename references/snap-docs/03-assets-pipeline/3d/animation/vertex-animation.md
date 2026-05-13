# Vertex Animation

Vertex animation or PLA (Point Level Animation) allows you to animate the individual vertices of an object. Vertex animation can be useful for creating complex or simulated animations. For example, it can be used to create a flag waving animation using cloth simulation.

Some things to consider when using Vertex Animation:

* Complex vertex animation can cause performance issues on lower end devices. Please pay close attention to your Lens frame rate
* Because vertex animation is storing keyframes for each vertex, vertex animations have a heavy file size. Please pay close attention to your Lens size-on-disk

[](/img/lens-studio/vertex-animation_vertex_animation_main.webm)

The guides below have exports guides for the following 3D tools:

* [Maya Export Guide](#maya-export)
* [Cinema 4D Export Guide](#cinema-export)
* [3ds Max Export Guide](#3ds-export)

And a guide for importing Vertex Animation into Lens Studio:

* [Vertex Animation Import Guide](#vertex-import)

## Maya Export Guide[​**](#maya-export "Copy to clipboard")

To export from Maya, first we need to define a set of objects that we want to export as vertex animation. In order to create a set in Maya, select the objects that have a geometry cache, then select `Create -> Sets -> Quick Select Set…` from Maya’s menu bar.

![](/assets/images/vertex-animation_vertex_animation_maya_create_set-1eca92e51ea26f10e31275129fa337f7.png)

This will open the `Create Quick Select Set` window. In this window you can set the name for your objects set. Then, click the `OK` button.

![](/assets/images/vertex-animation_vertex_animation_maya_set-277a661d27c813349f505feec2e6143d.png)

Now we are ready to export the Vertex Animation. Select the object(s) you wish to export in Maya’s `Outliner` window. Then, Select the `File -> Export Selection...` from Maya’s menu bar.

This will open the `Export Selection` option window.

![](/assets/images/vertex-animation_vertex_animation_maya_export-0a3defda3e201136c1ce1fece7415515.png)

In the `Export Selections` option window, expand `Animation` options. Then check the `Animation` checkbox.

![](/assets/images/vertex-animation_vertex_animation_maya_animation-5581b06add579d4093e03e24ce28bab3.png)

Then expand the `Geometry Cache File(s)` option and check the `Geometry Cache File(s)` checkbox.

![](/assets/images/vertex-animation_vertex_animation_maya_geometry-7c16ddb9d5f5bdf7ed02c621032cbd44.png)

Now we need to select the `Set` that we created before in the `Set` drop down menu.

[](/img/lens-studio/vertex-animation_vertex_animation_maya_cache_select.webm)

You should now be ready to export. Give your file a name then select the `Export Selection` button.

![](/assets/images/vertex-animation_vertex_animation_maya_finder-9d61c2fee30be79b86b47e42f6a9c021.png)

To learn more about Maya's export process, refer to the [Maya, 3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/maya-3d-object-export.md) guide.

You now have an exported `FBX` file with a folder in the same path that contains data for Vertex Animation.

## Cinema 4D Export Guide[​**](#cinema-export "Copy to clipboard")

To export your own 3D object `PLA` animation we need to make sure that the animation is cached as keyframes and is not using Cinema 4D's `deformers` or `effects`. Next, select the `File -> Export… -> FBX (*.fbx)` from Cinema 4D’s menu bar. Select where you want to save your FBX and click `Save`.

![](/assets/images/vertex-animation_vertex_animation_c4d_export-cdeb50bf27c17450cc1f059ea751b45e.png)

This will open the `FBX Export Settings` window. In the `FBX Export Settings`, inside the `Animation` section, make sure `Tracks` and `PLA to Vertex Cache` are checked.

![](/assets/images/vertex-animation_vertex_animation_c4d_export_window-f0137fb83d79c79bfbc069f2fc34c39e.png)

To learn more about Cinema 4D’s export process, refer to the [Cinema 4D, 3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/cinema-4d-3d-object-export.md) guide.

Finally, in the `FBX Export Settings` window, click the `OK` button.

![](/assets/images/vertex-animation_vertex_animation_c4d_finder-75e0dc366aebcd50764650fa1ef62a16.png)

You now have an exported FBX file with a folder in the same path that contains data for Vertex Animation.

## 3ds Max Export Guide[​**](#3ds-export "Copy to clipboard")

To export from 3ds Max, first we need to create a set of object(s) that we want to export as vertex animation. To create a set in 3ds Max, select the object(s), then click `Create Selection Set` from 3ds Max’s menu bar and give the set a name.

![](/assets/images/vertex-animation_vertex_animation_3ds_click_sets-ffd07c3ae0892fae7a5eb1c41d44102b.png)

Now we have a set called `SphereSelectionSet`.

![](/assets/images/vertex-animation_vertex_animation_3ds_created_sets-4c0089a2ab543c373a78c266bea96c09.png)

We are now ready to export the `Vertex Animation`. Click on the `3ds Max icon` in the top left corner and then select `Export`.

![](/assets/images/vertex-animation_vertex_animation_3ds_export-ed989a9a196e02f30cbcce5bff60cff3.png)

Select a path where you want to save your `FBX` file and then in the `Save as type` drop down menu, select `Autodesk(*.FBX)`. Then, click the `Save` button.

![](/assets/images/vertex-animation_vertex_animation_3ds_path-cc33a9f7ae8ee64dbef9267de3075b3b.png)

This will open the `FBX Export` window.

![](/assets/images/vertex-animation_vertex_animation_3ds_exportwindow-11dac1a8783a3b01910202d48839e0df.png)

In the `FBX Export` window, click the small triangle to the left of `Animation` to show the animation options and check the `Animation` checkbox.

![](/assets/images/vertex-animation_vertex_animation_3ds_created_animationcheck-271f2f9d52092102bf5aa93d0bd80d5a.png)

Then click on the small triangle to the left of `Point Cache File(s)` to show the options and then, check the `Point Cache File(s)` checkbox.

![](/assets/images/vertex-animation_vertex_animation_3ds_pointcache_checked-b387d52e54823daa8b87a7cd4ff69577.png)

Now we need to select the set that we created before in the `Set` drop down menu.

![](/assets/images/vertex-animation_vertex_animation_3ds_select_set-2bdd6abac9c08179c2e716525f38b2ef.png)

You should now be ready to export. Click on `OK` button to export.

To learn more about 3ds Max’s export process, refer to the [3ds Max, 3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/3ds-max-3d-object-export.md) guide.

You now have an exported FBX file with a folder in the same path that contains data for Vertex Animation.

## Vertex Animation Import Guide[​**](#vertex-import "Copy to clipboard")

To import your Vertex Animation make sure you have both a `FBX` and also a folder with the `XML` and `MC (MCX for Maya)` inside. This folder should be stored at the same level as your `FBX`. Then, drag and drop your `FBX` file into the Lens Studio `Scene Hierarchy` panel. This will open the `FBX Import Options` window. The `Import Vertex Animation` should be checked by default.

[](/img/lens-studio/vertex-animation_import-vertex-animation-2.webm)

Once the `FBX` is imported into Lens Studio, you should see it listed in your `Scene Hierarchy` panel as a new object added to the scene.

In order to check if your object(s) has a Vertex Animation, select the object. Then, in the `Inspector` panel make sure there is a `Vertex Animation` component.

![](/assets/images/vertex-animation_vertex-animation-993e72b2097d757b736aa565f986e672.jpg)

To learn how to play the animation please visit the [Playing 3D Animation](/lens-studio/features/animation/animation-player.md) guide.

[](/img/lens-studio/vertex-animation_vertex_animation-main.webm)
