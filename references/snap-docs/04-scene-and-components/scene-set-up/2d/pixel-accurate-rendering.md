# Pixel Accurate Rendering

When working with 2D elements, in some cases, you might want to render content perfectly based on their pixel size. For example: a logo which you want to be correctly sized to avoid aliasing. Or, if you’re designing UIs in an external software, it can be useful to be able to translate exact measurements (e.g. pixels or points) from those software into your Lens.

Lens Studio allows you to switch the units you are working with to help you translate these external assets into your Lens, as well as leverage the entire resolution of the device’s screen by using [Canvas](/lens-studio/lens-studio-workflow/scene-set-up/2d/canvas-component.md) and [Overlay Render Target](/lens-studio/lens-studio-workflow/scene-set-up/camera.md).

## Rendering to a Device’s Native Resolution[​**](#rendering-to-a-devices-native-resolution "Copy to clipboard")

A Lens is rendered through a variety of “Render Targets” (i.e. textures that the cameras in your scene send its results to). By default, you are taking advantage of the “Capture Target” and “Render Target”. That is: when you are seeing the Lens live, you will see whatever is on the “Render Target”, and when you take a Snap, you will see whatever is in the “Capture Target”. This information is set up in the `Scene` asset found in the `Asset Browser` panel. Learn more in the [Camera](/lens-studio/lens-studio-workflow/scene-set-up/camera.md) guide.

