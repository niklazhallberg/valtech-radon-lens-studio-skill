# Head Generator

[](/img/lens-studio/5-platform-solutions/head-gen-v3-visuals.webm)

Head Generator is a powerful tool for generating and customizing 3D heads for creating Lenses. It uses AI to generate a 3D head, which can then be driven by facial expressions, similar to [Face Morph](/lens-studio/features/ar-tracking/face/face-templates/face-morph.md).

This guide will walk you through all the features and provide tips and hacks for getting the most out of your 3D head creations.

## Getting Started[​**](#getting-started "Copy to clipboard")

### Launching Head Generator[​**](#launching-head-generator "Copy to clipboard")

1. Navigate to the `Lens Studio AI` option in the top right corner of the Lens Studio. Then, click on the `GenAI Home Page` tab in the sidebar.

   ![](/img/lens-studio/5-head-generator/head-gen-genai-suite-icon.png)

2. On the `GenAI Home Page` tab, you may need to scroll down to find Head Generator.

   ![](/img/lens-studio/5-head-generator/head-gen-genai-suite-menu.png)

### User Interface Overview[​**](#user-interface-overview "Copy to clipboard")

1. **Creation Panel:** Provides tools for creating and editing 3D Heads.

   ![](/img/lens-studio/5-head-generator/head-gen-creation-panel.png)

2. **Gallery:** Shows all the assets you’ve created along with their statuses.

   ![](/img/lens-studio/5-head-generator/head-gen-gallery.png)

3. **Search:** Allows you to search through the 3D Heads you’ve created.

   ![](/img/lens-studio/5-head-generator/head-gen-search.png)

## Asset Creation flow[​**](#asset-creation-flow "Copy to clipboard")

1. Enter a text description of the 3D Head you want to generate. You can use the `Surprise Me` button to insert one of the default prompts and get familiar with the creation flow.

   The plugin currently does not support using text and image prompts at the same time.

   ![](/img/lens-studio/5-head-generator/head-gen-text-prompt.png)

2. If you have an image of the desired 3D head, switch to the `Image Reference` tab to upload your image prompt.

   At this stage, `Image Reference` produces the highest-quality assets. We recommend using an image reference to achieve results that match your desired look as closely as possible.

   ![](/img/lens-studio/5-head-generator/head-gen-image-prompt.png)

3. When your prompt is ready, press the `Generate previews` button to generate the previews.

   ![](/img/lens-studio/5-head-generator/head-gen-generate.png)

4. You will be presented with four previews of the future 3D head. If the previews don’t match your expectations, click `Regenerate` to get four new options.

   ![](/img/lens-studio/5-head-generator/head-gen-regenerate.png)

5. When you’re satisfied with the preview, select one and click `Generate asset`.

   ![](/img/lens-studio/5-head-generator/head-four-previews.png)

6. A new tile will appear in the Gallery with a loading indicator in the corner, showing the progress.

   Generating the asset may take up to 1 hour, but you can close the plugin and return later.

   ![](/img/lens-studio/5-head-generator/head-gen-queue.png)

7. Once the 3D Head has been generated, you will see the completed preview in the Gallery. Click on it to open the asset in detail view. If the asset doesn’t match your expectations, click `Copy settings` to adjust your prompt. Your original asset will remain in the Gallery, and a new entity will be created.

   ![](/img/lens-studio/5-head-generator/head-gen-copy-settings.png)

8. If the result matches your expectations, click `Import to Project` to bring the 3D Head into your project and continue building your Lens.

   ![](/img/lens-studio/5-head-generator/head-gen-import.png)

9. The component will be added to the Scene Hierarchy, and you will see a preview of the 3D head applied to the model.

   If the asset appears misaligned with the person’s head, you can adjust its position by modifying the transform coordinates to ensure a proper fit.

   [](/img/lens-studio/5-head-generator/head-gen-position.webm)

10. Take a look at the [Pairing to Snapchat guide](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) to test your Lens on device, and the [Publishing guide](/lens-studio/publishing/submitting/submitting-your-lens.md) to learn more about sharing your creation.

11. [**Follow this guide**](/lens-studio/features/genai-suite/combining-gen-ai-components/selfie-attachments-and-more.md) to learn how to combine **Head Generator with Style Generator, Selfie Attachments and Zoom Component.**

## Prompt Tips and Hacks[​**](#prompt-tips-and-hacks "Copy to clipboard")

This plugin generates high quality human and non-human subjects, such as animals, creatures, objects, or stylized characters.

### Words and Phrases[​**](#words-and-phrases "Copy to clipboard")

* **Context Words and Phrases**: It is best to divide long sentence descriptions into context phrases of 2-3 words separated by a comma symbol.

  <!-- -->

  * **Works best**: 1 human head, big sunglasses, red curly hair, realistic portrait, green lizard skin, good quality, highres, hipoly model, snake teeth, opened mouth
  * **Works worse**: Human that have green lizard skin and red curly hair wears big sunglasses he also has white snake teeth his mouth is opened also make it high quality 3D hipoly model

### Descriptors[​**](#descriptors "Copy to clipboard")

* **Character**: Mention the character you want to create.
  <!-- -->
  * Example: rhino, medieval king, clown, alien, samurai, robot, baby penguin
* **Features**: Mention face and head features that you want to emphasize.
  <!-- -->
  * Example: horn, fur, spiky hair, huge nose, big eyes, elf ears, facial tattoo, snake teeth, opened mouth
* **Details**: Add descriptors for accessories and special details.
  <!-- -->
  * Example: wig, crown, plague mask, wizard hat, pilot helmet, glasses
* **Emotions**: Mention emotions if needed.
  <!-- -->
  * Example: smiling, angry, cute, excited, sad, scared
* **Style**: Mention style if needed.
  <!-- -->
  * Example: realistic, cartoon, steampunk, anime, retro, minimalistic
* **Color**: While using color words can provide more control, too many color phrases can cause visual dismiss issues.

### Special words[​**](#special-words "Copy to clipboard")

* **High-poly**: To increase the level of detail.
* **3D printed**: For geometric models with minimal overhangs.
* **Anatomy**: For detailed human or animal models.
* **Hyper-realistic**: To increase the realistic natural effect.
* **Biomorphic**: To create smooth abstract shapes.

### Order of Words[​**](#order-of-words "Copy to clipboard")

* **Weight of words**: The words at the start of your prompt have the most influence and should fully reflect the concept.

  <!-- -->

  * **Works best**: 1 human head, big sunglasses, red curly hair, realistic portrait, green lizard skin, good quality, highres, hi poly model, snake teeth, opened mouth
  * **Doesn’t work as well**: highres, hi-poly, good quality 3D model, snake teeth, green lizard skin, curls, red hair, human head
