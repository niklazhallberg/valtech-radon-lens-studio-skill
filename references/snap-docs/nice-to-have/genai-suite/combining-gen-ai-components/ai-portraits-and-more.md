# Combining AI Portraits with Custom Transition, Face Generator, Post Effects, Color Correction and Body Parallax

### Introduction[​**](#introduction "Copy to clipboard")

In this tutorial, you’ll learn how to build a more advanced Lens by combining GenAI-powered components with traditional Lens Studio effects. We’ll start with [AI Portraits](/lens-studio/features/genai-suite/ai-portraits.md) as the core generation component, then enhance the result by customizing **transition**, applying **post effect**, adding the [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md), and introducing depth and motion using [Body Parallax](/lens-studio/examples/components/body-parallax-component.md).

By the end of this guide, you’ll have a fully polished Lens that demonstrates how multiple AI and non-AI components can work together in a single, cohesive workflow.

[](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-final-result.webm)

You can watch the video tutorial for a guided overview, or continue with the detailed step-by-step guide below.

### Step 1: Add [AI Portraits](/lens-studio/features/genai-suite/ai-portraits.md) to your Lens Studio project[​**](#step-1-add-ai-portraits-to-your-lens-studio-project "Copy to clipboard")

1.1. Navigate to the `Lens Studio AI` option in the top right corner of the Lens Studio. Then, click on the `GenAI Home Page` tab in the sidebar.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-ls-ai.png)

1.2. On the `GenAI Home Page` tab, you may need to scroll down to find [AI Portraits](/lens-studio/features/genai-suite/ai-portraits.md).

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-tile.png)

1.3. Generate an effect using text prompts, or select an existing one from the Gallery.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-plugin.png)

1.4. Once you click `Import`, the component is automatically added to your project and is ready for use.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-plugin-component.png)

1.5. A tap on the **Preview** window triggers the generation process, and the result appears using the default transition.

[](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-preview.webm)

1.6. If no further customization is needed, your Lens is already ready for publication. If you’d like to replace the transition and add post effects, continue with the next steps.

### Step 2: Replacing the transition using the [Transitions Library](/lens-studio/extending-lens-studio/plugins/transitions-library.md)[​**](#step-2-replacing-the-transition-using-the-transitions-library "Copy to clipboard")

2.1. The **AI Portraits** component allows you to replace the default transition.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-change-transition.png)

2.2. Open the [Transitions Library](/lens-studio/extending-lens-studio/plugins/transitions-library.md) and choose a transition. Import it into your project by clicking the `Import` button. The transition components are automatically added to your project.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-trans-library-1.png) ![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-trans-library-2.png)

2.3. Enable the `Change Transition` checkbox in the **AI Portraits** component and link the transition’s parent object that you imported earlier.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-transition-parent.png)

2.4. The parent object’s name usually starts with "Transition\_…". You can also drag and drop the transition’s parent object. The selected transition will now be applied to the Lens.

[](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-change-transition-parent-scene.webm)

### Step 3: Add Post Effects[​**](#step-3-add-post-effects "Copy to clipboard")

3.1. The **AI Portraits** component allows you to apply a variety of post effects to the generated result by enabling the `Post Effects` checkbox.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-post-effect-1.png)

3.2. Before enabling the `Post Effects` checkbox, add and configure the post effects in the **Scene Hierarchy**. Remove the default **Camera Object** along with **Lighting**, then add a dedicated **Orthographic Camera** for post effects. For better organization, rename it **Post Effects Camera**.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-post-effect-2.png)

3.3. Assign the **Default** Render Layer to **Post Effects Camera**. Note that the layer must be assigned in two places: in the top-right dropdown and in the `Layers` field.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-rander-layer-def.png)

3.4. Set the **Render Order** of the **Post Effects Camera** higher than the previously added cameras to see the final result.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-post-effect-3.png)

### Step 4: Add a [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) component[​**](#step-4-add-a-face-generator-component "Copy to clipboard")

4.1. Next, we’ll add the component from Lens Studio’s [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) plugin.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-1.png)

4.2. Import a pre-trained model from the Gallery.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-2.png)

4.3. If you don’t have a pre-trained model, you can create one by following the prompts in the [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) plugin. Note that training a model can take several hours.

4.4. After clicking `Import`, the [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) will be automatically added to your project. If necessary, drag it into the **Post Effects Camera** and assign the correct layer.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-3.png)

4.5. We also need to further configure the [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) to ensure it works correctly. To apply the [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) on top of the **AI Portraits** image, we must add an additional component to the project: the [Texture Tracking Scope](/lens-studio/features/ar-tracking/body/consistent-face-and-body-tracking.md#texture-tracking-scope). To add it, click the `+` button in the **Asset Browser**, navigate to the **Tracking** category, and select [Texture Tracking Scope](/lens-studio/features/ar-tracking/body/consistent-face-and-body-tracking.md#texture-tracking-scope). This is necessary for the tracking to function properly on the generated output.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-4.png)

4.6. Next, locate the **AI Output** texture: in the **Scene Hierarchy**, select **AI Portraits** and enable the `Post Effects` checkbox in the **AI Portraits component**. This will reveal the **AI Output** texture.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-41.png)

