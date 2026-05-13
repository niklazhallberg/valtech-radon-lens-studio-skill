# Wristwear Try-On

With the Wrist Tracking Custom Component, Lens Developers can create unique AR Try-On experiences that can be tracked onto the user's wrist. The Wristwear Try-On Sample Project offers a quick way for you to get started building wrist-based Try-On experiences.

This sample project is available on Lens Studio [Home Page](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md).

## Sample Project Walkthrough[​**](#sample-project-walkthrough "Copy to clipboard")

Once you open the Wristwear Try-On Sample Project, you will see the `Wrist Binding` SceneObject where all of the content for this sample project is located. The important Scene Objects in this project are:

* `Wrist Binding` Scene Object handles the wrist tracking.
* The `Left Wrist` and `Right Wrist` Scene Objects contain all the content related to the left and right wrists, respectively.
* The `Watch [TOGGLE_ME]` and `Bracelet [TOGGLE_ME]` Scene Objects are examples that demonstrate how to create your own Try-On AR experiences.

![](/assets/images/wristwearTryOn_1-58cfb5bc2c7507af1195e8b9eba953fc.png)

One thing to keep in mind when making your own Wristwear Try-On Lenses is to make sure that custom meshes are oriented the same way as they are in the examples.

If you would like to use your own 3D models in this project, you will need to remove the existing bracelet models and replace them with the custom mesh:

1. Right-click on the `Watch [TOGGLE_ME]` Scene Object in the `Scene Hierarchy` panel, and select Delete.
2. After the Scene Objects have been removed, you will need to import the custom 3D model.
3. Once the new mesh has been imported into the project, drag and drop the mesh from the `Asset Browser` panel into the `Scene Hierarchy` panel such that the new mesh is a child of either the `Left Wrist` or `Right Wrist` Scene Objects.
4. With the new mesh selected, go to the `Inspector Panel` to adjust the object’s Transform so that it is positioned similar to the following image:

![](/assets/images/wristwear-try-on-image4-0b2d3dc8117fa9a14a9347d8757723f1.png)

You can learn more about how to [import 3d models into Lens Studio](/lens-studio/assets-pipeline/3d/importing-content/overview.md) to see how you can bring in your own 3D models to use.

## Adding Interactivity[​**](#adding-interactivity "Copy to clipboard")

The Wristwear Try-On Sample Project contains some added functionality to enhance the user's experience in AR.

The `WatchHandController.js` Script brings the AR watch to life by simulating a traditional watch face. You can click on the `Watch [TOGGLE_ME]` Scene Object in the `Scene Hierarchy` panel to find the `WatchHandController.js`.

The script utilizes two Scene Objects as an input, one named `Hour Hand` and the other named `Minute Hand`. Each Scene Object placed in the script will rotate and act based on the hour or minute of a twelve hour analog clock."

## Adding Wrist Tracking to Existing Projects[​**](#adding-wrist-tracking-to-existing-projects "Copy to clipboard")

Now that you have a solid grasp of the Wristwear Try-On sample project, you can also add Wrist Tracking to your existing Lens Studio Projects. In this next section, you will learn how to set up Wrist Tracking from scratch in a similar structure to the Wrist Try-On Template.

### Collecting Assets[​**](#collecting-assets "Copy to clipboard")

In order to get started, you will need to have the following Assets for Wrist Tracking;

* The Wrist Binding Custom Component.
* A Wrist Occluder asset.
* A 3D model that will be used as wristwear.

The first two assets can be found in the Asset Library.

1. Open a new or existing project in Lens Studio.

2. Once you get the most relevant version of `Wrist Binding` from Asset Library, it could be added to the Asset Browser panel by clicking on the + button. Then simply drag it to the Scene Object to create a new Scene Object with the`Wrist Binding` Component.

![](/assets/images/wristwearTryOn_3-1260b9b606b84d28d73fe5b85cb4437e.png)

Or directly in Scene Object inspector by clicking on Add Component Button.

![](/assets/images/wristwearTryOn_2-a942f697a828f604562d4c4426e74a97.png)

3. Find the `Wrist Occluder` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the Asset Library.

![](/assets/images/wristwearTryOn_4-6e61d6e02d102bc0937be7251fe04f4c.png)

