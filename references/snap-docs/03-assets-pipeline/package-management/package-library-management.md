# Package Library Management

You can take advantage of the library management features for packages for cross team collaboration.

## Registering Packages to Installed Library[​**](#registering-packages-to-installed-library "Copy to clipboard")

To register your package to your library, right click on the package and select `Register to Library`. The package will be registered to your [Installed Library](/lens-studio/features/package-management/package-manager.md) folder.

When you register at your library, you will see a .lspkg file, a .json file that contains information about the package and an icon file.

![](/assets/images/package-management_4-ad6277f62e06b698ba91007f6d942815.png)

## Versioning[​**](#versioning "Copy to clipboard")

Registered packages have a version number associated with them to help manage updates without breaking existing projects.

The version installed to your Lens Studio or inside an Installed Library can be updated by right clicking the package and selecting `Push Update To Library` or setting the version in the package asset inspector.

`Push Update to Library > Locked`, this will prevent any future edits to the package `Push Update to Library > Editable`, this will allow any future editors to the package

When your installed library has an updated version of the package compared to your project you can update your package by right clicking the package and selecting `Pull Update from Library`.

## Library Management through Teams[​**](#library-management-through-teams "Copy to clipboard")

Library management enables team members to work efficiently together. If team members share the same installed library through a git workflow, they can easily share their changes to their scripts.

For Example: A team sets their library path to be `/UserId/myPackages`. myPackages, is a git repository of asset packages. When a user sets it as their library path, all the packages will show up in the preferences window under Lens Studio Installed Content.

![](/assets/images/package-management_12-ef6420c87d92dd1a92abbdd04a0c595e.png)

Or they’ll show up under Library Components in the Add New Asset Menu.

![](/assets/images/package-management_13-cd38f1aebc772958339c2ae88935f2db.png)

For Custom Components they will show up under Installed Components.

Team member A, decided to update `PackageA` and pushed the update to their library, by pressing `Push Update to Library > Editable`. Now they can commit the change on git and push it to their repo.

![](/assets/images/package-management_14-41f6f319b4d17e45190af0214552f34e.png)

Team member B, who is working on a project with an old version of `PackageA`, can update their git repo. Now their installed library will have the most recent version of `PackageA`. In their project, they can right-click on `PackageA` and click `Pull Update from the Library`.

![](/assets/images/package-management_15-7fed875e12bd795c13f50aa1e6c64d8f.png)

An icon will be present beside packages that have a higher version available.
