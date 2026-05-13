# Tracking Scope

## Introduction[​**](#introduction "Copy to clipboard")

What is "Tracking Scope"? Think of it as a capability that lets you specify where your effect should look for objects to track.

By default, effects typically track objects (like a [Body](/lens-studio/features/ar-tracking/body/object-tracking-3d.md), [Head](/lens-studio/features/ar-tracking/face/head-attached-3d-objects.md), or [Face Mesh](/lens-studio/features/ar-tracking/face/face-mesh.md)) using the live feed from the device's camera (often referred to as the `Device Camera Texture`).

But what if you want to apply an effect to a person in a photo or video from your [Camera Roll](/lens-studio/assets-pipeline/2d/media-picker-texture.md), or perhaps use input from a [Dual Camera](/lens-studio/features/camera/dual-camera.md) feature? This is where `Tracking Scope` is essential. It allows you to direct the effect to track objects within these alternative image or video sources instead of the live camera feed.

You can add `Tracking Scope` as an asset via the Assets Browser, making it available for various components and other assets.

* [Head Binding](/lens-studio/features/ar-tracking/face/head-attached-3d-objects.md)
* [Face Mesh](/lens-studio/features/ar-tracking/face/face-mesh.md)
* [Face Crop Texture](/lens-studio/features/snap-ml/ml-component/crop-textures.md)
* [Face Inset](/lens-studio/features/ar-tracking/face/face-inset.md)
* [Eye Color](/lens-studio/features/ar-tracking/face/eye-color.md)
* [Face Stretch](/lens-studio/features/ar-tracking/face/face-stretch.md)
* [Retouch](/lens-studio/features/ar-tracking/face/face-retouch.md)
* [Face Mask](/lens-studio/features/ar-tracking/face/face-mask.md)

...and others!

Let's see how you can use it!

## Using Tracking Scope with Face Inset[​**](#using-tracking-scope-with-face-inset "Copy to clipboard")

![](/assets/images/tracking-scope-inset-preview-e0550ad6e788ed28c6e0adefdf138f55.png)

Let's take the [Face Inset](/lens-studio/features/ar-tracking/face/face-inset.md) and enhance it by enabling it to work with photos and videos selected from the `Camera Roll`!

Our goal is to adjust the `Face Inset` so it tracks a mouth within a photo or video chosen by the user (via `Media Picker Texture`), instead of tracking from the live camera feed (`Device Camera Texture`).

To do this requires just three main actions:

