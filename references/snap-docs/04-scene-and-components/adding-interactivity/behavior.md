# Behavior

The Behavior helper script allows you to create simple interactions without writing any custom script. With Behavior, interactions are completely configured in the `Inspector` panel. It allows you to configure the trigger type which defines when something should happen. Next, it allows you to configure what should happen as a response to a trigger. The selectable responses include a number of commonly used interactions like playing an animation, playing a sound, enabling an object and more.

## Overview[​**](#overview "Copy to clipboard")

![](/assets/images/behavior_behavior_graphic-7005861e3f8719e319d1cd3cc6d93aa1.png)

The Behavior helper script's interface is broken out into two sections:

* **Trigger:** Defines when something should happen
* **Response:** Defines what should happen as a response to the trigger

In the below example, I've configured the `Trigger` to Mouth Opened. Next, I've configured the `Response` to `Play Sound`. The resulting interaction is - when the user opens their mouth -> play a sound.

![](/assets/images/behavior_example-6b2501f10dc14936f241d0630d0caa11.png)

## Adding Behavior[​**](#adding-behavior "Copy to clipboard")

### Add Object[​**](#add-object "Copy to clipboard")

To add the Behavior helper script, in the `Scene Hierarchy` panel select `+ -> Scripts -> Behavior`. This will create a new object with the Behavior helper script added to it.

![](/assets/images/helper-script-behavior-db4d975e09c385c81f883a43e2b3b1bc.png)

### Configure Behavior[​**](#configure-behavior "Copy to clipboard")

Once the Behavior helper script is added, it can be configured in the `Inspector` panel. To do this, first select the object in the `Scene Hierarchy` panel. Then, in the `Inspector` panel you'll see a number of options. To configure the Behavior helper script, first select the `Trigger` which defines when something should happen. Then, select the `Response Type`, which defines what should happen on trigger. Finally, configure additional settings based on the selected Trigger and Response Type. These additional settings are detailed below in the [Trigger Types](#trigger-types) and [Response Types](#response-types) sections.

In the example below, we first set the `Trigger` to the `Face Event` type: `Brows Raised`. Then, we set the `Response Type` to `Play Sound`. Finally, we configure the sound we want to play in the response type's settings. The resulting interaction is - when the user's eyebrows are raised -> play a sound.

[](/img/lens-studio/5-essential/behavior_example.webm)

## Trigger Types[​**](#trigger-types "Copy to clipboard")

The Behavior helper script offers a number of Trigger Types via the `Trigger` dropdown. When the Trigger happens, the Behavior helper script will fire the Response.

![](/assets/images/behavior_triggers-5693f01d46ae57491ac9a9706ff3d97d.png)

The sections below detail the available Trigger Types.

### Touch Event[​**](#touch-event "Copy to clipboard")

The `Touch Event` trigger responds to the user touching the screen or a portion of the screen.

![](/assets/images/behavior_touch_event-5e5045123f9ccfe77104284f46807a6b.png)

* **Event Type:** The type of touch event to trigger on. Includes `Tap`, `Touch Start`, `Touch Move` and `Touch End`
* **Touch Target:** When `Touch Target` is left empty, the trigger will happen when the user touches the entire screen. If you set `Touch Target` to a MeshVisual, Screen Image or Image, the touch will happen only when you touch that specific object.

### Face Event[​**](#face-event "Copy to clipboard")

The `Face Event` trigger responds to the user moving their face in some way.

![](/assets/images/behavior_face_event-06f11f07524d34304d71e215363aac9b.png)

* **Event Type:** The type of face event to trigger on. Includes `Mouth Opened`, `Brows Raised`, `Face Found`, `Kiss Started`, `Smile Started` and more
* **Face Index:** The face to look for the trigger on. When two faces are in the scene, the first face found is `Face Index` 0 and the second face found is `Face Index` 1 .

### On Awake[​**](#on-awake "Copy to clipboard")

The `On Awake Event` trigger happens as soon as the Lens starts. Occurs before On Start.

### On Start[​**](#on-start "Copy to clipboard")

The `On Start Event` trigger happens as soon as the Lens starts.

### On Enabled[​**](#on-enabled "Copy to clipboard")

