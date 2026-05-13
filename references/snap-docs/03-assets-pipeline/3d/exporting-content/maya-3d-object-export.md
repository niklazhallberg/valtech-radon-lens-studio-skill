# Maya, 3D Object Export

This guide will walk through how to export a 3D model to the FBX format, so that it can be imported into Lens Studio. For the purposes of this guide, we're using [Autodesk's Maya 2016](https://www.autodesk.com/products/maya/overview). That said, any 3D tool that can export to FBX should be able to export models that can be imported into Lens Studio.

## Animation Settings[​**](#animation-settings "Copy to clipboard")

Before exporting to FBX we have to make sure that we are using the correct project settings so we can successfully import the 3D model into Lens Studio. To see the project settings, first select `Windows -> Settings/Preferences -> Preferences` from Maya's menu bar.

![Export Selection](/assets/images/maya-3d-object-export_3d_object_export_pref-581c837e4b5fa1b9a8f896f2de44a17f.png)

This will open the `Preferences` window. In the left side categories, select `Settings`.

Then, under `Working Units` select the `Time` drop down menu and select `NTSC (30 fps)`. This will change the scene's frame rate to 30 FPS.

![Export Selection](/assets/images/maya-3d-object-export_3d_object_export_prefwindow-cbaaf7253a74aeac04fba54f74deb78d.png)

Finally, press the `Save` button.

Now we're ready to export the 3D model.

## Export for Lens Studio[​**](#export-for-lens-studio "Copy to clipboard")

To export a FBX from Maya, first select the object(s) you wish to export in Maya's `Outliner` window. Then, select the square to the right of `File -> Export Selection...` from Maya's menu bar. This will open the `Export Selections` options window.

![Export Selection](/assets/images/maya-3d-object-export_3d_object_export_selection-5de991871778b02bce5940b72e25eb95.png)

In the `Export Selections` options window, expand `General Options`. Then, select `FBX` in the `File type` dropdown.

![FBX Type](data:image/png;base64,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)

Then, in the `Export Selections` options window, click the `Export Selection` button.

![Export Selection Button](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAANwAAAAkCAIAAABt+cOiAAAEvUlEQVR42u2ccU/bRhiH++H2KVZHUokt1MZIJY5UYaTWVQmoI3QALQABCmyglTYhgNZBUoACTVOIgASRioRkTeTMqYzOX2HvnePUzqBMqEOhe5+/yPnOd/ie/O58knLjBwRpMG7gI0BQSgRBKRGUEkG+sZTNzc1ut/sWglwJPM+DchdICZVcCHKFQAheIGVTUxM+JuQqgbxEKRGUEkFQSgSlRBCUEkEpka8jyoqiyJIonHNdeB5bfxm4gw/q/yhl6+g7YiM5ee+/77MltF+y9Xj3rDq+PUIOZy4xGN/OJRuilA0k5QdC9KVAmyRTzk2uS/F08y9SeSs6C3n/Cri43NcKcdg5GOyX+bPd0snBv/2GtGyqRiUxbH6AewZkHqW87lKqYwJXK/l1t0TUnR5WMrpe0AsrYNWz9Vx+N7qZPaXhpqamFDfTa/ZIM/NO2577CUo4z3BWy8diSShK/xG30lDfDn6JQ3f3KhQlZjrsw/DPJXRWtbD1S72UfE88z/rVj2dZvy6+ay1TNm9dTkz8HP3T6uhkTPREs6Vqd7Zqua0X7LvhW8uXk4uLKdWgbdMRH0rZqFKSYjadTmfS70N05viBI0KMTMT/7C1cWuqk/9rIezq7h7EJRRna0wxSWhG4HqhW2X/lcwndL6iFy4EmzjutUnuOpgJ+SRRDaZApNaS0OQPYt5Cu0Fr5nSnFA59vmtkZuAPNi4Rs9922SSksZA0j+zvcYBRyt7wqshJCjl8G2kTpYafiBWtTOjn9GFEkSeAcDYm21y/x3u55GFVh+THcNs50TIaf+kc3YAiz0k2UskGlPIiFwuHF8EyvKQ/X9kplAXMYfmRWG9mtnB5Mm3/fXzghxof7NPBqk+qL66S0McB5piE655Ufq61A5dN3Z6aRf/JNkXWxPXmvN5aDP/IZIE+qO0LLLX7gmAbxCVzLgk/Gnsz3Q6XCm8d2yzc1o5Icd0QsPwDVDqzNJYyfCs3RceaWHrFQh6FqKOX1WL7phD2ImMtywtrVPQcpk9VNWweTsqMXclSbEi0pNaO8NVw301SFc6Rk3TyE3DJyEbb+floKBicpwU6Jt7k1DG6VdyOD7GJw0C+wktyyQ8r4GVIOF21vUSPxz7C7lao5ehelvAYvOvOdraJEoess9wTW5dL6yCh1RTNjj2aenhqSeRfXvlakJrk4GkVQDa562UK/0Xe7bqapbcZel8thPK8MzYBbNSkPfzOX7+Qc22UKPjYI5yqsxrvY10aSJcEs0Y/GZA9Upsu3qyVapPdxbkaF10WDlFbboR/vOMRtaeOJfauKUjb68l0D8mYhYxj5FfZa0PKavtmkwCompapX31tSQyLHXFzVrIYfYyPmTKu2meb9EXMbkLC96Dh61MAtWrk7nHQeEtHws+zpiRcNa3w0dzlP/45q1AZMNwOhFPv0aUryfmnoHU9p1WpaJtpuZSpK+Z1gLd+CTLPKccpdzdfzz2skUfzH0bgoy/TsvK7wK7diQS7Wl9hri4BwTsPv8IQIpXRN7J8ah9MuBKVsICDGvu3BOoJSIiglgqCUCEqJUiKNLqXb7cbHhFwlPM9f/GMEUKkJQa4ECMGLf4wAQfC3hBAEpURQSgRBKZFrz9/8qtzOC9X7UwAAAABJRU5ErkJggg==)

When exporting a FBX, Maya will bring up the `FBX Exporter` options window. Here, you're given a number of options for defining the type of FBX export.

Expand `Embed Media` and verify that the `Embed Media` checkbox is checked.

![Embed Media](data:image/png;base64,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)

### Triangulate, Tangents and Binormals[​**](#triangulate-tangents-and-binormals "Copy to clipboard")

3D models imported into Lens Studio must be triangulated. In Maya, you can triangulate your mesh by checking `Triangulate` in the FBX Export settings under `Geometry`. Also check `Tangents and Binormals`.

![Triangulate](/assets/images/maya-3d-object-export_3d_object_export_triangulate_rev-1e35a8f84c743ec72a399423b259c477.png)

`Split per-vertex Normals` will be used to transfer hard edge information to Lens Studio. If your 3D model has hard edges please make sure to check the `Split per-vertex Normals` checkbox.

### Animation Settings[​**](#animation-settings-1 "Copy to clipboard")

If you want to export animation with your model, make sure the `Animation` checkbox is selected. In Maya 2016, the following settings should be selected under the `Animation` section of the FBX export settings before exporting:

* `Animation` to unlock animation settings
* `Deformed Models`, `Skins` and `Blend Shapes` under `Deformed Models`
* `Constraints` and `Skeleton Definitions` under `Constraints`

![Animation Settings](/assets/images/maya-3d-object-export_3d_animation_export_anim_settings-52e56eedf2064890f5843e397c18594c.png)

Below is a list of things to ensure when exporting your 3D assets to work best in Lens Studio and ultimately Snapchat.<br /><!-- -->• Your model has to be triangulated via the export dialog<br /><!-- -->• Tangent and Binormals must be enabled in the export dialog<br /><!-- -->• Your scene total of 3D assets should add up to less than `10,000 triangles (5,000 polys assuming your model is built with quads)`. This will allow your model to display smoothly across the widest variety of Android and iPhone devices<br /><!-- -->• In general, stay under `100 joints` for your animation rig. Additionally, while the engine does support Blend Shape animation, try to avoid using it. If Blend Shapes are required, use sparingly and pay close attention to your frame rate performance<br /><!-- -->• Lens Studio supports up to a `4 bones per vertex` limit. If the influence is greater than 4 then there will be problems in your rigged model when imported into Lens Studio

You should now be ready to export. In the `FBX Exporter` options window select the `Export` button.

![Export Button](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAG0AAAAhCAMAAADkvNVzAAABm1BMVEVERERdXV3u7u5lXV1kZGRdbKBnZ2elc13k7u5jY2Pu7udsc3NzXV1zc3Nzm8ubx+RdXXO7kWy74e5dXWzn7u7u7svu7tLu7t1hYWHu7uFiYmJskbtslr9dgKpzbF1dhrJzm8ddZWxzoMt6XV16enN6enp6m8OAXV2Ac3OGXV2GpcOGrs+MXV2MbGWMgHqMstaMstqMt92RZV2Rc3OWss+Wu9KWu92Wv+GbbF2bw+Gbx+FdbGybx+egbF2gc12ghoBdbJallnqly+Sqhmyqy+Sqz+eusrKyhmW3kYZdXYa7m3q7rq67t8e7wN27x91dbKW/kWy/lnO/m3rD5O7D5+7Hm3PHrozH5+7MsrnPoHrPpXrProzPrpHSrobSt5bS1tbS6+7Wt5HWv6DW7u7a0tLa593a7u7d7uvh7u7k4cvk5OtlXXPnx5vny6Dn7ufn7utlc3Prz6rr1rLr1rvr7uvr7u7u0qru1q7u5Mfu58Pu58fu59Lu59ru68tljLvu7s9dc5vu7tpsXV1sZYxsbGXu7utdc6Du68+gjKBi1O00AAABLUlEQVR4Xu3UNW8EMRCA0Zvx8jFDmJmZmZmZmZmZ87Pja7JVOvuUlfZrXD6NpRmLcTOT1BDnBEnXBOCeqmsR/lrIwJqpmVoNImpyrDRnoCwjnfwFeMf2mWr1N5RK2J6D5y1380b/Ba4SyPXhfRvE7wxqA4jBapazfawvTUIRdnuuyKdy11SO7iSc32t/yU/Gs8K35dNswlIL93W2ALTiVw6IRzL0rM2U+NNA9A07AlngGj9g+5O3r0DrwGtKHDZQbbbqwUa1CQd9XFNsNedTgdVOioPfmycgKoskE7secRQqw6Wpfht4PZdMtVqkTeMIxOGCqOwirgBUIGq9EJ0N8jDcyGm76U8eJwItxf67E3XvwEkbOpdjebms5H/cSVNT+WuCrklChHOqZDFuZj88ZUhkBqqwYQAAAABJRU5ErkJggg==)

You now have an exported FBX file that's ready to be imported into Lens Studio. For information on importing 3D models into Lens Studio, review the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide.

## Preparing Multiple Animation Layers[​**](#preparing-multiple-animation-layers "Copy to clipboard")

If your 3D model does not have multiple animations you can skip this section.

These animations should be in separate `Animation Layers` in Maya so that Lens Studio recognizes each individual animation.

Animation layers hold keyframe data of the animation in your scene. For example, the model we are exporting has an Idle animation and a Jump animation. In Maya, these separate animations both exist in the `BaseAnimation` layer by default. We need to assign each individual animation to different animation layers.

Before creating our animation layers, we have to make note of the frame ranges that correspond to each animation.

For example:

* The Idle animation takes up frames 1 - 95
* The Jump animation takes up frames 95 - 200

Then, open the `Outliner` window by selecting `Windows -> Outliner` from Maya’s menu bar.

![](/assets/images/maya-3d-object-export_3d_animation_export_layer_Outliner-d40c9f7e07674469fa76e9e6ec63e5de.png)

Next, select all the joints and controllers that contains animations (keyframes), in the `Outliner` window.

You can collapse a hierarchy in Maya by holding `Shift` and clicking the `+` button.

Next, we need to bake the animation. Baking the animation will automatically create an animation layer for you.

Select the square to the right of `Edit -> Keys -> Bake Simulation` from Maya’s menu bar. This will open the `Bake Simulation Options` window.

![](/assets/images/maya-3d-object-export_3d_animation_export_layer_bake-5b695028f7009c1cfe54a918d8805f53.png)

In the `Bake Simulation Options` window, set the `Time Range` to `Start / End` to unlock the time range settings. Now in the `Start Time` field specify the time that your animation starts and in the `End Time` field specify the time when your animation ends.

For example if the Idle animation starts at frame 1 and ends at frame 95, we have to put 1 in the `Start Time` field and 95 in the `End Time` field.

Next, make sure the `Bake To` is set to `New Layer` and that the `Baked Layers` drop down menu is set to `Keep`.

Now we are ready to bake the animation by clicking on the `Bake` button in the `Bake Simulation Options` window.

![](/assets/images/maya-3d-object-export_3d_animation_export_layer_bakewindow-b7b4cab9a49b7436f89cdb42981f2302.png)

You should now have a newly baked animation in the `Anim` tab in Maya.

[](/img/lens-studio/maya-3d-object-export_3d_animation_export_layer_rename_171205_200555.webm)

After baking all of the animations and creating anim layers for them, we need to make sure all of our animations start at frame 0 in the timeline.

When animation plays in the Lens Studio it will be playing the animation from frame 0.

In order to move all the keyframes of animation layers to start at frame 0, first select all the joints and controllers that contain animations in the `Outliner` window.

Then we need to `Mute` all of the `Animation Layers` besides the animation layer that we want to move to frame 0.

[](/img/lens-studio/maya-3d-object-export_3d_animation_export_layer_mutelayer_171205_200618.webm)

Next, we can select all of the keyframes that are showing in Maya’s `Timeline` by holding the `Shift` key. Then, click and drag from the start time of your animation to the end time of the animation in the `Timeline` panel.

[](/img/lens-studio/maya-3d-object-export_3d_animation_export_layer_timeline_171205_200634.webm)

Finally, move the keyframes to frame 0 by clicking and dragging the selection to frame 0 in the `Timeline`.

Repeat the same process above so that all anim layers start at frame 0. For information on playing back your animations, please refer to the [Animation Player](/lens-studio/features/animation/animation-player.md) guide.