Learn more about Render Targets in the [Scene Set Up guide](/lens-studio/lens-studio-workflow/scene-set-up/camera.md#live-target-and-capture-target)

In addition to these render targets, you can use the Overlay Render Target. Unlike the Capture and Live target, this target runs at your device’s full resolution! This is useful when you’re looking to display detailed content such as texts.

Since Overlay Render Target is taking full advantage of the current device’s display, it is not possible to show them in a recorded Snap.

On the left you can see the same camera rendering on an Overlay Target, and on the right a camera rendering on Live Target. Notice how. in the left image, the rulers are a bit smaller--this is because the image is rendering at the simulated device's native resolution which is higher than the normal Lens resolution.

![](/assets/images/pixel-accurate-rendering-1-7aafe4ff52f8a4f3bfc4045f3aa5e67c.png)

To do this:

1. In the `Asset Browser` panel > + > Render Target.
2. In the `Scene Hierarchy` panel, select the camera object you want to render at full device display resolution.
3. In the Inspector panel, in the Camera component, select the field “Render Target” and choose your newly created Render Target.
4. In the `Asset Browser` panel, select the `Scene` Asset, and in the `Inspector` panel, modify the field `Live Overlay Target` and choose your newly created Render Target.

![](/assets/images/scene-asset-live-overlay-c35248483b2f2aa31825eb149dafa857.png)

**Pro-tip:** Doing `Scene Hierarchy` panel > + > `Overlay Camera` will automatically do the above step for you!

If you don’t see the `Asset Browser` panel, in the Lens Studio menu bar > Window > General > Asset Browser.

You can download the following textures to help test the result of your set up;

* [Download](/assets/files/pixel-accurate-rendering-ruler-1d71fd31934bc10498013d52804f26de.png) the ruler texture.
* [Download](/assets/files/pixel-accurate-rendering-grid-58943990db5c2aa6d5aa65033c015617.png) the grid texture.

## Choosing the Units for a Camera to Use[​**](#choosing-the-units-for-a-camera-to-use "Copy to clipboard")

By default, objects are positioned in World Units. But by adding the Canvas component on a Camera, you can tell every descendant of the camera to use a different unit:

**Pixels**: are the smallest addressable element on a display **Points**: sometimes referred to as “Density Independent Pixels (dp)”, are abstractions of pixels that make it easier to deal with displays of different densities.

**In most cases, you will want to use Points**, as they make it easier to handle the wide variety of devices that can display Lenses. That is to say: on a newer device with a high density display, a 500x500px image can show up in the corner of the screen, where as on an older device it can take the whole screen.

![](/assets/images/pixel-accurate-rendering-3-ea483ce9342b937d197878fec8bcc843.png)

To do this:

1. In the `Scene Hierarchy` panel, select the camera object you want to render at full device display resolution.
2. In the Inspector panel, press “Add component”, then choose “Canvas”.
3. In the newly added Canvas component, choose “Points” from the drop down menu.

![](/assets/images/pixel-accurate-rendering-4-4a6b90789092aece3e13c83814cfdbfb.png)

[Download](/assets/files/pixel-accurate-rendering-500x500-ea7b0f063311e2cd87887c09b06e46e9.png) the example 500x500px texture which is shown in the demo above.

## Setting Up an Image[​**](#setting-up-an-image "Copy to clipboard")

Now that the camera and Lens is set up, you can configure your content as you normally would. For example:

With your Orthographic Camera selected, add a new Screen Image in the `Scene Hierarchy` panel.

![](data:image/png;base64,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)

With the newly added image selected, in the Inspector panel, you can configure its Screen Transform to use a Fixed Size, and notice that we’re no longer sizing based on the normalized of the screen (0-1) but rather absolute value (what we chose earlier).

![](data:image/png;base64,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)

Note that not all the values in Screen Transform component will use Canvas' units. For example, if you want to offset the Position of the image, by default it’s still using normalized units (that is, `1` being the screen size), since the image would not know how the absolute value should relate to the canvas.

To have these offset values use the units we chose earlier, you can use `Pin to Edge`.

![](/assets/images/pixel-accurate-rendering-7-a57334054f598924c7bd4434f8245272.png)

Different devices will have different aspect ratios and sizes, so you should ensure that your positioning and sizes still work in a variety of displays. I.e. 100px offset from an edge may be closer or farther from the center of the screen depending on the device.

![](/assets/images/pixel-accurate-rendering-8-ae5694b6235261b05eded4cfd9db613e.png)

## Advanced Usage[​**](#advanced-usage "Copy to clipboard")

As you continue to improve the visual quality of your Lens by leverage device native resolution, you should keep in mind how this might affect the rendering of elements.

### Ensuring Pixel Accuracy[​**](#ensuring-pixel-accuracy "Copy to clipboard")

Setting up your scene correctly is critical to ensuring you are displaying your content as you intended. In some cases you might want to inspect the resolution a camera is rendering at. You can do this with a small script:

```
// @input Component.Camera camera
const orthoSize = script.camera.getOrthographicSize();
print(orthoSize);
```

Depending on the preview settings, Canvas settings, and render target, you can get quite different results! So it’s very important to make sure you’ve set up your scene correctly. For example, on one phone's preview you might get the following:

* Default Orthographic Camera settings: `{x: 11.1111, y: 20}`
* With Canvas component set to Pixels: `{x: 800, y: 1440}`
* With Canvas component set to Points settings: `{x: 11.1111, y: 20}`
* With Canvas component set to Pixels settings, on Overlay Target: `{x: 1179, y: 2097}`
* With Canvas component set to Points settings, on Overlay Target: `{x: 393, y: 699}`

In most cases you will want to use Canvas Component with Overlay Target. If you don't use the Overlay Target, you will be using the pixel resolution of the input camera.

With those values, you can notice that the Pixel settings on Overlay Target is 3x the value of the Points settings on Overlay Target. This is because the chosen preview has a higher density display.

This higher density specification may sound familiar if you’ve used other software that allows you to define different resolutions on image export (e.g. @1x, @2x, @3x).

In most cases you will want to use Points as your setup will apply to more devices (i.e. regardless of their device density).

More importantly, this flexibility means you have to pay attention to how you export your image from other software. That is: if your other software exports at pixel values (e.g @3x for the high density phone illustrated above), to get it to look right in Canvas, you will want to use the Pixels unit. However, if you export it in Points (e.g. @1x), you will want to use the Canvas in Points unit.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOoAAACCCAMAAAB/7aRLAAAAtFBMVEX///8ZGRklJSX7+/v5+fns7Ozx8fGysrItLS39/f05OTnp6en19fW5ubnz8/NBQUF/f39cXFz39/fg4ODZ2dmsrKy9vb1GRkbIyMju7u7S0tLm5uYyMjKnp6fExMSwsLBVVVVOTk7T09PPz8+enp6NjY17e3u2trZhYWFkZGSamprW1taEhITc3NyUlJTr6+tLS0vj4+Nra2txcXFmZmbMzMzAwMCQkJC7u7t3d3eKioqMjIxoFqJPAAAERklEQVR4Xu3Z127jVhSF4bVPYe9U7713ufv93ysk5ExiJBmPaRuhNfuDDgmCVwvi3Y9vgzHGGGOMMcYIb1PtnP07TO1RLsB/mfpXNHUyGo1sVwNtw3BlqpAxXABuM0j34ry/nql3yDyKpk9+JIaUPasFUd1FWKdF9jy8nqn1ON5Ai5kTI6JNw7FwT/5ILBFSNTXE2cD/i/5S4P2rqXEUrYAJUYqIDOyoPTgAM2GHMQAxw5V9wJgSjRCRxpTcuA48CoTLa5v65Pu+Sum5fpARnftWByvq1uh0meocKtcytUG5Ztzxbqkb0YI6Y8hHothAeAOgKupXMvW1iBAgpxL8Salrnfq7SMf4F4wxxhhjjDHGGGOMsWTtoYhWVO8cdhKA3GoUZWd1V+Y3ZJoegKSi8DVMUScT73fb8Q3o2UBi3alThII0OR0xhaYugGUf9ow6tLPxBaRoodaBYQBNA79OibEbPa62py5uVtB0TFwg0AWmAltxq0kc86m4DzUqwsQXqTnoWUFTtPDrxgMZTqpUa9wgo8nVYmQPJoWmIu5q2g1lPtVpAWj4Ly/xpmd6fnX9qXUsasD5abbBO0w22wGwqKUHILkRU6A6NA+yyFR7TC1NcrjLphqk4LXbe+RgakCb+o36+ur6U/vqYmCjaTneu6Y+5SMHtfEAkPOZ04Y9oAoKTLWEtYImpGK97Afk4cGxhsjlM7PfZ/2rygWUGKEtLAPvcLeQ4fSZZqcp2hJYTCDrdFtkqmEgvwHdMO4j7AGYnPHnVlPjs2i6sxu0x+I+OuMdAqvl3u8q0dRD/V62O3OsBr6TFJj642bH1EfXaslby8cLrfF5+hZZfcydJLB6eIcHq7pHswJgFBJt5FFssZh+ZCpc0QdWDjldfBEDhaSPh064Qy6Q+EQBvh5jjDHGGGOMMcYYY4wZFfnBvqoq3rfoqxNyrMqH+mpDhGR+g74aUIr7E1wPcFWxvjqsomHZl0Jb5r7qtQAzxnSBXico1lfHCVySl0Jb7r4Kw/GhnFpYK9pXYZ82L4W23H01GWwANOiEon0VT8MEl0Jb5r4KeXOSAHyK7YJ9FRNHA5dCW+a+isdYATCsXr1asK/2O20Al0Jb5r7aooxAdEZL6GJ9lXKVS6EteV/Fh/sq8N36KmOMMcYYY4wxxhhjjBlNFCINhR+aWy8/rl3mvloVSxSRmnfmGi8Cc51kx/CDEvdVc7hZokAbVWaAZG7YCSCVfewlMjt2YisFKFnKvqpldYkCbVTNPWSMOyAdGbV5T2dHmkr7Us2NkvbV6rJQG03nt0f5MhVuA/mBqTCujNZl7avVZbE2qo6NB/XPqcp/kOXsq/nUIm1UeQAaR6MGbF9N9ea+KmdfzacWaaOB78HztTS1uns1tVFZj8vZV4HqDYq00bTmzyvAdu6P/z61/WBLf39lfRUKOZv76psYY4wx5iGHdmHIwcMnY38A4+B5AFx6dg4AAAAASUVORK5CYII=)

Exporting at the right resolution will improve the rendering quality of your texture, as it doesn’t have to be resized by the renderer, which might result in aliasing.

Pro-tip: You can optionally write a script that switches between different texture sizes based on the device density display.

### Working with Text component[​**](#working-with-text-component "Copy to clipboard")

The size of a text component is unaffected by Canvas’ unit settings, as they are just correlated with the screen height. Meaning: you don’t need to do anything special!

However, you should note that since screens might have different aspect ratios, or overall size, text might flow differently. In addition, the Screen Transform settings will still apply as usual. So, as always, you should check your Lens with different devices in the Preview panel.

In the image below, you can see that the Text Component might overflow outside of the Fix Size dimension set in the Screen Transform component. The two images change because the screen resolution changes on device, NOT because the font size changes.

![](/assets/images/pixel-accurate-rendering-10-feb1e3e08753436326963c0c3c637240.png)

If we change the Canvas component to Pixels unit, note how the font size stays the same, but the width of the text box changes. This is because these two devices use a higher density screen–meaning that the fixed size we set earlier in Points, needs to be multiplied by some factor (screen density) in order to achieve the same look.

![](/assets/images/pixel-accurate-rendering-11-043b60c803cc0d3efb42f1ef2b2be351.png)

Pro tip: It is possible to get the calculated pixel/points size of a text component by using Extent Target. That is: You can set the Extents Target of the Text Component, to another Screen Transform, and that Screen Transform will be resized to match the actual text component size (e.g. instead of the “baked in” Screen Transform setting of the Text component). You can then get the size of the Extent Target’s Screen Transform, to get the dynamically calculated points/pixel size of the Screen text!

### Working with Shaders[​**](#working-with-shaders "Copy to clipboard")

When you’re making a Material graph, it’s important to consider how the wide variety of sizes can impact your shader.

For example, if you’re calculating a rounded border, the radius of the border might dramatically change based on the units the camera is rendering at. That is: by default the camera size is 20, but when using the Canvas and Pixels unit, the camera size will be whatever size pixels the device screen has.

One way to account for this, is by using the Code Node and getting the projection matrix to understand the size of the camera, then using that as a multiplier.

```
bool epsilonEqual(float a, float b) {
    return a + .0005 > b && a - .0005 < b;
}

vec2 ImageSize = vec2(scale_x, scale_y);
bool isOrtho = !epsilonEqual(system.getMatrixProjection()[3].w, 0.0);

if (isOrtho) {
    vec2 orthoSize = abs(vec2(system.getMatrixProjection()[0].x, system.getMatrixProjection()[1].y));
    //We use 20.0 as the baseline because it is the default camera size
    float orthoRatio = orthoSize.y / 0.1;
    ImageSize = ImageSize * orthoRatio;
}
```

You can see an example of this in the `9 Slicing Material` found in the Asset Library.
