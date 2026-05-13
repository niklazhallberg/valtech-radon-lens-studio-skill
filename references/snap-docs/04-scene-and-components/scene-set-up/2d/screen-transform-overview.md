# Screen Transform Overview

Screen Transform represents position, size, anchor and pivot information of a rectangle on the screen.

While Transform (Object position, rotation and scale) represents a single point, ScreenTransform defines a rectangle that contains 2D elements ([Screen Text](/lens-studio/features/text/2d-text.md), [Screen Image](/lens-studio/assets-pipeline/2d/image.md), or another Screen Transform)

Screen Transforms are usually used for the objects that exist in 2D space (are rendered to the Orthographic camera and are in Camera SceneObject Hierarchy). It is used to create complex layouts and supports various forms of scaling and anchoring based on a parent ScreenTransform. This is important and useful for creating UI for your Lenses that adapt to different device resolutions.

Before looking into Screen Transform Component you can get familiar with couple useful Pages:  [Screen Transform Properties](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-properties.md) and [Screen Region and Device Simulation](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-region-device-simulation.md)

## Screen Transform Component[​**](#screen-transform-component "Copy to clipboard")

ScreenTransform Component comes up with two modes - **Basic** and **Advanced**.

While advanced mode gives you full access to all [properties](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-properties.md), in Basic mode you have access to the limited amount of ScreenTransform properties, which does make sense for the particular case.

**ScreenTransform setup made in Basic mode has corresponding Setup in Advanced mode. But *not* vice versa.**

### Screen Transform, Basic[​**](#screen-transform-basic "Copy to clipboard")

`Basic` mode allows you to choose one from the most common setups using different combinations of buttons.

By default, Screen Transform opens to the `Basic` tab. The `Basic` tab allows you to tune if the 2D object is pinned to an edge and if it's set to fixed width or fixed height. These are relative to the parent's Screen Transform.

![](/assets/images/screen-transform-overview_st_basic_inspect-88b1ae69e157879acb4bc4ea21f7b751.png)

**Pin to Edge:** Anchor the edge of the rectangle to the edge of the parent, so that the rectangle’s position is controlled by a fixed size padding from that edge

* **Fix Size:** Lock the size of the rectangle at a fixed world unit size. You can lock width and height independently
* **Position:** When width or height of the rectangle is fixed but not pinned, this represents the shared values of Bounds. Controls the relative position of the Pivot within the parent rectangle on a -1 to 1 scale
* **Size:** The fixed size of the rectangle, see: Fix Size
* **Bounds:** The relative position within the parent on a -1 to 1 scale where this edge should be positioned
* **Padding:** The fixed distance from a parent edge the edge should be positioned when that edge is pinned. See: Pin To Edge
* **Pivot Position:** The point around which the rectangle should be rotated. The (0, 0) point for any child objects

Below are a number of common use cases for different Basic Screen Transform setups.

### Example 1 - Nothing selected[​**](#example-1---nothing-selected "Copy to clipboard")

![](/assets/images/screen-transform-overview_Screen-Transform-Sasic-Mode-default-9bd7407b337c37b874260c15299bf357.png)

When neither `Pin To Edge` nor `Fix Size` are selected - this means that total control on the ScreenTransform is taken by the Anchors. You can see only `Bounds` Setting available in the UI (which represents Anchors of the edges - their relative positions relative to Parent Screen Transform)

[](/img/lens-studio/screen-transform-overview_ScreenTransform-Basic-Default.webm)

### Example 2 - Pin To Edge (Edges)[​**](#example-2--pin-to-edge-edges "Copy to clipboard")

![](/assets/images/screen-transform-overview_Screen-Transform-pin-to-edge-37e5b0cadba807fcbe782ac6d33160a9.png)

When we select Pin to Edge - the distance from this Screen Transform edge to the parent screen Transform edge will stay the same and is not affected by the parent screen transform scale (You can see how red segments stay the same) We now have Padding property activated - that represents distance from the parent edge.

[](/img/lens-studio/screen-transform-overview_Screen-Transform-pin-to-edge.webm)

### Example 3 - Fixed Width and Fixed Height[​**](#example-3---fixed-width-and-fixed-height "Copy to clipboard")

![](/assets/images/screen-transform-overview_Screen-Transform-Fixed-size-35a22c39fe073d1943d79d4be10b0834.png)

In this example, we are placing a Screen Image on the screen and not pinning it. Because of this, it simply stays in the fixed local position of the parent.

We now have size property activated, and this Screen Transform’s size does not change as the Parent Screen Transform size changes.

[](/img/lens-studio/screen-transform-overview_Screen-Transform-Fixed-size.webm)

You can mix and match different settings for different edges and axes. Below are some common examples. Also don’t forget that the has its Stretch mode itself, that configures how the image will be displayed inside its screen transform.

You can use pixel units for width, height, and offset by using Camera and Overlay render target. [Learn More](/lens-studio/lens-studio-workflow/scene-set-up/2d/pixel-accurate-rendering.md)

### Example - Pin Corner + Fixed size[​**](#example---pin-corner--fixed-size "Copy to clipboard")

