# Video

Lens Studio supports video import. This guide will walk you through how to work with videos in Lens Studio.

## Video Import[​**](#video-import "Copy to clipboard")

You can import a video by dragging and dropping the video into the `Asset Browser` panel.

[](/img/lens-studio/5-adding-content/video-1.webm)

You can also use `+ -> Import Asset` and choose the video you want to import.

![](/assets/images/video-2-f2fc41049927e872ea1b8daa84b43146.png)

### Supported Video Format[​**](#supported-video-format "Copy to clipboard")

Lens Studio supports videos with the following requirements:

* **File format:** MP4
* **Codec:** H.264 / AVC
* **Resolution:** Your video resolution needs to be greater than 16 x 16 and smaller than 1280 x 1280. In both dimensions resolution needs to be multiples of 16
* **Size:** Less than 10 MB

## Use Video As Texture[​**](#use-video-as-texture "Copy to clipboard")

When you import a video into Lens Studio, it automatically converts it to a `Texture` Asset. It can be used the same way as static textures or animated textures. For example, it can be a texture for an [Image or Screen Image](/lens-studio/assets-pipeline/2d/image.md).

[](/img/lens-studio/5-adding-content/video-3.webm)

In the `Inspector` panel, you can view its properties and adjust the volume. Check the `Auto Play` checkbox if you want the video to automatically start playing upon opening the Lens. Increase the `Volume` slider if you want the video to also playback sound.

[](/img/lens-studio/5-adding-content/video-4.webm)

## Scripting Video Playback[​**](#scripting-video-playback "Copy to clipboard")

Scripting unlocks more complex playback control beyond  `Auto Play` and  `Volume`. For more information on scripting video playback, see the [VideoTextureProvider](/api/lens-studio/Classes/Providers.md#videotextureprovider) scripting API reference.

## Related Guides[​**](#related-guides "Copy to clipboard")

Please refer to the guides below for additional information:

* [Scripting Overview Guide](/lens-studio/features/scripting/script-overview.md)
* [2D Animation](/lens-studio/assets-pipeline/2d/2d-animation.md)
