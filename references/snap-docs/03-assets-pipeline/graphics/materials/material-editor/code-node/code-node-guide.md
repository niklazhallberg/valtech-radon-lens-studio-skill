# Introduction to Code Nodes

The Code Node is an advanced feature that allows custom shader code to be written directly in Material Editor and VFX Editor, unlocking new effects and performance enhancements that were previously impossible. It seamlessly integrates into the graph editor, creating a hybrid system that brings the best of both worlds.

Code that is written in the Code Node will be almost entirely native GLSL. In the background, code is analyzed for reserved functions and keywords which define the node’s primary function, including input and output ports. It is then sent through our cross compiler to produce device-safe shader code.

[](/img/lens-studio/code-node-guide-1.webm)

## Create a Code Node[​**](#create-a-code-node "Copy to clipboard")

To create a Code Node:

1. While hovering over an empty portion of the graph, press **Tab** on the keyboard to open a pop-up.
2. In the pop-up window, type in the word `code`.
3. Select **Custom Code** from the list.

[](/img/lens-studio/code-node-guide-2.webm)

Code nodes can also be created for each container type in a VFX asset- Spawn, Update, and Output. The method to create a Code Node here is the same as before, except hover over the container instead of an empty portion of the graph and press tab

Code Nodes are created with a default function that outputs the product of two vec4 inputs.

## Writing Code[​**](#writing-code "Copy to clipboard")

You can start writing custom shader code by directly writing in the Code Node's editing field. When you are ready to apply your changes, you can do one of the following:

* Hit the shortcut **cmd + enter** on MacOS or **ctrl + enter** on Windows.
* Click the **Apply Changes** button below the field.
* Click on an empty space around the node to deselect and apply.

[](/img/lens-studio/code-node-guide-3.webm)

### Autocomplete[​**](#autocomplete "Copy to clipboard")

The Code Node features an in-line autocomplete window that suggests methods and variables as you type.

You can use the **up** and **down** keys on your keyboard to make a selection from the suggestions list. Then press **Tab** to fill in the rest of the characters.

[](/img/lens-studio/code-node-guide-4.webm)

## Example Code Snippets[​**](#example-code-snippets "Copy to clipboard")

On the Code Node’s properties, changing the dropdown selection for `Example Code` will overwrite the current node’s contents with a pre-made example. This is an easy way to find common use cases, and is particularly useful to use as reference to built-in system variables and all the available input and output types.

Selecting an example code snippet will erase what you have written in the code window!

[](/img/lens-studio/code-node-guide-5.webm)

## Creating Input and Output Ports[​**](#creating-input-and-output-ports "Copy to clipboard")

To interface with the rest of the graph, you will need to create inputs and outputs for receiving and sending values.

To create inputs, Code Node looks for special declarations in the form of `input_` followed by the type, for example `input_float` or `input_vec4`. The name you write after the input type is the variable you can use in your shader code, and it is displayed on the node’s input port.

Creating output ports is similar to inputs, except the prefix is `output_` followed by the type and name.

![Image showing the relation between code inputs and outputs and how they match up with the node](/assets/images/code-node-guide-6-73156c380ce3de3ae350b82d29f8a4a7.png)

For Code Nodes that are attached to VFX containers, the creation of output ports is blocked. Nodes stacked in VFX containers are endpoints for modifying particle attributes, so sending arbitrary data out of the right side is not allowed.

A complete list of supported Input and Output types can be found by selecting the `Inputs/Outputs/Global Types` value from the **Example Code** dropdown on the Code Node.

All built in functions can also be found in the [Code Node Reference guide](/lens-studio/features/graphics/materials/material-editor/code-node/code-node-reference.md).

## Entrypoint and Extra Functions[​**](#entrypoint-and-extra-functions "Copy to clipboard")

The `main()` function is the entrypoint for Code Node to evaluate your shader code. It must be present or the material won’t be compiled.

Extra functions outside of `main()` are allowed. Inputs can be accessed implicitly by any function defined in the Code Node and do not need to be passed as arguments from main().

```
input_vec2 Input;
input_vec2 Bias;
output_vec2 Output;

vec2 myBiasFunction()
{
   return Input * 2.0 - 1.0 + Bias;
}

void main()
{
   Output = myBiasFunction();
}
```

More examples of defining and using extra functions can be found in the Example Code droplist.

## Global Variables and .evaluate()[​**](#global-variables-and-evaluate "Copy to clipboard")

The Code Node provides a mechanism for declaring and operating upon custom variables that can then be referenced in the graph system, upstream from the Code Node itself. These variables are called Globals and can be accessed in the graph by adding a **Code Global** node. This node’s dropdown will be populated with global variables defined from Code Nodes in the same subgraph level.

