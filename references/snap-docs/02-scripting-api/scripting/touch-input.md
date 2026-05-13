# Touch and Interactions

## Introduction[​**](#introduction "Copy to clipboard")

You can add interactivity to the Lenses you create in Lens Studio by handling user touch input events. Your Lens can play a sound, trigger a character animation, and more by responding to events when users touch their device screens.

Touch handling is an essential part of any interactive experience. In this guide, we will learn how to handle touch events and create various interactive effects.

This guide assumes you are familiar with the basics of scripting in Lens Studio. To learn more about scripting, please visit the [Scripting Overview](/lens-studio/features/scripting/script-overview.md).

***

## Scene Events[​**](#scene-events "Copy to clipboard")

This section describes simple, full-screen touch events. For more precise touch detection, check out the [Interaction Component](#interaction-component). Lenses can respond to events triggered when the user touches the screen. For example, your lens can play a sound whenever the screen is touched.

**[TouchStartEvent](/api/lens-studio/Classes/Events.md#TouchStartEvent):** Triggered when the user starts a screen touch.

**[TouchMoveEvent](/api/lens-studio/Classes/Events.md#TouchMoveEvent):** Triggered when the user moves their finger while holding a screen touch (e.g., dragging on the screen).

**[TouchEndEvent](/api/lens-studio/Classes/Events.md#TouchEndEvent):** Triggered when the user ends a screen touch (e.g., lifting their finger off the screen).

**[TapEvent](/api/lens-studio/Classes/Events.md#TapEvent):** Triggered when the user quickly starts and stops a touch (e.g., tapping the screen).

While starting to work with tap and touch-move interactions in your Lens, you may notice that the Snapchat UI also reacts to those events. To prevent this, you can [enable touch blocking](#touch-blocking).

If your Lens does not use touch blocking, user touches will trigger default actions, such as double-tapping to switch the camera or long-pressing to activate Scan.

To learn more about events in Lens Studio, please refer to the [Script Events Guide](/lens-studio/features/scripting/script-events.md).

***

### Touching the Screen[​**](#touching-the-screen "Copy to clipboard")

The following guide will walk you through setting up a screen-based Touch Started event.

Let's start with creating a `New` -> `JavaScript File` in the `Asset Browser` panel .

Then drag this Script from the Asset Browser into the `Scene Hierarchy` panel, that will automatically create a new Scene Object with this script attached.

![](/assets/images/touch-interactions-2-12ccc57794935a2847fc6ab9b10a7179.png)

Next, double-click the script in the Asset Browser to open the Script Editor panel.

And finally, copy and paste the following code into the script:

```
script.createEvent('TouchStartEvent').bind(function (eventData) {
  print('Touch Start');
});

script.createEvent('TouchMoveEvent').bind(function (eventData) {
  print('Touch Move');
});

script.createEvent('TouchEndEvent').bind(function (eventData) {
  print('Touch End');
});

script.createEvent('TapEvent').bind(function (eventData) {
  print('Tap');
});
```

Now save the script and try pressing and releasing mouse buttons in the Preview panel and see the output in the Logger panel!

### Touch Event Arguments[​**](#touch-event-arguments "Copy to clipboard")

Script events pass a parameter called eventData. This argument provides additional information about touch events, such as screen position and touch ID.

Here's how you can use this data to drag a 3D object:

* First add `New Sphere` in the `Scene Hierarchy` panel by clicking on the `+` button.
* Rename `Untitled JavaScript` to something more descriptive, like `Drag3DObject`. To do this, right-click on the script file in the Asset Browser and select Rename.
* Replace the code in the script file with the code below and save the script.

```
//@input SceneObject sphere
//@input Component.Camera camera
//@input float depth = 40

var transform = script.sphere.getTransform();

script.createEvent('TouchStartEvent').bind(function (eventData) {
  updatePositionFromScreen(eventData.getTouchPosition());
});

script.createEvent('TouchMoveEvent').bind(function (eventData) {
  updatePositionFromScreen(eventData.getTouchPosition());
});

function updatePositionFromScreen(screenPos) {
  transform.setWorldPosition(
    script.camera.screenSpaceToWorldSpace(screenPos, script.depth)
  );
}
```

* Set the `Sphere` and `Camera` inputs of the script in the Inspector panel

![](/assets/images/touch-interactions-5-a59807ce78345521bb0ef7fef635acf4.png)

* Lastly, touch and drag your mouse in the Preview panel to see this super simple implementation of dragging 3D object on the screen.

#### Preview the Project[​**](#preview-the-project "Copy to clipboard")

[Preview the Lens on your device](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md). You should see a sphere rendered on the screen. When you touch the sphere and move your finger - it follows your touch position.

***

## Interaction Component[​**](#interaction-component "Copy to clipboard")

Lenses can respond to touch events triggered when the user touches an object. This is useful for cases when the user should interact with a specific object in the scene. For example, when a user taps on a 3D character, that character could play an animation.

The Interaction Component is the main building block for creating robust interactive experiences by allowing you to detect touches within the bounds of a specific 2D or 3D object.

Additionally it allows to filter touches by depth, see the section [Depth Filtering](#depth-filtering) below.

### Adding To Scene[​**](#adding-to-scene "Copy to clipboard")

Interaction components can be added to a Scene Object with the next couple steps:

* Select Scene Object in the `Scene Hierarchy` panel
* Click on `Add Component` button and select `Interaction Component`
* Configure component properties.

![](/assets/images/touch-interactions-0-9e3312dd07c6a48c86e7181cdce64584.png)

### Set Up[​**](#set-up "Copy to clipboard")

As you may see, the Interaction Component has several properties amongst which there is a `Camera` and array of `Mesh Visuals`.

![](/assets/images/touch-interactions-3-0e8da509bfdddb68d507d786db567916.png)

**Camera:** camera used for detecting interactions. Should be the camera that renders corresponding Mesh Visual objects. Most of the time this can be left empty and the Interaction Component will determine the right Camera automatically.

**Min Touch Size:** Sets the minimum bounding box size used for detecting touches. Value range from 0 to 1, relative to screen width.

**Depth Filter:** when enabled, interaction events will only be triggered on the “closest” object, determined by the distance from the camera, camera render order, and scene hierarchy.

**Mesh Visual array**: one or multiple Mesh Visual components to detect interactions with. The Interaction Component automatically uses Mesh Visuals on the same SceneObject, so you can leave this empty if the Mesh Visual is part of the same object.

### Scripting Interaction Component[​**](#scripting-interaction-component "Copy to clipboard")

The Interaction Component allows access to events via script, where you can add callbacks.

Using Interaction Component events is the preferred way of scripting interactions in a scene.

Let’s create a simple script example using Interaction Component events:

* In a new project, create a `Sphere` in the `Scene Hierarchy` panel.
* Add an Interaction Component to the Sphere Object.
* Create a new `JavaScript File` in the `Asset Browser` panel and drag it to the Sphere Scene object to create a Script Component.
* Double-click the script in the `Asset Browser` panel to open it for editing.

![](/assets/images/touch-interactions-7-f94bf66f1d802c6aef298adcd6dc5876.png)

Please note that Interaction Component events have a different type and api than Script Events. Please refer to [api page](/api/lens-studio/Classes/Components.md#InteractionComponent--Properties) for more details

```
var sceneObject = script.getSceneObject();
var interactionComponent = sceneObject.getComponent('InteractionComponent');

function onTouchStart(eventArgs) {
  print(
    '[Tapped on] ' +
      sceneObject.name +
      ', [Touch position] ' +
      eventArgs.position +
      ', [Touch Index] ' +
      eventArgs.touchId
  );
}

interactionComponent.onTouchStart.add(onTouchStart);
```

### Depth Filtering[​**](#depth-filtering "Copy to clipboard")

At this point we have an example that detects touch on the 3D object. Let's build upon it and create two copies of the Sphere object and assign different materials to each.

[](/img/lens-studio/touch-interactions-4.webm)

You may notice how touches are detected only on the Bounding Box of the object closest to the camera if the Interaction Component has `Depth Filter` checkbox enabled.

Touches are detected based on the mesh bounding box, not the mesh itself.

## Interactions for Screen Transforms[​**](#interactions-for-screen-transforms "Copy to clipboard")

The Interaction Component also works with 2D objects that use a Screen Transform, such as Screen Images or Text. This is especially useful for non-visual elements like bounding areas in a scrolling list, as seen in the [UI Scroll View](/lens-studio/features/ui/ui-scroll-view.md#ui-scroll-view) Custom Component available in the Asset Library.

The `Screen Transform` Component provides useful [API functions](/api/lens-studio/Classes/Components.md#ScreenTransform) that allow to script precise interactions with Screen Transform and build various UI elements.

Let’s build an example that will allow us to manipulate screen objects on screen from scratch:

* Add a new `Screen Image` in the `Scene Hierarchy` panel and customize its texture.
* Add an Interaction Component to the Image scene object.
* Create a new `JavaScript script` in the `Asset Browser` panel with the following code and attach it to the same Scene Object:

```
// Requires Screen Transform
// Requires Visual

//@ui {"widget":"group_start", "label":"Drag"}
//@input bool dragX = true {"label": "X"}
//@input bool dragY = true {"label": "Y"}
//@ui {"widget":"group_end"}
//@input bool scale = true
//@input bool rotate = true

var dragX = script.dragX;
var dragY = script.dragY;
var scale = script.scale;
var rotate = script.rotate;

var isActive = false;

var touches = [];
var touchCount = 0;

var startPos;
var startDir = new vec2(0, 0);
var startScale = new vec3(1, 1, 1);
var startRot = new quat(0, 0, 0, 0);
var offset = new vec2(0, 0);

// Scene Object
var so;
// Screen Transfrom
var st;
// Interaction Component
var ic;

// initialize
function onStart() {
  so = script.getSceneObject();
  st = so.getComponent('ScreenTransform');
  ic = so.getComponent('InteractionComponent');
  ic.onTouchStart.add(onTouchStart);
  ic.onTouchMove.add(onTouchMove);
  ic.onTouchEnd.add(onTouchEnd);
}

function onTouchStart(eventData) {
  if (touches.length == 0) {
    isActive = true;
  }
  if (isActive && touches.length < 2) {
    var touch = { id: eventData.touchId, position: eventData.position };
    touches.push(touch);
    if (touches.length > touchCount) {
      touchCount = touches.length;
    }
    if (touches.length == 1) {
      if (dragX || dragY) {
        var pos = st.screenPointToParentPoint(touches[0].position);
        if (pos != null) {
          offset = pos.sub(st.anchors.getCenter());
        }
      }
    } else if (touches.length == 2) {
      startDir = touches[0].position.sub(touches[1].position);
      startScale = st.scale;
      startRot = st.rotation;
    }
  }
}

function onTouchMove(eventData) {
  if (isActive) {
    for (var i = touches.length - 1; i >= 0; i--) {
      if (touches[i].id == eventData.touchId) {
        touches[i].position = eventData.position;
        break;
      }
    }
    if (touchCount == 1) {
      if (dragX || dragY) {
        var pos = st.screenPointToParentPoint(touches[0].position);
        if (pos != null) {
          pos = pos.sub(offset);
          pos.x = dragX ? pos.x : startPos.x;
          pos.y = dragY ? pos.y : startPos.y;
          st.anchors.setCenter(pos);
        }
      }
    } else if (touches.length == 2) {
      var dir = touches[0].position.sub(touches[1].position);
      if (rotate) {
        var startAngle = Math.atan(startDir.y / startDir.x);
        var newAngle = Math.atan(dir.y / dir.x);
        var newRotation = startRot.toEulerAngles();
        var angleDiff = startAngle - newAngle;
        if ((dir.x < 0 && startDir.x > 0) || (dir.x > 0 && startDir.x < 0)) {
          angleDiff += Math.PI;
        }
        newRotation.z = newRotation.z + angleDiff;
        st.rotation = quat.fromEulerVec(newRotation);
      }
      if (scale) {
        var magChange = dir.length / startDir.length;
        st.scale = startScale.uniformScale(magChange);
      }
    }
  }
}

function onTouchEnd(eventData) {
  if (isActive) {
    if (touchCount == 1) {
      if (dragX || dragY) {
        var pos = st.screenPointToParentPoint(touches[0].position);
        if (pos != null) {
          pos = pos.sub(offset);
          pos.x = dragX ? pos.x : startPos.x;
          pos.y = dragY ? pos.y : startPos.y;
          st.anchors.setCenter(pos);
        }
      }
    }
    for (var i = touches.length - 1; i >= 0; i--) {
      if (touches[i].id == eventData.touchId) {
        touches.splice(i, 1);
        break;
      }
    }
    if (touches.length == 0) {
      isActive = false;
      touchCount = 0;
    }
  }
}

// clamps center to parent bounds
function getClampedPosition(pos) {
  pos.x = dragX ? pos.x : startPos.x;
  pos.y = dragY ? pos.y : startPos.y;
  if (limitToParent) {
    pos.x = Math.min(Math.max(-1, pos.x), 1);
    pos.y = Math.min(Math.max(-1, pos.y), 1);
  }
  return pos;
}

script.createEvent('OnStartEvent').bind(onStart);
```

Show more▼

Here is how the attached components should look:

![](/assets/images/touch-interactions-6-c8638c0c9d2ee84517b926a7da304ba6.png)

Make several copies of the Screen Image scene object to create a fun sticker Lens!

[](/img/lens-studio/touch-interactions-1.webm)

As you may notice, the script above uses the `screenPointToParentPoint` API function of a Screen Transform to calculate the local position while manipulating objects on the screen. This enables the development of useful UI elements such as sliders, image carousels, and more.

Check out the `Manipulate Screen Transform` Component from the Asset Library for more advanced version of this example!

***

## Touch Blocking[​**](#touch-blocking "Copy to clipboard")

There may be times when you want your lens to capture all touch events to prevent users from unintentionally triggering other Snapchat actions while using it. For example, if your lens involves rapid tapping interactions, you may want to override Snapchat's default behavior of switching cameras on a double-tap.

In such cases, you can use `Touch Blocking` to override some or all of Snapchat's default touch behaviors.

### Basic Use[​**](#basic-use "Copy to clipboard")

To override the Snapchat app's default touch events, add the following line to a script bound to the "Lens Turned On" event:

```
global.touchSystem.touchBlocking = true;
```

With this line included, your Lens will override all of the app's default screen touch events.

The global property `global.touchSystem` is a TouchDataProvider object used to manage touch blocking exceptions.

### Touch Blocking Exceptions[​**](#touch-blocking-exceptions "Copy to clipboard")

You may not want to override all of the default Snapchat touch events. For example, you may want to override the double-tap event, but still allow the user to swipe to Stories or Chat. In this instance, you can use the Touch Blocking Exceptions.

#### Usage[​**](#usage "Copy to clipboard")

To make an exception for a specific type of touch, add the following code to a script bound to the "Lens Turned On" event:

```
global.touchSystem.touchBlocking = true;
global.touchSystem.enableTouchBlockingException('TouchTypePan', true);
```

In the example above, the Lens overrides all of the default touch events, but makes an exception for screen swipes. Enabling this exception allows the user to still swipe into another view of Snapchat (like Stories or Chat) while the Lens is active.

You can replace the string `TouchTypePan` with any of the Touch Types listed in the section below.

#### Exception Types[​**](#exception-types "Copy to clipboard")

You can enable or disable the following Touch Type Exceptions:

**TouchTypeTap:** Allows Snapchat to continue handling the tap gesture.

**TouchTypeDoubleTap:** Allows Snapchat to continue handling the double-taps gesture.

**TouchTypeScale:** Allows Snapchat to continue handling the two-finger pinch gesture.

**TouchTypePan:** Allows Snapchat to continue handling the pan gesture.

**TouchTypeSwipe:** Allows Snapchat to continue handling the swipe gesture.

## Related Documentation[​**](#related-documentation "Copy to clipboard")

Please refer to the guides below for additional information:

* [Scripting Overview](/lens-studio/features/scripting/script-overview.md)
* [Scripting Events](/lens-studio/features/scripting/script-events.md)
