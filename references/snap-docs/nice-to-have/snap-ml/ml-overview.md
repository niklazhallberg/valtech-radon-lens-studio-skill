# SnapML Overview

In this guide, we will go over some of the bigger concepts that underlie how machine learning works within Lens Studio and Snapchat. Many of these ideas are common to machine learning, so you may be familiar with a few of them already. If not, don’t worry, we’re here to help!

## Machine Learning and Lens Studio[​**](#machine-learning-and-lens-studio "Copy to clipboard")

Practically speaking, you might already be using machine learning in Lens Studio without realizing it if you’ve been using [segmentation](/lens-studio/features/ar-tracking/body/segmentation/fullscreen-segmentation.md), [skeletal tracking](/lens-studio/features/ar-tracking/body/body-templates/skeletal.md), and other features!

In addition to the built-in ML (machine learning) models which come with Lens Studio, Lens Studio 3.0 introduces SnapML. SnapML allows you to add your own ML models to your Lenses, which means that you can extend the capabilities of Lens Studio to do more than what it comes with!

Lenses with SnapML are distributed in the same way as other Lenses are, which means they are available to millions of Snapchatters without them having to download a new app or do anything additional!

## How it Works[​**](#how-it-works "Copy to clipboard")

The capabilities you can add to Lens Studio and Lenses depends on the ML models that you have. ML models provide instructions for applying an algorithm in order to arrive at a result.

You can import models created using many different frameworks like [PyTorch](/lens-studio/features/snap-ml/ml-frameworks/export-from-pytorch.md), [TensorFlow](/lens-studio/features/snap-ml/ml-frameworks/export-from-tensorflow.md), [Roboflow](https://universe.roboflow.com/) and frameworks compatible with `ONNX`.

![](/assets/images/ml-overview_ml-overview-1-9ff765c5f90d223229b6bab33251da2e.png)

In the case of Lens Studio, the outputs of models are used to enable features in Lenses.

For example, one model may take the camera input, run it through the computational graph, and arrive at a texture which colors the sky in white, and everywhere else in black. In other words, this model segments the sky.

![](/assets/images/ml-overview_ml-overview-2-e686fda73ea93cfd59b5c28741249631.png)

## Using ML Models[​**](#using-ml-models "Copy to clipboard")

![](/assets/images/ml-overview_ml-overview-3-f697cb29eaa84c0fc837b071721bfa36.png)

Models you bring into Lens Studio act similar to a black box, in that Lens Studio does not know exactly what it needs and what it provides. In other words, since every model may have different inputs (what it needs) and outputs (what it provides), you’ll need to tell Lens Studio what it should provide to the model, and how to use the result.

Lens Studio supports .ONNX (Open Neural Network Exchange) and .TFLite (TensorFlow Lite) file formats.

For example, in the sky segmentation case above, in order to detect where the sky is in the frame, we’d tell Lens Studio to pass in the camera texture. But another model may only need a texture around the face since the model only cares about the face--such as a model which outputs (classifies) if a person is wearing glasses or not. Yet another model may not need any texture at all.

[](/img/lens-studio/ml-overview_ml-overview-4.webm)

In the same way, the output of models may be different for each one. While the sky segmentation model described above would output a black and white image which can be used as a mask texture, a model which outputs whether or not someone is wearing glasses or not would only need to output the probability of the presence of glasses.

In other words, SnapML can implement not only computer vision use cases--like [detecting glasses](/lens-studio/features/snap-ml/snap-ml-templates/classification.md)--but also machine learning based visual effects--like [style transfer](/lens-studio/features/snap-ml/snap-ml-templates/style-transfer.md)!

 You can output data or images. If your output is an image, you can use it directly on an [Image Component](/lens-studio/assets-pipeline/2d/image.md), or anywhere a texture is used!

## ML Component[​**](#ml-component "Copy to clipboard")

[](/img/lens-studio/ml-overview_Import-in-LS.webm)

The way you instruct Lens Studio to use a model is via the [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md).  With it, you can not only tell Lens Studio what data to pass in to the model and what data comes out of it, you can also say how the model should be run: should it run every frame, when the user takes an action, or even in another thread so your Lens can continue to run in real-time!

In other words, these models are used in Lens Studio via the ML Component, in a similar manner to how textures are used on the Image Component.

 SnapML takes care of running your model in the most optimized way possible, leveraging device-specific hardware acceleration when available. Take a look at the [Compatibility Table](/lens-studio/features/snap-ml/compatibility.md) for more information.

## Templates[​**](#templates "Copy to clipboard")

Lens Studio comes with 5 different templates which demonstrate how to use SnapML and ML Component.

* [Classification](/lens-studio/features/snap-ml/snap-ml-templates/classification.md): Useful as a starting point for binary classification type models which output the probability of something. The template comes with a model that can return the probability of whether someone is wearing glasses or not and call an effect based on this information.
* [Object Detection](/lens-studio/features/snap-ml/snap-ml-templates/object-detection.md): Useful as a starting point for object detection type models which output the location and probability of an object on the camera feed. The template comes with both a car and food detection model, as well as a way to visually call it out.
* [Style Transfer](/lens-studio/features/snap-ml/snap-ml-templates/style-transfer.md): Useful as a starting point for style transfer type models which take in a texture and return a modified texture. The template comes with an example style transfer model.
* [Custom Segmentation](/lens-studio/features/snap-ml/snap-ml-templates/custom-segmentation.md): Useful as a starting point for segmentation type models which take in a texture, and return a segmented version of that texture. The template comes with a pizza segmentation texture and uses Material Editor to make it look sizzling.
* [Ground Segmentation](/lens-studio/features/snap-ml/snap-ml-templates/other-ml-templates/ground-segmentation.md): A template which uses a segmentation model to segment the ground. The template comes with a way to replace the ground with a material and to occlude objects not on the ground.
* [Keyword Detection](/lens-studio/features/audio/audio-templates/keyword-detection.md): Useful as a starting point for audio related ML models. The template comes with two models that can return the probability of a spoken word given a spectrogram analysis of the audio.
* [Multi Object Detection](/lens-studio/features/snap-ml/snap-ml-templates/multi-object-detection.md): Useful as a starting point for multi-class object detection ML models. The template comes with a model that allows you to detect 7 classes of objects: cat, dog, potted plant, TV, car, bottle, cup.

These templates come with their own sample model so you don’t need to worry about training your own! That being said, these templates are designed with flexibility in mind, and you should be able to use it with similar models of your own.

For example, if you wanted to create a Lens that draws a detection box around household objects, you can bring in a similar object detection model that is trained for household objects, and plug it into the Object Detection Template, and it will work.

 It might take longer for your SnapML Lenses to be reviewed. Please refer to the [Community Submission](/lens-studio/publishing/submitting/submitting-your-lens.md) guide under Lens Statuses for more information.

## Making your own model[​**](#making-your-own-model "Copy to clipboard")

[](/img/lens-studio/ml-overview_Training-Process.webm)

While models are built outside of Lens Studio, you can take a look at the template guides which provide a walkthrough, as well as example code (python notebooks) that can be used to build your own model!
