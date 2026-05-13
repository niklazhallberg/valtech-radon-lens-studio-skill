# Beat Sync

The Beat Sync Custom Component enables creators to build real-time, beat-responsive effects in Lens Studio by leveraging the Sound Sync API. It offers customizable response events triggered by musical beats (e.g., downbeats, specific beat indices) and allows creators to control visuals, animations, materials, and logic in perfect sync with a selected music track.

[](/img/lens-studio/beat-sync2.webm)

## How Beat Sync Works[​**](#how-beat-sync-works "Copy to clipboard")

The Beat Sync component uses beat data from the Sound Sync API to trigger synchronized responses:

1. **Beat Data Loading** - The component loads pre-analyzed beat data for the selected music track from the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md)
2. **Trigger Detection** - Based on configured triggers (OnBeat, OnDownBeat, or specific beat indices), events are fired at precise timestamps
3. **Response Execution** - When triggers activate, various responses can be executed including behavior scripts, custom API calls, or property modifications
4. **Synchronized Effects** - Visual effects, animations, and other behaviors stay perfectly in sync with the music using the pre-computed beat timestamps

Common use cases include:

* **Music Visualizers** - Creating visual effects that pulse with the beat
* **Rhythm Games** - Triggering gameplay events on specific beats
* **Dance Experiences** - Synchronizing character animations with music
* **Video Templates** - Coordinating scene changes and transitions with audio

## Installing the Component[​**](#installing-the-component "Copy to clipboard")

![](/img/lens-studio/beat-sync1.png)

The Beat Sync custom component is available in the Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Press `Install` or `Update` and then add it to the `Asset Browser` panel by clicking the `+` button and looking up `Beat Sync`.

### Downloading Music Tracks[​**](#downloading-music-tracks "Copy to clipboard")

To use the Beat Sync component, you must download music tracks from the Asset Library:

1. **Find Music Tracks** - Go to the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and navigate to the `Music` section
2. **Select a Track** - Choose a music track that will be used in your lens
3. **Mark as Unbundled** - Make sure to uncheck the `Bundled` option for the selected track. This allows users to change the track in your lens on their own, and the component will not work if this option is enabled

Beat Sync can not be used in sponsored Lenses. Learn more in the [Music on Snapchat Guidelines](https://www.snap.com/music-guidelines).

### Basic Setup[​**](#basic-setup "Copy to clipboard")

1. **Add to Scene** - Drag the Beat Sync component to a scene object
2. **Set Audio Track** - Assign the downloaded Audio Track to load beat data from
3. **Configure Triggers** - Set up trigger inputs to define when events should occur
4. **Add Responses** - Configure responses for each trigger (behaviors, scripts, or property changes)

<!-- -->

## Component Inputs[​**](#component-inputs "Copy to clipboard")

<!-- -->

### Core Settings[​**](#core-settings "Copy to clipboard")

| Input              | Type            | Description                                                                                      |
| ------------------ | --------------- | ------------------------------------------------------------------------------------------------ |
| **Audio Track**    | AudioTrackAsset | The audio file that will be used for beat synchronization                                        |
| **Triggers Input** | TriggerInput\[] | An array of trigger inputs that define when and how events should occur based on the beat        |
| **Print Warns**    | Boolean         | If set to true, it will print warnings to the console for debugging purposes (defaults to false) |

### Trigger Input Configuration[​**](#trigger-input-configuration "Copy to clipboard")

Each Trigger Input defines a specific point in the music and the actions that should be taken:

| Input            | Type             | Description                                                                                                                                                                            |
| ---------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Trigger Type** | Enum             | Determines the type of beat that will trigger the response:<br />• `OnBeat` - Any beat<br />• `OnDownBeat` - The first beat of a measure<br />• `OnBeatIndex` - A specific beat number |
| **Beat Index**   | Number           | If Trigger Type is OnBeatIndex, specifies the exact beat number (from 1 to 64)                                                                                                         |
| **Responses**    | ResponseInput\[] | Array of responses that will be executed when the trigger condition is met                                                                                                             |

### Response Configuration[​**](#response-configuration "Copy to clipboard")

Each Response Input specifies the action to be taken when a trigger is fired:

| Input             | Type | Description                                                                                                                                                                                                       |
| ----------------- | ---- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Response Type** | Enum | The typea of action to perform:<br />• `Behavior Script` - Trigger a behavior script<br />• `Custom Script API Method` - Call a custom script method<br />• `Expose Property` - Modify a property value over time |

#### Behavior Response Input[​**](#behavior-response-input "Copy to clipboard")

For triggering behavior scripts:

| Input                     | Type            | Description                                                                                                                                                  |
| ------------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Behavior Trigger Type** | Enum            | Method for triggering the behavior:<br />• `Global CustomTrigger` - Use a custom trigger name<br />• `Manual Trigger` - Direct reference to script component |
| **Custom Trigger Name**   | String          | Name of the custom trigger (for Global CustomTrigger)                                                                                                        |
| **Behavior Script**       | ScriptComponent | Direct reference to script component (for Manual Trigger)                                                                                                    |

#### Script API Response Input[​**](#script-api-response-input "Copy to clipboard")

For calling custom script methods:

| Input                  | Type             | Description                                                                                                                        |
| ---------------------- | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **Script**             | ScriptComponent  | Reference to the script component containing the method                                                                            |
| **Method Name**        | String           | Name of the method to be called on the script                                                                                      |
| **Response Type**      | Enum             | How the script responds:<br />• `Only Trigger` - Simple trigger with no value<br />• `Fading Value` - Value that changes over time |
| **Fading Value Input** | FadingValueInput | Fading transition properties (if using Fading Value)                                                                               |

#### Expose Property Response Input[​**](#expose-property-response-input "Copy to clipboard")

For controlling property values:

| Input                     | Type             | Description                                          |
| ------------------------- | ---------------- | ---------------------------------------------------- |
| **Exposed Property Name** | String           | Name of the property to be exposed and modified      |
| **Fading Value Input**    | FadingValueInput | Defines the fading behavior for the exposed property |

### Fading Transition Input[​**](#fading-transition-input "Copy to clipboard")

Defines how values change over time:

| Input               | Type   | Description                                                                                                                                                                   |
| ------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Fading Type**     | Enum   | Type of fading transition:<br />• `Linear` - Constant rate of change<br />• `Logarithmic` - Creates ease-in or ease-out effect<br />• `FixedStep` - Incremental value changes |
| **Fading Speed**    | Number | Controls the rate of transition (behavior depends on Fading Type)                                                                                                             |
| **Fixed Step Size** | Number | Incremental value change for each step (FixedStep only)                                                                                                                       |

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

To preview your Beat Sync Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide. A helpful testing flow to follow is:

1. **Push the lens to your device** to test audio playback and beat synchronization
2. **Test with different music tracks** to verify beat sync accuracy
3. **Verify trigger timing** matches expected beat patterns
4. **Check response effects** activate at the correct moments
5. **Test performance** with multiple simultaneous effects
