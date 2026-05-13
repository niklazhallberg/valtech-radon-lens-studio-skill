# Audio Component

This guide walks you through how to play sound in your Lens. You can find info about how to import audio file and other types of Audio Tracks here.

### Sound Best Practices[​**](#sound-best-practices "Copy to clipboard")

When preparing your sound resource for Lens Studio, keep the following optimization recommendations in mind:

* Use the MP3 format
* Use mono instead of stereo
* Use sounds that are < 15 seconds

### Playing Sound[​**](#playing-sound "Copy to clipboard")

Sounds are added to a scene using an `Audio` component added to an object. Sounds are then played using a short playback script.

Your Lens can play multiple sounds simultaneously (e.g. looping background ambience paired with event based sound effects).

### Import the Sound[​**](#import-the-sound "Copy to clipboard")

To import your sound, drag and drop your audio file into the `Asset Browser` panel.

[](/img/lens-studio/playing-audio_import-audio.webm)

### Create Audio Component[​**](#create-audio-component "Copy to clipboard")

To create an object with an `Audio` component. Press `"+"`  button at the `Scene Hierarchy` panel and select -> `Audio`.

Reference audio track by clicking on the `Audio Track` field and selecting your imported sound or dragging audio track onto the`Audio Track` field or the `Audio` component.

[](/img/lens-studio/playing-audio_add-audio-component.webm)

### Audio Component UI[​**](#audio-component-ui "Copy to clipboard")

![](/assets/images/playing-audio_Audio-Audio-Component-7f5d1f7a8f3f706efd16beea4db09fd4.png)

* **Audio Track:**  the Audio Track asset to play
* **Autoplay Loop:** if enabled sound will play and loop automatically. This is great for looping music or background ambience
* **Volume:** set the volume of audio
* **Mix to Snap:** allows to record sound directly into the snap. In this case input from microphone will be ignored. Please note that in order for microphone audio to not be present on the final snap all Audio components should have this option
  <!-- -->
  * ***Record volume:*** the volume of audio recorded to the snap

### Spatial Audio[​**](#spatial-audio "Copy to clipboard")

Spatial audio is the technique that allows to process sounds in such way so they appear to come from their real location in space. Spatial audio requires AudioListener Component.

* **Distance Effect:** allows to simulate sound attenuation which depends on distance to the audio listener

  <!-- -->

  * ***Curve Type:***  describes how volume of the audio source changes with distance. See `Audio.DistanceCurveType`
  * ***Min Distance:*** if distance is less than this value we do not apply distance effect at all
  * ***Max Distance:*** if distance is larger than this value we can not hear any sounds

* **Directivity effect:** applies directivity effect to the `Audio` component that simulates sound attenuation based on the orientation of the `Audio` component relatively to the Audio Listener

* **Position Effect:** applies effect to the `Audio` component that simulates the position of the sound by outputting different result to Left and Right channel. Best effect achieved in the head phones.

### Playing Audio[​**](#playing-audio "Copy to clipboard")

To play sound any other way than `Autoplay Loop` we need to create a Script that will play the sound.

In the `Asset Browser` panel, select `+ -> ``Script`. With the newly added script selected, head to the `Inspector` panel to replace the text in your script resource with the following code:

```
// Play Audio
// @input Component.AudioComponent audio
script.audio.play(1);
```

The play function takes in the number of times you want the sound to play as the input parameter. If you want the sound to play indefinitely, pass in -1 .

### Connect the Script[​**](#connect-the-script "Copy to clipboard")

We can now use this script to play the sound in the `Audio` component we created earlier.

With our object selected, add a `Script` component in the `Inspector` panel. Select `+ Add Component -> ``Script`. Click the `+ Add Script` field and select the script resource we just created. Set the script to run on the `Lens Turned On` event. Finally, bind the `Audio` field to the `Audio` component.

[](/img/lens-studio/playing-audio_audio_add_audio_script.webm)

You can also use [Behavior Script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to play the audio.

### Previewing the Sound[​**](#previewing-the-sound "Copy to clipboard")

Press the refresh button in the `Preview` panel and you should be able to hear your sound.

## Related Guides[​**](#related-guides "Copy to clipboard")

Please refer to the guides below for additional information:

* [Scripting Overview](/lens-studio/features/scripting/script-overview.md)
* [Audio Component](/api/lens-studio/Classes/Components.md#audiocomponent)
