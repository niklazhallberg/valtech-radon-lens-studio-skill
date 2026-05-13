# Music Video

You can find this sample project in the homescreen of Lens Studio.

The Music Video sample project allows you to time different effects based on audio timestamps. The sample project comes with helper scripts that allow you to trigger scripts, set text, call [Behaviors](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md), and more!

[](/img/lens-studio/music-video_recording.2021-12-01-17_58_02.webm)

This sample project does not require a [Licensed Music](/lens-studio/features/audio/audio-track-assets.md) asset. However, it will utilize the Licensed Music asset to showcase how it works. It can be used with any other Audio Track File.

## Guide[​**](#guide "Copy to clipboard")

To make our music video Lens, we will need to: get the sound to play, get timing information for our sounds, and finally set up our effects to be called based on these times.

### Importing the Sound[​**](#importing-the-sound "Copy to clipboard")

First, find the Music you’d like to prepare a video for on the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) or [import](/lens-studio/features/audio/audio-track-assets.md) your own audio file.

### Choosing Audio Track To Play[​**](#choosing-audio-track-to-play "Copy to clipboard")

Select the`Audio [SWAP AUDIO TRACK]`scene object in the `Scene Hierarchy` panel and replace the audio track input of the [Audio Component](/lens-studio/features/audio/playing-audio.md) in the Inspector panel with the audio track of your choice.

![](/assets/images/music-video-1-72646defe4d63b0e84b065a164fe3006.png)

`Audio [SWAP AUDIO TRACK]` component is played using a [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script. Select the `Behavior - Tap To Play [EDIT]` object to modify the event used to play sound.

![](/assets/images/music-video-2-af294f2c267ffb369d6d1471c19a8d23.png)

### Preparing lyrics[​**](#preparing-lyrics "Copy to clipboard")

If you do not intend to use song lyrics in your project you can skip to the next part.

The next step would be to get lyrics with timestamps in the `.lrc` format and save the file to your drive. This file is a common format used to store the relationship between song lyrics and the song itself. For convenience remove everything except for the segment we’re interested in.

Let's say that you are interested in the 30 second piece that starts at second 29, so let’s remove all other lines and save the file

```
[00:29.70]I just been fantasizin' (Size)
[00:31.40]And we got a lotta time (Time)
[00:33.30]Baby, come throw the pipe (Pipe)
[00:35.10]Gotta know what it's like (Like)
[00:36.90]Yeah-yeah, oh-woah-woah
[00:40.40]Baby, I need to know, mmm
[00:44.90]What's your size? (Size)
[00:46.40]Add, subtract, divide ('Vide)
[00:48.10]Daddy don't throw no curves (Curves)
[00:49.90]Hold up, I'm goin' wide (Wide)
[00:51.70]We could just start at ten (Ten)
[00:53.50]Then we can go to five (Five)
[00:55.40]I don't play with my pen (Pen)
[00:57.20]I mean what I writе
[00:59.10]Yeah-yeah, woah-woah-woah
```

Next, we need to convert these timestamps to be usable by the Lens. You can either calculate them yourself, or process a `.lrc` file using this short python script to obtain converted values. [Download the example script here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Forum-Helpers/Music_Video_Template_Helper.ipynb.zip). It can be run in [Google Collab](https://colab.research.google.com/) :

1. Unzip and upload notebook to your Google Drive.
2. Open the notebook.
3. Left-click on the **Folder** button on the left to open the content folder.
4. Drag and drop your `.lrc` file into the folder.
5. Left-click on the **Run** button in the top left corner of the cell with python code.

[](/img/lens-studio/music-video_MV-subtitles-fix.webm)

## AudioAttachedSequence[​**](#audioattachedsequence "Copy to clipboard")

**AudioAttachedSequence** script allows you to perform different actions at the specified time of the played audio track.

The **Audio** field should be set with the Audio Component configured to play the audio track of your choice.

**Mode** allows you to select one of next options :

* **Time Stamp Sequence** performs one action per each timestamp
* **Single Timestamp** performs a sequence of actions for one timestamp.

**Timestamp** input or **Timestamps** array input will be enabled correspondingly. Values can be filled out with the ones obtained in the previous section or tweaked by ear.

**Action:** specifies the action to perform:

### Enable/Disable Scene Objects[​**](#enabledisable-scene-objects "Copy to clipboard")

Allows to enable scene object for current timestamp and disable previous one.

**SceneObjects:** list of Scene Objects to enable/disable for each timestamp.

Expand the Orthographic camera’s hierarchy to check out how each screen scene object is set up. Each stage has a hierarchy of scene objects with images, post effects, text components combined with some Tween and Behavior scripts. Almost all assets used here were found in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md)!

![](/assets/images/music-video-3-5e6f3449ec6ca99668f11118ed2bcfde.png)

Since our music will loop in the Lens, we will want our animations to loop as well. There are some extra settings that allow to restart helper scripts in the hierarchy of specified scene objects.

![](/assets/images/music-video-4-88d848bcf3a07b4dc1478aa197b26e30.png)

**Tweens:** restarts all tweens in the scene objects hierarchy that have autoplay

**Restart Behavior:** allows to reinitialize, or invoke OnAwake and OnStart events for the behavior scripts attached to the scene objects and their children.

### Set Text[​**](#set-text "Copy to clipboard")

Let’s check out another action type, to do so switch `Action Type` to `Set Text`, add [Text](/lens-studio/features/text/2d-text.md) or [3D Text](/lens-studio/features/text/3d-text.md) object to your scene and set the `Text/3DText` input of the helper script with this component. While timestamps stay the same lets populate elements of the Text array with the lines of the lyrics.

![](/assets/images/music-video-5-f45960d14cd004fd06a0d16088aed100.png)

Refresh the `Preview` panel, and click to start audio again and see the text update along with the audio!

### Start/Stop Tween[​**](#startstop-tween "Copy to clipboard")

`Start/Stop Tween` Action Type allows to start and stop a tween with specified `Tween name` on the scene object from the `Tween Objects` array. At each time stamp tween on the previous scene object is stopped, and the one on the next sceneObject is being reset and played.

![](/assets/images/music-video-6-5dd4ca91da0b2ad95d4feba9f1d6e7f3.png)

### Call Api Function[​**](#call-api-function "Copy to clipboard")

`Call Api Function` Action Type allows to call `start function name` on the specified script and `stop function name` on the same script from the `Scripts With Api` array.

![](/assets/images/music-video-7-f8bf05d91f8b4f0d0e2d5bcadaf86624.png)

Script with api can look like this:

```
script.start = function () {
  //do something when this timestamp is on
};
script.stop = function () {
  //do something when this timestamp is off
};
```

### Call Behavior[​**](#call-behavior "Copy to clipboard")

`Call Behavior` Action Type trigger calls a corresponding behavior `Custom Trigger` on each timestamp.

![](/assets/images/music-video-8-78ec614ff58df0f80d8f3b3b3c547fc6.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
