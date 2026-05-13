# Face Landmarks

The Face Landmarks asset allows you to track 93 points on the face which we call [Face Landmarks](/lens-studio/features/ar-tracking/face/face-landmark.md). The asset also provides additional functions to attach objects, check the distance between points to trigger an effect.

[](/img/lens-studio/5-features/faceLandmarks-1.webm)

## Guide[​**](#guide "Copy to clipboard")

Find the `Face Landmarks` asset in the `Asset Library` and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets from the `Asset Library`.

Once you import the asset from `Asset Library`, you can find the package in the `Asset Browser`.

![](/assets/images/faceLandmarks-2-5ad52af30b79d845616b78cafb138899.png)

Follow the instructions and drag the prefab `Face Landmarks` into `Scene Hierarchy` under the main `Camera Object` to create a new `Scene Object`.

![](/assets/images/faceLandmarks-3-a4a6765a9142f0da33f546e56afd493a.png)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/faceLandmarks-4-93b6a678d91bf2bae2f1acff1a30c65d.png)

This asset comes with several helper scripts to help you to attach your objects to a single point or the center of multiple points. You can also use the distance between the points to create different interactions.

Take a look below for a description of each helper and information about their settings.

## Pin To Face Landmarks[​**](#pin-to-face-landmarks "Copy to clipboard")

![](/assets/images/faceLandmarks-5-52b041c6d604eb8d2816e5ea413a9245.png)

This is the main script of the asset which allows you to attach your object(s) to a single point or the center of multiple points.

[](/img/lens-studio/5-features/faceLandmarks-6.webm)

Since Face Landmark uses 2D space to track the points on the face we need to get the depth of each point with the help of the [Head Binding](/lens-studio/features/ar-tracking/face/head-attached-3d-objects.md) component.

This script gets the depth from Head Binding and then uses that to convert each point position from 2D transform into 3D transform. With that being said you need to always have a reference of `Head Binding` on the script.

![](/assets/images/faceLandmarks-7-74d48dff8548f22ee889941ed022f021.png)

If you want to learn more about how to convert 2D transform to 3D transform, please take a look at the [Screen Transform API](/lens-studio/api/lens-scripting/classes/Built-In.ScreenTransform.html) page.

To attach your objects to Landmarks, just place any content as a child of the `PinToFaceLandmarks` script in the `Scene Hierarchy` panel.

[](/img/lens-studio/5-features/faceLandmarks-8.webm)

The sections below walk through each customizable setting in the `PinToFaceLandmarks` script.

### Placement Mode[​**](#placement-mode "Copy to clipboard")

There are two options available for placing the objects on the Landmarks.

**Stick In Between Points:** This option attaches all the child content of the script to a Face Landmarks position.

![](/assets/images/faceLandmarks-9-aa6c95edf70197b8eb7193fce4de7ba7.png)

**Spawn At Each Points:** This option distributes the child objects along all the Face Landmarks points.

![](/assets/images/faceLandmarks-10-9bc4d774281a02a6b937e1a526840298.png)

### Points Mode[​**](#points-mode "Copy to clipboard")

Points refers to each placement of the landmarks as you can see in the diagram below:

![](/assets/images/face-landmarks_face-landmark-10-517debcb92a7a0bfcd38bbcb06f52fea.png)

There are two options available for selecting point(s):

**Custom Points:** In this option you can specify a specific point(s) for the object to be attached to. Take a look at the Face Landmarks diagram to find a desired point(s) and then add the number into the `Points` array input.

[](/img/lens-studio/5-features/faceLandmarks-11.webm)

If you put more than one point, it will find the center between points and place the content in the center.

**Predefined Points:** When predefined points are selected you will get a `Defined Points` dropdown. With this  drop down menu, you can select one of the options to attach the content to a desired place.

[](/img/lens-studio/5-features/faceLandmarks-12.webm)

Predefined points is just a short hand for a subset of the points available.

### Offset[​**](#offset "Copy to clipboard")

You can offset all of the child content from the Face Landmark point using the `Offset` input.

## FaceLandmarksDistanceTrigger[​**](#facelandmarksdistancetrigger "Copy to clipboard")

