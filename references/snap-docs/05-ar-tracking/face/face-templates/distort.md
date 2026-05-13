# Distort

The Distort sample project provides a base for creating Face Lenses that stretch, liquify, and duplicate your facial features. The project allows you to create a compelling Face Lens without importing any additional resources. The project contains a few preconfigured effects which you can edit or delete. This guide covers how to modify the project’s effects, as well as how to add more. You can find the project in the [homescreen](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md) of Lens Studio.

To make it easier for you to mix-and-match our different examples, this sample project has also been converted to an importable asset in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) with the name `Face Distort`. Find the asset in the Asset Library and import ut into your existing project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the Asset Library.

## Guide[​**](#guide "Copy to clipboard")

### Editing the Face Liquify Effect[​**](#editing-the-face-liquify-effect "Copy to clipboard")

The Face Liquify Effect can bulge and pucker any region of the face. The Distort sample project includes two Face Liquify Points, attached to the eyes. You can find them in the `Scene Hierarchy` panel under the `Distortion Effects` object.

![](/assets/images/distort-face-liquify-98e0a7b6a8564606eb6cc6ea5cb99c5b.png)

Double click on one of the Liquify Point Scene Object to open Face Liquify Editor. Or go to `Window -> Editors -> Face Liquify Editor` to edit Liquify points. In the Face Liquify Editor panel, you can change the position of the Face Liquify Effect by dragging the blue circle.

[](/img/lens-studio/5-features/distort-face-liquify-points.webm)

You can adjust the radius and intensity of the Face Liquify effect with the Liquify Visual Component in the Inspector Panel.

![](/assets/images/distort-adjust-radius-3e0dc8ab3d39ad6788be1035a5ef74fb.png)

### Adding a Face Liquify Effect[​**](#adding-a-face-liquify-effect "Copy to clipboard")

To add a new Face Liquify Effect, select `+ -> Face -> Face Liquify` in the `Scene Hierarchy` panel.

### Editing The Face Stretch Effect[​**](#editing-the-face-stretch-effect "Copy to clipboard")

The Face Stretch Effect distorts the shape of the face by manipulating points mapped to the face. The Distort sample project includes a Face Stretch Effect, used to shrink the head and round out the overall shape of the face. You can find it in the `Scene Hierarchy` panel under the `Distortion Effects`object.

![](/assets/images/distort-face-stretch-b578683025dae999cfaea265b202ebbe.png)

Double click on the Face Stretch Scene Object to open Face Stretch Editor. Or go to `Window -> Editors-> Face Stretch Editor` to edit Face Stretch. In the Face Stretch Editor panel, you can drag the Face Stretch points to change the shape of the face.

[](/img/lens-studio/5-features/distort-face-stretch-adjust.webm)

You can change the strength of the Face Stretch Effect by adjusting the Face Stretch Component’s `Feature` slider in the `Inspector` panel.

![](/assets/images/distort-face-stretch-intensity-8bf0872395e56c2b53f9ef1f31861bad.png)

### Adding a Face Stretch Effect[​**](#adding-a-face-stretch-effect "Copy to clipboard")

To add a new Face Stretch Effect, select `+ -> Face -> Face Stretch` in the `Scene Hierarchy` panel.

### Editing The Face Inset Effect[​**](#editing-the-face-inset-effect "Copy to clipboard")

The Face Inset Effect creates an image with a cropped texture of a facial feature. This effect is great for adding extra eyes, mouths, or noses to a face. The distort sample project includes a Face Inset Effect, used to create a comically large mouth that tracks the user’s face. You can find it in the `Scene Hierarchy` panel under the `Distortion Effects` object.

![](/assets/images/distort-face-inset-cac70d20be1fad664e2cc605324032d6.png)

Double click on the Face Inset Scene Object to open Face Inset Editor. Or go to `Window -> Editors-> Face Inset Editor` to edit Face Inset. In the Face Inset Editor panel, you can drag and resize the Mouth to any part of the face. To rotate the Face Inset, hover over one of the edges until your mouse cursor changes to a rotation icon. Then click and drag in the direction to rotate it.

[](/img/lens-studio/5-features/distort-face-inset-modify.webm)

You can adjust the appearance (including feathering, blend mode, mirroring, and more) of the Face Inset Effect by adjusting the properties of the Face Inset Component in the `Inspector` panel. Here, you can also change the part of the face used in the effect.

![](/assets/images/distort-face-inset-inspector-setting-5edb0e831932e8458106b2a5c1a4e9ed.png)

### Adding a Face Inset Effect[​**](#adding-a-face-inset-effect "Copy to clipboard")

To add a new Face Inset Effect, select `+ -> Face -> Face Inset` in the `Scene Hierarchy` panel.

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
