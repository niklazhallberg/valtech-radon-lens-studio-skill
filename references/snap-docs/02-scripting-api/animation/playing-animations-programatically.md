# Playing Animations Programmatically

By default, Animation Player will play the animations automatically. However, you may want to manually trigger the animation, or switch between animations. In addition, when useful, you can blend between animation clips.

## Naming Animation Clips[​**](#naming-animation-clips "Copy to clipboard")

In the Animation Player, you can give your Animation Clips a name, so that you can refer to them in scripts:

![](/assets/images/animation-player-12-7725c8c43d379c4dde4d1825afe0935c.png)

## Triggering Animations Through Behavior[​**](#triggering-animations-through-behavior "Copy to clipboard")

You can use [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to trigger your animation in a variety of ways.

In the Response section, choose `Play Animation Clip` and then add a reference to your `Animation Player` and the `name` of your clip.

## Triggering Animations Through Script[​**](#triggering-animations-through-script "Copy to clipboard")

You can trigger an animation using the `playClipAt`, and passing in the clip name, as well as the second you want the clip to start at.

For example, to play an animation when the user taps the screen:

```
//@input Component.AnimationPlayer animationPlayer
script.createEvent('TapEvent').bind(function () {
  script.animationPlayer.playClipAt('myClipName', 0);
});
```

Take a look at the scripting guide to learn more about scripting!

## Transitioning Between Animation Clips[​**](#transitioning-between-animation-clips "Copy to clipboard")

You can play multiple clips simultaneously to blend between various animations.

Animation Clips are processed in the order they are visualized on the Animation Player. For example, if you wanted to transition between a walking and running animation, you will likely want the walking animation to be the first clip, with a weight of 1.0, and then blend in the run clip, ramping from 0-1. See an example script in the API page.

For example: notice here how the tube bending starts transitioning from going forward-backward to left-right on mouse click. See the script in the [Animation Player API example](/api/lens-studio/Classes/Components.md#AnimationPlayer--Examples).

[](/img/lens-studio/animation-player-13.webm)

### Related Guides[​**](#related-guides "Copy to clipboard")

* [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md)
* [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md)
* [Scripting Overview](/lens-studio/features/scripting/script-overview.md)
* [Scripting Example](/lens-studio/features/scripting/scripting-example.md)
* [Animation State Manager](/lens-studio/features/animation/animation-state-manager.md)