![](/assets/images/faceLandmarks-13-02c47a249d229aabec9d040a51dac4b1.png)

This is one of the helper scripts which allows you to trigger an action based on the distance of two points. You can use the output of the script to move, scale, rotate or change the opacity of an object. Additionally, you can also use it to  create custom face events such as eye blink.

Like before, to use the script, we need to specify the `Head Binding` so the script can access the landmarks.

The sections below walk through each customizable setting in the `FaceLandmarksDistanceTrigger` script.

### Getting Distance[​**](#getting-distance "Copy to clipboard")

The first thing we’ll do is  define two sets of landmarks to calculate distance from. Like before, you can use the `Points` mode to select between predefined points or you can have custom points.

This option is the same as `PinToFaceLandmarks` scripts. To learn more about it please read the guide above in the `PinToFaceLandmarks` section.

### Min Distance / Max Distance[​**](#min-distance--max-distance "Copy to clipboard")

With the two points specified, this script can provide raw values between two points.

You can easily see the raw distance on each frame with use of the `Print Distance` checkbox. By checking the checkbox, you can see the value in the logger panel.

If you don't see your logger, go to the Windows menu in the main bar of Lens Studio, then select Utilities and click on Logger.

![](/assets/images/faceLandmarks-14-cf6c39d5a178cef102a11fc9cd125c0a.png)

This value can be varied based on the points that you select. To make the values easier to use, we will convert the raw value to a value between 0 to 1 using the `Min Distance`and `Max Distance` values.

Min distance is the minimum distance between two points that we specify. For example, to find a minimum distance between upper and lower lips is to close your mouth and see the `Distance` value in the logger. That value is your `Min Distance` value.

The same way works for Max distance as well. For example, to find the maximum distance between upper and lower lips, open your mouth and see the `Distance` value in the logger. That value is your `Max Distance` value.

This workflow is not only for lips and can be applied to eyelids and more.

Depending on the user using the Lens, these values might be different so don’t choose an extreme value.

#### Smoothing[​**](#smoothing "Copy to clipboard")

By checking the `Smoothing` checkbox you can use the slider to make the value more smooth and less bumpy, but it may result in a delay.

### Custom Triggers[​**](#custom-triggers "Copy to clipboard")

You can enable the `Custom Trigger` option to specify a trigger that will occur when the distance hits the `Min Distance`, and when it hits the `Max Distance`.

You can use this custom trigger with [Behavior script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to create events and triggers that did not exist before in the Lens Studio! For example you can get the distance between two eyelids and create a blink trigger event.

You can choose a name for the `Min Trigger` to get called when the distance value is equal or less than the `Min Distance` number.

The same way also applies to `Max Trigger` which you can specify a name to get called when the distance value is equal or greater than the `Max Distance` that we explain earlier.

### FaceLandmarksDistanceResponse[​**](#facelandmarksdistanceresponse "Copy to clipboard")

![](/assets/images/faceLandmarks-15-2581b2014349ec4f85d9b4679258a87a.png)

This script allows you to get data from the `FaceLandmarksDistanceTrigger` and convert that value so you can apply the value to Move, Rotate an object, drive blend shapes, or make an object disappear and appear.

you can add more features to this script since this is just a JavaScript file and expand the script based on your needs.

The sections below walk through each customizable setting in the `FaceLandmarksDistanceResponse` script.

### Distance Script[​**](#distance-script "Copy to clipboard")

To make the script work, you need to have a reference to `FaceLandmarksDistanceTrigger` so this script can receive the values from that.

#### Mode[​**](#mode "Copy to clipboard")

There are three modes available.

**Transform Mode:**

This mode allows you to move or scale your object based on the values that received from the `FaceLandmarksDistanceTrigger`.

[](/img/lens-studio/face-landmarks_face-landmark-26.webm)

**Blendshape Mode:**

This mode allows you to drive a blendshapes based on the values from the `FaceLandmarksDistanceTrigger`.

[](/img/lens-studio/face-landmarks_face-landmark-28.webm)

**Opacity Mode:**

This mode allows you to make your object appear or disappear based on the values received from the `FaceLandmarksDistanceTrigger`.

[](/img/lens-studio/face-landmarks_face-landmark-30.webm)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