1. On the `Face Inset` component, set its `Texture` property to use your [Media Picker Texture](/lens-studio/assets-pipeline/2d/media-picker-texture.md#create-the-media-picker-texture)

   ![](/assets/images/tracking-scope-media-picker-7575556935016a042959a19882181d09.png)

2. Select the `Tracking Scope` field of same `Face Inset` component. In the asset selector, press the `+` button to add the `Tracking Scope Asset`.

   [](/img/lens-studio/5-features/tracking-scope-add-tracking-scope.webm)

3. Finally, Within the Tracking Scope's properties, set its `Texture` property to use the same `Media Picker Texture` as in step 1.

   ![](/assets/images/tracking-scope-add-faceinset-fb7be2fe09966049be04c7adf3d58503.png)

Now, the `Face Inset` effect will track the mouth from the photo or video you select from your `Camera Roll` via the `Media Picker Texture`!

## Adding Tracking Scope to Media Picker Texture[​**](#adding-tracking-scope-to-media-picker-texture "Copy to clipboard")

In other cases, you may want to apply the AR effect on the Media Picker Texture itself. For example, you might want to add a [Face Mask](/lens-studio/features/ar-tracking/face/face-mask.md) on the user's camera roll.

1. Like before, you can add the Face Mask and change its `Tracking Scope` to use the `Media Picker Texture`.

   ![](/assets/images/tracking-scope-fm-90a90904e0a494d800104430357eb8c6.png)

2. Next, we will display the `Media Picker Texture` for the Face Mask to be applied on top of. In the `Scene Hierarchy` panel, press `+`, and select `Screen Image`.

   ![](/assets/images/tracking-scope-si-8b650e4e71d1ee8d8f844b0103193d3c.png)

3. Finally, we will display the Face Mask **after** the Screen Image. To do this, in the `Asset Browser` panel, select `Scene` and in the `Inspector` panel: drag the `Orthographic Camera` (which is displaying the Screen Image) above the `Camera Object` (which is displaying the Face Mask) in the `Render Order Config`.

   ![](/assets/images/tracking-scope-order-223f5ea838f960329235753605236c1e.png)

## Using Cameras for More Control[​**](#using-cameras-for-more-control "Copy to clipboard")

Since Tracking Scopes' data are relative to the texture, if you start moving the texture around, the Tracking Scope won't know that the underlying texture has moved.

To solve this, you can render the face effects on a separate camera (so the source texture and the tracking data are relative), then display the result of that camera anywhere you want!

This is similar to how if you move the `Device Camera Texture` on the screen, the AR effects won't line up to it.

![](/assets/images/tracking-scope-separate-cam-preview-2324c867bcc115e3fdf508ad5ab92a71.png)

### Setting up a Separate Camera[​**](#setting-up-a-separate-camera "Copy to clipboard")

First let's set up a seperate camera that will render the effects on our media picker texture.

1. In the `Objects` panel, press `+`, and add a new `Camera` to your Lens.

   ![](/assets/images/tracking-scope-camera-b04f5e09016784f0d62e74a80eeee5fd.png)

2. With the `Camera` object selected, in the `Inspector` panel, set the camera to be on, and view a different `Render Layer` so our AR effects won't be seen by multiple cameras simultaenously.

   ![](/assets/images/tracking-scope-layer-0ae2d96b8c622793f20195f9e54a1a95.png)

3. Set the camera to target its result to a seperate Render Target--in other words target its result to different texture which we can display in our final Lens. Select the `Render Target` field, and in the pop-up, press `+` > `Render Target`.

   ![](/assets/images/tracking-scope-rt-62c638bce3c833cf389f939be4bd8124.png)

4. Next, we can set the newly added `Render Target` to display the selected `Media Picker Texture`. Open the inline inspector next to the `Render Target` field:

   1. Set the `Clear Color Option` drop down to `Texture`.
   2. In the `Input Texture` field select `Media Picker Texture`.
   3. Make sure `Use Screen Resolution` is enabled to ensure that tracking aligns properly.

   ![](/assets/images/tracking-scope-rt-settings-17d6439020ce59e5b3ad863324f8744c.png)

You can make this Camera into a prefab (Right-click > Save as Prefab) so that you can edit this setup as a separate scene (double-click on the prefab in the `Asset Browser` panel, to modify only the prefab).

![](/assets/images/tracking-scope-cam-prefab-9f47ad8b71c07646e207ecdf8f56dd61.png)

### Displaying the Separate camera[​**](#displaying-the-separate-camera "Copy to clipboard")

Now, we can display the result of this camera into our final Lens.

1. Create a `Screen Image` to display the Render Target we created earlier. To do this, in the `Scene Hierarchy` panel, press the `+` and choose `Screen Image`.

   ![](/assets/images/tracking-scope-si-2-96b71fcc9fd4575ccb21b4648e960e01.png)

2. With the newly added `Screen Image`, in the `Inspector` panel set the `Texture` field to be the Render Target we created earlier.

   ![](/assets/images/tracking-scope-si-preview-b7f0c0e1f2959bbc0dc2a6f00c3ed62a.png)

You should now see a media picker selector in the `Preview` panel. You can select any image, and it should display in your Lens!

You can double-click on the `Screen Image` object to open the `2D Editor` panel, and move your texture around.

![](/assets/images/tracking-scope-2d-editor-1503474981c4cea8d0ea2564393956fb.png)

### Adding Effects to the Separate Camera.[​**](#adding-effects-to-the-separate-camera "Copy to clipboard")

Finally, we can apply our affects separately in this camera.

1. Like before, we can add a `Face Mask` and set its `Tracking Scope` to point to the `Media Picker Texture`.

   ![](/assets/images/tracking-scope-face-mask-6a05ac1a11bdd610fe3460a241a252f0.png)

2. Since our camera is rendering a different layer, make sure to set your `Face Mask` is on the same layer. In other words, the colored dots in the `Scene Hierarchy` panel matches.

   ![](/assets/images/tracking-scope-dots-b55f9f7a4a9b5b5ea48e06d419f3493e.png)

### Changing the Separate Camera's characteristic[​**](#changing-the-separate-cameras-characteristic "Copy to clipboard")

In some AR effects, the camera's characteristics need to be changed to match the texture that it's rendering on top off.

For example: Since [Face Mesh](/lens-studio/features/ar-tracking/face/face-mesh.md) is a 3D effect, the camera needs to have the same FOV as the input texture.

To do this: select the camera, and in the `Device Properties Source` field, select the same `Tracking Scope` as the one that you used in your effect.

![](/assets/images/tracking-scope-set-cam-prop-4456bd90a16409b66eebd8e5950ef8b9.png)

## Next Steps[​**](#next-steps "Copy to clipboard")

The Tracking Scope can also be applied to other textures. Here are some ideas you can try exploring:

* Use the `Tracking Scope` on a video texture
* Use the `Tracking Scope` on the `Reverse Camera Texture` to apply different face effects on the front and back camera simultaenously.
* You can use multiple `Tracking Scope` simultaenously. For example: you can apply different effects simultaenously on the front camera, rear camera, and a media picker texture.

Beyond using Tracking Scope to track different sources, you can also use Tracking Scope to point multiple trackers to the same context. For example to ensure that an affect is applied to the same person (same face and body). Take a look at the [Person Tracking Scope Guide](/lens-studio/features/ar-tracking/body/consistent-face-and-body-tracking.md) to learn more!
