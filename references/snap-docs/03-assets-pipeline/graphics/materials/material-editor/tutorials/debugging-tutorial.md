# Debugging Tutorial

This guide shows an example of how we can use the `Switch` or `Conditional` nodes to debug our materials. This way, you can better understand what's happening in your graph and how to solve problems. As your materials get more complex, debugging becomes an increasingly important technique to have in your back pocket.

## Guide[​**](#guide "Copy to clipboard")

The easiest way to debug a material is to send the output from a node we're curious about to the shader's Color output and verify the results visually.

Beginning with the Graph PBR material, I first created a `Switch` node and placed it after the PBR node. I connected the output of the PBR node to `Value` for `Case 0`, and connected the output of the Switch to the `Color (Pixel)` of the shader.

At this point it's essentially a passthrough and doesn't do anything, but now we can start connecting different elements to the other cases. Feel free to connect anything you want- in this example I've attached several surface properties such as `Surface Position`, `Surface Normal`, and `Surface UV Coord 0`.

![](/assets/images/debugging-tutorial_debugging_1-b610d5a160e4dce5ee99d5e8590a3466.jpg)

For convenience, I added an `Int Parameter` to the `Switch.x` input on the Switch node, which gives me a control on the material to easily toggle which case I'm looking at.

The colors of the surface properties we're visualizing represent values in the data. Pixel color values range from `0.0 - 1.0`, so if we're looking at the Surface Normal and the color is bright red, we know that the normal at that point is `(1.0, 0.0, 0.0)`.

![](/assets/images/debugging-tutorial_debugging_2-0754918135e1f9706fa5c9d0f18a479c.jpg)

Another way to verify and debug your material is to pass data through a `Conditional` node. In the example below, I'm taking the `Surface Position` in World Space and selecting the `x` component with a `Split Vector` node. That goes into an `Is Greater` node, which compares the A input with the B input. Here I'm seeing if the `x` world space position is greater than `0.0`.

Finally, the output of Is Greater is used for the `Bool.x` input on the `Conditional` node. Conditional nodes switch between True or False cases based on the Bool input. I've hooked up the output of the PBR node to True, and set False to be a red color. This shows us exactly where on our shader the world space x component becomes greater than zero:

![](/assets/images/debugging-tutorial_debugging_3_3_0-f44e5c62c0314b69f56e7152ecf3f2e6.jpg)

Switch and Conditional nodes are powerful tools for debugging various operations and data in your materials. If you get stuck creating materials and are wondering why it's not working, try visualizing each step in the process.

## Downloads[​**](#downloads "Copy to clipboard")

[Download the Debugging Example Materials](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/jbanbO_WIj2p3i_2_3_0/files/Debugging-Materials.zip)
