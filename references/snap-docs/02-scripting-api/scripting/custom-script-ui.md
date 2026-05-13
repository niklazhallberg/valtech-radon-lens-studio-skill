# Custom Script UI

<!-- -->

Custom UI can be used to control how your script input fields appear in the `Inspector` panel. This is configured by adding a json string after your normal `@input` property declaration or a decorators in TypeScript.

#### Normal input declaration[​**](#normal-input-declaration "Copy to clipboard")

* JavaScript
* TypeScript

```
//@input vec3 myColor
```

```
@component
export class ExampleScript extends BaseScriptComponent {
  @input
  color: vec3;

  onAwake() {}
}
```

#### Input with custom UI[​**](#input-with-custom-ui "Copy to clipboard")

* JavaScript
* TypeScript

```
//@input vec3 myColor {"widget":"color"}
```

```
@component
export class ExampleScript extends BaseScriptComponent {
  @input
  @widget(new ColorWidget())
  color: vec3;

  onAwake() {}
}
```

## Default Values[​**](#default-values "Copy to clipboard")

### Individual variables[​**](#individual-variables "Copy to clipboard")

* JavaScript
* TypeScript

```
//@input string myString = "default string"
//@input int myInt = 24
//@input bool myBool = true
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input
  myString: string = 'default string';

  @input('int')
  myInt: number = 24;

  @input
  myBool: boolean = true;

  onAwake() {}
}
```

### Arrays[​**](#arrays "Copy to clipboard")

* JavaScript
* TypeScript

```
//@input string[] myStringArray  = {"My","default","strings"}
//@input int[] myIntArray = {24,1}
//@input bool[] myBoolArray = {true,false,false}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input('int[]', '{24,1}')
  myIntArray: number[];

  @input('boolean[]', '{true, false, false}')
  myBoolArray: boolean[] = [true, false, false];

  onAwake() {}
}
```

## General UI Controls[​**](#general-ui-controls "Copy to clipboard")

These are optional controls that work on `@input` properties and `@ui` widgets.

### Labels and Hints[​**](#labels-and-hints "Copy to clipboard")

![](/assets/images/custom-script-ui_CustomScriptUI_1-327dbcff522ff7bf69d63f56bae4afae.png)

* **"label"** - Overrides the text label displayed
* **"hint"** - Sets a hint message to appear on mouse hover

- JavaScript
- TypeScript

```
//@input string string1 = "hello" {"label":"String #1"}
//@input int number1 {"label":"Number (1.0)", "hint":"This is a number variable"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input
  @label('String #1')
  string1: string = 'hello';

  @input('int')
  @label('Number (1.0)')
  @hint('This is a number variable')
  number1: number = 0.0;

  onAwake() {}
}
```

### ShowIf[​**](#showif "Copy to clipboard")

* **"showIf"** - Sets a property name to control the element's visibility

[](/img/lens-studio/scripting/custom-script-ui_CustomScriptUI_2.webm)

* JavaScript
* TypeScript

```
//@input bool useColor
//@input vec3 myColor {"widget":"color", "showIf":"useColor"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input
  useColor: boolean;

  @input
  @widget(new ColorWidget())
  @showIf('useColor', true)
  myColor: vec3;

  onAwake() {}
}
```

### ShowIfValue[​**](#showifvalue "Copy to clipboard")

* **"showIfValue"** - Used with "showIf", sets a required value for the element to be visible (defaults to `true`)

[](/img/lens-studio/scripting/custom-script-ui_CustomScriptUI_3.webm)

* JavaScript
* TypeScript

