# Face Occlusion and Features Segmentation

This guide demonstrates how to use the **Face Occlusion** Custom Component as well as the **Facial Features Segmentation** Custom Component. Both of these Custom Components allow the user to occlude AR face effects when a user places an object in front of their face.

This occlusion can increase the realism of the AR effect. For example, if the user was to put their hands in front of their face, it will will prevent the AR effect from breaking as the face effect gets overlaid on the hand.

[](/img/lens-studio/facial-features-segmentation-0.webm)

## Face Occlusion vs Facial Features Segmentation[​**](#face-occlusion-vs-facial-features-segmentation "Copy to clipboard")

At first, the Face Occlusion and Facial Features Segmentation Custom Components may appear to do the same thing, but there are some key nuances that differentiate the two Custom Components.

The primary difference between the two Custom Components is that the Face Occlusion Custom Component only has one output, while the Face Segmentation Custom Component has seven distinct outputs. The final output of the Face Occlusion Custom Component is a black and white image, where the white represents the area of the camera that contains a user's face, and the black is everything else. **Use the Face Occlusion Custom Component when you are making a face effect that applies to the user's entire face.**

![](/img/lens-studio/facial-features-segmentation-1.jpg)

Conversely, the Face Segmentation Custom Component outputs seven different Image Textures, each corresponding to a different element of a user's face:

* Beard
* Eyebrows
* Ears
* Eyes
* Face
* Lips
* Background

The Face Segmentation Custom Component has checkboxes for each of these face elements that you can turn on or off depending on the kind of effect you are looking to achieve. Use the Face Segmentation Custom Component when you are making a face effect that revolves around a specific part of the user's face.

![](/img/lens-studio/facial-features-segmentation-2.jpg)

## Getting the components[​**](#getting-the-components "Copy to clipboard")

In the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) find the components you'd like to use, and press the `Install` button to add the component to your Lens Studio.

| Face Occlusion                                                            | Facial Features Segmentation                                              |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| ![](/assets/images/face-occlusion-2-88b711e39f763655d477b42af036685d.png) | ![](/assets/images/face-occlusion-1-cc843e1737dc3807c250ab1b6630e3c8.png) |

## How to Set Up the Custom Components[​**](#how-to-set-up-the-custom-components "Copy to clipboard")

This section explains how to set up either the Face Occlusion and Face Segmentation Custom Components.

For this effect we need to use two separate Cameras:

1. An Orthographic Camera used to render the output of the Face Occlusion or Face Segmentation Custom Components.
2. An Perspective Camera for rendering face effects, which will be masked by the output of the Orthographic Camera.

### Setting up the Segmentation[​**](#setting-up-the-segmentation "Copy to clipboard")

Unlike other segmentations [which are full screen](/lens-studio/features/ar-tracking/face/face-templates/segmentation.md), Face Occlusion and Facial Features Segmentation are segmenting only the face, and thus needs to be modified to fill the whole screen. Let's take a look on how to do that.

In the `Scene Hierarchy` panel, press `+ > Screen Image`. This will add an Orthographic Camera to your Lens which can display images in the screen space.

![](/assets/images/face-occlusion-3-93519dfaa4a8c97ef2fb498016224dc7.png)

Next, select the `Screen Image` object. Press the `+ Add Component` to add either the `Face Occlusion` or the `Facial Features Segmentation` component.

| Face Occlusion                                                             | Facial Features Segmentation                                               |
| -------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| ![](/assets/images/face-occlusion-4a-f94eedb849ab1ef0f4a5a2de3c97d1a4.png) | ![](/assets/images/face-occlusion-4b-704aeeeedd71a7495de2b1393e5e60f5.png) |

In the `Preview` panel, you should notice that the parts of the face where we want the AR effect to be visible is white.

If you're using `Facial Features Segmentation`, make sure to toggle the segments that you want to show!

If you don't see a face, try switching the preview camera in the top right, or choosing a different preview video by pressing the drop down in the top-center of the `Preview` panel.

![](/assets/images/face-occlusion-5a-781f96611016a974c6f4504c8814e683.png)

Next, we can remove the default texture from the `Texture` field by right-clicking on the field, and choosing `Clear`. We'll also want the `Color` to be set to black (rgba: 0,0,0,1), so that by default we don't show anything (remember that white is where things should be visible.)

![](/assets/images/face-occlusion-5-1171d4183feed9f2c17194d792d0dea5.png)

Since we might want to render other things on the `Orthographic layer` (e.g. text, images on the screen), we can move our objects to a different layer. Select the `Orthographic Camera` object, and in the `Inspector` panel, in the `Camera` component, click on the `Layers` field, and create a new layer.

We renamed the render target to `Segmentation` to make it easier to understand.

![](/assets/images/face-occlusion-6-6003f3cbf570a064e023903ef9200383.png)

Now, we can select all the objects we want to be rendered by this camera (e.g. our component), and in the top right of the `Inspector` panel, choose the same layer that we chose in the camera.

| Before                                                                    | After                                                                     |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| ![](/assets/images/face-occlusion-7-8dd7c950ac2fb3c150991f0507ff021e.png) | ![](/assets/images/face-occlusion-8-a45f9345edf290d93891bcc693d2c870.png) |