4.7. Right-click the **AI Output** texture field and select `Select` to highlight it in the **Asset Browser**. Take note of its location.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-42.png)

4.8. In the **Asset Browser**, select [Texture Tracking Scope](/lens-studio/features/ar-tracking/body/consistent-face-and-body-tracking.md#texture-tracking-scope). The **Texture** field is currently empty: drag and drop the **AI Output** texture into this field.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-5.png)

4.9. Open the **Face Generator** component and locate **Face Crop Texture**. Hover over it, right-click, and select `Select`.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-7.png)

4.10. For the **Face Crop Texture**:

* Assign the **AI Output** as the **Input Texture**.
* Assign the [Texture Tracking Scope](/lens-studio/features/ar-tracking/body/consistent-face-and-body-tracking.md#texture-tracking-scope) as the **Tracking Scope**.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-face-gen-71.png)

### Step 5: Add [Color Correction](/lens-studio/features/graphics/materials/post-effects.md#color-correction)[​**](#step-5-add-color-correction "Copy to clipboard")

5.1. To give your Lens a more polished, finished look, add a [Color Correction](/lens-studio/features/graphics/materials/post-effects.md#color-correction).

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-cc-1.png)

5.2. Move the [Color Correction](/lens-studio/features/graphics/materials/post-effects.md#color-correction) into the Post Effects Camera, then assign the appropriate Layer and Render Order.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-cc-2.png)

### Step 6: Add dynamics with [Body Parallax](/lens-studio/examples/components/body-parallax-component.md)[​**](#step-6-add-dynamics-with-body-parallax "Copy to clipboard")

6.1. To make the generated **AI Portraits** output more engaging, add a [Body Parallax](/lens-studio/examples/components/body-parallax-component.md) effect to create a sense of depth and motion. Open the **Asset Library**, search for [Body Parallax](/lens-studio/examples/components/body-parallax-component.md) component, and click `Install`. The component will appear in both the Asset Browser and the Scene Hierarchy.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-1.png) ![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-2.png)

6.2. Move the [Body Parallax](/lens-studio/examples/components/body-parallax-component.md) into the **Post Effects Camera**.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-22.png)

6.3. Add the **Screen Texture** by clicking the `+` button in the **Asset Browser**.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-4.png)

6.4. In the **Scene Hierarchy**, select [Body Parallax](/lens-studio/examples/components/body-parallax-component.md) and set **Screen Texture** as the **Input Texture** in the Inspector.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-3.png)

6.5. To preview the [Body Parallax](/lens-studio/examples/components/body-parallax-component.md) effect, temporarily disable the AI Portraits component and the transition, as they may interfere with the post-effects setup. You can then adjust the **Speed** and **Amplitude** sliders to control the intensity of the effect and observe the changes in the **Preview** panel. Be sure to re-enable the disabled components once you have finished adjusting the **Body Parallax** settings.

[](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-5.webm) ![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-parallax-5.png)

### Step 7: Apply Post Effects to the AI Portraits Output[​**](#step-7-apply-post-effects-to-the-ai-portraits-output "Copy to clipboard")

7.1. After adding and configuring your post effects, the next step is to apply them to the **AI Portraits** output. Earlier, you enabled the `Post Effects` checkbox in the **AI Portraits component** while locating the **AI Output** texture.

Now, link the previously created **Post Effects** camera by clicking the `Add Value` button in the **Cameras with Post Effects** field.

You can add as many cameras with post effects as you want.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-apply-1.png)

7.2. The **Post Effects** camera and effects will be automatically added to the generated result. Click the `Reset` button to ensure the **Preview** reflects the correct result after applying all changes made in the previous steps.

![](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-apply-2.png) [](/img/lens-studio/5-tutorial-ai-portraits/tut-ai-portraits-apply-3.webm)

### Summary[​**](#summary "Copy to clipboard")

Your Lens is now complete and ready for testing in Lens Studio and on a device. In this tutorial, we:

* Built a basic [AI Portraits](/lens-studio/features/genai-suite/ai-portraits.md) Lens
* Replaced the default transition
* Added a [Face Generator](/lens-studio/features/genai-suite/face-ml-generation.md) component
* Applied [Color Correction](/lens-studio/features/graphics/materials/post-effects.md#color-correction)
* Added [Body Parallax](/lens-studio/examples/components/body-parallax-component.md) for depth and motion
* Applied Post Effects to AI Portraits output

To learn more about Render Targets, Render Layers, and camera configuration, see the [Camera documentation](/lens-studio/lens-studio-workflow/scene-set-up/camera.md).
