# Animated Object

The `Animated Object` asset demonstrates an easy way to add and interact with 3D models into the world. The asset is a great way to get into the [Interaction](/api/lens-studio/Classes/Components.md#interactioncomponent) component.

## Guide[​**](#guide "Copy to clipboard")

Find the `Animated Object` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

### Animated Object Package[​**](#animated-object-package "Copy to clipboard")

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/animated-object-import-package-0456faccc20bbaeb10cc31a1f2642783.png)

Follow the instructions. Click on the `Camera Object` and add a [`Device Tracking`](/lens-studio/features/ar-tracking/world/tracking-modes.md) Component with default `Surface` tracking mode.

[](/img/lens-studio/5-features/animated-object-add-device-tracking.webm)

In the Preview Panel, click on the `Switch To Back camera` button to switch to world side preview.

[](/img/lens-studio/5-features/animated-object-switch-camera.webm)

Then drag the prefab `Animated Object__PLACE_IN_SCENE` into Scene Hierarchy to create a new Scene Object.

[](/img/lens-studio/5-features/animated-object-drag-prefab.webm)

Attach the `Camera Object` to each WorldObjectController script.

[](/img/lens-studio/5-features/animated-object-attach-camera-to-scripts.webm)

In the Preview Panel, click on the `Refresh` button and try to drag the animated objects around.

[](/img/lens-studio/5-features/animated-object-drag-around.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

The asset comes with two objects by default that you can move independently. Notice that they are identical except for the `ADD_TO_SCENE` objects. You can delete or duplicate these examples as needed.

### Exporting 3D Content[​**](#exporting-3d-content "Copy to clipboard")

The `Animated Object` asset assumes that you have a 3D animated object which you'll be importing into Lens Studio. First you must export your object to be Lens Studio ready. To do this, follow the [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guide.

### Importing 3D Content[​**](#importing-3d-content "Copy to clipboard")

Once you have your 3D object exported, follow the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide to import your 3D object into Lens Studio.

### The World Object Controller Setup[​**](#the-world-object-controller-setup "Copy to clipboard")

The World Object Controller takes care of some of the most common tasks you will want to do when adding objects to the world

* Hides any child object when you are in the front camera, and enables it on rear camera
* Adds a `ground grid` so the user understand where the object is attached
* Provides a `Touch Collision` object that allows you to determine where users can touch to move the object around
* A `Matte Shadow` which your object can cast shadow on.

For the most part you will simply need to replace the `ADD_TO_SCENE` object with your own.

In case your object is much bigger than the example objects, select the `Touch Collision` object and resize it (press the `R` key on the keyboard to change to the scale widget). This will make sure where the user taps they can manipulate the object as expected:

[](/img/lens-studio/5-features/animated-object-scale.webm)

You can add `World Object Controller` asset into any of your projects through Asset Library.

### Auto-play Animation[​**](#auto-play-animation "Copy to clipboard")

If you'd like your animation to auto-play, or animate without user interaction, all you need to do is set up the animation player found in the object with the animation.

You can check the `Autoplay` Checkbox to have the animation play by default. Take a look at the settings as well to change whether you want the animation to play on loop forever, or reverse, etc. Learn more about [Animation Player](/lens-studio/features/animation/animation-player.md).

![](/assets/images/animated-object-auto-play-08840a00cb40b2c05a6a3ea349ac9f01.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your world Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
