# Instant World Hit Test

## Overview[​**](#overview "Copy to clipboard")

The Instant World Hit Test asset enables Snapchatters to start interacting with world-facing Lenses instantly. Currently there needs to be a UI prompt for the user to look around for a few seconds before generating the World Mesh and causes a decrease in user engagement.

With this asset library [Custom Component](/lens-studio/features/scripting/script-components.md), the Lens Creator can start hit testing right on the depth texture and ask for callbacks when a World Mesh hit test is found that is more accurate. This will increase user engagement for the use cases of AR object placement and projectile shooting.

[](/img/lens-studio/instant-hit-test-candy-canes.webm)

Notice that the user can shoot candy canes instantly with this Lens. The blue candy canes were shot using a hit result from the depth texture since the World Mesh haven't generated in that area yet. Notice that the World Mesh does eventually generate in that area, and the candy canes were upgraded from blue to red to indicate that they have their position and orientation upgraded from a depth texture hit result to a World Mesh hit result.

## Capabilities[​**](#capabilities "Copy to clipboard")

Instant World Hit Test enables hit testing right from the beginning of Lens session. It uses both depth texture and World Mesh for hit testing results. Adding this asset to a Lens Studio project will give instant World Mesh hit testing ability to Lens Creators. It uses the deviceTracking.hitTestWorldMesh(screenPosition) [method](https://developers.snap.com/lens-studio/api/interfaces/Lens_Scripting.Built_In.DeviceTracking.html#hitTestWorldMesh).

If that method returns no results, it will then sample the corresponding pixel in the depth texture for a depth value which is projected to a coordinate in world space. This is generally sufficiently accurate (±10% of the true depth) to be used for object placement, which is one of the primary use cases of the hitTestWorldMesh method. Additionally, this asset also offers a optional callback on a depth texture hit testing that will check for and return when possible a World Mesh hit test of similar start and end positions.

## Installation[​**](#installation "Copy to clipboard")

The Instant World Hit Test custom component can be found in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md)

In the Asset Library, type in Instant World Hit Test in the `Search` field of Asset Library, navigate to the Instant World Hit Test asset and click `Install`.

![](/assets/images/instantWorldHitTestIcon-b58d149b43ef23a8cc768aa5c4a41ade.png)

## Adding To The Scene[​**](#adding-to-the-scene "Copy to clipboard")

In the Resources Panel, click + button, scroll to the right to Custom Components tab, and select the InstantWorldHitTest custom component.

![](/assets/images/instantWorldHitTestResources-839aec09cdcf7e043eb382a11e2b5ff0.png)

In the Objects Panel, create a Scene Object. Select it, and click Add Component button in the Inspector Panel. Scroll to the right to either the Custom Components - Local Library or Custom Components - Asset Library tabs to find the InstantWorldHitTest component.

![](/assets/images/InstantWorldHitTestComponent-242aac71adf8752571978a9b8ae4e021.png)

Add the InstantWorldHitTest component to your Scene Object. Notice there is reference needed for the camera in the scene and for a Depth Texture resource.

![](/assets/images/InstantWorldHitTestObjects-b22d8a4d816383b7884f52bbabdb4e2c.jpg)

The Camera Scene Object will need a Device Tracking component attached to it for this all to work.

![](/assets/images/InstantWorldHitTestDeviceTracking-51ca1cbb7e5b05d4324d5f467bcc5f92.png)

Select the Camera Scene Object and add a Device Tracking component, and set it to World Tracking Mode.

![](/assets/images/InstantWorldHitTestWorldTracking-059de0f2b17743473d3ef148aebf51e8.png)

Next, add a Depth Texture Resources in the Resources Panel.

![](/assets/images/InstantWorldHitTestDepthTexture-dd69365472ef3f267bd76ed83536f769.png)

Now, we can assign the two references of the InstantWorldHitTest component by dragging the Camera Scene Object onto the Camera reference and the Depth Texture Resources onto the Depth Texture reference. You can leave the other properties of the InstantWorldHitTest component at their default settings. They are customizable but that is usually for edge cases.

