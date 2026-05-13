# Selfie Attachments

Selfie Attachments lets you dream up any prop and see it magically placed on any person in a Snapchat Lens. From floating kittens to majestic Roman helmets, the only limit is your imagination. And you can choose whether your attachment appears as a static element or comes to life as an animated one.

[](/img/lens-studio/5-selfie-attachments/selfie-attach-0.webm) [](/img/lens-studio/5-selfie-attachments/selfie-attach-1.webm) [](/img/lens-studio/5-selfie-attachments/selfie-attach-2.webm) [](/img/lens-studio/5-selfie-attachments/selfie-attach-3.webm)

## Getting Started[​**](#getting-started "Copy to clipboard")

### Launching Selfie Attachments[​**](#launching-selfie-attachments "Copy to clipboard")

1. Navigate to the `Lens Studio AI` option in the top right corner of the Lens Studio. Then, click on the `GenAI Home Page` tab in the sidebar.

   ![](/img/lens-studio/5-selfie-attachments/sa-genai-suite-icon.png)

2. On the `GenAI Home Page` tab, you may need to scroll down to find Selfie Attachments.

   ![](/img/lens-studio/5-selfie-attachments/sa-genai-suite-menu.png)

### User Interface Overview[​**](#user-interface-overview "Copy to clipboard")

1. **Creation Panel:** Contains the input fields for a text prompt, image prompt, seed and animation prompt.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-5.png)

2. **Gallery:** Displays all Attachments you created and their Statuses.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-6.png)

3. **Search:** Search and Filter created Attachments.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-7.png)

### Creating new Attachment[​**](#creating-new-attachment "Copy to clipboard")

To create an animated attachment, add an animation description in the Animation Prompt field. Leave it blank if you want a static attachment.

Let’s walk through the process of creating an animated attachment.

1. Click the `Surprise me` button to try one of the default prompts and get familiar with the plugin.

   Generating the static attachment may take 5-10 minutes, but you can close the plugin and come back later.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-88.png)

2. If you are ready to use your own prompt, enter a description of the Attachment you’d like to generate in the "Attachments Prompt" text field. Use seed to reproduce experiments and control the randomness of generation.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-8.png)

3. UPDATE: The plugin now includes a **Styles** option. You can customize the look of your selfie attachments by selecting one of the available styles:

   * **Default:** A balanced and neutral result
   * **Cartoon:** A fun, stylized aesthetic
   * **Realistic:** More lifelike, high-fidelity outputs

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-styles.png)

4. Optionally, you can add an image input to guide the generation and make the result closer to your vision.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-89.png)

   At this stage, text prompts produce the highest-quality assets. We recommend using a text prompt as the foundation of your request and adding an image prompt only as a supplement.

5. To create an animated attachment, add an animation description to the "Animation Prompt" text field.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-anim-prompt.png)

6. When your prompt is ready, press the `Generate previews` button to generate the previews.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-9.png)

7. You will be presented with four previews of the future attachment. Select the one that best fits your needs and click the `Preview Animations` button when you are ready.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-10.png)

8. You will then see four new previews, each animated according to your animation prompt. Select the one that best fits your needs and click `Generate attachment` when you're ready.

   [](/img/lens-studio/5-selfie-attachments/selfie-attach-anim-preview.webm)

9. A new tile will appear in the Gallery with a loading indicator in the corner, showing the progress.

   Generating the animated attachment may take up to 2 hours, but you can close the plugin and come back later.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-tile.png)

10. When the animated attachment is ready, click its tile in the Gallery to review it.

If the preview doesn’t match your expectations, click `Change animation` to keep the same attachment and adjust only the animation.

If you want to modify all prompts, click `Change attachment` instead.

![](/img/lens-studio/5-selfie-attachments/selfie-attach-12.png)

11. You can always preview the static attachment by switching to the `Static` tab. If you decide not to use the animated version and want to import only the static attachment, uncheck `Include animation` and then click `Import to project`.

![](/img/lens-studio/5-selfie-attachments/selfie-attach-include.png)

12. When you’re satisfied with the animated attachment, click `Import to Project` to add the asset to your project.

    ![](/img/lens-studio/5-selfie-attachments/selfie-attach-import.png)

13. You can also animate any static attachments you previously created by clicking `Add animation` and entering an animation prompt.

    ![](/img/lens-studio/5-selfie-attachments/selfie-attach-animate-old.png)

14. After you click `Import to Project`, all necessary elements will be added to the Scene Hierarchy, including the component itself. The component provides the following options for configuring the animated attachment:

* **Start Events**—Defines one or more events that trigger the animation.

* **Delay**—Defines the delay time before the animation starts playing.

* **Playback Speed**—Defines how fast the animation plays relative to its original speed.

* **Loop Options**—Defines how the animation repeats, such as looping continuously or using a ping-pong motion.

* **Infinite Loop**—Defines whether the animation plays endlessly without stopping.

  ![](/img/lens-studio/5-selfie-attachments/selfie-attach-component.png)

15. [**Follow this guide**](/lens-studio/features/genai-suite/combining-gen-ai-components/selfie-attachments-and-more.md) to learn how to combine **Selfie Attachments with Style Generator, Head Generator and Zoom Component.**

