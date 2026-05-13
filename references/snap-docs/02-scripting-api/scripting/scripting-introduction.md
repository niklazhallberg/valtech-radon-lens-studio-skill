# Scripting Introduction

<!-- -->

Lens Studio comes with scripting support to help you add interactivity to your Lenses, from helper scripts and tweens to fully custom components.

[](/img/lens-studio/scripting/scripting-intro_2024-04-16.webm)

### Helper Scripts[​**](#helper-scripts "Copy to clipboard")

Lens Studio comes with a number of helper scripts to help you add interactivity without you having to write your own code.

* [Behavior Script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md): allows you to define triggers (for example, mouth opens) and responses (play animation)
* [Tween Manager](/lens-studio/lens-studio-workflow/adding-interactivity/tween-manager.md): allows you to add tweens and animations to objects in your scene

### Asset Library[​**](#asset-library "Copy to clipboard")

You can find even more helper scripts, custom components and other assets in the Asset Library.

[](/img/lens-studio/scripting/asset-lib_2024-04-16.webm)

### Custom Components[​**](#custom-components "Copy to clipboard")

The term custom components refers to a bundle that has one main script asset and all it's dependencies. A custom component is a subset of an [Asset Package.](/lens-studio/features/package-management/asset-packages-introduction.md)

In Lens Studio, all Scripts are by default consider custom components.

### Scripting Example[​**](#scripting-example "Copy to clipboard")

For a step-by-step guide to creating and running your first script, please refer to the [Scripting Example](/lens-studio/features/scripting/scripting-example.md).

### API Reference[​**](#api-reference "Copy to clipboard")

For a detailed technical reference of all classes and methods available in Lens Studio, please refer to the [Scripting API](/api/home.md) in the navigation menu.

***

## Script Assets[​**](#script-assets "Copy to clipboard")

Script Assets (referred to as Scripts) are text files that contain the code you write for your Lens. Scripts are written in JavaScript or TypeScript. Here's an example of a basic script:

* JavaScript
* TypeScript

```
print('Hello, World!');
```

