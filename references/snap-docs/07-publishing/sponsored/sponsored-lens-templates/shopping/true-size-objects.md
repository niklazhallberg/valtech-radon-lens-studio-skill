# True Size Objects

The True Size Object sample project allows you to put 3D objects into the world with an accurate scale. The sample project comes with several different sized objects as an example.

True Size Object sample project is available on Lens Studio Home Page.

Lens built with this sample project will use LiDAR capabilities for better accuracy if it's available on the device, and will automatically fallback to Multi-Surface tracking solution, utilizing ARCore/ARKit, if LiDAR is unavailable. If neither are available, Lens will use Surface tracking.

While the content in here can be used for 3D objects in general, this sample project is great for shopping related Lenses where a realistic representation of size is important to show.

To learn more about Shopping Lenses, please visit the [Shopping Lens](/lens-studio/sponsored/sponsored-lens-templates/shopping/surface-objects.md) page.

[](/img/lens-studio/true-size-object-1.webm)

In the next few sections, you will learn:

* What the User Experience of True Size Objects Lens looks like at runtime.
* How Multi-Surface Tracking and World Mesh are used to create a true to size experience.
* How the 3D model is configured to a real world scale.

### Lens User Experience[​**](#lens-user-experience "Copy to clipboard")

When the Lens starts, you will see the following:

* The Scan message to find supported surfaces will be shown.
* The Item will automatically appears in the user’s environment if a vacant position is found.
* The Item can be dragged and rotated using finger gestures on-screen.
* Tapping a position will teleport the Item to that position.
* If the Item is off-screen, an indicator arrow will appear to guide the user's attention back to the Item.

## Device Tracking[​**](#device-tracking "Copy to clipboard")

True to size scaling utilizes two different types of tracking solutions that are dependent on the User’s device:

* **Multi-Surface Tracking**.
* **LiDAR World Mesh**.

If Lens is running on a lower end device, it will default to a third type of tracking solution called Surface tracking.

### Multi-Surface tracking[​**](#multi-surface-tracking "Copy to clipboard")

With Multi-Surface tracking, Users will be able to detect flat surfaces, such as a floor, table, or a countertop, in their environment. After a surface has been detected, items can then be placed on the detected surfaces. Sensors in the phone allow for the digital item to be rendered at an accurate scale as the User moves throughout their physical space.

[](/img/lens-studio/true-size-object-3.webm)

In order to use Multi-Surface tracking in a Lens, the User’s device will need to support either Apple’s ARKit or Google’s ARCore SDK.

### LiDAR World Mesh[​**](#lidar-world-mesh "Copy to clipboard")

Certain Apple devices have embedded Light Detection and Ranging sensors, commonly known as LiDAR, that can scan and understand the world around the User when experiencing AR content. When using the True Size Objects example on one of these devices, it will use World Reconstruction to create a virtual 3D mesh of the User’s environment to allow users to place content with greater accuracy.

[](/img/lens-studio/true-size-object-4.webm)

To learn more about LiDAR and World Reconstruction in Lens Studio, please visit the [World Mesh and Depth Texture](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md) guide.

If You or a User is on an older device that does not have ARCore or ARKit capabilities, you can utilize the Surface Tracking solution. This solution uses camera on a device to create an approximate scale to use when placing content on a surface. This will **not** create a true to size scale on the digital items in the Lens.

To learn more about Surface Tracking, please visit the [Tracking Modes](/lens-studio/features/ar-tracking/world/tracking-modes.md) guide.

[](/img/lens-studio/true-size-object-5.webm)

### Item Placement Script Object[​**](#item-placement-script-object "Copy to clipboard")

The Item Placement Script object contains the main logic used to place an object on a horizontal surface.

* **Force Tracking Quality:** Overrides which tracking solution will be used at runtime. This can be used to test how the Lens would behave on devices with no LiDAR or no world tracking support.

* **Tracking Quality:** Sets the type of tracking solution that will be used.

  <!-- -->

  * ***Plane***
  * ***Surface***

* **Endless Surfaces:** Sets if the item will go through barriers (such as walls) instead of getting stuck.

* **Edge spring:** Sets if the item will bounce back when dragged over the edge in a spring-like manner.

[](/img/lens-studio/true-size-object-2.webm)

## Best Practices[​**](#best-practices "Copy to clipboard")

Listed below are some best practices to keep in mind when working with objects that will be accurately represented in the Lens.

### Use Centimeters for Scale[​**](#use-centimeters-for-scale "Copy to clipboard")

To provide an accurate scale for the model, its units should be in centimeters. The scale of the model can be changed using the Transform component in the Lens studio editor.

For instance, if the model is of meters units instead of centimeters, you will need to scale it by 100.

### 3D Object centered and facing the Z Direction[​**](#3d-object-centered-and-facing-the-z-direction "Copy to clipboard")

When looking to add interactivity and manipulation to the user experience, the model will need to be properly positioned in order to be placed in the world accurately. The Object’s pivot point should be located at the center of the object and at the very bottom. The pivot point should be placed at origin or `0,0,0` and the Object should be faced towards the positive Z direction.

[](/img/lens-studio/5-shopping/true-size-object-6.webm)

1. In the Viewport, switch to **Scene** view and select **3D scene**.
2. Select the object you need to adjust in the `Scene Hierarchy` panel.
3. Left-click on the Move Tool and move the Object to `0,0,0`.
4. Left-click on the Rotate Tool and rotate the Object to face the correct direction.

Incorrectly orientating the object in the correct position may lead to undesirable results.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide. In order to properly preview this sample project, use the **Interactive Environment** preview option.

[](/img/lens-studio/5-shopping/true-size-object-9.webm)

You will need to switch to the rear camera in order for the sample project to work properly in the **Interactive Environment** preview.

You can simulate tapping on the screen by left-clicking within the Environment. You can also virtually walk around in the Environment by pressing the **arrow** keys.
