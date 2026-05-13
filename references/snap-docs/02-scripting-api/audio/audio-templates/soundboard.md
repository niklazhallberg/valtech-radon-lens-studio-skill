# Soundboard

The Soundboard example allows you to create your very own soundboard Lenses! This Lens example features a set of buttons that each trigger a different sound and popup graphic.

The buttons in Soundboard Example Lens will show during recording allowing the user to press them but won't be rendered in the final Snap. It does this by using a unique Capture Target and Live Target. Refer to the [Camera and Layers](/lens-studio/lens-studio-workflow/scene-set-up/camera.md) guide for more information on showing things during recording but not having them be in the final Snap.

## Getting the Example[​**](#getting-the-example "Copy to clipboard")

Open the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and look for the `Soundboard` asset.

Once you import the asset from Asset Library, you can find the package `Soundboard` in the Asset Browser.

![](/assets/images/soundboard-0-8bbeb2336b9db14470dcd10e19103c57.png)

Follow the instructions and drag the prefab `Soundboard` into Scene Hierarchy to create a new Scene Object.

[](/img/lens-studio/5-features/soundboard-0b.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

If your project doesn't have an Orthographic Camera (i.e. to render 2D content in screen space), you can add it by pressing `+ > Orthographic Camera` in the `Scene Hierarchy` panel.

![](/assets/images/soundboard-0c-7cd9f0369376b25e12fae37547cf5a8a.png)

## Exploring The Example[​**](#exploring-the-example "Copy to clipboard")

Once you have the project open, you’ll see a set of buttons in the `Preview` panel. Try clicking on these buttons in the `Preview` panel to see what they do.

[](/img/lens-studio/soundboard_soundboard_intro.webm)

You should see that each button triggers a different sound and kitty visual.

## The Soundboard Keys[​**](#the-soundboard-keys "Copy to clipboard")

The sounds and visuals triggered by the buttons are controlled by a group of SceneObjects. You can see them in the `Scene Hierarchy` panel, named with the prefix “SoundboardKey\_”.

![](/assets/images/soundboard-1-2bf27ca90922849601e45feedf4c1531.png)

### Adding Custom Sounds[​**](#adding-custom-sounds "Copy to clipboard")

To edit the sound played by a button, start by selecting its corresponding “SoundboardKey\_” object in the `Scene Hierarchy` panel.

![](/assets/images/soundboard-3-98d66523d2f99c771a3c3f3b69885e1a.png)

The selected object has a SoundboardKey script. You can change the sound it plays by editing the `Audio Track` property on that script component.

![](/assets/images/soundboard-4-8cb7257f0fafd9712f591f1732d7524a.png)

To bring in your own audio track, in the `Asset Browser` panel, select `+ -> Import Asset`.

You can also drag your files into the `Asset Browser` panel to import them.

### Editing The Buttons[​**](#editing-the-buttons "Copy to clipboard")

Similarly, you can change the appearance of the buttons by editing the button’s Material, which you can find in the `Asset Browser` panel under `Materials`.

![](/assets/images/soundboard-7-f993f46dd07160e4c2d91549f1f8c9d5.png)

To bring in your own image, in the `Asset Browser` panel, select `Add New -> Import Files`. Learn more in the [import](/lens-studio/assets-pipeline/2d/image.md) guide.

You’ll likely only need to adjust the `Base Color` and `Base Texture` properties.

## The Trigger Visuals[​**](#the-trigger-visuals "Copy to clipboard")

The Kitty visuals you see popping in after each button press are also SceneObjects, named with the prefix “TriggerVisual\_”.

![](/assets/images/soundboard-2-f2d52f79c4e9a98fd82c1bb803db491d.png)

### Adding Custom Visuals[​**](#adding-custom-visuals "Copy to clipboard")

To replace the image displayed on one of the popup visuals, start by selecting its corresponding “TriggerVisual\_” object in the `Scene Hierarchy` panel.

Like before, the selected object has a `Image` component. You can change its image by editing the `Texture` property on the `Image` Component's material.

![](/assets/images/soundboard-5-cfdaa059031b7be79b09cdfa2ae4d2d2.png)

You can collapse components to find the ones you're looking for by clicking on the arrow next to their name. For example, collapsing `Screen transform` and `TweenScreenTransform` can help you find the `Image` component.

### Updating The Motion[​**](#updating-the-motion "Copy to clipboard")

Each of the TriggerVisual objects has its own predefined tweens for entering and exiting the frame. You can adjust these settings by editing the `TweenScreenTransform` script components attached to the “TriggerVisual\_” objects.

To edit the visual’s start position, edit the `Start` property on the Tween named “show”, and edit the `End` property on the Tween named “hide.”

To edit the visual’s end position, edit the `End` property on the Tween named “show”, and edit the `Start` property on the Tween named “hide.”

![](/assets/images/soundboard-6-cbd99655f3e8861ed79fd1b95e59e3ec.png)

To learn more about how the Tween system works, visit our documentation on [Tweening](/lens-studio/lens-studio-workflow/adding-interactivity/tween-manager.md).

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