```
//@input string inputMode {"widget":"combobox", "values":[{"label":"float", "value":"float"}, {"label":"vec3", "value":"vec3"}, {"label":"color", "value":"color"}]}
//@input float floatVal {"showIf":"inputMode", "showIfValue":"float"}
//@input vec3 vec3Val {"showIf":"inputMode", "showIfValue":"vec3"}
//@input vec4 colorVal {"widget":"color", "showIf":"inputMode", "showIfValue":"color"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input
  @widget(
    new ComboBoxWidget([
      new ComboBoxItem('float', 'float'),
      new ComboBoxItem('vec3', 'vec3'),
      new ComboBoxItem('color', 'color'),
    ])
  )
  inputMode: string = 'float';

  @input('float')
  @showIf('inputMode', 'float')
  floatVal: number;

  @input
  @showIf('inputMode', 'vec3')
  vec3Val: vec3;

  @input
  @showIf('inputMode', 'color')
  @widget(new ColorWidget())
  colorVal: vec4;

  onAwake() {}
}
```

## Input Widgets[​**](#input-widgets "Copy to clipboard")

Widgets can make dramatic changes to how `@input` properties are drawn. Each widget works with a certain set of property types, so make sure your property type is supported by the widget.

### Color[​**](#color "Copy to clipboard")

![](/assets/images/custom-script-ui_CustomScriptUI_4-1d218cb9d30e206f9ed82cf5a984b0dd.png)

A color picker for `vec3` and `vec4` properties.

* JavaScript
* TypeScript

```
// RGB (red, green, blue)
//@input vec3 myColor = {1,0,0} {"widget":"color"}
// RGBA (red, green, blue, alpha)
//@input vec4 colorWithAlpha = {1,1,1,.5} {"widget":"color"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input('vec3', '{1,0,0}')
  @widget(new ColorWidget())
  myColor: vec3;

  @input('vec4', '{1,1,1,1}')
  @widget(new ColorWidget())
  colorWithAlpha: vec4;

  onAwake() {}
}
```

### Spinbox[​**](#spinbox "Copy to clipboard")

[](/img/lens-studio/5-features/custom-script-ui_CustomScriptUI_5.webm)

The default widget for `int` and `float` properties.

* **"min"** - Minimum allowed value
* **"max"** - Maximum allowed value
* **"step"** - Amount added when clicking the up and down buttons

- JavaScript
- TypeScript

```
//@input int myInt {"widget":"spinbox", "label":"My Int", "min":0, "max":25, "step":5}
//@input float myFloat {"widget":"spinbox", "label":"My Float", "min":0.0, "max":1.0, "step":0.001}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input('int')
  @label('My Int')
  @widget(new SpinBoxWidget(0, 25, 5))
  myInt: number = 0;

  @input('float')
  @label('My Float')
  @widget(new SpinBoxWidget(0, 1, 0.001))
  myFloat: number = 0;

  onAwake() {}
}
```

### Slider[​**](#slider "Copy to clipboard")

[](/img/lens-studio/scripting/custom-script-ui_CustomScriptUI_6.webm)

Draws a draggable slider that interpolates between two values. This works with `int` and `float` properties.

* **"min"** - Minimum allowed value
* **"max"** - Maximum allowed value
* **"step"** - Smallest increment allowed between min/max

- JavaScript
- TypeScript

```
//@input int intSlider {"widget":"slider", "min":0, "max":10, "step":1}
//@input float floatSlider = 0.5 {"widget":"slider", "min":0.0, "max":1.0, "step":0.01}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input('int')
  @widget(new SliderWidget(0, 10, 1))
  intSlider: number = 5;

  @input('float')
  @widget(new SliderWidget(0, 1, 0.01))
  floatSlider: number = 0.5;

  onAwake() {}
}
```

### Combo Box[​**](#combo-box "Copy to clipboard")

[](/img/lens-studio/scripting/custom-script-ui_CustomScriptUI_7.webm)

Shows a dropdown menu with a list of selectable options. This works with `string`, `int`, and `float` properties.

* **"values"** - List of options in the combo box. Each option is a json object formatted as follows:

  <!-- -->

  * **"label"** - How this option appears in the drop down menu
  * **"value"** - The value returned in script if this option is selected

- JavaScript
- TypeScript

