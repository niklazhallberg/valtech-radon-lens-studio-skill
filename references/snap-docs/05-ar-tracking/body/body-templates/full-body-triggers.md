# Full Body Triggers

To make it easier for you to mix-and-match our different examples, this template has been converted to an importable asset in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) with the name `Full Body Trigger - T Pose`, `Full Body Trigger - Screen` and `Full Body Trigger - Distance`.

The Full Body Trigger Template allows you to trigger different screen effects with different body movements, such as custom body gestures, touch screen triggers and distance check between joints and screen elements.

[](/img/lens-studio/full-body-triggers_fbtrigger-preview.webm)

The Full Body Attachment template differs from the [Skeletal](/lens-studio/features/ar-tracking/body/body-templates/skeletal.md) as it requires the user to be even further from the camera in exchange for more joints tracked as it uses the [Full Body Tracking system](/lens-studio/features/ar-tracking/world/object-tracking.md) rather than the Upper Body Tracking system . In addition, instead of Head joint it provides access to the face points such as Nose, Eye Left/Right, Ear Left/Right.

## Tutorial[​**](#tutorial "Copy to clipboard")

## Guide[​**](#guide "Copy to clipboard")

To create your own Full Body Trigger Lens you will need:

* **Triggers:** This can be body gesture, distance check between body joints, or distance check between body joints and a screen transform
* **Trigger Responses:** What should happen when a trigger occurs: e.g. triggering Behavior, playing tweens etc.
* **Visual Effects:** This can be full screen effects, visual effects attached to the body, or anything else that you want Trigger Response to use

![](/assets/images/full-body-triggers_full-body-triggers-1-f81a613fd4041dc210c3de58477d8340.jpg)

### Switching Preview Video[​**](#switching-preview-video "Copy to clipboard")

When working with this Template, you’ll want to switch the preview video to one with a person’s body. In the `Preview` panel, select the `Image / Video Mode` button.

![](/assets/images/full-body-triggers_full-body-templates-2-1654dfe21d644112ae5152e32f82e777.png)

Then, in the drop down at the top of the Preview panel, choose the `Dance` or the `Skeletal` preview video.

Record your own videos or make photos and set them as a lens studio preview by clicking on `+ From Files` button at the bottom of the preview panel dropdown list.

![](/assets/images/full-body-triggers_full-body-templates-3-fc950794e3b4bd9c67ea8247f423373f.png)

You should now see the content tracked to the body in the video. You can also switch to Webcam Mode to see the content attached to yourself.

![](data:image/png;base64,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)

### Full Body Tracking[​**](#full-body-tracking "Copy to clipboard")

The Full Body Tracking provides 2D screen points that represent user’s joints / parts of the body. It is the basis of this template.

You can find all the joint objects under`Full Body Tracking Controller`and on the `FullBodyTrackingController` script under `Advanced` section.

![](/assets/images/full-body-triggers_full-body-triggers-2-aefcfccc0f2153d3539f0a196bc8aeb4.jpg)

