# Scripting ML Component

Although you can configure and run your ML models using the [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md) found in the Lens Studio UI, you can have additional flexibility to fine-tune the way your model is run using its [API](/api/lens-studio/Classes/Components.md#MLComponent). Additionally, you can use it to pass in or get data from your model.

This page will go through some common scenarios when scripting the ML Component. You can find the full list of API in the [API documentation](/api/home.md).

Take a look at the [Scripting guide](/lens-studio/features/scripting/script-overview.md) to learn how to use the scripting system.

## ML Component Lifecycle[​**](#ml-component-lifecycle "Copy to clipboard")

For reference, you can see the lifecycle of an ML Component below.

![](/assets/images/scripting-ml-component_Machine-Learning-Model-States-c797e422f081b944468691cb2b04ece7.png)

## Create ML Component[​**](#create-ml-component "Copy to clipboard")

You can create the ML Component in the same way you would create other components in script.

```
var mlComponent = script.sceneObject.createComponent('MLComponent');
```

Like with the ML Component UI, we need to initialize its settings. In particular:

We can pass in a model to our script by creating an input to the script, and selecting our model in the `Inspector` panel where our script is.

```
//@input Asset.MLAsset model
```

Then we can assign the model to the created ML Component.

```
mlComponent.model = script.model;
```

Next configure and build the ML Component’s [InputPlaceholders](/api/lens-studio/Classes/ScriptObjects.md#InputPlaceholder) using [InputBuilder](/api/lens-studio/Classes/ScriptObjects.md#InputBuilder).

```
//@input string inputName = "input"
var inputBuilder = MachineLearning.createInputBuilder();
inputBuilder.setName(script.inputName);
inputBuilder.setShape(new vec3(64, 64, 3));
var inputPlaceholder = inputBuilder.build();
```

And its [OutputPlaceholders](/api/lens-studio/Classes/ScriptObjects.md#OutputPlaceholder) using [OutputBuilder](/api/lens-studio/Classes/ScriptObjects.md#OutputBuilder):

```
//@input string outputName = "probs"
var outputBuilder = MachineLearning.createOutputBuilder();
outputBuilder.setName(script.outputName);
outputBuilder.setShape(new vec3(1, 1, 1));
outputBuilder.setOutputMode(MachineLearning.OutputMode.Data);
var outputPlaceholder = outputBuilder.build();
```

Input [Transformer](/api/lens-studio/Classes/ScriptObjects.md#Transformer) can also be created in a script and set via `setTransformer` method of an input and output placeholder builders

```
var transformer = MachineLearning.createTransformerBuilder()
.setVerticalAlignment(VerticalAlignment.Center)
.setHorizontalAlignment(HorizontalAlignment.Center)
.setRotation(TransformerRotation.Rotate180).
.setFillColor(new vec4(0, 0, 0, 1)).build();
```

## Build ML Component[​**](#build-ml-component "Copy to clipboard")

Now that we’ve set up our input and output, we can build our ML component so that it will be ready to run our model when we need it. Provide an array of all input and output placeholders as a parameter of `build` function:

```
mlComponent.build([inputPlaceholder, outputPlaceholder]);
```

You can set up your model, input, and output in the `Inspector` panel but build it in script as well by disabling the **Auto Build** checkbox and calling `build`

```
var mlComponent = script.getComponent(“Component.MLComponent”);
mlComponent.build([]);
```

Passing an empty array as a parameter. In this case input and output settings will be taken from the ML Component settings specified in the `Inspector` panel.

## Callbacks[​**](#callbacks "Copy to clipboard")

There are a couple useful callback functions available to hook logic to the state of your ML Component:

`onLoadingFinished` is called when the model has finished building, and right before it can start running. After the model has been loaded you can start working with its inputs and outputs.

```
mlComponent.onLoadingFinished = onLoadingFinished;
function onLoadingFinished() {
  //do something
  //access inputs and outputs
  //start running
}
```

Please be sure to set this callback before calling `build`, otherwise it may not be executed. If your **Auto Build** checkbox is checked - set it on script initialized event.

`onRunningFinished` is called after the model has finished running the last time it has been called. You can use this callback with both synchronous and asynchronous modes when running the model once or on update.

For example, to use this callback to process an ML Component’s output when running the model asynchronously you can do:

```
mlComponent.onRunningFinished = onRunningFinished;
mlComponent.runImmediate(false);
function onRunningFinished() {
  //process output
}
```

These callbacks are properties which means that if you assign another function to the callback, it will replace the previous one.

## Accessing inputs and outputs[​**](#accessing-inputs-and-outputs "Copy to clipboard")

You can access inputs and outputs only after the model has been built.

For Example: setting input texture and saving reference to the input data

```
//@input Asset.Texture deviceCameraTexture
//@input string textureInputName
//@input string dataInputName
var inputData;
function onLoadingFinished() {
  var input = mlComponent.getInput(script.textureInputName);
  input.texture = script.deviceCameraTexture;
  var input1 = mlComponent.getInput(script.dataInputName);
  inputData = input1.data;
}
```

All input and output data are Float32Arrays.

To modify the values within this data array, direct reassignment (e.g., `input1.data = newData`) is not permitted. Instead, you must update its values using the following approach:

```
//...
for (var i = 0; i < inputData.length; i++) {
  inputData[i] = someNewValue;
}
```

Output data or textures can be accessed in the same way:

```
var outputData = mlComponent.getOutput(script.output1Name).data;
var outputTexture = mlComponent.getOutput(script.output2Name).texture;
```

It is always efficient to save the reference to the input/output data array or texture instead of accessing it via output every time.

## Running ML Component[​**](#running-ml-component "Copy to clipboard")

Depending on what your model does, you can tell the ML Component to run (the inference):

* Immediately / scheduled
* Synchronously / asynchronously
* Once / run always

`runImmediate(bool isSync)`: Initiates the execution of the ML Model with an option to either wait for the process to complete before returning (synchronous) or allow it to complete naturally (asynchronous). In both scenarios, `onRunningFinished` will be triggered during the next update cycle after the inference concludes.

### Examples[​**](#examples "Copy to clipboard")

* `runImmediate(false)`: Executes the ML Component asynchronously. Utilize the `onRunningFinished` callback to handle completion.
* `runImmediate(true)`: Executes the ML Component synchronously. The subsequent line of code will not run until the model completes execution, allowing for immediate processing of the output.

`runScheduled(boolean isRecurring, MachineLearning.FrameTiming startTiming, MachineLearning.FrameTiming endTiming): void`: Initiates execution at the specified `startTiming` and concludes at the specified `endTiming` (or completes naturally if `endTiming` is set to `FrameTiming.None`).

* `isRecurring`: If set to true, inference will commence each time `startTiming` is reached, provided an inference is not already in progress.
* `startTiming`: Specifies the point when the ML Component begins execution.
* `endTiming`: Specifies the point when the ML Component concludes execution.

## Frame Timing[​**](#frame-timing "Copy to clipboard")

**startTiming** is the point where all inputs are ready, and **endTiming** is the point at which the output is required. Several options are available for `startTiming` and `endTiming`:

* `MachineLearning.FrameTiming.Update`: Initiates or concludes execution during the ML Component update. This occurs naturally before any script invocation and is optimal for preparing tracking data. The model will run using the current frame, ensuring any script accessing this data has it ready.

* `MachineLearning.FrameTiming.LateUpdate`: Initiates or concludes execution during the ML Component's LateUpdate, post all script updates but prior to their LateUpdate execution.

* `MachineLearning.FrameTiming.OnRender`: Initiates or concludes execution at a specific point during frame rendering. Ideal for scenarios where an input texture prepared in the current frame needs to be processed into an output texture for use within the same frame.

* `MachineLearning.FrameTiming.None`: Valid only as an end timing, indicating no wait. Inference will restart automatically after completion (asynchronous execution).

Next chart helps to understand when these moments of time happen in relation to script events:

![](/assets/images/scripting-ml-component_ml-lifecycle-large-cf0074b1b49ce18d7a5b887a619bf4aa.png)

When `startTiming == endTiming`, the model operates synchronously. If they differ, the model runs in parallel, ensuring the output data is available at a specific time.

If `startTiming != endTiming`, ensure that inputs are not updated, nor output data accessed, between these times. This is crucial as the ML Component operates on a parallel thread, and results may not be reliable if these conditions are not met.

The `Auto Run` checkbox on the ML Component functions equivalently to `runScheduled(true, MachineLearning.FrameTiming.OnRender, MachineLearning.FrameTiming.OnRender)`

Configure the settings of the Scene asset to specify when exactly `OnRender` frame timing happens. You can find the Scene asset in Asset Browser, select the Scene asset and you can find the settings in `Inspector` panel.

[](/img/lens-studio/scripting-ml-component_ML-11-Scene-Config.webm)

Check out the [Style Transfer Template](/lens-studio/features/snap-ml/snap-ml-templates/style-transfer.md) or [Object Detection Template](/lens-studio/features/snap-ml/snap-ml-templates/object-detection.md) to see how different update modes for ML Component are used.

You can use a [Behavior script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to run ML Component with different settings without writing any code:

![](/assets/images/scripting-ml-component_ML_Behavior-16f18d25b29a2705a5c4497fdcc9950d.png)
