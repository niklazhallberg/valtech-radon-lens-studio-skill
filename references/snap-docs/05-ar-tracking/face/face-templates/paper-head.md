# Paper Head

The Paper Head example lets you create a customizable head that reacts to facial movement. The example tracks the user’s eyes, mouth and the direction the head is facing to drive 2D textures and 2D animations.

[](/img/lens-studio/paper-head_paper_head_template_example.webm)

## Guide[​**](#guide "Copy to clipboard")

### Getting the example[​**](#getting-the-example "Copy to clipboard")

Find the `Paper Head` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/paperhead-1-ea95b8b6ea6e9de354975d90ef8c87d8.png)

Follow the instructions and drag the prefab `Paper Head` into Scene Hierarchy to create a new Scene Object.

[](/img/lens-studio/5-features/paperhead-2.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

### Select Paper Head Controller[​**](#select-paper-head-controller "Copy to clipboard")

To edit the Paper Head example, first select the `Paper Head Controller [Edit Me]` object in the `Scene Hierarchy` panel on the left side of Lens Studio. With the object selected, we can configure its settings in the `Inspector` panel.

![](/assets/images/paperhead-3-162effce822b3b71a8db686df89658bf.png)

### Add Resources[​**](#add-resources "Copy to clipboard")

For the Paper Head example, we should first import your 2D textures or animations into the `Asset Browser` panel that you want to apply to the face. To do this, drag and drop a `PNG`, `JPG` or `GIF` into the `Asset Browser` panel from your computer.

[](/img/lens-studio/5-features/paperhead-4.webm)

Learn more about importing in the [2D Asset](/lens-studio/assets-pipeline/2d/image.md) guide.

### Configure Mouth[​**](#configure-mouth "Copy to clipboard")

There are three different ways to animate the mouth based:

1. **Texture Sequence:** You have multiple images for various "open-ness" of the mouth.
2. **Animated Texture:** You have an animated image (e.g. gif) where each frame will represent various "open-ness" of the mouth.
3. **Sliding Mouth:** You have two image, where one image will represent the jaw and will move based on the "open-ness" of the mouth. The Mouth Face element has three different types of Mouths selectable via the Mouth Type drop down.

![](/assets/images/paperhead-5-1e613db7805da82e9904b9fc629bef00.png)

The sections below walk through each Mouth Type.

#### Texture Sequence[​**](#texture-sequence "Copy to clipboard")

In this Mouth Type, the `Mouth Textures` array is filled with various textures that represent a mouth starting as closed and ending as opened. As the user opens their mouth, the Texture Sequence will select an image for the mouth based on how wide the mouth is opened. Fill the `Mouth Textures` fields to your own custom textures. Press the `Trash` icon to remove frames and the `Add Value` button to add frames.

[](/img/lens-studio/5-features/paperhead-6.webm)

#### Animated Texture[​**](#animated-texture "Copy to clipboard")

In this Mouth Type, an animated texture of a mouth is played back based on how open the user’s mouth is. Set the `Animated Texture` field to your own custom animated texture. For more information on importing a 2D Animation, follow the [2D Animation](/lens-studio/assets-pipeline/2d/2d-animation.md) guide.

[](/img/lens-studio/5-features/paperhead-7.webm)

#### Sliding Mouth[​**](#sliding-mouth "Copy to clipboard")

The last Mouth Type is unique to Mouth. It requires two textures. One texture of the entire head and another texture of the lower jaw. In creating these textures, think of a ventriloquist’s puppet.

In the `Inspector` panel, set the `Head Texture` field to your custom head texture and the `Mouth Texture` field to your custom mouth texture. The Mouth Texture will slide based on the user’s mouth movement. The `Mouth Offset` and `Slide Amount` can be configured in the `Inspector` panel via the corresponding sliders.

[](/img/lens-studio/5-features/paperhead-8.webm)

Below is an example of a Head Texture (without mouth) and the Mouth Texture (without head).

![](/assets/images/paper-head_cat_texture_head-501b9f5827277d11301c52255e2622bc.png) ![](/assets/images/paper-head_cat_texture_mouth-30a22da070eedc362e34a6dec11c17a0.png)

#### Tuning the Mouth[​**](#tuning-the-mouth "Copy to clipboard")

Each mouth type has sliders to tune the mouth.

![](/assets/images/paperhead-9-af309b53258e4d1694f0a12be5e27d2d.png)

* **Size -** How big the mouth is
* **Offset X -** The offset of the mouth horizontally
* **Offset Y -** The offset of the mouth vertically
* **Rotate -** Apply a rotation to the mouth if needed
* **Alpha -** How transparent the mouth is
* **Flip Image -** Will mirror the texture horizontally
* **Flip With Head -** Based on the direction the head is facing, the texture will flip to face that direction. This gives the 2D texture a quasi 3D effect

### Configure Nose[​**](#configure-nose "Copy to clipboard")

Enable the `Nose` by checking the Nose checkbox. Unlike the mouth, it does not have different Types. That said, if you do want an animated nose, the `Nose Texture` field does support an animated texture. The tuning settings as described in the Mouth section above (Size, Offset, Rotation, Alpha, Flip Image and Flip With Head) are also available for Nose.

[](/img/lens-studio/5-features/paperhead-10.webm)

We recommend using the `Flip with Head` option on the Nose to give it an effect that responds to facial movement

### Configure Eyes[​**](#configure-eyes "Copy to clipboard")

Enable the `Left Eye` or `Right Eye` by checking the `Left Eye` or `Right Eye` checkbox.

Like the mouth, the Eyes both support the `Texture Sequence` and `Animated Texture` types which are selected from the `Eye Type` drop down. The tuning settings as described in the Mouth section above (Size, Offset, Rotation, Alpha, Flip Image and Flip With Head) are also available for Left and Right Eyes.

![](/assets/images/paperhead-11-c5ffd46be057dc544a2a48adf1528cd7.png)
