# Exporting Packages

When exporting packages with no external dependencies, you will be presented with an option to export the package as `Editable` or `Locked`.

![](/assets/images/package-management_16-32390848e932bae2b0b02a10c9001362.png)

`Editable` will allow users to unpack their packages on import. `Locked` will prevent users from unpacking their packages on import.

# Exporting External Asset Library Dependencies

When exporting a script or package that depends on an Asset Library Dependency in the Packages you will not be able to include it in your export. Rather, we will store the information of that dependency in a file called the `package_dependencies.json` and on import we will resolve following certain rules.

For example A script that has an external dependency to a script inside of SpectaclesInteractionKit and has an external dependency to Bitmoji 3D. When exporting that script the following dialog box appears:

![](/assets/images/package-management_17-b3bc7cc8d383cf953505af22a3a9fdc6.png)

Notice that because SIK and Bitmoji 3D are from the Asset Library, they cannot be included on my export. On export within the exported custom component, SIK and Bitmoji 3D are nowhere to be found.

![](/assets/images/package-management_18-2d2c024954ebad845f2a46ae937e439e.png)

This new `package_dependencies.json` file that has all the information about the external asset library dependencies.

# Exporting External Non-Asset Library Dependencies

Users can make their own Custom Components and Packages and have them in the Packages folder. Since these are not from the Asset Library, users will have an option to include them into their exported package or not.

For example There is a script with an external dependency to a script inside myOwnPackage and to myOwnScript asset in the packages folder. On exporting the script, the following dialog box appears.

![](/assets/images/package-management_19-f25e721bb2c3da9974c7bc4c4054bff8.png)

Notice that because myOwnPackage was included in the export and myOwnScript was not, myOwnPackage in the exported custom component, but not myOwnScript.

![](/assets/images/package-management_20-0433f14d855373d28090e6299be6cf85.png)

A package\_dependencies.json file that has all the information about the external asset library dependencies is created.

# Import Resolution

On import we do the folliwng rules to evaluate how to resolve the external dependencies.

**On import of the Package**:

* Check this .json file

**For each Asset Library Dependency:**

* If not in the Installed Library, install specific the version and import it to the Packages folder

**If in Installed Library:**

* If version is higher or equal resolve to that version
* If version is lower, install correct version from Asset Library

**If in Project already:**

* Resolve to project version

**For each Non-Asset Library Dependency:**

* If in the Installed Library import it
* If in Project already, resolve to project version
