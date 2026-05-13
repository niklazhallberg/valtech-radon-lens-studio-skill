# ML Component Overview

Although neural networks have been already widely presented in Lens Studio - in 3D face tracking, segmentation, object tracking, SnapML allows users to create their own Lens features based on neural networks (“models“) they, or third parties, have trained. The neural networks, or ML models, are used in Lens Studio via the ML Component.

## ML Model Import[​**](#ml-model-import "Copy to clipboard")

Lens Studio supports importing several common ML model formats:

* Open Neural Network Exchange (`.ONNX`).
* TensorFlow Lite model (`.TFLite`).

These files can be imported into Lens Studio project by dragging and dropping model files into the `Asset Browser` panel.

You can tune your import settings through Inspector by selecting the imported model.

![](/assets/images/ml-component-overview_ML-2-import-dialog-a64b18bbad1b78400d8571a8f3180b68.png)

**Inputs** are presented at the top. For each input of the model you can:

* See information about its **name** and **Shape**.

* Configure **Input Transform** by selecting a combination of settings (See Transformer settings in the [Inputs](#inputs)).

* Set channel **Scale** and **Bias**.

  <!-- -->

  * If the number of channels is less than or equal to `4`, scale and bias can specified for each of them separately.
  * Otherwise, scale and bias can be modified for all channels at once.

You can use this Python code to calculate `Scale` and `Bias` from standard deviation and mean:

```
std = [0.229, 0.224, 0.225]
mean = [0.485, 0.456, 0.406]
# n = (i - mean)/std
scale = [1.0 / 255 /s for s in std]
print(scale)
bias = [-m / s for m, s in zip(mean, std)]
print(bias)
```

**Outputs** are presented at the bottom. For each output of the model you can:

* See its **name** and **Shape**

* Specify an **Input** that will provide it’s **Transform source** (Output transform is reverse to the input transform).

* Set channel **Scale** and **Bias**.

  <!-- -->

  * If the number of channels is less than or equal to `4`, scale and bias can specified for each of them separately.
  * Otherwise, scale and bias can be modified for all channels at once.

Once imported, Lens Studio will refer to the ML model as a **[ML Asset](/api/lens-studio/Classes/Assets.md#MLAsset)**. Specified settings will be the default settings for this ML Asset for ML Component initialization.

You can specify different input and output transform settings (but not scale and bias), as well as their shapes, later in the ML Component UI.

Since model training is an iterative process and you might want to update the asset. To do so, you can right-click on the model asset in `Asset Browser` panel and select **Update from Source** or **Relink to new Source**.

Though you should make sure your model is as small as possible to improve the Lens experience, you can have up to 10MB of SnapML Assets.<br />![](/assets/images/ml-component-overview_ML_lens-size-c627f8006c828dcd5d0791b7041ad7d3.png)

### Compression[​**](#compression "Copy to clipboard")

You can select a method of compression inside of the **Compression Setting** component when the ML model is selected from Asset Browser. It will reduce model size with minimum degradation of accuracy. Compressing might take some time depending on the model size.

## ML Component[​**](#ml-component "Copy to clipboard")

Once you’ve imported your model, you can use it in your Lens by using the ML Component.

This section covers how to set up a ML Component in a new project. You can also follow these steps to add ML Component to an existing project.

### Creating the ML Component[​**](#creating-the-ml-component "Copy to clipboard")

You can create ML Component by selecting or creating a Scene Object. With this Scene Object selected, you can find **Add Component** button and select **MLComponent** on the `Inspector` panel

![](/assets/images/ml-component-overview_ML-1-add-new-3a22cf2053bf6cc96af6d28a37293f2d.png)

You can create and build ML Component completely in a [script](/lens-studio/features/snap-ml/ml-component/scripting-ml-component.md).

### ML Component Settings[​**](#ml-component-settings "Copy to clipboard")

Let’s take a look at the ML Component UI:

![](/assets/images/ml-component-overview_ML-8-settings_200603_002839-daed7f7365a4eac67509d449164fad3a.png)

* **Render Order:** the model can be run at a specific point during frame rendering if certain run options are selected. More about this in [Scripting](/lens-studio/features/snap-ml/ml-component/scripting-ml-component.md) section.
* **Model:** is intended for your MLAsset resource.
* **Auto build:** if selected, the model will be built with specified input and output settings.
* **Auto run:** if selected, after the model is built it will run every frame, synchronously. It will start processing on frame update, and output results on frame render.

Auto run is the equivalent of running: `mlComponent.runScheduled(true, MachineLearning.FrameTiming.OnRender, MachineLearning.FrameTiming.OnRender);`

More information about run modes and `FrameTiming` can be found in [Scripting ML Component](/lens-studio/features/snap-ml/ml-component/scripting-ml-component.md) guide .

### Inputs[​**](#inputs "Copy to clipboard")

This section of Ml Component UI provides information on all input placeholders of the ML model and allows users to configure their settings.

Each Input is described with a name specified in the ML model asset (name can't be changed).

Next Options are available for each input:

* **Shape:** is represented with **Width**, **Height** and **Channels**. **Width** and **Height** can be changed if your network supports it. Number of **Channels** can’t be changed.

Shape always consists of these three parameters. They will be set to 1 if the dimension of input and output is lower than 3.

* **Texture:** If the channel amount of the input is <= 4 MLComponent will suggest that this input could possibly (but not necessarily) be a texture and enable **Input Texture Field**. Click on the **Texture** field and select input texture. In other cases you will need to modify input data using JavaScript. See [scripting guide](/lens-studio/features/snap-ml/ml-component/scripting-ml-component.md) for details

Textures are fed into the ML Component are in the range `[0, 255]`

If the input texture has a different number of channels than model expects  - color space will be converted automatically for you and you don’t need to apply any additional operations.

* **Input Transformer settings:** Sometimes texture needs some preprocessing before feeding it to the neural network. To avoid complicated setup (e.g. extra cameras) Lens studio allows you to perform a set of simple transformations on the input texture:

  <!-- -->

  * **Stretch:** if enabled - texture is stretched to the size (width and height) of model input.
  * **Horizontal** alignment - sets the horizontal alignment of the texture if stretch is off, adds padding if needed.
  * **Vertical** alignment - sets the vertical alignment of the texture if stretch is off, adds padding if needed.
  * **FlipX:** flips image on x axis.
  * **FlipY:** flips image on y axis.
  * **Rotation:** sets rotation to the one of 4 options.
  * **Fill Color:** if stretch is off defines a color added to the sides of the image to fit the input aspect ratio.

[](/img/lens-studio/ml-component-overview_ML-9-Transformer.webm)

### Outputs[​**](#outputs "Copy to clipboard")

**Output** section of the UI shows information about output placeholders. Every output is specified with a name.

* **Shape:** can’t be edited, but can change depending on the input shape.
* **Transform:** select an Input to get transform from. Output Transform is inverse to the Input Transform.
* **Output Texture:** Similarly as input, if the number of channels of the output is `<= 4` the **Create Output Texture** button will be available. When you click the button, the new Texture Asset will be created in Resources. You can use it in components and materials as any other texture.

[](/img/lens-studio/ml-component-overview_Ml_10-create-proxy-texture.webm)

This texture is not initialized until the model has finished its first run. And you may use it reliably only after this event.

Continue reading:  [ML Component Scripting and Lifecycle](/lens-studio/features/snap-ml/ml-component/scripting-ml-component.md)
