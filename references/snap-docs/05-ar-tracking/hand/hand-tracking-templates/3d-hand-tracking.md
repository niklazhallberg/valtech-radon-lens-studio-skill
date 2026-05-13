# 3D Hand Tracking

The 3D Hand Tracking feature applies a 3D hand model to your hand in virtual space. Let's see how it works!

[](/img/lens-studio/3d-hand-tracking_3dhand.webm)

Find the `Default 3D Hands`, `Frog 3D Hands` and `Skeleton 3D Hands` assets in the Asset Library and import them into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library. Once you import the assets from Asset Library, you can find the packages in the Asset Browser. Follow the instructions and drag the prefabs into Scene Hierarchy to create a new Scene Object under `Camera Object`.

![](/img/lens-studio/5-features/3d-hand-tracking-scene-hierarchy.png)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

Here is what we'll go over in the guide:

* [3D Hand Tracking Component](#3dhandtracking) - The component that enables your models to track with the hand
* [The Hand 3D Model](#3dmodel) - The example hands provided with the assets
* [Swap Hand Model with Match Hierarchy](#swaphandmodels) - How to track your own models with the hand
* [Hand Skeleton Controller](#handskeletoncontroller) - How to track models to different joints of the hand

### **3D Hand Tracking Component**[​**](#3dhandtracking "Copy to clipboard")

The 3D Hand Tracking Component allows you to track hands in 3D space. The tracking data appends 2 rigged 3D hand models to match your left and right hand.

![](/img/lens-studio/5-features/3d-hand-tracking-hand-tracking-asset.png)

### The Hand 3D Model[​**](#3dmodel "Copy to clipboard")

![](/assets/images/3d-hand-tracking_hand3dmodel-c25d5e7309c1e8b0cebfdce0df6570ee.png)

The 3D Hand Tracking Component provides two pairs of Hand 3D models as references and inspirations for tracking hands in 3D space. Try them by clicking on the `checkboxes` besides the object in the `Scene Hierarchy` panel.

 You can see the rigging of custom models in green and riggings from tracking component in grey. Please check out the [Object Tracking 3D page](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) to learn more about joint display in scene!

![](/assets/images/3d-hand-tracking_3dhand_model-87936b24f2baf830fa503e3d7c82aa77.jpg)

### Swap Hand Model with Match Hierarchy[​**](#swaphandmodels "Copy to clipboard")

You can bring in your own custom 3d models and track it to the hand. While working on your own hand model, make sure the rigging structure of each bone matches the examples we provided in the assets **exactly**.

If the new hand model has the same rigging hierarchy as our default hand models, you can use the `Match Hierarchy` button to automatically append your 3D hand model to the 3D hand tracking component.

![](/img/lens-studio/5-features/3d-hand-tracking-object-tracking-3d.png)

If Match Hierarchy doesn’t work, manually drag the bones to their correlated `Attachment Points`slot on the `Object Tracking 3D` component. Otherwise, your model will not be tracked to the hand.

Make sure your hand model has its scale set to `(1,1,1)` and has its raw scale set similar to the scale of the example models.

### **Hand Skeleton Controller**[​**](#handskeletoncontroller "Copy to clipboard")

![](/img/lens-studio/5-features/3d-hand-tracking-hand-skeleton-controller.png)

The `Hand Skeleton Controller` can be found under the `Skeleton 3D Hands` example.

This script appends custom joints and bones to the hand object instead of using a rigged 3D Hand model. Input one model for each joint, finger bone and palm bone and the script automatically applies them to hands.

There’s a Basic Bones set and Cartoony Bones set applied to different hands by default. See what they look like with your left and right hand!

[](/img/lens-studio/3d-hand-tracking_3dhand-skeleton.webm)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
