# UV Blend Tutorial

In this guide, we'll look at using UV coordinates to control blending between two textures. We'll use `Swizzle`, `Remap`, and `Mix` to achieve the effect.

## Guide[​**](#guide "Copy to clipboard")

We'll start with the blend mask, which is a single value will tell us which texture to use. A value of `0` will display one texture, and a value of `1` will display the other. Values in between will be a ratio of one or the other.

In the material below, we use a `Surface UV Coord 0` node to get the UV coordinates of our mesh. UV coordinates contain two components - a vec2 - but in this case we only care about the second component. Wire the UV coordinate it into a `Swizzle` node and type `y` into the Swizzle parameter. This grabs the second component of the UV coordinate.

Next, we plug that into a `Remap` node, and the `Remap` output into the Color (Pixel) input of the `Shader (3D)` node. If you're using a Plane mesh, you should see a black and white vertical gradient. Play with the `Range Min In` and `Range Max In` parameters on the `Remap` node to compress the range of the gradient. In the picture below, I set Range Min In to `0.3` and Range Max In to `0.7<code>.`

![](/assets/images/uv-blend-tutorial_uvblend_2_3_0-a015d74e0d956f0da4743a25b73f99e5.jpg)

Now let's use this gradient to control where two textures blend together. Add a `Texture 2D` node, a `Noise (Simplex)` node, and a `Mix` node.

Wire Texture 2D into the `A` input of Mix, Noise into the `B` input, and the Remap output into `Ratio`.

Use the same UV coordinates to drive the `UV Coord` input on Texture 2D and the `Seed` input on the Noise node.

Finally, plug the output of `Mix` into the `Color (Pixel)` input of the Shader node. You will probably need to assign a texture to your newly created Texture 2D parameter on your material in Lens Studio. You should have something that looks like this:

![](/assets/images/uv-blend-tutorial_uvblend_3_3_0-1fdef8947546efe12b26f9617d324eb8.jpg)

Now play again with the input ranges of the Remap node: by changing these numbers, we have quick creative control on what the blend region looks like.

One final note: changing the Remap input ranges can cause the output of the remap to go beyond the output range which can cause undesired effects. We can fix this by adding a Clamp node after Remap, or by simply checking `Clamp` on the Remap node’s settings.

## Downloads[​**](#downloads "Copy to clipboard")

[Download the UV Blend Material](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/jbanbO_WIj2p3i_2_3_0/files/UV-Blend-Material.zip)
