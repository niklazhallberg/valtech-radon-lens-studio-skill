# Curves in Materials and VFX

**Animation Curve Tracks** can be utilized in both **Materials** and **VFX**. This feature provides a new level of creative flexibility, making complex effects much easier to produce. For example, customizing particle behavior over its lifetime, creating shader gradients, or controlling vertex position within materials all be achieved in a much more intuitive way. See [Animation Curve Editor](/lens-studio/features/animation/anim-curve-editor.md) guide to learn how to edit curves.

[](/img/lens-studio/curves-in-materials-and-vfx-01.webm)

## How To Use Curves In Graphs[​**](#how-to-use-curves-in-graphs "Copy to clipboard")

Similar to sampling a texture, there are several ways to sample a curve in **Materials** or **VFX**. You can sample the curve in graphs by:

* A `Curve Parameter` node
* One or multiple `Curve Object Parameter` connecting to a `Curve Sample` node.
* A `Sub-Graph` node.
* A `Custom Code` node.

For use within a `Custom Code` node, input the curve as `input_curve myCurve` and sample it with `myCurve.sample( SamplePoint )`, the result returns a float value.

![](/assets/images/curves-in-materials-and-vfx-02-8ef92c7af4f9504df8928a09ef4ba98b.png)

### Assigning A Curve[​**](#assigning-a-curve "Copy to clipboard")

First and foremost, it's important to understand the terminology used in **Lens Studio** before moving forward. In this guide, when you encounter the term 'track,' it refers to an **Animation Curve Track**. Similarly, when you see the term 'curve,' it refers to a curve within the **Animation Curve Track** asset, an **Animation Curve Track** can contain multiple curves. ![](/assets/images/curves-in-materials-and-vfx-03-60efaf00e0919e63f9c391e1b1ba1cb4.png)

Once everything is connected in the graph, you can now assign a curve in the inspector panel, similar to assigning texture assets. For graph usage, make sure you create only one curve within a single **Animation Curve Track** asset.

[](/img/lens-studio/curves-in-materials-and-vfx-04.webm)

Shader uniforms can also be set programmatically via script.

```
//@input Asset.AnimationCurveTrack curveTrackAsset
//@input Asset.Material myMat
//@input Asset.VFXAsset myVFX

script.myMat.mainPass.myCurve = script.curveTrackAsset;
script.myVFX.properties.myCurve = script.curveTrackAsset;
```

Currently, **Material** and **VFX** graphs only support single-curve **Animation Curve Track** assets. If multiple curves are present within the asset, curve sampling will not execute. You will see a warning icon appear next to the parameter when the input asset has less or more than 1 curve property.

![](/assets/images/curves-in-materials-and-vfx-05-37d2119e6f0db5081f47eca5cdd6f860.png)

![](/assets/images/curves-in-materials-and-vfx-06-802cff8e6dea609c36d5e98356afbd5e.png)

See [Animation Curve Editor](/lens-studio/features/animation/anim-curve-editor.md) guide to learn how to edit curves.

### Sample Point[​**](#sample-point "Copy to clipboard")

`Sample Point` determines where the value is retrieved from a curve. For example, in a keyframe `(x, y)`, `x = samplePoint`, `y = value`. Given a two-keyframe linear curve with points `(0.0, 0.0)` and `(1.0, 0.5)`, a sample point of `0.5` returns a value of `0.25`.

![](/assets/images/curves-in-materials-and-vfx-07-f5dc71e00cc82540474e5a2cae6f8d79.png)

A curve with with points `(0.0, 0.0)` and `(1.0, 1.0)` can be visualized on a quad. When the x axis of the `Surface UV Coordinates` is used as the sample point, and the UV ranges from `0` to `1`, the result returns a `0` to `1` gradient rendered across the mesh.

![](/assets/images/curves-in-materials-and-vfx-08-fb91a7cd8fbb9140f71b3396e1fdca76.png)

Right clicking at a keyframe in the **Animation Curve Editor** opens an input window. The two input slots displayed as `(time, value)`, represent the keyframe's location on the curve. However, the `time` value is not tied to elapsed time unless elapsed time is used as the `Sample Point` input from the graph. In this context, `time` refers to the length of the curve.

![](/img/lens-studio/curves-in-materials-and-vfx-09.png)

