# Lens Quality Assurance Troubleshooting

Every published Lens is put through a series of automated tests on a variety of device models. These tests will verify if your Lens runs smoothly to ensure it works for a wide variety of Snapchat users.

Occasionally, a Lens may fail testing due to a crash or performance issue that may not immediately apparent. Listed below are a series of different troubleshooting steps that can help you find these issues and ways to address the underlying cause.

#### Before you Start[​**](#before-you-start "Copy to clipboard")

* You should test your Lens on a physical device such as a smartphone or tablet. Lens Studio can catch some errors, but it is not able to detect every issue that occurs in Snapchat.

Please see our guide on [pairing your device to Lens Studio](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) if you don’t know how to push your Lens to Snapchat.

* You should test on a variety of phones if possible. If you only have a single device to test with, do not worry. It provides more opportunities to help to catch any bugs. Ideally, you will want to test with the following devices:

  <!-- -->

  * An Android and iOS device.
  * A phone that is a few years old.
  * A more recent phone.

## Basic QA troubleshooting[​**](#basic-qa-troubleshooting "Copy to clipboard")

In this section, you will learn some basic QA tests you can perform to help test Lens performance on your device. In order to perform the following tasks on your device, you will need to have your device paired to Snapchat and **Send Lens to Device.**

Please visit the [Performance and Optimization Details](/lens-studio/publishing/optimization/performance-optimization-guide.md) guide to learn more about how to optimize your projects for a variety of devices.

### Memory Usage[​**](#memory-usage "Copy to clipboard")

1. With your device paired to Snapchat, you can send your Lens to your device and tap the bug symbol at the top left to see your Lens performance.

   ![image alt text](/assets/images/lens-qa-troubleshooting-0-14975b045bf4c98a91b21d3514bc73f5.png)

2. You should pay attention to the RAM as you use your Lens.

3. Make sure to interact with your Lens similar to how you would expect a User to use.

   1. For example, press any buttons, play the game to the end, record a Snap.

If the memory usage goes over 275MB, it is likely to crash lower end devices.

**Recommendations**

