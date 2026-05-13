# Post Effect Tutorial

This guide is going to demonstrate how to make post effects with a Chromatic Aberration example.

## Guide[​**](#guide "Copy to clipboard")

Create a `Graph Post Effect` from `Asset Browser panel > + > Graph Post Effect` and apply it to a Post Effect component.

The default graph might look complicated, but what it actually does is just color the screen texture with a LUT map and then multiply it with a color parameter to give an extra tint. The entire structure can be as simple as this:

![](/assets/images/post-effect-tutorial_peg_01-67c8b2a03700a316f64b368bfce56ea4.jpg)

LUT stands for Lookup Table. The `LUT Map` nodes takes a target (which will be our screen texture) and colors it with a LUT map input.`Texture Sample` will come in handy when you only want one texture input but different UV Coords:

![](/assets/images/post-effect-tutorial_peg_02-b1812d73788ac6e50b85b655dd9b5d2d.jpg)

### Chromatic Aberration[​**](#chromatic-aberration "Copy to clipboard")

Now, let's make a chromatic aberration effect. The process can be broken down into two steps: offsetting screen texture and assigning RGB colors.

By adding or subtracting UV, we can offset `Screen UV Coord.` We start from a new graph, drop in a `Screen UV Coord` node and separate `Screen UV Coord.x` and `Screen UV Coord.y` with a `Split` node. Under `Split` node we can set Output 3 to disabled, since we won't be using it. Create a `Float Parameter` and name it "Chromatic Aberration Offset". This will be an offset controller. Check `Enable Min` and `Enable Max` to turn this parameter into a slider.

To offset the image horizontally, let's work on one side first by using a `Subtract` node to subtract the “Chromatic Aberration Offset” from `Screen UV Coord.x`. Combine this result back with original Screen `UV Coord.y` with a `Channels (Mixer)` node, and you get a new UV coordinate:

![](/assets/images/post-effect-tutorial_peg_03-30cc168ec21f8b4737914486cc3d1305.jpg)

Create a `Screen Texture` node and connect it with a `Sample Texture`. Hook up our new UV to its `UV Coords.xy` input, and then feed the result to a `Shader 3D` at the end.

[](/img/lens-studio/post-effect-tutorial_peg_04.webm)

We can name the first texture we made "Left" and move on to create an `Add` node to add chromatic aberration offset to `Screen UV Coord.x`. Follow with a `Channels (Mixer)` node to combine `Screen UV Coord.y` back together like we did for Left. Plug it into a new `Texture Sample` node, feed in the same `Screen Texture` node and let's call this result "Right".

Besides hitting Tab hotkey to create new nodes, we can click and drag from an input or output for quick graph building:

[](/img/lens-studio/post-effect-tutorial_peg_05.webm)

Let's give `Screen UV Coord` its `Screen Texture` by connecting them straight to a new `Texture Sample` and call it "Center". We have Center, Left and Right split by chromatic aberration offset. Create a `Channels (Mixer)` node again to read in RGBA but only output `R` channel from the Center texture. Same for the `G` channel from Left and `B` channel from Right. Create one final `Mixer` node to connect all three texture sample outputs. On the `Mixer` node, you can expand how many inputs are accepted by the `Channels` dropdown menu. Finally connect this result to a `Shader 3D` node and we are done:

[](/img/lens-studio/post-effect-tutorial_peg_06.webm)

Here is how the entire graph looks like:

![](/assets/images/post-effect-tutorial_peg_07-e6be15c5bf74e710332f5f3e801b5f8c.jpg)

##

## Downloads[​**](#downloads "Copy to clipboard")

[Download the example material for chromatic aberration](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/kfmqObLkNr_3_0/Material-Editor/files/PostEffectChromaticAberration.lsmat.zip)
