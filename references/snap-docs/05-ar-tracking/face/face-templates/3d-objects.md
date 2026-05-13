# Head 3D Objects

The `Head 3D Objects` asset shows you how to attach 3D objects to a head or multiple heads. For multiple heads, the 3D object for each head can be the same or different.

## Guide[​**](#guide "Copy to clipboard")

### Adding the Head Object[​**](#adding-the-head-object "Copy to clipboard")

Find the `Head 3D Objects` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets from the Asset Library.

Once you import the asset from Asset Library, you can find the package in the `Asset Browser`.

![](/assets/images/3d_objects_1-632d326a2b249fdec5df67f10cb06a74.png)

Follow the instructions and drag the prefab `Head 3D Objects` into Scene Hierarchy under the main camera to create a new Scene Object.

[](/img/lens-studio/5-features/3d_objects_2.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

[](/img/lens-studio/5-features/3d_objects_6.webm)

### Exporting 3D Content[​**](#exporting-3d-content "Copy to clipboard")

The `Head 3D Objects` asset assumes that you have a 3D object which you'll be importing into Lens Studio. To make your 3D object ready for import into Lens Studio, follow the [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guide.

### Importing 3D Content[​**](#importing-3d-content "Copy to clipboard")

Once your 3D object is exported, follow the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide to import your 3D object into Lens Studio.

After importing, the 3D object will be automatically included in the `Scene Hierarchy` panel and should also be visible in the `Scene` panel. Drag your newly imported object to be a child of the `HeadObjectContainer` scene object found under `First Head`. This will attach the object to the first head found in the camera. You can now delete the asset's placeholder content labeled with `[REPLACE_ME]`.

[](/img/lens-studio/5-features/3d_objects_3.webm)

### Tuning the Object's Transform[​**](#tuning-the-objects-transform "Copy to clipboard")

In the `Scene` panel, you can position, scale, rotate the world object relative to the head. In the Lens, the head object will automatically be locked to the head as shown in the `Preview` Panel.

[](/img/lens-studio/5-features/3d_objects_4.webm)

### Adding a Second Head Object[​**](#adding-a-second-head-object "Copy to clipboard")

To add 3D objects to the second head, repeat the same process as above, but place it under the `FaceObjectContainer` below the `Second Head`. The Lens will automatically show and hide the object as needed depending on the number of heads visible.

![](/assets/images/3d_objects_5-041f64287798ee741177456c150ddd66.png)

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
