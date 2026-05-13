# Image

Images are 2D planes that can be added to your Lens. They can be added to the 3D scene, attached to the screen, attached to the face and more.

## Add Texture Resource[​**](#add-texture-resource "Copy to clipboard")

To add an image to your Lens, you first need to add a Texture resource to the `Asset Browser` panel. To do this, drag and drop a `PNG`, `JPG`, `GIF`, `PVR`, `TIFF`, `DDS`, `TGA`, `BMP` to the `Asset Browser` panel from your computer. For information about adding animated textures, please refer to the [2D Animation](/lens-studio/assets-pipeline/2d/2d-animation.md) guide.

[](/img/lens-studio/5-adding-content/2d-image-1.webm)

You can alternatively add a new resource press `"+"` button at the `Asset Browser` panel and select `Import Asset`.

## Add Image to Screen[​**](#add-image-to-screen "Copy to clipboard")

Images can be added to the Screen as well. These images will exist in 2D space attached to the screen. Screen Images are great for UI elements, overlays, headers, footers, logos and more.

### Add Screen Image[​**](#add-screen-image "Copy to clipboard")

To add a new Image attached to the Screen, press `"+"` button at the `Scene Hierarchy` panel and select `Screen Image`

![](/assets/images/2d-image-2-2275cd2f057b3ad5cd6e276b65b03b98.png)

### Set Texture[​**](#set-texture "Copy to clipboard")

With the new Screen Image selected, open the inline editor in the `Inspector` panel for the material used by the `Image` component by pressing the button to the right of the material. Next, set the `Texture` field to your imported Texture resource.

[](/img/lens-studio/5-adding-content/2d-image-3.webm)

In the `Asset Browser` you'll notice an `Image` material has been added when you added the Screen Image. The material asset is used to describe how something should look. The Image component automatically adds a material suitable for itself (e.g. unlit). Learn more in the [materials](/lens-studio/features/graphics/materials/overview.md) guide.

### Move, Scale and Rotate in Scene[​**](#move-scale-and-rotate-in-scene "Copy to clipboard")

Double click on the Screen Image, which will open up the `2D Editor` panel. Click and drag the image in the panel to move the image. The Screen Image can be scaled by clicking and dragging the corners and edges of the bounding box. Finally, the Screen Image can be rotated by hovering your mouse over a corner until the rotation handle appears. With the rotation handle, click and drag your mouse to rotate the Screen Image.

[](/img/lens-studio/5-adding-content/2d-image-5.webm)

## Add Image to 3D Scene[​**](#add-image-to-3d-scene "Copy to clipboard")

Images can be added to the 3D Scene. This will allow you to position the 2D image in 3D space.

### Add Image[​**](#add-image "Copy to clipboard")

To add a new Image to the 3D Scene, select `+ -> Image` from the `Scene Hierarchy` panel.

![](/assets/images/2d-image-6-e5fb58b5085ab454ad1b5a2cc07651b7.png)

### Set Texture[​**](#set-texture-1 "Copy to clipboard")

With the new Image selected, set the `Texture` field in the `Inspector` panel to your imported Texture resource.

![](/assets/images/2d-image-7-fe81683c689ac3972cfb79c0e11d83eb.png)

### Move, Scale and Rotate in Scene[​**](#move-scale-and-rotate-in-scene-1 "Copy to clipboard")

With the new Image selected, you can move the object in the 3D Scene in the `Scene` Panel. Press the `W` shortcut to enable the move handles on the object and then drag the handles to move in the X, Y and Z space. Similarly you can use the `E` shortcut for Scale and the `R` shortcut for Rotation.

[](/img/lens-studio/image_Image-3d-transform.webm)

## Add Image to Face[​**](#add-image-to-face "Copy to clipboard")

Images can be attached to and track with the face. Please refer to the [Face Image](/lens-studio/features/ar-tracking/face/face-image.md) guide for details.

## Adjusting Image[​**](#adjusting-image "Copy to clipboard")

With an Image or Screen image selected in the `Scene Hierarchy` panel, you can modify the Image's settings in the `Inspector` panel.

![](/assets/images/2d-image-8-9e1ce861f0744ee1d1eab6d41da5375c.png)

* **Material:** The material assigned to the image. Unless you're using your own custom material, use the Default material

  <!-- -->

  * **Pass:** The shader that describes how the material works.
  * **Texture:** The Texture Resource assigned to the image
  * **Blend Mode:** The blend mode of the image. Commonly used blend modes are Normal, Multiply, Overlay, Screen and Soft Light
  * **Alpha:** How transparent the image will be
  * **Depth Test:** Whether or not the image should test for depth for render order
  * **Open Full Inspector:** Open the `Inspector` panel for the material which this image is using.

* **Align to Camera:** Whether or not the image should always face the camera

* **Flip:** Allows you to flip the image either horizontally or vertically

Images that exists in the 3D Scene gives access to a `Pivot Position` field. Additionally, the `Pivot Presets` interface will automatically set the Pivot Position to commonly used pivots when clicked. These options will only appear when working with an Image without a Screen Transform.

![](data:image/png;base64,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)

### Stretch Modes[​**](#stretch-modes "Copy to clipboard")

Stretch Modes define how the image will fit to its bounding box. Below are the available Stretch Modes to choose from.

[](/img/lens-studio/image_image_fit.webm)

**Fill**

Fill will always fill the bounding box completely with the image. The image will extend pass the bounding box to maintain a complete fill. The image's aspect ratio is preserved.

[](/img/lens-studio/image_image_fill.webm)

**Stretch**

Stretch will always completely fill the bounding box with the image. It will stretch the image to fill the bounding box, distorting its aspect ratio.

[](/img/lens-studio/image_image_stretch.webm)

**Fit Width**

Fit Width will always fit the image within the width space of the box. The image can extend beyond the bounding box on the top and bottom. The image's aspect ratio is preserved.

[](/img/lens-studio/image_image_fit_width.webm)

**Fit Height**

Fit Height will always fit the image within the height space of the box. The image can extend beyond the bounding box on the left and right. The image's aspect ratio is preserved.

[](/img/lens-studio/image_image_fit_height.webm)

**Fill and Cut**

Fill and Cut works exactly like Fill but instead of letting the image extend beyond the bounding box, it crops the image to the bounding box.

[](/img/lens-studio/image_image_fill_and_cut.webm)

## Screen Transform[​**](#screen-transform "Copy to clipboard")

Screen Images always come with a Screen Transform component. The Screen Transform allows you to adapt screen attached UI to device resolution changes. Please refer to the [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) guide for a detailed walkthrough on the power of Screen Transform including some commonly used setups.

## Scripting Image[​**](#scripting-image "Copy to clipboard")

Below are some common scripting use cases for modifying Image programmatically.

### Set Texture[​**](#set-texture-2 "Copy to clipboard")

The script below will set the Image's texture.

```
// @input Component.Image image
// @input Asset.Texture texture
script.image.mainPass.baseTex = script.texture;
```

### Set Alpha[​**](#set-alpha "Copy to clipboard")

The script below will set the Image's alpha via the color parameter (without changing its color).

```
// @input Component.Image image
// @input float alpha = 0.5 {"widget":"slider", "min":0.0, "max":1.0, "step":0.01}
var currColor = script.image.mainPass.baseColor;
script.image.mainPass.baseColor = new vec4(
  currColor.r,
  currColor.g,
  currColor.b,
  script.alpha
);
```

### Set Color[​**](#set-color "Copy to clipboard")

The script below will set the Image's color.

```
// @input Component.Image image
// @input vec4 color {"widget":"color"}
script.image.mainPass.baseColor = script.color;
```