### Pro tip #1: Adjusting the position of the Attachment[​**](#pro-tip-1-adjusting-the-position-of-the-attachment "Copy to clipboard")

Sometimes, the attachment might be slightly misaligned with the resulting person. In this case, select your attachment in Scene Hierarchy and slightly tune the transform params as shown below.

![](/img/lens-studio/5-selfie-attachments/selfie-attach-14.png)

### Pro Tip #2: Cleaning Up the Splats[​**](#pro-tip-2-cleaning-up-the-splats "Copy to clipboard")

Sometimes, the final attachment includes unwanted splats that clutter the asset. Luckily, you can clean them up manually. Here's a before/after example:

![](/img/lens-studio/5-selfie-attachments/selfie-attach-20.jpeg)

1. After generation, locate the splat (.ply) file in the `Asset Browser` tab. Move it somewhere convenient to access (for example, Desktop).

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-21.jpeg) ![](/img/lens-studio/5-selfie-attachments/selfie-attach-22.jpeg)

2. Open the Supersplat editor in your browser: <https://superspl.at/editor>. Drag and drop the .ply file into the canvas.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-23.jpeg)

3. In the right panel, enable `Splat Mode`.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-24.jpeg) ![](/img/lens-studio/5-selfie-attachments/selfie-attach-25.jpeg)

4. In the bottom panel, enable `Lasso Select` (or another selection tool). Select the splats to delete. Tip: rotate the asset for better visibility.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-26.jpeg) ![](/img/lens-studio/5-selfie-attachments/selfie-attach-27.jpeg)

5. Press `<Backspace>` or `Delete` to remove selected splats. Repeat until you're happy with the result.

6. Export the cleaned splat.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-29.jpeg) ![](/img/lens-studio/5-selfie-attachments/selfie-attach-30.jpeg)

7. Drag the cleaned splat back into your Lens Studio project (alongside the original .ply file). Update the `Asset` field in the `Gaussian Splatting` component.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-32.jpeg) ![](/img/lens-studio/5-selfie-attachments/selfie-attach-33.jpeg)

Done. You can repeat this flow to tidy up your splats as needed.

## Prompt Tips and Hacks[​**](#prompt-tips-and-hacks "Copy to clipboard")

A few approaches exist to write a prompt. Pick whichever style feels most natural to you.

### Prompt Styles[​**](#prompt-styles "Copy to clipboard")

1. **Instruction-based (Recommended)**

   Tell the tool exactly what to create and where to place it on the body. Think of it like giving directions to an artist. Examples:

   * "add a purple octopus with long tentacles sitting on top of my head"
   * "put a donut with sprinkles around my entire face like a face mask"
   * "place a shiny silver monocle over my right eye"

2. **Description-based**

   Just describe a person with the prop already there. It’s a bit more casual, but still works well. Examples:

   * "a person with a huge jello instead of a head"
   * "a person wearing a majestic Roman helmet with a red plume"
   * "a person with a giant hamburger stacked on their head"

3. **Vibe-based**

   Feeling playful? Describe your mood, theme, or aesthetic - let the tool surprise you. Examples:

   * "I love sea creatures - make something fun and tentacly"
   * "Give me festival energy. Colorful, loud, and wild."
   * "Something goofy that makes my head look like a dessert"

### Tips for Great Results[​**](#tips-for-great-results "Copy to clipboard")

1. **Be specific.** 1–3 sentences usually works best. Both examples below work well.

   * "a person wearing a yellow chef hat with colorful fruit and vegetable decorations"
   * "a person with a giant fish on the head has its mouth wide open and is eating the head. the upper jaw of the fish is on the head and the lower jaw of the fish is around the neck. the face of the person is inside the mouth."

2. **Describe placement precisely, if ambiguous.** Use terms like "on top of the head," "covering the face," or "resting on the shoulder."

3. **Avoid describing the person.** Don't include age, skin color, or personal traits - the tool focuses only on the attachment.

4. **Focus on supported body regions:** head, face, neck, and shoulders.

5. **One prop per generation works best.** Avoid stacking too many elements at once.

6. **Great results can take a few tries** - experiment with the seed and hit "regenerate" to explore new variations.

### Common Issues & Workarounds[​**](#common-issues--workarounds "Copy to clipboard")

1. **Misplaced props:** sometimes, props like animals may appear covering the whole head instead of sitting on top. To fix this, clarify in your prompt even further.

   ✅ "a person with a hamburger on top of the head. Bottom of the hamburger is positioned just above the forehead"

   ✅ "…the upper jaw of the fish is on the head and the lower jaw of the fish is around the neck"

2. **Unsupported features:**

   🚫 Transparent glasses, makeup, tattoos, and full-body wearables aren't supported.

   🚫 Items placed on hands, feet, or lower body will not render properly.

### More Creative Prompt Ideas[​**](#more-creative-prompt-ideas "Copy to clipboard")

* "add a golden crown floating slightly above my head, with glowing gems"
* "a person with a cluster of helium balloons lifting their head upward"
* "wrap a fluffy pink scarf loosely around the neck"
* "add a tiny UFO hovering just above my left eyebrow"
* "a person with spaghetti noodles draped over their face like a curtain"

***

**Now it's your turn - get weird, get wild, get wearable. And remember, a great prop starts with a great prompt.**
