# Migrating from Meta Spark to Lens Studio

This guide serves as a way to help translate features, UI, and common workflows from Meta Spark Studio to Lens Studio. You will find one to one comparisons between the two developer platforms, like the AR Library and Asset Library, as well as explanations of unique Lens Studio features, like the GenAI Suite and the ability to create your own plugins.

## Spark to Lens Studio Glossary[​**](#spark-to-lens-studio-glossary "Copy to clipboard")

| Category   | Spark                       | Lens Studio                                                    |
| ---------- | --------------------------- | -------------------------------------------------------------- |
| Interface  | Scene                       | Scene Hierarchy: Scene                                         |
|            | Layers                      | Scene in Asset Browser                                         |
|            | Assets                      | Asset Browser                                                  |
|            | Viewport                    | Scene: Scene                                                   |
|            | Inspector                   | Inspector                                                      |
|            | Simulator                   | Preview                                                        |
|            | Patch Editor                | Shader Graph and Scripts                                       |
|            | SparkSL Shader              | Code Node in Shader Graph                                      |
|            | Console                     | Logger                                                         |
|            | AR Library                  | Asset Library                                                  |
|            | Templates                   | Sample Projects                                                |
| 3D Objects | Block                       | Prefab                                                         |
|            | Particles                   | GPU Particles or VFX                                           |
|            | Environment Light           | EnvMap                                                         |
|            | Camera Texture              | Device Camera Texture                                          |
|            | Device                      | N/A use Perspective Camera and add a Device Tracking component |
|            | Null Object                 | Scene Object                                                   |
| Tracking   | Face Tracker                | Head Binding                                                   |
|            | Target Tracker              | Marker Tracking                                                |
| Materials  | Flat Material               | Unlit Material                                                 |
|            | Retouching                  | Face Retouch Component                                         |
| Rendering  | Scene/Shader Render Pass    | Render Target (found in Asset Browser)                         |
|            | Dynamic Environment Texture | Dynamic Environment Map                                        |
| UI         | Rectangle                   | Screen Image                                                   |
|            | Plane                       | Image                                                          |
|            | 2D Text                     | Text / Screen Text                                             |
|            | 3D Text                     | Text3D                                                         |
|            | Instructions                | Hint in Project Settings                                       |
| Audio      | Speaker                     | Audio                                                          |
|            | Microphone                  | Audio Listener with Audio and Microphone Audio                 |

## The Editor UI Comparison[​**](#the-editor-ui-comparison "Copy to clipboard")

![image alt text](/assets/images/00_EditorUI-b68f55c550022495c488e7f4c7be9583.png) The layout of Lens Studio may look familiar with a few differences​​ to Spark. The panels can be moved by dragging them from the title and placing them where the highlighted blue indicators show. The layout can be reset to this default by going to Window in the toolbar and selecting Default Layout.

The main panels are:

* Scene Hierarchy
* Asset Browser
* Scene
* Logger
* Inspector
* Preview

### Scene Hierarchy (Scene)[​**](#scene-hierarchy-scene "Copy to clipboard")

![](/img/lens-studio/spark/01_SceneHierarchy.png)

Objects render from top to bottom like Spark, with the addition that scripts in the hierarchy in Lens Studio are run from top to bottom from the Scene Hierarchy. Objects can be added through the ‘+’ icon or dragged up from the Asset Browser. Coloured icons help identify the type of Scene Object quickly such as the orange camera icon for the Camera Object.

Like in Spark, the checkbox is used to toggle if the object is enabled or disabled, however it is by the object’s name as well as in the Inspector whereas in Spark it is only in the Inspector.

#### Camera Object[​**](#camera-object "Copy to clipboard")