![](/assets/images/InstantWorldTestHitReferences-d4e28e89006ff669bf5e87de4bd81012.jpg)

All that is left, is to connect up a World Mesh resource to the Lens. You can accomplish all the necessary steps at once, if you create a World Mesh Scene Object, which is under the Mesh tab of the Objects Panel. Manually, you would have to create a World Mesh Resource, then create a Scene Object, then a Render Mesh Visual Component, and then connect the World Mesh Resource to the Render Mesh Visual Component.

![](/assets/images/InstantWorldHitTestWorldMesh-671217dda2c74525e6d0e75d05c7b233.png)

The Render Mesh Visual will have the World Mesh Default material assigned to it, which makes the World Mesh appear on screen. This is good for debugging, and may suit your final Lens' needs. If not, please ensure you replace the material. You can create a simple invisible material by creating an Unlit Material Resource, setting its blend mode to normal, and setting its base color's opacity to zero.

## Building a Simple Lens Projects[​**](#building-a-simple-lens-projects "Copy to clipboard")

Let's build a simple sample project to show off the Instant World Hit Test feature in a Lens. First, create a Script Resource.

![](/assets/images/InstantWorldHitTestScript-ac8fcb91e81126314870c31c15e0f79f.png)

Let's call it LensLogic as it is going to run the logic of our Lens. Now write this code in the Script Editor Panel and save it to that Script Resource. It will create some simple Lens logic that listens for a tap event from the user. It then instantiates a prefab and calls hitTest method on the instantWorldHitTest component with a callback method provided by the prefab logic script, which we will write in a bit.

```
// @input Component.ScriptComponent instantWorldHitTest
// @input Asset.ObjectPrefab prefab

script.createEvent('TapEvent').bind((eventData) => {
  var tapPosition = eventData.getTapPosition();
  var instance = script.prefab.instantiate(script.getSceneObject());
  var prefabLogic = instance.getComponent('Component.ScriptComponent');
  var hitResult = script.instantWorldHitTest.hitTest(
    tapPosition,
    prefabLogic.onFoundBetterHitTestResult
  );
  prefabLogic.setInstance(hitResult);
});
```

Now create a Scene Object, call it LensLogic and add the Script Resource as a component. Notice there are two references that we need to connect up, the Instant World Hit Test component and a Prefab.

![](/assets/images/InstantWorldHitTestLensLogic-4db801a3ce2424f7b42768927341941e.jpg)

Create another Script Resource, call it PrefabLogic, and save this code in it. This will give logic to prefabs that we instantiate at runtime. It will set the position and rotation of the instantiated prefab's transform with the returned hitResult object from instantWorldHitTest.hitTest method. It also has a callback method in case a depth texture hitResult was found instead of a World Mesh hitResult. The callback is called from instantWorldHitTest when it finds an upgraded hitResult from World Mesh. It is a good convention to remove the callback from the instantWorldHitTest event with the eventHandler.off method so that instantWorldHitTest knows to stop checking for that upgraded hitTest.

```
var instantWorldHitTestEventHandler = null;
var transform = script.getTransform();

script.setInstance = function (hitResult) {
  if (hitResult.eventHandler) {
    instantWorldHitTestEventHandler = hitResult.eventHandler;
  }
  transform.setWorldPosition(hitResult.hits[0].position);
  var rotation = quat.lookAt(hitResult.hits[0].normal, vec3.up());
  transform.setWorldRotation(rotation);
};

script.onFoundBetterHitTestResult = function (newHitResult) {
  if (instantWorldHitTestEventHandler) {
    instantWorldHitTestEventHandler.off(script.onFoundBetterHitTestResult);
    instantWorldHitTestEventHandler = null;
  }
  transform.setWorldPosition(newHitResult.hits[0].position);
  var rotation = quat.lookAt(newHitResult.hits[0].normal, vec3.up());
  transform.setWorldRotation(rotation);
};
```

Now let's create a simple prefab. In the Objects Panel, create a Box Scene Object under Mesh tab.

![](/assets/images/InstantWorldHitTestBox-6d5d30643c694c7e0a0b6fc656c8b8c1.png)