When a Code Global node is a dependency of one of the inputs on your Code node, `evaluate()` can be called on the input variable name to inject the graph logic from that input into the section of code. This makes it a powerful tool for merging graph and code logic.

![image showing the steps taken to properly evaluate how content works in the code node](/assets/images/code-node-guide-7-b01ce2fc8a7fcba0e126e204b767dd86.png)

Check out the Code Node Globals examples in the Code Node Template to see Globals in action.

## System Uniforms and Varyings[​**](#system-uniforms-and-varyings "Copy to clipboard")

For convenience, we have included a number of commonly used uniforms and varyings can be accessed with the system `struct`. For example, to get the first UV coordinate attribute, you would write `system.getSurfaceUVCoord0()`.

System values appear in autocomplete suggestions when typing in the Code Node window.

Every system function has a node-based counterpart. A quick way to find documentation on a specific system function while in Lens Studio can be done by the following:

1. Create the Node version of the system you want.
2. Left-click the **i** at the top right corner of the node.
3. follow the link to the node’s full documentation page.

A complete list of system values can also be found by selecting the `System Built-In Values/Functions` snippet from the **Example Code** dropdown on the Code Node.

## Textures and Float Arrays[​**](#textures-and-float-arrays "Copy to clipboard")

Texture objects and float array types can be sampled from Code Node. This makes it easy to do all your UV calculations and procedural texture sampling all in one place.

To sample a texture, call `sample(vec2 uvCoord)` after the input you defined at the top. The syntax is similar for getting a value from a float array, `sample(int index)`.

Here's an example that gets an element from a float array to offset the uv coordinate of a texture sample:

```
input_float_array offsetArray;
input_texture_2d baseTexture;
output_vec4 color;

void main()
{
      vec2 uv = system.getSurfaceUVCoord0();
      vec2 offset = offsetArray.sample(3);  //get the 4th element of the array
      color = baseTexture.sample( uv + offset );
}
```

With both of these input types, you will need to connect their relevant object nodes to the input ports of the Code Node in order to define your texture or value. For 2d textures, that will be the `Texture 2D Object Parameter Node`, and for float arrays it's either a `Float Array Object Parameter` node or a `Float Array Object Value` node depending on if you want the float array to be settable by scripts or not. In the case of float arrays, these object nodes are also where you define the value's type: vec2, vec3, or vec4.

A complete list of sampling methods can be found by selecting the `Inputs/Outputs/Global Types` snippet from the **Example Code** dropdown on the Code Node.

## VFX Editor[​**](#vfx-editor "Copy to clipboard")

Code Nodes can be created in both Material Editor and VFX Editor. The Code Node in VFX Editor inherits all the functions from Material Editor, but adds additional getters for VFX settings and particle attributes, and functions for generating per-particle random numbers.

In VFX Editor, the standard free-floating Code Node exists, as well as a version which sits directly in the vertical stack, similar to Container Subgraphs:

![Image showing the VFX Editor iteration of a code node](/assets/images/code-node-guide-8-c73f7fcef32bd97c21f8aa75cb5bcb73.png)

Code Nodes that sit in the vertical stack also allow for setting particle attributes, making them effective replacements for Container Subgraphs and Modify Attribute nodes. However, currently custom particle attributes can not be set by the Code Node, only standard attributes such as Position, Velocity, Force, etc.

## Known Issues[​**](#known-issues "Copy to clipboard")

Listed below are some of the common issues you may run into when working with Code Nodes.

### Undo/redo[​**](#undoredo "Copy to clipboard")

Undo and redo is currently unreliable. It works, but the undo state is about 5 “undos” removed from the most previous action. To undo, click somewhere else in the graph then hit undo 5 times. This introduces another issue where it’s not possible to actually see the undo action take effect since after clicking away from the node, the code is no longer visible in the graph properties panel.

This is currently being worked on and will be addressed in a future update.

### Setting custom particle attributes[​**](#setting-custom-particle-attributes "Copy to clipboard")

For Code Nodes placed on a VFX Spawn or Update container, there is currently no way to set a custom particle attribute. A workaround is to use a regular floating Code Node and set the custom attribute with a Modify Attribute container node. All other built-in particle attributes may be set directly in a container Code Node by `system.setParticle[attributeName]()` commands.

See the [Code Node Reference guide](/lens-studio/features/graphics/materials/material-editor/code-node/code-node-reference.md) for more information.

### General code window improvements[​**](#general-code-window-improvements "Copy to clipboard")

We are working hard to improve the code editing window. Some improvements to look out for in the future include:

* Preserve indentation on new line
* Multi-line comment with ctrl + /
* Shift + tab to unindent
* Auto-resize code window height
* Remember widget scroll state
* External editor support
