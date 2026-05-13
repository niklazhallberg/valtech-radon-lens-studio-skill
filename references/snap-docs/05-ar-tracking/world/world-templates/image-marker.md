# Marker

The Marker feature allows you to specify an image that is recognized and tracked by the Snapchat camera. Unlike the other tracking techniques in the Device Tracking component, marker tracking detects and tracks the features in a specific user defined image. The guide shows you how to utilize marker tracking to create 2D and 3D experience tightly tracked to a marker image. It also includes different effects that can be triggered when the marker is recognized, tapped and more.

It is not recommended to utilize the Marker feature for a sponsored experience because it is not guaranteed that the user will have the target marker readily available. For brands, the Marker feature is instead recommended for print campaigns with a Lens that is unlockable via Snapcode.

## Add 2D Content with Marker Image asset[​**](#add-2d-content-with-marker-image-asset "Copy to clipboard")

Find the `Marker Image` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library. Once you import the asset from Asset Library, you can find the package in the Asset Browser. You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/marker-image-import-package-9c62e8352d3cbaa5c51990d5f2707abe.png)

Follow the instructions and drag the prefab `Marker Image` into Scene Hierarchy under `Camera Object` to create a new Scene Object.

[](/img/lens-studio/5-features/marker-image-drag-prefab.webm)

### Image Marker Component[​**](#image-marker-component "Copy to clipboard")

Click the `Marker Image` object. You can attach `Image Marker` Asset to the `Marker Tracking` Component in the Inspector Panel. With `Image Marker` selected in the `Asset Brower`, you can define Marker Height and attach Marker Texture. Click [here](/lens-studio/features/ar-tracking/world/marker-tracking.md) to learn more about `Marker Tracking`.

![](/assets/images/marker-image-marker-component-2ac1dd4a4d2721c2aac5a391e6876310.png)

### Image Tracking Controller[​**](#image-tracking-controller "Copy to clipboard")

Find `ImageTrackingController` script component in the `Marker Image` object.

* `Marker Tracking Component`: Attach `Marker Tracking Component` to the script.

* `Resize Object Arrary` : Resize the objects to match marker size.

* `Send Triggers` : Enable to send behavior triggers. Allow you to trigger marker event without coding.

  <!-- -->

  * `On Marker Found` : Send behavior triggers when marker is found.
  * `On Marker Lost` : Send behavior triggers when marker is Lost.

![](/img/lens-studio/5-features/marker-image-tracking-controller.png)

Click [here](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to learn more about behavior script.

## Add 3D Content with Marker Cube asset[​**](#add-3d-content-with-marker-cube-asset "Copy to clipboard")

Find the `Marker Cube` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library. Once you import the asset from Asset Library, you can find the package in the Asset Browser. You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/marker-cube-import-package-1810b4b46176132f772658e52758ed73.png)

Follow the instructions and drag the prefab `Marker Cube` into Scene Hierarchy under `Camera Object` to create a new Scene Object.

[](/img/lens-studio/5-features/marker-cube-drag-prefab.webm)

### Image Marker Component[​**](#image-marker-component-1 "Copy to clipboard")

Click the `Marker Image` object. You can attach `Image Marker` Asset to the `Marker Tracking` Component in the Inspector Panel. With `Image Marker` selected in the `Asset Brower`, you can define Marker Height and attach Marker Texture. Click [here](/lens-studio/features/ar-tracking/world/marker-tracking.md) to learn more about `Marker Tracking`.

![](/assets/images/marker-image-marker-component-2ac1dd4a4d2721c2aac5a391e6876310.png)

### Enable Light Shadows[​**](#enable-light-shadows "Copy to clipboard")

Find `EnableLightShadows` script component in the `Marker Cube` object. This script enables shadows in the Light Source automatically. In order to make your own mesh cast shadows on the `Matte Shadow Plane`. Change `Mesh Shadow Mode` to `Caster` in the `Render Mesh Visual` Component.

![](/img/lens-studio/5-features/marker-cube-mesh-shadow-mode.png)

## Scripting the Marker Found and Lost Events[​**](#scripting-the-marker-found-and-lost-events "Copy to clipboard")

Follow the below script examples to create your own custom interactions for when a marker is found or lost.

### script.onMarkerFound[​**](#scriptonmarkerfound "Copy to clipboard")

This function is triggered when the marker is found as long as it is on an object that is a child of the `Image Marker [EDIT_ME]` object. Example script below:

```
script.onMarkerFound = function () {
  print('Marker Found');
};
```

### script.onMarkerLost[​**](#scriptonmarkerlost "Copy to clipboard")

This function is triggered when the marker is lost as long as it is on an object that is a child of the `Image Marker [EDIT_ME]` object. Example script below:

```
script.onMarkerLost = function () {
  print('Marker Lost');
};
```

## Create your own Marker[​**](#create-your-own-marker "Copy to clipboard")

### Designing an Image Marker[​**](#designing-an-image-marker "Copy to clipboard")

When picking an image for your marker, keep the following guidelines in mind to make sure that it will have smooth and accurate tracking. For more information, refer to the [Marker Tracking](/lens-studio/features/ar-tracking/world/marker-tracking.md) guide.

* Make sure your image has a lot of detail and contrast.
* Avoid repetitive patterns.
* Avoid low resolution images.
* Use a `PNG` or `JPG` with a resolution of 2048 x 2048 or less,

### Adding an Image Marker[​**](#adding-an-image-marker "Copy to clipboard")

After designing an image marker, you need to import the marker into Lens Studio. To do this, in the `Asset Browser` panel select `+ -> Image Marker`.

[](/img/lens-studio/5-features/marker-image-add-new-marker.webm)

Then, select the image file that you want to use as your image marker.

You’ll now have an image marker resource in your `Asset Browser` panel. Select your marker and in the `Inspector` panel, tune the height of your image in centimeters if you want the size of your marker in the `Scene` panel to accurately reflect the size of your marker in physical space.

[](/img/lens-studio/5-features/marker-marker-height.webm)

To replace the marker, locate the object named `Image Marker [EDIT_ME]` in the `Scene Hierarchy` panel and assign your newly created image marker to the `Marker` field of the `Marker Tracking` component.

[](/img/lens-studio/5-features/marker-replace-marker.webm)

### Adding a Snapcode Marker[​**](#adding-a-snapcode-marker "Copy to clipboard")

With a Snapcode Marker you can detect and track any Snapcode. This allows you to create an experience that works on all Snapcodes. In the `Asset Browser` panel `+ -> Snapcode Marker` to create a new Snapcode Marker.

![](data:image/png;base64,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)

In the `Scene Hierarchy` panel, locate the object named `Image Marker` and select it. Then, assign the `Snapcode Marker` resource to the `Marker` field of the `Marker Tracking` component.

### Attach Content to the Image Marker[​**](#attach-content-to-the-image-marker "Copy to clipboard")

Drag and drop your custom content to be a child of the `Image Marker [EDIT_ME]` object in the `Scene` panel. Any object (including 2D Images) can be added as a child of the `Image Marker [EDIT_ME]` object to have them be tightly tracked to the marker image.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.

## Submitting Your Lens[​**](#submitting-your-lens "Copy to clipboard")

For information on submitting your Lens, follow the below guides:

* [Creating an Icon](/lens-studio/publishing/configuring/creating-an-icon.md)
* [Configuring Project Info](/lens-studio/publishing/configuring/configuring-project-info.md)
* [Submitting Your Lens](/lens-studio/publishing/submitting/submitting-your-lens.md)
* [Sharing Your Lens](/lens-studio/publishing/distributing/sharing-your-lens.md)
