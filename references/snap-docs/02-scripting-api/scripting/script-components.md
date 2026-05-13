# Script Components

<!-- -->

In Lens Studio, scripts are added to the scene as Script Components, which are attached to Scene Objects. This association allows Script Components to interact with and manipulate the properties of other components within the same object or other objects in the scene.

![](/assets/images/script-components_2024-04-08-ab5da83371ebb54d6d2d6cd9297c9f8c.png)

The Script Component integrates `Script Assets` into a scene by:

* Running custom code when Lens **events** are triggered
* Exposing custom script **properties** for tweaking script behavior from the Lens Studio `Inspector` panel

Deleting a ScriptAsset will also remove the corresponding ScriptComponents

#### Lifecycle of a Script Component[​**](#lifecycle-of-a-script-component "Copy to clipboard")

To learn more about the life cycle of a Script Component, please refer to the [Script Events](/lens-studio/features/scripting/script-events.md)

## How to Create A Script Component[​**](#how-to-create-a-script-component "Copy to clipboard")

Script Components are automatically created when you drag your Script Asset to the Scene.

[](/img/lens-studio/scripting/script-components-create_2024-04-08.webm)

Script Components are automatically created when you select a Script Asset from the Add Component menu or the Add New Object menu.

[](/img/lens-studio/scripting/script-components-add_2024-04-08.webm)

Script Components can be created using [createComponent()](/api/lens-studio/Classes/ScriptObjects.md#SceneObject--createComponent) and retrieved using [getComponent()](/api/lens-studio/Classes/ScriptObjects.md#SceneObject--getComponent).

* JavaScript
* TypeScript

```
// Gets SceneObject attached
var newSceneObj = script.getSceneObject();
// Creates a new ScriptComponent
var newScriptComp = newSceneObj.createComponent('ScriptComponent');

// Gets the ScriptComponent attached to the SceneObject
var mySceneObj = newSceneObj.getComponent('ScriptComponent');
```

```
@component
export class NewScript extends BaseScriptComponent {
  onAwake() {
    // Gets SceneObject attached
    let sceneObject = this.getSceneObject();

    // Creates a new ScriptComponent
    let newScripComponent = sceneObject.createComponent('ScriptComponent');

    // Gets the ScriptComponent attached to the SceneObject
    let referenceScriptComponent = sceneObject.getComponent('ScriptComponent');
  }
}
```

In Lens Studio, you should not instantiate classes that extend BaseScriptComponent or decorated with @component using the `new` keyword. This is because BaseScriptComponent and decorated @component classes are tightly integrated with Lens Studio and have a specific lifecycle that is managed by Lens Studio.

Instead, if you want to create an instance of BaseScriptComponent or @component, you should use the createComponent() method on a SceneObject. This method will properly create and attach the component to the SceneObject, ensuring that it is managed correctly by Lens Studio's lifecycle.

## Events[​**](#events "Copy to clipboard")

A [Scene Event](/lens-studio/features/scripting/script-events.md) is a trigger that is activated while using a Lens. There are events for user activity (e.g. Tapped, Touch Started, etc.), as well as lifecycle events (Frame Updated, OnAwake, OnStart, etc.). The Script Component binds Lens Events to custom script code.

By default the Script Component will be bound to an OnAwake event. The contents of the Script will execute immediately when the ScriptComponent is first enabled. At that time future events like Frame Updated or Touch Start can be subscribed to, please refer to the [Binding Events In Scripts Example](/lens-studio/features/scripting/script-events.md#binding-events-in-script)

## Script Component Inspector[​**](#script-component-inspector "Copy to clipboard")

Script Input Fields are variables you can define to customize your script's behavior. Input Fields defined in a script can be modified in the `Inspector panel`, making them useful for tweaks and adjustments in Lens Studio. Input Fields are also useful for referencing Scene Objects, Components, and Assets from your script.

![](/assets/images/script-components-inputs_2024-04-08-d1102e284372d43db031f5b3301ffd63.png)

### Custom Script Input Fields[​**](#custom-script-input-fields "Copy to clipboard")

In the image above, the Script Component exposes the following Input Fields:

* A Material named *Object Material*
* A vec4 (color) named *Tint Color*
* A float number named *Change Speed*

These Input Fields can be edited live in the `Inspector` panel without the need for modifying code.

Widgets like sliders, color pickers, and more are available using a special definition syntax in your script. To learn more about how to include widgets in your script input fields, visit the [Custom Script UI guide.](/lens-studio/features/scripting/custom-script-ui.md)

You can reference [Assets](/api/lens-studio/Classes/Assets.md), [Components](/api/lens-studio/Classes/Components.md) and [Scene Objects](/api/lens-studio/Classes/ScriptObjects.md#SceneObject) through inputs. You can set the default value for Assets through the Script Asset Inspector, however Components and Scene Objects can only be set in the Script Component Inspector.

* JavaScript
* TypeScript

```
// @input SceneObject mySceneObj
// @input SceneObject[] mySceneObjArray

// @input Asset asset
// @input Asset[] assetArray
// @input Asset.Material materialAsset

// @input Component component
// @input Component[] componenArray
// @input Component.ScriptComponent scriptComponent
```

```
@component
export class NewScript extends BaseScriptComponent {
  @input
  mySceneObj: SceneObject;
  @input
  mySceneObjArray: SceneObject[];

  @input
  asset: Asset;
  @input
  assetArray: Asset[];
  @input
  materialAsset: Material;

  @input
  component: Component;
  @input
  componenArray: Component[];
  @input
  scriptComponent: ScriptComponent;

  onAwake() {}
}
```

### In Place Inspector[​**](#in-place-inspector "Copy to clipboard")

Users will be able to view the in-place asset inspector for referenced asset inputs. This in-place inspector will provide extra information about the asset.

[](/img/lens-studio/scripting/script-components-inplace_2024-04-08.webm)

Hovering over the input fields, allows for a quick way to obtain the property names for scripting.
