# TypeScript

With Lens Studio 5.0, TypeScript is supported natively within Lens Studio. Lens developers can choose to develop their Lens in JavaScript, TypeScript or both. While there should be some familiarity with using TypeScript as JavaScript, there are nuances that you should be aware of. If it is your first time using TypeScript, [typescriptlang](https://www.typescriptlang.org/docs/handbook/intro.html) is a great resource to learn more about TypeScript.

## JavaScript vs TypeScript[​**](#javascript-vs-typescript "Copy to clipboard")

When choosing between JavaScript and TypeScript for creating your Augmented Reality experiences in Lens Studio, it’s essential to understand their difference and make an informed decision.

### Benefits of TypeScript Compared to JavaScript[​**](#benefits-of-typescript-compared-to-javascript "Copy to clipboard")

#### Static Typing[​**](#static-typing "Copy to clipboard")

TypeScript’s static typing feature allows developers to define types for variables, function parameters, and return values, enabling early error detection and enhancing code quality and maintainability during compilation.

#### IDE Support[​**](#ide-support "Copy to clipboard")

TypeScript provides robust tooling support, including features such as code navigation, intelligent code completion, and refactoring tools through integrated development environments (IDEs) such as [Visual Studio Code](/lens-studio/features/scripting/vscode-extension.md).

#### Object-Oriented Programming[​**](#object-oriented-programming "Copy to clipboard")

TypeScript’s support for object-oriented programming (OOP) concepts simplifies the creation of scalable and maintainable codebases. Features such as classes, interfaces, and inheritance contribute to improved code organization.

#### Interoperability with JavaScript[​**](#interoperability-with-javascript "Copy to clipboard")

TypeScript’s interoperability with existing JavaScript codebases allows for seamless integration and incremental adoption. Developers can gradually introduce TypeScript into an existing project.

### Challenges of TypeScript Compared to JavaScript[​**](#challenges-of-typescript-compared-to-javascript "Copy to clipboard")

#### Learning Curve[​**](#learning-curve "Copy to clipboard")

TypeScript’s static typing feature may pose a learning curve for developers who are unfamiliar with static typing concepts.

#### Compilation Time[​**](#compilation-time "Copy to clipboard")

TypeScript’s compilation time, which converts TypeScript code to JavaScript, can introduce additional overhead and potentially slow down development time.

#### Lens Studio IDE[​**](#lens-studio-ide "Copy to clipboard")

While Lens Studio provides auto-completion support for JavaScript-based scripts, it lacks similar support for TypeScript.

#### Small Project Overhead[​**](#small-project-overhead "Copy to clipboard")

In smaller projects, static typing may be less prevalent. In such cases, the additional overhead of using TypeScript might outweigh its advantages.

## Core Lens Studio Classes For TypeScript[​**](#core-lens-studio-classes-for-typescript "Copy to clipboard")

### BaseScriptComponent[​**](#basescriptcomponent "Copy to clipboard")

In TypeScript, all scripts decorated with @component inherit from the BaseScriptComponent and will behave similarly to JavaScript Components. Read for more details: [Script Components Documentation](/lens-studio/features/scripting/script-components.md)

BaseScriptComponent inherits all methods and properties of ScriptComponent with addition of getTypeName method.

### getTypeName(): string[​**](#gettypename-string "Copy to clipboard")

Returns the name of this object’s type.

RequireMe.ts

```
@component
export class RequireMe extends BaseScriptComponent {
  @input
  someNumericInput: number;

  @input
  someDefaultInput2: number = 10;

  protected value: number = 1;

  setValue(value: number) {
    this.value = value;
  }

  getValue() {
    return this.value;
  }
}
```

TestRequireType.ts

```
import { RequireMe } from './RequireMe';

@component
export class TestRequireType extends BaseScriptComponent {
  @input
  objectWithRequireMe: SceneObject;

  onAwake() {
    let requireMe = this.objectWithRequireMe.getComponent(
      RequireMe.getTypeName()
    );
    let createdRequireMe = this.objectWithRequireMe.createComponent(
      RequireMe.getTypeName()
    );

    print(requireMe.getValue());
    print(requireMe.someDefaultInput2);
    print(requireMe.someNumericInput);
  }
}
```

## Widgets[​**](#widgets "Copy to clipboard")

Widgets Classes can be used to create a custom UI to control how your script properties appear in the Inspector Panel using the Core Lens Studio Decorators.

See for the available Widget Classes: Input Widgets - [Custom Script UI](/lens-studio/features/scripting/custom-script-ui.md)

## Core Lens Studio Decorators[​**](#core-lens-studio-decorators "Copy to clipboard")

Decorators are special kinds of declarations that can be attached to class declarations, methods, properties, or parameters. Decorators use the form `@expression`, where expression must evaluate to a function that will be called at runtime with information about the decorated declaration.

For more details, refer to the [TypeScript Decorators](https://www.typescriptlang.org/docs/handbook/decorators.html) documentation.

Lens Studio provides several native decorators.

### Component[​**](#component "Copy to clipboard")

`@component`

The `@component` decorator instructs the compiler to create a special .js file with specified Script Inputs and Script UI. It should be used to decorate export classes. The decorated class should extend `BaseScriptComponent` or any other class that directly or indirectly extends `BaseScriptComponent`. Only one component decorator is allowed per file. The file will create an instance of the decorated class and set the input properties accordingly. After that, the `onAwake()` function is called.

```
@component
export class HelloWorld extends BaseScriptComponent {
  onAwake() {
    print('Hello World!');
  }
}
```

### Typedef[​**](#typedef "Copy to clipboard")

`@typedef`

The `@typedef` decorator is used to create a class that can be used inside a Custom Type Input. It should be used to decorate export classes. The decorated class should only contain properties decorated with `@input`.

```
@typedef
export class Button {
  @input()
  isActive: boolean;

  @input()
  material: Material;

  @input()
  sceneObject: SceneObject;
}
```

### Input[​**](#input "Copy to clipboard")

`@input(typeOverride?: ScriptingInputType, defaultInitializerOverride?: string | number)`

Decorator which is used to make a Script Input from a class, decorated with `@component`, property or constructor parameter.

```
import { OtherTSComp } from './OtherTSComp';

@component
export class InputsShowcase extends BaseScriptComponent {
  @input()
  sceneObject: SceneObject;

  @input()
  someMaterial: Material;

  @input()
  customType: CustomType; // (can be also in a different file)

  @input('int')
  someInt: number;

  @input()
  someFloat: number = 2.0;

  @input('mat2', '{{1,2},{3,4}}')
  someMatrix: mat2;

  @input
  otherTSComp: OtherTSComp; // can use other ts component types as input types

  onAwake() {}
}
```

### ShowIf[​**](#showif "Copy to clipboard")

`@showIf(showIf: string, showIfValue?: string | number)`

The `@showIf` decorator is used after `@input` or any `@ui.*` decorator. It sets a property name to control the element's visibility.

```
@component
export class ShowIfShowcase extends BaseScriptComponent {
  @input()
  advanced: boolean;

  @input()
  @showIf('advanced')
  sceneObject: SceneObject;

  onAwake() {}
}
```

### Hint[​**](#hint "Copy to clipboard")

`@hint(hint: string)`

The `@hint` decorator is used after `@input`, or `@ui.*` decorator. It sets a hint message to appear on mouse hover.

```
@component
export class HintShowcase extends BaseScriptComponent {
  @input()
  @hint('Scene object that does a lot of stuff')
  sceneObject: SceneObject;

  onAwake() {}
}
```

### Label[​**](#label "Copy to clipboard")

`@label(label: string)`

The `@label` decorator is used only after `@input` decorator. It is used to override displayed text.

```
@component
export class LabelShowcase extends BaseScriptComponent {
  @input()
  @label('Hand Root')
  sceneObject: SceneObject;

  onAwake() {}
}
```

### Widget[​**](#widget "Copy to clipboard")

`@widget(widget: UIWidget)`

The `@widget` decorator is used only after `@input`. It is used to specify custom UI widgets for particular script input.

```
@component
export class WidgetShowcase extends BaseScriptComponent {
  @input()
  @widget(new SliderWidget(0, 5, 0.25))
  myFloat: number;

  onAwake() {}
}
```

See for the available Widgets: Input Widgets - [Custom Script UI](/lens-studio/features/scripting/custom-script-ui.md)

### UI[​**](#ui "Copy to clipboard")

`@ui.separator` `@ui.label(label?: string)` `@ui.group_start(label?: string)` `@ui.group_end`

Decorators for creating UI Widgets are used only for pure visualization. The property which is being decorated doesn’t matter, only its order relative to other decorators is being used. Keep in mind, there should always be some property below `@ui` decorator. This is the restriction which comes from the TypeScript compiler.

```
@component
export class UIShowcase extends BaseScriptComponent {
  @input()
  showSliders: boolean;

  @ui.group_start('My Sliders')
  @showIf('showSliders')
  @input()
  @widget(new SliderWidget(0, 5, 0.25))
  myFloat: number;

  @input()
  @widget(new SliderWidget(0, 5, 0.25))
  myFloat2: number;

  @ui.group_end
  @ui.separator
  @ui.label() // Intentional empty label
  @ui.label('Here only scene objects are listed')
  @input()
  mySceneObject1: SceneObject[];

  @input()
  mySceneObject2: SceneObject[];

  @ui.separator
  onAwake() {}
}
```

### AllowUndefined[​**](#allowundefined "Copy to clipboard")

`@allowUndefined`

The `@allowUndefined` decorator is used along with `@input` or `@inputTypedef` decorators to disable undefined checks. By default, all `@input` and `@inputTypedef` properties are checked for “undefined”. If an input property is not provided, then a run-time error would be thrown.

```
@component
export class AllowUndefined extends BaseScriptComponent {
  @input()
  @allowUndefined
  sceneObject: SceneObject;

  onAwake() {
    if (this.sceneObject) {
      this.sceneObject.enabled = true;
    }
  }
}
```

### Typename[​**](#typename "Copy to clipboard")

`@typename`

The `@typename` decorator is used to specify a custom type name, which can later be used as a parameter for the `getComponent()` function or as an input type.

```
@component
export class UsingTypeName extends BaseScriptComponent {
  @typename
  MySecretComponent: keyof ComponentNameMap;

  @input('MySecretComponent')
  component: MySecretComponent;

  onAwake() {
    let component = this.script
      .getSceneObject()
      .getComponent(this.MySecretComponent) as MySecretComponent;
  }
}
```

## TypeScript Compilation[​**](#typescript-compilation "Copy to clipboard")

In Lens Studio, TypeScript files undergo a compilation process. This process may not be instantaneous, and as a result, the Preview Panel may not immediately reflect the correct behavior if the TypeScript compilation was not successful. It's crucial to ensure that Lens Studio has completed the compilation of your TypeScript files after each modification.

Information regarding the state of TypeScript compilation can be found in the Logger Panel.

![](/assets/images/typescript-1-ce553da69852a4ab9658b335c1db10d7.png)

Compilation info can be accessed in the TypeScript Status Panel as well. To access the TypeScript Panel, navigate to `Window > Utilities > TypeScript Status`.

![](/assets/images/typescript-2-b8ab28e0cce16b8d247409c8c5124099.png)

Remember to refresh your Preview Panel once the compilation process has successfully completed.

![](/assets/images/typescript-3-dc26c2f4a683ca632e8d3c5a0ff2a359.png)

## Declaration Files[​**](#declaration-files "Copy to clipboard")

The declare keyword is essential for ambient declarations in TypeScript. These declarations allow seamless integration of existing JavaScript code into your TypeScript codebase. Think of it as a bridge connecting TypeScript with existing JavaScript code. Suppose you have an existing JavaScript file with valuable variables or functions. By declaring them in TypeScript, you can leverage their functionality without rewriting everything.

For practical examples of using the declare keyword, see: [Accessing one component from another](/lens-studio/features/scripting/accessing-components.md)

Lens Studio does not provide any specific handling for .d.ts files. Therefore, when using the declare keyword, you have the flexibility to create these declarations in either .d.ts files or regular .ts files. For additional information on how to use the declare keyword, refer to the [TypeScript Handbook: Declaration Files by Example](https://www.typescriptlang.org/docs/handbook/declaration-files/by-example.html).
