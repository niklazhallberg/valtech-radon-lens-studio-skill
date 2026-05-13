# Script Modules

<!-- -->

Script Modules allow you to encapsulate code to use throughout your project.

Script Modules are especially useful when combining functionality abstracted from scene objects. Since a module isn't used as a regular script in a script component, it doesn't have access to the `script` property, which is available when a script is added to a scene object. Modules *do* have access to the global `scene` object.

You can also use the syntax of modules to access scripts, to instantiate them onto the SceneObject so they can use the script property, or to access other assets like Textures and Materials.

## Syntax[​**](#syntax "Copy to clipboard")

Script Modules in Lens Studio use CommonJS syntax. Export a module using `module.exports` and import a module using the `require` function.

## How to use a module[​**](#how-to-use-a-module "Copy to clipboard")

Use the method `require` to access a module from other scripts.

MyScript.js

```
const math = require('./MathModule');
var result = math.sum(1, 2); // Calculates the sum of the given digits
print(result); // Result: 3
```

In this case, the `math` variable receives the exports object defined in `MathModule.js`. Required modules are shown in the Inspector panel.

It is possible to refer to modules `by path` or `by name`. In either case the location of the module file relative to the file calling `require()` will be relevant.

A require is considered to be `by path` if it begins with `./` or `../`, i.e. `require("./MathModule")`. In the `by path` case the string passed to require should be the relative path from the file calling require to the module.

Any other case, i.e. `require("MathModule")` is considered `by name`. In the `by name` case a module with that name will first be looked for in the same folder as the script calling require, then the parent folder, then the next folder up, etc.

All versions of require must be used with string literals not by passing a const or var argument.

Modules required by name can still include path information but should not start with ./ or ../, i.e. `require("Modules/MathModule")`.

When doing require "by path" if your file has an extension other than ".js", ".cjs", ".lsc", or ".ts" you must include that extension. For example it must be requireAsset("./MySprite.png") not requireAsset("./MySprite").

## Library Packages and Folders[​**](#library-packages-and-folders "Copy to clipboard")

Modules can also be placed in your application Library Folder or your project’s Packages folder. Modules required by path will be searched for relative to the root of the folder. Modules required by name will look for a file with that name in the root of the folder. If a module is used out of the Library Folder it will be automatically copied into your project’s Packages folder for future use. If you use source control we recommend committing files in the Packages folder to source control.

Scripts within your Library and Packages folders can also require other scripts from those folders following the same rules for `by name` or `by path` but relative to their position in that folder.

You can check where the library folder is located or change it from the [Installed Content Preferences.](/lens-studio/features/package-management/package-library-management.md#installed-library)

You can add scripts to your Library Folder by right clicking and selecting "Register Script to Library"

## Other types of require[​**](#other-types-of-require "Copy to clipboard")

Along with the CommonJS standard require Lens Studio supports two other functions, `requireType` and `requireAsset`. Both of these functions follow the same rules as `require` described above, but allow retrieving different types of resources.

By using `requireAsset` you can get a reference to an Asset like a Texture, Material, or Mesh within your script without having to use `@input`.

By using `requireType` you can get a reference to a ScriptAsset, but instead of evaluating that ScriptAsset as a module you retrieve a handle used to make a call like `createComponent`, `getComponent`, or as part of an `@input` line for an instance of that ScriptComponent.

## Native Modules[​**](#native-modules "Copy to clipboard")

It’s also possible to retrieve built in Lens Studio modules using require. This means any type with `Module` in its name like ScanModule, BitmojiModule, or RemoteMediaModule. To do this use `LensStudio:` as a prefix for the name, i.e. `require("LensStudio:BitmojiModule")`. You don’t have to have added the module asset to your project previously or have it in your Assets folder for this to work.

## Creating a Module[​**](#creating-a-module "Copy to clipboard")

To create a module, define the `module.exports` object in a ScriptAsset:

MathModule.js

```
function sum(a, b) {
  return a + b;
}
module.exports = sum;
```

To specify the `module.exports` object's properties, either explicitly define the object:

MathModule.js

```
function sum(a, b) {
  return a + b;
}

function diff(a, b) {
  return a - b;
}

module.exports = {
  sum: sum,
  diff: diff,
};
```

Or define the properties of the `exports` object directly:

MathModule.js

```
module.exports.sum = sum;
module.exports.diff = diff;
```

Or define an entire prototype of a JavaScript object:

MathModule.js

```
function String(sourceString) {
  this.source = sourceString;
}

String.prototype.push = function (character) {
  this.source = this.source + character;
  return this.source;
};

String.prototype.pop = function () {
  this.source = this.source.slice(0, -1);
  return this.source;
};

module.exports = String;
```

To turn an existing ScriptAsset into a module, add the `module.exports` object definition which specifies the data you intend to export:

ExistingModule.js

```
// ScriptAsset data
// …
module.exports = {...} // The exported data
```

## Limitations[​**](#limitations "Copy to clipboard")

Script modules cache differently than other exports. When a module is required, it's not cached like in other environments. For example, `require.cache` is not available in Lens Studio.

## Asset Library Modules[​**](#asset-library-modules "Copy to clipboard")

We've prepared some useful modules in the Asset Library.

![](/img/lens-studio/script-modules-2.png)

## External Modules[​**](#external-modules "Copy to clipboard")

Requiring modules is standard practice for development in JavaScript. That means Lens Studio allows for general purpose external modules not limited to Lens development. Keep in mind that some modules might not fit the Lens development process. For example, some modules could be designed to work with file systems and other platform dependent features. Others could be written in non-CommonJS syntax.
