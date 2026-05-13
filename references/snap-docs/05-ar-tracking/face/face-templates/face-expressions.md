# Face Expressions

This guide shows how you can use face expressions of the user to drive a 3D model using the [Face Expressions](/lens-studio/features/ar-tracking/face/face-expressions.md) effect. For example, you can bring in a 3D character that repeats the user's face expressions!

[](/img/lens-studio/face-expressions_face-expressions-1.webm)

## Guide[​**](#guide "Copy to clipboard")

There are 51 expressions available overall, each of them corresponds to specific user emotion or facial muscle movement. For each of them, there is a "weight" parameter. Weight is a number which indicates how strong this expression is.

For example - `EyeBlinkLeft` has weight closer to `0.0` when users left eye is fully open, and goes up when the user blinks. It's different and unique for every face, so there is no guarantee that it ever reaches `0.0` or `1.0`.

You can see the list of expressions available in the [API page](/api/lens-studio/Classes/OtherClasses.md#expressions). Though optional, by using the names listed on this page, it will make it easier to hook up your model to this template.

### Face Expressions Asset[​**](#face-expressions-asset "Copy to clipboard")

Find the `Face Expressions` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

The Face Expression asset comes with two examples of driving 3D models based on the Face Expression feature. Toggle the `Character Expressions` and the `Face Mesh Expressions` to see them in action.

[](/img/lens-studio/5-features/face-expressions-toggle-objects.webm)

### Hooking up your model[​**](#hooking-up-your-model "Copy to clipboard")

Each of these objects utilizes the ExpressionController script which allows you to set up which face expressions will drive animation of your 3d model blend shapes.

To learn about making your own model, take a look at the [3d animation](/lens-studio/assets-pipeline/3d/animation/3d-animation.md) guide for more information.

![](/assets/images/face-expressions-add-3d-model-34f362cc1dad9e69f225f80dcd7c817e.png)

To hook your model up, select the `Mesh Component` field, and choose the Render Mesh Visual component on your object. At this point, if the blendshapes on your object matches those listed in the API page, your model will automatically be driven by the Face Expression feature.

To bring your 3D model into Lens Studio, drag and drop the file into the `Asset Browser` panel.

### Customizing your expressions[​**](#customizing-your-expressions "Copy to clipboard")

You can modify how the ExpressionController maps your face expressions by toggling the Customize Expression checkbox. All of the expressions are divided into categories and sorted alphabetically for easier search.

* **Brows**
* **Cheeks**
* **Eyes**
* **Jaw**
* **Lips**
* **Mouth**
* **Face**

[](/img/lens-studio/5-features/face-expressons-customize-expression.webm)

**Scale parameter** is used to multiply actual face expressions weight, so you can get exaggerated effect without editing animation in model.

We’re continually upgrading the model which understands the shape of your face expression. As a result, you should not rely on the Scale parameter for big changes.

**Blendshape** - name of the blendshape in 3d model that you want to map to the current face expression blendshape.

The Face Mesh option under the Advanced field provides a reference Face Mesh object that the face expression blendshapes are derived from. This needs to be enabled at all times when face expressions are in use. The template applies a transparent material that you can add to it, so it won't interfere with other rendered objects.

### Eyeball Tracking[​**](#eyeball-tracking "Copy to clipboard")

This asset also provides a helper script to help you use only the rotation of the eye tracking feature. In the `Character Expressions` example, the character’s eye moves with the user’s eye, but its position is positioned by the model itself.

To use this helper script, add the `Copy Rotation` script to your eye object. Then, set the corresponding Eyeballs to the `Source Object`, and your model’s eye object to the `Target Object`.

![](/assets/images/face-expressions-eye-helper-7ecf34459d952cb05c125f57f335db77.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
