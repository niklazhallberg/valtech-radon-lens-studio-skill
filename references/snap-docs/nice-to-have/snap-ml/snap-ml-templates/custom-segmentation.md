# Custom Segmentation

Lens Studio allows you to create a custom segmentation mask using a ML model through the [ML Component](/lens-studio/features/snap-ml/ml-overview.md). This guide will walk you through creating custom segmentation model for Pizzas and building a Lens experience which makes the pizza appear hot.

[](/img/lens-studio/custom-segmentation_custom-segmentation.webm)

`Custom Segmentation` asset is available in the Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create new Orthographic camera and place the prefab under it.

Skip to the [Importing Your Model](#downloading-your-model) section if you have the ML model ready.

Skip to the [Customizing Lens](#customizing-your-lens-experience) section if you want to use the existing pizza segmentation texture.

### Creating an ML Model[​**](#creating-an-ml-model "Copy to clipboard")

To learn more about Machine Learning and Lens Studio, please visit the [ML Overview](/lens-studio/features/snap-ml/ml-overview.md) page.

To train a segmentation ML model, you will need the following:

* **Machine learning training code:** The code that describes how the model is trained. This is sometimes referred to as a notebook. You can [download our example notebook](https://github.com/Snapchat/snapml-templates/blob/main/Custom%20Segmentation/segmentation_training.ipynb) if you want to follow along.
* **Data set:** A collection of data that our code will use to learn from (in this case we will use the [COCO data set](http://cocodataset.org/#home)).

This dataset comes with multiple labels that you can modify in order to change what type of mask is used. You can try creating different ones.

### Training Your Model[​**](#training-your-model "Copy to clipboard")

There are many different ways you can train your model. For our example, we will use [Google Colaboratory](https://colab.research.google.com/). To see other ways of training, take a look at the [ML Frameworks](/lens-studio/features/snap-ml/ml-frameworks/export-from-pytorch.md) page of the guide section.

Head over to Google Colaboratory, select the `Upload` tab, and drag the python notebook into the upload area.

[](/img/lens-studio/custom-segmentation_importing-model.webm)

The notebook is well documented with information about what each section of the code is doing. Take a look at the notebook to learn more about the training process itself!

Once your notebook has been opened, you can choose which labels you want the model to segment out. Then, you can run the code by choosing  `Runtime > Run All` in the menu bar. This process may take a while to run, as creating a model is computationally intensive.

![](data:image/png;base64,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)

#### Downloading your Model[​**](#downloading-your-model "Copy to clipboard")

You can scroll to the Train Loop section of the notebook to see how your ML model is coming along.

Once you are happy with the result, you can download your `.ONNX` model.

 When using a data set to train your model, make sure that you adhere to the usage license of that dataset.

### Importing your Model[​**](#importing-your-model "Copy to clipboard")

Now that we have our model, we’ll import it into Lens Studio.

You can drag and drop your `.ONNX` file into the `Asset Browser` panel to bring it into Lens Studio.

[](/img/lens-studio/5-snap-ml/custom-segmentation-import.webm)

Please have the `Custom Segmentation` asset imported and added to Orthographic Camera.

To use imported model navigate to `Scene Hierarchy` panel, and under `Custom Segmentation` object select `ML Component` object. Then, in the `Inspector` panel, click on the field next to `Model`, and then in the pop up window, choose your newly imported model.

[](/img/lens-studio/5-snap-ml/custom-segmentation-use-model.webm)

Next, set model input texture to `Screen Crop Texture` or `Device Camera Texture`. Then click on the **Output Texture** field and create new `Proxy Texture`. `Proxy Texture` asset is a texture that can be used in materials and effects.

[](/img/lens-studio/5-snap-ml/custom-segmentation-set-textures.webm)

If you have created a new proxy texture, make sure to set it as the input for the materials provided in this example to see the effects.

## Customizing your Lens Experience[​**](#customizing-your-lens-experience "Copy to clipboard")

You can see in the ML Component, that it has an `Output Texture` of `Segmentation Texture`. This Texture can be used in any way that textures are used.

[](/img/lens-studio/custom-segmentation_custom-segmentation-3.webm)

### Using the output texture in material editor[​**](#using-the-output-texture-in-material-editor "Copy to clipboard")

In this example the texture is being used as input to the [Material Editor](/lens-studio/features/graphics/materials/material-editor/introduction-and-concepts.md) to create the heat effect.

![material](/assets/images/custom-segmentation-set-textures-material-e923c7a8975f797976f0cc961c9f8ff0.png)

The segmentation texture is passed in to the material using the `Texture 2D Object Parameter` node to allow your material to access inputs:

![use texture in material](/assets/images/custom-segmentation-set-textures-reference_texture-0e3a15cc2e7ea751ee90dd234147609c.png)

Please visit the [Material Editor](/lens-studio/features/graphics/materials/material-editor/welcome-to-material-editor.md) guides for more information.

Play around with some of the parameters of `Heat Distortion` material and check out the graph to see how it works!

[](/img/lens-studio/5-snap-ml/custom-segmentation-material-edit.webm)

The `Heat Distortion` material uses the segmentation mask to determine where the area should be grayscale (pixel is not pizza) and to generate the smoke noise that appears on top of the pizza.

### Using Segmentation Texture to cut things out[​**](#using-segmentation-texture-to-cut-things-out "Copy to clipboard")

You can also use the `Segmentation Texture` directly on a camera to mask what it renders.

For example, let's say we added a color correction object to make our image be sepia toned.

[](/img/lens-studio/custom-segmentation_custom-segmentation-8.webm)

Then, you can select the `Camera` object, and use the `Segmentation Texture` from the ML Component as the Camera’s `Mask Texture`.

![add camera mask](/assets/images/custom-segmentation-add-camera-mask-4a98537ec9c59f108c62d9b0012d60a4.png)

Please visit the [Fullscreen Segmentation](/lens-studio/features/ar-tracking/body/segmentation/fullscreen-segmentation.md) guide to learn about how you can use segmentation textures to cut out parts of an object or image.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
