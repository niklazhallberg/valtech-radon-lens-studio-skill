# Person Normals and Depth

Lens Studio comes with two built-in textures that provides information about surfaces of the body. The **Body Depth Texture** provides information about the distance (in centimeters) from the camera to each pixel of the body. **The Body Normal Texture** represents the surface direction of each pixel of the body. There is no additional performance cost to using both at the same time.

## Body Normals Texture[​**](#body-normals-texture "Copy to clipboard")

Use the **Body Normals Texture** to apply realistic lighting effects to bodies.

### Getting started with the Body Normals Texture[​**](#getting-started-with-the-body-normals-texture "Copy to clipboard")

Normals tell you the shape of a surface at a given point. The **Body Normals Texture** contains estimates of the body's shape for every pixel in the image.

Add a **Body Normals Texture** in the `Asset Browser` panel:

![](/assets/images/person-depth-and-normals-1-6750640b636e631fc39dd065f4858f7b.png)

The **Body Normals Texture** has four channels. The first three channels correspond to the XYZ direction of the normal with respect to the camera:

* +X directs to the right of the camera
* +Y directs up
* +Z directs towards the viewer

The fourth channel corresponds to the confidence in the normal estimate. A low confidence value implies that the normal estimate may not be accurate.

The **Body Normals Texture** only produces values for a single person. See which person is associated with each texture by clicking on the texture in the `Asset Browser` panel.

![](/assets/images/person-depth-and-normals-2-af0121b20e5cc8341031e71488b0b0be.png)

### Use the Body Normals Texture as a normal map[​**](#use-the-body-normals-texture-as-a-normal-map "Copy to clipboard")

Create a simple PBR material that uses Body Normals to light a person using the PBR shader node.

Open the **Body Normals PBR** node:

![](/assets/images/person-depth-and-normals-3-41463522ebfc12142022baccb95cafb0.png)

Here, the normal texture is passed into the material as a Texture 2D Parameter. In order to use the normal texture, make sure that it's sampled as a `Normal Map` which converts its values from their texture representations (values between 0 and 1) into their real world representations (values between -1 and 1).

![](/assets/images/person-depth-and-normals-4-3f7e0a1f95520d709f1f8c723f44f6f0.png)

To ensure that you only visualize the material when the normal information is valid, map the alpha channel of the **Body Normals Texture** to the opacity channel of the PBR material:

![](/assets/images/person-depth-and-normals-5-0d1a5810e9363c6036fa9cc555129487.png)

Instead of attaching the material to a mesh, attach the material to an **Image** component in an orthographic camera to visualize how the material looks:

![](/assets/images/person-depth-and-normals-6-1245f1783e66117ab9524f7228ef4669.png)

To make the image fill the screen, select `Stretch` for the **Stretch Mode**.

![](/assets/images/person-depth-and-normals-7-b1c315b5cad73a36a957d29245a51239.png)

Putting it all together, you can see realistic reflections on the person:

![](/assets/images/person-depth-and-normals-8-e6a33376131aba333a5230c9cb1ee8a5.jpeg)

Change the material properties to get different visual effects:

![](/assets/images/person-depth-and-normals-9-6c0e074bf6da8e1dc8fef02ccce71c76.png) ![](/assets/images/person-depth-and-normals-10-94ea97ed0b35f8d9dcb1ebea4f2f8986.jpeg)

### Modifying existing materials to use Body Normals[​**](#modifying-existing-materials-to-use-body-normals "Copy to clipboard")

You can modify other materials to use Body Normals textures. For example, open the **Toon Material** from the Asset Library:

![](/assets/images/person-depth-and-normals-11-e48dcd8ccbb2b7dd4b36dcec849442dd.png)

This material uses the normal direction and the light direction to find which areas should be “flat” and which areas should be “shadowed”. It expects to be applied to a mesh with a calculated **Surface Normal** direction:

![](/assets/images/person-depth-and-normals-12-230062efdbdee435458bd7912daf15d8.png)

Replace the **Surface Normal** direction with our Body Normal direction (remembering to sample the texture as a `Normal Map`):

![](/assets/images/person-depth-and-normals-13-d43a7d63d7395bf4ad542076c25e66ea.png)

Modify the “outline” to use the camera view direction rather than the camera facing ratio to use this material with an orthographic camera:

![](/assets/images/person-depth-and-normals-14-4a69ee8b1920908e00f585827066fb13.png)

