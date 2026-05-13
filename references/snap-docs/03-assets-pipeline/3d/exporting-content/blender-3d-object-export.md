# Blender, 3D Object Export

![Blender](/assets/images/blender-3d-object-export_3d_animation_export_blender_intro-4456dd551db857e22228e20342d9de7d.png)

This guide will walk through how to use Blender to export a 3D model to the FBX format, so that it can be imported into Lens Studio. For the purposes of this guide, we're using [Blender 2.79](https://www.blender.org/). That said, any 3D tool that can export to FBX should be able to export models that can be imported into Lens Studio.

## Export for Lens Studio[​**](#export-for-lens-studio "Copy to clipboard")

In Blender, select the object or objects you want to export.

Select `File -> Export -> FBX (.fbx)`

![Blender | Export FBX](/assets/images/blender-3d-object-export_3d_object_export_blender_file_menu-060b68124a730658cd48fdc7ba845d06.png)

## Export Settings[​**](#export-settings "Copy to clipboard")

In the Blender Export dialog, make sure you have the following settings.

### Main[​**](#main "Copy to clipboard")

![Blender Settings | Main](/assets/images/blender-3d-object-export_3d_object_export_blender_settings_main-978def1efe85db171def956bea3a4724.png)

The default settings in the Main tab should work for your export.

### Geometries[​**](#geometries "Copy to clipboard")

![Blender Settings | Geometries](/assets/images/blender-3d-object-export_3d_object_export_blender_settings_geometries-ba89b362e59702f3878c8d0b80d8ab3a.png)

Select the following settings in the Geometries tab:

* Apply Modifiers
* Use Modifiers Render Setting

### Armatures[​**](#armatures "Copy to clipboard")

![Blender Settings | Armatures](/assets/images/blender-3d-object-export_3d_object_export_blender_settings_armatures-ed63f0f0d28930f109c3606ab53c532b.png)

The default settings in the Armatures tab should work for your export.

### Animation[​**](#animation "Copy to clipboard")

![Blender Settings | Animation](/assets/images/blender-3d-object-export_3d_object_export_blender_settings_animation-c4e41832b17d452054718fac8b863f2f.png)

Select `Baked Animation` in the Animation tab and optionally these two following settings:

* Key All Bones
* Force Start/End Keying

If your scene has multiple animation Actions (known in Lens Studio as Animation Layers), you should check "All Actions" to ensure they imported properly into Lens Studio.

Below is a list of things to ensure when exporting your 3D assets to work best in Lens Studio and ultimately Snapchat.<br /><!-- -->• Your scene total of 3D assets should add up to less than `10,000 triangles (5,000 polys assuming your model is built with quads)`. This will allow your model to display smoothly across the widest variety of Android and iPhone devices<br /><!-- -->• In general, stay under `100 joints` for your animation rig. Additionally, while the engine does support Blend Shape animation, try to avoid using it. If Blend Shapes are required, use sparingly and pay close attention to your frame rate performance<br /><!-- -->• Lens Studio supports up to a `4 bones per vertex` limit. If the influence is greater than 4 then there will be problems in your rigged model when imported into Lens Studio

## Textures[​**](#textures "Copy to clipboard")

To ensure that your model's textures are imported automatically to Lens Studio, it's recommended that you save your textures in the same folder as your exported FBX. For example, if your project is located at the path:

`/Users/user.name/ExportedModels/MyModel.fbx`

You should save your textures in the directory

`/Users/user.name/ExportedModels/`

3D model textures should be square. The width and height of your texture should be a power of 2 (e.g. 128, 256, 512 or 1024). If your model has only one color try to lower the resolution to 8 x 8.

## Scene Settings[​**](#scene-settings "Copy to clipboard")

Lens Studio's target animation frame rate is 30 frames per second. To ensure that the timing of your imported animation plays back correctly in Lens Studio, you should set the frame rate of your Blender scene to 30 frames per second.

You can set the frame rate in Blender under the scene settings in the default view.

![Blender | Frame Rate](/assets/images/blender-3d-object-export_3d_object_export_blender_frame_rate-7e60274e64790394c6bdbdc7b6af7969.png)

## More Information[​**](#more-information "Copy to clipboard")

You now have an exported FBX file that's ready to be imported into Lens Studio. For information on importing 3D models into Lens Studio, review the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide.
