# ML Environment Matching

`ML Environment Matching Metal Character` and `ML Environment Matching Gold Frame` are available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project and follow the instructions in the Asset Readme.

The ML Environment Template demonstrates built-in ML capabilities that allows AR effects to better match the real world environment easily. The template utilizes two techniques ([Blur Noise Estimation and Dynamic Envmap](/lens-studio/features/graphics/ml-environment-matching.md)), and provides several examples to see them in action.

[](/img/lens-studio/The-ML-Environment-Template-and-Guide_3.webm)

## Guide[​**](#guide "Copy to clipboard")

The template comes with several examples that you can find under the **Head Binding** object in the `Scene Hierarchy` panel. To try them, enable the checkboxes to the right of each object’s name.

The template leverages two key features to better match the AR effect to the real world:

* **Blur Noise Estimation** which leverages an ML model to understand the noise in the camera feed and apply them to the AR objects to help them blend in.
* **Dynamic Envmap** which leverages ML model to create a dynamic environment map such that your objects can reflect real world lighting

### Blur Noise Estimation[​**](#blur-noise-estimation "Copy to clipboard")

Select the **Camera** object in the `Scene Hierarchy` panel, and in the `Inspector` panel, notice that there is a `Blur Noise Estimation` component. With this component added on the Camera object, our Camera will automatically apply the ML model to blur and add noise to your objects so that they blend in with the Camera source.

![Image of Blur Noise Estimation](/assets/images/The-ML-Environment-Template-and-Guide_4-24764c49cfa31cbbb0f78bb9363a8cd5.png)

This effect is very subtle and most visible on moving cameras and in darkly lit scenes. If you don’t see any significant changes in the **Preview** panel, it is normal.

This effect only works on the face camera and only on some devices.

### Dynamic Envmap[​**](#dynamic-envmap "Copy to clipboard")

The Dynamic Envmap feature can be toggled on a Lighting Object. This template comes with two Envmap lighting objects under the **Lighting** object in the `Scene Hierarchy` panel. In general practice you should only have one; both are here to allow you to easily compare the difference between the two. Try enabling and disabling the checkbox to the right of each object.

![Image of Dynamic Envmap](/assets/images/The-ML-Environment-Template-and-Guide_9-be753ac8c960967a5ef0c8d6cf7cbbd2.png)

If you select the `Envmap - Dynamic Envmap Enabled` object, in the `Inspector` panel, notice that the Dynamic Envmap toggle is enabled. In addition, the Device Camera Texture is used as `Input` to get data about the real world.

This effect only works on the face camera and only on some devices. When the ML model is unavailable, the Lens will automatically fallback to classical Envmap which will still use the `Input` albeit without ML processing.

### Examples[​**](#examples "Copy to clipboard")

With the ML Environment Matching features enabled, the effect will automatically be applied to all your objects.

### Simple Examples[​**](#simple-examples "Copy to clipboard")

[](/img/lens-studio/The-ML-Environment-Template-and-Guide_3.webm)

The `Face Mesh` and `Gold Frames` examples show the default `Face Mesh` and `Uber PBR` materials in action. Try clicking their related material (same name) in the `Asset Browser` panel and modifying the Lighting parameters in the `Inspector` panel.

Try using the Webcam preview and shining light onto yourself to see the environmental matching effect in action.

In the `Texture` field of lighting, we use a white texture to make sure our parameter can be as shiny as possible. Take a look at the Material Parameters guide to learn more about what data the texture here should contain.

### Metal Character - Double Materials[​**](#metal-character---double-materials "Copy to clipboard")

[](/img/lens-studio/The-ML-Environment-Template-and-Guide_8.webm)

In the previous example, you’ll notice that if you had used no roughness, the object never gets shiny enough to seem reflective. This is because the ML model’s generated envmap is blurry. In order to have an extremely shiny material, we can overlay two materials on top of each other. Take a look at the **Character Face** object to see this:

![Image of Character Face object](/assets/images/The-ML-Environment-Template-and-Guide_7-736a90453c590afdd27dd17e60bc7c00.png)

The first material contains a Simple Reflection which reflects a standard Specular map.

![Image of Simple Reflection via Specular Map](data:image/png;base64,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)

This material is based on the Uber PBR material. However, since we only need the `Simple Reflection` setting, we removed the `Lighting` settings by detaching it from the final output.

You can detach nodes by holding shift and click/dragging to draw a line over the connections that you want to cut. Take a look at the Material Editor guide to learn more.

![Image of detached nodes via Material Editor](/assets/images/The-ML-Environment-Template-and-Guide_1-ee7e05ada7cf31ca48ce15bde727b643.png)

Secondly, we add another Uber PBR material as before to receive the lighting from the Dynamic Envmap. In addition, we use the `Multiply` blend mode, so that the lighting results are applied on top of the `Simple Reflection` in the previous material.

![Image of secondary Uber PBR material](/assets/images/The-ML-Environment-Template-and-Guide_11-ec5d3c98f727564c523a3dcc81fded2f.png)

Right-click on a field, and click on **Select** to see what the field is a reference to.

### Baseball Cap Example[​**](#baseball-cap-example "Copy to clipboard")

[](/img/lens-studio/The-ML-Environment-Template-and-Guide_5.webm)

In the last example, we simply brought in the Baseball Cap example from the Asset Library. There’s nothing special in this set-up, and in fact it reflects that the ML Environment Matching feature can be a quick addition to any Lens as it doesn’t require any additional setups on each object!

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
