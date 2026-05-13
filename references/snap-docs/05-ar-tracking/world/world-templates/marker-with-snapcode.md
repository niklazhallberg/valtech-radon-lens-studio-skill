# Marker with Snapcode

The Marker with Snapcode template lets you unlock a Lens via its Snapcode and immediately track your content to it; then, switching to tracking your image when it’s visible. This template is great for creating Lenses that overlay content onto existing images such as a poster or mural.

This template was originally released as part of Lens Studio 1.0. Since then, significant improvement has been made to Lens Studio to provide better ways of achieving the same result as this template. You can download the legacy template from the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

Since you won't get a Snapcode until you've submitted your Lens, you can [download](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/VKgkU8_1_7_0/img/lens-studio-snapcode.png) this example Snapcode to use as a placeholder in your image.

It is not recommended to utilize the Marker with Snapcode template for a sponsored experience because it is not guaranteed that the user will have the target marker readily available. For brands, the Marker with Snapcode template is instead recommended for print campaigns with Lenses that are unlockable via Snapcode.

## Tutorial[​**](#tutorial "Copy to clipboard")

## Guide[​**](#guide "Copy to clipboard")

### Exporting 3D Content[​**](#exporting-3d-content "Copy to clipboard")

The Animated Object Template assumes that you have a 3D animated object which you'll be importing into Lens Studio. First you must export your object to be Lens Studio ready. To do this, follow the [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guide.

### Importing 3D Content[​**](#importing-3d-content "Copy to clipboard")

Once you have your 3D object exported, follow the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide to import your 3D object into Lens Studio.

### Placing Your Content[​**](#placing-your-content "Copy to clipboard")

Once your content is imported, in the `Scene Hierarchy` panel, drag your content underneath the `MarkerWithSnapcodeController`. Then remove the object `MyScene [REPLACE_ME]`.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-1.webm)

### Importing your Image as a Visual Hint[​**](#importing-your-image-as-a-visual-hint "Copy to clipboard")

Since we’re using marker tracking, your content will not show up when your marker is not visible. To help your user find the right image, we provide a simple UI to let the user know what they need to do.

To do this, import your image by dragging and dropping your image from your computer to the `Asset Browser` panel. Then, in the `Scene Hierarchy` panel, select `Magnifying Hint [EDIT_ME]` and select the `Preview Texture` field. In the popup window, select your newly imported image.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-2.webm)

### Importing your Image as a Marker[​**](#importing-your-image-as-a-marker "Copy to clipboard")

Now, we need to tell the Lens what image to look for. In your `Asset Browser` panel, click `+ -> Image Marker`. Then in the file selection window, choose your image.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-3.webm)

Your image should be high resolution, but below 2048 x 2048

### Tracking your Image Marker[​**](#tracking-your-image-marker "Copy to clipboard")

To use the new marker you created, in the `Scene Hierarchy` panel, select `Image Tracking`. Then, in the `Inspector` panel, select the `Marker` field, and choose your new Image Marker in the popup.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-4.webm)

### Setting Up Your Markers[​**](#setting-up-your-markers "Copy to clipboard")

Since we are tracking two different markers, it is crucial that their relationship in the real world is reflected in Lens Studio so that your content will seamlessly track across the two markers.

Select `Snapcode Marker [EDIT_ME]` in the `Asset Browser` panel, and in the `Inspector` panel, type in the height of your Snapcode in centimeters.

Similarly, select your marker in the `Asset Browser` panel, and in the `Inspector` panel, type in the height of your image in centimeters.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-5_181004_213908.webm)

Finally, in the `Scene Hierarchy` panel select `Snapcode Tracking`, and in the `Scene` panel, use the move widget to position your Snapcode relationally to your image.

### Setting Up Reference Points[​**](#setting-up-reference-points "Copy to clipboard")

Additionally, we will need to track our content to a common reference point so the Lens knows how to position our content in relation to each marker.

To do this, we need three objects that all have the same world position. Since, by default, the `Reference Point` under `Image Tracking` is in the same position as `MarkerWithSnapcodeController` (world origin), all we need to do is copy this position to `Snapcode Tracking`. To do this: right-click the `Reference Point` under `Image Tracking` and select `Duplicate`. Then, drag the duplicated object under `Snapcode Tracking`. Finally, remove the original `Reference Point` under Snapcode Tracking.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-7.webm)

### Setting Up Cross Hint[​**](#setting-up-cross-hint "Copy to clipboard")

We provide a multi-colored cross animation that plays to help users understand that a marker has been found. You can set this animation to animate from a certain point. Usually this is where your Snapcode is.

In the `Scene Hierarchy` panel, select `CrossController [POSITION_ME]`, and in the `Scene` panel, use the move widget to move this object in the x and y coordinate to where your `Snapcode Tracking` object is.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-8.webm)

### Setting Up an Occluder[​**](#setting-up-an-occluder "Copy to clipboard")

We provide a rectangle occluder to help you occlude anything outside your image. In the `Scene Hierarchy` panel, select `Occluder`, and in the `Inspector` panel, modify the x and y scale to the size of your image in centimeters. You can fine tune the occluder using the scale widget in the `Scene` panel.

This occluder is a regular mesh with an occluder material which has a rectangular hole cut out in the middle. If your image is not rectangular, feel free to replace it with your own custom occluder mesh.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-9.webm)

### Fading in Your Content[​**](#fading-in-your-content "Copy to clipboard")

In most cases you will want to transition your content in so that it feels like it’s coming from the marker rather than instantly popping into place.

To do this, in the `Asset Browser` panel, select the materials that your content uses that you want to fade in. Then, in the `Inspector` panel, tick the box labeled `Fizzle`. Finally, in your `Scene Hierarchy` panel, select `MeshFadeController` and under `Fade Materials`, press `Add Value` and add the materials which you want to fade in.

[](/img/lens-studio/marker-with-snapcode_marker-with-snapcode-10.webm)

You can choose whether your object fades in or fades out in the `Fade Type` drop down.

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.

### Submitting Your Lens[​**](#submitting-your-lens "Copy to clipboard")

For information on submitting your Lens, follow the below guides:

* [Creating an Icon](/lens-studio/publishing/configuring/creating-an-icon.md)
* [Configuring Project Info](/lens-studio/publishing/configuring/configuring-project-info.md)
* [Submitting Your Lens](/lens-studio/publishing/submitting/submitting-your-lens.md)
* [Sharing Your Lens](/lens-studio/publishing/distributing/sharing-your-lens.md)

## Script Interface[​**](#script-interface "Copy to clipboard")

### MarkerWithSnapcodeController.js[​**](#markerwithsnapcodecontrollerjs "Copy to clipboard")

In some cases you may want to specify how your content should play. To do this, you can add a global function which the template will call based on the status of the marker tracker. One way to do this is to create a script on an object and set the script to run on `Initialized`. This template includes an example script which is attached to the `MyScene` object (found in the `Asset Browser` panel under `Mark in the City Example [REMOVE_ME] -> Scripts -> MySceneController.js`).

* `global.onSceneEnabled` - This function, if it exists, will be called when a marker is found
* `global.onSceneWillDisable` - This function, if it exists, will be called when a marker is lost
* `global.onSceneDisabled` - This function, if it exists, will be called one frame after global.onSceneWillDisable is called

## Related Guides[​**](#related-guides "Copy to clipboard")

Please refer to the guides below for additional information:

* [Marker Tracking](/lens-studio/features/ar-tracking/world/marker-tracking.md)
* [Image Marker Template](/lens-studio/features/ar-tracking/world/world-templates/image-marker.md)
