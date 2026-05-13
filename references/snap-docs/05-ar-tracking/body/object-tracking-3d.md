# 3D Body and Hand Tracking

You are able to track joints on the body, as well as the hands in 3D space with the `Object Tracking 3D` component. However, depending on the parts you want to track, you will use different `Tracking Assets`.

You can add the different tracking by selecting either the `Body Tracking 3D` or `Hand tracking 3D` under the `Tracking` category in `Scene Hierarchy panel > +`. Lens Studio will then add the object containing the unique `Tracking Asset`.

You can also track your, or your friends, Bitmoji to the body. Take a look at the [Bitmoji 3D](/lens-studio/features/bitmoji-avatar/bitmoji-3d.md) guide to learn more!

You can also track hand and body in 2D space using [Object Tracking](/lens-studio/features/ar-tracking/world/object-tracking.md).

## 3D Body Tracking[​**](#3d-body-tracking "Copy to clipboard")

[](/img/lens-studio/object-tracking-3d_body-3d-preview.webm)

The `3D Body Tracking` asset, combined with the `Object Tracking 3D` component, allows you to attach 2D or 3D contents to a set of 3D skeletons found in the camera. It currently supports the tracking of the joints of one or more bodies.

You can download the 3D Body Tracking FBX file in both [A Pose](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/Body_Mesh_With_Skeleton_A_Pose.fbx) and [T Pose](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/Body_Mesh_With_Skeleton_T_Pose.fbx) form to use as references for your Lenses.

### Previewing Your Model for Use[​**](#previewing-your-model-for-use "Copy to clipboard")

You can preview rigged skeleton of any 3d model. User uploaded custom rigging will have the turquoise color and bones provided by 3D tracking component will have a grey color as shown in the image above.

You may tap on an individual joint and drag it around to adjust shape of your rigged model

[](/img/lens-studio/object-tracking-3d_objecttracking3d-adjustrig.webm)

### Removing Existing Animation Component[​**](#removing-existing-animation-component "Copy to clipboard")

If your 3D model already has animation component, please make sure to disable the `Animation Player` component, otherwise your 3D model might not move with tracking component because its existing 3D animation is overwriting its movement.

![](/assets/images/object-tracking-3d-disable-animation-05860f361c30eb2b354a3bcc13c40785.png)

In the same way, even if you manipulate the position of a joint in the Scene panel, if you have an animation on it, your changes will be overwritten.

### Adding Body Tracking 3D[​**](#adding-body-tracking-3d "Copy to clipboard")

Body Tracking 3D allows you to track the joints of one or more bodies in 3D. Unlike [2D Body tracking](/lens-studio/features/ar-tracking/world/object-tracking.md), it will track the rotation of the joints even as the user turns around.

To add `3D Body Tracking` to your project, in the `Scene Hierarchy` panel, select `+ -> Tracking -> Body Tracking 3D`

A `3D Body Tracking` asset will be generated in the `Asset Browser` panel and used by the new object with the `Object Tracking 3D` componennt.

If you're looking to create `3D Body Tracking` Lenses, we recommend taking a look at the [3D Body Tracking](/lens-studio/features/ar-tracking/body/body-templates/3d-body-tracking.md) example.

### Choosing Tracking Mode[​**](#choosing-tracking-mode "Copy to clipboard")

There are several ways your content can be attached to the tracker.

* **Proportions and Pose** Applies rotation correction from the root of the model to the leaf bones. If bones further down the hierarchy are missing, we still apply corrections up to that point. Additionally, it will scale the your object such that it matches the proportion of the Snapchatter.
* **Pose Only -** The same as `Proportions and Pose`, but does not apply scaling. This is useful when you don't want your 3D model to be distorted based on the Snapchatter's body.
* **Attachment -** Moves the attached scene object to the world position of the joint. An object with 0 rotation will be aligned to the axis of the attached joint. This mode is useful when you are attaching separate 3D models to the joints.

### Adding 3D Models to the Tracking Component[​**](#adding-3d-models-to-the-tracking-component "Copy to clipboard")

There is a list of Attachment Points on each Object Tracking 3D component. Each of these points represent a specific joint on the body part. Any object linked in this slot will be attached to the specific part of the body.

![](/assets/images/object-tracking-3d_3dbody-attachment-points-fa993a6c5176a38f2363d25a5124ec42.jpg)

### Using Match Hierarchy[​**](#using-match-hierarchy "Copy to clipboard")

No visual element will show up in the scene unless we apply a custom 3D model to the Object Tracking 3D component. The most convenient way to do this is by using the `Match Hierarchy` option.

