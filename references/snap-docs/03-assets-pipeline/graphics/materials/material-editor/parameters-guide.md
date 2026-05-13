# Parameters Guide

In this guide, we’ll take a look at Parameter nodes. These nodes allow you to create an interface for your material that lets you easily change colors and values from the `Inspector` panel in Lens Studio. They also allow you to add textures to your material, and control your material with scripts.

## Using Parameters[​**](#using-parameters "Copy to clipboard")

To create a parameter, add a Parameter node and connect it to your graph. Parameters only appear in the `Inspector` panel if they are connected to a chain of nodes that eventually make it to the Shader node at the end.

[](/img/lens-studio/parameters-guide_parameters_connecting_3_0.webm)

## Controlling Materials with Scripts[​**](#controlling-materials-with-scripts "Copy to clipboard")

One of the most powerful features of Material Editor is the ability to create custom materials that can be controlled with scripts. You can do this by using the `Script Name` of a Parameter node.

On the Parameter node settings, take note of the `Script Name`. This is the variable name you’ll be using in your scripts. Parameter nodes are given a semi-random Script Name by default as not to conflict with other parameters. Feel free to change it to any script-friendly name.

In your script, you can get or set this parameter through the material’s mainPass property, the same way you normally would.

Make sure your `Script Name` doesn’t start with a number, has no spaces, and no special characters.

### Example[​**](#example "Copy to clipboard")

![](/assets/images/parameters-guide_parameters_script_name_3_0-64d69b66e6a7e50846dace842bcc0bdd.jpg)

Say we created an Int Parameter with a script name called `myIntParameter`, connected it up to our material, and set the value `5` in the Inspector. In a script, we could do something like:

```
//@input Asset.Material material
print('Starting value: ' + script.material.mainPass.myIntParameter);
script.material.mainPass.myIntParameter = 1;
print('Changed value: ' + script.material.mainPass.myIntParameter);
```

In your Logger, you should see:

```
> Starting value: 5
> Changed value: 1
```

Copying and pasting parameters will reset the script name to a new semi-random default name. Be sure to change this if you expect the script name to be the same after copying and pasting parameters from one material to another.

## Customizing Your Material Interface[​**](#customizing-your-material-interface "Copy to clipboard")

Parameter nodes allow you to create highly customizable interfaces to your materials. Knowing how to organize your parameters as they appear in the Inspector can be useful when you have a lot of parameters or want to group together parameters that perform related functions.

![](/assets/images/parameters-guide_parameters_custom_interface_3_0-bc7182ff2ced4020490b3bbac9f388f1.jpg)

### Title[​**](#title "Copy to clipboard")

This is the name of your parameter that will be displayed in the Inspector. It can include spaces and special characters. The Title is not the same thing as the Script Name!

### Ordering[​**](#ordering "Copy to clipboard")

To control what order your parameters appear in the Inspector, you can change the `SortIndex` in the Parameter Node’s settings. Lower numbers will appear higher in the Inspector.

SortIndex can be a negative number if you want! This is useful if you already have a bunch of parameters and want to add a new one at the very top without changing the order of everything else.

### Groups[​**](#groups "Copy to clipboard")

To create a group, simply type a name into **Group** in the Parameter Node’s settings. The Group name can include spaces and special characters. Add additional parameters to the group by using the same group name.

Sub-groups can be created by using a period, `.`. For example, the group name `PBR Parameters.Colors` would create a group called `PBR Parameters`, and `Colors` would be a sub-group of that.

### Sliders[​**](#sliders "Copy to clipboard")

For Int Parameters and single-value Float Parameters, sliders can be displayed in the Inspector by checking both `Enable Min` and `Enable Max` in the Parameter Node’s settings. `Min` and `Max` control the slider’s range, while `Step` adjusts how fine of an adjustment you can make with the slider.

Min and Max do not clamp the values of these parameters coming into your material. They only affect the minimum and maximum range of the slider, which can be overridden with a script!

### Tooltips[​**](#tooltips "Copy to clipboard")

Tooltips display text to users when hovering over a parameter in the `Inspector` panel. Add relevant information in the **Tooltip** field of the Node Parameter’s settings panel to customize this text.

## Parameter Node Reference[​**](#parameter-node-reference "Copy to clipboard")

Up until now we’ve looked at properties that are shared across all parameters. Now we’ll look at all the individual parameters and some of the unique settings that exist for each one.

### Bool Parameter[​**](#bool-parameter "Copy to clipboard")

The Bool parameter creates a check box in the Inspector. In the Material Editor, it returns 0 or 1 depending if it’s on or off.

The Static setting tells Material Editor if this parameter will be changing at runtime. If it’s set to Static that means it will not be changing, in which case Material Editor can make some optimizations in the background to speed up your material. The downside is that if Static is enabled, you won’t be able to change the value of this parameter with a script.

Static is enabled by default.

### Bool Group Parameter[​**](#bool-group-parameter "Copy to clipboard")

The Bool Group parameter gives you a check box next to a group in the `Inspector` panel. When checked off, it hides parameters that are assigned to the group. This lets you create materials that have dynamic or optional functionality based on enabling or disabling bool groups.

### Color Parameter[​**](#color-parameter "Copy to clipboard")

Color parameters display a color picker in the Inspector. You can select how many channels it has: RGB or RGBA.

### DropList Parameter[​**](#droplist-parameter "Copy to clipboard")

A DropList creates a dropdown menu in the Inspector. You can choose how many items in the list you want, and provide titles for each item. In Material Editor, the value it returns is the index of the selected item, starting at `0`. This is useful when used in combination with a `Switch` node.

### Float Parameter[​**](#float-parameter "Copy to clipboard")

A Float parameter is one of the more customizable parameters, allowing you to create a single channel float, or a vec2, a vec3, or a vec4 parameter. Single float values can be turned into sliders (see the Sliders section above).

### Int Parameter[​**](#int-parameter "Copy to clipboard")

Int parameters are similar to single channel float parameters, except they always return an integer value in Material Editor.

### Texture 2D Parameter[​**](#texture-2d-parameter "Copy to clipboard")

The Texture 2D parameter is an all-in-one way of adding a texture parameter to your material, and sampling it at the same time.

**Type** tells Material Editor whether or not this texture is a Normal Map.

**UV Coords Mode** lets you change what UV coordinates are used when sampling the texture. Changing it to Custom exposes an input on the node, letting you pass in your own UV coordinates.

**LOD Mode** tells Material Editor which mipmap level to choose.

Mipmaps must be enabled on texture parameters in the Inspector for LOD Mode to work.

**Expose Size Outputs** shows two additional vec2 outputs on the node. **Texture Size** is the dimensions of the texture in pixels. **Pixel Size** is the width of a pixel in 0-1 range, or (1/Texture Size).

### Texture 2D Object Parameter[​**](#texture-2d-object-parameter "Copy to clipboard")

Texture 2D Object parameters return just the texture object itself, without any sampling. You can wire this into a Texture Sample node to sample it. This is useful if you want to send textures into sub-graphs, or sample a texture multiple times with different UV coordinates.
