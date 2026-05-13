# 3D Animation

The animation system in Lens Studio supports skeletal, transform, and blend shape animations for bringing 3D content to life.

###

![](/assets/images/3d-animation_3DAnimatiom-d83666eb88bf8c02812cd3b114cd761b.png)

### [​**](#-1 "Copy to clipboard")

### Introduction[​**](#introduction "Copy to clipboard")

The animation system in Lens Studio supports several animation types like `Transform` animation, `Skeletal` animation and `Blend Shape` animation.

## Types of Animation[​**](#types-of-animation "Copy to clipboard")

The following types of animation are available in Lens Studio.

### Transform Animation[​**](#transform-animation "Copy to clipboard")

[](/img/lens-studio/3d-animation_Transform_Animation.webm)

`Transform` animation can be used for basic movement through `Scale`, `Rotation` , and `Position`. `Transform` animation modifies the parameters of the object's `Transform`.

### Joint Animation[​**](#joint-animation "Copy to clipboard")

[](/img/lens-studio/3d-animation_Skeleton_Animation.webm)

`Skeletal` animation allows you to animate a mesh (aka skin) using a connected skeleton (aka rig).

`Skeletal` animation is often used for animating characters. That said, the technique of using a skeleton to deform an object can be applied to any type of 3D object. When using `Skeletal` animation in Lens Studio, keep your skeleton's number of joints (aka bones) to under 100.

### Blend Shape Animation[​**](#blend-shapeanimation "Copy to clipboard")

[](/img/lens-studio/3d-animation_Blendshapes.webm)

`Blend Shape` animation (aka `Morph Target` animation) allows a single mesh to deform to numerous pre-defined shapes. In your animation, you can then morph between these pre-defined shapes. This technique is commonly used in facial animation. We recommend not using `Blend Shape` animation unless it is truly needed for the creative concept. If `Blend Shape` animation is required, use sparingly and play close attention to your frame rate performance.

### Vertex Animation[​**](#vertex-animation "Copy to clipboard")

`Vertex Animation` or PLA (Point Level Animation) allows you to animate the individual vertices of an object. `Vertex Animation` can be useful for creating complex or simulated animations. For example, it can be used to create a flag waving animation using cloth simulation. Please refer to the [Vertex Animation](/lens-studio/assets-pipeline/3d/animation/vertex-animation.md) guide for more information.

## Related Guides[​**](#related-guides "Copy to clipboard")

Please refer to the guides below for additional information:

* [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md)
* [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md)
* [Vertex Animation](/lens-studio/assets-pipeline/3d/animation/vertex-animation.md)
