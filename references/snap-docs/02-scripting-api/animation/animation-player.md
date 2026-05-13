# Animation Player

AnimationPlayer handles animations created by other 3D creation software.

Prior to Lens Studio 5.0.10, animations leveraged Animation Mixer instead of Animation Player. Take a look at the Animation Mixer doc to learn more about the old system.

## Animation Player Component[​**](#animation-player-component "Copy to clipboard")

Animations are played through the Animation Player component. The component takes in a list of `Animation Clips`, and allows you to play, stop, resume, subscribe to animation events, and more.

![](/assets/images/animation-player-1-566e6101ca2cd597e0f8145b76bcc74a.png)

* **Autoplay** - Specifies if clips should play on initialization.
* **Animation Clips** - Array of animation clips. You can add Animation Clips by pressing `+ Add Value`.

### Animation Clips[​**](#animation-clips "Copy to clipboard")

Animation Clip is what an `Animation Player` uses to manage playback for a specific animation. It defines the playback speed, clip duration, sample speed, weight. This asset takes in a single Animation Asset. Animation Clips are created within the Animation Player Component.

![](/assets/images/animation-player-2-773183d9c3b20ab6cb673df427caaf94.png)

* **Animation Asset** - Points to the animation asset to be played by the Animation Player.

* **Name** - Name of the clip. Way to refer to the clip in code.

* **Weight** - Strength of animation clip contribution. Lies between \[0.0f, 1.0f] inclusive.

* **Begin** - The start time of clip. In seconds, based on the export fps.

* **End** - The end time of clip.In seconds, based on the export fps.

* **Reversed** - Specifies if the clip should be played reversed.

* **Disabled** - Specifies whether the clip has any influence on the Animation Player.

* **Blend Type** - When blending multiple animations you can specify how you would like this blend to be applied

  <!-- -->

  * **Default** - Completely overrides any influence on the joints this animation will be applied giving this animation priority
  * **Additive** - The weight of this animation will be added to any current animation influence already being applied to the joints this animation is being applied to

* **Scale Accumulation** - This value determines how you want the animation values to be applied to the joints

  <!-- -->

  * **Multiply** - Multiples the values to each joint effectively scaling values currently applied
  * **Additive** - Adds the desired animation's values to the currently applied values on joints

## Animation Asset[​**](#animation-asset "Copy to clipboard")

Animation Asset contains multiple Animation Property Layers. It also allows you to hook into events which can be triggered by the animation.

Animation Assets are found in the Asset Browser panel. It is created when you import a 3D animation.

![](/assets/images/animation-player-3-bc753da858755da666aa9aca308420f1.png)

When dealing with joints in a 3D animation, the animation targets based on the name of the joints. Meaning, every object should have a unique name.

Animations will automatically retarget if they have the same structure!

### Animation Property Layer[​**](#animation-property-layer "Copy to clipboard")

A layer containing different properties. Examples include position, rotation, scale or any other arbitrary properties. Animation Property Layers are made within an Animation Asset.

Since an `Animation Property Layer` simply contains a bunch of numbers that describe the state of a property (e.g. state of a rotation), you can sample the animation in many other contexts (e.g. state of a font size).

In other words:

1. Animation Player component, controls and plays an Animation Clips.
2. Animation Clips contains a reference to a single Animation Asset.
3. Animation Asset contains a map of Animation Layers.
4. Animation Layers contain different properties of the animations.

You can learn more about each of these, and their interface for scripting in the [API documentation](/api/lens-studio/Classes/Components.md#animationplayer).
