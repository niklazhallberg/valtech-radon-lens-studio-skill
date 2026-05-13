# Body Instance Segmentation

Body Instance Segmentation Texture provides a detailed mask for a specific person in the camera view. The person is defined by `bodyIndex` property, which is consistent with other human tracking features (such as body tracking, body mesh, body depth and normals).

Currently Body Instance Segmentation Texture supports up to two different person instances.

In the example below, the left image shows two predicted masks: one in blue and the other in orange. The middle and right images show each mask separately. White pixels indicate areas that belong to the mask, while black pixels show areas that do not.

![](/img/lens-studio/body-instance-segmentation-3.png) ![](/img/lens-studio/body-instance-segmentation-2.png) ![](/img/lens-studio/body-instance-segmentation-1.png)

## Add a Segmentation Texture[​**](#add-a-segmentation-texture "Copy to clipboard")

To add a new Body Instance Segmentation Texture, select `+ -> Body Instance Segmentation Texture` from the `Asset Browser` panel. Then, with the `Body Instance Segmentation Texture` selected in the `Asset Browser` panel, specify the `bodyIndex` parameter in `Inspector` panel.

![](/img/lens-studio/body-instance-segmentation-0.png)

## Examples[​**](#examples "Copy to clipboard")

As any other [full screen segmentation](/lens-studio/features/ar-tracking/body/segmentation/fullscreen-segmentation.md) texture Body Instance Segmentation Texture can be used as an opacity texture in various materials and VFX and displayed through Screen Image, Post Effect, VFX components, etc, as well as used as Camera Mask Texture. Check out `Two Persons Segmentation` asset on Asset Library for examples.

[](/img/lens-studio/body-instance-segmentation-5.webm)
