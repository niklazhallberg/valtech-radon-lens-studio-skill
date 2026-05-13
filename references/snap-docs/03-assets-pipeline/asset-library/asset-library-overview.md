# Asset Library

The Asset Library is a repository containing a wide variety of assets and helpers that allows you to build your unique Lens Experiences or to refine your Lenses. It contains everything from simple reusable assets, to packages and components that get installed to your Lens Studio. Or even plugins, that add a whole new functionality!

[](/img/lens-studio/asset-library_asset-library-large.webm)

## What’s in it[​**](#whats-in-it "Copy to clipboard")

* **Essentials:** A selection of frequently used assets and components.
* **3D:** [3D models](/lens-studio/assets-pipeline/3d/importing-content/overview.md) that can be added to your Lenses.
* **2D:** Textures, hints, masks, and more for [2D](/lens-studio/assets-pipeline/2d/image.md) design.
* **Materials:** Custom [Materials](/lens-studio/features/graphics/materials/overview.md) to change the appearance of any mesh in your scene.
* **Tools:** Helper scripts that enhance the capabilities of your Lens.
* **Effects:** Custom shaders, particles, VFX, and full-screen effects.
* **SnapML:** Machine Learning models that extend the capabilities of Lens Studio. [Learn more about SnapML](/lens-studio/features/snap-ml/ml-overview.md)
* **Music:** A library of [Licensed Music](/lens-studio/features/audio/audio-track-assets.md#licensed-music) for use in your Lenses.
* **Audio:** [Audio and Voice](/lens-studio/features/audio/audio-track-assets.md) related assets.
* **Reference:** Helpful 3D models, materials, textures, reference assets.
* **Spectacles:** Tools specifically for developing Lenses for [Spectacles](/spectacles/home.md).
* **APIs:** A collection of [Remote API modules](/lens-studio/features/remote-apis/remote-service-module.md) that serve as higher-level interfaces, utilizing remoteServiceModule under the hood to enable your Lens to communicate with external services.
* **Custom Components:** Scripts with bundled resources that are installed into Lens Studio and can be added across projects. [Learn more about Custom Components](/lens-studio/features/scripting/script-components.md).
* **Script Modules:** [Modules](/lens-studio/features/scripting/script-modules.md) that facilitate code reuse in your scripts and custom components.
* **UI:** A collection of assets for Lens [UI](/lens-studio/features/ui/overview.md) design.
* **Plugins:** A collection of Lens Studio plugins. [Plugin](/lens-studio/extending-lens-studio/plugins/overview.md) utilizes the Editor API, enabling Lens developers to extend the functionality of Lens Studio.

## Using the Asset Library[​**](#using-the-asset-library "Copy to clipboard")

You can open the Asset Library within your project, by pressing the **Asset Library** button in the top left of Lens Studio.

![](/assets/images/asset-library_asset-library-button-a48e363c3bf7c99d92af7656db6ca77f.png)

Once the Asset Library is open, you’ll be able to find different categories of assets in the sidebar, and a grid of assets on the left-hand side.

![](/assets/images/asset-library_asset-library-window-9a1aaa29d7f345b4ac6391c75f98790a.png)

For each asset, you can find an **(i)** button that tells you more about the asset on hover.

![](/assets/images/asset-library_i-button-8fbb5eccc5b7138c0fc068effc419114.png)

To import the asset, click on the **Import** or **Install** button.

* **Import** button at the bottom of most of the assets.

  ![](/assets/images/asset-library_import-button-5a1a9b59b1fe4185bca0c34d596a2156.png)

* **Install** button at the bottom of Custom Components, Plugins and certain asset packages that are installable. You may also choose to install a specific version by clicking on the three dots on the top right of the item.

  ![](/assets/images/asset-library_install-verion-button-8469605d14d1176f6399196dc725bfda.png)

## Using the Assets[​**](#using-the-assets "Copy to clipboard")

There are different ways to bring the imported assets into your Lens depending on its type.

### Prefab[​**](#prefab "Copy to clipboard")

Most commonly, your assets will come in a `Prefab` which you can find in the `Asset Browser` panel. To use it, drag the prefab from the `Asset Browser` panel into the `Scene Hierarchy` panel based on the instructions. Once added, you can select the assets you need and remove those you don’t.

Asset can come in as an [`Asset Package`](/lens-studio/features/package-management/asset-packages-introduction.md). Most often the prefab will in the `Package` and follow the following steps to use the `Prefab`. You can right click on the `Package` and `Unpack for Editing` to modify the resources in the `Package`.

![](/assets/images/assset_library_asset-package-f87522e6093f3ba15bbb5222cb68d24b.png)

There are three common instructions in the Prefab after the asset name.

* `__PLACE_IN_SCENE`: Drag the prefab from the `Asset Browser` panel into the `Scene Hierarchy` panel.

  [](/img/lens-studio/asset-library_drag-prefab_scene.webm)

* `__PUT_IN_ORTHO_CAM` : If your project doesn't have an existing Orthographic camera. Create a new `Orthographic Camera` and place the prefab under it.

  [](/img/lens-studio/asset-library_drag-prefab_ortho.webm)

* `__PUT_UNDER_MAIN_CAM` : Drag the prefab from the `Asset Browser` panel into the `Scene Hierarchy` panel and place the prefab under the Camera Object.

  [](/img/lens-studio/asset-library_drag-prefab.webm)

### Scripts and Packages[​**](#scripts-and-packages "Copy to clipboard")

Some assets get installed to your Lens Studio instead of being added to the current project. For example items from the Custom Components section or other assets that support versioning. Click on the `Install` or `Update` button on the asset tile, or click on the context menu button in the top right corner to install a different version. Learn more about [Custom Components](/lens-studio/features/scripting/script-components.md) and [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md).

[](/img/lens-studio/asset-library-custom-component.webm)

`Uninstall` the asset will remove it from `Project Installed Content` but asset will remain in the `Lens Studio Installed Content`. To remove the asset from Lens Studio find `Installed Content` in the Lens Studio Preferences. Learn more in the [Installed Content Preferences](/lens-studio/features/package-management/package-manager.md)

![](/assets/images/asset-library-scripts-and-packages-preference-be58c3df80bc58292864986d32b5e979.png)

The most relevant version of it could be added to the `Asset Browser` panel by clicking on the `+` button or directly in Scene Object inspector by clicking on `Add Component` Button.

[](/img/lens-studio/asset-library-add-custom-component.webm)

### Plugin[​**](#plugin "Copy to clipboard")

Plugins enable Lens Developers to extend the functionality of Lens Studio. You can manage the plugins in the Lens Studio Preferences. [Learn more about Plugins](/lens-studio/extending-lens-studio/plugins/overview.md). ![](/assets/images/asset-library-plugin-2c7a940640dd6697fbfa3cd18af2348b.png)

### LSO (Deprecated)[​**](#lso-deprecated "Copy to clipboard")

Some older assets may import as an `LSO`. In these cases, the asset will automatically be added into the `Scene Hierarchy` panel. This occurs more frequently when the asset requires different Cameras to achieve the effect.

### Asset Instructions[​**](#asset-instructions "Copy to clipboard")

Some assets may come with additional instructions on how to integrate it into your scene. In these cases, you might either have an image with instructions found in the `Asset Browser` panel, or a print out in the **Logger** panel with a link that you can go to.

You can open the image with instructions by using the viewer in the **Inspector** panel by clicking on the item in the `Asset Browser` panel. Alternatively, you can use another photo application installed on your computer.

![](/assets/images/asset-library_info-card-16b1cd63bd801945700a75d481e7634f.png)

Additional assets may require further setup once imported into your project. In these cases, you will see an object marked with `[DELETE_ME]` in the `Scene Hierarchy` panel, which you can right-click and delete once you've read it.

![](/assets/images/asset-library_delete_me_instruction-4c36d89f2989e0430da3aaf58e0a1c92.png)

If the asset utilizes cameras, take a look at the **Scene** Asset to further customize how the assets are used in your Lens. [Learn more about Cameras, Render Targets and Layers](/lens-studio/lens-studio-workflow/scene-set-up/camera.md)

![](/assets/images/asset-library_importing-5f36b2a2217c1537e1c6230b305984e9.png)

## Submitting Your Assets to the Asset Library[​**](#submitting-your-assets-to-the-asset-library "Copy to clipboard")

Are you interested in contributing your assets to the Asset Library? We welcome creative and useful submissions from our community directly through My Lenses. Please refer to [Asset Library Publishing Guide](/lens-studio/assets-pipeline/asset-library/asset-library-publishing-guide.md) to get started!
