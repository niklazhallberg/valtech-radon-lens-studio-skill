# Scripting Example

## Introduction[​**](#introduction "Copy to clipboard")

This guide will walk you through the process of creating a simple script in Lens Studio. You'll learn how to create a Script resource, connect your script to a Scene Object using the Script Component, and finally trigger the script from a Lens Event.

The script you create in this guide will add an oscillating bounce movement to a 3D object.

### Related Guides[​**](#related-guides "Copy to clipboard")

This walk-through touches on concepts from the following guides:

* [Scripting Overview](/lens-studio/features/scripting/script-overview.md)
* [Script Events](/lens-studio/features/scripting/script-events.md)
* [Custom Script UI](/lens-studio/features/scripting/custom-script-ui.md)

## Project Setup[​**](#project-setup "Copy to clipboard")

To follow this guide, you'll need to set up a Lens Studio project that has a Scene Object with a `Mesh Visual` component. You can use any mesh you like.

## Prepare the Script Asset[​**](#prepare-the-script-asset "Copy to clipboard")

With our Scene Object ready, we can now prepare a Script Asset.

To learn more about Script Assets, visit the [Scripting Introduction](/lens-studio/features/scripting/scripting-introduction.md#script-assets).

### Create a Script Asset[​**](#create-a-script-asset "Copy to clipboard")

In the `Asset Browser` panel, select `+ -> JavaScript`.

Give the newly created script a name that describes what the script does. Rename it to `Bounce`.

[](/img/lens-studio/scripting/scripting-example-create_2024-04-22.webm)

### Open the Script[​**](#open-the-script "Copy to clipboard")

You can open the `Bounce` script in either Lens Studio's internal editor, or the external text editor of your choice.

#### Internal Editor[​**](#internal-editor "Copy to clipboard")

To open your script in the built-in Lens Studio editor, double-click your Script in the `Asset Browser` panel. This will open up the [Script Editor](/lens-studio/features/scripting/script-editor.md).

![](/assets/images/scripting-example-editor_2024-04-22-d65ff0858a76d8e037fb3fd410201b5a.png)

#### External Editor[​**](#external-editor "Copy to clipboard")

To open your script in an external editor, click on your script in the `Asset Browser` panel and press `Open in External Editor`.

![](/assets/images/scripting-example-open-external_2024-04-22-a6f401e9d1960230bbe4867a0a99dde0.png)

***

## Connect the Script[​**](#connect-the-script "Copy to clipboard")

Scripts in Lens Studio are triggered by assigning them to Events on a Script Component.

### Add the Script Component[​**](#add-the-script-component "Copy to clipboard")

Select your Scene Object.

In the `Inspector` panel, select `Bounce` from under the `Project Components` category.

## Write the Script[​**](#write-the-script "Copy to clipboard")

We can now write the code for our project. This code will continuously bounce a 3D object up and down.

This section breaks down each part of the script's code. The [completed script](#completed-script-bouncejs) is provided at the end of this guide.

### Define the Script Input Fields[​**](#define-the-script-input-fields "Copy to clipboard")

Script Input Fields are variables used by a script that can be edited live in the Lens Studio `Inspector` panel.

For this script, we will define two properties:

* **`speed`**: (float) The speed at which the object will bounce
* **`range`**: (float) The range of the object's bounce

Add the following line to your script:

```
//@input float speed = 1.0
//@input float range = 10.0
```

The Script Component you added to your Scene Object should now be updated with these two inputs. Note that the `Inspector` panel view reflects the default values defined in the script.

![](/assets/images/scripting-example-1_2024-04-22-d93a599a3f373fc56f398452029e3012.png)

To learn more about script input fields, visit the [Script Introduction](/lens-studio/features/scripting/scripting-introduction.md) page.

### Create Property Widgets[​**](#create-property-widgets "Copy to clipboard")

It's possible to [create a custom Inspector interface](/lens-studio/features/scripting/custom-script-ui.md) for your Script Component inputs. This is especially useful when you have inputs that need tuning.

In the case of the Bounce script, it would be handy to adjust the `speed` and `range` inputs of the bouncing motion using sliders.

To create the custom UI, update the property definitions in your script as follows:

```
//@input float speed = 1.0 {"widget": "slider", "min": 0, "max": 10.0, "step": 0.01}
//@input float range = 10.0 {"widget": "slider", "min": 0, "max": 30.0, "step": 0.01}
```

You should now see the `speed` and `range` properties represented as sliders in the `Inspector` panel.

![](/assets/images/scripting-example-2_2024-04-22-0905bff648202afa81c1f38ce18c2959.png)

To learn more about the different UI elements you can add to Script Components, visit the [Custom Script UI guide](/lens-studio/features/scripting/custom-script-ui.md).

### Complete the Script[​**](#complete-the-script "Copy to clipboard")

Let's complete the script. Add the following code to your Bounce script, below the inputs definitions:

```
function bounce() {
  // Calculate the new height of the Scene Object and store it in newY.
  var newY = Math.sin(getTime() * script.speed) * script.range;
  // Set the new local position of the Scene Object to [0, newY, 0].
  script
    .getSceneObject()
    .getTransform()
    .setLocalPosition(new vec3(0, newY, 0));
}
```

## Bind Script to Event[​**](#bind-script-to-event "Copy to clipboard")

Because we bound this script to the `Frame Updated` event, this code will run every frame, adding an incremental change in position to the Scene Object's transform.

```
var updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(bounce);
```

To learn more about the lifecycle of script events, visit the [Script Events](/lens-studio/features/scripting/script-events.md) page.

## Preview the Lens[​**](#preview-the-lens "Copy to clipboard")

Press the Refresh button in the `Preview` panel to reload the scene. You should now see the Scene Object bouncing up and down in the `Preview` panel.

[](/img/lens-studio/scripting-example_scripting_example_preview.webm)

***

## Completed Script: Bounce.js[​**](#completed-script-bouncejs "Copy to clipboard")

Here's the completed `Bounce.js` script.

```
// Bounce.js
// Properties:
//@input float speed = 1.0 {"widget": "slider", "min": 0, "max": 10.0, "step": 0.01}
//@input float range = 10.0 {"widget": "slider", "min": 0, "max": 30.0, "step": 0.01}

function bounce() {
  var newY = Math.sin(getTime() * script.speed) * script.range;
  script
    .getSceneObject()
    .getTransform()
    .setLocalPosition(new vec3(0, newY, 0));
}

var updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(bounce);
```
