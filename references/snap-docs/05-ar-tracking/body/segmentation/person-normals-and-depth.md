# Body Normals and Depth

This guide explains how to use built-in Body Depth and Body Normal textures to relight, occlude, and make objects collide with the body. This guide is a great way to learn about using Graph materials to create various effects.

The `Body Depth Texture` provides information about the distance (in centimeters) from the camera to each pixel of the body. The `Body Normal Texture` represents the surface direction of each pixel of the body. There is no additional performance cost to using both at the same time.

There are multiple ways to get depth and normals within Lens Studio, depending on what you’re trying to do. The Body Normal and Depth Textures should not be confused with the Depth Render Target which exposes the Depth buffer of virtual objects in the Camera.

## Examples[​**](#examples "Copy to clipboard")

Examples described in this guide are available in Lens Studio Asset Library with names: `Body Normals And Depth 2D`, `Body Normals - Arrows`, `Body Normals and Depth - Cartoon Water Pool` and `Body Normals and Depth - Water Ripples`

### Body Normals And Depth 2D[​**](#body-normals-and-depth-2d "Copy to clipboard")

Import `Body Normals And Depth 2D` asset from the Asset Library and place prefab under an Orthographic Camera.

![](/assets/images/body-normals-0-021730a36b35950e5b38bb3096dc61ea.png)

In this example the Body Normals texture is used as an input for different Graph materials. These examples use the texture in 2D space, hence they are all under an Orthographic Camera.

Take a look at the [Body Depth and Normals](/lens-studio/features/graphics/person-normals-and-depth.md) guide for an in depth explanation of using the features shown in this template.

#### Simple PBR using Normals[​**](#simple-pbr-using-normals "Copy to clipboard")

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_5.webm)

This example modifies the built in Simple PBR Graph materials with the Normal Texture. It’s a great example for learning how you can integrate the Normal Texture into your own materials.

To see how it works, open the related material in the `Asset Browser` panel. In this case, open the `Simple PBR using Normals` by double clicking on it. Notice how a `Texture 2D Parameter` is added to provide an input for the `Normal Texture`. In addition, we set the `Texture 2D Parameter` node setting to be of type `Normal Map` so that the data is passed in correctly from the texture.

![](/assets/images/body-normals-2-ccc148b65838f25e3b0843c3cd907cc6.png)

Then, we extract the Alpha channel of this texture as the Opacity of the PBR (such that parts of the screen which are NOT the body will not be shown in this material). In addition, we pass the values from the `Normal` texture into the `Normal (Tangent Space)` input of the PBR node.

![](/assets/images/body-normals-1-6208210b4c8ab25f53b846da4e0d77de.png)

Finally, in the `Inspector` panel, you will find that we filled this Parameter with the Body Normals Texture.

![](/assets/images/body-normals-3-99d48cd041e7e94eea9c1dcd9f899076.png)

#### Default Uber PBR with Segmentation[​**](#default-uber-pbr-with-segmentation "Copy to clipboard")

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_14.webm)

The default `Uber PBR` material provided in Lens Studio comes with a Normal Texture field that you can use to pass in the Normals data. In addition, this template also leverages the Opacity Texture option to only show the PBR effect in certain parts of the Image. In this case, we only show it on the Upper Garment area, using the built in Upper Garment Segmentation.

![Image of Default Uber PBR with Segmentation](/assets/images/body-normals-4-f0709acf94e20ff1d0f7a9a5a59dd06b.png)

#### Default Uber PBR using Normal Alpha[​**](#default-uber-pbr-using-normal-alpha "Copy to clipboard")

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_12.webm)

This example showcases a combination of the two previous examples. As mentioned above, the Normal Texture itself contains `Alpha` (or opacity) information around where the body is. Thus, it is possible to modify the built in Uber PBR material to leverage this information to show the effects only in the areas where the body is.

First, like before, we pass in the `Body Normals Texture` into the `Opacity Texture` field. But as in the first example, we need to tell the material to use the `Alpha` value of the texture as the opacity texture.

To do this: Double click on an `Uber PBR` material, find the Opacity subgraph and double click it to open it. Then, add the `Swizzle` node in between the `Texture 2D Sample` and the `If/Else` node.

![Image of Texture 2D Sample, Swizzle, and If/Else Node](/assets/images/body-normals-5-57cc1af5e564ed33a0a412b423cf361b.png)

Then select the `Swizzle` node, and set it to `Swizzle` for `a` (alpha channel of the texture).

![Image of Swizzle Node](/assets/images/body-normals-6-053a7bd42320620aeac5ad3070121876.png)

The `swizzle` node allows you to mix the part of a vector based on some string input. In this case we only need the alpha channel of the texture, so we type in `a`.

Try changing angle of a directional light or rotation of envmap light to observe the effects.

#### Custom Examples[​**](#custom-examples "Copy to clipboard")

The next two materials demonstrate how you can apply this method in various other ways, without even using the built-in materials!

The `Custom - Shaded Cartoon` example uses the `Cartoon` material found in the Asset Library as the basis for the effect.

Take a look at the [Person Normals and Depth Guide](/lens-studio/features/graphics/person-normals-and-depth.md) to see an explanation of how this material was made!

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_17.webm)