Triggered when the current object, or a specified object is enabled (i.e. similar to their box being checked in the `Scene Hierarchy` panel).

### On Disabled[​**](#on-disabled "Copy to clipboard")

Triggered when the current object, or a specified object is disabled (i.e. similar to their box being unchecked in the `Scene Hierarchy` panel).

### Update[​**](#update "Copy to clipboard")

The `Update` trigger happens every single frame.

You can utilize the `Update` trigger and configure the `Trigger Options` to `After Interval`. This will create a trigger that happens every X number of seconds.

### Late Update[​**](#late-update "Copy to clipboard")

The `Late Update` trigger happens every single frame. The Late Update however always happens immediately after the Update trigger.

### Front Camera[​**](#front-camera "Copy to clipboard")

The `Front Camera` trigger happens every time the user switches to the Front camera either through the swap camera button or by double tapping the screen.

### Back Camera[​**](#back-camera "Copy to clipboard")

The `Back Camera` trigger happens every time the user switches to the Back camera either through the swap camera button or by double tapping the screen.

### Animation End[​**](#animation-end "Copy to clipboard")

The `Animation End` trigger happens when a specified animation finishes.

![](/assets/images/behavior_AnimationEnd_event-dcc9d367d497c88e1b8c12741ef474f5.png)

* **Anim Type:** The type of the animation that you want to respond to when the animation finishes. This can be an animated texture, an animated image or an animated 3D mesh.
* **Target**- Depending on the `Anim Type` that is selected, here you'll configure the animation resource or object you want to respond to when the animation finishes.

### Tween End[​**](#tween-end "Copy to clipboard")

The `Tween End` trigger happens when a Tween finishes utilizing the [Tween System](/lens-studio/lens-studio-workflow/adding-interactivity/tween-manager.md).

![](/assets/images/behavior_TweenEnd_event-ec1b4d1fab2ca6c318b67ec249b638b0.png)

* **Target Object:** The object the Tween is on.
* **Tween Name:** The name of the Tween that is being played.

### Looking At[​**](#looking-at "Copy to clipboard")

The `Looking At` trigger happens when one object is looking at another object.

![](/assets/images/behavior_LookingAt_event-fd009d8467c786561ab71b924c007432.png)

* **Looking Object:** The object that's doing the looking. A common use case here is to make the `Looking Object` your primary camera.
* **Look Target:** The object that when looked at triggers the response.
* **Flip Forward Vec:** Flips the z direction where the angle is compared. This should be enabled when your `Looking Object` is a camera.
* **Compare Type:** How you'll compare the angle between the two objects. Options are `Less Than`, `Equal To` and `Greater Than`.
* **Angle:** The tunable angle used to trigger the response.
* **Allow Repeat:** When enabled, the response will call every frame when the angle check succeeds.

### Distance Check[​**](#distance-check "Copy to clipboard")

The `Distance Check` trigger happens when one object is within a configurable distance of another object.

![](/assets/images/behavior_DistanceCheck_event-ad54792292f802f0f55b8000a2304b03.png)

* **Object A:** The first object to distance check against.
* **Object B:** The second object to distance check against.
* **Compare Type:** How you'll compare the distance between the two objects. Options are `Less Than`, `Equal To` and `Greater Than`.
* **Distance:** The tunable distance used to trigger the response.
* **Allow Repeat:** When enabled, the response will call every frame when the distance check succeeds.
* **Flatten Z Distance:** Use this option when using distance check on a Screen Transform.

### Marker Tracking Event[​**](#marker-tracking-event "Copy to clipboard")

The `Marker Tracking Event` trigger happens when the specified [marker](/lens-studio/features/ar-tracking/world/marker-tracking.md) is either found or lost.

![](/assets/images/behavior_MarkerTracking_event-062aad7cabe5ed7f6531d427b36bd758.png)

* **Event Type:** When the trigger will occur. Options are `Marker Found` and `Marker Lost`.

### Object Tracking Event[​**](#object-tracking-event "Copy to clipboard")

The `Object Tracking Event` trigger happens when the specified [object](/lens-studio/features/ar-tracking/world/object-tracking.md) is either found or lost.

