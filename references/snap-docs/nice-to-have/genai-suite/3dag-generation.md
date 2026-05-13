# 3D Asset Generation

3D Asset Generation is a tool for generating and customizing 3D assets for creating Lenses. This guide will walk you through all the features and provide tips and hacks for getting the most out of your 3D assets creations.

## Getting Started[​**](#getting-started "Copy to clipboard")

### Launching 3D Asset Generation[​**](#launching-3d-asset-generation "Copy to clipboard")

1. Navigate to the `GenAI Home Page` using the `Lens Studio AI` option in the top right corner of the Lens Studio.

   ![](/img/lens-studio/5-platform-solutions/3dag-genai-button.png)

2. On the GenAI Home Page, you may need to scroll down to find the menu of GenAI tools. In the panel, select 3D Asset.

   ![](/img/lens-studio/5-platform-solutions/genai-suite-menu-3D-asset.png)

### User Interface Overview[​**](#user-interface-overview "Copy to clipboard")

* **Create new Asset Toolbar:** Contains tools for creating and editing Models:

  ![](/img/lens-studio/5-platform-solutions/3dag-23.png)

* **Gallery:** Displays all Assets you created and their Statuses.

  ![](/img/lens-studio/5-platform-solutions/3dag-20.png)

* **Search:** Search through the created assets.

  ![](/img/lens-studio/5-platform-solutions/3dag-2.png) ![](/img/lens-studio/5-platform-solutions/3dag-18.png)

## Creating a 3D Asset[​**](#creating-a-3d-asset "Copy to clipboard")

### Text Prompt[​**](#text-prompt "Copy to clipboard")

* **Input your own text prompt:** Provide a text description of the asset that you're looking to create.

* **Use the `Surprise me` feature:** Tap `Surprise me` to use a random prompt.

  ![](/img/lens-studio/5-platform-solutions/3dag-1.png)

### Image Prompt[​**](#image-prompt "Copy to clipboard")

* **Input your own image:** Upload the image from your computer. Please note that the prompt is still necessary even if the image is added.

  ![](/img/lens-studio/5-platform-solutions/3dag-24.png)

### Other settings Prompt[​**](#other-settings-prompt "Copy to clipboard")

* **Negative prompt:** Describe what you want to exclude from generation.

  ![](/img/lens-studio/5-platform-solutions/3dag-5.png)

### Preview of the Asset[​**](#preview-of-the-asset "Copy to clipboard")

* You will be presented with four previews of the future asset. Select the one that best fits your needs and click `Generate Asset` when you are ready.

  ![](/img/lens-studio/5-platform-solutions/3dag-12.png)

* **Regenerate:** You can edit and regenerate the previews.

  ![](/img/lens-studio/5-platform-solutions/3dag-10.png)

### Generation[​**](#generation "Copy to clipboard")

* Press `Generate Asset` when you are ready.

  ![](/img/lens-studio/5-platform-solutions/3dag-26.png)

* Check upon the Status bar for info.

  ![](/img/lens-studio/5-platform-solutions/3dag-9.png)

## 3D Asset Generation Preview and Editing[​**](#3d-asset-generation-preview-and-editing "Copy to clipboard")

![](/img/lens-studio/5-platform-solutions/3dag-21.png)

### Change Geometry and Texture[​**](#change-geometry-and-texture "Copy to clipboard")

* You can adjust the asset by changing Geometry or Texture. Add more details to the prompt field, add images or adjust other settings.
* Press `Update Asset` and wait for the result. The new effect will be created and displayed in the Gallery view.

![](/img/lens-studio/5-platform-solutions/3dag-17.png)

### Delete 3D Asset[​**](#delete-3d-asset "Copy to clipboard")

* You can also delete the asset

![](/img/lens-studio/5-platform-solutions/3dag-15.png)

## Create a Lens[​**](#create-a-lens "Copy to clipboard")

### Import to Project[​**](#import-to-project "Copy to clipboard")

* Press `Import to Project` button to start creating a Lens with your 3D asset.

  ![](/img/lens-studio/5-platform-solutions/3dag-3.png)

* Select the quality of your 3D asset, keeping the asset size in mind. Higher quality downloads have higher polycounts and texture sizes, but also larger asset sizes.

  ![](/img/lens-studio/5-platform-solutions/3dag-25.png)

### Result[​**](#result "Copy to clipboard")

Save and Export Your Lens:

* Once satisfied with the result, save your project and export the Lens for testing on Snapchat.

## Prompt Tips and Hacks[​**](#prompt-tips-and-hacks "Copy to clipboard")

### Text Prompt[​**](#text-prompt-1 "Copy to clipboard")

1. **Avoid too many details**<br /><!-- -->Be descriptive about your asset's main properties (main color or attributes you wish your asset to have). However, try to keep it simple.

   * **✅Good:** dragon with emerald green scales, large wings, fiery eyes
   * **👎Bad:** dragon, deep emerald green scales with subtle blue undertones, massive wings spanning twenty feet with intricate vein patterns, fiery eyes glowing with a detailed fiery texture, sharp claws detailed with worn edges

2. **Use comma-separated phrases, not sentences**<br /><!-- -->It is best to divide long sentence descriptions into context phrases of 2-3 words separated by a comma symbol.

   * **✅Good:** unicorn, white fur, spiraled horn, golden hooves, highres
   * **👎Bad:** Create a unicorn with white fur, a spiraled horn, and golden hooves; ensure it's a high-quality, high-resolution, high-polygon model

3. **Don't use “a 3d model of…” or alternatives**<br /><!-- -->Don't specify the wording mentioning explicitly that you want a 3d model - this might result in less detailed generations.

   * **✅Good:** a playful corgi dog
   * **👎Bad:** a playful corgi dog as a 3d model

4. **Describe the object, not the scene**<br /><!-- -->Current version of the tool does not support 3D scene reconstruction - it will only generate a single 3D model.

   * **✅Good:** an american eagle statue, high quality
   * **👎Bad:** an american eagle flying in an empty forest, high quality statue

5. **The words at the start of your prompt have the most influence and should fully reflect the concept.**

   * **✅Good:** big sunglasses, green good quality, highres,
   * **👎Bad:** highres, hi-poly, good quality, 3d model, sunglasses

### Image Prompt[​**](#image-prompt-1 "Copy to clipboard")

1. **Use mostly squared image**<br /><!-- -->Expect your image to be center-cropped, so it's best to use almost-squared images not to lose important context.

   ![](/assets/images/3dag-19-32ee6ee4a1e1416f70bf657e6bdb6877.jpg)

2. **Make sure there is a single, easily distinguishable object on your image**<br /><!-- -->Our tool will reconstruct a single 3D asset. Therefore for the best result make sure that the following requirements are satisfied:

   * There is a single object present on an image (no multi-objects/environments)
   * The object is clearly separable from the background
   * No people are present in the shot
   * The object is position in full body (e.g. not truncated)

   **✅Good:**

   ![](/img/lens-studio/5-platform-solutions/3dag-16.png) ![](/img/lens-studio/5-platform-solutions/3dag-8.jpg)

   **👎Bad:**

   ![](/img/lens-studio/5-platform-solutions/3dag-13.png) ![](/img/lens-studio/5-platform-solutions/3dag-7.png) ![](/img/lens-studio/5-platform-solutions/3dag-27.png) ![](/img/lens-studio/5-platform-solutions/3dag-6.png)

3. **Use prompts “Best Practices” to write a matching prompt**<br /><!-- -->Currently, the prompt is also used when the image is present. Make sure that you write a good matching prompt using the recommendations above.
