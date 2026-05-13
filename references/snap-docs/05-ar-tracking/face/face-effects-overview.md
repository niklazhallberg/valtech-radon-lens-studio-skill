# Face Effects Overview

## Introduction[​**](#introduction "Copy to clipboard")

Lens Studio provides a variety of Face Effects you can add to your Lenses. These effects range from face modifications which require no assets, to attachments requiring simple 2D textures, to more complex effects with 3D animated assets. These effects can be used on their own or together, and can be applied to one or more faces.

## Face Effects[​**](#face-effects "Copy to clipboard")

This guide provides a general overview of each available Face Effect in Lens Studio.

### Face Retouch[​**](#face-retouch "Copy to clipboard")

The [Face Retouch](/lens-studio/features/ar-tracking/face/face-retouch.md) effect offers a number of features for retouching the user's face. These features include Soft Skin, Teeth Whitening, Eye Sharpening and Eye Whitening. The Face Retouch object works best when subtly applied to the face.

![](/assets/images/face-effects-overview_s3Dx-face-overview-7-a41f727c6b8a827157cb27a3a1e523bb.png)

### Eye Color[​**](#eye-color "Copy to clipboard")

The [Eye Color](/lens-studio/features/ar-tracking/face/eye-color.md) effect allows you to change the color of the user's eyes. It also allows you to create subtle eye reflections with the more advanced Texture mode.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-0.webm)

### Face Liquify[​**](#face-liquify "Copy to clipboard")

The [Face Liquify](/lens-studio/features/ar-tracking/face/face-liquify.md) effect spherically warps the face. You are able to configure how big and how intense the effect is. The Face Liquify object is perfect for making funny or exaggerated faces. See [Distort](/lens-studio/features/ar-tracking/face/face-templates/distort.md) for an example.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-1.webm)

### Face Stretch[​**](#face-stretch "Copy to clipboard")

The [Face Stretch](/lens-studio/features/ar-tracking/face/face-stretch.md) effect allows you to stretch points of the user's face. It’s perfect for creating fun and playful face expressions. See [Distort](/lens-studio/features/ar-tracking/face/face-templates/distort.md) for an example.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-2.webm)

### Face Inset[​**](#face-inset "Copy to clipboard")

The [Face Inset](/lens-studio/features/ar-tracking/face/face-inset.md) object allows you to map a feature of your face (e.g. eyes) to other areas of your face. This allows you to, for example, replace your eyes with mouths or map an eye to the center of your forehead. See [Distort](/lens-studio/features/ar-tracking/face/face-templates/distort.md) for an example.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-3.webm)

### Face Mask[​**](#face-mask "Copy to clipboard")

The [Face Mask](/lens-studio/features/ar-tracking/face/face-mask.md) effect maps a 2D texture to your face. The texture appears to be painted on your skin and contorts with facial movements. It’s great for full face masks but also can be used to create realistic makeup. See [Face Paint](/lens-studio/features/ar-tracking/face/face-templates/face-paint.md) and [Photo](/lens-studio/features/ar-tracking/face/face-templates/photo.md) for an example.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-4.webm)

### 2D Face Attachment[​**](#2d-face-attachment "Copy to clipboard")

The [Face Image](/lens-studio/features/ar-tracking/face/face-image.md) effect attaches a 2D textured plane to your head.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-9.webm)

### 3D Face Attachment[​**](#3d-face-attachment "Copy to clipboard")

You can use a similar technique to attach 3D objects as well by replacing the 2D image with a 3D Mesh Visual. See [3D Objects](/lens-studio/features/ar-tracking/face/face-templates/3d-objects.md) for an example and the [Head Attached 3D Objects](/lens-studio/features/ar-tracking/face/head-attached-3d-objects.md) guide for more information.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-5.webm)

### Face Mesh[​**](#face-mesh "Copy to clipboard")

The [Face Mesh](/lens-studio/features/ar-tracking/face/face-mesh.md) resource provides a 3D mesh that will mimic the user's facial expression in real time. It can be used anywhere a mesh may be used.

[](/img/lens-studio/face-effects-overview_face-mesh.webm)

### Face Landmarks[​**](#face-landmarks "Copy to clipboard")

[Face Landmarks](/lens-studio/features/ar-tracking/face/face-landmark.md) are 93 points that are tracked with the user's face. Like [Object tracking](/lens-studio/features/ar-tracking/world/object-tracking.md), the position of the points are in screen space.

[](/img/lens-studio/face-effects-overview_face-land.webm)

### Face Expressions[​**](#face-expressions "Copy to clipboard")

The [Face Expressions](/lens-studio/features/ar-tracking/face/face-expressions.md) Effect allows you to get information about the current expression of the user’s face--such as whether they are currently blinking their left eye, opening their mouth, and more.

[](/img/lens-studio/face-effects-overview_face-expres.webm)

### Eye Tracking[​**](#eye-tracking "Copy to clipboard")

The [Eye Tracking](/lens-studio/features/ar-tracking/face/eye-tracking.md) effect allows you to track the position and rotation of the user’s eyes.

[](/img/lens-studio/face-effects-overview_eye-tracking-prev.webm)

### Face Texture[​**](#face-texture "Copy to clipboard")

The [Face Texture](/lens-studio/features/ar-tracking/face/face-texture.md) effect allows you to get a your Camera texture centered around a part of your face. It can be used, for example, for creating a picture in picture effect, or for applying a user’s face to a 3D object in your Lens.

![](/assets/images/face-effects-overview_s3Dx-face-overview-8-b2d6dde9d193c2f9231dcb93d977282c.png)

### Media Picker Texture[​**](#media-picker-texture "Copy to clipboard")

The [Face Image Picker Texture](/lens-studio/features/ar-tracking/face/face-templates/media-picker.md) resource allows you to get an image or video from your device's camera roll. You can optionally filter for content with faces only, and center the content on the face. It can be used to apply the face of a person saved to your camera roll to a 3D object in your Lens scene.

The texture is also similar to [Face Texture](/lens-studio/features/ar-tracking/face/face-texture.md) but is driven by the device's camera roll instead of the live camera. In fact, if you have a project that's already using [Face Texture](/lens-studio/features/ar-tracking/face/face-texture.md), simply replacing that texture with a [Face Image Picker Texture](/lens-studio/features/ar-tracking/face/face-image-picker-texture.md) will modify it to a "from camera roll" experience.

[](/img/lens-studio/face-effects-overview_face_effects_overview_face_image_picker_example.webm)

## Face Interactivity[​**](#face-interactivity "Copy to clipboard")

Additionally, you can use facial movements to trigger behaviors in your lens. Example of facial triggers include:

* Opens mouth
* Smile
* Raise eyebrows
* Kiss

For a more complete list see the [Events API page](https://developers.snap.com/lens-studio/api/lens-scripting/documents/SceneEvents_List.html).

Take a look at the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script which allows you to trigger effects based on facial expression and more through a drop-down menu.

[](/img/lens-studio/face-effects-overview_s3Dx-face-overview-6.webm)
