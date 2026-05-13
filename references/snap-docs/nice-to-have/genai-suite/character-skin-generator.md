# Character Skin Generator

Character Skin Generator plugin enables the creation of lenses powered by ML models that transform users into full-body digital characters with pixel-level accuracy.

[](/img/lens-studio/5-character-skin-generator/csg-example-0.webm) [](/img/lens-studio/5-character-skin-generator/csg-example-1.webm) [](/img/lens-studio/5-character-skin-generator/csg-example-2.webm)

## Getting Started[​**](#getting-started "Copy to clipboard")

### Launching Skin Generator[​**](#launching-skin-generator "Copy to clipboard")

1. Navigate to the `Lens Studio AI` option in the top right corner of the Lens Studio. Then, click on the `GenAI Home Page` tab in the sidebar.

   ![](/img/lens-studio/5-character-skin-generator/csg-lens-studio-ai.png)

2. On the `GenAI Home Page` tab, you may need to scroll down to find Character Skin Generator.

   ![](/img/lens-studio/5-character-skin-generator/csg-tile.png)

### User Interface Overview[​**](#user-interface-overview "Copy to clipboard")

1. **Creation Panel:** Provides an input field for the image prompt.

   ![](/img/lens-studio/5-character-skin-generator/csg-creation-panel.png)

2. **Gallery:** Displays all created effects along with their statuses.

   ![](/img/lens-studio/5-character-skin-generator/csg-gallery.png)

3. **Status Bar:** Shows information about recent actions and system feedback.

   ![](/img/lens-studio/5-character-skin-generator/csg-status.png)

## Creating a New Effect[​**](#creating-a-new-effect "Copy to clipboard")

1. Upload the Image Reference you want to use for your effect creation.

   See the [**Best Practices**](#best-practices) guide to learn how to achieve the best results.

   ![](/img/lens-studio/5-character-skin-generator/csg-image-prompt.png)

2. Select the `Non-humanoid anatomy` checkbox if your reference image shows a character or object without a human-like body structure (for example, a banana, cactus, snowman, or other non-humanoid shapes).

   ![](/img/lens-studio/5-character-skin-generator/csg-non-humanoid.png)

3. When your prompt is ready, click `Generate previews` to generate the previews.

   ![](/img/lens-studio/5-character-skin-generator/csg-previews.png)

4. A new tile will appear in the Gallery with a loading indicator in the corner, showing the progress. A corresponding message is also displayed in the Status Bar at the bottom.

   Preview generation may take up to 5 minutes. You can close the plugin and return later.

   ![](/img/lens-studio/5-character-skin-generator/csg-preview-generation.png)

5. Once the preview has been generated, you can click its tile in the Gallery to open the details page. Here, you can use the arrows on the sides to preview the effect on different models. Additionally, you can click the button in the bottom-right corner to view the original image the effect was applied to.

   ![](/img/lens-studio/5-character-skin-generator/csg-details-page.png)

6. Happy with the preview? Great! Click `Train model` to start training your model. You’ll be able to track the training status directly in the Gallery.

   Training the model may take 8-12 hours. You can close the plugin and return later.

   ![](/img/lens-studio/5-character-skin-generator/csg-train.png)

7. Once training is complete, you can import the effect directly from the Gallery by clicking the `Import` button, or click `Import to project` on the details page to add it to your project.

   ![](/img/lens-studio/5-character-skin-generator/csg-import.png)

8. When you’re satisfied with the result, save your project and push the Lens for testing on Snapchat. See the [Pairing to Snapchat guide](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) to test your Lens on a device, and the [Publishing guide](/lens-studio/publishing/submitting/submitting-your-lens.md) to learn more about sharing your creation.

   [](/img/lens-studio/5-character-skin-generator/csg-result.webm)

## Best Practices[​**](#best-practices "Copy to clipboard")

### Image Reference Recommendations[​**](#image-reference-recommendations "Copy to clipboard")

You can use any image, but for best results, upload an Image Reference that meets the following criteria:

* High-quality image (at least 720px tall);
* Plain, high-contrast background;
* Front-facing orientation of the object;
* Larger head with clear, human facial features;
* Simple textures;
* No protruding elements;
* Full body visible (head to toe);
* Human-like body shape in an A-pose or T-pose

| Ideal Image Reference                                                      |                                                                          |                                                                            |
| -------------------------------------------------------------------------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-good-ref-sceleton.png) | ![](/img/lens-studio/5-character-skin-generator/csg-good-ref-ginger.png) | ![](/img/lens-studio/5-character-skin-generator/csg-good-ref-cucumber.png) |

