# Character Animation

With the Character Animation plugin, creators can choose from existing animations in the Animation Library, generate entirely new ones using a Text Prompt, or upload a Video to capture animation from it - offering a flexible and powerful workflow for animation creation.

All animations can be applied to both: Bitmoji and Body Morph, making the plugin a versatile tool for different character types.

## Getting Started[​**](#getting-started "Copy to clipboard")

### Launching Character Animation Plugin[​**](#launching-character-animation-plugin "Copy to clipboard")

1. Navigate to the GenAI Suite using the option in the top right corner of the Lens Studio.

   ![](/img/lens-studio/5-selfie-attachments/selfie-attach-3.png)

2. On the GenAI Home Page, you may need to scroll down to find the menu of GenAI tools. In the panel, select Character Animation.

   ![](/img/lens-studio/5-character-animation/ca-library-genai-menu.png)

### User Interface Overview[​**](#user-interface-overview "Copy to clipboard")

In the pop-up window, you’ll see four options:

* [**Animation Library**](#animation-library) - select and apply a pre-made animation from the library;
* [**Upload Animation**](#upload-animation) - upload your animation;
* [**Text Prompt**](#text-prompt) - generate a new animation by entering a text prompt;
* [**Capture from Video**](#capture-from-video) - upload a video and extract animation directly from it.
  <!-- -->
  ![](/img/lens-studio/5-character-animation/ca-menu-new.png)

## Animation Library[​**](#animation-library "Copy to clipboard")

### Choose an animation[​**](#choose-an-animation "Copy to clipboard")

On the left side, you’ll find all available animations, organized into three categories:

* **Actions** - full-body animations *without* facial expressions;
* **Emotions** – full-body animations *with* facial expressions included;
* **My Gallery** – this is where *your custom animations* will appear after being generated using a Text or Video Prompt. Here you can also track the status of the animation generation process.

![](/img/lens-studio/5-character-animation/ca-library-left.png)

For Bitmoji, you can optionally add facial animations using [**Bitmoji Face Animator**](/lens-studio/features/bitmoji-avatar/bitmoji-face-animator.md).

You can also use the search bar to quickly find the animation you need within each category.

![](/img/lens-studio/5-character-animation/ca-library-search.png)

### Choose a character[​**](#choose-a-character "Copy to clipboard")

Once you've selected an animation, the right-side panel allows you to choose which character to apply it to. You can switch between the tabs at the top to apply the animation to either Bitmoji or Body Morph.

![](/img/lens-studio/5-character-animation/ca-library-right.png)

If your Body Morph tab is empty, it means you haven’t created any characters yet. To get started, open the [**Body Generator**](/lens-studio/features/genai-suite/body-morph-generation.md), create a character using its tools, and it will appear in the gallery, ready for you to apply animations to.

### Stitch animations[​**](#stitch-animations "Copy to clipboard")

This option lets you seamlessly stitch together any animations from the library, giving you full flexibility to bring your unique vision to life.

Select the first animation in the library that you’d like to stitch. A tiny preview of the animation will appear in the lower corner of the scene, along with a `+` button.

![](/img/lens-studio/5-character-animation/ca-stitch-1.png)

Click the `+` button to add a second animation. You can add up to five animations in total.

![](/img/lens-studio/5-character-animation/ca-stitch-2.png)

Once you’ve selected all the animations you want, click the `Blend animation` button, and you’ll see a new tile in the library, where you can track the progress of your animation stitching.

![](/img/lens-studio/5-character-animation/ca-stitch-3.png)

### Import to Project[​**](#import-to-project "Copy to clipboard")

Once you’ve selected an animation and a character, click the `Import to Project` button to bring them into your project.

![](/img/lens-studio/5-character-animation/ca-library-import.png)

## Upload Animation[​**](#upload-animation "Copy to clipboard")

This option lets you upload your animation file. Simply click the large placeholder labeled `Upload .fbx` and select your animation from your file system. You’ll then be redirected to the [**Animation Library**](#animation-library), where you can track the progress of your animation uploading.

The animation file must be in .fbx format and under 20 MB.

![](/img/lens-studio/5-character-animation/ca-upload-animation.png)

## Text Prompt[​**](#text-prompt "Copy to clipboard")

Here, you can generate an animation by entering a text prompt in the input field.

![](/img/lens-studio/5-character-animation/ca-text-prompt.png)

To explore how it works, click the `Surprise me` button to use one of the default prompts. You can also quickly clear the input using the trash icon in the top-right corner.

![](/img/lens-studio/5-character-animation/ca-text-surprise.png)

Once your text prompt is ready, click the `Generate Animation` button. You’ll then be redirected to the [**Animation Library**](#animation-library), where you can track the progress of your animation generation.

![](/img/lens-studio/5-character-animation/ca-text-generate.png)

## Capture from Video[​**](#capture-from-video "Copy to clipboard")

Use this option to generate an animation by uploading a video and extracting the persons’s movement from it.

Please, note that only the first 10 seconds or 512 frames will be processed. Video upload requirements:

* Format: .mp4 only
* Max File Size: 20 MB

Click the `Upload Video` area to select and upload your video file.

![](/img/lens-studio/5-character-animation/ca-video-upload.png)

Then, click the `Process Video` button to allow the plugin to analyze the video and detect any persons present.

![](/img/lens-studio/5-character-animation/ca-video-process.png)

If the analysis is successful, you will see a breakdown of detected persons. Select the person whose motion you want to capture, and click `Generate Animation` to create the animation. You’ll then be redirected to the [**Animation Library**](#animation-library), where you can track the progress of your animation generation.

![](/img/lens-studio/5-character-animation/ca-video-generate.png)

### Best Practices for Uploaded Video[​**](#best-practices-for-uploaded-video "Copy to clipboard")

**Good** ✅

* The video should be less than 10 seconds long;
* The video should contain at least one person;
* The full body of the selected person should be mostly visible.

| Example 1 | Example 2 | Example 3 |
| --------- | --------- | --------- |
|           |           |           |

**Bad** ❌

* Video containing no person;
* Video that is very blurry;
* Person in the video is too small;
* Person in the video is mostly occluded / not visible in the frame.

| Example 1 | Example 2 |
| --------- | --------- |
|           |           |

Visit [**Animating Bitmoji 3D**](/lens-studio/features/bitmoji-avatar/animating-bitmoji-3d.md) to learn how to animate Bitmoji using other tools and how to apply them.
