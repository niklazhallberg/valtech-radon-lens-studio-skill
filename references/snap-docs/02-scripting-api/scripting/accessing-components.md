# Accessing Components

Script Components in Lens Studio are able to reference one another whether they have been created with JavaScript, TypeScript or Custom Component.

## Accessing JavaScript from JavaScript[​**](#accessing-javascript-from-javascript "Copy to clipboard")

To access properties and methods of a Component created with JavaScript, the property or method must be declared to a predefined object which all ScriptComponent have called `script`. In the example code below `script.numberVal` is declared and made available for other scripts to access it.

JSComponentA.js

```
script.numberVal = 1;
script.printHelloWorld = function () {
  print('hello');
};
```

JSComponentB.js

```
//@input Component.ScriptComponent refScript
print(script.refScript.numberVal);
script.refScript.printHelloWorld();
```

<!-- -->

#### Practical Example▼

## Accessing TypeScript from JavaScript[​**](#accessing-typescript-from-javascript "Copy to clipboard")

To access properties and methods of a Component created with TypeScript, the property or method must be declared within the scoped TypeScript defined Class. Properties and methods defined in a TypeScript file are by default public members. In the example code below numberVal is declared within the scope of the class TSComponentA and made available for other scripts to access it.

TSComponentA.ts

```
@component
export class TSComponentA extends BaseScriptComponent {
  numberVal: number = 1;

  onAwake() {}
  printHelloWorld() {
    print('Hello, world!');
  }
}
```

JSComponentB.js

```
//@input Component.ScriptComponent refScript
print(script.refScript.numberVal);
script.refScript.printHelloWorld();
```

#### Practical Example▼

## Accessing TypeScript from TypeScript[​**](#accessing-typescript-from-typescript "Copy to clipboard")

ScriptComponent created with TypeScript can be accessed directly with the Class type. In the example below, TSComponentA is created and being referenced by TSComponentB. To access the TSComponentA's property and methods, a reference property `@input` with the typeof TSComponentA is declared in TSComponentB.

TSComponentA.ts

```
@component
export class TSComponentA extends BaseScriptComponent {
  numberVal: number = 1;

  onAwake() {}
  printHelloWorld() {
    print('Hello, world!');
  }
}
```

TSComponentB.ts

```
import { TSComponentA } from './TSComponentA';

@component
export class TSComponentB extends BaseScriptComponent {
  @input
  refScript: TSComponentA;

  onAwake() {
    print(this.refScript.numberVal);
    this.refScript.printHelloWorld();
  }
}
```

#### Practical Example▼

## Accessing JavaScript from TypeScript[​**](#accessing-javascript-from-typescript "Copy to clipboard")

### With Type Completion:[​**](#with-type-completion "Copy to clipboard")

TypeScript enhances coding by providing automatic code completion. To ensure this feature works consistently when using JavaScript files, it's advised to create a declaration file. This file describes the JavaScript code structure so that your TypeScript components can recognize and work with it seamlessly. After setting up a declaration file, you can access a JavaScript component in TypeScript using the `@input` decorator.

Please refer to the example code below.

JSComponentA.js

```
script.numberVal = 1;
script.printHelloWorld = function () {
  print('hello');
};
```

JSComponentA\_Declaration.ts

```
export interface JSComponentA extends ScriptComponent {
  numberVal: number;
  printHelloWorld: () => void;
}
```

TSComponentB.ts

```
import { JSComponentA } from './JSComponentA_Declaration';

@component
export class TSComponentB extends BaseScriptComponent {
  @input('Component.ScriptComponent')
  refScript: JSComponentA;

  onAwake() {
    print(this.refScript.numberVal);
    this.refScript.printHelloWorld();
  }
}
```

#### Practical Example▼

### Without Type Completion:[​**](#without-type-completion "Copy to clipboard")

To access properties and methods created from JavaScript Components in your TypeScript Component without a declaration file, use the `@input` decorator and set the type to `any`.

JSComponentA.js

```
script.numberVal = 1;
script.printHelloWorld = function () {
  print('hello');
};
```

TSComponentB.ts

```
@component
export class TSComponentB extends BaseScriptComponent {
  @input('Component.ScriptComponent')
  refScript: any;

  onAwake() {
    print(this.refScript.numberVal);
    this.refScript.printHelloWorld();
  }
}
```

#### Practical Example▼

## Accessing Components on Scene Objects[​**](#accessing-components-on-scene-objects "Copy to clipboard")

Components can be accessed directly from SceneObjects using the `getComponent` method. This is useful when you want to access components that are attached to specific objects in your scene hierarchy.

* JavaScript
* TypeScript

```
//@input SceneObject mySceneObject {"hint":"The object to access the component from"}

// Access a component on the provided scene object
let renderMeshVisual = script.mySceneObject.getComponent(
  'Component.RenderMeshVisual'
);

// Check if the component exists before using it
if (renderMeshVisual) {
  print('Found RenderMeshVisual component');
  // Do something with the component
}
```

```
@component
export class AccessComponent extends BaseScriptComponent {
  @input
  mySceneObject: SceneObject;

  onAwake() {
    // Access a component on the provided scene object
    const renderMeshVisual = this.mySceneObject.getComponent(
      'Component.RenderMeshVisual'
    );

    // Check if the component exists before using it
    if (renderMeshVisual) {
      print('Found RenderMeshVisual component');
      // Do something with the component
    }
  }
}
```

#### Practical Example - Scene Object Components▼

## Accessing Components on Child Scene Objects[​**](#accessing-components-on-child-scene-objects "Copy to clipboard")

To access components on child objects in your scene hierarchy, you can use the `getChild` method to navigate the scene tree and then use `getComponent` on the child object.

* JavaScript
* TypeScript

```
//@input SceneObject parentObject

// Access the first child of the parent object
let childObject = script.parentObject.getChild(0);

// Access a component on the child object
if (childObject) {
  let childComponent = childObject.getComponent('Component.ScriptComponent');
  if (childComponent) {
    print('Found script component on child');
    // Use the component
  }
}
```

```
@component
export class AccessChildComponent extends BaseScriptComponent {
  @input
  parentObject: SceneObject;

  onAwake() {
    // Access the first child of the parent object
    const childObject = this.parentObject.getChild(0);

    // Access a component on the child object
    if (childObject) {
      const childComponent = childObject.getComponent(
        'Component.ScriptComponent'
      );
      if (childComponent) {
        print('Found script component on child');
        // Use the component
      }
    }
  }
}
```

#### Practical Example - Child Scene Object Components▼
