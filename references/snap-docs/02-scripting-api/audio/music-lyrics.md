# Music Lyrics

The `Music Lyrics` custom component enhances your Lens by displaying song lyrics with the music playing in the background. Bring music to life with visualized lyrics. You can design the way the lyrics stream into the Lens by styling the text like you would any other text in a Lens. For example, customize color and font, choose 2D or 3D text, animate the words, and leverage physics.

Combine the Lyrics with an `ML Face Effect` or `Immersive ML` to create a full effect or tap into other creative visuals. Lenses leveraging the Lyrics API allow Snapchatters to engage with music in a new way: challenge friends to a rap battle, Snap a musical moment, and sing along with friends.

Music Lyrics custom component is not compatible with `Spectacles` and `CameraKit`.

Music Lyrics can not be used in sponsored Lenses. Learn more in the [Music on Snapchat Guidelines](https://www.snap.com/music-guidelines).

[](/img/lens-studio/lyrics-component.webm)

### Usage[​**](#usage "Copy to clipboard")

1. To add the `Music Lyrics` to your Lens, go to the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and find the `Music Lyrics` in the `Custom Components` section.

   ![](/assets/images/lyrics-component-1-5ed1270ce9ba71e4fdf805ee4fb28358.png)

2. Once you click the `Install` button, you can find this component in the `Asset Browser` and add it to your resources to build the Lens.

3. In the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md), select the track that will play when your lens is swiped on by the user. Tracks are located in the `Music` section.

   ![](/assets/images/lyrics-component-3-3c4a088c2971000365e98ce5f46a96e7.png)

4. Make sure to uncheck the `Bundled` option for the selected track — this allows the user to change the track in your lens on their own. The component will not work if this option is enabled.

   ![](/assets/images/lyrics-component-4-4ec611cb3f3ca38ba4db94571a011cea.png)

   While you can assign the audio which lyric will be shown by default, Snapchatters can change the music while using your Lens in the app to fit their needs, and the component will automatically show the corresponding lyrics!

   In this context toggling off `Bundled` means we are only including the music id, and not "bundling" the audio file itself.

5. Drag the custom component into the scene from resources or add it to an empty scene object.

   ![](/assets/images/lyrics-component-5-3924f2e6a1034633937dd913351ccf2f.png)

6. Fill in the input data for the custom component.

   [](/img/lens-studio/lyrics-component-2.webm)

### Inputs[​**](#inputs "Copy to clipboard")

**Music Track**: `AudioTrackAsset` - add the track downloaded from the Asset Library.

**Show mode**: `combobox` - when selecting the `Word` type, the song lyrics will be displayed word by word. When selecting the `Line` type, a specified number of lines of the song will be displayed on the screen.

**Text Placeholders**: `SceneObject[]` - add scene objects that have a `Text Component` and/or `Text3D` where the text will be displayed.

### API[​**](#api "Copy to clipboard")

**lyricsTracker**: `LyricsTracker`

Returns the `LyricsTracker` of the current track.

***

**externalMusicModule**: `ExternalMusicModule`

Returns an `ExternalMusicModule` that is used in the component.

***

**clipDuration**: `number`

Returns the duration of the current track.

***

**lines**: `LyricsLine[]`

Returns an array of the track's text lines.

***

**fullLyrics**: `Lyrics`

Returns the Lyrics of the current track.

***

**currentLine**: `LyricsLine`

Returns the active line of text.

***

**highlightFirstLine**: `boolean`

Allows enabling or disabling additional text outlining for the first line of text in 2D animation.
