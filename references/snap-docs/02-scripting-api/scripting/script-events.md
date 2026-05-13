# Script Events

<!-- -->

![](/assets/images/script-events-lifecycle_2024-04-22-897b19ba0c877d88f08f742216bdce2d.png)

## Introduction[​**](#introduction "Copy to clipboard")

This guide provides a breakdown of Lens Events available. Scripts are triggered by binding them to these events. By default, all scripts are bound to the `On Awake` Event.

## Lens Events[​**](#lens-events "Copy to clipboard")

We've broken down the events into five categories: Scene, Camera, Touch, Keyboard and Other.

For a technical reference of all Lens Events, please visit the [Events API Reference](/lens-studio/api/lens-scripting/index.html).

## Scene Events[​**](#scene-events "Copy to clipboard")

These events are tied to the timing and execution of the Lens Scene. The ordering in which the scene objects are placed in the scene hierarchy will determine the execution time.

***

#### On Awake[​**](#on-awake "Copy to clipboard")

Scripts bound to this event will trigger before any other event in the Lens (including `OnStart` and `Update`). It also fires immediately on a newly instantiated or copied object, for instance before returning from `createComponent`. `OnAwake` should be used for a script to configure itself or define its API but not to access other ScriptComponents since they may not have yet received `OnAwake` themselves.

*Scripting API*

[OnAwakeEvent](/lens-studio/api/lens-scripting/classes/Built-In.OnAwakeEvent.html)

***

#### On Start[​**](#on-start "Copy to clipboard")

Scripts bound to this event will trigger before `Update` on the first frame a Component is enabled. This will be after all `OnAwake` events have triggered on the first frame and after a `createComponent` caller has had an opportunity to configure the Component. `OnStart` should be used to do initialization that depends on inputs or to access other Components which will have defined their inputs and methods during `OnAwake`.

*Scripting API*

[OnStartEvent](/lens-studio/api/lens-scripting/classes/Built-In.OnStartEvent.html)

***

#### On Destroy[​**](#on-destroy "Copy to clipboard")

Scripts bound to this event will trigger once the Script Component associated with the script has been destroyed while the Lens is running.

*Scripting API*

[OnDestroyEvent](/lens-studio/api/lens-scripting/classes/Built-In.OnDestroyEvent.html)

***

#### On Enable[​**](#on-enable "Copy to clipboard")

Scripts bound to this event will trigger once the associated Script Component is enabled.

*Scripting API*

[OnEnableEvent](/lens-studio/api/lens-scripting/classes/Built-In.OnEnableEvent.html)

***

#### On Disable[​**](#on-disable "Copy to clipboard")

Scripts bound to this event will trigger once the associated Script Component is disabled.

*Scripting API*

[OnDisableEvent](/lens-studio/api/lens-scripting/classes/Built-In.OnDisableEvent.html)

***

#### Update[​**](#update "Copy to clipboard")

Scripts bound to this event will trigger once on every frame update. This is handy for running code that changes things over time.

Multiple update events can cause slow performance.

*Scripting API*

[UpdateEvent](/lens-studio/api/lens-scripting/classes/Built-In.UpdateEvent.html)

***

#### Late Update[​**](#late-update "Copy to clipboard")

This event is triggered at the end of every frame, after normal `UpdateEvents` such as `Physics Events` or `Animation Events` but before rendering occurs.

*Scripting API*

[LateUpdateEvent](/lens-studio/api/lens-scripting/classes/Built-In.LateUpdateEvent.html)

***

## Face Events[​**](#face-events "Copy to clipboard")

These events are triggered based on user face actions (for example, opening or closing the mouth, raising eyebrows).

#### Brows Frowned[​**](#brows-frowned "Copy to clipboard")

Scripts bound to this event will trigger when a face's eyebrows are lowered.

*Scripting API*

[BrowsLoweredEvent](/lens-studio/api/lens-scripting/classes/Built-In.BrowsLoweredEvent.html)

***

#### Brows Raised[​**](#brows-raised "Copy to clipboard")

Scripts bound to this event will trigger when a face's eyebrows are raised.

*Scripting API*

[BrowsRaisedEvent](/lens-studio/api/lens-scripting/classes/Built-In.BrowsRaisedEvent.html)

***