Unlike Spark, there is no Device object by default and instead there is a default Perspective Camera added. Further cameras can be added and can be set as Perspective or Orthographic. Render Layers of Cameras can be switched in [script](https://developers.snap.com/lens-studio/lens-studio-workflow/scene-set-up/camera#examples-of-switching-cameras-in-script).

### Inspector (Inspector)[​**](#inspector-inspector "Copy to clipboard")

When a Scene Object or Asset is selected, its properties and components show up in the Inspector panel.

The following shows when a Prefab in the Scene Hierarchy is selected. It shows its Transform settings which can be adjusted here or in the Scene with the Move, Rotate, Scale and Uniform widgets. The link icon by Scale allows uniform scaling to keep the current proportions. As this Prefab has a Skin and Animation Mixer component, these are also visible. The Add Component button can be used to add further Components such as Tween Animations and Behaviour Scripts for example to toggle visibility on a tap interaction.

![](/img/lens-studio/spark/03_Inspector.png)

This example shows the Inspector if a Mesh from the same Prefab is selected from the Asset Browser panel. For this mesh it shows a Mesh and Compression Settings that can be applied to it. The original and current file size is displayed as well as a 3D Preview of the mesh for visual aid. The lighting and EnvMap applied can be changed as well as toggling on the texture map and grid to help see if the mesh is as desired. Different assets show different options such as Material, Texture and Audio settings.

![](/img/lens-studio/spark/04_Inspector.png)

### Asset Browser (Assets)[​**](#asset-browser-assets "Copy to clipboard")

![](/img/lens-studio/spark/05_Assets.png)

The Asset Browser is similar to the Asset panel in Spark. It has the addition of being able to organize Assets in Folders. Assets such as Meshes, Textures and Audio can be added by dragging and dropping from local files or through the ‘+’ icon and choosing from the available list or importing local files with the Import Asset button.

#### Device Camera Texture[​**](#device-camera-texture "Copy to clipboard")

A camera texture is in the Asset Browser by default and does not need to be extracted from a camera object like in Spark.

#### Render Target[​**](#render-target "Copy to clipboard")

A Render Target is the output texture of a single camera or the combined output of multiple cameras. Each Camera has a Render Target associated with it and multiple cameras can share one Render Target. You can add a new Render Target by ‘+’ -> Render Target from the Asset Browser panel.

#### Scene[​**](#scene "Copy to clipboard")

The Scene asset is where the Render Targets for capture, live camera view and as an overlay (rendering at native screen resolution) are assigned. These have settings which can be adjusted for the Target for Anti Aliasing, Clear Color and the Depth Buffer used. The Overlay Target can not be added to the final captured Snap

The order of different Camera objects and their Render Targets can be specified through the Render Order Config list. A Physics World can be assigned if Physics is desired in the project.

### Scene (Viewport)[​**](#scene-viewport "Copy to clipboard")

![](/img/lens-studio/spark/06_Scene.png)

The top menu shows icons to maneuver around the Scene and manipulate Scene Objects.

This 3D Scene shows a 3D Panda as a Prefab in the Scene with a perspective camera (blue), EnvMap and Directional light (yellow). The ghost in the box allows the scene to be oriented through clicking and dragging the box to rotate it.

The icons in the menu with keyboard shortcuts from left to right are:

* Selection (Q)
* Pan
* Orbit
* Dolly
* Move (W)
* Rotate (E)
* Scale (R)
* Unified (Y)
* Global, Parent, Local Space which shows when Move, Rotate or Unified are selected
* Box, Color, Wire Highlight
* Zoom to All (A)
* Zoom to Selection (F)
* Reset to Home (H)
* Settings to show grid

### The 2D Editor[​**](#the-2d-editor "Copy to clipboard")

A 2D Editor panel is available to edit 2D elements such as Screen Text easily like in Spark. It can be opened by selecting a 2D Scene Object from the Hierarchy or going to Window from the toolbar -> Editor -> 2D Editor.

![](/img/lens-studio/spark/02_2DEditor.png)

### Preview (Simulator)[​**](#preview-simulator "Copy to clipboard")

Like Spark’s simulator, the Preview panel lets you view updates as they are made.

Different inputs are available such as Images, Videos, WebCam feed and Interactive Environments which can be navigated with WASD keys and can be looked around with right click and drag. This is useful for world Lenses such as single plane and world tracking.

The Lens can be reset from this window as well as activate microphone, mute audio and capture image and video previews.

Front and Back cameras are supported as well as previews for different devices such as iPhone 14 Pro Max, Spectacles and Horizontal screens.

Different UI overlays help preview the experience from the end user’s perspective including Snapchat live view, capture view and no UI.

![](/img/lens-studio/spark/07_Preview.png) ![](/img/lens-studio/spark/08_Preview.png) ![](/img/lens-studio/spark/09_Preview.png)

### GenAI Suite[​**](#genai-suite "Copy to clipboard")

The GenAI Suite has an AI Chat option to ask the AI Assistant questions such as ‘Explain Face Masks to me’ and the GenAI option allows generation of assets such as ML Face Effects, PBR Materials and Immersive ML to use in a Lens Studio project. GenAI features are continuing to be added and can be downloaded from the Asset Library.

![](/img/lens-studio/spark/10_GenAI.png) ![](/img/lens-studio/spark/11_GenAI.png)

### Logger (Console)[​**](#logger-console "Copy to clipboard")

The Logger is like Spark’s console. However, unlike Spark, it logs various executions within the project and not only manually added Diagnostics.Log() or Diagnostics.Watch() via script, such as the Behaviour Helper Script being imported. The logs can be set to clear on Lens Reset or cleared immediately and error messages from the project show highlighted in red.

![image alt text](/assets/images/12_Logger-08d76d4fb51ce216234a16611fddcaa2.png)

## Scene Objects[​**](#scene-objects "Copy to clipboard")

### Scene Object[​**](#scene-object "Copy to clipboard")

Using the plus sign, Scene Objects can be added to the Scene Hierarchy. Instead of Null Objects in Spark, a Scene Object can be added which will not have components added to it. This can be seen by selecting the newly added object and looking at the Inspector panel.

A Scene Object and its children can be exported as a .lso file by right clicking it in the Hierarchy and choosing Export. When imported to a project a .lso is automatically instantiated into the Scene Hierarchy.

### Camera Object[​**](#camera-object-1 "Copy to clipboard")

As mentioned, instead of Device, Camera objects are directly added to the Hierarchy and multiple cameras can be added. They have a Camera component on the object with settings to choose the Layer(s) that will be rendered to the assigned Render Target(s). There are further settings which can be adjusted such as the Near and Far distances, Depth Mode and manipulating the Transforms (Position, Rotation, Scale).

**Perspective Camera:** simulates how perspective and depth-perception work in the real world. Objects appear smaller when they are further away. The Perspective Camera is useful for visualizing 3D models. The Device Tracking Component can be added to this type of camera in the Inspector panel to allow digital objects to persist in their location as you move around the space, like Spark effects using plane or world tracking. **Orthographic Camera:** does not include perspective distortion. Parallel lines stay parallel no matter how far away they are. The Orthographic Camera is commonly used for 2D effects like Screen Image and Screen Text.

![](/img/lens-studio/spark/13_Camera.png) ![](/img/lens-studio/spark/14_Camera.png)

Read more about [Camera Settings](/lens-studio/lens-studio-workflow/scene-set-up/camera.md#camera-settings).

### UI[​**](#ui "Copy to clipboard")

#### Canvas[​**](#canvas "Copy to clipboard")

Like in Spark, the Canvas is used for 2D Components such as Images and Text that can be placed in 2D Screen Space or 3D World Space. For example a Canvas and its hierarchy of Scene Objects can be added as a child of an Image Marker.

#### Image[​**](#image "Copy to clipboard")

The Image Scene Object is like the Plane object in Spark. It can be used in 2D or 3D Space, resized and assigned an image texture via its material.

#### Screen Image[​**](#screen-image "Copy to clipboard")

Similar to the Rectangle object in Spark, it creates an image that measures to the device’s Screen Transforms. It automatically adds an Orthographic Camera -> Full Frame Image -> Screen Image hierarchy to the Scene Hierarchy.

#### Screen Region[​**](#screen-region "Copy to clipboard")

This also adds an Orthographic Camera if there is not already one and a Full Frame Image object to the Scene Hierarchy. It has the components Screen Transform and Screen Region on the object. The Screen Region type can be changed between Full Frame, Capture, Preview, Safe Render and Round Button as required.

#### Screen Transform[​**](#screen-transform "Copy to clipboard")

This can be added as an individual Scene Object under a Screen Region object with only the Screen Transform component on it.

#### Screen Text[​**](#screen-text "Copy to clipboard")

Screen Text is also added under the Screen Region object, this allows 2D text to be added and sized to match the screen dimensions.

#### Text[​**](#text "Copy to clipboard")

Text also allows 2D text to be added to the hierarchy, but does not have a Screen Transform component and is not added as a child of a Screen Region object.

![image alt text](/assets/images/15_UI-2879615a139d8d1280914383ffc2514a.png)

## Prefabs (Blocks)[​**](#prefabs-blocks "Copy to clipboard")

Prefabs are like Blocks and are useful to add multiple of the same object in a Scene. It can be opened and edited in a panel within Lens Studio and the changes will be applied to all instances of the Prefab.

Also like in Spark, Prefabs can be dynamically instantiated via script, nested within one another and can be exported to be used in other Lens Studio projects. A key difference is that Prefabs do not have inputs and outputs like blocks, but can be referenced via scripts for both manually and dynamically instantiated versions to edit their properties and components and the Asset can be dragged into exposed UI parameters for scripts.

Prefabs can be instantiated both synchronously and asynchronously with a script. This makes it possible for easy creation of interactions such as [tapping the screen to instantiate a Prefab](https://developers.snap.com/lens-studio/lens-studio-workflow/prefabs#scripting-with-prefabs).

To create a Prefab, an existing Scene Object can be dragged from the Scene Hierarchy into the Asset Browser, or an empty Prefab can be added directly in the Asset Browser with the ‘+’ icon. As with Blocks, Prefabs can be exported by right clicking on it in the Asset Browser and choosing Export. When saved it will be importable as a .oprfb Asset.

To edit a Prefab, double click on it in the Asset Browser and it will open as an isolated Scene. Once changes have been made, with the changed object selected in the Scene Hierarchy, use the Apply button in the Inspector to save them. To return to the main Scene, select the original Scene in the Asset Browser.

![image alt text](/assets/images/16_Prefab-e0b0ad8096a4fa8b1d8fe778572e0feb.png)

## Asset Library (AR Library)[​**](#asset-library-ar-library "Copy to clipboard")

Like Spark’s AR Library, the Asset Library provides a collection of assets that can be imported into a project. From the Asset Library button above the Scene Hierarchy a new window opens showing assets such as 3D objects, materials and VFX. ![image alt text](/assets/images/17_AssetLib-a57f99b842c188a37000a57f24eb94aa.png)

## Shader Graph (Patch Editor)[​**](#shader-graph-patch-editor "Copy to clipboard")

The Shader Graph is very similar to making and editing shaders in Spark’s Patch Editor with Patches being called Nodes. By double clicking a material in the Asset Browser, it opens in the Shader Graph panel. Any material can be opened and edited this way.

An Empty shader asset can be created in the Asset Browser and opened to show the associated graph. Each material has a shader assigned to it. The Inspector shows different parameters and settings when a material vs a shader is selected whilst the graph will be the same for the shader and material that are linked. Post Effects are editable in the same way.

The biggest difference is this is split from Visual Coding and parameters must be passed into the graph as inputs. There are many similar nodes to the shader patches and materials such as PBR can be edited and created and output to a shader node.

![image alt text](/assets/images/18_Shader-0dda1f01e1736a45037a42503c9092d5.png) ![image alt text](/assets/images/19_Shader-3c414af511d28d7178182b11e2ccf919.png)

Some things are a little different in Lens Studio’s node graphs.

* Sub-Graphs are like Patch Groups
* Nodes can be added from the ‘+’ icon at the top of the graph or right clicking in the graph -> Add Node (with options from the library or Sub-Graphs) or by left clicking and dragging from a node’s output
* Nodes and Sub-Graphs are categorized like Spark but many are grouped differently. The search bar helps to easily find a node and the full list to become more familiar with them is here
* To delete a node connection, left click on the connecting wire
* Wire colors indicate the data type of the connection and match input and output colors
* Right clicking an input or output on the graph and choosing Wireless allows for wireless connections like senders and receivers in Spark to create a cleaner looking graph.

The equivalent of writing SparkSL and dragging it into the Patch Editor is to add a Custom Code node into the Shader Graph. Here the code is almost completely native GLSL and familiarity will be found with standard shader code including using Uniforms and Varyings. In Lens Studio, Uniforms and Varyings have node equivalents and can be accessed in the code node using the system object. Generally GLSL ES 3.0 can be considered safe to use, however it is not set to a specific version as Lens Studio specific functions etc can be included such as the Texture Sampler and the specifications of the variety of output devices will impact which versions ad languages it compiles to.

Multiple inputs and outputs can be defined to pass these values onto different nodes in the Shader Graph such as one for vertex position and one for fragment color.

For example:

```
output_vec4 Position;
output_vec4 Color;

Void main() {
  Position = system.getSurfacePosition() * system.getMatrixProjectionView();
  Color = vec4(1.0, 0.0, 0.0, 1.0);
}
```

The default Custom Code node outputs a multiplication of two input values from the Shader Graph. ![image alt text](/assets/images/20_Shader-a9941af336adb38328e0630b28d63d56.png)

The Custom Code node can also be used with VFX graphs in a slightly different way. As with converting from ShaderToy to SparkSL, it can also be [converted to Lens Studio](/lens-studio/features/graphics/materials/material-editor/tutorials/shadertoy-to-lens-studio.md) with a combination of the Code Node in a Shader Graph and Scripts.

## Scripting[​**](#scripting "Copy to clipboard")

Lens Studio uses the ES6 version of JavaScript and TypeScript. Meaning arrow function, class and promises can be used like in Spark. Script assets can be added through right clicking -> Export in the Asset Browser and can be set to be editable or locked for more control over sharing them. When an editable script is imported, it can be right clicked and the option Unpack for Editing allows the assets to be unpacked.

Like Scene Objects, scripts are run in the Scene Hierarchy from top to bottom. They must be added to the hierarchy to run and cannot be left in the Asset Browser like in Spark. Scripts can be edited in the Lens Studio script panel or with an external code editor such as VSCode. External editors are recommended for TypeScript to enable autocomplete. Like the Meta Spark extension for VSCode, there is the [Lens Studio Extension](https://marketplace.visualstudio.com/items?itemName=SnapInc.studio-vscode-extension).

The Behavior and Tween Scripts are examples of ready made scripts in Lens Studio that are available for use by adding them to the Scene Hierarchy. They do not need to be opened in an editor to be used as they have surfaced UI in the Inspector where parameters can be assigned.

Custom scripts can also be [created](https://developers.snap.com/lens-studio/features/scripting/scripting-example) and added to Scene Objects as components. The layout of a script may seem a bit different to Spark as everything does not need to be done through promises. Synchronous and asynchronous scripting can be used in Lens Studio.

Instead of `Diagnostics.log(‘Hello World!’);` we can log messages using `print('Hello, World!');`

This example makes two objects bounce. Add a script component to a 3D Scene Object and edit it as follows.

```
// Bounce.js
// Properties:
//@input SceneObject secondObject;
//@input float speed = 1.0 {"widget": "slider", "min": 0, "max": 10.0, "step": 0.01}
//@input float range = 10.0 {"widget": "slider", "min": 0, "max": 30.0, "step": 0.01}

global.xOffset = 10;

function bounce() {
  var newY = Math.sin(getTime() * script.speed) * script.range;
  script
    .getSceneObject()
    .getTransform()
    .setLocalPosition(new vec3(-xOffset, newY, 0));
  script.secondObject
    .getTransform()
    .setLocalPosition(new vec3(xOffset, newY, 0));
}

var updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(bounce);
```

### Input[​**](#input "Copy to clipboard")

![](/img/lens-studio/spark/21_Script.png)

Inputs are defined with the `//@input` keyword to create UI surfaced widgets where assets, objects, components and other data can be entered through the Inspector. This is handy to make the script reusable as well as edit values without needing to open and edit the script.

In the above example, two sliders widgets are created to control the speed and range variables. The [UI Guide](https://developers.snap.com/lens-studio/features/scripting/custom-script-ui) provides further references.

### Global Variable[​**](#global-variable "Copy to clipboard")

The Global variable refers to the global object to access built in properties and methods with global scope. The full list can be found [here](https://developers.snap.com/api/lens-studio/Classes/OtherClasses#Globals--isNull).

[global.scene](https://developers.snap.com/api/lens-studio/Classes/OtherClasses#Globals--global.scene)​ : [ScriptScene](https://developers.snap.com/api/lens-studio/Classes/ScriptObjects#scriptscene) Returns the global ScriptScene object, which offers information and controls for the current scene.

[global.getTime() : number](https://developers.snap.com/api/lens-studio/Classes/OtherClasses#Globals--getTime) Returns the time in seconds since the lens was started.

Custom Global methods, properties and variables can be created too. In the example, a global number is defined in the line

`global.xOffset = 10;`

Now xOffset can be accessed in any script within the project that runs after this script has been triggered.

### Local Variable[​**](#local-variable "Copy to clipboard")

Functions and variables declared with the keyword var are in the local scope. This means they can only be accessed within the script they were created.

### Script Variable[​**](#script-variable "Copy to clipboard")

A script component can have multiple scripts on it. In contrast to global, a Script variable has a scope across all scripts on a script component and is used to access the data passed in as inputs. To use the speed, range and secondObject inputs, they must be referenced as the following.

```
script.speed
script.range
script.secondObject
```

### Referencing Other Scripts[​**](#referencing-other-scripts "Copy to clipboard")

To connect scripts, the getComponent(‘Component.ScriptComponent’) method is used to specify which script to use if the object has multiple script components on it.

```
/* main.js */
var scriptsComponents = myObject.getComponents('Component.ScriptComponent');
var targetScript;
scriptsComponents.forEach(function (scriptToReference) {
  if (scriptToReference.varA === 5) {
    targetScript = scriptToReference;
  }
});
```

```
/* script secondary.js */
script.varA = 5;
```

### Script Events[​**](#script-events "Copy to clipboard")

As mentioned, scripts in the Hierarchy will execute from top to bottom and all scripts are bound to On Awake.

* OnAwake triggers before any other event in a Lens and runs straight away on newly instantiated or copied objects in the Hierarchy.
* OnStart runs on the first frame, after OnAwake and before Update. It is used to initialize information that depends on inputs or data from other components that have used OnAwake to define their inputs and methods.
* OnDestroy triggers when the script component connected to the script calling this has been destroyed.
* OnEnable triggers when the connected script component is enabled (checkbox ticked).
* OnDisable is triggered when the connected script component is disabled (checkbox unticked).
* Update triggers once per frame update and is used to run code that changes over time.
* LateUpdate triggers at the end of each frame, before rendering and after Update, Physics and Animation events.

An example to print the time in the Logger using Update is as follows.

```
function printTime(eventData) {
  // Print the elapsed Lens time
  print(getTime().toString());
}
// Bind the function printTime to the event UpdateEvent
var event = script.createEvent('UpdateEvent');
event.bind(printTime);
```

The following is an example of a tap event. An Interaction component must be added to the Inspector of the hosting Scene Object for it to be read.

```
//@input Component.InteractionComponent interactionComponent

// Subscribe to the onTap event
var onTapEvent = script.interactionComponent.onTap.add(function (tapEventArgs) {
  print('onTap!');
});

// Unsubscribe from the onTap event
script.interactionComponent.onTap.remove(onTapEvent);
```

Further events include face gestures, camera switch to front or rear and touch events. These can all be called in a script instead of nodes. A full guide can be found [here](https://developers.snap.com/lens-studio/features/scripting/script-events).

### Bind Keyword[​**](#bind-keyword "Copy to clipboard")

Scripts must be bound to events using the bind keyword so it runs when the event fires. In the example above we created the event for whenever a frame is updated with script.createEvent('UpdateEvent') and bound our response, to run our printTime function, with event.bind(printTime). This is similar to subscribing to events in Spark scripting.

To run a function that is triggered by a face event, such as face found, eyebrows raised or mouth open, the following script shows how to do this. Note this can also be achieved by importing the Behavior helper script to the Scene Hierarchy, in the Inspector setting the Trigger to Face Event, Event Type to Face Found, response type to Set Enabled and assigning a Scene Object for it to apply to.

```
//@input SceneObject exampleObject;

function setEnabled() {
script.exampleObject.enabled = true;
}


var faceEvent = script.createEvent(“FaceFoundEvent”);
faceEvent.faceIndex = 0;
faceEvent.bind(setEnabled);
```

### Event Listeners[​**](#event-listeners "Copy to clipboard")

This provides a way to create custom events such as keeping track of a score. Import the Event module from the Asset Library to use the Event module. This script should be referenced in another script with var events = require("./EventModule"); and not added to the Scene Hierarchy as a Scene Object. In this example the module is imported into an existing script, the event created and what happens when it is triggered. The trigger here is the string “hello!” for example if this is the text output by another function e.g. from a Behavior script’s Set Text Response Type or simply another function returning the string “hello!” in this same script and it is accessed through this script.

```
var eventModule = require('./EventModule');

// Event Wrapper
var myEvent = new eventModule.EventWrapper();

// Add a callback to the event
myEvent.add(function (arg) {
  print('event triggered with parameter to say: ' + arg);
});

// Trigger the event
myEvent.trigger('hello!');
```

### Scene Manager[​**](#scene-manager "Copy to clipboard")

The Scene Manager is a component that helps organize multiple Scenes in a Lens, for example one scene for the front camera and another for the back. This uses Prefabs and is instead of the front and back camera checkboxes in the Object’s Inspector and grouping them under Null Objects in Spark. It can be imported from the Asset Library and added as a Component to an empty Scene Object which is positioned at the top of the Scene Hierarchy. They can be non-additive meaning these can not exist with one another, or additive which can be combined like layers.

If using remote assets, only asynchronous loading can be used. The following loads a different prefab under the Scene Manager object for the Front and Back cameras as they are changed. Two different prefabs are assigned from the Asset Browser to the Scene Manager Object in the Inspector. And this custom script is added as another component to the Scene Manager Object.

```
script.createEvent('CameraFrontEvent').bind(onFrontCamEvent);
script.createEvent('CameraBackEvent').bind(onBackCamEvent);

function onFrontCamEvent(eventData) {
  global.sceneManager.loadSceneAsync('Front', {
    additive: false,
    enabled: true,
    parent: undefined,
  });
}

function onBackCamEvent(eventData) {
  global.sceneManager.loadSceneAsync('Back', {
    additive: false,
    enabled: true,
    parent: undefined,
  });
}
```

![](/img/lens-studio/spark/22_SceneManager.png)

## Audio[​**](#audio "Copy to clipboard")

Audio can be spatial in Lens Studio. Audio objects must be added manually to the Scene Hierarchy to be used. This includes adding a microphone setup as it does not have a default setup like Spark.

An Audio Listener is added to the Scene Hierarchy along with an Audio Object. In this object, an Audio Track needs to be linked. From its Choose Audio Track menu, selecting the ‘+’ shows Microphone Audio as an option. Now a Microphone Audio asset has been added to the Asset Browser and the microphone’s audio can be used in the project.

![](/img/lens-studio/spark/24_Audio.png) ![](/img/lens-studio/spark/25_Audio.png)

## Physics[​**](#physics "Copy to clipboard")

Physics is a feature integrated into Lens Studio so imitation logic does not need to be created, it allows objects to act with gravity and forces like they would in the physical world. There are a few elements to get set up. [This guide](https://developers.snap.com/lens-studio/features/physics/physics-overview) covers getting started with Physics.

## VFX and GPU Particles (Particle System)[​**](#vfx-and-gpu-particles-particle-system "Copy to clipboard")

VFX and GPU Particles are Lens Studio’s versions of Particle Systems with Emitters in Spark.

GPU Particles are the most similar to Particle Systems. They have a set of predefined controls to edit its behavior and can be better for performance. When they are added to the Scene Hierarchy, a material, shader, mesh and texture are added to the assets. Opening up the material asset by double clicking it, shows how it is built and this is different to VFX. The Inspector shows a long list of editable parameters which are used to edit the particles object using this component in the Scene. Properties include:

* World / Local space
* Mesh type
* Lifetime
* Spawn shape
* Texture instead of material
* Color
* Alpha Start and End which does not need a script like Spark but can be edited directly here with a slider
* Particles Velocity
* Particles Rotation
* Size for Start and End, again editable directly in the Material Inspector rather than needing a separate script
* Force and Gravity

![image alt text](/assets/images/27_VFX-7377d0a6ce65c62aaee500f065bdca69.png)

Meanwhile VFX allows for more control with nodes that can be edited through the VFX graph where Custom Code GLSL nodes can be incorporated and collisions can be added. This is like an extended version of bringing particle properties into the patch editor or using the particles API in scripting to make more complex and interesting systems. If you are familiar with Unity’s VFX setup, it is similar with sections for different parts of the lifecycle when the asset is double clicked to open the VFX Graph.

The sections are:

* Spawn Space where initial properties are defined when the particle is created.
* Update is processed every frame during the particle's lifetime.
* Output is a material applied to a 2D square mesh to define how it is rendered

Editable attributes for VFX are:

* Position (vec3)
* Velocity (vec3)
* Life (float)
* Force (vec3)
* Mass (float)
* Color (rgba)
* Size (float)
* Matrix (mat4)
* Custom (set by the user)

Get started with VFX [here](https://developers.snap.com/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts#getting-started.) ![image alt text](/assets/images/29_VFX-fc34df7cdadd0fe582357331ea624051.png)

## Plugins[​**](#plugins "Copy to clipboard")

![](/img/lens-studio/spark/30_Plugins.png)

Plugins can be considered as similar to Blender plugins to build extended Studio functionality and improved workflows by using the newly available Editor API in JavaScript or TypeScript ES10. For example, the GenAI Suite in Lens Studio is built as a Plugin and so is the Figma Plugin. Instructions on how to build a Plugin can be found [here](https://developers.snap.com/lens-studio/extending-lens-studio/plugins-development/overview) and examples can be found on the Lens Studio [Plugins GitHub repository](https://github.com/Snapchat/Lens-Studio-Plugins/tree/main).

A Plugin is created externally e.g. using VSCode and can be imported from the Asset Library or locally added through the top menu Lens Studio -> Preferences -> Plugins-> Additional Libraries -> Add the Plugin directory that is a parent of the folder containing the JSON file.

For example, once the [Figma Importer](/lens-studio/extending-lens-studio/plugins/figma-plugin.md) has been added to the project, it can be accessed through the menus’s Window option to see and use it as a new panel.

## Build and Release[​**](#build-and-release "Copy to clipboard")

Build and release in Lens Studio is simple and straightforward. Your Lenses will be hosted through one of the environments:

* Snapchat (Android, iOS and Web)
* Spectacles (Wearable)
* [Camera Kit](https://ar.snap.com/en-US/camera-kit) (publication process may vary)

You can publish and update your lens through the Publish Lens button in Lens Studio and manage them through My Lenses to see usage insights, similar to Meta Spark Hub. Lenses can also be shared to users without them needing a Snapchat account or needing to download Snapchat by clicking the share WebAR lens button in My Lenses. Now it is easily viewable on a web browser including a phone’s native browser such as Safari or Chrome by visiting this generated URL.

## Examples[​**](#examples "Copy to clipboard")

The following tutorials show how to set up common Spark starter projects.

### World Effects[​**](#world-effects "Copy to clipboard")

Lens Studio provides multiple options for World Tracking, including Surface and World. This example allows an object to be placed in the world where the user can move around it using the Device Tracking component on a Camera. We are also using a World Object Controller script with Interaction and Manipulation components which means we can tap, drag and pinch the object to move, rotate and scale it like Spark’s World Object template.

Firstly, add a Device Tracking component to the Perspective Camera. Next, download The World Object Controller from the Asset Library and it is automatically added to the Scene Hierarchy. Selecting this object in the Hierarchy shows the parameter boxes that need to be filled for it to work. Drag the Camera object in the Scene Hierarchy panel into the World Object Controller script component’s Device Tracking Box. Now it has connected this camera’s Device Tracking component to the script. Next, drag the same Camera object to the same World Object Controller’s Inspector panel, but into the Interaction component’s Camera box and is ready to go. The example Sphere object in the Scene Hierarchy can be replaced with an object of choice and the Touch Collision box can be scaled to cover your chosen object’s volume so the user has enough space to activate the interactions. Test these out in the Preview and make sure you have chosen a world preview and the back camera as the active one.

![image alt text](/assets/images/33_Example-b99d4c3ea96cb353b4dd94baac9673c0.png)

Further examples include [Simple World Mesh](https://developers.snap.com/lens-studio/features/ar-tracking/world/world-templates/simple-world-mesh) and [Static Object.](https://developers.snap.com/lens-studio/features/ar-examples/static-object)

### Face Effects[​**](#face-effects "Copy to clipboard")

As with Spark, there are lots of examples of lenses made using head tracking and face meshes.

Retouching is added through adding a Face Retouch object into the Scene Hierarchy. It can be adjusted through the Inspector, unchecking Auto and adjusting the sliders as desired.

The Face Mask object applies a 2D texture to a tracked face and the Face Mesh applies a material to a 3D mesh which is tracked to a face including following the shape of facial expressions by being located under a Head Tracker in the Hierarchy. The Face Mesh is how we can apply light reactive materials such as PBR.

Double clicking each object in the Hierarchy opens an Editor to see the effects of each and make further edits with a better view. The exception here is the 3D Face Mesh as this functions like other 3D objects so the material applied to it can be edited through selecting it in the Asset Browser.

![image alt text](/assets/images/34_Example-d0d9c40e25ac0a9eae64235d36564f6d.png) ![image alt text](/assets/images/35_Example-bf08c14d353a626531b4d09c9ae75bfb.png) ![image alt text](/assets/images/36_Example-7baf93b424beebff5f395e2fdcf7e3c5.png)

We can show and hide a Scene Object with a Smile Face Gesture using the Behavior script. With the Face Mesh already added, import the Behavior script into the Hierarchy. In the Inspector we can see various options to choose from. Set the Trigger Type to Face Event and now we can select Smile from a list of Event Types. Under Response Type, we want to use Set Enabled and the Action to Toggle so each smile will alternate between showing and hiding our object. Lastly drag the Face Mesh object from the Hierarchy into the Target box and we can see it toggle visibility in the Preview. Tip: Find the Facial Expressions preview video to test out a smile gesture.

![image alt text](/assets/images/37_Example-60b619274ae3b081c358a324d7eef62a.png)

An overview of different Face Effects can be found [here](https://developers.snap.com/lens-studio/features/ar-tracking/face/face-effects-overview)

## Further Capabilities[​**](#further-capabilities "Copy to clipboard")

Lens Studio offers additional capabilities such as:

* [SnapML](https://developers.snap.com/lens-studio/features/snap-ml/ml-overview)
* [Location AR](https://developers.snap.com/lens-studio/features/location-ar/guide)
* [User Context & Friends](https://developers.snap.com/lens-studio/features/user-context/overview)
* [Persistent Storage](https://developers.snap.com/lens-studio/features/lens-cloud/persistent-cloud-storage/persistent-storage)
* [Remote APIs](https://developers.snap.com/lens-studio/features/remote-apis/remote-service-module)
