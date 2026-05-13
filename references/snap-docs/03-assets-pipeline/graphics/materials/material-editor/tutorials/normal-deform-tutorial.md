# Normal Deform Tutorial

This guide is going to show you how to use Vertex Position and Vertex Normal to manipulate your mesh. It will also demonstrate `Swizzle`, `Elapsed Time`, adjusting UV using `Mix`, and using `Conditional` to test your shader result.

## Guide[​**](#guide "Copy to clipboard")

Let's get started by importing a mesh. I'll be using the roots mesh and texture in the package here, which you can also find in the downloads list below.

Now, assign our imported roots mesh with a default `PBR(Lighting)` shader, and replace Albedo Base texture with `LP_blinn3SG_BaseColor`, Normal with `LP_blinn3GS_Normal`, Material Params with `LP_blinn3SG_Mask`, You will see that the texture on the roots are stretched out, which is not something we want:

[](/img/lens-studio/normal-deform-tutorial_nd_01.webm)

This can be fixed by adding a Mixer node to help us. Add a new Channels (Mixer) node and select it so we can make some changes. Set `Input A` to `x` channel, and link the `UV Scale` node to `Input B`. Next, set `Output 1` to `xy` channel, with `X` outputting to `A.x`, and `Y` outputting to `B.x`. We are no longer scaling UV by both the x and y axis, because x will always be 1.0.

Select the `Scale Coords` node and check `Enable Min` and `Enable Max` so that the parameter will turn into a convenient slider.

By holding down shift on your keyboard, you can drag a node over a connection to automatically insert it between the other two nodes.

[](/img/lens-studio/normal-deform-tutorial_nd_02.webm)

Now what if we want to change the thickness of our roots? This can be achieved by subtracting the normal vector from position to expand vertices along the normal. Let's create a `Surface (Position)` and a `Surface (Normal)` node, link them together with a `Subtract` node and connect the result to `World Position (Vertex).xyz` input under `Shader 3D`.

After that, go ahead and make a Multiply node in between and follow up with a `Float Parameter` node named "Factor" which will become our thickness controller. You will find that when dragging the slider to the right, roots actually get thinner, the functionality is there but the logic is not what people are used to. We always want to make our UI user friendly! In this case dropping in a `One Minus` node can flip the result, so when the Factor number gets larger our mesh will go thicker:

![](/assets/images/normal-deform-tutorial_nd_03-6919141284d8de35324b32edca7a5ac8.jpg)

Can I have more control of the shape? The answer is yes! Let's import a black and white ramp texture and see how it looks when applied to our roots. This can be done by creating a new `Texture 2D Parameter` node to replace the original Albedo and call it “Alpha”. This is a great way to visualize and examine your inputs:

![](/assets/images/normal-deform-tutorial_nd_04-1754167f0b019283aafa1ce01c91a98c.jpg)

What if we use this black and white information to control how much we scale our roots? Drop in a `Swizzle` node after “Alpha” `Texture 2D Parameter`. We can get just the alpha channel out by typing in "a" in the `Swizzle` field. If an image is packed with different information in each RGBA channels, both the `Swizzle` and Split nodes can come in handy to extract each channel.

Plug in this red channel information to `Multiply` with “Factor”. Also don't forget to reconnect back our Albedo! Now we have a viny looking roots:

![](/assets/images/normal-deform-tutorial_nd_05-30679daec43989642eba35e920acb1ef.jpg)

To spice things up, we can modify the UV of our texture by using an Add node, or more straightforwardly, an `Offset Coords` node. Hook in a `Mixer` node again to make sure we only add numbers to one coordinate, and finally create an `Elapsed Time` node to let time takes over the scrolling animation:

[](/img/lens-studio/normal-deform-tutorial_nd_06.webm)

What more fun nodes can we can throw in here? Let's create a `Conditional` node, connect the swizzled alpha texture into True and Albedo into False, then make a `Bool Parameter` and give it a good name. This will become a checkbox for us to view two different textures with one click.

[](/img/lens-studio/normal-deform-tutorial_nd_07.webm)

At the end we can create some comment boxes to help us read it. `Comments` can be very useful when other people look at your graph too. Just simply select all the nodes you like, right click and select `Create Comment Group`. To make a graph cleaner looking, there is an option if you right click on an input and select Wireless:

[](/img/lens-studio/normal-deform-tutorial_nd_08.webm)

Here is the overview of the entire graph:

![](/assets/images/normal-deform-tutorial_nd_09-cee2786644bbd81e0729095f864ce1ee.jpg)

See the downloads below for the final material as shown in this guide, and a more advanced use in a preexisted lens.

## Downloads[​**](#downloads "Copy to clipboard")

[Download the example mesh and material](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/VSUgfdso3432df_2_3_0/files/Normal_Deform_Guide/nd_GraphPBRNormalDeform.lso.zip)

[Download the example horn growth project](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/VSUgfdso3432df_2_3_0/files/Normal_Deform_Guide/nd_horns.zip)
