# Multi-Object Detection

`Multi Object Detection` is available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create new Orthographic camera and place the prefab under it.

The Multi-Object Detection Template allows you create a machine learning model that detects certain objects on the screen, bring it to Lens Studio and run different effects based on the ML model output.

![](/assets/images/multi-object-detection_1-1f199ea8bbf11f953b87a886eef78709.png)

## Template Walkthrough[​**](#template-walkthrough "Copy to clipboard")

The Multi-Object Detection Template comes up with a dedicated Berry Detection machine learning model that allows to classify and detect four different kinds of berries on the user's screen; Blueberry, Strawberry, Blackberry and Blueberry

You can learn how to import your own model [here](#training-ml-model).

This template is controlled by of two main scripts: `Ml Controller` and `ObjectDetectionController` that are attached to scene objects with corresponding names.

### ML Controller[​**](#ml-controller "Copy to clipboard")

This script will configure and run an ML Model, along with processing the Model’s outputs. This script generates a list of object detections on the device’s screen for each frame.

Each detection provides such information as

* Bounding box of the object on the screen
* Probability of the detection
* Class index
* Class label (if provided)

#### ML Controller Inputs[​**](#ml-controller-inputs "Copy to clipboard")

Listed below are the ML Controller script inputs:

![](/assets/images/multi-object-detection_2-6bbfd5d4a2cf524b1cdde33dab4413c1.png)

* **ML Model**: An ML model asset exported from the [notebook](https://github.com/Snapchat/snapml-templates/blob/main/Multi-Object%20Detection/Multi-Object%20Detection.ipynb).

* **Input Texture**: Texture that is being processed with ML model. This value is set to `Device Camera Texture` by default.

![](/assets/images/multi-object-detection_3-e5318bd1a5478c34a2a847e5e0ec3894.png)

* **Class Settings**: An array of pairs of the class name, that can be used by other scripts for display, and a boolean that defines whether detections of this class are being tracked.

![](/assets/images/multi-object-detection_4-4091d4d2f02239efaa7696a48cc5fdf2.png)

* **NMS Settings**: A boolean that allows to tweak some advanced settings such as:

  <!-- -->

  * **Score Threshold**: A probability threshold class has to pass in order to be considered as detected. The lower the value is, the more false positive results you may receive, while a higher value may be more accurate but return less results.
  * **IOU Threshold**: Set Intersection Over Union threshold for detection matching. If IOU of two detected object’s bounding boxes is higher than this threshold value, they will be considered the same object (This is called NMS Algorithm).
  * **Print Debug:** Enable to print certain messages to logger or specified Text Component.

#### How ML Controller detects objects[​**](#how-ml-controller-detects-objects "Copy to clipboard")

Now that you have an idea on what the ML Controller can use as inputs, you will now learn how the script obtains information about detections.

MlController script has an `onDetectionsUpdated` event, that any script can add callback too. It passes an array of detections as its parameter:

```
/** @type {EventWrapper} Event that is called when detections are updated */
var onDetectionsUpdated = new EventWrapper(); //
```

Take a look at the EventModule script module, also located in the Asset Library, to learn more about EventWrapper class.

From any other script, you can add callback to this event and obtain list of detections as parameter:

```
// @input Component.ScriptComponent mlController
/** @type {ScriptComponent} */
var mlController = script.mlController;
mlController.onDetectionsUpdated.add(onUpdate);
/**
 * @param {DetectionHelpers.Detection} detections
 */
function onUpdate(detections) {
  /// do something with detections
}
```

Where Detection class is defined as:

```
/**
 * represents single object detection
 * @class
 * @param {[number, number, number, number]} bbox - bounding box coordinates in screen space
 * @param {number} score - detection score
 * @param {number} index - class index
 * @param {string} [label] - class label
 */
```

### Object Detection Controller[​**](#object-detection-controller "Copy to clipboard")

`ObjectDetectionController` script creates a certain amount of SceneObject copies and configures them accordingly to object detections provided by `MLController` script.

![](/assets/images/multi-object-detection_5-5aca12d8fde7c25a890dc6420c250341.png)

* **Object To Copy:** A SceneObject to copy and place on each detection.
* **Max Count:** Maximum amount of copied objects.

There are several examples of objects to copy provided in the scene. To see how different frames will look, you can drag and drop the provided objects into the `Object To Copy` input field to see different effects applied:

[](/img/lens-studio/multi-object-detection_6.webm)

* **Match Detections:** A boolean that allows you to match detected objects on screen with the detection from the previous frame. This allows the same scene object to follow the same detection and allows smoothing effects.
  <!-- -->
  * If the `Match Detections` checkbox is enabled, you can also set a **Smooth Coefficient** value to make objects move smoother on the screen.
* **Match Threshold:** An IOU coefficient threshold to consider if two detections are the same one.
* **Lost Frames:** Will keep detection for several frames, even if it was lost.
* **Set Object Position:** A boolean that enables control over screen or world object position of copied scene objects.

In the example image below, you may see the effect with no matching, then with matching and smoothing enabled:

[](/img/lens-studio/multi-object-detection_7.webm)

In addition, the `ObjectDetectionController` script will look up a script component on the `Object To Copy` instances and will call certain APIs, if available. You can see a small function example below;

```
script.updateDetection(detection);
script.resetDetection(detection);
```

See Example \[EDIT ME] script for code example which allows you to apply custom logic to each detection.

Another example to see how the script can be used, the next function allows you to change the material color based on the detection class index.

```
/**
 * @param {DetectionHelpers.Detection} detection
 */
function updateDetection(detection) {
  // set material color based on script index
  material.mainPass.baseColor = colors[detection.index];

  // set text background color
  labelText.backgroundSettings.fill.color = colors[detection.index];

  // set label
  labelText.text = detection.label + ' ' + detection.score.toFixed(2);
}
script.updateDetection = updateDetection;
```

### Object Counter Example[​**](#object-counter-example "Copy to clipboard")

The Object Counter example provides a simple setup that allows you to display a total of the amount of objects of a certain class on the screen. Select the `Object Counter` scene object to take a look at the available `ObjectCounter` script inputs:

* **MLController:** A reference to the MLController script.
* **Counter Text:** An array of Text components used to display a number of the objects.

Locate `Scripts/ExampleScripts/ObjectCounter.js` in the `Asset Browser` panel to see how it is implemented. This script adds a callback to the `onDetectionsUpdated` event of the MLController script and iterates over the array of Detections to calculate the amount of detections per class.

You can see an example of how the script is set up here:

```
// add callback
//@input Component.ScriptComponent mlController
/** @type {ScriptComponent} */
var mlController = script.mlController;
//@input Component.Text[] counterText{"hint" : "index in array should match class index"}
/** @type {Text[]} */
var counterText = script.counterText;

mlController.onDetectionsUpdated.add(onDetectionsUpdated);

function onDetectionsUpdated(detections) {
  // reset counters
  for (var i = 0; i < classCount; i++) {
    countPerClass[i] = 0;
  }
  // update from detections
  for (i = 0; i < detections.length; i++) {
    countPerClass[detections[i].index] += 1;
  }
  // update text components if set
  for (i = 0; i < classCount; i++) {
    if (!isNull(script.counterText[i])) {
      counterText[i].text = countPerClass[i].toString();
    }
  }
}
```

![](/assets/images/multi-object-detection_8-5b666364ad49402eca5f67660331a344.png)

### Switch Class On And Off[​**](#switch-class-on-and-off "Copy to clipboard")

[](/img/lens-studio/multi-object-detection_9.webm)

The MLController script allows you to turn detection of certain classes on and off in script inputs. You may also do so in runtime by tapping on certain mesh visual by calling `setClassEnabled` api function of `MLController`.

```
mlController.setClassEnabled(classIndex, isTracking);
```

To set this up you will need the following:

* Attach ToggleClassTracking.js script to the mesh visual of your choice, like an Image for example, to tap on.
* Provide a reference to the MLController script.
* Select a class index in script input.

[](/img/lens-studio/multi-object-detection_10.webm)

## Training ML Model[​**](#training-ml-model "Copy to clipboard")

While the template comes with a berry detection model for the [MLComponent](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md), you can make any kind of object detection by importing your own machine learning model. You will see an example of what this might look like below.

To learn more about Machine Learning and Lens Studio, please visit [ML Overview](/lens-studio/features/snap-ml/ml-overview.md) page.

There are many different ways you can train your model. For this example, we will use [Google Colaboratory](https://colab.research.google.com/).

Download the [notebook](https://github.com/Snapchat/snapml-templates/blob/main/Multi-Object%20Detection/Multi-Object%20Detection.ipynb) from [snapml-templates](https://github.com/Snapchat/snapml-templates) repository.

Then head over to Google Colaboratory, select the `Upload` tab, and drag the downloaded python notebook into the upload area.

[](/img/lens-studio/classification_importing-model.webm)

The provided example is using a custom dataset annotated with [Roboflow](https://app.roboflow.com/snapml/4-berries-shuffled/4). Running the notebook will install all the necessary libraries and datasets.

With our files added, you can run the code by selecting `Runtime > Run All` in the menu bar.

This process may take a while to run, as creating a model is computationally intensive.

![](data:image/png;base64,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)

### Download Model[​**](#download-model "Copy to clipboard")

You can scroll to the `Train Loop` section of the notebook to see how your machine learning model is coming along. Once you are happy with the result, you can download your `.ONNX` model using the code we provided towards the end of the notebook.

### Importing Model[​**](#importing-model "Copy to clipboard")

Open the Multi-Object Detection template from the Lens Studio home screen or create a new Lens Studio project.

When bringing your model into the Lens Studio please consider the input range model accepts. Exported model takes input in the range `[0, 1]` while the Texture input of the ML Component in Lens Studio takes values from `0` to `255`.

Drag and drop the exported `.ONNX` file into the `Asset Browser` panel and configure the input channel scale to be `0.0039215` (`1/255`).

![](/assets/images/multi-object-detection_12-6ffdfab917da37e34ee1c69d682e5543.png)

If you need to change scale and bias after the model was imported, right-click on the model asset and select **Update From Source**. Then modify settings to your liking.

You will need to configure [MLController](#ml-controller) to work with your model.

* Set `Ml Model` input with your model
* Configure `Class Settings` input to reflect your models class labels.

At this point, you should see your model up and running. You can tune experience to your liking as described in the [section above](#template-walkthrough).

## Publishing Your Lens[​**](#publishing-your-lens "Copy to clipboard")

Consider using the [Scan Trigger](/lens-studio/publishing/submitting/submitting-your-lens.md#confirm-submission) feature when publishing your Lens. This is a great combination with SnapML as it enhance user experience by allowing them to immediately start detecting objects in the camera right after they activated the Scanned those objects.
