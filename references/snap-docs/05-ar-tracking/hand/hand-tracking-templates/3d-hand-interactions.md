# 3D Hand Interactions

The 3D Hand Interactions Assets enable you to create custom interactions (such as hand gestures) with the [Object Tracking 3D](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) component through helper scripts and gesture examples provided in the assets.

These assets provide some example custom interactions and helper scripts to help you get started. However, these interactions are built in the Lens through scripting. The scripts are heavily commented so you can try copy and pasting them to see how they work! If you are looking to make advanced or more custom interactions, we recommend some understanding of [scripting](/lens-studio/features/scripting/script-overview.md).

[](/img/lens-studio/3d-hand-interactions_3dhand-frog.webm)

## Guide[​**](#guide "Copy to clipboard")

These assets come with several setups to showcase how you can create interactions based on the hand

* [Object Tracking 3D Component](#object-tracking-3d-component) - An overview of how we are able to detect interactions and custom gestures
* [Tracking Manager](#tracking-manager) - An overview of the helper scripts provided by the assets to help you build interactions
* [Gesture Triggers](#gesture-triggers) - How you can define your own custom hand interactions using the helpers above

Using these helpers, we provide several interaction demos:

* [Hand Interaction Examples](#hand-interaction-examples)

  * [Grab Object with Hand](#grab-object-with-hand) - How you can use hand gestures to create a complex effect
  * [Scissors Trigger](#scissors-trigger) - How you can combine multiple gestures to create one effect
  * [Rotate Spoon by Index Finger](#rotate-spoon-by-index-finger) - How you can use the 3d positions of hand joints with gestures

### Importing the examples[​**](#importing-the-examples "Copy to clipboard")

You can find these examples and helpers as importable assets in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

Import the `Gesture Trigger` asset to see a minimal implementation of this technique.

Alternatively import the `Grab Object With Hand`, `Gesture Scissors Trigger` and `Rotate With Finger` assets to see various interactions based on `Gesture Trigger`.

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/hand-interactions-example-1-2c03d56b69147a470fd336bb6de33218.png)

Next, drag the prefab inside the newly imported asset to the `Scene Hierarchy` panel to add them to your Lens.

[](/img/lens-studio/5-features/hand-interactions-example-2.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/hand-interactions-example-3-830b619c70cf170a232523bbf550d8d1.png)

### Object Tracking 3D Component[​**](#object-tracking-3d-component "Copy to clipboard")

![](/img/lens-studio/3d-hand-interactions_3dhand1.jpg)

The Hand Interactions example here is made possible by the [Object Tracking 3D](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) component with the `Hand Tracking Asset`, which allows the Lens to track joints of the hand in 3D space. The tracking data from this component is then processed by scripts provided in this example to detect poses or gestures made by the hand.

There are [built in gestures](/lens-studio/features/ar-tracking/hand/hand-gestures.md) that a Lens can detect using machine learning. These assets demonstrate using the joints provided by 3D hand tracking to define custom gestures.

### Tracking Manager[​**](#tracking-manager "Copy to clipboard")

![](/assets/images/hand-interactions-example-4-63f9337f20d77b501b70079c279db614.png)

The `Tracking Manager` object at top of the assets' hierarchy handles all hand interactions in the examples. Make sure to keep this object enabled at all times.

`Left Hand Tracking` and `Right Hand Tracking` code would get hand tracking related data from its related 3D Hand Tracking component. The `GlobalTrackingHelper` Script contains global utility functions that can be called by any custom script.

Turn off the `ShowJoints` and `ShowBones` option on these scripts to hide hand joints and bones in the `Preview` panel.

Check out the `GlobalTrackingHelper` script by double-clicking on it from the `Hand Tracking Assets > Scripts` folder in the `Asset Browser` panel to see details of what each global function does and how to use them!

![](/assets/images/hand-interactions-example-5-52b95499cca8fd07a48e0a63805756ba.png)

Global function is a good way for scripts across the whole project to access one function. Check out the section on the **Global Scope** in the scripting [reference page](/lens-studio/features/scripting/scripting-introduction.md#global-scope). Note that you should be careful when using globals, as it might be unclear to the user where a function is coming from. We are using it here to enable faster development, since these utilities would be used often and in many places. However, the scripts in these assets will always use `global.` as a prefix to any global function to help clarify where a function is coming from.

### Gesture Triggers[​**](#gesture-triggers "Copy to clipboard")

![](/assets/images/hand-interactions-example-6-f9f20307a49e4d9c4c1a4436500d165b.png)

Under the `Gesture Triggers` object you’ll find modular helper scripts that define hand gestures based on distances between specific fingers, and send out behavior triggers based on whether the hand gesture is detected.

We are using the word "gesture" here colloquially, not as a reference to the built-in [Hand Gesture detection](/lens-studio/features/ar-tracking/hand/hand-gestures.md) available in Lenses.

#### Thumbs Up example[​**](#thumbs-up-example "Copy to clipboard")

Let's explore one of the examples to see how we can make a custom interaction. In this case, the Thumbs Up gesture is made when the index, middle, ring and pinky fingers are curved into the palm, and when the thumb is sticking out.

The way we define this gesture is by checking distances between the following:

* To make sure index, mid, ring and pinky are curved in:

  <!-- -->

  * Distance between pinky finger tip joint and wrist joint is smaller than 9
  * Distance between Ring finger tip and wrist joint is smaller than 9
  * Distance between Middle finger tip and wrist joint is smaller than 9
  * Distance between Index finger tip and wrist joint is smaller than 9

* To make sure thumb is sticking out:

  <!-- -->

  * Distance between Thumb finger tip and wrist joint is larger than 9
  * Distance between Thumb finger tip and index root is larger than 5

These checks are performed by the `GetJointDistance` script attached to each object under the Thumbs Up object. Feel free to customize this script to see how that affects gesture checks!

You can either input one joint name for each Joint Group, or a list of joint names which will return the middle position for the joint. For example, a list of: `index-0, mid-0, ring-0 and pinky-0` will return a median point of all these joints. The lower the number, the closer the joint is to the wrist.

![](/assets/images/hand-interactions-example-7-17c99db78d4f3df4373d2c802c4c9f00.png)

The `GetJointDistanceManager` script attached on the Thumbs Up object will get conditions from all these scripts, and send out a `Gesture Detected` trigger and `Gesture Lost` trigger when gesture is detected and lost.

![](/assets/images/hand-interactions-example-8-f7a72bdea1c442a0eafbd0c9f97ab39c.png)

Turning on the `OverwriteVisual` and `ShowVisualizer` options will enable you to visualize each distance being checked based on child scripts connected to the `ScriptContainer` object, instead of the option in the manager.

Turning on the `SetTextColor` option will change the text color of the distance logger based on whether it’s within Range or not. This is useful for debugging.

![](/assets/images/hand-interactions-example-9-5adb9c4d49cd380c42d7726465980041.png)

As we can see in the preview, the shown gesture has its thumb sticking out which grants the `PassColor` yellow to thumb distance checks, and the rest of fingers aren’t curved in which gives them the `DefaultColor` blue.

[](/img/lens-studio/3d-hand-interactions_3D-Hand-Thumbsup.webm)

Feel free to duplicate from any of these examples under the `Gesture Triggers` example, and create your own gestures! Note that not all fingers need to be defined, if you want to create a gesture in which only certain fingers are defined, feel free to do so!

#### Responding to Gesture Triggers[​**](#responding-to-gesture-triggers "Copy to clipboard")

![](/assets/images/3d-hand-interactions_gesture_trigger-778858da431f8e964cf938cb6f055083.jpg)

`Gesture Hints` object show 3 hints on screen by default which can respond to the triggers above. Try making these gestures to make them disappear!

[](/img/lens-studio/3d-hand-interactions_gesture_trigger1.webm)

The `Trigger Sound` example triggers a sound every time a gesture is recognized. Turn on your volume to hear how it’s played with the example preview video! And feel free to customize these triggers to anything else!

## Hand Interaction Examples[​**](#hand-interaction-examples "Copy to clipboard")

In the Asset Library, you’ll find various examples of hand interactions. Import them to try it in your project!

Each interaction asset has the same base helpers as described above. The assets simply demonstrate how you might use them.

### Grab Object with Hand[​**](#grab-object-with-hand "Copy to clipboard")

[](/img/lens-studio/3d-hand-interactions_3D-Hand-Frog-Grab.webm)

This example lets you grab an object (e.g. the Frog with a helipad) in the scene. The example is composed of a few interactive scripts that work with each others to create this interaction:

* The `Grab Trigger` (SingleGestureTrigger.js) which sends out a behavior trigger when the action ‘Grab’ is detected.
* The `Set Follow Hand Helper` (SetFollowHandHelper.js) which is a generic script that can set any object to follow any arbitrary joints’ median position and rotation of hand with an option of starting follow on behavior trigger.
* The `Distance Indicator` which has the `GetJointDistance` script which will show distance between hand and object in Preview.

Try modifying parameters on any of these scripts to see how it affects the project!

### Gesture Scissors Trigger[​**](#gesture-scissors-trigger "Copy to clipboard")

[](/img/lens-studio/3d-hand-interactions_3dhand_scissors.webm)

The `Scissors Trigger` example triggers a ‘scissor cut’ action. It uses the `SequencedGestureTrigger` script which works similar to the `SingleGestureTrigger` script mentioned above. The only difference is that `SequencedGestureTrigger` would trigger a sequence of gestures instead of only one.

Try checking out the `getGesture()` function in `SequencedGestureTrigger` script to see how the sequenced gesture is defined!

![](/assets/images/hand-interactions-example-10-849293f42541c17972509e0fa74cb73a.png)

You can right click on the imported package and select `Unpack for Editing`. Then, double click on `Hand Tracking Assets > Scripts > Helpers > SequencedGestureTrigger` to see how the interaction is done.

### Rotate With Finger[​**](#rotate-with-finger "Copy to clipboard")

![](/assets/images/hand-interactions-example-11-1fd18afdc59d1dac9273b21b3e23c55a.png)

In this example we can use our index finger to ‘stir’ this spoon in the coffee cup. This is done with the `RotateObjectByFingerHelper` script.

As before, you can right click on the imported package and select `Unpack for Editing`. Then, double click on `Hand Tracking Assets > Scripts > Helpers > RotateObjectByFingerHelper` to see how the interaction is done.

This script takes a position from the `GetPositionScript`, and uses it to rotate an object along the axis in `RotateAmount`. It also has an option to change VFX value with the same position input, as you can see in this example we’ve provided a steam effect which increases in its density when finger stirs faster.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