```
//@input int radius {"widget":"combobox", "values":[{"label":"one", "value":1}, {"label":"two", "value":2}]}
//@input string animalType {"widget":"combobox", "values":[{"label":"cat", "value":"cat"}, {"label":"dog", "value":"dog"}, {"label":"bird", "value":"bird"}]}
```

Here's a breakdown of the json strings being used in this example. Remember that each UI element is defined in a single line, so this expanded version is only for readability and won't work as is.

```
{
    "widget": "combobox",
    "values":
    [
        {"label": "one", "value": 1},
        {"label": "two", "value": 2}
    ]
}
{
    "widget": "combobox",
    "values":
    [
        {"label": "cat", "value": "cat"},
        {"label": "dog", "value": "dog"},
        {"label": "bird", "value": "bird"}
    ]
}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input('int')
  @widget(
    new ComboBoxWidget([new ComboBoxItem('one', 1), new ComboBoxItem('two', 2)])
  )
  radius: number = 1;

  @input
  @widget(
    new ComboBoxWidget([
      new ComboBoxItem('cat', 'cat'),
      new ComboBoxItem('dog', 'dog'),
      new ComboBoxItem('bird', 'bird'),
    ])
  )
  animalType: string = 'cat';

  onAwake() {}
}
```

### Text Area[​**](#text-area "Copy to clipboard")

Create a multi-line string input field:

![](/assets/images/custom-script-ui_CustomScriptUI_10-d77c25d4342b20690dbdfcb8f5f7be92.png)

* JavaScript
* TypeScript

```
//@input string text {"widget" : "text_area"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @input
  @widget(new TextAreaWidget())
  text: string;

  onAwake() {}
}
```

### Custom Type Inputs[​**](#custom-type-inputs "Copy to clipboard")

You may define your own custom input type and create arrays of custom objects:

![](/assets/images/custom-script-ui_CustomScriptUI_11-521fd0ef5afc3e879f16d08e0847b249.png)

* JavaScript
* TypeScript

```
/*
@typedef test
@property {vec3} a {"widget": "color"}
@property {vec4} b {"widget": "color"}
@property {int} c {"label":"My Int", "min":0, "max":25, "step":5}
@property {float} d {"label":"My Float", "min":0.0, "max":1.0, "step":0.001}
@property {int} e {"widget":"slider", "min":0, "max":10, "step":1}
@property {float} f {"widget":"slider", "min":0.0, "max":1.0, "step":0.01}
@property {int} g {"widget":"combobox", "values":[{"label":"one", "value":1}, {"label":"two", "value":2}]}
@property {string} h {"widget":"combobox", "values":[{"label":"cat", "value":"cat"}, {"label":"dog", "value":"dog"}, {"label":"bird", "value":"bird"}]}
*/

// @input test mystruct
// @input test[] mystruct2
```

```
@typedef
export class TestTypeDefTS {
  @input('vec3', '{1,1,1}')
  @widget(new ColorWidget())
  a: vec3;

  @input('int')
  @label('My Int')
  @widget(new SpinBoxWidget(0, 25, 5))
  b: number = 1;

  @input('int')
  @widget(new SliderWidget(0, 10, 1))
  e: number = 1;

  @input('int')
  @widget(
    new ComboBoxWidget([new ComboBoxItem('one', 1), new ComboBoxItem('two', 2)])
  )
  d: number;
}

@component
export class TypeScript extends BaseScriptComponent {
  @input
  mystruct: TestTypeDefTS; // (can be also in a different file)

  @input
  mystructArray: TestTypeDefTS[];

  onAwake() {}
}
```

Show more▼

Custom Type Inputs can also be nested multiple times within the custom type block:

![](/assets/images/custom-script-ui_CustomScriptUI_12-a0b1bd704a8c498cf8ed68f782548bbc.png)

* JavaScript
* TypeScript

