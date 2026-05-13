# Footwear Segmentation

To make it easier for you to mix-and-match our different examples, this template has been converted to an importable asset in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) with the name `Footwear Segmentation Rainbow` and `Footwear Segmentation Black Light`.

The Footwear Segmentation template demonstrates some common use cases for footwear segmentation effects, emphasizing an egocentric view (a ‘point of view’ perspective of the user’s footwear).

The template contains two example effects (Rainbow, Blacklight) that can be enabled / disabled. Through these examples, we demo how to occlude footwear effects using lower garment segmentation.

[](/img/lens-studio/footware_segmentation_3.webm)

## Guide[​**](#guide "Copy to clipboard")

The Footwear Segmentation template has two main effects that sit within the main camera:

* **Rainbow:** a series of post effects including an outline animation, an animated texture and lower garment occlusion.
* **Black Light:** a series of post effects including an animated texture in the lower garment, a color gradient effect and tweens that cause all the effects to fade in. Additionally, in a separate orthographic camera, there is a **Hint**.

The hint exists within its own Render Target, which is set as the Live Render Target visible in the Scene Config menu. This is to ensure that while visible to the user, it will not be captured in snaps.

## Rainbow[​**](#rainbow "Copy to clipboard")

![](/assets/images/footware_segmentation_2-74801aabb54bdeddaeaac4d25486ab2b.png)

The **Darken Background** effect uses an inverted footwear segmentation texture, darkening everything around it.

The **Shoe Texture Animation** renders a 2D animated texture, masked by a footwear segmentation texture. The animation can be swapped by changing the post effect’s texture and can have its opacity modified by the alpha slider. The rainbow color effect creates a colorful overlay that transitions between rainbow colors through the Rainbow material.

![](/assets/images/footware_segmentation_1-747a26cfc7c1ff099ffa510850971cf3.png)

Try swap the Opacity Texture with the Footwear Inverted Segmentation Texture to see what happens. Also try swapping the Animation Texture for your own! If you want to use your own 2D animation, follow [this guide](https://developers.snap.com/lens-studio/references/guides/assets-pipeline/2d/2d-animation/#:~:text=Lens%20Studio%20allows%20you%20to,how%20often%20the%20animation%20plays.).

The **Outline Script** controls the *Rainbow Outline Material* animation within the Outline Effect post effect and can be disabled to maintain a static footwear outline. It contains multiple parameters. It contains inner and outer colors (Color 1 and Color 2) that the outline effect creates a gradient between, as well as a controller for the animation speed and outline distance. The Effect Type dropdown, provides 4 options:

* **No Effect:** simply transitions between the inner and outer colors when Color Swap Effect is selected.
* **Outwards:** increases the feather distance from the beginning of the footwear perimeter, until it reaches its maximum distance.
* **Inwards:** decreases the feather distance from the maximum distance to the footwear perimeter
* **PingPong:** that transitions inwards and outwards.

![](/assets/images/footware_segmentation_6-3d215ca50c3b5ad5f217b803a7a92b26.png)

These effects are determined by the OutlineEffectScript file. Try and chain multiple effects together in a new function and add it to the effectType input dropdown as well as to the corresponding value in the effects array.

The *Occlude Lower Garment* effect, uses the lower garment segmentation texture as an overlay, occluding the footwear segmentation effects.

## Black Light[​**](#black-light "Copy to clipboard")

Each Post Effect in the Black Light group is accompanied by a tween script that controls a ‘fade in’ effect triggered when the Lens starts.

![](/assets/images/footware_segmentation_5-f736d21f625dce2ae9c327856729e30e.png)

The Color Gradient effect overlays the Color Gradient Footwear material on top of the footwear, using the Footwear Segmentation opacity texture. Its gradient can be edited in the material editor.

![](/assets/images/footware_segmentation_4-4b254b337ad377bddb610573ffc80d15.png)

The *Darken Background* effect uses the *Footwear Inverted Segmentation* opacity texture to darken the area around the footwear and can be adjusted by the alpha slider.

The *Outline Light* layer uses the Pro Outline asset’s *Black Light Outline Material* whose color, feather start, opacity and feather distance values can be edited within the material editor.

The *Occlude Lower Garment* effect, uses a separate Color *Gradient Lower Garment* material to the initial *Color Gradient* layer, leveraging the lower garment segmentation opacity texture to occlude the footwear effect with the overlapping lower garment. The material gradient can be similarly edited in the material editor.

Try and change the graph parameter colors in the Color Gradient Footwear and Color Gradient Lower Garment materials to see what effect they have on your clothing color.

Finally, the *Lower Garment Texture Animation* post effect uses the lower garment segmentation opacity texture to overlay an animation on the user’s lower garment. The animation can be swapped out in the texture selector as well as the blend mode and opacity.