With the Wrist Binding Custom Component and Wrist Occlusion asset added, you will need a 3D model that will be tracked on the user’s wrist. For the purposes of this guide, We will use the "Aqua Terrestrials Pack" by [WRLD SPACE](https://wrld.space/) to showcase how to add existing 3D Content into wrist tracking.

1. In the Asset Library, type in "Aqua Terrestrials Pack" in the search bar.
2. Left-Click on the **Import** button.

### Setting up the Wrist Tracking Custom Component[​**](#setting-up-the-wrist-tracking-custom-component "Copy to clipboard")

With all the necessary assets imported into your Lens Studio project, you can start setting up the Wrist Tracking Components. The first step is to create the scene hierarchy in the `Scene Hierarchy` panel, the second is populating the hierarchy with scripts and assets.

1. Right click on the `Camera` object and select Create Scene Object.

2. Rename this Scene Object `Wrist Binding`.

   ![](/assets/images/wristwearTryOn_5-a2868448dcb88e9e6879596373ccce1d.png)

3. Right-click on the `Wrist Binding` object and create two new Scene Objects by left-clicking on the **Create Scene Object** button.

4. Rename one Scene Object `Left Wrist` and the other to `Right Wrist`.

![](/assets/images/wristwearTryOn_6-ee3ab182154c0add135099aa97e07330.png)

With the hierarchy set up in the `Scene Hierarchy` panel, you can now start adding scripts and assets.

1. Click on the `Wrist Binding` Scene Object.
2. In the Inspector panel click on **+ Add Component**.
3. Search for `Wrist Binding` and add it to your Scene Object.
4. Click and drag the `Left Wrist` and `Right Wrist` Scene Objects in the `Scene Hierarchy` panel into their respective slots in the Inspector Panel.

![](/assets/images/wristwearTryOn_7-17bca504f62f351bfc486490ddacddaf.png)

5. Click on the `Wrist Occluder__PLACE_UNDER_WRIST_BINDING` asset from the `Asset Browser` panel and drag it once under `Left Wrist` and another under the `Right Wrist` Scene Objects.
6. In the Inspector Panel, double-check that the Position of the `Wrist Occluder__PLACE_UNDER_WRIST_BINDING` Scene Object is set to `0, 0, 0`.
7. Change the `Left Wrist` and `Right Wrist` Scene Objects x positions to be able to see both occluders in the `Scene` panel.

![](/assets/images/wristwearTryOn_8-8f0d7f4ff239b5a333724cf787bfc0c1.png)

Now with the Wrist Binding Custom Component and Wrist Occlusion set up, you can now add the 3D content:

1. Drag and drop the `AquaTerrestrials__PLACE_IN_OBJECTS_PANEL` asset from the `Asset Browser` panel into the `Scene Hierarchy` panel. A few animated 3D objects should appear.
2. In the `Scene Hierarchy` panel, delete every animated 3D object except for the `Donut` object.
3. Drag and drop the `Donut` Scene Object under the `Left Wrist` Scene Object.
4. With the `Donut` Scene Object selected, in the Inspector Panel adjust the `Donut`’s position, rotation, and scale so that it fits around the left wrist occluder.
5. Duplicate the `Donut` Scene Object by right-clicking on the `Donut` Scene Object and then left-clicking on "Duplicate".
6. Drag and drop the duplicated `Donut` Scene Object under the `Right Wrist` Scene Object.

![](/assets/images/wristwearTryOn_9-c3b9245cca96aa1e6f7e0fad399ddde5.png)

You have completed your first Wrist Tracking Lens. Now that you have learned how the Wristwear sample project works and how to add Wrist Tracking to your projects, you can now create your own Wristwear AR Try-On Lenses.

[](/img/lens-studio/wristwear-try-on-image11.webm)

## Best Practices[​**](#best-practices "Copy to clipboard")

The most common error encountered when working with Wrist Tracking is when 3D models are not properly centered on the wrist. In practice, this issue appears as if the AR wristwear is orbiting around a wrist, rather than sitting nicely on the wrist. See below for an example of a improperly centered 3D object:

[](/img/lens-studio/wristwear-try-on-image7.webm)

Thankfully, this is easily fixed. Make sure that any child of the `Left Wrist` or `Right Wrist` Scene Objects has its position set to `0, 0, 0`. Of course, if your 3D model’s origin is not at the center of the geometry this may need to be adjusted.

The `Left Wrist` or `Right Wrist` can have any transform. For the purposes of demonstration and visual clarity, the Wristwear Try On Sample Project has the `Left Wrist` and `Right Wrist` Scene Objects adjusted by +/- 10 units on the X axis.

### Wristwear Tracking[​**](#wristwear-tracking "Copy to clipboard")

For optimal wristwear tracking and detection, it is recommended to place 3D models along the wrist up to 4 centimeters (cm). Detection and tracking will degrade as you move further down the wrist into the forearm. See below for optimal tracking and detection areas:

![](/assets/images/wristwear-try-on-image-1-9e92d01a1169c173e38a3f5093274a9e.png)

### Wrist Occluder Fit[​**](#wrist-occluder-fit "Copy to clipboard")

The Wrist Occluder Asset consists of two separate elements that help in creating a realistic Wristwear Try-On effect. These components are:

* The Wrist Occluder, which is a 3D mesh that hides the underside of the wrist-attached 3D objects through the use of an Occluder material.
* The Wrist Occluder Shadow, which is an optional addition to the Wrist Occluder that applies a subtle shadow to a user’s wrist in order to further ground the AR object in its environment.

[](/img/lens-studio/5-features/wristwearTryOn_10.webm)

The thickness of both of these meshes can be altered by selecting the “Left Wrist Occluder Parent” or the “Right Wrist Occluder Parent” and adjusting the “Thickness” slider in the Inspector Panel. Adjusting the thickness of the Wrist Occluder can help in creating a better fit for your AR wristwear Lens.

## What's Next?[​**](#whats-next "Copy to clipboard")

Now that you have learned about how to create your own Wristwear Try-On Lenses, take a look at some of the other AR Try-On examples.

* Check out the [Developing Fashion Lenses for Virtual Try-On using Lens Studio](https://ar.snap.com/en-US/intermediate-courses) course on how to make your own Fashion Lens.
* [Footwear Try-On](/lens-studio/features/try-on/foot-tracking.md)
* [Cloth Simulation Try-On](/lens-studio/features/try-on/cloth-simulation-try-on.md)
* [Earring Try-On](/lens-studio/features/try-on/earring-try-on.md)
* [Garment Transfer](/lens-studio/features/try-on/garment-transfer.md)
