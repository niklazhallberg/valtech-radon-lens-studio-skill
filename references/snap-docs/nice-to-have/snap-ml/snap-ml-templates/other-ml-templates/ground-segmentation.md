# Ground Segmentation

`Ground Segmentation` is available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create new Orthographic camera and place the prefab under it.

The ground segmentation example allows you to modify the ground by using a ground segmentation mask provided by the [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md). Additionally, objects in the scene can be occluded when they are placed beyond the ground

[](/img/lens-studio/ground-segmentation_ground-segmentation.webm)

## Guide[​**](#guide "Copy to clipboard")

### Adding Ground Segmentation[​**](#adding-ground-segmentation "Copy to clipboard")

Find the `Ground Segmentation` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages).

![](/assets/images/ground-segmentation-1-aabb5934e7fe828105b9af87afc95bb1.png)

The newly imported package can be found in the `Asset Browser` panel. Notice that it says that it should be placed on the `Orthographic` camera.

To do this, in the `Scene Hierarchy` panel, press `+` and choose `Orthographic` camera.

![](/assets/images/ground-segmentation-2-28d1f28c63b1a5b81aba6e40debfb5f0.png)

Since segmentation happens in screen-space (i.e. a 2D texture), we need an orthographic camera to dipslay that texture in the Lens (as opposed to the default Camera which uses a Perspective view).

Next, drag the `GroundSegmentation__PUT_IN_ORTHO_CAM` from the newly imported asset in the `Asset Browser` panel, underneath the newly created `Orthographic Camera`.

![](/assets/images/ground-segmentation-3-84c365dfd11bc7c593b8caedf7fd7f4e.png)

In the `Preview` panel, with the camera showing a preview with a ground, you should now see a white pixel where there's ground, and black pixels, where it's not ground.

| Scene                                                                           | Ground Segmentation                                                             |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| ![](/assets/images/ground-segmentation-4a-40ff5cc575e8dac7306c5aa9431921e3.png) | ![](/assets/images/ground-segmentation-4b-2133f3da6765fe491b071a438f116559.png) |

If you don't see the ground, make sure you change the preview image to one which includes a ground. ![](data:image/png;base64,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)

### Using the Ground Segmentation[​**](#using-the-ground-segmentation "Copy to clipboard")

Now that the Lens can understand what's the ground and not the ground, we can use this as a mask--that is: show our effects. only where the pixels are white.

We can select the `Orthographic Camera`, and in the `Inspector` panel, notice that it has a `Render Target`. This Render Target is where we output the result of the camera to. We can make a new Render Target by selecting the field, and in the picker, press the `+` button and selecting Render Target.

![](/assets/images/ground-segmentation-5-6ea5c681331ffc3b61c461e04e971eb7.png)

At this point, you won't see the mask anymore--which is what we want. Instead, we will use this as a mask for our default `Camera Object`, which will render our effect. Select the `Camera Object`, and in the `Inspector` panel, select the `Mask Texture` field, and select the newly added Render Target.

![](/assets/images/ground-segmentation-6-cb01f910e7da141d39f001197ec0a8ce.png)

Now, when we render things on the `Camera Object`, it should not show up when it isn't ground!

### Example Ground Effect[​**](#example-ground-effect "Copy to clipboard")

For example, let's add a floor to the ground.

On the `Camera Object`, in the `Inspector` panel, press `Add Component` and choose `Device Tracking`. We do this, because we want our AR floor to track the ground--that is our virtual camera should follow the device's camera movement.

![](/assets/images/ground-segmentation-8-b35814aa5ba2d605af831b97bd53e6ac.png)

Next, in the `Scene Hierarchy` panel, with nothing selected, press `+` and choose `Plane`. This should add a new plane mash at the root of your Scene Hierarchy.

![](/assets/images/ground-segmentation-7-657b060453f367f762b78674688e1d93.png)

Now, try expanding the size of the plane: with the `Plane` selected, in the `Scene` panel, press the `Scale` tool at the top (keyboard shortcut: `R`), and drag one of the boxes out. In the preview panel, you should see the plane only showing where the ground is!

![](/assets/images/ground-segmentation-8b-4beb30652446ec648eaab65d2627718d.png)

### Adding a Camera That is Not Masked[​**](#adding-a-camera-that-is-not-masked "Copy to clipboard")

At this point, any object you add will be rendered by the `Camera Object` which is masked--meaning you can't have anything that's not on the ground!

To fix this, we can add a new camera which will render things not on the ground.

In the `Scene Hierarchy` panel, press the `+` button, and select `Camera`. Like before, we will also add `Device Tracking` component on this camera.

![](/assets/images/ground-segmentation-9-0132bf718d54c1fd238d39b2c2447f9d.png)

Since we want this new `Camera` to see different things than our default `Camera Object`, in the `Inspector` panel, in the `Camera` component, select the `Layers` field, press `Add New Layer`, then choose the new Layer.

![](/assets/images/ground-segmentation-11-0acc897366c771d44661367ee9c4a2b2.png)

Lastly, we also want this camera to show its results. To do this, assign the `Render Target` from the `Asset Browser` to the camera's `Render Target` field.

Every project will have a Render Target which is used for the final output. You can see these by selecting the `Scene` asset in the `Asset Browser` panel. Take a look at [Scene Asset](/lens-studio/lens-studio-workflow/scene-set-up/camera.md#scene-asset) guide to learn more.

![](/img/lens-studio/5-features/ground-segmentation-13b.png)

You should have something that looks like this:

![](/assets/images/ground-segmentation-13-fa8701c060ffe29fe2a47be317359304.png)

### Adding an Object That is Not Masked.[​**](#adding-an-object-that-is-not-masked "Copy to clipboard")

Finally, let's add a `Sphere` at the root of our scene to be rendered by our newly adde camera. In the `Scene Hierarchy` panel, press the `+` button and choose `Sphere`.

![](/assets/images/ground-segmentation-10-66e2804f4a811190af5270fbc6cc3301.png)

Then, with the `Sphere` selected, in the `Inspector` panel, in the top right corner, you can choose the layer it's on. Make sure it's on the same layer as the `Camera` you've just added so that it can be seen by that camera.

![](/assets/images/ground-segmentation-12-1f66fe3e1fcde12e14ea543c3e241874.png)

You can resize the sphere as before, and notice how the Sphere isn't masked by the ground segmentation!

![](/assets/images/ground-segmentation-15-6e397c84d89530acc40233875da7e7ae.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
