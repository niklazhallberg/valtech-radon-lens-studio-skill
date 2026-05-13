# Marker Tracking

[](/img/lens-studio/marker-tracking_marker_guide_intro.webm) [](/img/lens-studio/marker-tracking_marker_guide_intro_snapcode.webm)

Lens Studio’s Marker Tracking gives you the ability to a Lens which tracks content to a unique physical image. Marker Tracking is ideal for Lenses which are meant to be used in the presence of a custom image. For example, you can create a Lens that places an animated 3D character overlaid on a poster or mural of your own design. You can also set up a Marker Tracking Lens to detect and track Snapcodes.

This guide covers how to create a custom tracking Marker and include it in a Lens.

## Creating a Marker Tracking Lens[​**](#creating-a-marker-tracking-lens "Copy to clipboard")

This section covers how to create a Marker Tracking Lens in a new project. You can also follow these steps to add Marker Tracking to an existing Lens.

There are several assets in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) that can help you create your marker Lens including: `Marker Tracking Helper`.

### Prepare an Image for Tracking[​**](#prepare-an-image-for-tracking "Copy to clipboard")

If you're planning to use a custom image as a tracking marker, keep the following guidelines in mind to make sure that it will have smooth and accurate tracking:

* Make sure your image has a lot of detail and contrast
* Avoid repetitive patterns
* Avoid low resolution images
* Use a `PNG` or `JPG` with a resolution of 2048 x 2048 or less

Here is an example of a bad marker. Notice the low contrast and high repetition.

![](/img/lens-studio/marker-tracking_marker_bad_example_2.png)

Here is an example of a good marker for mobile, but NOT for Spectacles. This image has a lot of detail, constrast, and doesn't contain a repeating pattern. However, because the image is highly detailed, it won't work as well when tracking from far away, or when the camera has a wide FOV, such as Spectacles.

![](/img/lens-studio/marker-tracking_image_marker_source.png)

Here is an example of a great marker. This image has a lot of details, contrast, and doesn't contain a repeating pattern. Additionally, there are high constrasting features from both close and far away (e.g. the rocket is distinguishable from the planets, and even within the planets, there are distinguishible features).

![](/img/lens-studio/marker-tracking-image-planets.png)

You can download these images to see the full size resolution.

### Create a New Project[​**](#create-a-new-project "Copy to clipboard")

Create a new project by selecting `File -> New Project` from the Lens Studio menu.

![](/assets/images/marker-tracking_general_marker_7-9cf3dd7a3d9f180e94372a76fd58e1ba.png)

### Create a Marker Tracking Object[​**](#create-a-marker-tracking-object "Copy to clipboard")

Marker Tracking requires a Marker Tracking object to be added to your Scene. Your Lens can use either Image Tracking or Snapcode Tracking.

#### Adding Image Tracking[​**](#adding-image-tracking "Copy to clipboard")

To set up your Lens to track a custom Image:

1. In the `Scene Hierarchy` panel, select `+ -> Image Tracking`

   ![](/assets/images/marker-add-marker-8c992b634ae44a0cac041b414281b634.png)

   You can also do this manually by adding a scene object under a camera, then selecting the newly added object, and finally adding a `Marker Tracking` component in the `Inspector` panel.

   You can also get a setup with the example image marker by searching for `marker` in the Asset Library!

   You can also do this manually by adding a scene object under a camera, then selecting the newly added object, and finally adding a `Marker Tracking` component in the `Inspector` panel.

2. Select a custom image file from your computer and select `Open`

3. In the `Scene Hierarchy` panel, you should now see an `Image Tracking` object parented to your main `Camera` object

   ![](/assets/images/marker-image-marker-26fa71cbe38ec557b7c1df51d84ed7f3.png)

4. In the `Asset Browser` panel, you should now see an `Tracking Marker` resource

   ![](/assets/images/marker-asset-browser-d5eeb7b92fc3d4051341fb00611ff1ec.png)

5. Select the newly created `Tracking Marker` resource in the `Asset Browser` panel

6. In the `Inspector` panel, note the `Marker Height` field. You should set it to match the expected vertical size of the physical image, in centimeters (cm). For example, if you are planning to create a Lens which tracks content to a printed sticker that’s 8 cm in the vertical dimension, you should set your Image Marker’s`Marker Height` to 8.0.

   ![](/assets/images/marker-marker-height-63f8bc517c25b1a1a38dd82fe26fac89.png)

#### Adding Snapcode Tracking[​**](#adding-snapcode-tracking "Copy to clipboard")

1. In the `Scene Hierarchy` panel, select `+ -> Snapcode Tracking`

   ![](/assets/images/marker-snapcode-marker-355e2c7a8b42f0ded503c749733fda50.png)

2. In the `Scene Hierarchy` panel, you should now see a `Snapcode Tracking` object parented to your main `Camera` object

   ![](/assets/images/marker-scene-snapcode-5c34713dd20bbab5bfefefae1c629651.png)

3. In the `Asset Browser` panel, you should now see a `Snapcode Marker` resource

4. Select the newly created `Snapcode Marker` resource in the `Asset Browser` panel

5. In the `Inspector`, note the `Marker Height` field. You should set it to match the expected vertical size of the physical Snapcode, in centimeters (cm). For example, if you are planning to create a Lens which tracks content to a printed sticker that’s 8 cm in the vertical dimension, you should set your Snapcode Marker’s `Marker Height` to 8.0.

   ![](/assets/images/marker-snapcode-height-2e991bc8b5e8fcb973131c8536cc3dfa.png)

