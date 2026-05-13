# Baseball Cap

The `Baseball Cap Controller` asset allows users create a customizable baseball cap.  The asset comes with a configurable 3D baseball cap which you can recolor and decorate with any image you like. This guide covers how to customize the baseball cap as well as how to import your own custom logo.

Find the `Baseball Cap Controller` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the Asset Library.

## Guide[​**](#guide "Copy to clipboard")

### Baseball Cap Controller Asset[​**](#baseball-cap-controller-asset "Copy to clipboard")

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/baseball-cap-package-7fc1eb22541a89f092bb36ab3a49ef20.png)

Follow the instructions and create a new Head Binding in the Scene Hierarchy.

[](/img/lens-studio/5-features/baseball-cap-create-head-binding.webm)

Drag the prefab `Baseball_Cap_Controller__PUT_UNDER_HEAD_BINDING` into Scene Hierarchy under the Head Binding to create a new Scene Object.

[](/img/lens-studio/5-features/baseball-cap-add-prefab.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/baseball-cap-unpack-package-8536c7950f60df03a5d564f2da6bd528.png)

### Customizing The Baseball Cap[​**](#customizing-the-baseball-cap "Copy to clipboard")

To customize the baseball cap, select the `Baseball Cap Controller [EDIT_ME]` object in the `Scene Hierarchy` panel and adjust its settings in the `Inspector` panel. The sections below walk through each of the customizable settings.

![](/assets/images/baseball-cap-controller-0b0203ea401b1287549afebb6e543038.png)

### Changing the Logo[​**](#changing-the-logo "Copy to clipboard")

You can replace the logo on the baseball cap by changing the `Logo Texture` property to the texture of your choosing.

[](/img/lens-studio/5-features/baseball-cap-change-logo-texture.webm)

To bring in your own image as a logo, select `+ -> Import Asset` in the `Asset Browser` panel. Alternatively, you can drag and drop any image from your computer to the `Asset Browser` panel.

### Adjusting the Logo[​**](#adjusting-the-logo "Copy to clipboard")

You can adjust the logo size using the `Logo Size` slider.

![](/assets/images/baseball-cap-logo-size-7acef82172bfa6341f7a2c80a97e3aa1.png)

You can adjust the logo position using the `Logo Offset X` and `Logo Offset Y` sliders.

![](/assets/images/baseball-cap-logo-offset-cb457df189093180893e13ac2e13176d.png)

You can also adjust the logo's appearance by changing the `Logo Blend Mode` dropdown. Available blend modes are Normal, Screen, and Multiply.

![](/assets/images/baseball-cap-logo-blend-mode-fbec8d5f78d2e7f1ea433a6fe18dd13c.png)

### Coloring the Baseball Cap[​**](#coloring-the-baseball-cap "Copy to clipboard")

You can edit the baseball cap's color in the `Inspector` panel by changing the `Primary Cap Color` and `Secondary Cap Color` properties.

![](/assets/images/baseball-cap-color-ab18e2235fdbdece5ec9aa53df7a4935.png)

### Adjusting the Baseball Cap[​**](#adjusting-the-baseball-cap "Copy to clipboard")

You can reshape the look of the baseball cap by adjusting the `Brim Curve` slider. This property adjusts the curve of the cap's brim between flat and curved.

![](/assets/images/baseball-cap-brim-870e01f4a9eb0dd8fc6ce6b032b4d9c9.png)

You can also change the tilt and swivel of the cap by adjusting the `Hat Tilt` and `Hat Swivel` sliders.

![](/assets/images/baseball-cap-swivel-tilt-1ed94bff57d8d80d00fe544366f53f9c.png)

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
