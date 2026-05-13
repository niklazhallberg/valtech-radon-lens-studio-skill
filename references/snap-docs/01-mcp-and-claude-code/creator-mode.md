# Creator Mode

Creator mode in the Lens Studio AI allows you to generate AR experiences through plain text descriptions. This feature leverages GenAI to translate these descriptions into fully functional Lenses, which can include effects, objects, or characters.

This is the same as Easy Lens, which you may have previously accessed.

You can add your own custom components to the system by adding AI metadata in it, sometimes referred to as a "Block", and have AI fill your custom components (e.g. 3D object, textures, input parameters, etc.). Take a look at the [AI Enabled Custom Component](/lens-studio/features/lens-studio-ai/ai-custom-components.md) guide to learn more, or find examples in the [repository](https://github.com/Snapchat/lens-studio-custom-component).

## Step 1: Interact with the panel[​**](#step-1-interact-with-the-panel "Copy to clipboard")

In the top left of Lens Studio, you will find the GenAI Suite panel. Click on the `+` icon to open up Lens Studio AI.

You will see a chat interface, as well as some prompt examples to get started.

Let's click on one of the prompt examples: *"Show the text "Happy days" on my head when I smile."*

[](/img/lens-studio/easylens5.4_1.webm)

## Step 2: Provide details of the Lens to the AI[​**](#step-2-provide-details-of-the-lens-to-the-ai "Copy to clipboard")

Wait for a few moments until Lens Studio AI processes the message.

You will see that Lens Studio AI responds with some questions to further clarify what you wish to see in the output Lens. You have the option to select one of the recommended responses, or provide your own.

Let’s click on one of the example responses.

In this case, we selected “Simple and bold.”

**Note:** Lens Studio AI is an LLM based dynamic system, therefore the specific recommendations may vary from chat to chat.

[](/img/lens-studio/easylens5.4_2.webm) [](/img/lens-studio/easylens5.4_3.webm)

## Step 3: Ask AI to build the Lens[​**](#step-3-ask-ai-to-build-the-lens "Copy to clipboard")

Lens Studio AI will continue interacting with you to describe your concept by answering some questions, or you can simply ask it to create the Lens. In this case, let’s click “Just make a Lens!”.

This kicks off the Lens designing process. It may take a few moments for this to complete.

Once done, you will be able to preview the Lens created!

[](/img/lens-studio/easylens5.4_4.webm) [](/img/lens-studio/easylens5.4_5.webm)

## Step 4: Publish the Generated Lens[​**](#step-4-publish-the-generated-lens "Copy to clipboard")

You are now ready to publish the Lens. Follow the same steps you take to normally publish Lenses in Lens Studio.

You’re all set!

Take a look at some Lenses created through Lens Studio AI!

# Supported Features in Creator Mode

Creator mode relies on various AI Enabled [custom components](/lens-studio/features/scripting/script-components.md) to compose your Lens.

You can add aditional capabilites by adding additionnal components through the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md), or by adding your own by making your [custom component AI Enabled](/lens-studio/features/lens-studio-ai/ai-custom-components.md).

By default, you will have access to the following:

* 2D Screen and Face Stickers
* 3D Asset Generation
* 3D Eyewear, Headwear, Ears, Facial Hair, Hair
* 3D Objects on Head
* Background Generation
* Background Image
* Beautification
* Bitmoji on Shoulder
* Color Filter
* Face Deformation
* Face Events
* Face in Image
* Face Mask Generation
* Facial Hair Generation
* Garment Generation
* Head Text
* Lens Icon Generation
* Screen Text
* "What X are you" randomizer
* Face Art
* Lens Frames
* Upload your own image
* Bitmoji Animation Generation
* Bitmoji Background Generation
* Window Cutouts
* Headmorph collections
* Dynamic Stream from Mouth Open events

## Best Practices, Tips and Tricks[​**](#best-practices-tips-and-tricks "Copy to clipboard")

### Do’s[​**](#dos "Copy to clipboard")

* Use clear instructions in plain English. There is no need to use elaborate wording, straight and concise is best.

* Make use of the recommended prompts from Lens Studio AI. They’re useful to help move along quickly!

* If you’re looking to build up intuition around the different Lens components, try to stack up your Lens concept. Start simple and keep adding more components to it in every consecutive chat interaction.

* If you wish to remove something from your Lens concept, simply ask “Remove \[insert object / component] ”.

* If you know exactly what you want out of Lens Studio AI, you may provide specific instructions in your prompt. Example:

  <!-- -->

  * *I want a Lens that makes me a cowboy*

    * add a desert background
    * add a cowboy hat

* If you are requesting a task that requires coding (which sometimes may not be functional), you can try again, rephrase your prompt, or investigate the code in LensController.js.

* Lens Studio AI automatically creates an icon and name for the Lens. You may update these details in the project settings.

* Lens Studio AI is connected to unique, optimized-for-AR generators (such as retexturing of 3D assets, stickers, background generation etc). Try to experiment with them, adding separately or together to the Lens.

* “Just make a Lens!” is a prompt suggestion that can help with ending the conversation with Lens Studio AI and kicking off the Lens generation itself.

### Don’ts[​**](#donts "Copy to clipboard")

* Do not ask Lens Studio AI questions that are in languages other than English. It will not respond to you.
* Do not ask Lens Studio AI non-related questions to the topic of Lens creation. It simply won’t answer the question for you :)
* Do not ask Lens Studio AI to build back facing experiences. Lens Studio AI is currently not optimized for it.
* You may make changes to your Lens project after working with Lens Studio AI, however the opposite is not currently feasible, *i.e any manual changes made to the project prior, will not carry over to Lens Studio AI.*

### Prompt examples to try[​**](#prompt-examples-to-try "Copy to clipboard")

* Create a new years themed Lens showing a gold colored semi large title "Happy New year, 2025!" at the bottom of the screen, in an elegant font. Purple snow effect and golden heart shaped glasses. A golden party hat and a bit of makeup will add a nice touch.
* Create a realistic or vector art valentines day themed lens with a subtle red and black makeup. Add a 2d lens frame to complement the experience.
* Turn my face to a cheeseburger floating on the screen on a background of a diner at night.
* Make a quiz lens about interesting world records with 8 questions. Add a game show background.
* Dive into an underwater scene with fish and bubbles.
* Create a background with beautiful illustrated vibrant flowers and a pink vibrant flower on my head, also add light beautification.
* A designer inspired bucket hat and sunglasses perfect for traveling in New York + add text on top of the screen with countdown of days until my New York trip which is on December 8th 2025 in New York style font.
* Make a Lens that shows my spirit animal, with funny options.
* Create a pink cap with a logo of cute adorable animal characters.
* Add a space helmet and floating planets around you.
* Make me a pirate.
* Make me look like a cat.
* Image of a witch in a hat with tattoos and piercings, a pet - a black kitten with wings.
* Create a hat made of pasta.
* Make a vintage-feeling lens that shows the time.
* Show the text "Happy days" on my head when I smile.
* Create a Lens with beautiful blue diamond jewelry face art and subtle makeup to complement a beauty effect.
