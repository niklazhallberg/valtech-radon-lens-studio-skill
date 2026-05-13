# Animation Events

The Animation Events system allows you to trigger responses based on an animation clip timeline.

Animation Events are created on `Animations Assets`, and listened to on `Animation Players`.

Animation events rely on some knowledge of scripting. Take a look at the scripting section to learn more.

## Creating an Animation Events[​**](#creating-an-animation-events "Copy to clipboard")

To create an event we can subscribe to, we can get a reference to an animation asset. Then, we provide an event name so we can look for the event later, as well as the time (in seconds) in the animation asset’s timeline we want this event to be triggered.

```
// @input Asset.AnimationAsset animAsset
const startEventName = 'animStarted';
const startTimestamp = 0;
const e = script.animAsset.createEvent(startEventName, startTimestamp);
```

You can create an event that triggers at the end of a playback by getting the duration of the asset.

```
const endEventName = 'animEnded';
const endTimestamp = script.animAsset.duration;
script.animAsset.createEvent(endEventName, endTimestamp);
```

## Listening for an Animation Events[​**](#listening-for-an-animation-events "Copy to clipboard")

To listen to the animation you created, you can listen to events on the Animation Player, which is playing the Animation Asset.

```
// @input Component.AnimationPlayer animPlayer
script.animPlayer.onEvent.add(function (eventData) {
  print('Some event has triggered');
  if (eventData.eventName === startEventName) {
    print('Animation has started');
  } else if (eventData.eventName === endEventName) {
    print('Animation has ended');
  }
});
```

## Related Links[​**](#related-links "Copy to clipboard")

* [3D object importing](/lens-studio/assets-pipeline/3d/importing-content/overview.md)
* [Scripting](/lens-studio/features/scripting/script-overview.md)
* [Animation Player API](/api/lens-studio/Classes/Components.md#AnimationPlayer)
* [Animation Asset API](/api/lens-studio/Classes/Assets.md#AnimationAsset)