Image Tracking and Snapcode Tracking objects must be parented to your Scene's main Camera in order to track properly.

You can include up to 10 Marker images in a Lens, as well as a Snapcode Tracking objects to your Scene. For image tracking, only one image will be tracked at a time. For Snapcode tracking, only one Snapcode will be tracked at a time. That said, a single image and a single Snapcode can be tracked at the same time.

#### Orienting the Marker Tracking Object[​**](#orienting-the-marker-tracking-object "Copy to clipboard")

By default, the Marker Tracking object is created in a vertical orientation. However, since objects are simply tracked to the marker image, if a marker is oriented horizontally in Lens Studio, it will still track that same image when it is vertical in real life.

Since objects are simply tracked to the marker image, if a marker is oriented horizontally in Lens Studio, it does not mean that it will not track that same image when it is vertical in real life. Orienting your marker in Lens Studio simply helps your development process.

### Placing Content[​**](#placing-content "Copy to clipboard")

Any content you want to track to your marker should already be [imported to your Scene](/lens-studio/assets-pipeline/importing-and-exporting-resources.md) and set up as a Scene Object. This Scene Object should be parented to the Marker Tracking Object you created in the previous section.

To set up your content:

1. In the `Scene Hierarchy` panel, select the Scene Object you want to track to the Marker

2. Click and drag the Scene Object so that it’s parented underneath the `Marker Tracking` object you created

   [](/img/lens-studio/5-essential/marker-drag-under.webm)

3. In the `Scene` panel, align the Scene Object’s position with the position of the `Marker Tracking` object

   [](/img/lens-studio/marker-tracking_marker_guide_align_content_object.webm)

4. Scale the Scene Object as you see fit. Remember that the `Marker Height` property you set on the Marker resource represents the size in centimeters in physical space. You can use its size as a relative guide for scaling your content

   [](/img/lens-studio/marker-tracking_marker_guide_scale_content_object.webm)

To learn more about importing 2D and 3D content to your Scene, visit the Lens Studio guide on [Importing and Updating Resources](/lens-studio/assets-pipeline/importing-and-exporting-resources.md).

## Previewing The Lens[​**](#previewing-the-lens "Copy to clipboard")

To properly preview your Marker Tracking Lens in the `Preview` panel, you’ll need to import a video of your Marker. To import a video file from your computer:

1. Select the dropdown at the top of the `Preview` panel

   ![](/assets/images/marker-change-preview-d1a71334cdd7c8c0724726dfa47f8edd.png)

2. Select `+ From Files` at the bottom of the dropdown

   ![](/assets/images/marker-import-file-587324ee2a3733fad5b24f4ea1c705f0.png)

3. Find the video file and open it

4. In the `Preview` panel, the video you imported should automatically be selected.

   ![](/assets/images/marker-select-myvideo-3af76703c93fb6cdd2622dd8312a0099.png)

5. You should now see your video playing in the `Preview` panel. Your content should be aligned to the Marker when it’s on screen.

## Additional Information[​**](#additional-information "Copy to clipboard")

### Marker Resources[​**](#marker-resources "Copy to clipboard")

Marker Tracking requires a Marker resource. The Marker resource defines the target image the Lens should track, as well as is expected physical size. There are two types of Marker resources: Image Marker and Snapcode Marker.

![](/assets/images/marker-both-assets-9066c70bfc34ea93f344332ebeda4b5d.png)

While a Marker Resource is created automatically when you add an Image Tracking or Snapcode Tracking object to your Scene, you can also create one manually.

#### Creating an Image Marker Resource[​**](#creating-an-image-marker-resource "Copy to clipboard")

![](/assets/images/marker-image-asset-6d55a554a03c583dcbad35a573d5d795.png)

If you want your Lens to track a specific image, you can create an Image Marker.

To create an Image Marker:

1. In the `Asset Browser` panel, select `+ -> Image Marker` to create the marker asset.

2. [Import](/lens-studio/assets-pipeline/2d/image.md) your texture into Lens Studio.

3. Select the newly created `Image Marker` resource in the `Asset Browser` panel. In the Inspector panel, select the `Marker Texture` field and choose the texture you've imported that you want to track.

4. In the Inspector, note the `Marker Height` field. You should set it to match the expected vertical size of the physical image, in centimeters (cm). For example, if you are planning to create a Lens which tracks content to a printed sticker that’s 8 cm in the vertical dimension, you should set your Image Marker’s `Marker Height` to 8.0. By doing this, the transform of this object will be scale accurate (i.e. 1 unit in the `Transform` component will represent 1cm.)

#### Creating a Snapcode Marker Resource[​**](#creating-a-snapcode-marker-resource "Copy to clipboard")

![](/assets/images/marker-snapcode-asset-e275d6c8d0d22eb5315a23b592a7a6a7.png)

If you want your Lens to track Snapcodes, you can create a Snapcode Marker.

To create a Snapcode Marker:

1. In the `Asset Browser` panel, select `+ -> Snapcode Marker`

2. Select the newly created `Snapcode Marker` resource in the `Asset Browser` panel

3. In the `Inspector`, note the `Marker Height` field. You should set it to match the expected vertical size of the physical image, in centimeters (cm). For example, if you are planning to create a Lens which tracks content to a printed Snapcode that’s 8 cm in the vertical dimension, you should set your Snapcode's `Marker Height` to 8.0
