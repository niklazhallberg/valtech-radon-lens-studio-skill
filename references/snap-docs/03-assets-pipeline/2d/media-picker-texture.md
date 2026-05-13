# Media Picker Texture

The Media Picker Texture asset allows you to use images or videos from your device's camera roll it as a texture in your Lens. You can have the picker show all images, all videos, all images with faces in them, or a combination of these options. You can use the texture anywhere you can use a regular imported texture: on an Image component, on a material, and elsewhere.

For the most common use case of applying a Media Picker asset, see the [Media Picker Guide](/lens-studio/features/ar-tracking/face/face-templates/media-picker.md).

The Media Picker combines the Image Picker and Face Image Picker Texture to one convenient asset, and therefore should be used in place of them.

[](/img/lens-studio/5-adding-content/media-picker-1.webm) [](/img/lens-studio/media-picker-texture_media-picker-guide-1.webm)

## Create the Media Picker Texture[​**](#create-the-media-picker-texture "Copy to clipboard")

To create a Media Picker Texture asset, select `+ -> Media Picker Texture` in the `Asset Browser` panel.

![](/assets/images/media-picker-2-efbf2f3f8d715857397b77ac1628a217.png)

This creates a texture you can now utilize like any other texture resource. You can add the resource to a material texture field, to an [Image or Screen Image](/lens-studio/assets-pipeline/2d/image.md), and more.

## Configuring the Media Picker Texture Settings[​**](#configuring-the-media-picker-texture-settings "Copy to clipboard")

With the `Media Picker Texture` asset selected in the `Asset Browser` panel, note  the following settings used to configure the resource in the `Inspector` panel:

![](/assets/images/media-picker-3-5a44f3a491f85ff08cbf8bd48919d967.png)

* **Show On Start -** If disabled, the UI for the Face Image Picker does not automatically appear and must be activated via script. See the [API page](/lens-studio/api/lens-scripting/classes/Built-In.ImagePickerTextureProvider.html) for more information. You must use the texture in the Lens for this option to have an effect.
* **Images -** Whether to show all images, only images with faces, or no images.
* **Videos -** Whether to show all videos or no videos.

### Image Options[​**](#image-options "Copy to clipboard")

When showing images `Only with Faces`, you have additional settings to configure how the face is shown in the texture:

![](/assets/images/media-picker-4-197004b78ffd6ed645c605716394423c.png)

* **Crop to Face** - When enabled, the image is cropped to the face in the photo. When disabled, the image is the entire source image (not cropped).
* **Scale** - The UV Scale of the face texture. Decrease these values to zoom in on the face and increase them values to zoom out.
* **Face Region** - The area of the face this texture is centered on.

## Previewing the Media Picker[​**](#previewing-the-media-picker "Copy to clipboard")

If `Show On Start` is enabled in the Media Picker setting, in the `Preview` panel, you see a picker for the media based on your configuration.

![](/assets/images/media-picker-5-63b6232170d8c11d7c40ab5214e2a239.png)

Lens Studio shows the usual images and videos found in the `Preview` panel as an example of what the user’s camera roll looks like.

Make sure you are showing Snapchat UI to display this picker:

![](/assets/images/media-picker-6-6f6ca23d4fd27f6a83ea9232af99cd96.png)

You can also use a script to pull the UI. See the [API page](/api/lens-studio/Classes/Providers.md#ImagePickerTextureProvider) for more information.

## Displaying the Media[​**](#displaying-the-media "Copy to clipboard")

You can display the media anywhere a texture can be used in Lens Studio. Below are two examples:

### Displaying the Media on the Screen[​**](#displaying-the-media-on-the-screen "Copy to clipboard")

In the Objects panel, press `+ > Screen Image`.

![](/assets/images/media-picker-7-868daf802d53f82b5977a4529c60583c.png)

Next, with the newly added `Image` selected in the `Objects` panel, in the `Inspector` panel click on the `Image` component’s `Texture` field and select the `Media Picker Asset`.

![](/assets/images/media-picker-8-7a261f81c2fa7ac243127d84ec2ffdd7.png)

### Displaying only a 3D Mesh[​**](#displaying-only-a-3d-mesh "Copy to clipboard")

You can also apply your media as a texture on a 3D object. For example, you can display a face image on your character. The example below shows how to display the face image on a 3D object based on the Face Image Picker template.

The texture is very similar to [Face Texture](/lens-studio/features/ar-tracking/face/face-texture.md) but is driven by the device's camera roll instead of the live camera. If you have a project that's already using Face Texture, simply replace that texture with a Face Image Picker Texture to upgrade it to a ‘from camera roll’ experience.

[**Download: Face Image Picker Mesh**](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/VKgkU8_1_7_0/files/face_image_picker_mesh.lso.zip)

Once downloaded and unzipped, import the .lso into your project. To do this, right click in the `Objects` panel and select `Import Object`.

![](/assets/images/media-picker-texture_media-picker-guide-8-a340d93284fe23224f75e663ce2b95a2.png)

When imported, a FaceMesh object appears in the Objects panel. Position, rotate, and scale the `FaceMesh` so that it aligns with where you want your camera roll driven face.

[](/img/lens-studio/media-picker-texture_media-picker-guide-9.webm)

If you have a character you'd like to add the face to, drag and drop the FaceMesh object to be a child of the character so that it moves with the character's movement.

The `FaceMesh` object that you imported is already set up with a Media Picker texture and material. If you're using this object, you don't need to create your own Media Picker Texture.
