# Hand Gestures

This template allows you to trigger different effects based on recognized hand gestures. The template uses Hand Gestures to show a stylized picture of a recognized gesture, as well as triggering a sound effect. It provides an easy way to interact with the following gestures (each gesture is seen in the image below):

[](/img/lens-studio/hand-gestures_hand-gestures.webm)

## Tutorial[​**](#tutorial "Copy to clipboard")

## Template Walkthrough[​**](#template-walkthrough "Copy to clipboard")

Let’s take a high level overview of the project. It can be split into three major parts:

* Hand Tracking
* Gesture Detection and Emitting Events
* Responding to the Events and Triggering Effects

The Hand Tracking part is managed by the Object Tracking component, which is attached to the `Orthographic Camera > Hand Tracking Region > Hand Tracking > Hand Center`. In addition to tracking the hand, this component can also look for hand gestures.

This is the same hand tracking that is used in the [Hand Template](/lens-studio/features/ar-tracking/hand/hand-tracking-templates/hand.md))

![](/assets/images/hand-gestures_hg-1-094bb8dcaae97399046537d984e87838.png)

Emitting events is handled by the `Hand Gesture Controller` object. If you select this object, you can see, in the `Inspector` panel, that it takes an Object Tracking component and a list of Behavior triggers to emit for each of the recognizable gestures. So that every time the Object Tracking component detects a hand gesture, this script emits the given list of triggers.

Take a look at the `Hand Gesture Controller` script to see how you can detect a hand gesture event yourself through script! Try adding the `thumb` gesture.

![](/assets/images/hand-gestures_hg-2-df54a034eb5a9b6a7cbb1408a5e72e38.png)

We can use the Behavior script to respond to the hand gestures events. This template provides two examples of using the Behavior script to respond to detection of a hand gesture:

* Instantiating prefabs
* Playing sounds

Prefab is a convenient way to instantiate the same objects multiple times. Take a look at the [Prefab](/lens-studio/lens-studio-workflow/prefabs.md) guide for more information

### Instantiating Prefabs[​**](#instantiating-prefabs "Copy to clipboard")

Instantiating of prefabs is controlled by a set of instantiators. These instantiators are just scene objects with attached Behavior script. Those Behavior scripts are set to react on custom triggers and each of them instantiates a prefab according to a trigger it is set to respond to.

You can find examples of these instantiators at `Orthographic Camera > Hand Tracking Region > Hand Tracking > Hand Center > Hand Prefabs Instantiator` and `Orthographic Camera > Bottom UI Region > UI Prefabs Instantiator`.

![](/assets/images/hand-gestures_hg-3-fb6ea1479ddea085e2174942b7ab2f07.png)

#### Source Prefabs[​**](#source-prefabs "Copy to clipboard")

These instantiators instantiate two different sets of prefabs:

* **Hand Tracking objects** are stylized pictures of hand gestures that are instantiated at hand position when a hand gesture is detected.
* **Bottom UI objects** are images at the bottom of the screen that slightly pop and fill themselves with a color when a hand gesture is detected as well.

You can find these objects in `Orthographic Camera > Hand Tracking Region > Hand Tracking > Prefabs Source [EDIT_CHILDREN]` and `Orthographic Camera > Bottom UI Region > UI Prefabs Source [EDIT_CHILDREN]` respectively.

![](/assets/images/hand-gestures_7-7d90f0c20d66293d0fcdd259351acc66.png)

If you expand these objects you can see a number of prefabs. These prefabs are used as source prefabs for the instances which are instantiated when a hand gesture is detected.

#### Editing Prefabs[​**](#editing-prefabs "Copy to clipboard")

To modify what is instantiated when a hand gesture is detected, you can modify each related prefab found underneath the objects labeled `[EDIT_CHILDREN]`.

For example, if you want to replace images to be instantiated, select the prefab in the `Scene Hierarchy` panel, then in the `Inspector` panel, set a new texture for the `Image Component`. Finally, to save your prefab, hit the `Apply` button at the top of the Inspector panel. You need to save a prefab to have your changes in action.

![](/assets/images/hand-gestures_hg-4-29e425f33462e2ecd23a98a1a56d97e6.png)

Make sure that the prefab you are editing is enabled in the `Scene Hierarchy` panel, otherwise your prefab will be instantiated disabled! By default, we disable the parent object so that when the Lens open, you don’t actually see the prefab until it’s instantiated.

### Sound[​**](#sound "Copy to clipboard")

Another way to respond to the hand gesture events is to play sound on gesture detection. There is the same logic behind the sound effects in this template: a Behavior script is set to respond to a custom trigger with playing a given sound effect. You can find sound controllers under `Sound Effects` in the `Scene Hierarchy` panel.

For example, to change which sound is played when the `Close` hand gesture is detected, you can select the `Close SFX`object in the `Scene Hierarchy` panel, then, in the `Inspector` panel, change the behavior script to target a different Audio Track by clicking the `Audio Track` field.

### More Hand Gestures Effect[​**](#more-hand-gestures-effect "Copy to clipboard")

While the Hand Gestures template only provides an example of playing a sound, as well as instantiating prefabs, you can add your own responses to different gestures.

#### Using Behavior[​**](#using-behavior "Copy to clipboard")

You can do things like: play an animation, call a tween, set text, and more by using the Behavior script. To do this, create a new object in the `Scene Hierarchy` panel, then drag the `Behavior` script from the `Asset Browser` panel to the `Inspector` panel.

Then, set the Behavior to use On Custom Trigger. You can use the following triggers for each gesture:

* `open_gesture_trigger`
* `close_gesture_trigger`
* `horns_gesture_trigger`
* `index_finger_gesture_trigger`
* `victory_gesture_trigger`

![](/assets/images/hand-gestures_hg5-b0e6c2ce15e4087e8a432862274d6105.png)

You can change the trigger names by modifying the values for each gesture in the `Hand Gesture Trigger` object.

#### Adding Additional Gesture triggers[​**](#adding-additional-gesturetriggers "Copy to clipboard")

You can add a trigger by modifying the HandGestureController script. For example, lets add the `thumb` trigger

First, add a new input for the trigger:

```
//@input string[] thumbTriggers
```

Then add it to the list of labels:

```
var labels = ['open', 'close', 'horns', 'index_finger', 'victory', 'thumb'];
```

Finally, map the label to the triggers list:

```
var customMap = {
    open: script.openTriggers,
    close: script.closeTriggers,
    horns: script.hornsTriggers,
    index_finger: script.indexFingerTriggers,
    victory: script.victoryTriggers,
    thumb: script.thumbTriggers,
};
Using a custom script
```

You can also respond to these triggers in script by listening to the Behavior Script

```
global.behaviorSystem.addCustomTriggerResponse(triggerName, callback);
```

For example, if you wanted to print a message in the logger when Open Trigger is called:

```
global.behaviorSystem.addCustomTriggerResponse(“open_gesture_trigger”, function() {
    print(“open gesture detected”);
});
```

You can subscribe to a hand gesture event directly. Take a look at the [Hand Gesture Guide](/lens-studio/features/ar-tracking/hand/hand-gestures.md) for more information.

Hand gestures recognition is a feature that allows you to perform some actions when a hand gesture is detected. For more information and to see how it works please look at the Hand Gestures Guide.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