```
/**
@typedef TestTypeDefJS
@property {vec3} a {"widget": "color"}
@property {int} b {"label":"My Int", "min":0, "max":25, "step":5}
@property {int} c {"widget":"slider", "min":0, "max":10, "step":1}
@property {int} d {"widget":"combobox", "values":[{"label":"one", "value":1}, {"label":"two", "value":2}]}
**/

/**
@typedef TestTypeDefJS_2
@property {TestTypeDefJS} testProperties; 
@property {string} testString; 
@property {int} testInt;
**/

// @input TestTypeDefJS_2 mystruct
```

```
@typedef
export class TestTypeDefTS {
  @input('vec3', '{1,1,1')
  @widget(new ColorWidget())
  a: vec3;

  @input('int')
  @label('My Int')
  @widget(new SpinBoxWidget(0, 25, 5))
  b: number = 1;

  @input('int')
  @widget(new SliderWidget(0, 10, 1))
  e: number = 1;

  @input('int')
  @widget(
    new ComboBoxWidget([new ComboBoxItem('one', 1), new ComboBoxItem('two', 2)])
  )
  d: number;
}

@typedef
export class TestTypeDefTS_2 {
  @input
  testProperties: TestTypeDefTS;
}

@component
export class TypeScript extends BaseScriptComponent {
  @input
  mystruct: TestTypeDefTS_2;

  onAwake() {}
}
```

Show more▼

## UI Widgets[​**](#ui-widgets "Copy to clipboard")

UI widgets are purely for visual organization and decoration, since unlike `@input` properties they won't provide values to your script. They are created by starting a line with `//@ui`. For example:

![](/assets/images/custom-script-ui_CustomScriptUI_13-74651c9d09511710d19c3066da60a6a1.png)

* JavaScript
* TypeScript

```
//@ui {"widget":"label", "label":"Hello"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @ui.label('Number Controls')
  @input
  myInt: number = 1;

  onAwake() {}
}
```

### Label[​**](#label "Copy to clipboard")

![](/assets/images/custom-script-ui_CustomScriptUI_14-c8f2903a2a4cb21e71f6d636f86b5663.png)

Draws a line of text. Useful for titles, warnings and descriptions.

* JavaScript
* TypeScript

```
//@ui {"widget":"label", "label":"Color Controls"}
// Empty label, adds empty space
//@ui {"widget":"label"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @ui.label('Color Controls')
  @ui.label('')
  @input('vec3', '{1,0,0}')
  @widget(new ColorWidget())
  myColor: vec3;

  onAwake() {}
}
```

### Separator[​**](#separator "Copy to clipboard")

![](/assets/images/custom-script-ui_CustomScriptUI_15-808648a7b7b8930ec7e1dc50a2732a9b.png)

Draws a horizontal line for separating content.

* JavaScript
* TypeScript

```
//@ui {"widget":"label", "label":"Color Controls"}
// Empty label, adds empty space
//@ui {"widget":"separator"}
//@input vec3 myColor = (1,0,0) {"widget":"color"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @ui.label('Color Controls')
  @ui.separator
  @input('vec3', '{1,1,1}')
  @widget(new ColorWidget())
  myColor: vec3;

  onAwake() {}
}
```

### Group[​**](#group "Copy to clipboard")

![](/assets/images/custom-script-ui_CustomScriptUI_16-0b60ae480c17ac439ce412d9450cf156.png)

Creates a collapsible group that hides or shows all content inside. Use a `"group_start"` widget to begin the group, and a `"group_end"` widget to end it. Any `@input` or `@ui` between the two will become part of the group.

* JavaScript
* TypeScript

```
//@ui {"widget":"group_start", "label":"My Group"}
// inner content...
//@ui {"widget":"group_end"}
```

```
@component
export class TypeScript extends BaseScriptComponent {
  @ui.group_start('Number Content')
  @input
  myInt: number = 1;
  @ui.group_end
  @ui.group_start('String Content')
  @input
  myString: string = 'Hello';
  @ui.group_end
  onAwake() {}
}
```
