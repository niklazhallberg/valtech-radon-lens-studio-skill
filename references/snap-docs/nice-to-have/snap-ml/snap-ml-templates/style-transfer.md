# Style Transfer

The Style Transfer example allows you to use a Style Transfer model to visually change how the camera feed looks based on another image. The example allows you to choose between always running it in real time, running it on demand, or automatically choosing between the two for the best user experience.

[](/img/lens-studio/style-transfer_style-transfer.webm)

## Guide[​**](#guide "Copy to clipboard")

  If you have your own **style transfer model**, you can skip down to the **Importing Your Model** section below.

### Creating a Model[​**](#creating-a-model "Copy to clipboard")

The Style Transfer example relies on a machine learning model to define how the camera feed should be visually changed. The example comes with an example model, but you’ll want to create your own to make your unique style transfer Lens.

To learn more about Machine Learning and Lens Studio, take a look at the [ML Overview](/lens-studio/features/snap-ml/ml-overview.md) page.

#### Prerequisites[​**](#prerequisites "Copy to clipboard")

To create a model, you’ll need a

* **Style reference image:** any image that has the style you want
* **Machine learning training code:** code that describes how the model is trained (this is sometimes referred to as a notebook). Please find our [example notebook here](https://github.com/Snapchat/snapml-templates/blob/main/Style%20Transfer/style_transfer.ipynb).
* **Data set:** collection of data that our code will use to learn from (in this case we will use the [COCO data set](http://cocodataset.org/#home))

Try using your own reference image! You can use the same training code and dataset.

When using a data set to train your model, make sure that you adhere to the usage license of that dataset.

### Training Your Model[​**](#training-your-model "Copy to clipboard")

There are many different ways you can train your model. For our example, we will use [Google Colaboratory](https://colab.research.google.com/). To see other ways of training, take a look at the ML Frameworks page of the guide section.

Head over to Google Colaboratory, select the Upload tab, and drag the notebook to the upload area.

[](/img/lens-studio/style-transfer_importing-model.webm)

The example notebook is well documented with information about what each section of the code is doing. Take a look at the notebook to learn more about the training process itself!

Once your notebook has been opened, you can add your style reference image. You can also add an image to test your results on:

[](/img/lens-studio/style-transfer_style-transfer-9.webm)

Don't forget to upload a style reference image `style_image.png` and the image you want to test on `test_image.png`**\`\`**

With our files added, you can run the code by choosing  `Runtime > Run All` in the menu bar. This process may take a while to run, as creating a model is computationally intensive.

![](data:image/png;base64,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)

#### Downloading your Model[​**](#downloading-your-model "Copy to clipboard")

You can scroll to the Train Loop section of the notebook to see how your machine learning model is coming along.

Once you are happy with the result, you can download your `.ONNX` model!

### Getting the Example[​**](#getting-the-example "Copy to clipboard")

Open the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md), and look for `Style Transfer`, and press the `Import` button to bring it into your project.

![](/assets/images/style-transfer-1-75acb3da577c9d03e00fe0fd7711498a.png)

Once you import the asset from Asset Library, you can find the package in the `Asset Browser` panel. Follow the instructions and drag the prefab `Style Transfer` into `Scene Hierarchy` panel under an `Orthographic` camera to create a new Scene Object.

[](/img/lens-studio/5-features/style-transfer-3.webm)

Orthographic Cameras are used to show effects on the screen. If you do not have one yet, you can press the `+` button in the `Scene Hierarchy` panel, and add the `Orthographic Camera`.

![](/assets/images/style-transfer-2-255e664b0c9608ab98fa15cd38f3ef28.png)

### Importing your Model[​**](#importing-your-model "Copy to clipboard")

Now we’ll import our model into Lens Studio.

You can drag and drop your `.ONNX` file into the `Asset Browser` panel to bring it into Lens Studio.

[](/img/lens-studio/5-features/style-transfer-4.webm)

Next, we’ll tell the example to use this model. In the `Scene Hierarchy` panel, select `ML Component`. Then, in the `Inspector` panel, click on the field next to `Model`, and then in the pop up window, choose your newly imported model.

![](/assets/images/style-transfer-5-59dbaedbd947fea37bbbdfa07810cbce.png)

### Connecting your Model[​**](#connecting-your-model "Copy to clipboard")

With our model hooked in, what we need to do now is to tell the Style Transfer Controller to connect to our Style Transfer model.

First, take a note of the input and output parameter in the ML Component. This should be the same as what the notebook has specified. Select the model in the `Asset Browser` panel, and in the `Inspector` panel, take note of its input and output.

Then, select the `Style Transfer Controller` object in the `Scene Hierarchy` panel to modify how the style is controlled.

![](/assets/images/style-transfer-6-76d841d2eea52fb5f66f0827d75e9a99.png)

Next, in the `Inspector` panel, type in Input name and Output name as it is shown in the ML Component.

![](/assets/images/style-transfer-7-75394541080c45c4639808a06b802f2e.png)

You should now see the `Preview` panel showing a result similar to what you saw earlier!

## Customizing your Lens Experience[​**](#customizing-your-lens-experience "Copy to clipboard")

With your style transfer working, you can preview and publish your Lens! However, you can customize your Lens even more!

#### Changing Run mode[​**](#changing-run-mode "Copy to clipboard")

By default the Lens will adapt to running your model in real time or on demand depending on the device it is running on. This is the best option as it will try to optimize the Lens for your users.

To change this, select the `Style Transfer Controller` object in the `Scene Hierarchy` panel, and choose one of the options:

* **Adapt to Device Performance:** Depending on the device, the style transfer will run in Realtime or On Demand
* **Realtime:** Style transfer will run every frame on every device (may result in lower frame rate for some devices)
* **Run on Demand:** Style transfer will run when the user presses a button.

[](/img/lens-studio/5-features/style-transfer-8.webm)

#### Changing Output Image[​**](#changing-output-image "Copy to clipboard")

By default, the Style Transfer result is displayed as a full screen image. However, you may want to change how it is displayed. To change this, in the `Scene Hierarchy` panel, press the down arrow next to the `Orthographic` Camera, then `Style Transfer Output`, and finally select the `Output Image`. Then, in the `Scene` panel, you will be able to modify your `Output image`.

To learn more about laying out your image on the screen check out the [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) guide.

[](/img/lens-studio/5-features/style-transfer-9.webm)

 This image is referenced in the `Style Transfer Controller` in the Output Image field. You can set your own image in this field as well.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
