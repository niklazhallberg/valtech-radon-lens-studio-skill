# Asset Library Publishing Guide

This guide walks you through preparing assets for the **Lens Studio Asset Library**—from how to structure your resources to exporting and submitting them. Following these guidelines improves the chance your asset is approved and useful to other creators.

In this guide:

1. [Resource guidelines](#resource-guidelines)
2. [Ways to Export](#ways-to-export)
3. [Submitting](#submitting)
4. [Questions](#questions)

## Resource guidelines[​**](#resource-guidelines "Copy to clipboard")

Use the guidance below to confirm that your submission is reusable, clear, and aligned with **Asset Library** quality.

### What we look for in every submission[​**](#what-we-look-for-in-every-submission "Copy to clipboard")

* **Versatile building blocks:** A good asset supports more than one type of Lens—creators should be able to apply it in different ways across their ideas. For example:

  <!-- -->

  * **Texture packs:** Provide several different example use cases.
  * **Materials:** Provide customizable inputs so others can fine-tune your materials to fit their needs.
  * **3D assets:** Allow for several variations or animations that inspire and enable creators on their projects.

* **Reusable:** Think building block, not finished scene—package work so others can import it without untangling a whole project. For example:

  <!-- -->

  * **What to submit:** Do not submit an entire **Lens Studio** project. Publish a focused asset package, custom component, installable package, or plugin that creators can import or install into their own projects.
  * **How it fits other projects:** Content must integrate well with other work—not dependent on a specific full-scene setup that only works as a standalone Lens.

* **Documentation:** Assume the reader is new to **Lens Studio**—your asset might be one of the first things they try in the editor, or the first time they use a workflow your asset depends on. Other creators should be able to pick up your asset without guessing. For example:

  <!-- -->

  * **Language:** All instructional text (asset and prefab names, in-editor descriptions, comments, JSDoc, and any separate documentation) must be in English. If you include instructions or labels in another language, you must provide the same guidance in English.
  * **Descriptions:** Provide a detailed package **Description**, submission blurb, and any README or separate documentation so people know what they are getting.
  * **In-editor clarity:** Use clear names and parameter descriptions for assets, prefabs, and parameters.
  * **Code and behavior:** Add comments or JSDoc where behavior needs explanation.
  * **External references:** Link to guides, templates, or examples when setup is non-trivial.

### Resource type guidelines[​**](#resource-type-guidelines "Copy to clipboard")

#### Scripts and custom components[​**](#scripts-and-custom-components "Copy to clipboard")

* Scripts and custom components must compile in **Lens Studio** with no errors before you submit.
* Putting comments or JSDoc annotations is a great way to help others use what you've built.
* Make sure your script is versioned and attributed.
* If you use third-party scripts or script modules, ensure the license allows this. If unsure, tell us when submitting.

#### Textures[​**](#textures "Copy to clipboard")

* Keep texture files as small as possible.
* If you are creating a texture pack, add textures to the **Asset Browser**, place them in a folder, and [create a package](#create-package) (see [Asset export](#asset-export)).

#### Materials[​**](#materials "Copy to clipboard")

* All materials used in the asset should be **Graph materials**. See the [Material Editor](/lens-studio/features/graphics/materials/material-editor/introduction-and-concepts.md) guides for more information.
* All material parameters should have meaningful **Title** and **Script Name** values.
  <!-- -->
  ![](/img/lens-studio/asset-library-publishing-4.png)
  <br />
  ![](/img/lens-studio/asset-library-publishing-5.png)
* Keep the material graph readable and not tangled; use subgraphs or code nodes where possible.
* Add a comment node when needed to group nodes and explain what they do.
  <!-- -->
  ![](/img/lens-studio/asset-library-publishing-6.png)
* Use **Sticky Note** for longer multi-line comments.
  <!-- -->
  ![](/img/lens-studio/asset-library-publishing-9.png)

#### VFX assets[​**](#vfx-assets "Copy to clipboard")

Good VFX assets benefit from the same practices as good materials, plus a few extras:

* Use the fewest particles needed for your goal. Avoid publishing VFX assets with more than 50,000 max particles.
  <!-- -->
  ![](/img/lens-studio/asset-library-publishing-8.png)
* Use subgraphs and code nodes directly on the **Spawn**, **Update**, and **Output** containers to keep the graph clean and readable.
* See [VFX Graph Optimization](/lens-studio/features/graphics/particles/vfx-editor/vfx-graph-optimization.md) for tips on keeping VFX systems running smoothly.

#### 3D assets[​**](#3d-assets "Copy to clipboard")

Follow [these general directions](/lens-studio/assets-pipeline/3d/exporting-content/overview.md#introduction) before bringing your 3D model into **Lens Studio**:

* Try to keep models under 100,000 triangles, or 60,000 triangles for meshes with joints/skinning, for best performance.
* Name meshes and bones descriptively; merge meshes that can be merged to simplify.
* Place the pivot at the object center (or another point that supports manipulating the object in the **Scene Panel**).
* Reset or apply all transforms when possible.
* Ensure normals face the correct direction.
* Meshes need a UV map and texture for use in **Lens Studio**.
* For extra detail, prefer a normal map texture.
* If the object is animated, do not use the **Legacy Import** option. Use an **Animation Player** component (not the deprecated animation mixer).
* For animation, set your tool’s time unit to 30 FPS and export the full range of animation frames.

## Ways to Export[​**](#ways-to-export "Copy to clipboard")

**Asset Library** accepts two broad paths:

* **[Asset export](#asset-export):** Reusable asset packages (scene hierarchies and resources as `.lspkg`). Best for prefabs, textures, materials, and bundled folders you want others to import into a project.
* **[Installable content export](#installable-content-export):** Items installed into **Lens Studio** itself—custom components, installable packages, and plugins (for example `.lsc` or a zipped plugin folder).

Pick the path that matches how creators should consume your work, then follow the subsection below.

### Asset export[​**](#asset-export "Copy to clipboard")

Asset packages are the most convenient way to distribute reusable building blocks. Even if you submit single asset files, we prefer you import them into **Lens Studio** yourself and follow the steps below to package them.

#### Name[​**](#name "Copy to clipboard")

Pick a descriptive and somewhat unique name for your asset. It should be clear and describe the asset well.

#### Resource organization[​**](#resource-organization "Copy to clipboard")

The easiest approach is **Organize Folder Structure** (right-click in the **Asset Browser**), then place all folders under a parent folder that matches your asset name. For example:

![](/img/lens-studio/asset-library-publishing-0.png)

#### Scene organization[​**](#scene-organization "Copy to clipboard")

When applicable, parent all scene objects that belong to your asset under one object and give it a descriptive name.

Then drag that scene object into the **Asset Browser** to create a prefab.

[](</img/lens-studio/5-asset-library/publishing - create prefab.webm>)

Append a placement hint to the prefab name when it helps users, for example `__PLACE_IN_SCENE`, `__PLACE_IN_ORTHO_CAM`, `__PLACE_UNDER_MAIN_CAM`, and similar.

#### Create package[​**](#create-package "Copy to clipboard")

Right-click the main folder in the **Asset Browser** and choose **Create Package**.

![](</img/lens-studio/5-asset-library/publishing - create package.png>)

Select the package in the **Asset Browser**, rename it, and fill **Description**, **Icon**, and **Version** in the **Inspector** so others understand what they are getting.

![](</img/lens-studio/5-asset-library/publishing - instructions.png>)

#### Export package[​**](#export-package "Copy to clipboard")

Right-click the asset package in the **Inspector** and choose **Export**. Choose whether the package is **Editable** or not—we generally recommend allowing editing for flexibility.

### Installable content export[​**](#installable-content-export "Copy to clipboard")

**Lens Studio** supports content that installs into the editor rather than importing into a single project: [Custom Components](#custom-components), [Installable Packages](#installable-packages), and [Plugins](#plugins).

#### Custom Components[​**](#custom-components "Copy to clipboard")

[Custom Components](/lens-studio/features/scripting/script-components.md) are components built from a script and include the resources the script needs, so developers can ship script and assets together.

When you export a custom component, referenced resources are packaged automatically. Fill in the required fields on the script component in the **Asset Inspector**.

![Custom component fields in the Asset Inspector](/img/lens-studio/5-asset-library/asset-lib-publishing-1.png)

Right-click and choose **Export**. Pick **Editable** or **Locked** depending on whether users should be able to customize your component.

#### Installable Packages[​**](#installable-packages "Copy to clipboard")

Installable editor packages (for example `.lsc`) add content to **Lens Studio** itself rather than to one project file. Export them with the appropriate editor workflow, then verify in a new project before you submit.

#### Plugins[​**](#plugins "Copy to clipboard")

See the [Plugins](/lens-studio/extending-lens-studio/plugins-development/overview.md) development guides. When the plugin is ready, zip the plugin folder.

![Zipped plugin folder ready to submit](/img/lens-studio/5-asset-library/publishing-zip-plugin.png)

When submitting, make sure the plugin name matches the asset name exactly, and optionally show how users should open the plugin in the asset thumbnail:

![Plugin thumbnail showing how to open the plugin](/img/lens-studio/5-asset-library/publishing-icon-plugin.png)

## Submitting[​**](#submitting "Copy to clipboard")

### Prepare Submission[​**](#prepare-submission "Copy to clipboard")

1. Open a new project in **Lens Studio** and verify your asset imports correctly before you submit.

2. Log in to [**My Lenses**](https://my-lenses.snapchat.com/assets/create) with the **Snapchat** account you want to publish under.

   * **Note:** Anything you submit to the **Lens Studio Asset Library** is published under that account's name.

3. Open **Asset Library Assets** in the left sidebar.

   ![My Lenses Asset Library Assets in the sidebar](/img/lens-studio/5-asset-library/asset-lib-publishing-0.png)

4. Click **Create Asset** on the top right.

### Submission Fields[​**](#submission-fields "Copy to clipboard")

#### Asset[​**](#asset "Copy to clipboard")

In the Asset section, click **Upload Asset** and select your `.lspkg`, `.lsc`, or `.zip` file.

#### Thumbnail[​**](#thumbnail "Copy to clipboard")

In the Thumbnail section, click **Upload Photo** and select your preview image.

* **Purpose:** This is the preview users see first. Make it engaging, faithful to the asset, and aligned with a colorful **Asset Library** look.
* **Format:** Export as a 512×512 pixel PNG, preferably on a transparent background.
* **Layout:** Leave some space around the subject so UI elements do not crowd the artwork.

Reference thumbnails (right-click an image → Save Image As):

![Example custom component thumbnail](/img/lens-studio/asset-library-publishing-cc.png) ![Example module thumbnail](/img/lens-studio/asset-library-publishing-module.png)

#### Description[​**](#description "Copy to clipboard")

Provide a short description of your asset, for example:

*"World Object Controller allows you to add a 3D object to the world that the user can walk towards and around. This tool gives you access to manipulation control which allows the user to move, scale and rotate the object."*

You may add words that help people find your asset. If it has several elements, list their names for search.

Add useful links for context (guides, templates, and similar).

#### Category[​**](#category "Copy to clipboard")

Pick the most relevant category. Use the correct category for installable content when applicable.

#### External link[​**](#external-link "Copy to clipboard")

This can be a **Lens Studio** guide that covers the essential components used in your Lens, or your own resource link.

#### Version[​**](#version "Copy to clipboard")

Set **Min Version** to the **Lens Studio** version you used to create the asset. Prefer the latest **Lens Studio** when you can.

If you are unsure about **Max Version**, leave it empty.

## Questions[​**](#questions "Copy to clipboard")

If you have questions about the submission process, contact [Lens Studio support](mailto:lensstudio-support@snapchat.com).