To attach mesh or images to a certain joint, just put the object as their child or use [Pin to Mesh](https://lensstudio.snapchat.com/guides/3d/pin-to-mesh/) to connect them to the joint. In this template we have attached simple 2D colored dots.

You can preview how joints are tracked by turning on the joint debug view. To do this go to `JointDebugHelper` under the `Helper Scripts [EDIT_ME]` object and check `Show Debug Joints`.

### Movement Trigger Types[​**](#movement-trigger-types "Copy to clipboard")

Under `Effect Trigger Examples` you’ll find a few objects each with the `MovementTrigger` script attached such as

* T Pose
* Right Foot Click
* ScreenTrigger Swarm
* ScreenTrigger Party Hat.

Each of these objects has a `MovementTrigger` script attached to them. The `MovementTrigger` script allows you to set up triggers with different `Movement Types`. There are 3 different movement types: `Gesture`, `Screen Trigger` and `Distance`.

#### Gesture[​**](#gesture "Copy to clipboard")

[](/img/lens-studio/full-body-triggers_full-body-triggers-3.webm)

`T Pose` and `Right Foot Click` uses `Gesture` as their movement types.

![](/assets/images/full-body-triggers_full-body-triggers-4-f6f3844a8b73b05dec96fa0a4ed15891.jpg)

Each `Gesture` is composed of a list of pose triggers listed in the `Gesture Poses` input field. For example, the pose triggers for Right Foot Click are `RIGHT_LEG_OUT` and `RIGHT_LEG_CLICK`. Each of these poses are defined in the `GesturesLibrary`script.

![](/assets/images/full-body-triggers_full-body-triggers-5-f49ad6f6386d17a7a713e9e49ac150de.jpg)

When the first pose is matched to the user in the camera, with tolerance of the value of `Threshold`, the list of `Behavior` triggers in `Start Trigger` is called. Similarly, when the last post is matched, the list of `Complete Trigger` is called.

You can add a custom pose to the `GestureController` script by tapping the screen at a certain time, it will print out the relative position of the joints at the time of the tapping.

[](/img/lens-studio/full-body-triggers_full-body-triggers-6.webm)

Then you can copy the printed message and paste it into the `GestureLibrary` script and create your own pose!

You can also remove some of the values (name and value) provided by the logger message if those joints don’t matter for your pose.

![](/assets/images/full-body-triggers_full-body-triggers-7-3f2973ddb6ada025ebc9d8f25cef3ec2.jpg)

#### Touch Screen Trigger[​**](#touch-screen-trigger "Copy to clipboard")

[](/img/lens-studio/full-body-triggers_full-body-triggers-8.webm)

The `ScreenTrigger Swarm` object and `ScreenTrigger Party Hat` object uses `Touch Screen Trigger` as their `Movement Type` in `MovementTrigger` script.

In this case `Touch Screen Trigger` is related to the body’s joint “touching” the screen transform area based on the camera video, not touching the device screen. To learn more about screen touches on device, check out this [guide](/lens-studio/features/scripting/touch-input.md).

![](/assets/images/full-body-triggers_full-body-triggers-9-f2e3dd8c06d604a526ae0070cd9efadc.jpg)

In this mode you’ll input a ScreenTransform as the trigger area and select a joint from the drop list, then the script will check the distance between the joint and the screen trigger. It will send out `Start Trigger` and `Complete Trigger` if distance is smaller than the `Threshold` value.

Because screen trigger is instantaneous in comparison to gesture trigger, the effect here often checks `Has End Time` and is given an `Effect Length`.

#### Distance Check[​**](#distance-check "Copy to clipboard")

![](/assets/images/full-body-triggers_full-body-triggers-10-4ad099eab59aafe063d5eef39edd85ec.jpg)

`Distance Check` checks the distance between two joints and compares it against the `Threshold`, and sends out `Start Trigger` and `Complete Trigger` if distance is smaller than the `Threshold`.

#### Distance Modifier[​**](#distance-modifier "Copy to clipboard")

![](/assets/images/full-body-triggers_full-body-triggers-11-a63878802dce8d4014302c396c0a9497.jpg)

Different from `Distance Check` in `MovementTrigger`, `Distance Modifier` takes the distance between `Main Joint` and `Target Joint` or `Target Object` with a screen transform component and uses the distance to change a given `Parameter` on a material.

In the case of the example, the distance between left and right wrists is modifying a pixelated full screen effect.

[](/img/lens-studio/full-body-triggers_full-body-triggers-12.webm)

### Movement Trigger Response[​**](#movement-trigger-response "Copy to clipboard")

Under each object in `Effect Trigger Examples`, there is a Response object with a `MovementTriggerResponse` script.

![](/assets/images/full-body-triggers_full-body-triggers-13-f08710f1bcaa3e5906b8e25382e41c2d.jpg)

Each response object handles calling the visual effects for each trigger. They communicate through a Behavior Custom trigger string. We need to make sure that the Start and End trigger strings match each other in the `MovementTrigger` and `MovementTriggerResponse` script.

![](/assets/images/full-body-triggers_full-body-triggers-14-ff4f56e220e18ecc340a81973b5ed453.jpg)

In the `MovementTriggerResponse` script, there are four different response types:

* **Trigger Objects:** Objects here will be turned on when trigger is started, and off when trigger ends
* **Trigger Tweens:** Objects here with tween scripts attached to them will have their tween triggered with the tween name same as `Fade In Tween` and `Fade Out` Tween found in the `Advanced` section of the Script component (by default it is ‘`FADEIN`’ and ‘`FADEOUT`’).

![](/assets/images/full-body-triggers_full-body-triggers-15-af2562394dbe544e67eae77296e17715.jpg)

* **Trigger Animated Textures:** Animated textures input here will be started and stopped when the trigger starts and stops.
* **Particle Bursts:** Particle Systems with the `ParticleControllerHelper` script attached will have a ‘burst’ effect triggered when the trigger starts. Make sure `External Time` and `Instant Spawn` are both checked on the Particle System material so that the `ParticleControllerHelper` script can modify the parameters.

![](/assets/images/full-body-triggers_full-body-triggers-16-88090166ae72c2d4218f415f313add55.jpg)

#### Behavior Response[​**](#behavior-response "Copy to clipboard")

You can also respond to Movement Triggers by using Behavior scripts. For example, on the `FootClick_Response_Behavior` object, all animations and fullscreen effects are triggered with `Behavior` scripts.

Each Behavior script is set to run on a custom trigger with the trigger name corresponding to the triggers in `MovementTrigger`.

![](/assets/images/full-body-triggers_full-body-triggers-17-ef7b690b025934ec63db2ecfab64dacf.jpg)

The advantage of using Behavior scripts is having a very wide range selection of responses and having delays to the trigger as well.

To learn more about Behavior script, check out the official [Behavior Script guide](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md)!

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your world Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
