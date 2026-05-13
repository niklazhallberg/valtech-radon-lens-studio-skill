# Audio Tracks

This page explains different types of Audio Tracks. You can access provider of the audio track asset by accessing it's control property:

```
//@input Asset.AudioTrackAsset audioTrack
var control = script.audioTrack.control;
```

For each type of audio track asset serves different purpose, let's quickly overview all of them

## FIle Audio Track[​**](#file-audio-track "Copy to clipboard")

The most common type of Audio Track asset is audio From File.

To import your sound, drag and drop your audio file into the `Asset Browser` panel.

[](/img/lens-studio/audio-track-assets_import-audio.webm)

They can be played with [Audio component](/lens-studio/features/audio/playing-audio.md) or processed as raw data with [JavaScript](/api/lens-studio/Classes/Providers.md#FileAudioTrackProvider).

We currently support reading audio data from 1 channel audio, for a stereo file left and right channels will be added

This type of audio is using [Provider.FileAudioTrackProvider](/lens-studio/api/lens-scripting/classes/Built-In.FileAudioTrackProvider.html) type and allows to read audio data. Check out api documentation page to see scripting examples.

## Licensed Music[​**](#licensed-music "Copy to clipboard")

Another Audio Track asset type is Licensed Music. Provider type : [FileLicensedSoundProvider](/lens-studio/api/lens-scripting/classes/Built-In.FileLicensedSoundProvider.html)

To add a new Licensed Music open the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and select the `Music` section. Left-click on the play button to hear the sound preview.

![](/assets/images/audio-track-assets_S-track-7b34b655aa7387e783b6fe3bef265343.png)

Once you’ve selected a Music asset, press on the import button to add a Music resource to your project.

Licensed Music can be played as any other audio track asset in Lens Studio using [Audio Component](/lens-studio/features/audio/playing-audio.md), or with the help of a [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) script.

There are certain limitations in the usage of Licensed Music, such as:

* Lens can contain only one Licensed Music.
* If Lens Studio cannot get device location or the track is not available in the user’s country, the sound in the Lens will be muted. The user will have an ability to remove or replace un available tracks.
* These tracks cannot be mixed with other tracks or changed in any manner. Only one track can be played at a time. Any other simultaneous audio playback is forbidden.
* The final audio will be mixed directly into the Lens.

Audio Component that plays this audio track has its API restricted to support these limitations. Using restricted apis will throw an exception in Lens Studio and on device, so be mindful of using them.

To learn more about Snap's Guidelines on Licensed Music, you can visit the **[Music on Snapchat Guidelines](https://snap.com/en-US/music-guidelines)**.

**Available API:**

* Play (loops)
* All spatial audio API

**Restricted API:**

* Stop
* Pause
* Resume
* Fade in, fade out
* Volume changing
* Position changing
* Recording volume changing

Behavior script checks and ignores all restricted use cases and can be safely used with Licensed Music.

## Audio From Microphone[​**](#audio-from-microphone "Copy to clipboard")

Audio From Microphone is a specific Audio Track asset that provides direct access to the audio from the microphone. Provided by [MicrophoneAudioProvider](/lens-studio/api/lens-scripting/classes/Built-In.MicrophoneAudioProvider.html).

**Audio From Microphone** audio track can be added by pressing the `“+”` button on the `Asset Browser` panel and selecting Audio From`Microphone.`

[](/img/lens-studio/audio-track-assets_Audio-AUdio-from-mic-Add.webm)

After the **Audio From Microphone** is referenced somewhere in the scene an additional icon will appear in the bottom-right corner of the Preview Panel.

You will also be asked for permissions at the first time.

[](/img/lens-studio/audio-track-assets_Audio-Preview-On.webm)

The Microphone Preview button is only available if **Audio From Microphone asset**  is present and referenced in Script or Script Graph somewhere in the project.

On MacOS: the default input device is used, settings can be changed in the System Preferences. On Windows - right click on the button and select the Input Device if multiple ones are available.

![](data:image/png;base64,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)

Toggle the button to start or stop grabbing the Audio Input for processing.

[](/img/lens-studio/audio-track-assets_Audio-Mic-on.webm)

If Audio input is enabled the button provides visual feedback on the input sound

[](/img/lens-studio/audio-track-assets_mic_audio_4.webm)

You can find usage examples in the [API documentation](/lens-studio/api/lens-scripting/classes/Built-In.MicrophoneAudioProvider.html) or [AudioAnalyzer](/lens-studio/features/audio/audio-templates/audio-analyzer.md) and [Keyword Detection](/lens-studio/features/audio/audio-templates/keyword-detection.md) templates.

While reading data from microphone don't forget to call `start` function

```
var control = script.audioTrack.control;
if (control.isOfType('Provider.MicrophoneAudioProvider')) {
  control.start();
}
```

## Audio Output[​**](#audio-output "Copy to clipboard")

Audio Output is a specific type of Audio Track asset that allows you to obtain a preferred audio frame size for the current frame and write raw data into it.

### Guide[​**](#guide "Copy to clipboard")

Audio Output audio track can be added by pressing the `“+”` button on the `Asset Browser` panel and selecting `Audio Output`.

![](/assets/images/audio-track-assets_Audio-Audio-Output-add-8ff2bfcb5f7d57b49a19cb91d20c79b4.png)

[AudioOutputProvider](/lens-studio/api/lens-scripting/classes/Built-In.AudioOutputProvider.html) of this audio track asset allows you to get the amount of samples required for the current frame, generate some data and write into the output. Here is an example of how to generate sin wave :

```
// @input Asset.AudioTrackAsset outputAudioTrack
// @input int sampleRate = 44100 {"widget" : "combobox", "values" : [{"label" : "4000", "value" : 4000}, {"label" : "8000", "value" : 8000},{"label" : "16000", "value" : 16000}, {"label" : "32000", "value" : 32000}, {"label" : "44100", "value" : 44100}, {"label" : "48000", "value" : 48000}], "hint" : "Number or samples per second"}
// @input float frequency = 440
// @input float amplitude = 0.5
const PI_2 = Math.PI * 2;
const BUFFER_SIZE = 640000;
var audioOutput = script.outputAudioTrack.control;
audioOutput.sampleRate = script.sampleRate;
var data = new Float32Array(BUFFER_SIZE);
var shape = new vec3(0, 1, 1);
var phase = 0;
function udpateAudioFrame() {
  shape.x = audioOutput.getPreferredFrameSize();
  //write some samples into the data array
  //for example sin signal
  for (var i = 0; i < shape.x; i++) {
    data[i] = Math.sin(phase) * script.amplitude;
    phase = (phase % PI_2) + (PI_2 * this.frequency) / this.sampleRate;
  }
  audioOutput.enqueueAudioFrame(data, shape);
}
script.createEvent('UpdateEvent').bind(udpateAudioFrame);
```

To make this example work create [Audio](/lens-studio/features/audio/playing-audio.md) Component, set `Audio Track` with the Audio Output asset and enable `Autoplay Loop`

![](/assets/images/audio-track-assets_Screen-Shot-2021-12-02-at-12.45.20-PM-faae8af46eec215907cde5d0c7c97ee4.png)
