# Crop Texture

When using a model, it may be necessary to provide a specific region of the input texture. For example, you might need to pass a texture that focuses on the center of the screen, an area around a person's face, or a rectangle surrounding a hand.

Two types of crop textures are available: **Screen Crop** and **Face Crop**.

### Screen Crop Texture[​**](#screen-crop-texture "Copy to clipboard")

This feature allows you to extract a rectangular area from the input texture.<br /><!-- -->To create a **Screen Crop Texture**, click the **“+”** button in the `Asset Browser` panel and select **Screen Crop Texture**.

![Creating Screen Crop Texture](/assets/images/crop-textures_Crop-1-new-screen-crop-32fdc5ff66f59a4ceba7e1be5a0cd5be.png)

Click on the newly created texture in the `Asset Browser` panel to view its properties:

![Screen Crop Texture Properties](/assets/images/crop-textures_Crop2-Screen-Crop-Rect-8b5c6952c915e25fa600b22ec0ca27c7.png)

* **Input Texture:** The original texture from which to crop. By default, it is set to the Device Camera Texture.

The cropping region is defined by:

* **Cropping Left, Right, Top, Bottom:** Specifies the anchors of the crop rectangle within the input texture's local space. (A rectangle with anchors (-1, 1, -1, 1) represents the entire input texture.)
* **Rotation:** The rotation angle of the crop rectangle.

These parameters can be modified via script. Refer to [`RectCropTextureProvider`](/lens-studio/api/lens-scripting/classes/Built-In.RectCropTextureProvider.html) in the [API documentation](/lens-studio/api/lens-scripting/classes/Built-In.RectCropTextureProvider.html).

### Face Crop Texture[​**](#face-crop-texture "Copy to clipboard")

This feature allows you to crop a texture around a face.

To create a **Face Crop Texture**, click the **“+”** button in the `Asset Browser` panel and select **Face Crop Texture**.

![Creating Face Crop Texture](/assets/images/crop-textures_Face-Crop-1-add-new-b2744160af23ec32c4bfa5d92a78bd58.png)

Click on the newly created texture in the `Asset Browser` panel to view its properties:

![Face Crop Texture Properties](/assets/images/crop-textures_Face-Crop-2-asset-settings-be3dab23712fcabbce60c3137798f576.png)

* **Input Texture:** The original texture from which to crop. By default, it is initialized with the Device Camera Texture.
* **Scale:** The UV scale of the face texture, which can be adjusted to zoom in or out on the face.
* **Face Index:** Specifies which face to use for cropping. The first face is indexed at 0, the second at 1, etc.
* **Face Center Mouth Weight:** A value of 0 positions the mouth at the default location, while a value of 1 centers the mouth in the cropped texture.

For further details, see the [`FaceCropProvider`](/api/lens-studio/Classes/Providers.md#FaceCropTextureProvider) in the Lens Studio API documentation.

## Rectangle Setter[​**](#rectangle-setter "Copy to clipboard")

The Rectangle Setter component controls the **ScreenTransform** component of an object based on the crop rectangle of a Crop Texture.

To create a Rectangle Setter component, select **Screen Image** in the `Scene Hierarchy` panel. In the `Inspector` panel, click **Add Component** -> **Rectangle Setter**. Then assign the **CropTexture** property to the desired crop texture.

[](/img/lens-studio/crop-textures_Crop-3-Rect-setter-1.webm)