Modify the opacity to use the confidence value from our **Body Normals Texture**:

![](/assets/images/person-depth-and-normals-15-74f6960f6431e4972ea06ca8ec98a09a.png)

Putting it all together:

![](/assets/images/person-depth-and-normals-16-4c8665b15f7051ca9e46241886afbb9e.png)

Since this material uses the input lighting direction, we can adjust the light orientation to get different lighting effects:

![](/assets/images/person-depth-and-normals-17-863bf6928e35122ced535cb3f0c604d9.png)

### Combining with Upper Garment Segmentation[​**](#combining-with-upper-garment-segmentation "Copy to clipboard")

You can combine the **Body Normal Textures** with other textures as well. For example, you can combine normal information with **Upper Garment Segmentation** to isolate where you want your effects to appear.

Start with the simple PBR material referenced earlier. Next, we can add `Texture 2D Parameter` nodes to pass in texture to our material. Add a node for the camera texture so we can set the albedo of the material. Similarly, add a node for the **Upper Garment Segmentation** texture to decide where to apply this material.

Lastly, to have them be displayed in our material, connect these nodes to the `albedo` and `opacity` port of the `PBR` node:

![](/assets/images/person-depth-and-normals-18-758216926bd28e0ba62b5b69a01d5858.png)

Now the base color of the material is the color of the camera texture. Since we want the **Upper Garment Segmentation** and the **Body Normals Texture** confidence values to determine the final opacity, we will multiply their values together.

Since we only want the confidence value of the **Body Normals Texture**, we will use the `Swizzle` node to get the forth channel. In contrast, Segmentation textures have information about the cut out in the first channel (x of xyzw), thus we will use the `Swizze` node to get the `x` channel.

Lastly, we need to pass in our textures into the material. Add the **Upper Garment Segmentation** texture in the `Asset Browser` panel:

![](/assets/images/person-depth-and-normals-19-254a3c6056b3b839a4bfe74c9692d9b3.png)

Attach all textures to the material and modify the **Graph Parameters** to get a plastic-like effect on the garment:

![](/assets/images/person-depth-and-normals-20-f957659baaae0680f791263bbbcab75d.png) ![](/assets/images/person-depth-and-normals-21-fd6b1b1cea67ae682d7b5c6a1f4208e8.png)

## Body Depth Texture[​**](#body-depth-texture "Copy to clipboard")

Use the **Body Depth Texture** to create realistic depth based materials.

Use the depth texture property of the camera to achieve seamless virtual object occlusion. This feature works even when the phone does not have a depth camera available.

When using the **Body Depth Texture** in materials, always select the `Nearest` **Filtering Mode**. If you don't, your material won't work on some Android devices due to a lack of support:

![](/assets/images/person-depth-and-normals-22-cca9464d26a2ec325f6cd0148315603a.png)

### Getting started with the Body Depth Texture[​**](#getting-started-with-the-body-depth-texture "Copy to clipboard")

The **Body Depth Texture** provides you with a person's depth for every pixel. To use it, add a **Body Depth Texture** in the `Asset Browser` panel:

![](/assets/images/person-depth-and-normals-23-5f82e6f1ffe8e9b1b87cd500af2ee17c.png)

The **Body Depth Texture** only produces values for a single person. See which person is associated with each texture by clicking on the texture in the `Asset Browser` panel.

The **Body Depth Texture** also provides a threshold on the minimum allowable confidence level. Pixels with a confidence lower than this threshold will be set to the **Body Depth Texture**’s far plane, which is set to 10 meters by default.

![](/assets/images/person-depth-and-normals-24-dbec188d88a0770ee27efc9f8c0fea45.png)

### Visualize depth[​**](#visualize-depth "Copy to clipboard")

We can visualize the **Person Depth Texture** by creating a simple material which remaps our depth for color values.

Create a Graph material in the `Asset Browser` panel.

![](/assets/images/person-depth-and-normals-25-e709cd32268d9bcad5d084ad15e80d4f.png)

This material has three parameters:

* The depth texture
* The minimum depth
* The range of depth which we want to visualize

Notice that the output of the **Body Depth Texture** parameter is `Depth.x`.

This is because `Depth Map` is selected in the type field of the node:

![](/assets/images/person-depth-and-normals-26-091e6b6e4646593de1359a188564b29a.png)