While Lens Studio scripts are written in JavaScript, there are some practices specific to the Lens Studio environment with which you should become familiar. To learn more, please refer to the section on [Writing Scripts](#writing-scripts-in-lens-studio).

```
@component
export class NewScript extends BaseScriptComponent {
  onAwake() {
    print('Hello World');
  }
}
```

*A basic script. When triggered, this script will print "Hello, World!" to the [Logger](/lens-studio/features/scripting/debugging.md).*

### Adding a Script Asset[​**](#adding-a-script-asset "Copy to clipboard")

You can add Scripts to your Lens Studio project in two ways:

* **Create** an empty script file
* **Import** an existing script file

#### Creating an Empty Script[​**](#creating-an-empty-script "Copy to clipboard")

You can add an empty script in the `Asset Browser` panel by selecting

`+ -> JavaScript or TypeScript Component`

[](/img/lens-studio/scripting/script-intro-addnew_2024-04-16.webm)

#### Importing an Existing Script[​**](#importing-an-existing-script "Copy to clipboard")

You can import an existing script in the `Asset Browser` panel by clicking

`+ -> Import Asset`

[](/img/lens-studio/scripting/script-intro-import_2024-04-15.webm)

#### Script Asset Inspector[​**](#script-asset-inspector "Copy to clipboard")

The Script Asset Inspector is present when you click on a Script Asset. Here you’ll be able to change the icon, description, and version. You can also set the default value of input variables, excluding Scene Object and Component references.

![](/assets/images/script-intro-asset-inspector-ad905d921ec9896925335810b85c5672.png)

#### Hidden Script Input Fields[​**](#hidden-script-input-fields "Copy to clipboard")

You can hide script input fields from being displayed in the scene by clicking the eye icon beside the input. These inputs won’t be visible in the Script Component Inspector and will always use their default value.

[](/img/lens-studio/scripting/script-intro-hidden-input.webm)

#### Exporting Scripts[​**](#exporting-scripts "Copy to clipboard")

You can right-click on the Script Asset and select Export in the drop down menu to export it. You have an option to export as `Editable` or `Locked`.

Exporting will bundle all referenced resources inside the asset. In case of exporting as Editable, whoever you share the file with will be able to see and edit the Script Asset. You can right-click and select `Unpack for Editing` in the drop down menu to unpack all assets stored in the bundle.

![](/assets/images/script-intro-export-scripts-7431f532f9adefc804d675f19d417896.png)

***

## Writing Scripts in Lens Studio[​**](#writing-scripts-in-lens-studio "Copy to clipboard")

Lens Studio scripts are written in an implementation of standard JavaScript or TypeScript, but there are a few practices specific to the Lens Studio environment that you'll need to be aware of as you write scripts for your Lenses.

### Declaring Script Input Fields[​**](#declaring-script-input-fields "Copy to clipboard")

To declare a script input field in your script, you'll need to use the @input keyword.

* JavaScript
* TypeScript

```
//@input float intensity = 1.0
//@input string objectName
//@input Component.AudioComponent music
//@input float[] delayTimes
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input('float')
  intensity: number = 1.0;

  @input
  objectName: string;

  @input
  @allowUndefined
  music: AudioComponent;

  @input('float[]')
  delayTimes: number[];

  onAwake() {}
}
```

In this example, we declared four script input fields:

* A `number` named `intensity` with a default value of 1.0
* A `string` named `objectName`
* A reference to an [Audio Component](/api/lens-studio/Classes/Components.md#audiocomponent) named `music`
* A `list` of `floats` named `delayTimes`

Script input fields defined in script are editable in the object's `Script` component[](/lens-studio/features/scripting/script-components.md) via the `Inspector` panel.

You can learn more about available property types in the [Scripting Input Type Reference](/api/lens-studio/InputTypes.md).

You can learn more about customizing your script's UI in the [Custom UI Guide](/lens-studio/features/scripting/custom-script-ui.md).

When you are referring to objects in a script, consider how other scripts may affect the object you are referring to. For example: another script might delete the object you are looking to modify, which would cause your script to error.

You can use the `isNull` [method](/lens-studio/api/lens-scripting/functions/Built-In.isNull.html) to ensure an object exists before modifying it. Importantly, checking an object `== null` might not be enough.

### Accessing a Script Input Field[​**](#accessing-a-script-input-field "Copy to clipboard")

Defined script input fields become members of the pre-defined object `script`. You can access a property defined in your script using the keyword `script`.

* JavaScript
* TypeScript

```
//@input string hello = "Hello, World!"
print(script.hello);
```

```
@component
export class NewScript extends BaseScriptComponent {
  @input
  hello: string;

  onAwake() {
    print(this.hello);
  }
}
```

You can learn more about the `script` object in the [Scope](#scope) section below.

## Scope[​**](#scope "Copy to clipboard")

Variables and functions you declare in script are accessible in three layers of scope.

### Local Scope[​**](#local-scope "Copy to clipboard")

All functions and variables you declare with `let` or `const` in a script are locally scoped by default. In other words, they can be accessed only from the script in which they're defined.

### Script Scope[​**](#script-scope "Copy to clipboard")

You can use the `script` object to access and modify properties defined in a Script. The same `script` object is shared between all Scripts on a Script Component.

### Global Scope[​**](#global-scope "Copy to clipboard")

You can create global properties and functions available to all scripts by using the pre-defined `global` object.

* JavaScript
* TypeScript

```
global.myMessage = 'Hello, World!';
global.sayHello = function (message) {
  global.myMessage = message;
  print(global.myMessage);
};
```

```
declare namespace global {
  var myMessage: string;
  function sayHello(message: string): void;
}

@component
export class GlobalExample extends BaseScriptComponent {
  onAwake() {
    global.myMessage = 'Hello, World!';

    global.sayHello = function (message) {
      global.myMessage = message;
      print(global.myMessage);
    };
  }
}
```

In this example, `global.myMessage` and `global.sayHello` can now be accessed from any other Script in the project.

Please note that in order to properly access `global` properties and methods assigned in another script, the properties need to be declared in a script that's already been triggered. To learn more about script triggering and event ordering, please refer to the [Event Guide](/lens-studio/features/scripting/script-events.md).

## Scripting Tools[​**](#scripting-tools "Copy to clipboard")

Lens Studio has built-in tools for writing and debugging Scripts. You can also use an external text editor to write Scripts.

### Logging[​**](#logging "Copy to clipboard")

See the [Debugging Guide](/lens-studio/features/scripting/debugging.md) for information on logging in Lens Studio or on device.

### Script Editor[​**](#script-editor "Copy to clipboard")

Scripts can be edited directly in Lens Studio's [Script Editor](/lens-studio/features/scripting/script-editor.md).

To edit a script, double-click a Script in the `Asset Browser` panel. Once opened, the Script Editor will show up. Press `Cmd + S` on Mac or `Ctrl + S` on Windows to save the script.

[](/img/lens-studio/scripting-overview_script-overview-10.webm)

You can also open your script by default in an [External Editor](/lens-studio/features/scripting/script-editor.md#external-editors).

## Script Instantiator[​**](#script-instantiator "Copy to clipboard")

Setup script allows to implement custom instantiation logic for your script. Find more info in the [Package Instantiator](/lens-studio/features/package-management/packages-instantiator.md) documentation.