Finally, we'll want our camera to target a new Render Target, which we can use ask as a mask for our main camera. In the `Asset Browser` panel, click `+ > Render Target`.

We renamed the render target to `Segmentation Target` to make it easier to understand.

![](/assets/images/face-occlusion-9-f96eb689c53cdce413de14be2a52983f.png)

Next, select the `Orthographic Camera`, and in the `Inspector` panel, click on the `Render Target` field, and select the newly added render target.

When you do this, our black and white texture will disappear, as it is now rendering onto a Render Target that is not being shown in the Lens!

![](/assets/images/face-occlusion-10-5a7e00820d9653a71bebd6d689f06558.png)

Similar to our image earlier, we will also want the new Render Target to have a black background. Select the new `Render Target` in the `Asset Browser` panel. Then, in the `Inspector` panel, choose `Color` as the `Clear Color Option`, and set the `Clear Color` to Black, with 100% opacity.

![](/assets/images/face-occlusion-11-99ddc7c63c3faca202199d19b2bc6678.png)

Finally, since we want our mask to be prepared before it is used, let's set this camera to the top of the render order. Select the `Scene` asset in the `Inspector` panel. Then, under `Render Order Config`, drag the handle on the left side of `Orthographic Camera` and drag it to the top.

[](/img/lens-studio/5-features/face-occlusion-12.webm)

#### Masking a camera with a texture[​**](#masking-a-camera-with-a-texture "Copy to clipboard")

Now that we have a render target displaying the segments that we want to show, we can use it as a mask on our rendering camera.

Select the camera you want to mask in the `Scene Hierarchy` panel. Usually, you will select the `Camera Object`. In the `Inspector` panel, click the `Mask Texture` field, and in the popup, choose your newly added Render Target.

![](/assets/images/face-occlusion-13-292400a1644c64488e560509020b0ea3.png)

### Testing the Occlusion[​**](#testing-the-occlusion "Copy to clipboard")

Now that we have our setup, let's see it mask our face effects!

For example, let's have it mask a [Face Mask](/lens-studio/features/ar-tracking/face/face-mask.md) effect.

In the `Scene Hierarchy` panel, click on the `+ > Face Mask`.

Face Mask itself can have its own mask (mapped to the face), and the texture overlaid on the face may not cover the area that the occlusion mask is covering.

![](/assets/images/face-occlusion-14-cd69da066f146051805bae027d6d523c.png)

Let's generate a texture that will provide a full coverage of the face mask and help us see how the mask is working. In the `Asset Browser` panel, press `+ > Generative AI > Texture`.

![](/assets/images/face-occlusion-15-1179d6c6bbf9ca8d9e5958749dbedd18.png)

For example, we can prompt for `Cheetah print`, then press `Apply` to import it into our project.

![](/assets/images/face-occlusion-16-dfd15a99e4b869ebf3293e49efc49154.png)

With the texture generated, select the `Face Mask` object again, and in the `Inspector` panel, click on the `Texture` field and choose the newly generated texture.

![](/assets/images/face-occlusion-17-857371877eb85b0d0f5a9598afeeccf5.png)

If you're using the `Face Occlusion` component, try using the `Webcam` option in the `Preview` panel and putting your hand over your face. Notice how the AR effect does not go on top of your hand.

If you're using the `Facial Feature Segmentation` component, try enabling the different checkboxes on the component, to see the texture come through.

[](/img/lens-studio/5-features/face-occlusion-18.webm)

### Debugging[​**](#debugging "Copy to clipboard")

In some cases, you might want to see the output of the `Segmentation Texture` render target.

The easiest thing to do, is to temporarily change your `Scene` asset so that the `Capture Target` field points to `Segmentation Texture`. This will tell the Lens to show the `Segmentation Texture` output, rather than the standard `Render Target` that our main camera is pointing to.

### Adding Another Orthographic Camera[​**](#adding-another-orthographic-camera "Copy to clipboard")

Alternatively, you may want to debug your texture by showing it on the screen along with your AR effect. Or, you want to add other screen element.

To do this, in the `Scene Hierarchy` panel, and select `+ > Orthographic Camera`.

Make sure nothing is selected in the `Scene Hierarchy` panel, so that Lens Studio doesn't try to make it a child of anything else.

With the new camera selected, you can add a `Screen Image` or whatever element you want to show. It's important to select the new camera when doing this, so Lens Studio knows which camera it should add to.

![](/assets/images/face-occlusion-20-0e734ee4a1a3100f9be50101f81d0651.png)

For example, we can change the new `Screen Image` object to the `Segmentation Texture` to show the output of the component. We can double-click on the new `Screen Image` object and move/resize it as usual in the `2D Editor` panel.

![](/assets/images/face-occlusion-21-bc1214373578613f9de6e58abefac1f0.png)

## Further Reading[​**](#further-reading "Copy to clipboard")

Since the texture generated from the component is converted into a `Render Target` and used as a mask for a `Camera` object, this mask will be applied to everything under this camera. This means that you can add other AR face effects as well!

If you do need to add other AR effects, which is NOT masked out, you can create another camera object (`Scene Hierarchy` panel > `+ > Camera`).

Try mixing and matching these various techniques to create a new Face Lens!
