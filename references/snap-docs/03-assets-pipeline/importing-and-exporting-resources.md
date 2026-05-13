# Importing and Exporting Resources

This guide details how to import resources into your Lens Studio project and export resources, including hierarchies from the scene.

### Add New Resources[​**](#add-new-resources "Copy to clipboard")

In the `Asset Browser` panel, the `+` button allows you to add new resources to your Lens Studio project. After clicking on the `+` button, select the `Import Asset` option to add in your own custom resources. Otherwise, select from Lens Studio's built-in resources.

![](/assets/images/importing-and-exporting-resources_1-68d529ec31645a469e93656bfb78aed5.png)

### Drag and Drop[​**](#drag-and-drop "Copy to clipboard")

For convenience, you can also drag and drop a resource from your computer into the `Asset Browser` panel. It will automatically recognize the resource type and add it to your resources.

### File -> Import[​**](#file---import "Copy to clipboard")

You can also import resources into Lens Studio by right clicking on the `Asset Browser` panel and selecting `Import Asset`.

![](/assets/images/importing-and-exporting-resources_2-e23c65cae0689ae65597155cc69fcad7.png)

### The Assets Folder[​**](#the-assets-folder "Copy to clipboard")

Every Lens Studio project has a `Assets` folder which exists inside the saved project. This `Assets` folder contains every resource that has been imported into the project. Once imported, you are able to make changes to the assets in the public folder directly, Lens Studio will automatically recognize the change and update the resources accordingly.

Learn more in the [Project Structure](/lens-studio/lens-studio-workflow/advanced/source-control.md) guide.

![](/assets/images/importing-and-exporting-resources_3-5b40b9f48f539877adc556b460d08ef2.png)

You can directly add, delete or move resources around in the Assets Folder and those changes will propagate to the Asset Browser.

Do not change the contents of the `Cache` folder as it can cause problems within your project.

## Exporting from the Scene Hierarchy[​**](#exporting-from-the-scene-hierarchy "Copy to clipboard")

Any object in the `Scene Hierarchy` panel can be exported by right clicking the object and selecting `Export`. This will export the object and all of its children to an `.lspkg` file. Additionally, it will export all dependent resources.

![](/assets/images/importing-and-exporting-resources_4-5776c7831583813961d05fb80adb96f1.png)

To import an `.lspkg` file, right click in the `Scene Hierarchy` panel and select `Import object`. This will import the entire exported object hierarchy. Additionally, it will import all dependent resources into your `Asset Browser` panel.

![](/assets/images/importing-and-exporting-resources_5-ad43572d4465bd776c1901b5044e1538.png)

## Exporting from the Assets Browser[​**](#exporting-from-the-assets-browser "Copy to clipboard")

Any asset in the asset browser panel can be exported by right clicking the asset and selecting Export. This will export the object and all of its children to an .lspkg file. Additionally, it will export all dependent resources.

![](/assets/images/importing-and-exporting-resources_6-751a2246114727ffb84cd09ca481bafc.png)

For single Script Assets, you will be able to export them as custom components. More details can be found [here](https://developers.snap.com/lens-studio/features/scripting/scripting-introduction#exporting-scripts).
