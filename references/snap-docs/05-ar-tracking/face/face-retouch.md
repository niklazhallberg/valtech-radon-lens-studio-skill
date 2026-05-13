# Face Retouch

The `Face Retouch` object offers a number of features to retouch the user's face. These features include Soft Skin, Teeth Whitening, Eye Sharpening and Eye Whitening. In addition, the component provides an `ML Retouch` option automatically uses ML to add a subtle retouch effect.

[](/img/lens-studio/ML-face-retouch-0.webm)

## Create the Retouch[​**](#create-the-retouch "Copy to clipboard")

To create a `Face Retouch` effect, first click the "+" button in the `Scene Hierarchy` panel. Then, select `Face Retouch`. Once added, you should see a new `Face Retouch` object in your `Scene Hierarchy` panel.

![](/assets/images/face-retouch-add-4350161b88cd2577dd965452ef0d22cc.png)

## Visualize the Retouch[​**](#visualize-the-retouch "Copy to clipboard")

**Double-clicking** the Face Retouch object automatically opens the `Retouch Editor` panel to visualize the retouch effect.

![](/assets/images/face-retouch-panel-0ae6ee83b678f69bffef98d71d1bc68b.png)

## Using Retouch[​**](#using-retouch "Copy to clipboard")

In most cases you can use the default settings, which uses `Auto Mode` as well as `ML Retouch`.

![](/assets/images/face-retouch-default-8c7fdcf1f46579604ba3626713e0d2da.png)

However, in some cases you might want to configure your own retouch to convey a certain effect.

Select the `Face Retouch` object and configure it in the `Inspector` panel. Each `Retouch` feature has an `Enabled` boolean, which when checked enables the effect. Additionally, each feature has an `Intensity` slider, which determines how intense the effect is when applied to the face. Try to use low intensities to produce a more subtle effect.

[](/img/lens-studio/5-essential/face-retouch-configure.webm)

## Retouch Settings[​**](#retouch-settings "Copy to clipboard")

![](/assets/images/face-retouch-settings-c96c7f5fa19c7cb873d8b7b50bf2a557.png)

* **Face Index:** Which face the effect will apply to. The first face in the scene is 0; the second face in the scene is 1.

* **Auto Mode:** Whether the retouch should automatically be configured. When not enabled, you will have the following additional settings:

  <!-- -->

  * **Teeth Whitening:** Whitens the user's teeth when they open their mouth
    <!-- -->
    * **Intensity:** How strong the effect is.
  * **Eye Sharpening:** Sharpens the pupils of the user's eyes producing a much crisper reflection.
    <!-- -->
    * **Intensity:** How strong the effect is.
  * **Eye Whitening:** Whitens the white of a user's eyes which helps accentuate the pupils.
    <!-- -->
    * **Intensity:** How strong the effect is.

* **Auto Type:** Whether the retouch should use ML or not.
