# Pet Tracking

`Pet Tracking` asset covered in this guide is available in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

The Pet Tracking lets you create Lenses that add content to Cat or Dog faces. It allows attaching images or animations to a Pet’s Left Eye, Right Eye, Nose and Center of the head.

[](/img/lens-studio/pet_pet_template_cat_example.webm)

### Switch Preview Video[​**](#switch-preview-video "Copy to clipboard")

When working with the Pet Example, you'll want to switch the preview video to one with a cat or dog. In the `Preview` panel, press the `Multimedia Preview` button. Then, in the drop down at the top of the `Preview` panel, select the `Cat and Dog`, `Cat`, or `Dog` preview video. You should now see the example working with content applied to the Cat or Dog’s face.

[](/img/lens-studio/pet_pet_template_preview_panel_switch.webm)

### Add Resource[​**](#add-resource "Copy to clipboard")

For the Pet example, we should first import a 2D texture or animation into the `Asset Browser` panel. To do this, drag and drop a `PNG`, `JPG` or `GIF` into the `Asset Browser` panel from your computer.

[](/img/lens-studio/pet_object_add_resource.webm)

### Configure Pet Tracking Controller[​**](#configure-pet-tracking-controller "Copy to clipboard")

With the `PetTrackingController [EDIT_ME]` object selected in the `Scene Hierarchy` panel, we'll configure its settings in the `Inspector` panel. First, let's select the Tracking Type we'd like to use from the `Tracking Type` drop down. The `Cat` tracking type will only apply to cats. The `Dog` tracking type will only apply to dogs. The `Cat or Dog` tracking type will apply to either a Cat or a Dog found in the camera.

If you're not creating an experience that ONLY works on Cats or ONLY works on Dogs, we recommend using the `Cat or Dog` tracking type

[](/img/lens-studio/pet_pet_tracking_type.webm)

The Pet example allows you to configure the image attached to the Right Eye, Left Eye, Nose or Center of the head. All are tuned in the same way. When tuning Right Eye for example, you can enable or disable the feature with the `Right Eye Tracking` checkbox. When enabled, you can assign my custom texture that you imported into my `Asset Browser` panel to the `Right Eye` field. Finally, you can adjust the `Size`, `Offset`, `Rotation` and `Alpha` of the feature with the corresponding sliders.

[](/img/lens-studio/pet_pet_configure_large.webm)

### Adding Pet Tracking Outside of Example[​**](#adding-pet-tracking-outside-of-example "Copy to clipboard")

While the Pet example gives you a simple way to add 2D images and animation to the tracked points, you can also always add Cat and Dog tracking outside of the example. To do this, select `+ -> Object Tracking -> Cats and Dogs Tracking` from the `Scene Hierarchy` panel. You can then edit the position, scale and rotation of the added element in the 2D scene.

### Object Tracking and 3D Objects[​**](#object-tracking-and-3d-objects "Copy to clipboard")

It is possible to attach 3D Objects to Object Tracking by adding a helper script. Please refer to the [Object Tracking & 3D Objects](/lens-studio/features/ar-tracking/world/object-tracking.md#object-tracking--3d-objects) section of the Object Tracking guide for more information.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
