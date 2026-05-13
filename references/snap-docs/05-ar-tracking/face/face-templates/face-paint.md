# Face Paint

The Face Paint lets you create a Face Lens that maps a 2D texture to your face. The texture appears to be painted on your skin and reshapes with facial movements. This template is great for creating full face masks or to apply realistic makeup effects. Additionally, the guide includes a Photoshop template for guided painting on the face.

[](/img/lens-studio/5-features/face-paint-preview.webm)

## Face Paint Asset[​**](#face-paint-asset "Copy to clipboard")

Find the `Face Paint` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/img/lens-studio/5-features/face-paint-import-package.png)

Follow the instructions and drag the prefab `Face Paint` into Scene Hierarchy to create a new Scene Object.

[](/img/lens-studio/5-features/face-paint-drag-prefab.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/img/lens-studio/5-features/face-paint-unpack-package.png)

## Customize Face Paint[​**](#customize-face-paint "Copy to clipboard")

### Download the Photoshop Template[​**](#download-the-photoshop-template "Copy to clipboard")

[Face Paint Photoshop Template](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/x7yZgWpMpDYXNbm_Face/files/face_paint_photoshop_template.zip)

### Using the Photoshop Template[​**](#using-the-photoshop-template "Copy to clipboard")

The Photoshop template contains different Artboards to help you create your face paint textures.

Three Artboards are used as a canvas for your textures. You can see how the different Artboards can be used later in this guide.

* **Full -** this Artboard is mapped to the “Full” face mask in Lens Studio
* **Eye -** this Artboard is mapped to the “Eye” face mask in Lens Studio
* **Lips -** this Artboard is mapped to the “Lips” face mask in Lens Studio

The `Anchors` and `Reference` layers are used purely for visual reference. Feel free to hide these layers.

![](/assets/images/face-paint_face-substitution-teplate-4-ce0d8ecff25e432b774719de132a83bc.png)

To get started, you can create a layer in Photoshop under the Artboard which contains the face section you want to work on and paint on this layer.

[](/img/lens-studio/face-paint_face-substitution-teplate-6.webm)

When you’re ready to export, select the Artboard you’re working in, and in the menu bar select `File > Export > Artboards to Files`.

![](/assets/images/face-paint_face-substitution-teplate-5-9e9b4ee28b15d1ad1d2ee091154078f8.png)

In the `Artboard to Files` options, choose PNG as the file type if you have transparency, or JPEG if you don’t. Make sure to have `Artboard Content Only` and `Export Selected Artboards` checked.

![](/assets/images/face-paint_face-substitution-teplate-7-small-4617681f7dd9b6a767ed558f5787ecbc.png)

### Adding the 2D Texture[​**](#adding-the-2d-texture "Copy to clipboard")

Once you've exported your texture(s), you can add them to Lens Studio by dragging and dropping them into the `Asset Browser` panel.

[](/img/lens-studio/5-features/face-paint-add-2d-texture.webm)

### Using Your Texture[​**](#using-your-texture "Copy to clipboard")

With your texture imported, find the `Face Paint Template Source` object in the `Scene Hierarchy` panel. Underneath are multiple Face Mask effect objects that correspond to the available Artboards in the Photoshop template (Eye, Lips and Full). Duplicate the one that corresponds to the texture you created by selecting it in the `Scene Hierarchy` panel, right clicking and selecting `Duplicate`. Next, select your new object and in the `Inspector` panel, set the `Texture` field to your imported texture.

[](/img/lens-studio/5-features/face-paint-update-texture.webm)

Additionally, you can change each Face Mask Effect’s `Blend Mode` and `Alpha` to adjust the appearance of your texture.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your world Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
