# Asset Packages Introduction

In Lens Studio, `Asset Packages` refers to a set of resources that can be managed and versioned from the library. They will have the extension `.lspkg`.

Custom Components are considered a subset of Asset Packages. Anything that can be done to Packages can also be done to Custom Components.

## Creating a Package[​**](#creating-a-package "Copy to clipboard")

In order to create an Asset Package, right click on whichever assets or folder you'd like to package and select, `Create Package`.

[](/img/lens-studio/package-management/package-management_5.webm)

Not all `.lspkg` files are considered an `Asset Package`. You must explicitely go through the `Create Package` flow in order to create a package.

## Export a Package[​**](#export-a-package "Copy to clipboard")

To export a package, right click on the root of the package and select, `Export`.

You have an option to export as `Editable` or `Locked`.

Exporting will bundle all referenced resources inside the asset. In case of exporting as Editable, whoever you share the file with will be able to see and edit the package. You can right-click and select `Unpack for Editing` in the drop down menu to unpack all assets stored in the bundle.

![](/assets/images/package-management_2-e508fd3cd654737be90c3a27ea11081d.png)

To learn more about exporting, please refer to the [Exporting Packages](/lens-studio/features/package-management/exporting-packages.md) section.

## Asset Package Inspector[​**](#asset-package-inspector "Copy to clipboard")

The Asset Package Inspector is present when you click on the root of the package. Here you’ll be able to change the icon, description, and version. You can also add a README and a setup script.

![](/assets/images/package-management_1-3bf2865bd93f2c4b09e30939041e8587.png)

## Asset Library[​**](#asset-library "Copy to clipboard")

The Asset Library contains many Asset Packages. When you install them to your project, they will get imported into your `Asset Browser` under the `Packages` folder and will be installed into the path set in the [Package Manager.](/lens-studio/features/package-management/package-manager.md)

For packages that have been installed to your library, you can import them from the `Add New Asset` menu. They will show under the `Installed Packages` section.

![](/assets/images/package-management_3-3e864861e0fdf7b763f9fecd9b82f143.png)

## Accessing Items In Packages via Scripting[​**](#accessing-items-in-packages-via-scripting "Copy to clipboard")

Scripts can access other assets within packages, using similar mechanisms described in [Script Modules.](/lens-studio/features/scripting/script-modules.md)

To access anything within your package, you must provide the full name of the package with the extension `.lspkg`.

For example, my Package.lspkg contains:

* myCustomComponent.lsc
* myJsModule.js
* myPng.png

In order to access these items, in my JS script asset, I can do the following:

myScript.js

```
const myCC = requireType('myPackage.lspkg/myCustomComponent.lsc');
const myModule = require('myPackage.lspkg/myJsModule.js');
const myAsset = requireAsset('myPackage.lspkg/myPng.png');
```

When unpacking pacakages, we automatically add the extension `.lspkg` or `.lsc` to the folder name so paths remain intact.