![](/assets/images/behavior_ObjectTracking_event-ae10cbcafe2e72b222731da2b99a6c98.png)

* **Event Type:** When the trigger will occur. Options are `Marker Found` and `Marker Lost`, [Descriptor Start, or Descriptor End](/lens-studio/features/ar-tracking/hand/hand-gestures.md).

### Location Event[​**](#location-event "Copy to clipboard")

The `Location Event` trigger happens when the specified location or [Landmarker](/lens-studio/features/location-ar/guide.md) is either found or lost.

![](/assets/images/behavior_location_event-6fe728dbe1703abf47d468313a379f26.png)

* **Event Type:** When the trigger will occur. Options are `Location Found` and `Location Lost`.

### Machine Learning Event[​**](#machine-learning-event "Copy to clipboard")

The `Machine Learning Event` trigger happens when a machine learning component has loaded or has ran. Learn more about these events in the [ML Component guide](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md).

![](/assets/images/behavior_machineLearning_event-6f777d1c915933b35ead548d5db3996b.png)

* **Event Type:** When the trigger will occur. Options are `Loading Finished` and `Running Finished`.
* **ML Component:** A reference to the Machine Learning component.

### Recording Event[​**](#recording-event "Copy to clipboard")

The `Recording Event` trigger happens when the user starts or stops recording a Snap or captures an image while using the lens.

![](/assets/images/behavior_recording_event-bfdb15f8d46227708afb4fd279380a3a.png)

* **Event Type:** When the trigger will occur. Options are `Recording Start`, `Recording Stop` and `Image Capture`.

### On Custom Trigger[​**](#on-custom-trigger "Copy to clipboard")