| Good Image Reference                                                 |                                                                          |                                                                      |
| -------------------------------------------------------------------- | ------------------------------------------------------------------------ | -------------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-ok-ref-gift.png) | ![](/img/lens-studio/5-character-skin-generator/csg-ok-ref-broccoli.png) | ![](/img/lens-studio/5-character-skin-generator/csg-ok-ref-tree.png) |

| Poor Image Reference                                                  |                                                                         |                                                                           |
| --------------------------------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-bad-ref-deer.png) | ![](/img/lens-studio/5-character-skin-generator/csg-bad-ref-ginger.png) | ![](/img/lens-studio/5-character-skin-generator/csg-bad-red-cucumber.png) |

### Figure Crop[​**](#figure-crop "Copy to clipboard")

The tool automatically crops the uploaded image to focus on the human figure and key control points, including the head, arms, and legs. Accurate cropping helps ensure higher-quality model generation.

![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-1.png) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-2.png) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-3.png) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-4.jpg) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-5.jpg) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-6.jpg) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-7.png) ![](/img/lens-studio/5-character-skin-generator/csg-figure-crop-8.jpg)

### Background Contrast[​**](#background-contrast "Copy to clipboard")

For best results, upload an image with a solid background that clearly contrasts with the character’s colors. Low-contrast images may cause visual artifacts, such as a glow along the figure’s outline or incorrect figure detection.

In the example below, the generation boundary captures part of the background from the reference image:

| Low contrast reference                                              | Result                                                              |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-contrast-3.png) | ![](/img/lens-studio/5-character-skin-generator/csg-contrast-2.png) |

Increasing contrast and clearly separating the subject from the background improves figure recognition and overall output quality:

| High contrast reference                                             | Result                                                              |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-contrast-1.png) | ![](/img/lens-studio/5-character-skin-generator/csg-contrast-4.png) |

### Background Color[​**](#background-color "Copy to clipboard")

Recommended background options include white, black, or a transparent PNG. When using an image reference, the tool transfers colors and textures directly from the uploaded image. If the source image is dark, the resulting model will also appear dark. You can improve results by adjusting brightness and saturation before uploading.

| Dark image reference                                             | Result                                                           |
| ---------------------------------------------------------------- | ---------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-color-1.png) | ![](/img/lens-studio/5-character-skin-generator/csg-color-2.png) |

Lighting is also transferred. In the example below, side lighting from the reference image is reflected in the generated ML model.

| Image reference with side lighting                               | Result                                                           |
| ---------------------------------------------------------------- | ---------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-color-3.png) | ![](/img/lens-studio/5-character-skin-generator/csg-color-4.png) |

### Image References with Faces[​**](#image-references-with-faces "Copy to clipboard")

If your reference image includes a realistic face, it will be transferred to the model:

| Realistic face                                                  | Result                                                          |
| --------------------------------------------------------------- | --------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-face-1.png) | ![](/img/lens-studio/5-character-skin-generator/csg-face-2.png) |

However, realistic faces generally produce lower-quality results compared to stylized or hand-drawn faces:

| Realistic face                                                  | Result                                                          |
| --------------------------------------------------------------- | --------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-face-3.png) | ![](/img/lens-studio/5-character-skin-generator/csg-face-4.png) |

| Hand-drawn face                                                 | Result                                                          |
| --------------------------------------------------------------- | --------------------------------------------------------------- |
| ![](/img/lens-studio/5-character-skin-generator/csg-face-5.png) | ![](/img/lens-studio/5-character-skin-generator/csg-face-6.png) |

### Image References with Heads[​**](#image-references-with-heads "Copy to clipboard")

Head size in the reference image affects facial quality:

* Images with very small heads tend to produce lower-quality facial transfers.
* Using a reference with a larger head helps the tool better calculate and transfer facial features.

As a result, facial detail and overall quality in the final render are typically higher when the head is more prominent in the reference image. Experiment with different references to achieve the best outcome.

Ideal Heads:

![](/img/lens-studio/5-character-skin-generator/csg-head-size-1.png) ![](/img/lens-studio/5-character-skin-generator/csg-head-size-2.png) ![](/img/lens-studio/5-character-skin-generator/csg-head-size-3.png)

### Supported Content[​**](#supported-content "Copy to clipboard")

The technology performs best when creating ML models for:

* 2D characters with clear shapes;
* Stylized humanoid characters;
* Simple 3D styles;
* Objects with simplified textures.

### Unsupported Content[​**](#unsupported-content "Copy to clipboard")

The technology does not support:

* Accessories or objects attached to hands (these may be cropped);
* Objects with elements extending beyond the human body silhouette (for example, deer antlers or objects above the head).
