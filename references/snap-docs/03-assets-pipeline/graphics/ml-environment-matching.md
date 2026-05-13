# Environment Matching

Lens Studio comes with Several techniques for adding realism to your AR objects.

Take a look at the [ML Environment Matching Template](/lens-studio/features/snap-ml/snap-ml-templates/other-ml-templates/ml-environment-matching.md) for an example of the techniques covered here.

## Dynamic Environment Map[​**](#dynamic-environment-map "Copy to clipboard")

The Dynamic Environment map generates an environment map in real time from some input–usually the `Device Camera Input`. This Dynamic Environment map will allow your object to receive lighting from the real world. When available, this feature will automatically leverage a Machine Learning model to improve the results of the generated environment map. When not available, the system will automatically fallback to just using the inputted texture.

| With Dynamic Envmap                                               | Without Dynamic Envmap                                            |
| ----------------------------------------------------------------- | ----------------------------------------------------------------- |
| [](/img/lens-studio/The-ML-Environment-Template-and-Guide_3.webm) | [](/img/lens-studio/The-ML-Environment-Template-and-Guide_6.webm) |

The Machine Learning generated environment map is only available in the front camera.

### Add Dynamic Environment Map[​**](#add-dynamic-environment-map "Copy to clipboard")

In the `Scene Hierarchy` panel, select your Light object. In the drop down, you can select `Environment Map`. In the `Input` field, select your `Device Camera Texture`.

[](/img/lens-studio/The-ML-Environment-Template-and-Guide_12.webm)

Now, all your PBR material will use the generated environment map to light itself!

Try using the Webcam option in the `Preview` panel and shining a light on yourself to see the effect in action!

The ML generated environment map may be blurred such that it won’t allow your object to have a mirror effect. However, you can modulate the result with a simple reflection based on a texture. Take a look at the ML Environment Matching template to learn more about this technique.