Add the PrefabLogic script to the Box Scene Object as a component to complete the ingredients for our Prefab. Now drag the Box Scene Object down into the Resources Panel. This will create a prefab Resource of this Scene Object for use later during Lens runtime. Delete the Box Scene Object as it's no longer needed since it is saved out as Resource on your file system.

![](/assets/images/InstantWorldHitTestPrefab-6f6592e35513ae8ebc28e9a2b5394ae7.jpg)

Connect the InstantWorldHitTest Component and the Sphere Prefab Resource to the LensLogic Component's missing references.

![](/assets/images/InstantWorldHitTestLensLogicRefs-befed2888a255d4bea3a5ad4552e3cd3.jpg)

Try out the Lens in the Interactive Preview Panel to make sure it is working correctly by creating Sphere Scene Objects where you click. Then Send to Snapchat to try it out on your own device!

![](/assets/images/instantWorldHitTestPreview-5be2acf54f61bffbcc9a5ddf04637544.jpg)

## Scripting API[​**](#scripting-api "Copy to clipboard")

### Input Variables Exposed in the Inspector[​**](#input-variables-exposed-in-the-inspector "Copy to clipboard")

| Signature                          | Visibility | User facing description                                                                             |
| ---------------------------------- | ---------- | --------------------------------------------------------------------------------------------------- |
| Camera                             | Public     | Developer must connect the scene camera with a device tracking component set to world               |
| Depth Texture                      | Public     | Developer must connect to a depth texture resource                                                  |
| Max Raycast Distance (m)           | Public     | Max distance of ray cast in m. Default 100m, min 10, max 200                                        |
| Max List Size of Callbacks         | Public     | Max list size allowed for callbacks. Default 50, min 10, max 200                                    |
| Max Processing Time Per Frame (ms) | Public     | Max processing time per frame in ms. Up to as it depends on size of list. Default 10, min 1, max 20 |

![](/assets/images/instant-hit-test-inspector-view-6edb165a221c47e05151b53b2921fa55.jpg) Screenshot of input variables exposed in the inspector when adding CC as a script component.

Make sure to set properties using input variables in the inspector view, and reset Lens session to see the changes.

### Read Only Properties[​**](#read-only-properties "Copy to clipboard")

| Signature          | Type   | Visibility | User facing description                                                                 |
| ------------------ | ------ | ---------- | --------------------------------------------------------------------------------------- |
| isWorldRaycaster   | Bool   | Public     | Can check if script component is of this type before calling its properties and methods |
| raycastDisMaxCm    | Number | Public     | Returns ray casting max distance in cm                                                  |
| callbackListMax    | Number | Public     | Returns max size of callback list                                                       |
| frameProcessingMax | Number | Public     | Returns max processing per frame in ms                                                  |

### Methods[​**](#methods "Copy to clipboard")

| Signature | Type                                                                                      | Visibility | User facing description                                                                                                                                                                                                                                                                                                                                                                           |
| --------- | ----------------------------------------------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| hitTest   | function(vec2 screenPosition, function onDepthTextureHit (HitTestResult)) : HitTestResult | Public     | Returns a HitTestResult object that intersect with a ray cast from screen position screenPos. If an optional callback function is provided as secondary input (onDepthTextureHit) and the hitTestResult is from depth texture since World Mesh wasn't available at that intersection, then the callback is added to a list for checking if a World Mesh hitTestResult is available in the future. |

### HitTest Method Returns an Array of Objects[​**](#hittest-method-returns-an-array-of-objects "Copy to clipboard")

| Signature     | Type                                                                                                                                    | Visibility | User facing description                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| hitTestResult | array of objects \[ { vec3 position, vec3 normal, bool worldMesh, TrackedMeshFaceClassification classification, object eventHandler } ] | Public     | Returns an array of objects that has details of the hitTest method call. This mirrors the deviceTracking.hitTestWorldMesh method. This includes the world position of the hit, the world normal of the hit, a bool to indicate if this hitTestResult is coming from the World Mesh or depth texture, an enum for classification of mesh face, and an eventHandler object that provides access to add more callbacks and to remove callbacks to the event. |
