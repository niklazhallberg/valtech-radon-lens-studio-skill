# Device Tracking

## Device Tracking[​**](#device-tracking "Copy to clipboard")

The `Device Tracking` component allows you to place objects in your Lens Studio experience that will be locked to the world. When run in Snapchat, the content will appear in front of you at the start of the Lens. The `Device Tracking` component has three modes:

* **Rotation:** Users can rotate their phone and have the objects stay locked relative to their orientation. Users will not be able to walk towards, away from or around the content.
* **Surface:** Users are able to walk towards, away from and around the content, in addition to being able to rotate their phones. When using this mode, the 0,0,0 position of your Scene represents a horizontal surface in front of the device's initial position. When the Surface mode is selected, you have the option to also enable `Use Native AR`. With `Use Native AR` enabled, the device's native AR tracking capabilities will be utilized to enhance tracking.
* **World:** Users are able to walk freely through the scene without focusing on a surface. When using this mode, the 0,0,0 position of your Scene represents your device's initial position. This mode solely relies on the device's native AR tracking capabilities and falls back to a Rotation experience if native AR tracking is not available. For most use cases where you want to take advantage of native tracking, we recommend instead using `Surface` with `Use Native AR` enabled because it will fallback to Surface if native tracking is unavailable. Note that while in the World mode, the units in the scene reflect centimeters in the real world.

`Surface` mode tracking works best when content is scaled roughly human size or less. For anything bigger, consider enabling `Use Native AR` as well, or `World` tracking mode, which will utilize the device's native tracking capabilities if available. When `Surface` mode is enabled, content in your scene is attached to the ground. Surface mode does not understand or detect walls or obstacles (like a couch or coffee table).

### Adding Device Tracking[​**](#adding-device-tracking "Copy to clipboard")

To add `Device Tracking`, first select the `Camera` object in the `Scene Hierarchy` panel. Then, in the `Inspector` panel click the `Add Component` button and select `Device Tracking`.

[](/img/lens-studio/5-essential/device-tracking-add.webm)

When `Device Tracking` is enabled, you'll see a green grid in your `Scene` panel indicating that `Device Tracking` is turned on. Any object in the scene on the layer of the camera will now be attached to the world.

In other words, the `Device Tracking` component, is using the device data to modify the Camera object which renders the scene.

### Choosing Device Tracking Mode[​**](#choosing-device-tracking-mode "Copy to clipboard")

By default, `Surface` mode is used in the `Device Tracking` component. To change this, in the `Inspector` component, press the `Tracking Mode` drop down and select an option.

[](/img/lens-studio/5-essential/device-tracking-option.webm)

### Using Surface Mode[​**](#using-surface-mode "Copy to clipboard")

Surface mode is useful for when you want to allow users to walk up to your content, as well as walk around it. For experiences that encourage the user to more freely walk around (like a portal) or for larger content, consider enabling `Use Native AR` which will utilize the device's native tracking capabilities if available.

### Positioning Object in Surface Mode[​**](#positioning-object-in-surface-mode "Copy to clipboard")

When you use `Surface` tracking mode, `Manipulation` can be added to any object allowing the user to move, rotate and scale objects. To add `Manipulation` follow the [Manipulation](/lens-studio/lens-studio-workflow/scene-set-up/3d/manipulation.md) guide.

![](/assets/images/device-tracking-scene-1f12e90ca6c4e5d80d9c8cc724f5453c.png)

When you add a `Device Tracking` component on a camera, it will have a grid below it, to showcase the component and how it affects the camera object.

You can use the `World Object Controller` in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) which provides a setup for manipulating objects, as well as UI affordances for it.

### Choosing Tracking Point in Surface Mode[​**](#choosing-tracking-point-in-surface-mode "Copy to clipboard")

As you move your object around on a surface, the further it gets from the origin and the less stable the tracking can become. Telling the Device Tracking system what the tracking target should be can significantly help this. Each time you start your Lens you can reset the device tracker's target with a very simple script. Create a new script named `SetSurfaceTrackingTarget.js` and add the text below to its contents.

```
// -----JS CODE-----
// @input Component.DeviceTracking deviceTrackingComponent
function onSurfaceReset(eventData) {
  if (script.deviceTrackingComponent) {
    script.deviceTrackingComponent.surfaceTrackingTarget =
      script.getSceneObject();
  }
}
var worldTrackingResetEvent = script.createEvent('WorldTrackingResetEvent');
worldTrackingResetEvent.bind(onSurfaceReset);
```

With the object you want to be the tracking target selected, in the `Inspector` panel, press `+ Add Component`, and select the script you just created (e.g. `SetSurfaceTrackingTarget`). This object will now be the device tracker's target.

### Using Rotation Mode[​**](#using-rotation-mode "Copy to clipboard")

`Rotation` mode takes the device's gyroscope rotation and applies it to whatever object it is added to. The primary use case for the `Device Tracking` component with `Rotation` mode is to have the scene's camera rotation be driven by the device's gyroscope. This will allow you to place content all around the user in 3D space and give the user the ability to freely look around the scene. It is useful for when you want to surround the user with content, but not necessarily allow them to walk towards it (i.e. 360 view).

## Camera Attached[​**](#camera-attached "Copy to clipboard")

You can attach an object to the camera. This is great for simulating a first person object (For example: a magic wand pretending to be in the user's hand). To do this, in the `Scene Hierarchy` panel, drag the object you want to be attached to the camera to be a child of the `Camera` object.

[](/img/lens-studio/5-essential/device-tracking-cam-attached.webm)

## Further Reading[​**](#further-reading "Copy to clipboard")

While using Device Tracking is a common way to track your experience to the world, depending on your use case, you might want to use other world related trackers.

* [Marker Tracking](/lens-studio/features/ar-tracking/world/marker-tracking.md)
* [Object Tracking](/lens-studio/features/ar-tracking/world/object-tracking.md)
* [Object Tracking 3D](/lens-studio/features/ar-tracking/body/object-tracking-3d.md)
