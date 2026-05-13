# Skeletal

The Skeletal asset allows you to track images to specific joints of the user's body. You can set your 2D images to track the user's head, neck, shoulders, elbows, and hands. Each image can be toggled on and off, as well as offset or resized. Additionally, you have the option to smooth out the tracking of each joint.

[](/img/lens-studio/skeletal_skeletal_temp_image2.webm)

## Importing the Asset[​**](#importing-the-asset "Copy to clipboard")

Find the `2D Skeletal` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

Once you import the asset from the Asset Library, you can find the package in the Asset Browser.

Follow the instructions and drag the prefab `2D Skeletal__PUT_IN_ORTHO_CAM` into the Scene Hierarchy to create a new Scene Object. If your scene doesn't have an Orthographic Camera, you can create one by clicking the `+` button at the top left corner of the `Scene Hierarchy` panel, typing "Orthographic Camera" to find the Orthographic Camera object, and clicking on it to add it to the scene.

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

## Walkthrough[​**](#walkthrough "Copy to clipboard")

### Switching Preview Video[​**](#switching-preview-video "Copy to clipboard")

When working with the Skeletal asset, you’ll want to switch the preview video to one with a person’s body. In the Preview panel, select the `Videos` button.

Then, in the drop-down at the top of the Preview panel, choose the `Skeletal` video under the category "Object Tracking".

![](/assets/images/ls5-preview-video-select-skeletal-c701e5710060d65924901dedfbdfc938.png)

You should now see the content tracked to the body in the video. You can also switch to `Webcam Mode` to see the content attached to yourself.

![](data:image/png;base64,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)

### Add a Resource[​**](#add-a-resource "Copy to clipboard")

To use the template, we’ll first need to import the images we want to attach to the joints. To do this, drag and drop a `PNG`, `JPG`, or `GIF` into the `Asset Browser` panel from your computer.

[](/img/lens-studio/general-5/ls5-add-asset-to-ab.webm)

### Configure Skeletal Controller[​**](#configure-skeletal-controller "Copy to clipboard")

Next, we will assign our imported content to each joint.

First, select the `Skeletal Image Controller [EDIT_ME]` object in the `Scene Hierarchy` panel to see its settings in the `Inspector` panel.

![](/assets/images/ls5-skeletal-asset-skeletal-image-controller-c84e47f72e016bffc48d9d881c48b5e7.png)

### Configure Content[​**](#configure-content "Copy to clipboard")

The Skeletal asset allows you to attach and tune an image to the following joints:

* Head
* Neck
* Right Shoulder
* Left Shoulder
* Right Elbow
* Left Elbow
* Right Hand
* Left Hand

You can enable or disable tracking of a joint by toggling the checkbox to the right of the joint's name.

[](/img/lens-studio/skeletal_sskeletal_temp_image5.webm)

When enabled, you can assign the custom texture that you imported to the joint’s Texture field.

[](/img/lens-studio/skeletal_sskeletal_temp_image6.webm)

You can also adjust the size, offset, rotation, and alpha of your image with the corresponding sliders.

[](/img/lens-studio/skeletal_sskeletal_temp_image7.webm)

Finally, you can set your image to look at a specific joint by setting the Rotate Toward drop-down menu.

[](/img/lens-studio/skeletal_sskeletal_temp_image8.webm)

### Configure Tracking Types[​**](#configure-tracking-types "Copy to clipboard")

The Skeletal assets comes with two tracking modes:

* **Smooth:** Smooth mode focuses on tracking the content with the least amount of jitter. In other words, tracking in Smooth mode is less bumpy, but it may result in a delay.
* **Precise:** Precise mode focuses on tracking the content with the highest accuracy and the least amount of delay, but it may result in occasional jitter.

By default, the tracking type is set to Smooth. To change the tracking type, select the `Skeletal Tracking Controller` in the `Scene Hierarchy` panel under the `Orthographic Camera` object.

![](/assets/images/ls5-skeletal-asset-skeletal-tracking-controller-8e1156e5d48f78e3868096ca79eff2d7.png)

Then, you can change the tracking type by changing the “Tracking Type” drop-down menu.

In most cases, you will want to use Smooth mode to track your content.

When smooth mode is selected, you can change the smoothing amount by changing the Smoothness slider.

You can export the Skeletal Tracking Controller object and add it to your own Lens project to get the same smoothing effect in your own Lens.

### Object Tracking and 3D Objects[​**](#object-tracking-and-3d-objects "Copy to clipboard")

You can attach 3D Objects to Object Tracking by adding a helper script. Please refer to the [Object Tracking & 3D Objects](/lens-studio/features/ar-tracking/world/object-tracking.md#object-tracking--3d-objects) section of the [Object Tracking](/lens-studio/features/ar-tracking/world/object-tracking.md) guide for more information.

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
