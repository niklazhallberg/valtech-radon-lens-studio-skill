# 2D Animation

<!-- -->

Lens Studio allows you to import a sequence of textures or animated GIFs for 2D animations. The texture sequence is converted to an optimized sprite sheet and can be used as a texture asset in your project. Playback can be controlled by enabling `Always Play` or scripting when and how often the animation plays.

## Importing 2D Animations[​**](#importing-2d-animations "Copy to clipboard")

Simply drag and drop your GIF file into the `Asset Browser` panel. Lens Studio will automatically create a new animated texture resource from the GIF in the `Asset Browser` panel.

[](/img/lens-studio/5-adding-content/2d-animation-1.webm)

## Configuring the 2D Animation Resource[​**](#configuring-the-2d-animation-resource "Copy to clipboard")

Select the newly imported animation resource. In the `Inspector` panel you will see the animation settings for your animation resource. You can preview the animation at the bottom of the `Inspector` panel.

You can also see the number of frames, and the pixel size of the animation in this panel!

[](/img/lens-studio/5-adding-content/2d-animation-2.webm)

#### Always Play[​**](#always-play "Copy to clipboard")

`Auto Play` sets the animation to repeat indefinitely. For simple animation playback, enable this.

If you want it to only play at certain times, you can write a customized script. You can find more info below.

#### FPS[​**](#fps "Copy to clipboard")

`FPS` sets the frame per second of the animation.

#### Duration[​**](#duration "Copy to clipboard")

`Duration` sets how long the animation will play for in seconds.

## Using 2D animation as Texture[​**](#using-2d-animation-as-texture "Copy to clipboard")

Now your 2D animation can be used the same way as other 2D static textures in Lens Studio.

One common use case will be using the animated texture on an `Image` or `Screen Image` object. Adding a new `Screen Image` is detailed in the [Image](/lens-studio/assets-pipeline/2d/image.md) guide. This imported animation can now be used in the `Texture` field in the material settings of a newly created `Screen Image`.

## Programatic Playback[​**](#programatic-playback "Copy to clipboard")

### Using Behavior Script[​**](#using-behavior-script "Copy to clipboard")

[Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) will allow you to play your animation based on some triggers (e.g. open mouth, on tap, on another animation's end, etc.) through simple dropdowns.

### Scripting Animation Playback[​**](#scripting-animation-playback "Copy to clipboard")

For more complex animation control beyond `Auto Play` you'll have to write a script.

An example script for animation playback is shown below. It should be added to the Image or `Screen Image` object. Bind it to the event when you want the animation to play. For more information about scripting, refer to the [Scripting Overview Guide](/lens-studio/features/scripting/script-overview.md).

* JavaScript
* TypeScript

```
const loops = 1;
const offset = 0.0;

const myAnimation = script.getSceneObject().getComponent('Component.Image');

const textureControl = myAnimation.getMaterial(0).getPass(0).baseTex.control;

textureControl.play(loops, offset);
```

```
@component
export class NewScript extends BaseScriptComponent {
  onAwake() {
    const loops = 1;
    const offset = 0.0;

    const myAnimation = this.getSceneObject().getComponent('Component.Image');

    // Get the TextureProvider on this Image component, and
    // let TypeScript know that it's an animated texture.
    const textureProvider = myAnimation.getMaterial(0).getPass(0).baseTex
      .control as AnimatedTextureFileProvider;

    textureProvider.play(loops, offset);
  }
}
```

Set loops to `-1` to tell the animation to loop indefinitely. Any other number represents the number of times the animation should loop. For more information about scripting a 2D animation, see the [AnimatedTextureFileProvider](/api/lens-studio/Classes/Providers.md#animatedtexturefileprovider) scripting API reference.