In this example, we are pinning a Screen Image to the top left corner of the screen. This for example would be used for a brand's logo. When pinned, notice that the offset from the top left corner will be maintained as the screen resolution changes. Next, the image is set to both Fix Width and Fix Height. Because of this, notice the pinned image's width and height remains the same (doesn't shrink or grow) as the screen resolution changes.

![](/assets/images/screen-transform-overview_Screen-Transform-Pin-Fixed-Size-0a53b0ae9bf25905882fafdb5f7be9cf.png)

[](/img/lens-studio/screen-transform-overview_Screen-Transform-Pin-Fixed-Size.webm)

### Example - Pin Banner to Top of Screen[​**](#example---pin-banner-to-top-of-screen "Copy to clipboard")

![](/assets/images/screen-transform-overview_Screen-Transform-Top-Banner-014bc72ab41d4feb21cb70dde59bfca5.png)

In this example, we are pinning a Screen image to the top, left and right edges of the screen. This for example would be used for a stretching banner. Because Fix Width is disabled, notice that the left and right edges of the Screen Image stretch to the changing screen resolution. But because Fix Height is enabled, the height of the Screen Image does not change.

[](/img/lens-studio/screen-transform-overview_image_st_pin_top_example.webm)

## Screen Transform, Advanced[​**](#screen-transform-advanced "Copy to clipboard")

For most Lens Creators, Basic mode will give you all the functionality you need to create responsive UI. That said, we also offer an Advanced mode that gives you full control of the Screen Transform's [properties](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-properties.md).

![](/assets/images/screen-transform-overview_Screen-Transform-Advanced-Tab-f6e6cd35dc0cf6ba2ddacd1e19f85143.png)

* **Pivot Position:** The point around which the rectangle should be rotated. The (0, 0) point for any child objects
* **Anchors:** The relative position within the parent on a -1 to 1 scale where this edge should be positioned
* **Offset:** After determining the edge positions based on Anchors/Bounds, apply these fixed world unit offsets to each edge position. Only differs from paddings in that: Paddings assume bounds position is -1 or 1, Offset is always positive right negative left, paddings are positive towards the center, negative towards the outside

### Example - Advanced Corner Pinning[​**](#example---advanced-corner-pinning "Copy to clipboard")

Also there is a helper UI that allows you to quickly set Anchors, Pivot and Offsets to one of the preset positions (TopLeft, TopCenter and etc.)

![](/assets/images/screen-transform-overview_Screen-Transform-Advanced-corner-pinning-f2f0cf715b2899460f076ddae6686c09.png)

* When neither **Set Pivot Position** nor **Set Object Position** are selected you can place the Anchors of Screen Transform to the one of the preset positions aligned with edges and center of parent Screen Transform.

[](/img/lens-studio/screen-transform-overview_Screen-Transform-Advanced-Anchors.webm)

* **Set Pivot Position:** When enabled, the pivot of this Screen Transform will also be placed at the desired corner or edge of this ScreenTransform along with the Anchors placed at the desired corner or edge of Parent Screen transform.

[](/img/lens-studio/screen-transform-overview_Screen-Transform-Advanced-Pivot.webm)

* **Set Object Position:** When enabled, the Object Position (offsets) will be automatically set to the interface's selected corner or edge along with the anchors.

## Scripting Screen Transform[​**](#scripting-screen-transform "Copy to clipboard")

Below are some common scripting use cases for modifying Screen Transform programmatically.

### Setting Anchors And Offsets[​**](#setting-anchors-and-offsets "Copy to clipboard")

```
// @input Component.ScreenTransform screenTransform
// @input vec2 bottomLeft = {-0.5, 0.5}
// @input vec2 topRight = {0,5, 0,5}
// @input float padding = 1.0
var anchors = script.screenTransform.anchors;
anchors.left = script.bottomLeft.x;
anchors.bottom = script.bottomLeft.y;
anchors.right = script.topRight.x;
anchors.top = script.topRight.y;
var offsets = script.screenTransform.offsets;
offsets.left = script.padding;
offsets.bottom = script.padding;
offsets.right = -script.padding;
offsets.top = -script.padding;
```

### Position[​**](#position "Copy to clipboard")

The script below will set the local position of the Screen Transform relative to the parent's pivot.

```
// @input Component.ScreenTransform screenTransform
// @input vec3 position
script.screenTransform.position = script.position;
```

### Scale[​**](#scale "Copy to clipboard")

The script below will set the local scale of the Screen Transform.

```
// @input Component.ScreenTransform screenTransform
// @input vec3 scale
script.screenTransform.scale = script.scale;
```

### Rotation[​**](#rotation "Copy to clipboard")

The script below will set the local rotation of the Screen Transform in the Z axis. Often for Screen Transform rotation, the only axis that makes sense to rotate is around the Z.

```
// @input Component.ScreenTransform screenTransform
// @input float rotation
var DEG_TO_RAD = 0.0174533;
script.screenTransform.rotation = quat.fromEulerAngles(
  0.0,
  0.0,
  script.rotation * DEG_TO_RAD
);
```

## Further Reading[​**](#further-reading "Copy to clipboard")

* [Screen Transform API](/api/lens-studio/Classes/Components.md#ScreenTransform) documentation.
* [Screen Transform Properties](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-properties.md)
* [Screen Transform Interactions](/lens-studio/features/scripting/touch-input.md#interactions-for-screen-transforms)