#### Brows Returned To Normal[​**](#brows-returned-to-normal "Copy to clipboard")

Scripts bound to this event will trigger when a face's eyebrows are returned to a neutral pose.

*Scripting API*

[BrowsReturnedToNormalEvent](/lens-studio/api/lens-scripting/classes/Built-In.BrowsReturnedToNormalEvent.html)

***

#### Face Found[​**](#face-found "Copy to clipboard")

Scripts bound to this event will trigger when a face enters the video frame.

*Scripting API*

[FaceFoundevent](/lens-studio/api/lens-scripting/classes/Built-In.FaceFoundEvent.html)

***

#### Face Lost[​**](#face-lost "Copy to clipboard")

Scripts bound to this event will trigger when a face leaves the video frame.

*Scripting API*

[FaceLostEvent](/lens-studio/api/lens-scripting/classes/Built-In.FaceLostEvent.html)

***

#### Mouth Closed[​**](#mouth-closed "Copy to clipboard")

Scripts bound to this event will trigger when a face's mouth closes.

*Scripting API*

[MouthClosedEvent](/lens-studio/api/lens-scripting/classes/Built-In.MouthClosedEvent.html)

***

#### Mouth Opened[​**](#mouth-opened "Copy to clipboard")

Scripts bound to this event will trigger when a face's mouth opens.

*Scripting API*

[MouthOpenedEvent](/lens-studio/api/lens-scripting/classes/Built-In.MouthOpenedEvent.html)

***

***

## Camera Events[​**](#camera-events "Copy to clipboard")

These events are triggered when a change is made to the current device camera.

#### Switched To Front Camera[​**](#switched-to-front-camera "Copy to clipboard")

Scripts bound to this event will trigger once when the camera is switched to the front (selfie) camera.

*Scripting API*

[CameraFrontEvent](/lens-studio/api/lens-scripting/classes/Built-In.CameraFrontEvent.html)

***

#### Switched To Rear Camera[​**](#switched-to-rear-camera "Copy to clipboard")

Scripts bound to this event will trigger once when the camera is switched to the rear (world) camera.

*Scripting API*

[CameraBackEvent](/lens-studio/api/lens-scripting/classes/Built-In.CameraBackEvent.html)

***

## Touch Events[​**](#touch-events "Copy to clipboard")

These events are triggered by user touch gestures. To use these events, you'll need a Scene Object with a `Touch` Component. To learn more about using the `Touch` Component, refer to the [Touch Input guide.](/lens-studio/features/scripting/touch-input.md)

***

#### Touch Started[​**](#touch-started "Copy to clipboard")

Scripts bound to this event will trigger once when the user starts a Touch gesture.

*Scripting API*

[TouchStartEvent](/lens-studio/api/lens-scripting/classes/Built-In.TouchStartEvent.html)

***

#### Touch Moved[​**](#touch-moved "Copy to clipboard")

Scripts bound to this event will trigger once every frame while the user is moving their finger during a Touch gesture (that is, dragging their finger).

*Scripting API*

[TouchMoveEvent](/lens-studio/api/lens-scripting/classes/Built-In.TouchMoveEvent.html)

***

#### Touch Ended[​**](#touch-ended "Copy to clipboard")

Scripts bound to this event will trigger once when the user ends a Touch gesture (that is, lifts their finger).

*Scripting API*

[TouchEndEvent](/lens-studio/api/lens-scripting/classes/Built-In.TouchEndEvent.html)

***

#### SnapRecordStartEvent[​**](#snaprecordstartevent "Copy to clipboard")

Scripts Bound to this event will be triggered when the user starts long pressing the capture button to record a Snap.

*Scripting API*

[SnapRecordStartEvent](/lens-studio/api/lens-scripting/classes/Built-In.SnapRecordStartEvent.html)

***

#### SnapRecordStopEvent[​**](#snaprecordstopevent "Copy to clipboard")

Scripts Bound to this event will be triggered when the user stops long pressing the Snap button to end recording of a Snap.

*Scripting API*

[SnapRecordStopEvent](/lens-studio/api/lens-scripting/classes/Built-In.SnapRecordStopEvent.html)

***

#### SnapImageCaptureEvent[​**](#snapimagecaptureevent "Copy to clipboard")

