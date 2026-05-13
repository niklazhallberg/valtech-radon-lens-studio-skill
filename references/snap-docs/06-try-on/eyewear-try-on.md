# Eyewear Try-On

With the Eyewear Try-On sample project, Lens Developers can create unique glasses AR Try-On experiences at professional level. The Eyewear Try-On sample project offers a quick way for you to get started with Glasses based Try-On experiences.

[](/img/lens-studio/eyewear-try-on03.webm)

This sample project is available on Lens Studio [Home Page](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md).

## Sample Project Walkthrough[​**](#sample-project-walkthrough "Copy to clipboard")

This sample project is set up so that for most things, almost no coding or additional setup is required.

Under `Template controls` Scene Object there are 3 scripts that help you set up the project:

### Effect Setup[​**](#effect-setup "Copy to clipboard")

This script controls adding standard effects that enhance overall visuals like face effects, color correction, rendering and toggling the new **Glasses Removal** component.

![](/assets/images/Eyewear_TryOn_1-e6ed38e5c33ab58316d1a0d350f090df.png)

[Light Estimation](/lens-studio/features/graphics/ml-environment-matching.md#dynamic-environment-map): The Dynamic Environment map generates an environment map in real time from some input – usually the Device Camera Input. This Dynamic Environment map will allow your object to receive lighting from the real world.

[Beautify](/lens-studio/features/ar-tracking/face/face-effects-overview.md#introduction): Adds simple facial effects like light morphine to the entire face area, light eye and lip augmentation, light soft skin and teeth whitening. Effects can be refined or removed by editing objects located under “EffectsBaseBeauty \[EDIT\_ME]” Scene Object.

**Smoothing**: Enable smoothing of face skin that is frequently used and removes skin features such as under-eye bruises and scars.

You can change the intensity of the effect by opening the material and changing “Base Color” parameter.

[Color Correction](/lens-studio/features/graphics/materials/post-effects.md#color-correction): enable color LUT effect. After enabling this effect, you can control it from two new parameters:

* Opacity: changes the mix of the color correction with original image.
* Texture: Add your own color correction instead of the default texture.
  <!-- -->
  * See the [color correction](/lens-studio/features/graphics/materials/post-effects.md#color-correction) docs for more information on how to make one.

![](/assets/images/Eyewear_TryOn_2-c6a5ca78b6b7830cbffd84585485d7a3.png)

**Glasses Removal**: This is a machine learning component that detects glasses in the frame and will produce a new image without them. This runs automatically, and currently will target regular glasses (not shaded). Use this feature to allow users wearing glasses to easily test the models you offer for try-on.

### Switching Items[​**](#switching-items "Copy to clipboard")

If you change the glasses 3D models (see below), make sure to change their reference in this script as well. It will connect these models to the Carousel UI and enable smooth toggling of different models.

![](/assets/images/Eyewear_TryOn_3-d8febc9add3145dbe649cb4b7faf84c2.png)

If you use visualization mode as well, copy from try-on will ensure visualization models will show in the same order when using the carousel.

### Visualization & Try-On[​**](#visualization--try-on "Copy to clipboard")

![](/assets/images/Eyewear_TryOn_4-17f39c295d189cf527872508bffbf870.png)

#### Visualization mode[​**](#visualization-mode "Copy to clipboard")

If **“Show Visualization”** is on, product visualization will show in cases no face was found or back camera is used (see Configuration below).

This mode allows users to rotate and get a better view of the product similar to holding it in their hands.

**Background**

**Blur background:** Use a blurred camera as the background.

**Use Texture:** Use custom texture as the background for the product visualization.

[](/img/lens-studio/eyewear-try-on10.webm)

#### Try-On mode[​**](#try-on-mode "Copy to clipboard")

If **“Show Try On”** is on, glasses will show on users face if one found or front camera is used (see Configuration below).

**Configuration**: If **Both** try-on and visualization are on, it’s possible to toggle try-on and visualization automatically when face is detected, or use front camera only for try-on and back camera only for visualization.

**Background**

**Blur background**: Use a blurred camera as the background.

**Use Texture**: Use custom texture as the background for try-on.

**Mask head sides**: Adds a 3D mask that will improve the occlusion of the glasses especially with hair and ears.

**Hand Occluder**: Use hand segmentation to occlude the glasses when hands are in front of the glasses, to increase the realism of the experience.

[](/img/lens-studio/eyewear-try-on11.webm)

### True Size Support[​**](#true-size-support "Copy to clipboard")

Usually, in Try-On mode, glasses automatically resize to match the user’s face. With **True Size** mode enabled, the glasses will keep their original 3D model size of 1 unit = 1 cm. This is useful in cases where it’s desirable to check fit.

To Enable "True Size", select **Visualization & Try-On** Scene Object in the `Scene Hierarchy` panel located under **Template Controls**

![](/assets/images/Eyewear_TryOn_5-3bc6e927ab8c3535bad97bd90d0c5c52.png)

Then select **Enable True Size**

![](/assets/images/Eyewear_TryOn_6-4b30ad444a79e04d27aa57eaffdddc0d.png)

**True Size** is only supported on Apple devices that support Face ID. Consult [this list](https://support.apple.com/en-us/HT209183) for supported devices.

## Importing and setting up new Items[​**](#importing-and-setting-up-new-items "Copy to clipboard")

If you have your own 3D model you would like to add to this template, please follow the standard steps to [import a new 3D model](/lens-studio/assets-pipeline/3d/importing-content/overview.md).

![](/assets/images/Eyewear_TryOn_7-5866f156c85f442f7245ed79f8eb10a6.png)

* After importing, add the model to the `Scene Hierarchy` panel under `Main Box` Scene Object.
* Adjust your new model transform so it is positioned and scaled correctly on the face occluder

![](/assets/images/eyewear-try-on06-ca8c9bfd24c95ea02e359baad0532949.png)

* In order to update the carousel UI, make sure to add your model to the correct place in the `Set Active Item` script. If you need more items, use the `Add Value` button.

[](/img/lens-studio/5-features/Eyewear_TryOn_8.webm)

* If you want to change the icons on the carousel, match the position of a new icon texture to the `Horizontal Carousel [EDIT_ME]` Scene Object. If you need more items, use the `Add Value` button

[](/img/lens-studio/5-features/Eyewear_TryOn_9.webm)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.

## What's Next?[​**](#whats-next "Copy to clipboard")

Now that you have learned about how to create your own Eyewear Try-On Lenses, take a look at some of the other AR Try-On examples.

* Check out the [Developing Fashion Lenses for Virtual Try-On using Lens Studio](https://ar.snap.com/en-US/intermediate-courses) course on how to make your own Fashion Lens.
* [Earring Try-On](/lens-studio/features/try-on/earring-try-on.md)
* [Garment Transfer](/lens-studio/features/try-on/garment-transfer.md)