Note that Match Hierarchy would work only if the 3D Model you provided has the same rigged bone structure as the default models we provided. Feel free to check out the [3D Body Tracking](/lens-studio/features/ar-tracking/body/body-templates/3d-body-tracking.md) template or the `Stick Figure 3D Model` on the Asset Library as a reference.

### Hand Tracking in Body Tracking[​**](#hand-tracking-in-body-tracking "Copy to clipboard")

The `3d Body Tracking` asset contains an option to enable hand tracking. You can enable this option by ticking the `Track Hand` option in the `Inspector` panel, with the asset selected. This option is useful when you want to track both the body and the hand, but should be disabled if you object doesn't have hand dedicated joints.

Take a look a the [3D Body Template](/lens-studio/features/ar-tracking/body/body-templates/3d-body-tracking.md#character-requirements) guide to see the hierarchy used in 3D Body Tracking, as well as examples of it in action.

[](/img/lens-studio/object-tracking-3d-hand-in-3d-body.webm)

## Standalone 3D Hand Tracking[​**](#standalone-3d-hand-tracking "Copy to clipboard")

[](/img/lens-studio/object-tracking-3d_3dhand.webm)

In addition to hand tracking provided by the body tracking, you can also add a dedicated 3D Hand Tracking asset which would work more precisely.

The Hand Tracking hierarchy in the Body Tracking asset uses a more standard hieararchy used in 3D animation. In contrast, the standalone 3D Hand Tracking contains 5 more extra bones: `wrist-to-thumb`, `wrist-to-index`, `wrist-to-mid`, `wrist-to-ring`, `wrist-to-pinky`. In addition, they use a 0-based naming convention for the remaining 4 bones of each finger, e.g., `thumb-0`, `thumb-1`, `thumb-2`, `thumb-3`.

`Hand Tracking 3D` allows you to track the joints of one or more hands in 3D. As before, to add `Hand Tracking 3D` to your project, in the `Scene Hierarchy` panel, select `+ -> Tracking -> Hand Tracking 3D`

A `Hand Tracking Asset` will be generated in the `Asset Browser` panel. You can select the Hand Type to specify which hand this asset will be tracking.

![](/assets/images/object-tracking-3d-hand-option-70bf655db786ed344ca600ae274af3b9.png)

By default, `Hand Tracking (Mobile)` is enabled. If you only need to track one hand a time, choose `Single Hand (Legacy)` tracking for device optimization. Additionally, if you are targeting Spectacles, you can use `Hand Tracking (Spectacles)`.

In addition, you can have a `Object Tracking 3D` for each hand you want to track, each referencing their own `Hand Tracking Asset`. If you only need one, you can delete the other.

Additional joints are provided between the wrist and the different fingers to allow scaling and rotation of "knuckles" joints independently, resulting in a more flexible 3D model that are more accurate to the tracked hand. Without these extra joints all 5 knuckles joints would share the same parent joint (wrist) and thus would share the same parent coordinate system; In other words, they could only be scaled and rotated all at once using single shared scaling and rotation parameters.

### Adding 3D Models to the Tracking Component[​**](#adding-3d-models-to-the-tracking-component-1 "Copy to clipboard")

Similar to the `3D Body Tracking`, there is a list of Attachment Points on each `3D Hand Tracking`. Each of these points represent a specific joint on the body part. Any object linked in this slot will be attached to that specific part of the hand.

### Using Match Hierarchy[​**](#using-match-hierarchy-1 "Copy to clipboard")

Similar to the `3D Body Tracking`, Match Hierarchy on the `3D Hand Tracking` component would work if the 3D Model you provided has the same rigged bone structure as the default models we provided. Please find the structure of the reference for 3D Hand model in the `3D Hand Reference` asset in the Asset Library or in the [3D Hand Tracking](/lens-studio/features/ar-tracking/hand/hand-tracking-templates/3d-hand-tracking.md) example!

![](/assets/images/object-tracking-3d_3dhand-objtracking-5fc9d65ee64b4d1bf33e0d713c3ecded.jpg)

### Make Sure Models Are Not Using Animations[​**](#make-sure-models-are-not-using-animations "Copy to clipboard")

Sometimes our models have built-in animations when we import them to Lens Studio. If so, the built-in animation might overwrite the movement and cause our 3D models to not follow tracking position, even if they are assigned in Attachment Points.

To prevent native animation from taking over our 3D model position. First we have to disable the `Animation Player` component on the object.

![](/assets/images/object-tracking-3d_redpanda1-1f97f3fd00888dcfcd06e3109bfd8d2e.jpg)

After we've done these 2 steps, we can make sure that there is no existing animation overwriting our model, we'll see our model being controlled by the tracking component instead.
