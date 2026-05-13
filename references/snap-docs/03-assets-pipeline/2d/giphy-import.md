# GIPHY Import

You can directly import content from [GIPHY](https://giphy.com/) inside Lens Studio! This guide will walk you through the simple steps for importing a GIPHY GIF as a Face Image, Screen Image, World Image or a Resource.

The content is populated with [GIPHY Stickers](https://giphy.com/stickers). These are GIFs that have transparent backgrounds.

## Add From GIPHY[​**](#add-from-giphy "Copy to clipboard")

In the top menu, select `Window`, `Utilities`, then `GIPHY`. A window will open to allow you to search for the stickers you want.

![](/assets/images/giphy-menu-7cb78711867834e3b6a33bb24bfaaf54.png)

When you hover over a sticker, you can see the `+` button. This will allow you to import the sticker as a resource.

![](/assets/images/giphy-1-c8236d0d75f8ce780ad1a2b05d74cae4.png)

## Using the Stickers[​**](#using-the-stickers "Copy to clipboard")

The imported resource will be a texture that you can use anywhere else you can use a texture. Below are some examples to consider.

### Attach to the user's face[​**](#attach-to-the-users-face "Copy to clipboard")

Check out the [Face Image](/lens-studio/features/ar-tracking/face/face-image.md) guide for more information on how you can attach a texture to different points on a user's face.

### Display the image in screen space[​**](#display-the-image-in-screen-space "Copy to clipboard")

Using Screen Image, you can attach the imported GIPHY GIF to the screen. Check out the [Image](/lens-studio/assets-pipeline/2d/image.md) and the [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) guide for more information on how to set up a Screen Image.

### Attach the image to the world[​**](#attach-the-image-to-the-world "Copy to clipboard")

With the sticker on an image, and a `Device Tracking` component on a camera object, you can attach the imported GIPHY GIF as a 3D plane in the world. Check out the [Image](/lens-studio/assets-pipeline/2d/image.md) guide for more information on how to work with Image.
