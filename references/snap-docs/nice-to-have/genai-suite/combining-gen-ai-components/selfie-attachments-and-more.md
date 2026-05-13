# Combining Style Generator with Animated Selfie Attachments, Head Generator and Zoom Component

### Introduction[​**](#introduction "Copy to clipboard")

In this tutorial, you’ll learn how to build a more advanced Lens by combining GenAI-powered components from the [Style Generator plugin](/lens-studio/features/genai-suite/style-generator.md), [Animated Selfie Attachments plugin](/lens-studio/features/genai-suite/selfie-attachments.md), and [Head Generator plugin](/lens-studio/features/genai-suite/head-morph-generation.md), along with a [Zoom Component](/lens-studio/examples/components/zoom-component.md) triggered by the `Open Mouth` event.

The main principle is to render each effect into its own separate Render Target and then use that Render Target as the input for the next effect and its camera (in this tutorial, the first two effects share the same Render Target to optimize the Lens’s technical performance). If you’d like to refresh your knowledge before diving into the tutorial, refer to the [Camera documentation](/lens-studio/lens-studio-workflow/scene-set-up/camera.md).

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-final-result.webm)

You can watch the video tutorial for a guided overview, or continue with the detailed step-by-step guide below.

### Step 1: Import Effects[​**](#step-1-import-effects "Copy to clipboard")

1.1. Navigate to the `Lens Studio AI` option in the top right corner of the Lens Studio. Then, click on the `GenAI Home Page` tab in the sidebar.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-ls-ai.png)

1.2. In the `GenAI Home Page` tab, locate the plugins we’ll be using.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-all-plugins.png)

1.3. Open the [Style Generator plugin](/lens-studio/features/genai-suite/style-generator.md) and import a generated effect into your project. If you don’t have any generated effects yet, refer to the [Style Generator](/lens-studio/features/genai-suite/style-generator.md) web page to learn how to create one.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-style-gen.png)

1.4. In the `GenAI Home Page`, find the [Selfie Attachments](/lens-studio/features/genai-suite/selfie-attachments.md) and import a generated effect into your project.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-selfie-attach.png)

1.5. In the `GenAI Home Page`, find the [Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) and import a generated effect into your project.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-head-gen.png)

### Step 2: Combine Components[​**](#step-2-combine-components "Copy to clipboard")

2.1. Next, separate the [Selfie Attachments](/lens-studio/features/genai-suite/selfie-attachments.md) and [Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) effects into two different cameras. You can duplicate the existing camera that contains both effects, then remove the unnecessary duplicated scene objects. Start by renaming the original camera to `Camera 3D 1`.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-6.webm)

2.2. Right-click `Camera 3D 1` and select `Duplicate`. This creates `Camera 3D 2`, which contains the same effects as the original camera.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-7.webm)

2.3. Create a new Render Layer for `Camera 3D 2`.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-8.webm)

2.4. Assign this new render layer to `Camera 3D 2`. Note that the layer must be reassigned in two places: in the top-right dropdown and in the Layers field.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-9.webm)

2.5. Set the Render Order to `1`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-10.png)

2.6. Create a new Render Target.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-11.webm)

2.7. In the `Scene` settings, set this `Render Target 2` as both the `Capture Target` and `Live Target`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-12.png)

2.8. Select the Orthographic Camera and set its Render Order to `2`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-13.png)

2.9. In the Scene Hierarchy, locate the [Style Generator](/lens-studio/features/genai-suite/style-generator.md) object. In the Inspector, replace the `Input Texture` with the `Render Target`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-14.png)

2.10. Remove the duplicate [Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) from `Camera 3D 1`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-15.png)

2.11. Remove the duplicate [Selfie Attachments](/lens-studio/features/genai-suite/selfie-attachments.md) from `Camera 3D 2`. Now, [Selfie Attachments](/lens-studio/features/genai-suite/selfie-attachments.md) should remain in `Camera 3D 1`, and [Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) should remain in `Camera 3D 2`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-16.png)

2.12. In the Scene Hierarchy, select the [Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) effect. In the Inspector, assign the render layer used by `Camera 3D 2`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-17.png)

2.13. In the Asset Browser, select `Render Target 2`. Under `Clear Color Option`, choose `Texture`, then set the `Input Texture` to the original `Render Target`.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-18.webm)

2.14. Select the Orthographic Camera and set its Render Target to `Render Target 2`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-19.png)

2.15. Let's review the setup. Select `Scene` in the Asset Browser, then examine your project configuration in the Inspector.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-20.png)

As shown in the configuration:

* The cameras containing **Selfie Attachments** and **Head Generator** render into the `Render Target`.
* The Orthographic Camera renders `Render Target 2`. Because the original `Render Target` is assigned as the Input Texture of `Render Target 2` (configured in #2.13), the Orthographic Camera can "see" the previously rendered effects and apply the **Style Generator** effect on top.
* The Render Orders are set sequentially.
* `Render Target 2` is assigned as both the `Capture Target` and `Live Target` (configured in #2.7), ensuring that all effects are visible in the Preview panel.

2.16. Click the `Reset` button to ensure the Preview reflects the correct result after applying all the changes made in the previous steps.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-21.png)

2.17. Adjust the scale of the [Head Generator](/lens-studio/features/genai-suite/head-morph-generation.md) effect as needed to properly align it with the user’s head and your overall Lens design.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-22.png)

### Step 3: Add a [Zoom](/lens-studio/examples/components/zoom-component.md) Effect[​**](#step-3-add-a-zoom-effect "Copy to clipboard")

3.1. Open the **Asset Library**, search for [Zoom Component](/lens-studio/examples/components/zoom-component.md), and click `Install`. The component will appear in both the Asset Browser and the Scene Hierarchy.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-23_1.png) ![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-23_2.png)

3.2. Drag the [Zoom](/lens-studio/examples/components/zoom-component.md) into the Orthographic Camera.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-24.webm)

3.3. Set its Render Order to `10` to ensure it renders above the other effects.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-25.png)

3.4. Assign it to the `Orthographic` render layer (since it is inside the Orthographic Camera).

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-26.png)

3.5. Set `Start Events` to `Mouth Opened`.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-27.png)

3.6. Adjust the `Duration`, `Delay` and other settings according to your preference.

![](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-28.png)

3.7. Preview your Lens to test the final result. If necessary, restart the project to ensure all changes are applied correctly.

[](/img/lens-studio/5-tutorial-selfie-attachments/tut-sa-29.webm)

### Summary[​**](#summary "Copy to clipboard")

Your Lens is now complete and ready to be tested on a device.

In this tutorial, you learned that successfully combining multiple components requires a clear understanding of how cameras work, how Render Layers are configured, and most importantly - how Render Targets enable one camera to access and "see" the output of another.

To learn more about Render Targets, Render Layers, and camera configuration, see the [Camera documentation](/lens-studio/lens-studio-workflow/scene-set-up/camera.md).