Scripts Bound to this event will be triggered when the user taps on the capture button to record an image.

*Scripting API*

[SnapImageCaptureEvent](/lens-studio/api/lens-scripting/classes/Built-In.SnapImageCaptureEvent.html)

***

## Keyboard Events[​**](#keyboard-events "Copy to clipboard")

These events are triggered by keyboard input. Use `KeyPressEvent` and `KeyReleaseEvent` to react when keys are pressed or released. Event data includes the key (via the [Keys](/lens-studio/api/lens-scripting/enums/Built-In.Keys.html) enum) and modifiers such as Shift, Control, Alt, and Meta (via the [KeyModifiers](/lens-studio/api/lens-scripting/enums/Built-In.KeyModifiers.html) enum). To check whether a key is currently held down—for example, for movement or game controls—use [KeyboardManager.isKeyPressed](/lens-studio/api/lens-scripting.html#iskeypressed) in your script.

***

#### Key Pressed[​**](#key-pressed "Copy to clipboard")

Scripts bound to this event will trigger when a key is pressed.

*Scripting API*

[KeyPressEvent](/lens-studio/api/lens-scripting/classes/Built-In.KeyPressEvent.html)

***

#### Key Released[​**](#key-released "Copy to clipboard")

Scripts bound to this event will trigger when a key is released.

*Scripting API*

[KeyReleaseEvent](/lens-studio/api/lens-scripting/classes/Built-In.KeyReleaseEvent.html)

***

## Other Events[​**](#other-events "Copy to clipboard")

In addition to the selectable events described above, there are many other events that can be bound in script. To learn more about binding events in script, please visit the [section below](#binding-events-in-script).

***

#### Lens Turned Off[​**](#lens-turned-off "Copy to clipboard")

Scripts bound to this event will trigger once when the Lens is exited (if the user switches to another Lens, or closes the Lens carousel).

*Scripting API*

[TurnOffEvent](/lens-studio/api/lens-scripting/classes/Built-In.DelayedCallbackEvent.html)

***

#### Delayed Callback[​**](#delayed-callback "Copy to clipboard")

Scripts bound to this event will trigger after a specified amount of time. This event can be used as a countdown timer.

*Scripting API*

[DelayedCallBackEvent](/lens-studio/api/lens-scripting/classes/Built-In.DelayedCallbackEvent.html)

***

#### Manipulate Start[​**](#manipulate-start "Copy to clipboard")

Scripts bound to this event will trigger when the user starts a [Manipulate gesture](/lens-studio/lens-studio-workflow/scene-set-up/3d/manipulation.md).

*Scripting API*

[ManipulateStartEvent](/lens-studio/api/lens-scripting/classes/Built-In.ManipulateStartEvent.html)

***

#### Manipulate End[​**](#manipulate-end "Copy to clipboard")

Scripts bound to this event will trigger when the user ends a [Manipulate gesture](/lens-studio/lens-studio-workflow/scene-set-up/3d/manipulation.md).

*Scripting API*

[ManipulateEndEvent](/lens-studio/api/lens-scripting/classes/Built-In.ManipulateEndEvent.html)

***

## Binding Events In Script[​**](#binding-events-in-script "Copy to clipboard")

You can bind a function to a Lens Event as follows:

* JavaScript
* TypeScript

```
function printTime(eventData) {
  // Print the elapsed Lens time
  print(getTime().toString());
}
// Bind the function printTime to the event UpdateEvent
var event = script.createEvent('UpdateEvent');
event.bind(printTime);
```

```
@component
export class NewScript extends BaseScriptComponent {
  onAwake() {
    let event = this.createEvent('UpdateEvent');
    // Bind the function printTime to the event UpdateEvent
    event.bind(this.printTime.bind(this));
  }

  printTime(eventData: UpdateEvent) {
    // Print the elapsed Lens time
    print(getTime().toString());
  }
}
```

In this example, the function `printTime` is bound to the [UpdateEvent](/lens-studio/api/lens-scripting/classes/Built-In.UpdateEvent.html) using a [SceneEvent](/lens-studio/api/lens-scripting/classes/Built-In.SceneEvent.html).

To learn more about what the Script Component can do with events, visit the [Script Component API Documentation](/lens-studio/api/lens-scripting/classes/Built-In.ScriptComponent.html).
