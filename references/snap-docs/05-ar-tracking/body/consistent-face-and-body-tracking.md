# 3D Body and Face Tracking

The 3D Body Tracking and Body Mesh features in Lens Studio let you apply effects to a user's body, while the Head and Face Mesh features track facial elements (like expressions, eye movements, and landmarks) in real-time, enabling face effects. These features support multiple bodies and faces through index properties (`faceIndex` and `bodyIndex`).

When using both features together you may notice certain problems. For example, face tracking struggles when viewed from a typical body distance, and the indexes for body and face tracking may not always correspond to the same person.

## Person Tracking Scope[​**](#person-tracking-scope "Copy to clipboard")

To solve these issues, we’re introducing a **Person Tracking Scope** that can be assigned to Head and Face Mesh components and enables consistent tracking of full-body characters—including facial expressions and eye movements. This is implemented by using face tracking derived from body tracking instead of default approach, reducing errors and improving performance.

Person Tracking Scope could also be a convenient way to change `bodyIndex` or `faceIndex` on multiple components at once!

## Person Tracking Scope Asset[​**](#person-tracking-scope-asset "Copy to clipboard")

In order to mix and match Face Tracking components (Head Binding, Face Mesh, face expressions api) and Body Tracking components (Object Tracking 3D, Body Mesh) please follow next steps:

1. Add **Person Tracking Scope Asset** in the Asset Browser. Configure **Person Index** parameter as needed.

![](/assets/images/tracking_scope_1-8600dc94ab686d2ffadee10715e6d6e9.png)

2. With Face Mesh, Body Mesh or Body Tracking 3D added to your scene select corresponding Face Mesh, Body Mesh or Body Tracking 3D asset in the Asset Browser.

For face tracking components (such as Head Binding, Face Inset , Face Mask, Face Retouch, Eye Color, Face Stretch, etc.) - select the scene object with component in the Scene Hierarchy.

3. Set the **Tracking Scope** field with the Person Tracking Scope asset of your choice.

![](/assets/images/tracking_scope_2-5ceaa2db1447a884da3d0aa647d5929f.png)

### Scripting Example[​**](#scripting-example "Copy to clipboard")

This can also be achieved through scripting:

```
// @input Asset.PersonTrackingScope personTrackingScope

// set scope on face mesh visual
// @input Component.RenderMeshVisual faceMeshVisual
script.faceMeshVisual.mesh.control.trackingScope = script.personTrackingScope;

// set scope on head binding
// @input Component.Head head
script.head.trackingScope = script.personTrackingScope;

// set scope on body tracking 3d
// @input Component.ObjectTracking3D bodyTracking3D
script.bodyTracking3D.trackingAsset.trackingScope = script.personTrackingScope;

// set scope on body mesh or upper body mesh
// @input Component.RenderMeshVisual bodyMeshVisual
script.bodyMeshVisual.mesh.control.trackingScope = script.personTrackingScope;

// Set the tracking scope for the Head component
// @input Component.Head head
script.head.trackingScope = script.personTrackingScope;

// Set the tracking scope for the Face Inset component
// @input Component.FaceInsetVisual faceInset
script.trackingScope = script.personTrackingScope;

// Set the tracking scope for the Face Mask component
// @input Component.FaceMaskVisual faceMask
script.faceMask.trackingScope = script.personTrackingScope;

// Set the tracking scope for the Face Retouch component
// @input Component.RetouchVisual faceRetouch
script.faceRetouch.trackingScope = script.personTrackingScope;

// Set the tracking scope for the Eye Color component
// @input Component.EyeColorVisual eyeColor
script.eyeColor.trackingScope = script.personTrackingScope;

// Set the tracking scope for the Face Stretch component
// @input Component.FaceStretchVisual faceStretch
script.faceStretch.trackingScope = script.personTrackingScope;
```

Show more▼

## Texture Tracking Scope[​**](#texture-tracking-scope "Copy to clipboard")

It is also possible to track body on a custom texture (from media picker, dual camera, video embedded to the lens).

To do so:

1. Add **Texture Tracking Scope** Asset in the Asset Browser. Configure input **Texture** to the texture of your choice.

2. Set the **Parent Scope** input of a **Person Tracking Scope** asset with **Texture Tracking Scope** asset.

3. Adjust camera used for body tracking to use information from **Texture Tracking scope** asset (see image below).

![](/assets/images/tracking_scope_5-22f9417b5afacde9033d65c45f006859.png)

4. For details of scene setup for tracking body on a custom texture refer to [Tracking Scope](/lens-studio/features/ar-tracking/tracking-scope.md) guide.
