# Animation State Manager

<!-- -->

**Animation State Manager** is a custom component that provides a simple way to manage your animation states, blend between animations, and configure transitions when certain conditions are met.

It is available for installation in the Lens Studio Asset Library.

![](/assets/images/animation-state-manager-8-bf324c948dbf0a65ae8d226b1fa30e22.png)

## Video guide[​**](#video-guide "Copy to clipboard")

Please check out this guide for a setup of the Animation State Manager from scratch.

## Inputs[​**](#inputs "Copy to clipboard")

![](/assets/images/animation-state-manager-2-43d3772f56734855e59ad082e8bd220f.png) **Animation Player** - the Animation Player to control.

### Animation States[​**](#animation-states "Copy to clipboard")

**Animation States** - This section defines a set of animation states that your animated object can be in. Additionally, there are several built-in states such as Entry and Exit, which allow you to create initial and final transitions.<br />**Enabled** - When checked, allows editing of the Animation States section.

**Create from Clips** - Enable this option to generate states from animation clips that are added to the referenced Animation Player. This is a simple option if you're not using blend trees or are using clips for multiple states.

**Custom States** - Define a list of states on top of the existing clips.

* **Name** - The Animation State name, used for referencing in scripts or in the Transitions section.
* **Source** - The type of state, which can either be *From Single Clip* or *From Blend Tree*.

![](/assets/images/animation-state-manager-5-90bab6f32050abb598d9604a6da64c37.png)

A **Custom State from the Blend Tree** allows you to blend multiple animations based on a float parameter. For example, this could be used to smoothly transition between Idle, Walk, and Run animations, or between running forward, right, and left.

A parameter used for a blend tree must be defined in the **Parameters** section, described below.

![](/assets/images/animation-state-manager-6-2e47741818ffb07ee5e57b394711b5ce.png)

Each blend tree clip is an structure of:

**Clip Name** - The name of a clip used for a blend tree. In the screenshot example, it blends between 3 animations: idle, walk, and run. The diagram below shows which animation is playing at a given moment.

**Threshold** - The value of the parameter that corresponds to the current animation clip being at full effect.

**Normalize Clip Duration** - Use normalized clip time for blending. Useful for looped animations like walk or run cycles that often have different duration.

**Blend Parameter** - a name of parameter used to control a blend tree.

[](/img/lens-studio/animation-state-manager-7.webm)

### Parameters[​**](#parameters "Copy to clipboard")

The **Parameters** section allows you to define variables that control animations and transitions. For example, you can set a character to crawl or stand based on whether a boolean parameter is `true` or `false`. You can also trigger an animation using a trigger parameter, or switch between equivalent states when an integer parameter changes.

* **Enabled**: Enables editing of the Parameters section.

* **Parameters**: An array of parameters that control the state manager. Each element includes:

  <!-- -->

  * **Name**: The parameter's name.
  * **Type**: The parameter type, which can be `Float`, `Int`, `Boolean`, or `Trigger`.
  * **Value**: The initial value of the parameter.

![](/assets/images/animation-state-manager-4-80e225a96a5a53c63012bd3d52e8bc03.png)

### Transitions[​**](#transitions "Copy to clipboard")

The Transition section allows you to specify when and how to transition between states.

![](/assets/images/animation-state-manager-1-5f6dae8a8cac6345dc5a5dac8b039cab.png)

The **Transitions** section defines how the system moves between animation states.

* **Enabled**: When checked, allows editing of the Transitions section.

* **Transitions**: An array of transitions, where each transition is structured as follows:

  <!-- -->

  * **Enabled**: Enable or disable the current transition.

  * **From**: The state from which the transition starts. Possible values include:

    <!-- -->

    * **Entry**: The initial entry state, used to initialize the default animation.
    * **Any**: A transition that can occur from any state.
    * **Specific State**: A named state from which the transition begins.

  * **To**: The state to which the transition leads. Possible values include:

    <!-- -->

    * **Specific State**: A named state to transition to.
    * **Exit**: Stops all animations.

  * **Duration**: The transition duration in seconds.

  * **Has Exit Time**: If enabled, the transition occurs automatically after the animation completes.
    <!-- -->
    * **Exit Time** - a normalized time \[0, 1] of a from animation when the transition should start.

![](/assets/images/animation-state-manager-0-c9ac7ca0b4060a4de34a0fdb05df2e35.png)

**Conditions**: A list of conditions that must be satisfied for the transition to occur. Each condition forms a logical expression applied to one of the parameters—such as "is less" or "is greater" for a float parameter, or "is true" for a boolean parameter. The transition begins when all conditions are true simultaneously. Each condition is defined by the following fields:

* **Name**: The name of the parameter.
* **Type**: The type of the parameter, which must match the one specified above.
* **Function**:(Optional) The logical operator applied to the parameter (e.g., "is less," "is more," "is true"). This depends on the parameter type.
* **Value**: (Optional) The value to compare against the parameter.

## Scripting[​**](#scripting "Copy to clipboard")

Next come some of the custom component api description.<br /><!-- -->You can add a parameter to control animations by calling the `addParameter` method with the parameter name and default value.

```
//@input Component.ScriptComponent animManager
script.animManager.addParameter('speed', 1.0);
```

To set the value of a parameter, use the setParameter method with the parameter name and the new value.

```
script.animManager.setParameter('speed', 1.5);
```

Set a trigger by calling setTrigger with the trigger name.

```
script.animManager.setTrigger('jump');
```

Reset a trigger by calling resetTrigger with the trigger name.

```
script.animManager.resetTrigger('jump');
```

Get a state to add callbacks or query its status using getState.

```
let state = {
  stateName: 'Run',
  type: script.animManager.StateType.Specific,
  source: script.animManager.StateSource.SingleClip,
  clipName: 'Idle',
};
```

Force a state change immediately or with a transition duration by calling setState.

```
script.animManager.setState('Idle', 0); // Immediately change to Idle state
script.animManager.setState('Run', 0.5); // Transition to Run state over 0.5 seconds
```

Define a new state from a configuration object using addStateFromConfig.

```
let state = {
  stateName: 'Run',
  source: 0, // From Single Clip
  clipName: 'RunAnimationClip',
};
script.addStateFromConfig(state);
```

## Triggering transitions with Behavior Script[​**](#triggering-transitions-with-behavior-script "Copy to clipboard")

If you prefer not to script, the Animation State Manager API functions are easily accessible from the Behavior script.

![](/assets/images/animation-state-manager-3-8b8c98afd0dc951c82bc45bdc67edb06.png)

* Select - `Call Object API` Response.
* Set `Call Type` to `Call Function`.
* Set `Function Name` to `setParameter` or `setTrigger`
* Set `Argument 1` `Type` to `string` and value to your parameter name.
* Optionally set `Argument 2` to the desired type and value of your parameter.

## Debugging[​**](#debugging "Copy to clipboard")

Please check the logger for warning messages. Additionally you can utilize the Show Debug checkbox and plug in a Text component to display current state, parameters and their values.
