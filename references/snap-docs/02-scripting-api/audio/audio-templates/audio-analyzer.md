# Audio Analyzer

Audio Analyzer allows you to drive different effects based on the power of the audio signal in certain frequency ranges.

The `Audio Analyzer` asset can be found in the Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import asset and drag included prefab to the `Scene Hierarchy` panel.

[](/img/lens-studio/audio-analyzer_AA-main.webm)

## Choosing the Audio Input[​**](#choosing-the-audio-input "Copy to clipboard")

The asset is set up to analyze audio data from the `File Audio Track`. Select the `Audio Analyzer[EDIT ME]` scene object in the `Scene Hierarchy` panel to explore all the options of the `Audio Analyzer` script in the `Inspector` panel.

### Audio from Microphone[​**](#audio-from-microphone "Copy to clipboard")

Set `Input Type` to `Microphone`, set `Microphone Audio` with the `Audio From Microphone` asset if it’s not set already.

![](/assets/images/audio-analyzer-mic-579226c4c6c24ca1848a72435a0f6c6f.png)

You can add `Microphone Audio` asset to the project by clicking on the **+** button in the `Asset Browser` panel.

Make sure to provide access to your microphone in Lens Studio by clicking on the microphone button at the bottom of the Preview panel.

[](/img/lens-studio/5-audio/audio-analyzer-enable-mic.webm)

Then try making some sound to see the reaction of the scene objects.

### Audio From File or Sound[​**](#audio-from-file-or-sound "Copy to clipboard")

Set Audio Track input with the imported audio file or a Licensed Music from the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md)

![](/assets/images/audio-analyzer-file-dc087a55c4589ec3f0b528de7e4a1b44.png)

Enable `Play Audio` checkbox to create audio component and play specified audio track.

Set a number of `loops` to play.

Please match sample rate with your audio track sample rate, (44100 for Licensed Music)

![](/assets/images/audio-analyzer-sample-rate-416934db68f7783b0124be337f44b486.png)

### Audio From Audio Component[​**](#audio-from-audio-component "Copy to clipboard")

Another way is to specify `Audio` Component to get audio data from. In this case audio analyzer will process the audio track of this audio component, stop and start as the audio component starts or stops.

![](/assets/images/audio-analyzer-audio-23f3fe3a3436469484f2c0aa37c2ef5d.png)

Play or stop this audio component as needed, for example with a [Behavior script](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md).

### From Script with API[​**](#from-script-with-api "Copy to clipboard")

You can even generate your own audio buffer and set a custom script with certain api as an input.

```
script.getAudioFrame(Float32Array audioFrame) : vec3 - function that writes audio samples into audioFrame array and returns it shape
script.sampleRate : Number - sample rate of this audio buffer
```

### Set input via api[​**](#set-input-via-api "Copy to clipboard")

You may also choose not to set Input and do it later from script or a Behavior script.

```
audioAnalyzerScript.setInput(input, sampleRate);
```

## Mel Spectrogram Settings[​**](#mel-spectrogram-settings "Copy to clipboard")

**Sample Rate:** Set number of samples per second (has to match your audio input sample rate).

**Frame Size:** Length of the window, which is the length of frameSize and then padded with zeros to match fftSize.

**Hop Size:** Set number of samples between successive fft segments.

**Fft Size:** Set length of the fft window.

**Num Mel:** Set number of mel bins.

**Min Frequency:** Set min frequency.

**Max Frequency:** Set max frequency.

## Driving Effects based on Audio Analysis[​**](#drivingeffects-based-on-audio-analysis "Copy to clipboard")

By default the example analyzes audio data and outputs power of signal in all frequency bands in the range from 0 to 1.

The bands (or bins) are defined by splitting the interval from the minimal frequency to the maximum frequency into a certain amount of bins on the mel (logarithmic) scale. This scale is used as it better represents the way the human ear perceives the sound.

Asset contains a`AudioAnalyzerHelper` script that allows it to perform certain responses to the change of band value.

![](/assets/images/audio-analyzer-helper-28ccbe55f369f4d98c541b3db09d69ed.png)

**Audio Analyzer:** reference to the audio Analyzer script.

**Get Band Value:** specifies which value to take.

* **By index:** get band value by index.
* **Average:** get average value across all bands.
* **All Bands:** get all band values. Can be used to set the array property of the Material or VFX asset or passed as parameter to the script component api function.

**Smooth Value:** allows to blend band value with previous value.

* **None:** no blending.
* **Fixed step:** each band value fades off by a fixed step per update.
* **Lerp:** interpolate between previous and next value.

[](/img/lens-studio/5-audio/audio-analyzer-lerp.webm)

**Response Action:** perform certain actions based on the selected band values

**Call Api Function:** allows to interpolate between start and end values and pass result to the api function.

* **Value Type:** set the type of value.
* **Start Value:** start value that corresponds to band value = `0`.
* **End Value:** start value that corresponds to band value = `1`.
* **Script:** script with api.
* **Function Name:** api function name.

**Set Material VFX Parameter**

**VFX or Material:** asset to set property of

* **Parameter Name:** asset parameter, if you select All Bands - this expected to be array parameter
* **Value Type:** set the type of value
* **Start Value:** start value that corresponds to band value = 0
* **End Value:** start value that corresponds to band value = 1

**Example:** script on the Beats scene object that sets float array parameter from the band values

![](/assets/images/audio-analyzer-material-6354394ae24e2e9fc370df1d2e4f5406.png)

**Set Transform:** Allows to set scene objects transform

![](/assets/images/audio-analyzer-set-transform-f71e78af76f526771b97afff46862e6f.png)

* **Scene Object:** scene object to set transform
* **Transform:** set Position, Rotation or Scale
* **Local:** if enabled sets local transform, otherwise - global
* **Mode:** allows to specify Start -  End values or Offset from the current transform value

### Using Audio Analyzer Api[​**](#using-audio-analyzer-api "Copy to clipboard")

Open AudioAnalyzer.js file to see available api functions. You can call them from a different script by referencing Audio Analyzer script component

```
// @input Component.ScriptComponent audioAnalyzerScript
var bands = script.audioAnalyzerScript.getBands();
var numMel = script.audioAnalyzerScript.getNumMel();
```

`AudioFrameToTexture` script provides an example of how to write current audio frame into a texture and use it in the material or VFX editor.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
