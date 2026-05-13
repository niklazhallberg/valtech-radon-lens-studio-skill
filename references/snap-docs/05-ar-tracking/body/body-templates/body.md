# Shoulder

The Shoulder template lets you create Lenses that adds images to an upper body found in the camera. The detection for shoulder works at medium to far distances. The Shoulder template uses [body tracking](/lens-studio/features/ar-tracking/world/object-tracking.md) to allow you to attach content to the center of the body and the left and right shoulders.

[](/img/lens-studio/body_body_template_example_small.webm)

Unlike Upper Body Tracking, Shoulder tracking also works on an upper body close to the camera (like in a front camera selfie experience). If you do not need to attach your content to the arm joints, use this template instead of the [Skeletal template](/lens-studio/features/ar-tracking/body/body-templates/skeletal.md). Take a look at the [Object Tracking](/lens-studio/features/ar-tracking/world/object-tracking.md) guide for more information.

## Video Walkthrough[​**](#video-walkthrough "Copy to clipboard")

## Template Walkthrough[​**](#template-walkthrough "Copy to clipboard")

### Switch Preview Video[​**](#switch-preview-video "Copy to clipboard")

When working with the Shoulder Template, you'll want to switch the preview video to one with a body. In the `Preview` panel, press the `Image / Video Mode` button. Then, in the drop down at the top of the `Preview` panel, select the `Body` preview video. You should now see the template working with content applied to the upper body and shoulders. You can also switch to Webcam in the `Preview` panel and see the content attached to your own upper body.

[](/img/lens-studio/body_body_template_preview_video_small.webm)

### Add Resource[​**](#add-resource "Copy to clipboard")

For the Shoulder template, we should first import a 2D texture or animation into the `Asset Browser` panel. To do this, drag and drop a `PNG`, `JPG` or `GIF` into the `Asset Browser` panel from your computer.

[](/img/lens-studio/body_body_template_add_resource_small.webm)

### Configure Shoulder Tracking Controller[​**](#configure-shoulder-tracking-controller "Copy to clipboard")

With the `ShoulderTrackingControler [EDIT_ME]` object selected in the `Scene Hierarchy` panel, we'll configure its settings in the `Inspector` panel. The Shoulder template allows you to configure the image attached to the Right Shoulder, Left Shoulder and Center of the upper body. All are tuned in the same way. When tuning Left Shoulder, for example, you can enable or disable the feature with the `Left Shoulder` checkbox. When enabled, you can assign a custom texture that was imported into the `Asset Browser` panel to the `Left Shoulder` texture field. Finally, you can adjust the `Size`, `Offset`, `Rotation` and `Alpha` of the content with the corresponding sliders.

[](/img/lens-studio/body_body_template_configure.webm)

### Adding Body Tracking Outside of Template[​**](#adding-body-tracking-outside-of-template "Copy to clipboard")

While the Shoulder template gives you a simple way to add 2D images and animation to the tracked points, you can also always add Body tracking outside of the template. To do this, select `+ -> Object Tracking -> Body``Tracking` from the `Scene Hierarchy` panel. You can then edit the position, scale and rotation of the added element in the 2D scene.

### Object Tracking and 3D Objects[​**](#object-tracking-and-3d-objects "Copy to clipboard")

It is possible to attach 3D Objects to Object Tracking by adding a helper script. Please refer to the [Object Tracking & 3D Objects](/lens-studio/features/ar-tracking/world/object-tracking.md#object-tracking--3d-objects) section of the Object Tracking guide for more information.
