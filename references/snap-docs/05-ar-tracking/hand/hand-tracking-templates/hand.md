# Hand

The `Hand Tracking Controller`, `Cat on Head` and `Panda On Head` assets let you create Lenses that add images or animations to a hand found in the camera. The assets also give example scripts for adding interaction when a hand is found or lost.

[](/img/lens-studio/hand_hand_template_example.webm)

## Guide[​**](#guide "Copy to clipboard")

Find the `Hand Tracking Controller`, `Cat on Head` and `Panda On Head` assets in the **Asset Library** and import them into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets from the **Asset Library**.

Once you import the asset from the **Asset Library**, you can find the package in the **Asset Browser**. You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/hand-1-a23a20d35f22a004a393284c99a7d31a.png)

Follow the instructions and drag the prefab into the **Scene Hierarchy** to create a new Scene Object.

### Switch Preview Video[​**](#switch-preview-video "Copy to clipboard")

When working with the Hand assets, you'll want to switch the preview video to one with a hand. In the **Preview** panel, press the `Image / Video Mode` button. Then, in the drop down at the top of the **Preview** panel, select the `Hand` preview video. You should now see the asset working with content applied to the preview model’s hand. You can also switch to Webcam in the **Preview** panel and see the content attached to your own hand.

[](/img/lens-studio/5-features/hand-2.webm)

### Add Resource[​**](#add-resource "Copy to clipboard")

For the Hand assets, start by importing a 2D texture or animation into the **Asset Browser**. To do this, drag and drop a `PNG`, `JPG`, or `GIF` file from your computer into the **Asset Browser**. Click [here](/lens-studio/assets-pipeline/2d/image.md) to learn more about adding a texture resource.

### Hand Tracking Controller[​**](#hand-tracking-controller "Copy to clipboard")

This asset requires an `Orthographic` camera. After importing the `Hand Tracking Controller` asset from the **Asset Library**, drag the `Hand Tracking Controller` prefab from the **Asset Browser** and place it under the orthographic camera in the **Scene Hierarchy** to create a new Scene Object.

![](/assets/images/hand-3-280cbec111a53aa3a595bbf45dc713f4.png)

With the `Hand Tracking Controller` object selected in the **Scene Hierarchy**, we’ll configure its settings in the **Inspector** panel. This asset allows you to configure the image attached to the hand. You can assign your custom texture, imported into the **Asset Browser** panel, to the `Texture` field. Finally, adjust the `Size`, `Offset`, `Rotation`, and `Alpha` of the content using the corresponding sliders.

[](/img/lens-studio/5-features/hand-4.webm)

Additionally, you can enable `Smooth Following`, which loosely attaches the content to the hand and includes a tunable `Smoothing Speed`.

### Cat on Head and Panda On Head Assets[​**](#cat-on-head-and-panda-on-head-assets "Copy to clipboard")

The `Cat on Head` asset requires a **Head Binding** object. To create one, navigate to your **Scene Hierarchy** panel and select: `+ -> Face -> Head Binding`.

![](/assets/images/hand-5-47f261f006209daa963090dc77f2d5f0.png)

For the `Panda On Head` asset, a **Head Binding** component is already included, so you only need to drag and drop the `Head Binding` prefab under the main **Camera Object**.

![](/assets/images/hand-6-5e0b4dc43438078b901e394ca1419552.png)

#### Adding Hand Found, Hand Lost Interaction[​**](#adding-hand-found-hand-lost-interaction "Copy to clipboard")

The `Cat on Head` and `Panda On Head` assets give examples for adding interaction when a hand is found or lost in the camera. In these assets, a 3D and 2D animation is played when the hand is either found or lost. Take a look at the `HandTriggerController.js` script in the **Cat on Head -> Scripts** folder, and the `HandHatController.js` in the **Panda on Head -> Scripts** folder.

To create your own custom interaction, you can use the following script.

```
script.onObjectFound = function () {
  // Add on Hand found logic here
  print('Hand Found');
};
script.onObjectLost = function () {
  // Add on Hand lost logic here
  print('Hand Lost');
};
```

### Adding Hand Tracking Outside The Assets[​**](#adding-hand-tracking-outside-the-assets "Copy to clipboard")

While the Hand assets give you simple ways to add 2D images and animation to the tracked hand, you can also always add Hand tracking outside of theses assets. To do this, select `+ -> Object Tracking -> Hand Tracking` from the **Scene Hierarchy** panel. You can then edit the position, scale and rotation of the added element in the 2D scene.

### Object Tracking and 3D Objects[​**](#object-tracking-and-3d-objects "Copy to clipboard")

It is possible to attach 3D Objects to Object Tracking by adding a helper script. Please refer to the [Object Tracking & 3D Objects](/lens-studio/features/ar-tracking/world/object-tracking.md#object-tracking--3d-objects) section of the [Object Tracking](/lens-studio/features/ar-tracking/world/object-tracking.md) guide for more information.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
