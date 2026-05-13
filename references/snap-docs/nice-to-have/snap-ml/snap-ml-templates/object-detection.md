# Object Detection

The Object Detection example allows you to instantiate and place UI elements on the screen corresponding to the bounding boxes of objects belonging to a specific class, as identified by a Machine Learning model's output.

## Guide[​**](#guide "Copy to clipboard")

If you already have an **object detection model**, you can skip down to the **Importing Your Model** section below. You can skip to the **Customizing Your Lens Experience** section if you’d like to use the example car or food detection.

### Creating a Model[​**](#creating-a-model "Copy to clipboard")

While the example comes with a car detection and food detection example model for the [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md), you can make any kind of object detection by importing your own machine learning model. We’ll go through an example of what this might look like below.

To learn more about Machine Learning and Lens Studio, take a look at the [ML Overview](/lens-studio/features/snap-ml/ml-overview.md) page.

#### Prerequisites[​**](#prerequisites "Copy to clipboard")

To create a model, you will need;

* **Machine learning training code:** code that describes how the model is trained (this is sometimes referred to as a notebook). Please find our [example notebook here](https://github.com/Snapchat/snapml-templates/blob/main/Object%20Detection/object_detection.ipynb).
* **Data set:** collection of data that our code will use to learn from (in this case we will use the [COCO data set](http://cocodataset.org/#home)).

This dataset comes with a couple examples of classes that you can swap. Also the provided training notebook uses a generalized classes that consist of couple more specific classes in order to perform better on the particular dataset

### Training Your Model[​**](#training-your-model "Copy to clipboard")

There are many different ways you can train your model. For our example, we will use [Google Colaboratory](https://colab.research.google.com/). To see other ways of training, take a look at the [ML Frameworks](/lens-studio/features/snap-ml/ml-frameworks/export-from-pytorch.md) page for more information.

Head over to Google Colaboratory, select the `Upload` tab, and drag the python notebook into the upload area.

[](/img/lens-studio/object-detection_importing-model.webm)

The provided example is using the COCO dataset for training the model. Running the notebook will install all the necessary libraries and mount google drive.

You can configure your training by editing some parameters like iteration count. It also provides all available COCO dataset classes.

With our files added, you can run the code by choosing  `Runtime > Run All` in the menu bar. This process may take a while to run, as creating a model is computationally intensive.

![](data:image/png;base64,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)

 When using a data set to train your model, make sure that you adhere to the usage license of that dataset.

#### Downloading your Model[​**](#downloading-your-model "Copy to clipboard")

You can scroll to the Train Loop section of the notebook to see how your machine learning model is coming along. Once you are happy with the result, you can download your `.ONNX` model!

### Getting the Example[​**](#getting-the-example "Copy to clipboard")

Open the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md), and look for `Style Transfer`, and press the `Import` button to bring it into your project.

![](/assets/images/od-1-51575d7a2204fefb590e170d4ac2f7f8.png)

Once you import the asset from Asset Library, you can find the package in the `Asset Browser` panel. Follow the instructions and drag the prefab `Style Transfer` into `Scene Hierarchy` panel under an `Orthographic` camera to create a new Scene Object.

[](/img/lens-studio/5-features/od-2.webm)

Orthographic Cameras are used to show effects on the screen. If you do not have one yet, you can press the `+` button in the `Scene Hierarchy` panel, and add the `Orthographic Camera`.

![](/assets/images/style-transfer-2-255e664b0c9608ab98fa15cd38f3ef28.png)

### Importing your Model[​**](#importing-your-model "Copy to clipboard")

Now we’ll import our model into Lens Studio.

You can drag and drop your `.ONNX` file into the `Asset Browser` panel to bring it into Lens Studio.

[](/img/lens-studio/5-features/od-3.webm)

Next, we’ll tell the example to use this model. In the `Scene Hierarchy` panel, select `ML Component`. Then, in the `Inspector` panel, click on the field next to `Model`, and then in the pop up window, choose your newly imported model.

![](/assets/images/od-4-0cf7fcd533664e45685a1f326221155f.png)

### Preparing your Preview[​**](#preparing-your-preview "Copy to clipboard")

Since this example is detecting a specific object, it'll be useful to change the `Preview` panel to show an image/video which triggers the detection. You can use this sample image below, or bring in your own.

Take a look at the [Previewing Guide](/lens-studio/lens-studio-workflow/previewing-your-lens.md#multimedia-preview) to learn more.

![](/assets/images/od-5-e6b041657320ccd41fe277473fce1bfe.jpg)

### Setting up MLComponent[​**](#setting-up-mlcomponent "Copy to clipboard")

If you are using the built in ML models, you can skip this section.

Next, we’ll tell the example to use this model. In the `Scene Hierarchy` panel, select `ML Component`. Then, in the `Inspector` panel, click on the field next to `Model`, and then in the pop up window, choose your newly imported model.

Next, we’ll set up the input for the ML Component to pass in the image most similar to how our model was trained.

The model that comes with the example uses the following input settings:

![](/assets/images/od-6-8f206ad1b98df0835e6e8b698fef0b9c.png)

* Input **shape** is 128 x 256 with 3 channels (for RGB) - using default settings for model here.

* DeviceCameraTexture is used as the **input texture**, as in we pass the camera feed to the model.

* **Input Transformer Settings**

  * Stretch is turned off, because the detector works better if objects on the input texture preservers their original proportions.

  * Horizontal and Vertical alignments are set to Center

  * Rotation is set to none

  * Fill color is set to black

These transform settings will take the original input texture and add paddings where needed depending on the device settings to fit the aspect of the input placeholder (in this case we have size 128 x 256 , aspect = 0.5).

![](/assets/images/object-detection_object-detection-4-d045c0ab37394ecf0b41d23404f0649a.png)

As for the outputs - we will keep all the default settings since the MLController script will process the raw output data in the `MLControllerScript`.

![](/assets/images/od-7-89a51e4945fbbb9b73f6aa3ba9c4e169.png)

### Trying Example Models[​**](#trying-example-models "Copy to clipboard")

Although the default ML model is set for car detection, the example also comes with a food detection model.  You can swap it with the food detection model found under `Example Assets/Food Detection[TRY_SWAPPING]` in the `Asset Browser` panel, by inputting the ML model into the `Model` field on `MLController[SWAP_MODEL]` object.

![](/assets/images/od-8-e6a7f220010894145bb58210b1d9e304.png)

#### MLController[​**](#mlcontroller "Copy to clipboard")

If you are using the built in ML models, you can skip this section.

The `MLController[EDIT_ME]` object contains the ML Component and the MLController script which controls the MLComponent and processes its output.

![](/assets/images/od-9-b7c2bc7e448dcca1b3bbe3691c61b849.png)

#### MLController Script [​**](#mlcontroller-script "Copy to clipboard")

By default all you will need to do is link your ML Controller to the MLController script, but you can find more model specific parameters by ticking `Advanced`.

The `Output Cls` and `Output Loc` need to have the same name as the ones in your ML model. This should be left as it is if you are using the provided notebook for training.

**Output Loc -** name of the MLComponent output that provides unprocessed detection locations.

**Output Cls -** name of the MLComponent output that returns scores(probability) of the detections.

The Output Loc and Output Cls should have the same name as the ones in your ML model, you can find out the output names on the ML Component.

**Confidence Threshold -** defines the minimum score of unprocessed detections that will be taken into account. If the detection threshold is lower--they will be skipped.

**TopK -** is the amount of detections with highest score to keep

**Loader -** is the UI element that will show up when the ML model is being loaded.

Machine Learning model is used to create proposals of bounding boxes of a certain class based on the input image. This script applies a Non-maximum suppression algorithm to filter and post process those detections based on some criteria. If the Intersection over union (IOU) of detected boxes is higher than the Confidence Threshold value, they will be considered the same box.

## Customizing Your Lens Experience[​**](#customizing-your-lens-experience "Copy to clipboard")

### Object Detection Controller[​**](#object-detection-controller "Copy to clipboard")

The Object Detection Controller contains the `ObjectDetectionController` script which takes the processed detection boxes from the  `MLController` script, instantiates the corresponding amount of detection boxes and controls their `Screen Transform` components.

![](/assets/images/od-10-a0b268e656b057eb30064d92d9de87c1.png)

The **Counter** object - is the Text Component used to output the amount of objects detected at the current moment of time.

The **Object To Copy** - is the object to duplicate. It has to have a ScreenTransform Component. By default it is set to the `Detection Box[EDIT_CHILDREN]` sceneObject.

**Smoothing** determines the smoothing applied to the detection box anchor positions. The higher the number, the smoother and slower detection screen transforms move. If smoothing equals `0.0` -  this means no smoothing.

**Hint Controller** is the HintController script that controls the hint displayed when an object is not detected.

You can optionally fine tune additional settings that help smooth detection boxes positions on the screen by ticking the Advanced checkbox:

**Matching Threshold** sets the breakpoint ratio of the intersection of two processed detection boxes over  their union, that determines whether two detection boxes should be considered as different or the same.

**Lost Frame Threshold** determines the amount of frames the instantiated visual element will be kept when current detection is defined as lost. A larger number of Lost Frame Threshold means it takes longer for a box to be removed after an object has been lost. Having a smaller number would provide more instantaneous updates and a larger number would create a more smoothed result.

### Detection Box[​**](#detection-box "Copy to clipboard")

`Detection Box [EDIT_CHILDREN]` is the object that is duplicated by the ObjectDetectionController script for each detected object.

The Object Detection model provides us the information about the detection boxes positions in screen space. The Detection Box object is using [ScreenTransform Component](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md).

Using Screen Transform allows you to create a complex layout of 2d elements (Screen Images and Screen Text) within its Screen Transform.  Anchors of the **Detection Box** screenTransform will be driven by a script and all the children Screen Transforms will adapt accordingly to their setup.

To see how your detection box would respond to different size objects, double-click on the `Detection Box [EDIT_CHILDREN]` object and manipulate its anchors in the `2D Scene` panel to see how it affects children:

[](/img/lens-studio/object-detection_object-detection-9.webm)

**Detection Box object** provided in the example has several children objects :

**Small Hint** (swap the texture on the Image Component of this object). This image uses the `Pin To Edge` and `Fix Size` option so that its size and position stays constant on the screen.

**Frame** . The frame represents the visual surrounding the detection boxes. It is built from 8 parts - one for each edge, and one for each corner. They are using different combinations of `Pin to Edge` settings.

Refer to the [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) guide to set up your custom children layout.

You can also swap textures used for the frame in the resources. Select the `Frame` object in the `Scene Hierarchy` panel, and in the `Inspector` panel, click on the `Texture` field to choose another one.

![](/assets/images/od-11-f4e57011966af35fcd6caa2efb380950.png)

This texture should also be designed as a 9-slice texture--meaning, the sides of the images can be stretched to fit the various detection. You can change the size of the border which should be stretched, by modifying the material the texture is on. To do this, click on the `Open Full Inspector` in the `Image` component's material to edit the material's setting.

![](/assets/images/od-12-850e873ea6ac9964af40b886eec44c2e.png)

#### Hint[​**](#hint "Copy to clipboard")

To customize the hint shown when an object is not detected select `Hint [EDIT_CHILDREN]` object in the `Scene Hierarchy` panel.

`HintController` script has an api that allows to call functions that show and hide the `HintSceneObject` from other scripts. To avoid hint from constantly popping up in case if detections are a bit noisy and can disappear for a couple frames, you can set a `MinLostFrames` parameter. If there are no detections found for this amount of frames - hint will show up.

Enable `HideOnCapture` checkbox if you don’t want the hint to appear on the final snap.

Expand the `Hint [EDIT_CHILDREN]` objects hierarchy to modify what the hint displays.

Select the `Big Hint [EDIT_ME]` object to change the image displayed. Swap the `Texture` parameter of the Image component of the `Big Hint [EDIT_ME]` object in the `Inspector` panel.

Similarly, change the text of the TextComponent of the `Hint Text [EDIT_ME]` object on the `Inspector` panel.

![](/assets/images/od-13-a6b5a24b9b1d1d576fe0c3900eb2b501.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
