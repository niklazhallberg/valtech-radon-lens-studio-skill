# Upper Garment Segmentation

The Upper Garment Segmentation allows you to replace a portion of upper garment with an image, 3D object, text or even a post effect. This asset comes with a helper script to allow you to design your content as well as track the content to the body.

[](/img/lens-studio/upper-garment-segmentation_1.webm)

## Guide[​**](#guide "Copy to clipboard")

Find the `Upper Garment Segmentation` asset in the `Asset Library` and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets from the `Asset Library`.

Once you import the asset from `Asset Library`, you can find the package in the `Asset Browser`.

![](/assets/images/upper-garment-seg-1-9a21223ca4b76340e094aa1586aafc43.png)

Follow the instructions and drag the prefab `Orthographic Camera` into Scene Hierarchy to create a new Scene Object.

![](/assets/images/upper-garment-seg-2-347a1b5458ee6b3858c77fcab6288b11.png)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/upper-garment-seg-3-095f625325536332713e230f4ea89c6e.png)

### Designing Upper Garment[​**](#designing-upper-garment "Copy to clipboard")

To make your objects appear on the garment, just place any content as a child of the `Garment Design [PLACE_ART_HERE]` under the `Orthographic Camera` in the `Scene Hierarchy` panel.

Take a look at the [Screen Image](/lens-studio/features/ar-tracking/body/segmentation/fullscreen-segmentation.md) and [Screen Text](/lens-studio/features/text/2d-text.md) guide to see some of the different types of content you can bring into your Lens.

Once you place an object as a child of `Garment Design [PLACE_ART_HERE]`, it will appear on the upper garment section of the body.

[](/img/lens-studio/5-features/upper-garment-seg-4.webm)

If the object is too big or too small, you can use the `Scene panel` to modify the transform of the object.

[](/img/lens-studio/5-features/upper-garment-seg-5.webm)

To display content on the garment, ensure the object’s alpha is enabled and that all child elements share the same layer as the `Orthographic Camera`. This asset includes a `DesignAttributeSetter` script—attached to the `Garment Design [PLACE_ART_HERE]` object—that automatically configures each child’s alpha and render layer. If you’d rather set layers manually, simply disable the script.

This asset comes with a helper script to help you design patterns for the upper garment segmentation, in the next section we will explain on how to use the helper script.

### Pattern Designer[​**](#pattern-designer "Copy to clipboard")

`PatternDesigner` script lets you easily design patterns and attach it to the body.

You can find this script attached to the `Pattern [EDIT_ME]` object under the `Garment Design` scene object. To modify the pattern first select the `Pattern [EDIT_ME]` scene object and modify the values in the `Inspector panel`.

![](/assets/images/upper-garment-seg-6-2318da384dbdd8e8c171a0995d1c40c8.png)

#### Background[​**](#background "Copy to clipboard")

To enable a solid background color, make sure the `Use Background Color` checkbox is checked. Once enabled, you’re able to tune the color and transparency.

#### Image[​**](#image "Copy to clipboard")

To place an image on top of the background, make sure the `Use Image` checkbox is checked.

#### Image Texture[​**](#image-texture "Copy to clipboard")

Once Use Image is checked, you’ll want to assign the image texture. To [add a texture](/lens-studio/assets-pipeline/importing-and-exporting-resources.md) to Lens Studio, drag and drop a PNG or JPG to the `Asset Browser` panel. Alternatively, select `+ -> Import Files` from the `Asset Browser` panel. Then, click the `Image Texture` field and assign it to your newly imported texture.

#### Image Transparency[​**](#image-transparency "Copy to clipboard")

You have control for how transparent your image will be via the `Image Transparency` slider.

#### Image Blend Mode[​**](#image-blend-mode "Copy to clipboard")

You can set your image blend mode using the `Image Blend Mode` drop down. Available blend modes are `Normal`, `Screen` & `Multiply`.

#### Fill Mode[​**](#fill-mode "Copy to clipboard")

You can set your image fill mode using the `Fill Mode` drop down.

#### Tiled[​**](#tiled "Copy to clipboard")

When the Tiled checkbox is selected, your image is tiled and you can easily design your pattern.

The following options in the `Inspector panel` allow you to configure the tiling.

* **Tile Density:** How dense the tiled pattern is. Smaller number = Bigger tiles. Bigger number = Smaller tiles
* **Animate:** If enabled, the tile pattern will play a scrolling animation
* **Animate Speed X:** How fast the tile pattern scrolls in the horizontal direction
* **Animate Speed Y:** How fast the tile pattern scrolls in the vertical direction

#### Transform[​**](#transform "Copy to clipboard")

You can use the slider to configure the pattern’s transform.

![](/assets/images/upper-garment-seg-7-87f58396c85a9f5975094ecd22fa5fd2.png)

You can also duplicate the script to create multiple patterns.

### Modify Segmentation Texture[​**](#modify-segmentation-texture "Copy to clipboard")

To modify what part of the image is segmented, modify the segmentation texture resource found in the `Asset Browser` panel. To do this, select the `upper_garment_segmentation [EDIT_ME]` object, and in the Inspector panel, modify its settings.

All of the segmentation textures can be inverted by enabling the `Invert` checkbox.

You can change how the borders of the segmentation looks by modifying the `Feathering` and `Refine Edge` option.

![](/assets/images/upper-garment-seg-8-eb48e2ba1380c7db84d1dcda29d175df.png)

### Modify Segmentation Post Effect Material[​**](#modify-segmentation-post-effect-material "Copy to clipboard")

This asset includes a custom material and helper script that extract the garment’s details—shadows, highlights, and wrinkles—and overlay them on your content for a more realistic look. To tweak the effect, select the `upper_garment_material [EDIT_ME]` available in the `Materials` folder in the `Asset Browser`, then adjust its settings in the `Inspector panel`.

[](/img/lens-studio/5-features/upper-garment-seg-9.webm)

### Tracking Controller[​**](#tracking-controller "Copy to clipboard")

This script helps you to track all your objects on the garment. To modify it settings first select the `Tracking Controller` under the `Orthographic Camera` in the `Scene Hierarchy` panel and modify the values in the `Inspector panel`.

![](/assets/images/upper-garment-seg-10-4f6c578474e45fe9d25d3224043d62a1.png)

#### Tracking[​**](#tracking "Copy to clipboard")

This option allows you to track selected objects on the body. The script uses body tracking as well as shoulder tracking to attach any object to the body. You can disable the tracking by unchecking the checkbox.

![](/assets/images/upper-garment-seg-11-c728edd232d86970aafa87762dc57616.png)

When Tracking is disable all the objects are not moving with the person anymore and it stays in world space.

#### Auto Optimize[​**](#auto-optimize "Copy to clipboard")

Tracking content to the body can be process heavy on older phones. This script provides an option to track how smooth Lens running on the phone and optimize the tracking based on the frame rate.

![](/assets/images/upper-garment-seg-12-31bee2cda9cc8efc0ba059d363e87235.png)

If the frame rate is lower than `Min FPS To Switch` slider, it will automatically switch to less process heavy tracking (Only shoulder tracking) and if the frame rate is above the number it uses body tracking.

#### Tracking Objects[​**](#tracking-objects "Copy to clipboard")

You can select and specify what objects are tracked to the body using the Tracking Objects. The `Garment Design [PLACE_ART_HERE]` object is already set as a tracking object to make the process easier.

![](/assets/images/upper-garment-seg-13-43843aaf26b1a440730efb9f1a1fef05.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
