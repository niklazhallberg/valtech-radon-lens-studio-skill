# AI Enabled Components Tutorial

This tutorial will cover how you can use your own custom components within Easy Lens, connect them to the content generators, and integrate it into the Lens Studio AI's compositing, allowing end users to download them and add them to their own Lens with ease!

You can learn more about the underlying concept in the [AI Enabled Custom Component](/lens-studio/features/lens-studio-ai/ai-custom-components.md) guide.

If you'd like to create your own custom component in Lens Studio, you can see [this guide](https://developers.snap.com/lens-studio/features/scripting/script-components), or download the [examples](https://github.com/Snapchat/lens-studio-custom-component) in the repository.

You may also refer to AI Enabled Custom Components as Blocks, which is shorter :). Nevertheless, the both refer to a [Custom Components](/lens-studio/features/scripting/script-components.md) with additional metadata for AI attached to it.

| Make a Lens that drops hearts                     | Make a Lens that drops rocks                     | Make a Lens that dropped beach ball              |
| ------------------------------------------------- | ------------------------------------------------ | ------------------------------------------------ |
| [](/img/lens-studio/5-features/aicc-image11.webm) | [](/img/lens-studio/5-features/aicc-image5.webm) | [](/img/lens-studio/5-features/aicc-image6.webm) |

### Taking a look at the existing component[​**](#taking-a-look-at-the-existing-component "Copy to clipboard")

1. Let's download the component from the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) select *unpack to edit* in the asset menu to view the markdown file.

   [](/img/lens-studio/5-features/aicc-image19.webm)

2. Let's open the first folder and double click the "AiMetadata" markdown file.

   ![](/img/lens-studio/5-features/aicc-image7.png) ![](/img/lens-studio/5-features/aicc-image26.png)

   It contains descriptions of each parameter of the custom component as well as its functions and its relationship to the 3D Object asset provider.

3. We can open Lens Studio AI and ask for a lens using this Falling 3D Object component.

   [](/img/lens-studio/5-features/aicc-image24.webm)

   Lens Studio AI can automatically add it to a composition of different components.

### Modifying and/or removing the installed custom component[​**](#modifying-andor-removing-the-installed-custom-component "Copy to clipboard")

1. Once the custom component is in your [local library](/lens-studio/features/package-management/package-library-management.md), you can remove it through the lens studio [package manager](https://developers.snap.com/lens-studio/features/package-management/package-manager?lang=en-US).

   ![](/img/lens-studio/5-features/aicc-image25.png) ![](/img/lens-studio/5-features/aicc-image18.png)

   You can also modify the custom component or metadata file. Let's return to our original project and add a `randomizeStartingRotation` parameter to the AiMetadata file, so that the LensStudio AI knows that it can randomize the starting rotation of the 3D objects.

   [](/img/lens-studio/5-features/aicc-image16.webm)

   ```
   ### randomizeStartingRotation

   - **Description:** Determines whether each 3D object begins with a random rotation.
   - **Type:** boolean
   - **Default:** true
   ```

2. Now you have to re-register it to your local library to update it.

   ![](/img/lens-studio/5-features/aicc-image1.png)

3. Start a new conversation asking for the objects to fall with a randomized rotation to see these changes reflected.

4. We can now generate 3D objects starting at random rotations!

   [](/img/lens-studio/5-features/aicc-image14.webm)

You can now use this component in your EasyLens prompts, enabling a diverse range of creative outcomes!

Every time you push to the library, the Custom Component will increment itself. If you don't save your project after pushing and re-open your project later, you will be asked to pull from the library (since the library now has a newer version than what's in your Asset Browser).

Instead of pulling, we recommend you uninstall the component from the library, so that it will match the same version as inside your Asset Browser!

## Additional Examples[​**](#additional-examples "Copy to clipboard")

You can find additional examples of AI Enabled Custom Components in the Asset Library or in the public repository.

There are several examples to help you get started, including:

* **Debug All Types:** An example that demonstrates using all the generators Lens Studio AI provides
* **AI Enabled Meme Text:** An example that demonstrates how you can respond to changes to @input using setters/getters, and using Coding Notes to guide AI to generate controllers that modify the component.
* **Score on Head:** An example of exposing some functions that can be called by another component (e.g. Bounce Object on Head)
* **Bounce Object On Head:** A more complex demo which demonstrates exposing events that Lens Controller can stitch up with another component, as well as using a 3D object asset generator.

You can also download the examples in the [repository](https://github.com/Snapchat/lens-studio-custom-component).