## Graph Inspector[​**](#graph-inspector "Copy to clipboard")

When you select the `Curve Sample` or `Curve Parameter` nodes, the **Inspector** panel displays options for wrap mode and sample mode. If the **Inspector** panel is not visible, you can enable it by going to **Window > General > Inspector** in the top menu of of the **Lens Studio** window.

### Wrap Mode[​**](#wrap-mode "Copy to clipboard")

![](/img/lens-studio/curves-in-materials-and-vfx-10.png)

Wrap mode determines how the curve behaves when the sample point falls outside the range of the curve. It is especially useful for controlling animations.

* **Clamp :** Samples the curve only once. If the sample point is outside the range, it returns the value from the nearest end of the curve.
* **Mirrored Repeat :** Samples the curve forwards then backwards in a continuous loop. This is the same as a ping-pong animation.
* **Repeat :** Samples the curve from start to end in a continuous loop, restarting from the beginning each time it reaches the end.

[](/img/lens-studio/curves-in-materials-and-vfx-11.webm)

### Sample Mode[​**](#sample-mode "Copy to clipboard")

![](/img/lens-studio/curves-in-materials-and-vfx-12.png)

In the **VFX** graph, you can set the `Sample Mode` to `Particle Age Ratio` to control particle behavior over age, such as size or opacity over particle lifetime. This produces the same result as connecting `Particle ( Get Attribute ) Age Ratio` to the `Sample Point` output when set to `Custom` mode.

### Custom Code Node[​**](#custom-code-node "Copy to clipboard")

Curves can also be sampled using `Custom Code` nodes. The `sample` method defaults to a clamped wrap mode, returning the curve’s value at the samplePoint. If the point falls outside the curve’s defined range, the value is clamped to the nearest boundary:

```
float Result = myTrack.sample(samplePoint);
```

Starting from Studio 5.7.0, you can use the following methods to apply different wrap modes:

```
float Result = myTrack.sampleMirrored(samplePoint);
float Result = myTrack.sampleRepeat(samplePoint);
```

Alternatively, you can apply math as follows:

```
// Mirrored Repeat
samplePoint = fract(samplePoint * 0.5) * 2.0;
samplePoint = 1.0 - abs(samplePoint - 1.0);

//Repeat
samplePoint = fract(samplePoint);
```

## Use Case Examples[​**](#use-case-examples "Copy to clipboard")

Checkout and learn more from the Curves in Materials and VFX example pack in the Asset Library.

![](/img/lens-studio/curves-in-materials-and-vfx-13.png)

## Limitations and Troubleshooting[​**](#limitations-and-troubleshooting "Copy to clipboard")

### Why is the Sample Point input missing?[​**](#why-is-the-sample-point-input-missing "Copy to clipboard")

If the `Sample Point` is not visible on your `Curve Parameter` or `Curve Sample` node, you might be working in the **VFX** Graph where the Sample Mode defaults to Particle Age Ratio. With the `Curve Sample` or `Curve Parameter` node selected, in the **Inspector** panel you can set the Sample Mode to `Custom` to expose an input for `Sample Point`.

### Can I use curves as a color ramp?[​**](#can-i-use-curves-as-a-color-ramp "Copy to clipboard")

Multi channel color ramp is not yet available, with the current structure you can only use 1 curve input. The curve sampling will not execute if the **Animation Curve Track** asset contains more than 1 curve. If needed, you can still create 3 curve inputs as separate RGB curve controls.

### Can I emit particles along a curve?[​**](#can-i-emit-particles-along-a-curve "Copy to clipboard")

This feature is not available yet. Lens Studio doesn’t support creating splines interactively in the **Scene** panel. However, you can still create curves to control the position of particles. Note that you will need to create 3 separate curves to control the X, Y, and Z values.

### How do I animate keyframes?[​**](#how-do-i-animate-keyframes "Copy to clipboard")

There's no concept of mutable keyframes for Animation Curve Track at this moment. It's only achievable with script API, using `addKeyframe()` and `removeKeyFrame()` to delete the previous added key every frame.

### Can I create a curve track from script?[​**](#can-i-create-a-curve-track-from-script "Copy to clipboard")

No, currently we can’t create an Animation Curve Track curve asset from the script.
