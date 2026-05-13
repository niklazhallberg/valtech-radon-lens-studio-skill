# 2D Head Art

The `2D Head Art` asset provides a base for creating Face Lenses that attach 2D art to your head. The asset contains examples that can be toggled to try out different looks. This guide covers how to try out the various example art and how to add your own artwork as an Image.

## Guide[​**](#guide "Copy to clipboard")

Find the `2D Head Art` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

### 2D Head Art Package[​**](#2d-head-art-package "Copy to clipboard")

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/2d-head-art-package-a924d85e1ad49ca1dfbeb38893b2590a.png)

Follow the instructions and drag the prefab `2D Head Art` into Scene Hierarchy under the Camera Object to create a new Scene Object.

[](/img/lens-studio/5-features/2d-head-art-drag-prefab.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/2d-head-art-unpack-package-46635dcdaf6f3187db694a04aa2a9059.png)

### Playing with Example Assets[​**](#playing-with-example-assets "Copy to clipboard")

In the `Scene Hierarchy` panel, under the `2D Objects Examples [REMOVE_ME]` object you can find all the provided example face accessories that can be mixed and matched to make a custom Lens.

To enable an accessory, click the checkbox to the right of its name in the `Scene Hierarchy` panel.

[](/img/lens-studio/5-features/2d-head-art-toggle-objects.webm)

### Adding Your Own 2D Textures[​**](#adding-your-own-2d-textures "Copy to clipboard")

To add your own 2D textures to the template, drag and drop your image to the `Asset Browser` panel.

It's important to use optimized images for Lens size and performance reasons. Follow these guidelines to create optimized texture resources:

* Image dimensions should never be greater than 2048 x 2048 pixels
* Non-transparent images should be saved using JPEG. Transparent images should be saved using PNG
* Try compressing images to reduce the Lens size

[](/img/lens-studio/5-features/2d-head-art-drag-texture.webm)

### Adding Your Texture to a Face Image[​**](#adding-your-texture-to-a-face-image "Copy to clipboard")

To add your texture to the scene, in the `Scene Hierarchy` panel, select `+ -> Face -> Face Image`. In the `Inspector` panel, click the `Texture` field and select your newly imported texture. You can also directly drag your texture from the `Asset Browser` panel to the Texture field.

[](/img/lens-studio/5-features/2d-head-art-add-face-image.webm)

### Positioning Your Face Image[​**](#positioning-your-face-image "Copy to clipboard")

In the `2D Scene` panel, you can position and resize your assets to fit the face in the `Preview` panel. You can dragging inside the Face Image container.

[](/img/lens-studio/5-features/2d-head-art-drag-face-image.webm)

Alternatively, you can use common face attachment points by tuning the `Attach to Point` dropdown found on the Head Binding component.

[](/img/lens-studio/5-features/2d-head-art-head-binding.webm)

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