* You should reduce the number of objects in your scene, especially resource intensive elements such as videos, textures, cameras, and highly detailed meshes.
* You can shrink the textures used within your Lens in another program and re-import them into your project, or use Lens Studio’s [Built-in compression](/lens-studio/publishing/optimization/overview.md#texture-compression) feature.
* Limit the number of segmentation or ML/custom component effects in your scene.
* If your Lens has VFX effects, such as particles, reduce the number of particles and adjust emitters to avoid particles overlapping.
* Limit the number of scripts utilizing the [Update Event](/lens-studio/features/scripting/script-events.md#scene-events).
* Avoid using scripts that repeatedly store large data like textures

### Repeated tapping[​**](#repeated-tapping "Copy to clipboard")

1. With the Lens pushed to your device, you should tap rapidly around the scene for a few seconds.
   <!-- -->
   1. Make sure to tap in varying places on the screen, except the Carousel or any of the Snapchat buttons on the edges of the screen.
2. If there is an issue, this tapping will cause the Lens to crash or return a script error.

**Recommendations**

* If the Lens crashes, it is likely an issue with memory usage.
* If you have a script that runs on tap, you should limit the number of objects created/ sounds played/or objects stored.

### Taking a Snap[​**](#taking-a-snap "Copy to clipboard")

1. With the Lens pushed to your device, you should record a video by holding the Snap button for a few seconds.
2. Snapchat should display the video shortly after.
3. If Snapchat freezes, there is likely an issue with your Lens.

**Recommendations**

* If the video freezes for a few seconds, it may be due to a memory issue.
* If Snapchat completely locks up, please reach out to Lens Studio support at <lensstudio-support@snapchat.com> and provide a copy of your project and steps to reproduce the issue.

#### Lens Startup[​**](#lens-startup "Copy to clipboard")

1. With the Lens pushed to your device, Select and deselect your Lens repeatedly in the Carousel.

   [](/img/lens-studio/lens-qa-troubleshooting-1.webm)

2. If Snapchat freezes, there is likely a performance issue with your Lens during startup.

**Recommendations**

* Limit the number of objects enabled when your Lens starts.
* Stagger the number of objects enabled during Lens start using a [behavior script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md#overview) or the [DelayedCallback event](https://developers.snap.com/api/lens-studio/Classes/Events#DelayedCallbackEvent)
* Reduce the number of unique objects and textures in your scene including elements imported as [Remote Assets](/lens-studio/features/lens-cloud/remote-assets-overview.md).
* Reduce the number of scripts running at `OnStart` and `OnAwake` Lens events.
  <!-- -->
  * Please visit [Script Events](/lens-studio/features/scripting/script-events.md#scene-events) to learn more.

### Swapping Cameras[​**](#swapping-cameras "Copy to clipboard")

1. With the Lens pushed to your device, you should swap between the front and back camera repeatedly.

You can easily swap cameras using the button found at the top right of your Lens.

![image alt text](/assets/images/lens-qa-troubleshooting-2-c2387e8beadb9518f33b07e8ca8a2def.png)

2. If Snapchat freezes, there is likely a performance issue with your Lens.

**Recommendations**

* Limit the number of objects enabled when changing cameras.
* Stagger the number of objects enabled using a [behavior script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md#overview) or the [DelayedCallback event](https://developers.snap.com/api/lens-studio/Classes/Events#DelayedCallbackEvent)

## Scripting QA[​**](#scripting-qa "Copy to clipboard")

Your Lens will be rejected in testing if one of your scripts produces a JavaScript error. If that happens, the testing system will provide an email with details on the error. However, your scripts may cause an error in the Lens engine that will not return a full error message. In those cases, please refer to this list of common scripting issues.

You can ignore this section if you did not add any custom scripts to your project.

### `Destroy()`[​**](#destroy "Copy to clipboard")

If a script tries to access an object that was already destroyed, it will return an error.

**Recommendation**

Add a check to any script that interacts with an object that might be destroyed.

Example:

```
if (!isNull(SceneObject)) {
  SceneObject.doSomething();
}
```

### `Script.provider.control.play()`[​**](#scriptprovidercontrolplay "Copy to clipboard")

Calling `play()` on a video/animation provider while it plays will return an error. Similarly, calling `stop()` on a stopped provider will also return an error.

**Recommendation**

Add a check before calling `play()` or `stop()` on a provider.

Example:

```
if (!provider.isPlaying()) {
  provider.play();
}
```

For more information, please see our documentation for the [VideoTextureProvider](/lens-studio/api/lens-scripting/classes/Built-In.VideoTextureProvider.html) and [AnimatedTextureFileProvider](/lens-studio/api/lens-scripting/classes/Built-In.AnimatedTextureFileProvider.html)

### Removing Components from an object or array[​**](#removing-components-from-an-object-or-array "Copy to clipboard")

Your Lens will return an error if a script tries accessing an array with an index that is too high. This can happen for many reasons but a common cause is removing objects from an array while looping through that array. An example would be the components inside of an object.

**Recommendations**

* Check the logic of any scripts that interact with arrays.
* Reversing the direction of your Loop if you are removing elements from your array.

### Face Landmarks[​**](#face-landmarks "Copy to clipboard")

A script can throw an error if it tries accessing face landmarks while a face is not detected

**Recommendation**

Add a check [`getFacesCount() > 0`](/lens-studio/api/lens-scripting/classes/Built-In.Head.html) before running the lines causing the error.

Example:

```
if (getFacesCount() > 0) {
  head.getLandmarks();
}
```

For more information, please see our documentation for the [Head Component](https://developers.snap.com/api/lens-studio/Classes/Components#Head).

## My Lens is Still Failing[​**](#my-lens-is-still-failing "Copy to clipboard")

If your Lens continues to get rejected after performing the steps provided in this guide, please reach out to Lens Studio support at <lensstudio-support@snapchat.com>. Please be sure to include your Lens ID with your request.

![image alt text](/assets/images/lens-qa-troubleshooting-3-f18e0e55dd6bb8f82f9f060efebd342b.png)
