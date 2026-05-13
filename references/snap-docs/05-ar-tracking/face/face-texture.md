# Face Texture

The Face Texture resource allows you to get a your Camera texture centered around a part of your face. It can be used, for example, for creating a picture in picture effect, or for applying a user’s face to a 3D object in your Lens.

## Create the Face Texture[​**](#create-the-face-texture "Copy to clipboard")

To create a Face Texture resource, first click the `+` button in the `Asset Browser` panel. Then, select `Face Texture`.

![](/assets/images/add-face-texture-937cc11fa96319a43ef46113ffeedeb3.png)

## Assign Texture to a Screen Image[​**](#assign-texture-to-a-screen-image "Copy to clipboard")

The Face Texture resource can be used anywhere a regular texture can be used.

One way of displaying it is to use a Screen Image. In the `Scene Hierarchy` panel: `+ > Screen Image`.

![](/assets/images/add-screen-image-6841b77b9f6830c41acf7bd5ea95248f.png)

Then, in the `Inspector` panel, assign `Texture` to your newly added Face Texture resource.

[](/img/lens-studio/5-essential/set-face-texture.webm)

## Position The Face Texture[​**](#position-the-face-texture "Copy to clipboard")

To modify where the image is displayed, **double-click** on the object in the `Scene Hierarchy` panel. This will open up the relevant editor, in this case, the `2D Editor` panel.

In the `2D Editor` panel, you can move your Screen Image around to position your Face Texture in the right place.

To learn more about Screen Image, checkout the [Image](/lens-studio/assets-pipeline/2d/image.md) guide

[](/img/lens-studio/5-essential/modify-face-texture.webm)

## Face Texture Settings[​**](#face-texture-settings "Copy to clipboard")

With the `Face Texture` resource selected, you'll see the following settings used to configure the resource in the `Inspector` panel:

![](/assets/images/face-texture-settings-4d0f69c80dcfed8f62bcd875017797ac.png)

* **Face Index:** The index of the face this face texture is displaying.
* **Input Texture:** The texture which the face is extracted from. By default it is the screen texture.
* **Scale:** The UV Scale of the face texture. How the face will be fitted unto the texture.
* **Offset:** The UV Scale to shift the inset texture.
* **Adjust Offset:** Whether the `Offset` should be applied.
* **Face Region:** The area of the face this texture is centered to.
* **Screen Texture:** Whether the face texture should receive from the screen.
