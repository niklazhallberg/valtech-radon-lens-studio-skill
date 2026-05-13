# Eye Tracking

The Eye Tracking effect allows you to track the position and rotation of the user’s eyes. The Eye Tracking effect uses the [Head Binding](/lens-studio/features/ar-tracking/face/head-attached-3d-objects.md) component to change the transform of the object the component is on.

[](/img/lens-studio/eye-tracking_eye-tracking-4.webm)

## Attaching Objects to the Eye[​**](#attaching-objects-to-the-eye "Copy to clipboard")

You can attach an object to the eye by making your object a child of an object with the `Head Binding` component, with the `Left` or `Right` Eyeball option selected.

The `Left Eye` and `Right Eye` object will position and rotate themselves based on the user’s eye. You can add an object as a child of either object to have your object track the eye.

![](/assets/images/eye-ball-basic-e2c56988844af5f3936ccc0f7740ca8c.png)

## Eyeballs Example[​**](#eyeballs-example "Copy to clipboard")

You can see a usage of this technique in the `Eyeballs` asset in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

In this asset, each eye will come with two objects: Sclera and Choroid. These objects are provided as an example and can be removed. The Sclera adds a reflective sphere around the Choroid. Both use the default PBR material.

### Add Eyeballs[​**](#add-eyeballs "Copy to clipboard")

Once you've imported `Eyeballs` from the Asset Library, you will find it in your `Asset Browser` panel.

Next, drag the prefab inside the folder underneath the main camera, as per the instruction in its name. This will add a `Left Eye` and `Right Eye` object, each with their own `Head Binding` component and their respective attach point.

[](/img/lens-studio/5-essential/eye-ball-drag.webm)

### Using the Eyeball Rotation Only[​**](#using-the-eyeball-rotation-only "Copy to clipboard")

The `Head Binding` component will modify both the rotation and position of the object it is attached to.

In some cases, you may only want to use the rotation and manually position the eyeball. For example, in the image below, the eye on the character shouldn't be positioned where the natural eye is.

[](/img/lens-studio/eye-tracking_eye-tracking-4.webm)

One way we can do this, is by tracking the eyeball to the head, but NOT to the eye itself. For example: below we attached the two eyes object to the `Face Center`.

![](/assets/images/eye-ball-copy-06ca32e015a7f7002de7f8710a386be4.png)

Next, you might want to copy the rotation of the eye onto the head tracked object. You can use the following script to copy the rotation from one object to another.

```
// CopyRotation.js
// Version: 0.0.1
// Description: Copies rotation from one object to another
// @input SceneObject sourceObject
// @input SceneObject targetObject
var targetTransform;
var sourceTransform;
if (script.targetObject) {
  targetTransform = script.targetObject.getTransform();
} else {
  targetTransform = script.getSceneObject().getTransform();
}
if (script.sourceObject) {
  sourceTransform = script.sourceObject.getTransform();
} else {
  print('[CopyRotation] Source object is not set');
}
function onUpdate() {
  if (sourceTransform) {
    targetTransform.setWorldRotation(sourceTransform.getWorldRotation());
  }
}
var updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(onUpdate);
```

With the script below selected, in the `Inspector` panel, you can select the object with the `Head Binding` component tracking the `eye` as the source, and the object you want to rotate with the eye as the target.

![](/assets/images/eye-ball-left-a3d0f29eb884caddbc6b693596406384.png)

You can checkout the [Face Expressions](/lens-studio/features/ar-tracking/face/face-templates/face-expressions.md) example in the Asset Library to see the complete setup above.

#### Changing the Eye to Track[​**](#changing-the-eye-to-track "Copy to clipboard")

Like any object with the `Head Binding` component, you can change the `Face Index` field to change [which face to track](/lens-studio/features/ar-tracking/face/working-with-multiple-faces.md) for the eyeballs. The first detected face is `0`, the second face is `1`, and so forth.

![](/assets/images/eye-ball-binding-b3b2590209decdb87a167ad605bdb97b.png)