The `Custom - Normals Relighting` example shows how you can use the normals texture to modulate how light interacts with your object.

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_9.webm)

Try taking what you learned in the previous examples and seeing how they map to these two!

#### Depth Examples[​**](#depth-examples "Copy to clipboard")

Next we can see how the Depth map can be used to create various effects. As with the Normals example, these examples use the texture in 2D space, hence they are all under an `Orthographic Camera.`

For every pixel, the `Body Depth Texture` provides the negative centimeters from the camera to the body. As with the `Body Normals Texture`, you will want to ensure that for any parameter that takes in the `Body Depth Texture`, you set the `Texture 2D Parameter` node settings to be of type `Depth Map`.

![Image of Body Depth Texture](/assets/images/body-bormals-7-97bc53d43a43e4ff16a3defd6cdb4ee2.png)

#### Simple Depth Remap[​**](#simple-depth-remap "Copy to clipboard")

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_15.webm)

In this example, we use the `Remap` node to convert the values of depth into `0-1`. This allows us to use the Depth texture as a black and white image where black pixels are closer to the camera.

Note that as mentioned above, we need to multiply the pixel values by `-1` (since the texture provides negative centimeters from the camera).

![Image of Remap Nodes](/assets/images/body-normals-8-a22582b9583f5583fb5b8470c76183ef.png)

#### Depth Slice[​**](#depth-slice "Copy to clipboard")

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_16.webm)

This example uses an `If/Else` node to only show colors between certain depths (i.e. depth value is greater than and less than some value).

![Image of Depth Slice If/Else Node](/assets/images/body-normals-9-00cc26db2fe1d18cfe317b956e21e77a.png)

### Body Normals - Arrows[​**](#body-normals---arrows "Copy to clipboard")

Import `Body Normals - Arrows` asset from the Asset Library and add prefab to the Scene Hierarchy.

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_8.webm)

We can also use these Body Normals texture in 3D as well. In the `Body Normals - Arrows` example, we use material instancing to duplicate a mesh 300 times without having to have multiple objects in the scene. Notice the `Instance Count` field in the inspector panel.

![Image of Instance Count](/assets/images/body-normals-10-ccf4f3adb7bd726c2fa39dc3ead260a7.png)

Then, we use the normals texture to orient each arrow so that they’re pointing in the direction of the normals of the body!

![Image of Normals texture direction nodes](/assets/images/body-normals-11-d5f5f274851be73f36d855899273f2f5.png)

### Combining Normals and Depth[​**](#combining-normals-and-depth "Copy to clipboard")

Import `Body Normals and Depth - Cartoon Water Pool` asset from the Asset Library and add it to Scene Hierarchy. Once imported - click on the `Render Target` input of a `Camera With Depth Input` and select your main render target.

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_19.webm)

In this example we first use the Depth Texture as an occluder such that virtual objects can be “behind” the person. In the `Camera - Depth Input` object, you can see that the Camera settings has `Depth Clear Option` set to `Custom Texture` and the input for this is set to `Body Depth Texture`.

![Image of Camera - Depth Input](/assets/images/body-normals-12-9308d2cbfac02d366cf4e7fa7673634c.png)

As a result, you can see that the user’s body can occlude different parts of the `Cartoon Water Plane` depending on where they are standing.

In addition, we pass in the Depth and Normals Texture to the VFX system so that our particles can collide against the body.

![Image of VFX using Depth and Normals](/assets/images/body-normals-13-662b380573b87778433556f77b040eec.png)

Double click on the `VFX using Depth and Normals` VFX in the `Asset Browser` panel to open the VFX graph. Within this VFX, you can see that in the `Update` loop, we added a `Collision (Depth Buffer)` node, and passed in our two textures.

![Image of Collision (Depth Buffer) node](/assets/images/body-normals-14-d4f414314fbf61165ab3f1afa9417115.png)

### Multi Camera Effect[​**](#multi-camera-effect "Copy to clipboard")

Import `Body Normals and Depth - Water Ripples` asset from the Asset Library and add it to Scene Hierarchy. Once imported - click on the `Render Target` input of a `Camera With Depth Input` and select your main render target.

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_23.webm)

In this example, you can see a more complex example of using these textures. In this case, we use multiple cameras to create a feedback loop to generate ripples that make it look like we pass through a sheet of water.

![Image Cameras and Textures used to create Multi Camera Effect](/assets/images/body-normals-15-c4617d6e5e023c7965fe9cdc16ca2eeb.png)

Try enabling the `Debug_Ripples` object to see the results of the different cameras.

[](/img/lens-studio/Person-Normals-and-Depth-Template-Guide_28.webm)

The `Ripple Plane` material, composites the final effect by taking in the result of `Depth Conversion` and `Ripple Feedback`.

Take a look at the [Ripple Guide](https://support.lensstudio.snapchat.com/hc/en-us/articles/4409969989908-Ripple-Effect) to learn more about the technique used to create this effect!

The `Depth Conversion` material is the same as the one you saw earlier! Try exploring the graphs based on what you already learned.

See another example usage of this technique in the `Optical Flow` example in the Asset Library.