The `On Custom Trigger` happens when a custom trigger is fired via another Behavior helper script. See the [Send Custom Trigger](#send-custom-trigger) response type below.

![](/assets/images/behavior_CustomTrigger_event-3886e74d98baaa897d82bff6a1a97020.png)

* **Trigger Name:** The name of the custom trigger to respond to.
* **Use List:** To add multiple custom triggers.

### Physics Collider Event[​**](#physics-collider-event "Copy to clipboard")

The `Physics Collider Event` happens when a [physics](/lens-studio/features/physics/physics-overview.md) collision or overlap occurs on a specified collider. You also have the ability to filter which event you want to respond to.

![](/assets/images/behavior_physicsCollider-event-a170b1d1ecc95c845e972748623c1e33.png)

* **Collider:** The name of the custom trigger to respond to.
* **Collision Type:** The type of object interaction you are interested in: `Collision`, or `Overlap`.
* **Event Type:** When in the collision you want the trigger to occur: `On Enter`, `On Stay`, `On Exit`.
* **Collider Filtering:** Only trigger events when the collision occur with: specified objects, or objects with specified names (`Equals`, `Starts With`, `RegEx`). If checking `Overlaps`, you will have additional option to check if object is: `static`, `dynamic`, `intangible`.

You can apply physics to colliders using the [Physics Apply Force](#physics-apply-force) response below.

### None Trigger[​**](#none-trigger "Copy to clipboard")

The `None` trigger is when you don't want the behavior to be run. You might use this when keeping old behaviors in your project as reference but don't want them to ever run.

## Trigger Options[​**](#trigger-options "Copy to clipboard")

A number of additional options are available when configuring your Trigger that apply to all Trigger Types.

### Always[​**](#always "Copy to clipboard")

![](/assets/images/behavior_always-e7fe04893287fe4f1639a7af8b946b26.png)

When `Always` is selected, the Trigger will always happen over multiple same triggers. Additionally, you're able to configure a `Delay Time` which delays the Response a configurable number of seconds after the trigger happens.

### Once[​**](#once "Copy to clipboard")

![](/assets/images/behavior_once-cc066ab5d31b6a05dc2779c11361e14a.png)

When `Once` is selected, the Trigger will only happen once during the lifetime of the Lens. Same triggers after the first will be ignored. Additionally, you're able to configure a `Delay Time` which delays the Response a configurable number of seconds after the trigger happens.

### After Interval[​**](#after-interval "Copy to clipboard")

![](/assets/images/behavior_afterInterval-58e9c1246108f93a45ac7c1d0e44235f.png)

When `After Interval` is selected, the Trigger will wait the `Interval Time` before allowing the trigger to happen again. Within the `Interval Time` window, same triggers will be ignored. When the `Interval Time` window is complete, the Trigger can happen again. Additionally, you're able to configure a `Delay Time` which delays the Response a configurable number of seconds after the trigger happens.

## Response Types[​**](#response-types "Copy to clipboard")

The Behavior helper script offers a number of Response Types via the `Response Type` dropdown. When the Trigger happens, the Behavior helper script will fire the Response.

![](/assets/images/behavior_responseTypes-727dd4ae66eeae1ecc7d0aec57a4453f.png)

The sections below detail the available Response Types.

### Animate Image[​**](#animate-image "Copy to clipboard")

The `Animate Image` response type plays a 2D animation.

![](/assets/images/behavior_animateImage-521f074537acbc888dc99289c6d54cae.png)

* **Animated Texture:** The animated texture you'd like to play.
* **Visual Object:** Alternatively, you can select a visual object to play the 2D animation on. This can be a Mesh Visual, Screen Image or Image. If both an `Animated Texture` and `Visual Object` are set, the `Animated Texture` will be applied to the Visual Object and played
* **Action:** The action to take on the animation. Available options are: `Play`, `Play or Resume`, `Pause` and `Stop`
* **Loop:** When playing an animation, should the playback continuously loop

### Animate Mesh (Animation Player)[​**](#animate-mesh-animation-player "Copy to clipboard")

The `Animate Mesh (Animation Player)` response type plays a mesh animation.

![](/assets/images/behavior_animateMesh-dba61c706c49be69e41b4176a2a2ce19.png)

* **Animation Player:** The animation player to play the animation on.
* **Clip Name:** The clip name of the animation to play.
* **Action:** The action to take on the animation. Available options are: `Play`, `Play or Resume`, `Pause` and `Stop`.
* **Weight:** The strength of the animation clip contribution.
* **Playback Mood:** Specifies how the animation should play: `Single`, `Loop`, or `PingPong`.

### Play Sound[​**](#play-sound "Copy to clipboard")

The `Play Sound` response type plays a sound.

![](/assets/images/behavior_playSound-90381e2ea372ec11c998296074c8c824.png)

* **Audio Track:** The audio resource (e.g. mp3) that you want to play. Note, the response automatically creates an Audio Component for you if one isn't specified.
* **Audio Component:** Alternatively, you can select an `Audio Component` to play the audio on. If both `Audio Track` and `Audio Component` are set, the `Audio Track` will be applied to the `Audio Component` and played.
* **Loop:** When playing a sound, should the playback continuously loop.
* **Volume:** The volume at which the sound is played.

### Set Enabled[​**](#set-enabled "Copy to clipboard")

The `Set Enabled` response type enables or disables a Scene Object.

![](/assets/images/behavior_setEnabled-63bfe70657f433cb67e64e61760b60eb.png)

* **Target:** The target Scene Object to enable or disable.
* **Action:** Defines if the object should be enabled, disabled or toggled (If disabled, enable. If enabled, disable).

### Set Color[​**](#set-color "Copy to clipboard")

The `Set Color` response type sets the color of an object or material.

![](/assets/images/behavior_setColor-bae0db89a961e45589a024e9b0b71f98.png)

* **Visual:** A mesh visual or image object to set the color on.
* **Material:** A material to change the base color on. This is only used if `Mesh Visual` is not set.
* **Color:** The color that will be set.

### Set Texture[​**](#set-texture "Copy to clipboard")

The `Set Texture` response type sets the texture of an object.

![](/assets/images/behavior_setTexture-2296c231dc391bce491b10787007cbd9.png)

* **Target:** A mesh visual or image object to set the texture of
* **New Texture:** The texture to set on the target object

### Set Text[​**](#set-text "Copy to clipboard")

The `Set Text` response type sets the text of a Text or Screen Text object.

![](/assets/images/behavior_setText-94c523ac9e6c5e7afadb0bc69d535ea7.png)

* **Component Type:** Choose between [Text3D](/lens-studio/features/text/3d-text.md) or [Text Component](/lens-studio/features/text/2d-text.md).
* **Text Component:** The Text Component to apply the text to.
* **Text:** The string you'd like to set the Text Component's text to.

### Run Tween[​**](#run-tween "Copy to clipboard")

The `Run Tween` response type runs a Tween utilizing the [Tween System](/lens-studio/lens-studio-workflow/adding-interactivity/tween-manager.md).

![](/assets/images/behavior_runTween-593ee9f163db0551e4473f4ccbb1786c.png)

* **Target Object:** The scene object the Tween is on.
* **Tween Name**: The name of the Tween to be played.
* **Action:** The action to take on the Tween. Available options are: `Start`, `Stop`, `Pause` and `Resume`.

### Set Position[​**](#set-position "Copy to clipboard")

The `Set Position` response type sets the position of an object's Transform.

![](/assets/images/behavior_setPosition-fd166d5835df11770fe4976c98e9946c.png)

* **Object to Move:** The object to set the position of.
* **Position:** The `vec3` position to set.
* **Local Space:** When enabled, local space will be used. When disabled, world space will be used.

### Set Rotation[​**](#set-rotation "Copy to clipboard")

The `Set Rotation` response type sets the rotation of an object's Transform.

![](/assets/images/behavior_setRotation-15adaab58aa13b38fab600e4d6bf9cb3.png)

* **Object to Rotate:** The object to set the rotation of.
* **Euler Rotation:** The `vec3` euler rotation to set.
* **Local Space:** When enabled, local space will be used. When disabled, world space will be used.

### Set Scale[​**](#set-scale "Copy to clipboard")

The `Set Scale` response type sets the scale of an object's Transform.

![](/assets/images/behavior_setScale-9319d2e31ade0943776cb8d9cb756d69.png)

* **Object to Scale:** The object to set the scale of.
* **Scale:** The `vec3` scale to set.
* **Local Space:** When enabled, local space will be used. When disabled, world space will be used.

### Set Screen Position[​**](#set-screen-position "Copy to clipboard")

The `Set Screen Position` response type sets the position of an object with a Screen Transform. For example, a Screen Image or Screen Text object.

![](/assets/images/behavior_Screen-Shot-2020-05-28-at-2.39.13-PM-63c60eea146f083f702f897b7d4432ba.png)

* **Screen Transform:** The Screen Transform to set position of.
* **Position Type:** The type of position to set. Available options are `Basic Position`, `Anchors Rect` and `Offset Rect`.
* **Basic Position:** A basic local position. For most simple positioning, you should use basic position.
* **Anchors Rect:** The relative position within the parent on a -1 to 1 scale.
* **Offset Rect:** Fixed world unit offsets to each edge position.

### Set Screen Rotation[​**](#set-screen-rotation "Copy to clipboard")

The `Set Screen Rotation` response type sets the rotation of an object with a Screen Transform. For example, a Screen Image or Screen Text object.

![](/assets/images/behavior_Screen-Shot-2020-05-28-at-2.39.26-PM-703c7ed6005ac30d78845ff19b080237.png)

* **Screen Transform:** The Screen Transform to set rotation of.
* **Angle:** The angle rotation to set from 0.0 to 360.0

### Set Screen Size[​**](#set-screen-size "Copy to clipboard")

The `Set Screen Size` response type sets the size of an object with a Screen Transform. For example, a Screen Image or Screen Text object.

![](/assets/images/behavior_Screen-Shot-2020-05-28-at-2.39.37-PM-c48794b28427da7d020c9b78f57b531d.png)

* **Screen Transform:** The Screen Transform to set the size of.
* **Size Type:** The type of size to set. Available options are `Basic Scale`, `Anchors Rect` and `Offset Rect`.
* **Basic Scale:** A basic local scale. For most simple scaling, you should use basic scale.
* **Anchors Rect:** The relative size within the parent on a -1 to 1 scale.
* **Offset Rect:** Fixed world unit offsets to each edge position.

### Set Blendshapes[​**](#set-blendshapes "Copy to clipboard")

The `Set Blendshapes` response type sets a blend shape weight on a BlendShapes component for a [3D Animation](/lens-studio/assets-pipeline/3d/animation/3d-animation.md).

![](/assets/images/behavior_setBlendshapes-d41936595db56d8410da86d66079a013.png)

* **Mesh Visual:** The mesh visual that has the blend shape component you want to affect.
* **Name:** The name of the blend shape to affect
* **Weight:** The weight to set this blend shape to.

### Set Material Parameter[​**](#set-material-parameter "Copy to clipboard")

The `Set Material Parameter` response type allows you to modify a material's parameter--for example, allowing you to change the base color of the default PBR material.

![](/assets/images/behavior_setMaterialParameter-1fdc29edd6b5af76d575bf355f615f0f.png)

* **Target Type:** Available options are `Material`, `MeshVisual`, `VFX Asset` and `VFX Component`.
* **Material:** The Material asset you want to affect.
* **Parameter Name:** The name of the parameter to affect.
* **Value Type:** The type of the value you want to pass in. It should match what the material expects. For example, if your material expects a color, you should choose `Color (RGBA)`.
* **Float Value:** The value to set this property to.

### Set Touch Blocking[​**](#set-touch-blocking "Copy to clipboard")

The `Set Touch Blocking` response type allows you to set how your Lens deal with touches.

![](/assets/images/behavior_setTouchBlocking-8461b96a36e1fcaeb620570f8ae9d2cc.png)

* **Interaction Component:** Apply the touch blocking only within the area of a Interaction Component so that touches are not passed to Snapchat.
* **Global Touch Blocking:** Apply the touch blocking around the whole screen so that touches are not passed to Snapchat.
* **Touch Blocking Exceptions:** Allow some types of touches to pass through to Snapchat. Usually you want to enable `DoubleTap` exceptions so that users can flip the camera while using your Lens.

### Show Hint[​**](#show-hint "Copy to clipboard")

The `Show Hint` response type allows you to trigger the Lens Hint. This hint text is localized to the region that the user is in

![](/assets/images/behavior_showHint-e70b4d8f619b9c6f7a0b55150f1f81a1.png)

* **Hint:** The hint text to show.
* **Duration:** How long the Hint should be shown before fading out.

### Machine Learning[​**](#machine-learning "Copy to clipboard")

The `Machine Learning` response type allows you to set up how an [ML Component should run](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md).

* **ML Component:** The ML Component to affect.
* **Action:** What action should be performed on the ML Component. Options are: `Build`, `Run Immediate`, `Run Scheduled`, `Cancel`, `Stop`.
* **Sync:** Whether to run the ML Component in synchronous mode.

### Instantiate Prefab[​**](#instantiate-prefab "Copy to clipboard")

The `Instantiate Prefab` response type instantiates the Prefab into the scene, and optionally gives the new object a Parent.

![](/assets/images/behavior_instantiatePrefab-c668809b84c871339f8ac6e7834a1eba.png)

* **Prefab:** The prefab to instantiate.
* **Parent:** If set, the instantiated object will use this as a parent.

### Destroy Object[​**](#destroy-object "Copy to clipboard")

The `Destroy Object` allows you destroy an object in the scene.

![](/assets/images/behavior_destroyObject-ba88884fc39a93bfc6f6b53407b991e0.png)

* **Object:** The object to destroy.

### Print Message[​**](#print-message "Copy to clipboard")

The `Print Message` response type prints a debug message to the `Logger` panel.

![](data:image/png;base64,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)

* **Message:** The message to print to the `Logger` panel.

### Call Object API[​**](#call-object-api "Copy to clipboard")

The Call Object API allows you to call the APIs on a script. You can call a function or set a property [exposed in another script's API](/lens-studio/features/scripting/script-overview.md).

![](/assets/images/behavior_callObject-1cf41da6b36a3f56c49ad6e01d45f56f.png)

* **Target Type:** Choose between (SceneObject, Component, Script API, or Global API).
* **Component:** The object to call upon.
* **Call Type:** Whether to call a function or set a property in the referenced script.
* **Function Name:** The name of the function to call.
* **Property Name:** The name of the property to set.
* **Argument:** The parameter to pass in to the function being called.
* **Value Type:** The type of the argument passed in.
* **Value:** The value to be set to the property if the property option is set.

### Send Custom Trigger[​**](#send-custom-trigger "Copy to clipboard")

The `Send Custom Trigger` response type sends a custom trigger message as a trigger to other Behavior helper scripts. The [On Custom Trigger](#on-custom-trigger) type can trigger based on the `Send Custom Trigger` response type.

![](/assets/images/behavior_Screen-Shot-2020-05-28-at-2.47.15-PM-898ecddc73d5635b422b51110fb3c2f2.png)

* **Trigger Name:** The name of the custom trigger to send.
* **Next in List:** Allows you to provide a list of custom triggers which Behavior will go through every time the response is triggered.

### Physics Apply Force[​**](#physics-apply-force "Copy to clipboard")

The `Physics Apply Force` response type allows you to affect a [physics](/lens-studio/features/physics/physics-overview.md) body.

![](/assets/images/behavior_physicsApplyForce-a8e9e24618c63f0db58b08b984df070f.png)

* **Body:** The physics body the force should be applied to.
* **Force Type:** The type of force to be applied: `Position` or `Rotation`.
* **Mode:** The way the force should be applied: `Force`, `Acceleration`, `Impulse`, `Velocity Change`, `Set Velocity`.
* **Force Value:** How much force should be applied.
* **Space:** What the force value is relative to: `World` or `Local`.

You can respond to physics collision events using the [Physics Collider Event](#physics-collider-event) response above.

## Script Interface[​**](#script-interface "Copy to clipboard")

In addition to configuring BehaviorScripts through the `Inspector` panel, it's also possible to interact with them through script. This means you can use your scripts to trigger BehaviorScript responses, or react to BehaviorScript triggers with your scripts.

### Local API[​**](#local-api "Copy to clipboard")

These functions are accessible on the `api` object of any `ScriptComponent` holding a BehaviorScript. They only affect the specific BehaviorScript being accessed.

* `api.trigger()` - Manually triggers the BehaviorScript's response
* `api.addTriggerResponse(callback)` - Adds a callback function to call when this BehaviorScript is triggered
* `api.removeTriggerResponse(callback)` - Removes the callback function from this BehaviorScript's response

```
//@input Component.ScriptComponent behaviorScript
function onTrigger() {
  print('behavior script triggered');
  // Remove our onTrigger() function from the BehaviorScript responses
  script.behaviorScript.api.removeTriggerResponse(onTrigger);
}
// Add our onTrigger() function as a response to the BehaviorScript being triggered
script.behaviorScript.api.addTriggerResponse(onTrigger);
```

### Global API[​**](#global-api "Copy to clipboard")

These functions are accessible on the `global.behaviorSystem` object from anywhere in script. They provide a way to globally send Custom Triggers or react to global Custom Triggers through script.

* `global.behaviorSystem.sendCustomTrigger(triggerName)` - Sends out a global Custom Trigger that BehaviorScripts can react to
* `global.behaviorSystem.addCustomTriggerResponse(triggerName, callback)` - Adds a callback function to call when the Custom Trigger is sent
* `global.behaviorSystem.removeCustomTriggerResponse(triggerName, callback)` - Removes the callback function from the Custom Trigger's responses

#### Example 1[​**](#example-1 "Copy to clipboard")

In this example, executing the line of code will trigger the `Print Message` response on the BehaviorScript.

```
// Send a global Custom Trigger that any BehaviorScript can react to
global.behaviorSystem.sendCustomTrigger('test_trigger');
```

![](/assets/images/behavior_globalExample1-8eb031c2fff3dd1e1768e03c4c79619b.png)

#### Example 2[​**](#example-2 "Copy to clipboard")

In this example, touching the screen will cause the BehaviorScript to send a Custom Trigger which is reacted to by a function in script.

```
function onTrigger() {
  print('on trigger');
  // Remove our onTrigger() function from the custom trigger's responses
  global.behaviorSystem.removeCustomTriggerResponse('my_trigger', onTrigger);
}
// Add our onTrigger() function as a response to the custom trigger "my_trigger"
global.behaviorSystem.addCustomTriggerResponse('my_trigger', onTrigger);
```

![](/assets/images/behavior_globalExample2-e70b0454c3745278135a515b5639b688.png)
