# Multi Class Classification

[](/img/lens-studio/multi_class_classification_preview.webm)

The `Multi Class Classification` enables you to create your own Multi Class Classification [Machine Learning](/lens-studio/features/snap-ml/ml-overview.md) model, quantize it and use it to trigger different effects in Lens Studio. This example comes with a **Flower Classification** model that allows users to classify flowers images into one of **103** classes, visualize the topK classes and their probabilities and trigger some effects once certain class is found.

`Multi Class Classification` example is available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create new Orthographic camera and place the prefab under it.

## Guide[​**](#guide "Copy to clipboard")

You can skip to the [Customizing Lens](/lens-studio/features/snap-ml/snap-ml-templates/multi-class-classification.md#customizing-lens) section if you’d like to use the Flower Classification Model. Or, if you already have a multi class classification model, you can skip down to the [Importing Your Model](/lens-studio/features/snap-ml/snap-ml-templates/multi-class-classification.md#importing-model) section below.

### Creating Machine Learning Model[​**](#creating-machine-learning-model "Copy to clipboard")

This example relies on a machine learning model to predict the probability of a certain class. To create a model, you’ll need a machine learning training code: code that describes how the model is trained (this is sometimes referred to as a notebook).

[Example notebook](https://github.com/Snapchat/snapml-templates/blob/main/Quantization%20With%20TFLite/classification_and_quantization_with_tflite.ipynb) provided allows you to:

* Train an image classification model with [Keras](https://keras.io/) and [TFLite model maker](https://www.tensorflow.org/lite/guide/model_maker).
* Transfer weights pre-trained on [ImageNet](https://www.image-net.org/) and add data augmentation, normalization and dropout to make our model more robust.
* Learn about different types of quantization, such as post training quantization and quantization aware training, and apply them to the model.

In this example, we are going to use the [oxford\_flowers102](https://www.tensorflow.org/datasets/catalog/oxford_flowers102) dataset. It contains 102 common flower categories commonly found in the UK. Notebook will download dataset and all the necessary libraries for you.

### Training Your Model​[​**](#training-your-model "Copy to clipboard")

There are many different ways you can train your model. For our example, we will use [Google Colaboratory](https://colab.research.google.com/).

To see other ways of training, please take a look at the [ML Frameworks](/lens-studio/features/snap-ml/ml-overview.md) page for more information.

Download [notebook](https://github.com/Snapchat/snapml-templates/blob/main/Quantization%20With%20TFLite/classification_and_quantization_with_tflite.ipynb) from [snapml-templates](https://github.com/Snapchat/snapml-templates) repository. Then head over to Google Colaboratory, select the **Upload** tab, and drag the downloaded python notebook into the upload area.

[](/img/lens-studio/classification_importing-model.webm)

### Importing Model[​**](#importing-model "Copy to clipboard")

After you successfully run the notebook from the previous chapter you should have these 3 files downloaded to your machine:

![](/assets/images/multi_class_classification_files-d4658a841d36563fb10c2647d6fd0106.png)

With Lens Studio project open drag these files into the `Asset Browser` panel:

Please note that Lens Studio reads pixel values between `0` and `255` and our model uses range `[-1, 1]` we need to set the scale and bias when importing our model. To transform `[0, 255]` range to `[-1, 1]` we need to divide `1` by `128` and subtract to, that results in the next setting:

![alt text](/assets/images/multi-class-scale-bias-3893e2f80f55d77c0fefd8e175376682.png)

We will explain how to replace labels and set up MLComponent in the next section.

## Customizing Lens[​**](#customizing-lens "Copy to clipboard")

Let's take a look at the example in Lens Studio:

![alt text](/assets/images/multi-class-scene-hierarchy-963b14df5f4ceced002d3fd3c4f669c3.png)

### SquareTextureCrop[​**](#squaretexturecrop "Copy to clipboard")

The `SquareTextureCrop` script allows modifying a [Screen Crop Texture](/lens-studio/features/snap-ml/ml-component/crop-textures.md) asset in a certain way. Specifically, it allows you to cut out a square piece of the input texture as displayed on a picture below. It allows to pass an image of an aspect 1:1 to the ml model that is often a kind of input image the model is trained on.

**Crop Texture** is a [Screen Crop Texture](/lens-studio/features/snap-ml/ml-component/crop-textures.md) to apply crop to.

**Type**:

* **Screen Center:** Crops square from the center of the screen.
* **User Tap:** Crops square around the user tap.
* **Scale Multiplier:** a crop region scale multiplier.

![](/assets/images/multi_class_classification_center_crop-45417f4f7d2a961ea52fae248ba36688.png) [](/img/lens-studio/multi_class_classification_crop_around_tap.webm)

Use the [Rectangle Setter](/lens-studio/features/snap-ml/ml-component/crop-textures.md#rectangle-setter) component on a Screen Image that displays your crop texture to place it to the same screen region it was cropped from.

Now we can use the modified ScreenCropTexture asset in components ans materials as any other texture.

### Setting up Model and Labels[​**](#setting-up-model-and-labels "Copy to clipboard")

![](/assets/images/multi-class-scripts-c096ce3e98bc41c49db7c2d02700246a.png)

The `MultiClassClassification` script contains references to two main components that contain our setup:

![](/assets/images/multi-class-scripts-1-844da2341735ef7bca0e29f48873b2b3.png)

`ML Component` that controls a multi classification machine learning model.

`Labels` is a script that contains our classes labels.

If you don’t specify labels - indices will be used instead.

Let’s take a look at these components before we go to the further settings and see how we can replace models and labels with the ones generated in the previous part of the guide.

At this point you should have two models imported to the `Asset Browser` panel:

![](/assets/images/multi-class-models-0dd1383fc917d025018627c4c5d63ceb.png)

Select the **MLComponent** scene object, set the model by clicking on the `Model` field of the MLComponent component and selecting the model of your choice in the popup dialog.

Click on the **Inputs**, select **Texture** field and select the **Screen Crop Texture** asset as it gets reset after swapping a model.

[](/img/lens-studio/5-snap-ml/multi-class-set-inputs.webm)

For this example we are going to use auto settings:

* **Auto Build:** means that the model will be built as soon as the lens is loaded.
* **Auto Run:** means that the model will be run on every frame before the script update event.

Learn more about how you can run 'MLComponent' on different events (for example using a [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script) and with different settings in [MLComponent Overview](/lens-studio/features/snap-ml/ml-overview.md).

#### Modifying labels[​**](#modifying-labels "Copy to clipboard")

Along with the model files you have a `.json` file with labels downloaded. Open the `FlowerClassificationLabels [OPEN ME].js` file in the script editor, copy and paste the contents of the downloaded json file as shown below:

```
script.labels = [contents of  the .json file]
```

Save your file.

Now that we have the model and labels configured, let's get back to the `MultiClassClassification` script.

![](/assets/images/multi-class-threshold-db83f78bad71c5cb00e655264171cfaf.png)

* **Threshold** is a value that has to be passed in order for the class to be detected.
* **Top K** is the number of the classes with the highest probability to display.

### Setting up Responses[​**](#setting-up-responses "Copy to clipboard")

![](/assets/images/multi-class-callbacks-96119de7c04cbe9ef59fab943b7b053e.png)

**Call Function:** enable this checkbox to call the function of another script and pass in probabilities and labels of topK classes with highest probabilities.

* **Script Component:** script component with a function.
* **Function Name:** a name of the function.

#### Example[​**](#example "Copy to clipboard")

```
script.printValues = function (values, labels) {
  for (var i = 0; i < values.length; i++) {
    print('Label:' + labels[i] + ', prob:' + values[i]);
  }
};
```

See [ProgressBasPanel](#progress-bar-and-progress-bar-panel) script for more examples.

**Use Behavior:** enable to call custom Behavior script trigger.

* **OnFoundPrefix:** a string added to the name of a found class to form a custom Behavior trigger name
* **OnLostPrefix:** a string added to the name of a class that was lost to form a custom Behavior trigger name.

#### Example - print text once flower was found[​**](#example---print-text-once-flower-was-found "Copy to clipboard")

![](/assets/images/multi-class-behavior-a15e61d7b624460f5172ca3a09862153.png)

**Print Result To:** enable to simply print the found class to the Text component.

* **Class Text:** Text component to use.
* **Placeholder Text:** text to display when none of the classes' probability is passing the probability threshold.

#### Progress Bar and Progress Bar Panel[​**](#progress-bar-and-progress-bar-panel "Copy to clipboard")

Select the **Top K Display** Scene Object under the Orthographic camera. `ProgressBarPanel` script allows user to instantiate a certain number of objects that visualize label and probability and update them via script API.

If you imported an asset and your UI looks small and misplaced - switch Canvas settings on Orthographic camera to World unit type or tweak inputs of the `Layout Grid` script.

![](/assets/images/multi_class_classification_progress_bar_panel-db5e17f41a29709936ec6930b2178038.png)

**Progress Bar Prefab:** an [object prefab](/lens-studio/lens-studio-workflow/prefabs.md) that contains several Scene Objects and a `ProgressBar` script.

The `ProgressBarPanel` setup can be used outside of this project for easy visualization of your data. Simply pass in an array of labels and values using this function:

```
/**
 *
 * @param {float[]} values
 * @param {string[]} labels
 */
function setValues(values, labels) {
  for (var i = 0; i < Math.min(progressBars.length, values.length); i++) {
    progressBars[i].value = values[i];
    progressBars[i].label = labels[i];
  }
}
```

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