The output value corresponds to the distance from the camera to the object at each pixel. The distance is measured in centimeters. Each additional centimeter decreases the value by one. For example, a depth of one meter corresponds to an output value of `-100`.

For convenience, multiply this value by `-1` to make the output value a positive number.

Now, using the given minimum depth parameter and range, remap the positive depth value to `0-1` and connect it to a shader to visualize the depth.

Use a **Screen Image** to view the result:

![](/assets/images/person-depth-and-normals-27-034cf710a6c0b36a89bae5f5e3f9272d.png) ![](/assets/images/person-depth-and-normals-28-99b392e0aa35d40bcd1848f3ed915ff2.png)

Notice that the **Stretch Mode** should be set to `Stretch` so that the **Body Depth Texture** covers the whole screen.

![](data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAMCAggICAgICAgIBwgICAgHBwcHCAcHBwcHBwgHBwcHBwcHBwcHBgYHBwcHBwoGBgcICQkJBgcLDQoIDQYICQgBAwQEAgICCQICCQgCAgIICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICP/AABEIAgABEQMBEQACEQEDEQH/xAAdAAEAAgIDAQEAAAAAAAAAAAAAAgMBBAUICQYH/8QASxAAAgICAQIEAgYFBA4LAQAAAQIAAwQREgUhBggTMQdBCRQiMlFhI1JygbEVQnGRFyQlM1NzdHWhorKz0vA0NVRikpO0wcTR0xb/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A9U4CAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYgfP8AjD4h4HT6xbn5uLg1sdK+XfVjq7fqobWX1G9vspsnftA/AfGv0h/h/FLLjnL6m69v7Uo4Vcux/v2Y2Mrr37vQLR2YdyOMD8h699KHbsjF6KgX+a+TnMX1yOuVNWJxBKa2BeeLE93ABIfn3UfpIvEb8glfSaAS3E14mW9iqd8QWt6i9bOo1t/RAJG+IB4wPkMPzxeKlu9VurmxOTt9VfB6SMfT8uKbqwa8rhVyBQjJ5kovNrPthw+z6H9I71+tl9avp2XWCeatj30WsD8ltpyhWhHYAnHftvsSdgP2LwV9JvhvpeodMycYkkephXVZtYHchnW4YVqjXbVa2nevf3AdjPhz5k+h9WZa8LqOPZc/Lhi2lsbMbgdMVxMlach1H6yVldaO9GB+lgwM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)

### Make a Depth Slice material[​**](#make-a-depth-slice-material "Copy to clipboard")

Take what you've learned in the previous sections and create a material that draws a colored line on the parts of the person within a certain depth range.

Starting from the previous depth visualization material, add a color input parameter and replace the remap with an explicit check to see if the depth is within the provided range:

![](/assets/images/person-depth-and-normals-30-950b56f0024ab63e152a87923f460fce.png)

If the depth is not in range, output a default value of `[0,0,0,0]` — pure black. Here's what that looks like when visualized:

![](/assets/images/person-depth-and-normals-31-9c2581e88c2195b710eef44875a0b717.jpeg)

To see the underlying camera feed for these pixels, set **Blend Mode** to `Normal` within the material:

![](/assets/images/person-depth-and-normals-32-e6e8d1e42395ef94c04f1fc8de169f58.png)

Now you see the normal camera output when the depth is not in range:

![](/assets/images/person-depth-and-normals-33-070504d33495794fa153b1873e8041a9.jpeg)

### Occlude objects using the camera depth texture[​**](#occlude-objects-using-the-camera-depth-texture "Copy to clipboard")

Use the **Body Depth Texture** with a virtual scene to get realistic occlusions.

First, create a camera in the `Scene Hierarchy` panel:

![](/assets/images/person-depth-and-normals-34-d8099598adf96911ec5a07d78b923461.png)

In this camera’s properties, set **Depth Clear Option** to `Custom Texture`. Choose the **Body Depth Texture** as the `Custom Texture` input:

![](/assets/images/person-depth-and-normals-35-55fad0a29a7faba495dfe0f18f051bd6.png)

Add the object you want to be occluded when the person is closer to the camera than the object is. The calculation of this occlusion will be handled by the camera and the **Body Depth Texture**.

To see the occlusion working, add a sphere and place it at a depth similar to the person in your preview.

![](/assets/images/person-depth-and-normals-36-723fd93a1dd37c80bdc755549d00bbf3.jpeg)
