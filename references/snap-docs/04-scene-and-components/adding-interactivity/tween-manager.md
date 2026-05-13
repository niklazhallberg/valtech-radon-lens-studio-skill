# Tween Manager

[Tween.js](https://github.com/tweenjs/tween.js/) is a JavaScript tweening engine for creating simple programmatic animations. It’s an open source JavaScript library created by [Sole](https://github.com/sole) and can be easily integrated into your Lens Studio project. We've created a convenient importable object that automatically includes Tween.js into your project. Additionally, in includes a Lens Studio specific wrapper called `TweenManager` and a number of Lens Studio specific `TweenType` scripts which can be tuned in the `Inspector` panel.

[](/img/lens-studio/tween-manager_tween_example_small.webm)

## Adding the Tween Package[​**](#adding-the-tween-package "Copy to clipboard")

To add the Tween package to your project, select `+ -> Scripts -> Tween Manager` in the `Scene Hierarchy` panel.

![](/assets/images/helper-script-tween-2c38f979adbbdce9fdc52820773d980a.png)

You're now ready to tween!

The imported package includes some example objects using tweening. To remove these objects, delete anything labeled `[REMOVE_ME]` in the `Scene Hierarchy` panel and the `Asset Browser` panel.

## Adding Tweens[​**](#adding-tweens "Copy to clipboard")

Tweens are added to Scene Objects as [Script Components](/lens-studio/features/scripting/script-overview.md). These scripts, referred to as `TweenTypes`, each tween a different set of properties. You can learn more about the different TweenTypes in the next section.

To add a Tween Type to a Scene Object:

1. Select an object in the `Scene Hierarchy` panel.
2. In the `Inspector` panel, click `Add Component` .
3. Under the `Project Components` section, select one of the Tween Type.

Any script in your project will automaticallly be added to this `Project Components` section.

## Tween Types[​**](#tween-types "Copy to clipboard")

Below is a description of each `TweenType` and the `Inspector` settings used for tuning the tween.

### Tween Transform[​**](#tween-transform "Copy to clipboard")

The `TweenTransform` type modifies an object's Transform using either Move, Scale or Rotate. The `TweenTransform` type has a number of settings that can be configured in the `Inspector` panel.

![](/assets/images/tweenManager_tweenTransform-2035a0536c35977d0ad5fd3d0567b0e9.png)

* **Scene Object:** The object you want to apply the tween to. This field allows you to separate your tween tuning from the object itself. If this field is left empty, the tween is applied to the object that the script component has been added to.
* **Tween Name:** The name of the tween. This is used when scripting playback for a tween. Please see the section [Scripting Tweens](#scripting-tweens) below for more information.
* **Play Automatically:** When enabled, the tween will start automatically.
* **Loop Type:** The type of tween loop. **None** doesn't loop. **Loop** plays to the end and then resets to the beginning. **Ping Pong** plays to the end and then reverses back to the beginning. **Ping Pong Once** plays to the end and then reverses back to the beginning, but only once.
* **Type:** The type of transform tweening. `Move` tweens the transform's position, `Scale` tweens the transform's scale and `Rotate` tweens the transform's rotation.
* **Movement Type:** Indicates how the tween start and end values will be specified. `From / To` specifies both the start and end values of the tween. `To` takes the start value of the tween from the current state of the Scene Object, while the end value of the tween is specified. `From` takes the end value of the tween from the current state of the Scene Object, while the start value of the tween is specified. `Offset` takes the start value of the tween from the current state of the Scene Object and the end value of the tween from the start value transformed by the specified offset.
* **Start:** A vec3 that represents the starting values for the tween.
* **End:** A vec3 that represents the ending values for the tween.
* **Time:** The duration of the Tween (in seconds).
* **Offset:** A vec3 that represents the offset from the tween's start value (only available if Offset is chosen as the Movement Type).
* **Additive:** If true while Movement Type is set to `Offset` and Loop Type is set to `Loop`, the tween will continue to be offset at each loop iteration rather than reset to its original start value.
* **Delay:** How long to wait before starting the tween.
* **Is Local:** If true, the transform is changed in local space. If false, the transform is changed in global space.
* **Easing Function:** The easing function for the tween. Available easing functions are: `Linear`, `Quadratic`, `Cubic`, `Quartic`, `Quintic`, `Sinusoidal`, `Exponential`, `Circular`, `Elastic`, `Back` and `Bounce`.
* **Easing Type:** The type of easing. Available easing types are: `In`, `Out` and `In / Out`.

The Rotation `TweenTransform` will always choose the shortest angle of rotation to go from start to end. For instance, if you specify the end rotation to be 359 degrees greater than the start rotation, then the tween will appear as though it has rotated one degree. This means that you cannot rotate more than 180 degrees in a single tween. A workaround is to define a `TweenChain` to incrementally rotate an object less than 180 degrees at a time until the desired rotation is reached.

### Tween Screen Transform[​**](#tween-screen-transform "Copy to clipboard")

The `TweenScreenTransform` type modifies an object's [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md). This is useful for tweening a Screen Transform's position, scale, rotation, or anchors. The `TweenScreenTransform` type has a number of settings that can be configured in the `Inspector` panel. Below details the settings that aren't shared with the [Tween Transform](#tween-transform) type.

![](/assets/images/tweenManager_tweenScreenTransform-376752168e6a673539d0b3c84c1dee88.png)

* **Type:** The type of Screen Transform tweening to perform.

  <!-- -->

  * ***Position:*** Tweens the Screen Transform's `position` property.
  * ***Scale:*** Tweens the Screen Transform's `scale` property.
  * ***Rotation:*** Tweens the Screen Transform's `rotation` property (Z axis only).
  * ***Anchors:*** Tweens the Screen Transform's `anchors` property.

### Tween Color[​**](#tween-color "Copy to clipboard")

The `TweenColor` type modifies an object's color. The object can be [Text](/lens-studio/features/text/2d-text.md), a [2D Image](/lens-studio/assets-pipeline/2d/image.md), or a [3D Mesh](/lens-studio/assets-pipeline/3d/importing-content/fbx-3d-object-import.md). The `TweenColor` type has a number of settings that can be configured in the `Inspector` panel. Below details the settings that aren't shared with the [Tween Transform](#tween-transform) type.

![](/assets/images/tweenManager_tweenColor-ffffa65d3783ee31b29ee2e906e00402.png)

* **Color Property:** Specifies the color property to tween.

  <!-- -->

  * ***Default:*** Tweens the object's base color (or Text Fill, if the object is Text).
  * ***Outline (Text Only):*** If the object is Text, tweens the text's Outline color.
  * ***Drop Shadow (Text Only):*** If the object is Text, tweens the text's Drop Shadow color.
  * ***Background (Text Only):*** If the object is Text, tweens the text's background.

* **Start:** A vec4 that represents the starting color for the tween.

* **End:** A vec4 that represents the ending color for the tween.

* **Offset:** A vec4 that represents the offset from the tween's start value (only available if Offset is chosen as the Movement Type).

* **Recursive:** If enabled, the color is applied to all child objects.

* **Ignore Alpha:** If enabled, the alpha is ignored when the color is applied. This allows you to run both a `TweenColor` and a `TweenAlpha` together.

### Tween Alpha[​**](#tween-alpha "Copy to clipboard")

The `TweenAlpha` type modifies an object's transparency. The object can be [Text](/lens-studio/features/text/2d-text.md), a [2D Image](/lens-studio/assets-pipeline/2d/image.md), or a [3D Mesh](/lens-studio/assets-pipeline/3d/importing-content/fbx-3d-object-import.md). The `TweenAlpha` type has a number of settings that can be configured in the `Inspector` panel. Below details the settings that aren't shared with the above [Tween Transform](#tween-transform) type.

![](/assets/images/tweenManager_tweenAlpha-a28ce66b4a711bb3292451910acf4af5.png)

* **Start:** A float that represents the starting transparency for the tween.
* **End:** A float that represents the ending transparency for the tween.
* **Offset:** A float that represents the offset from the tween's start value (only available if Offset is chosen as the Movement Type).
* **Recursive:** If enabled, the transparency is applied to all child objects.

### Tween Value[​**](#tween-value "Copy to clipboard")

The `TweenValue` type modifies a generic data value (int, float, vec2, vec3, or vec4). The value of a `TweenValue` at a certain point in time can be obtained by calling the `global.tweenManager.getGenericTweenValue` function (see [Get Generic Tween Value](#get-generic-tween-value) below). Below details the settings that aren't shared with the above [Tween Transform](#tween-transform) type.

![](/assets/images/tweenManager_tweenValue-1f8a3079b6cb2f1a24bb47a2ef482499.png)

* **Data Type:** The data type of the value to be tweened (i.e. int, float, vec2, vec3, vec4).
* **Start:** A value (of the data type specified in the Inspector) that represents the starting values for the tween.
* **End:** A value (of the data type specified in the Inspector) that represents the ending values for the tween.

### Tween Chain[​**](#tween-chain "Copy to clipboard")

The `TweenChain` type plays multiple tweens in sequence or simultaneously. All tweens specified within a `TweenChain` must be attached to a single Scene Object. Below details the settings that aren't shared with the above [Tween Transform](#tween-transform) type.

![](/assets/images/tweenManager_tweenChain-1653ec5cdc2cf1c5a0f25354bc9750d1.png)

* **Scene Object:** The object that contains all of the `TweenType` script components to be used in this `TweenChain`. This field allows you to separate your base tweens from the object itself. If this field is left empty, the `TweenChain` will use `TweenType` script components attached to the object that the script component has been added to.
* **All At Once:** If enabled, all specified `TweenType` scripts will play simultaneously. If disabled, the specified `TweenType` scripts will play in sequential order.
* **Recursive:** If enabled, this `TweenChain` will search the Scene Object, along with all of its children, for the tweens specified under `Tween Names`.
* **Tween Names:** The list of names of `TweenType` scripts, attached to Scene Object, to be chained together.

When using TweenChain, all `TweenType` Script Components of the names specified under Tween Names must have Play Automatically disabled.

When using TweenChain, all `TweenType` Script Components specified under Tween Names must be initialized before this `TweenChain` can be initialized. Script components with the same script event are initialized in the order that they appear in the `Scene Hierarchy` panel. If they are on the same Scene Object, they are initialized based on their order in the `Inspector` panel.

You are allowed to invoke another `TweenChain` within a `TweenChain`. However, the `All At Once` setting on the first TweenChain will be applied to any other `TweenChain` that it invokes.

A `TweenChain` is useful if you would like to change the default behavior of one of the other `TweenTypes`. For instance, you may want a delay to only be applied to the start of a looping or ping pong tween rather than at the start of every cycle. To do this, you may chain two separate copies of a `TweenType` - the first copy is set to no loop type with a delay, while the second copy is set to loop or ping pong with no delay.

You can use a `TweenValue` to specify a delay within your `TweenChain` sequence. Simply add its name under `Tween Names` like normal, and the `Time` that is set on it will be the amount of delay that will occur inside the `TweenChain`.

## Scripting Tweens[​**](#scripting-tweens "Copy to clipboard")

The `TweenManager` includes a number of global helper functions that allow you to easily control added tweens through script. Scripted tweens are added in the same way as non-scripted tweens by adding a `TweenType` as a component. When scripting a tween, make sure `Play Automatically` is unchecked.

You can also trigger tweens using the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) helper script, which allows you to set various trigger and responses through simple dropdowns.

### Start Tween[​**](#start-tween "Copy to clipboard")

```
global.tweenManager.startTween(SceneObject sceneObject, string, tweenName [, function onComplete, function onStart, function onStop]);
```

The `global.tweenManager.startTween` function takes in an object (that contains a `TweenType` script), the name of the tween and three optional callbacks that represent when the tween completes, starts and stops. When called, it starts the tween. Below is an example of using `global.tweenManager.startTween` with and without callbacks.

```
// -----JS CODE-----
// @input SceneObject objectWithTweens
global.tweenManager.startTween(script.objectWithTweens, 'box_move');
global.tweenManager.startTween(
  script.objectWithTweens,
  'box_move_with_callbacks',
  moveComplete,
  moveStart,
  moveStop
);
function moveComplete() {
  // Callback example
}
```

### Stop Tween[​**](#stop-tween "Copy to clipboard")

```
global.tweenManager.stopTween(SceneObject sceneObject, string tweenName);
```

The `global.tweenManager.stopTween` function takes in an object (that contains a `TweenType` script) and the name of the tween. When called, it stops the tween. Below is an example of using `global.tweenManager.stopTween`.

```
// -----JS CODE-----
// @input SceneObject objectWithTweens
global.tweenManager.stopTween(script.objectWithTweens, 'box_move');
```

### Pause Tween[​**](#pause-tween "Copy to clipboard")

```
global.tweenManager.pauseTween(SceneObject sceneObject, string tweenName)
```

The `global.tweenManager.pauseTween` function takes in an object (that contains a `TweenType` script) and the name of the tween. When called, it pauses a tween that is currently playing. Note that `global.tweenManager.pauseTween` allows a tween to later resume from the state at which it was paused, unlike `global.tweenManager.stopTween`. Below is an example of using `global.tweenManager.pauseTween`.

```
// -----JS CODE-----
// @input SceneObject objectWithTweens
global.tweenManager.pauseTween(script.objectWithTweens, 'box_move');
```

### Resume Tween[​**](#resume-tween "Copy to clipboard")

```
global.tweenManager.resumeTween(SceneObject sceneObject, string tweenName);
```

The `global.tweenManager.resumeTween` function takes in an object (that contains a `TweenType` script) and the name of the tween. When called, it resumes a tween that is currently paused. Below is an example of using `global.tweenManager.resumeTween`.

```
// -----JS CODE-----
// @input SceneObject objectWithTweens
global.tweenManager.resumeTween(script.objectWithTweens, 'box_move');
```

### Get Generic Tween Value[​**](#get-generic-tween-value "Copy to clipboard")

```
global.tweenManager.getGenericTweenValue(SceneObject sceneObject, string tweenName);
```

The `global.tweenManager.getGenericTweenValue` function takes in an object (that contains a `TweenValue` script) and the name of the tween. Int and float values can be obtained directly from the returned value. Vec2 values can be obtained with the `x` and `y` properties of the returned value. Vec3 values can be obtained with the `x`, `y`, and `z` properties of the returned value. Vec4 values can be obtained with the `x`, `y`, `z` and `w` properties of the returned value. Below is an example of using `global.tweenManager.getGenericTweenValue`.

```
// -----JS CODE-----
// @input SceneObject objectWithTweens
var tweenValue = global.tweenManager.getGenericTweenValue(
  script.objectWithTweens,
  'generic_tween'
);
print(tweenValue.toString());
```

### Set Start Value[​**](#set-start-value "Copy to clipboard")

```
global.tweenManager.setStartValue(SceneObject sceneObject, string tweenName, newStartValue);
```

The `global.tweenManager.setStartValue` function takes in an object (that contains a `TweenValue` script), the name of the tween, and the start value to be passed in. When called, it manually sets the start value of the tween. For tweening rotations, the passed-in start value must be a `quat`. Otherwise, its type must match the type of the `Start` value of the original `TweenType`. Below is an example of using `global.tweenManager.setStartValue`.

```
// -----JS CODE-----
//@input SceneObject objectWithTweens
var newStart = new vec3(0.0, 0.0, 0.0);
global.tweenManager.setStartValue(
  script.objectWithTweens,
  'box_move',
  newStart
);
```

### Set End Value[​**](#set-end-value "Copy to clipboard")

```
global.tweenManager.setEndValue(SceneObject sceneObject, string tweenName, newEndValue);
```

The `global.tweenManager.setEndValue` function takes in an object (that contains a `TweenValue` script), the name of the tween, and the end value to be passed in. When called, it manually sets the end value of the tween. For rotations, the passed-in end value must be a `quat`. Otherwise, its type must match the type of the `End` value of the original `TweenType`. Below is an example of using `global.tweenManager.setEndValue`.

```
// -----JS CODE-----
//@input SceneObject objectWithTweens
var newEnd = new vec3(0.0, 0.0, 0.0);
global.tweenManager.setEndValue(script.objectWithTweens, 'box_move', newEnd);
```

### Reset Object[​**](#reset-object "Copy to clipboard")

```
global.tweenManager.resetObject(SceneObject sceneObject, string tweenName);
```

The `global.tweenManager.resetObject` function takes in an object (that contains a `TweenType` script) and the name of the tween. When called, it resets the object to its start values. Below is an example of using `global.tweenManager.resetObject`.

```
// -----JS CODE-----
// @input SceneObject objectWithTweens
global.tweenManager.resetObject(script.objectWithTweens, 'box_move');
```
