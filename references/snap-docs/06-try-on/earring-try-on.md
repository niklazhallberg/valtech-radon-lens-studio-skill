# Earring Try-On

This sample project is available on Lens Studio [Home Page](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md).

The Earring Try-On sample project offers a quick way for you to get started with Earring based Try-On experiences and showcase additional features to enhance the user experience.

Ear Binding is a Custom Component that enables Lens Developers to build AR Try-On experiences that can bind a 3d Object to users ears. With earrings being a popular fashion accessory, AR Try-On experiences offers a way for users to visualize how earrings will fit to their ear.

## Sample Project Walkthrough[​**](#sample-project-walkthrough "Copy to clipboard")

This project introduces you to creating a Earring focused Try-On Lens, which allows you to attach objects to a user’s ear. The Earring Try-On project contains three different examples of how to utilize the Ear Binding Custom Component. In the `Scene Hierarchy` panel, you can see the following examples:

![](/img/lens-studio/5-features/earring-try-on-scene-hierarchy.png)

### Basic[​**](#basic "Copy to clipboard")

The Basic example is using the Ear Binding component to bind a single stud earring to a specific earring landmark.

![](/img/lens-studio/5-features/earring-try-on-landmark-selection.png)

You can utilize this example to test how Ear Landmarks work when placing content. If you edit the `Earring` Scene Object, you can change between different settings to see how they affect the final result in the scene panel.

### API[​**](#api "Copy to clipboard")

Through the API of the Ear Binding Component it’s possible to manipulate the different settings of the component via script. In this example, you can find two earrings, each holding a component in its hierarchy for changing the `Ear Binding` settings through the API. You can utilize the script `EarringAPIExample` to see how you can manipulate the `Ear Binding` settings using code. See full API in [Ear Binding Component API](#ear-binding-component-api).

### Earring Try-On Experience[​**](#earring-try-on-experience "Copy to clipboard")

This example shows a complete Earrings Try-On experience with additional advanced features within Lens Studio to increase a user’s immersion:

* Advanced earrings: Some earrings may have moving parts, attach to different parts of a user’s ear or may hang from a user’s ear. These earrings show how to set up Physics to give a realistic feel.

* Hair occlusion: Occlude the earrings using `Head Visibility` Custom Component to make the visual more realistic. For more information, go to the [Head Visibility](#head-visibility) component section

* Hand physics and occlusion: Adding the ability to touch the earrings and occlude them using the hands.

  * This is achieved by importing the `Hand Physics` Custom Component from the Assets Library.

    [](/img/lens-studio/earring_try_on_5.webm)

* Earring selection UI: Users may want to cycle between different styles and types of earrings. The Earring Selection UI is a UI element styled as a Carousel to allow users to select different earrings

  * You can learn more about how to utilize the [Carousel UI](#ui-carousel) below.

* Zoom: Using the ‘Zoom Image’ Custom Component to offer an easy way to inspect the look and feel of the earring. Zoom can be found under the Zoom Scene Object. For more information, go to the [Zoom Setup](#zoom-setup) section.

## Ear Binding Component Overview[​**](#ear-binding-component-overview "Copy to clipboard")

The Ear Binding component attaches its hierarchy to a landmark on either left or right ear.

![](/img/lens-studio/5-features/earring-try-on-earring-binding-cc.png)

* **Ear Landmark:** Determines the position on the ear. You can select one of the following landmarks available on the user’s ear.

  | Index | Position     |
  | ----- | ------------ |
  | `1`   | Lobe - front |
  | `2`   | Lobe - back  |
  | `3`   | Top Orbital  |
  | `4`   | Scapha       |
  | `5`   | Helix        |
  | `6`   | Tragus       |
  | `7`   | Diath        |
  | `8`   | Rock         |
  | `9`   | Snug         |

  ![](/assets/images/earring_try_on_7-f460ccf6e0e50caf420e9bcc17cabbb1.png)

* **Ear Selection:** Select target attachment ear - `left` or `right`.

* [**Face Index:**](/lens-studio/features/ar-tracking/face/head-attached-3d-objects.md) The index of the face this event is tracking. You can change this value to control which face the event tracks. The first detected face is `0`, the second face is `1`, and so forth.

  * Ear Binding can be used to add earrings to two persons at the same time.

* **Offset X / Y:** fine tune the asset position with offset from the original landmark position. The offset is in the UV space of the ear mesh.

## Adding Earring Binding to an Existing Project[​**](#adding-earring-binding-to-an-existing-project "Copy to clipboard")

Now that you have viewed the Earring Try-On sample project and see how the Ear Binding Custom Component works, you can also add Ear Binding to your existing Lens Studio Projects. In this section, you will learn how to set up Ear Binding from scratch in a similar structure to the Earring Try-On sample project.

1. Open a new or existing project in Lens Studio.

2. Left-click on the **Asset Library** button, located above the `Scene Hierarchy` panel.

   ![](/img/lens-studio/5-features/earring-try-on-asset-library.png)

3. Search for `Ear Binding` in the search bar at the top left.

4. Click **Install** on the Ear Binding Asset.

   ![](/img/lens-studio/5-features/earring-try-on-install-ear-binding-cc.png)

5. In your project, Add a new Scene Object under the main camera. Name the new Scene Object; `Earring`.

   ![](/img/lens-studio/5-features/earring-try-on-add-earring-object.png)

6. With the new Scene Object selected, left-click on **Add Component** in the Inspector panel and search for `Ear Binding`.

7. Press Enter to add it to the selected Scene Object.

   ![](/img/lens-studio/5-features/earring-try-on-add-ear-binding-cc.png)

8. Add [your earring asset](#adding-your-own-earring-asset) under the hierarchy of the `Earring` Scene Object. For this example, we’ll add a sphere to represent an earring. Set the sphere’s scale to `1.5` on all axes for better visibility.

   ![](/img/lens-studio/5-features/earring-try-on-add-sphere.png)

9. You can now select the `Earring` Scene Object and set the earring settings to your needs.

## Adding Your Own Earring Asset[​**](#adding-your-own-earring-asset "Copy to clipboard")

When designing an Earring Try-On Lens, you may want to include your own custom models to represent the type of earring you want to showcase. In the next few sections, you will learn about some things to keep in mind when building earring assets and how to set up your model to take advantage of what Lens Studio has to offer for your AR Try-On Lenses.

### Creating Earring in 3D Modeling App[​**](#creating-earring-in-3d-modeling-app "Copy to clipboard")

Download the face model to build the earrings assets with the right size to fit the face model in Lens Studio Please visit the [face mesh page](/lens-studio/features/ar-tracking/face/face-mesh.md#download-the-face-mesh-3d-model)

For every earring asset you create, it is important to remember to set its pivot to be at the point where you want the earring to be attached to the ear.

For the gold and chain earrings shown in the example above, the model was set up with an skeletal rig so that the mesh could have physics properties based on the different joints in order for them to act in a physically correct way. It is important to note that the rigged mesh is not required for every earring, a simpler type of earring that is fixed in position to the ear, such as an earring stud, doesn’t need to be rigged.

For rigged earrings, see the section in this document on how to [set up the physics](#physics-setup) for the earring.

You can see an example of a rigged earring below, the green markings represent the rigged joints:

![](/assets/images/earring_try_on_14-9d8eda93025b696c8a706f22258b72dd.png)

Please visit the [export 3d object guide](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) / [3D object import guide](/lens-studio/assets-pipeline/3d/importing-content/overview.md) to see how you can bring in your own model.

## Adding Interactivity with Advanced Features[​**](#adding-interactivity-with-advanced-features "Copy to clipboard")

Lens Studio offers Lens Developers a wide range of powerful and immersive features for AR content. In this next section, you will learn about some of the extra features you can include in your Try-On experience to enhance the user’s experience, such as making the hair occlude the earring or set up the earring to move with the user's head movement.

### Physics Setup[​**](#physics-setup "Copy to clipboard")

Physics system updates separately from the AR tracking system, follow the `Chain` Custom Component setup for best results.

Lens Studio offers an incredibly robust Physics system to enable AR content to act and react like physical objects. We’ve used the `Chain` Custom Component that handles the physics setup.

The `Chain` Custom Component has two benefits that you can use in your future projects:

* Physics setup can be a bit time consuming, this script will take all the heavy lifting on itself.
* Taking care of hierarchy setup that works best for physics objects that are tracked, a use case which needs special handling - as the physics object needs to be separated from the tracked object (as the earring is attached to the tracked ear).

The `Chain` Custom Component offers a quick way to set up physics behavior on skeletal rig objects such as chains or earrings. The `Chain` Custom Component will take care of adding Physics Body and Constraints between the joints and can be used for dangling chains and double ended chains, such as necklaces.

The `Chain` Custom Component determines physics behavior of the chain by controlling the shape, mass and damping as well as friction and bounciness through applying Physics Matter.

#### Setting Up[​**](#setting-up "Copy to clipboard")

##### Joint Referencing[​**](#joint-referencing "Copy to clipboard")

The first step for setting up the chain is providing the joints in the same order as in the model hierarchy, the custom component can do that automatically given the first joint in the hierarchy, the only requirement for automatic joint referencing is that the joints will keep a direct parent-child relationship as shown in the image below.

![](/img/lens-studio/5-features/earring-try-on-joints.png)

For automatic joint referencing, drag and drop the first joint to the Chain Base field of the Chain Custom Component, make sure that the ‘Use Hierarchy’ checkbox is set.

![](/img/lens-studio/5-features/earring-try-on-use-hierarchy.png)

For cases where there isn’t a direct parent-child relationship between the joints such as in the image below, you should uncheck ‘Use Hierarchy’ and reference the joints manually.

![](/img/lens-studio/5-features/earring-try-on-use-arrary.png)

##### Chain Shape[​**](#chain-shape "Copy to clipboard")

The Chain Custom Component adds physics bodies in the shape of a cylinder to each joint of the chain. In this section you can control the shape and constraint type of the chain.

![](data:image/png;base64,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)

* **Shape Radius:** the radius of the cylinder in cm.
* **Cylinder length:** the length of the cylinder in cm. This is the length of the cylinder that will be added to each joint.
* **Hinge offset:** the position where the constraint will be positioned relative to the joint and will control the moment of inertia for the joint movement. A value of 0 will place the constraint in the middle of the joint, a value of 1 will place the constraint at the top of the joint giving it some freedom of movement, a value greater than 1 will give the joint even more momentum when moving.
* **Constraint Type:** can be set as either Point or Hinge, determining the degrees of freedom the joint can move.

##### Chain Mass[​**](#chain-mass "Copy to clipboard")

This section of the Custom Component will determine the weight for each of the joints in the chain.

![](data:image/png;base64,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)

* **Mass Setting:** can be either Weight or Density. The weight being the weight of each joint in kg, regardless of the shape of the joint and density will be the weight in kg/l thus taking the shape into account of calculating the weight of each joint.
* **Base Weight:** the weight of the first joint.
* **Tip Weight:** the weight of the last joint. The weight of the intermediate joints are linearly interpolated between the base and the tip.

##### Advanced Setup[​**](#advanced-setup "Copy to clipboard")

![](/img/lens-studio/5-features/earring-try-on-chain-advanced-setup.png)

* **Damping:** the amount the chain slows down between frames.

* **Ang Damping:** the amount the chain slows down on angular movement between frames.

* **Physics Matter:** can reference a physics matter object that determines the friction and bounciness of the joints.In order to create a physics matter object, click the ‘+’ button in the `Asset Browser` panel and search for Physics Matter. This field can be left empty and will use default Lens Studio settings.

  ![](/img/lens-studio/5-features/earring-try-on-physics-matter.png)

  * **Physics Matter Settings:**

    ![](/img/lens-studio/5-features/earring-try-on-physics-matter-settings.png)

* **Anchor Both Ends:** will set the last joint in the hierarchy as non-dynamic, this way the chain will have two anchoring points, in the beginning of the chain and in the end of the chain. This can be used to set up a necklace use-case.

* **Intangible:** make the chain intangible.

* **Camera:** set which camera should render the chain, use this if the chain is not a part of a camera’s hierarchy.

##### Debug[​**](#debug "Copy to clipboard")

![](data:image/png;base64,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)

This section of the Custom Component is useful for showing the colliders and constraints of the joints and is recommended to be used while working on the chain to better understand the physics behavior.

* **Show Constraints:** will show the constraints in a yellow mark.
* **Show Colliders:** will show the collider as a blue cylinder for each joint.

More details about the different physics constraints and how they affect the physics body can be found in the [Physics](/lens-studio/features/physics/physics-examples/physics.md#constraint-types)

### Hair occluder using `Smart Hair Occlusion` Custom Component[​**](#hair-occluder-using-smart-hair-occlusion-custom-component "Copy to clipboard")

‘Smart Hair Occlusion’ includes a hair occluder mask that toggles automatically when selected face features are hair occluded. This effect helps to show the hair on top of the rendered 3D earring and increase realism. This is important because in some scenarios the hair will be tucked behind the ear, and in that case we want the virtual earring to be visible.

#### Adding `Smart Hair Occlusion`[​**](#adding-smart-hair-occlusion "Copy to clipboard")

To add the `Smart Hair Occlusion` Custom Component, search for `Smart Hair Occlusion` in the `Asset Library` and add it to the project, than add it to your project via the `Asset Browser` panel.

![](/img/lens-studio/5-features/earring-try-on-install-smart-hair-occlusion.png)

Drag the `Smart Hair Occlusion` Custom Component to the scene hierarchy, select the layer for the scene object to be the layer you want to occlude and you're done!

#### `Smart Hair Occlusion` Setup[​**](#smart-hair-occlusion-setup "Copy to clipboard")

* **Scene Hierarchy:**

  ![](/img/lens-studio/5-features/earring-try-on-smart-hair-occluder-object.png)

* **Smart Hair Occlusion Settings:**

  ![](/img/lens-studio/5-features/earring-try-on-smart-hair-occluder-settings.png)

Take a look at the [Hair Color](/lens-studio/features/ar-tracking/face/face-templates/hair-color.md) to see another example of using hair segmentation

### UI Carousel[​**](#ui-carousel "Copy to clipboard")

![](/img/lens-studio/5-features/earring-try-on-carousel-object.png)

The `Image Carousel` Custom Component allows you to easily switch between different earrings. You can add / remove earrings by modifying the Icons list in the `Inspector` panel and place the corresponding earrings in the Earring Selector object.

Under the UI Camera Scene Object, you can find the `Carousel` Scene Object which holds the Carousel2D script. The `icons` value holds the textures that show as buttons to the user.

The actual function to disable or enable a specific earring takes place in the `Earring Selector` Scene Object.

In order to add/remove items from the Carousel:

1. Add the earrings Scene Objects to the `Object Enabler` script under the `Earring Selector` Scene Object.

   ![](/img/lens-studio/5-features/earring-try-on-object-enabler.png)

2. Add the corresponding earring icons to the carousel, in the `Carousel` Scene Object.

Earrings’ icons should be placed in the same order as they appear in the `Object Enabler` script.

![](/img/lens-studio/5-features/earring-try-on-carousel-images.png)

3. If adding to a new project, another step is needed to connect between the `Carousel` and the `Object Enabler` script with `On Item Set Call` and function name `enableObject`. This is done in the carousel settings.

   ![](/img/lens-studio/5-features/earring-try-on-carousel-set-call.png)

### Zoom Image[​**](#zoom-image "Copy to clipboard")

The `Zoom Image` Custom Component adds a Picture-In-Picture to the top corner of the screen. this enables the user to inspect the earring with more focus to details.

The `Zoom Image` has many cool features, such as the ability to focus on a specific target, or the ability to use touch to move the zoom. Earring Try-On sample project contains a helper script to determine which object is focused in the zoom using the head rotation, this way. When the user is rotating his head, the zoom will automatically focus on the ear that is facing the camera. The helper script can be found under the scene object `Zoom Point of Interest Selector`.

#### Adding Zoom Image to an empty project[​**](#adding-zoom-image-to-an-empty-project "Copy to clipboard")

Add the `Zoom Image` custom component to Lens Studio via the `Asset Library`, search for `Zoom Image` and press install.

![](/img/lens-studio/5-features/earring-try-on-zoom-image-object.png)

Then add it to your project by pressing the ‘+’ button in the `Asset Browser` panel and search for `Zoom Image`. After doing so, you should see the `Zoom Image` component in the `Asset Browser` panel.

The `Zoom Image` is used with an orthographic camera, and will require a Screen Transform. This will enable you to change the size and position of the zoom output. You can add the `Zoom Image` custom component by first adding a Screen Image to the scene, which will add the orthographic camera if needed and the scene object with the Screen Transform, then replace the Image component with the `Zoom Image` component. The last step before seeing the Zoom Image is referencing the camera you want to use as an input for the zoom.

[](/img/lens-studio/5-features/earring-try-on-add-zoom-image.webm)

Next you can change the screen transform to suit your desired look and feel.

[](/img/lens-studio/5-features/earring-try-on-zoom-image-transform.webm)

The default output material for the Zoom Image is the `2D Shapes Shader` (which can also be found in the `Asset Library`), which lets you customize the cutout shape anywhere from a circle to a rectangle, add outline and more. You can select the material and modify the shape as needed. Alternatively, you can use the default image texture if you’d like a rectangular shape without borders.

![](/img/lens-studio/5-features/earring-try-on-2d-shapes-shader.png)

#### Zoom Image Setup in Earring Try-On[​**](#zoom-image-setup-in-earring-try-on "Copy to clipboard")

You can find the `Zoom Image` Custom Component under the `Zoom Image` scene object. In the try-on experience, the zoom default state is `on`, and can be set off via the zoom button.

![](/img/lens-studio/5-features/earring-try-on-zoom-image-object.png)

The zoom functionally is set via the script `Zoom Btn Ctrl.js`. The zoom button animation is done via the script `Btn Animation.js`. Zoom Settings:

* **Input Camera:** The camera that will be used for zoom input.
* **Zoom Multiplier:** Zoom value.
* **Touch pan:** Adds the ability to use touch gestures to move the zoom center.
* **Point of Interest:** Zoom will center around the referenced scene object.
* **Output Material:** The material for the zoom output.
* **Antialiasing:** Sets Antialiasing for the input camera. Will result in a sharper zoom image.
* **Move Damping:** Adds delay to the zoom movement towards the point of interest.
* **Zoom Speed:** The speed for the zoom to change from its current value to the target value.
* **Touch Sensitivity:** Sets the sensitivity for the touch which will affect the zoom movement.

![](/img/lens-studio/5-features/earring-try-on-zoom-image-settings.png)

## Ear Binding Component API[​**](#ear-binding-component-api "Copy to clipboard")

The Ear Binding component exposes the following API which can be used to control it from a script.

| Name                                  | Type             | Description                                            |
| ------------------------------------- | ---------------- | ------------------------------------------------------ |
| `setEarringLandmark(earringLandmark)` | Function(String) | Sets the ear landmark to use                           |
| `getLandmarkNames()`                  | Function()       | Gets a list of possible landmarks                      |
| `setEarSelection(ear)`                | Function(int)    | Sets the ear, `0` = left, `1` = right                  |
| `setEarringOffset(offset)`            | Function(vec2)   |                                                        |
| `faceIndex`                           | Property         | Set the person index to which the earring will bind to |

Example script:

```
/**
* Using the component from a script
*/
//@typename EarBinding
//@input EarBinding earringCtrl
script.earringCtrl.setEarSelection(0) // set earring to left ear
script.earringCtrl.setEarringLandmark("Scapha"); // will set the earring landmark to ‘Scapha’
script.earringCtrl.setEarringOffset(new vec2(0.005,0) // set the earring position with UV offset of 0.005 on X axis.
```

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Lens experience in Snapchat! To do so follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.

## Tips on earrings asset creation[​**](#tips-on-earrings-asset-creation "Copy to clipboard")

* If it’s your first time modeling earrings, and you want to better understand the fine details of earrings geometry, there are good references online, you can try searching for `diamonds scheme to model gemstones` as a reference to start your model with.

[](/img/lens-studio/earring_try_on_15.webm)

* It is important to turn on hard edges for edgy parts (for example gemstones) and smooth for smooth metal parts

[](/img/lens-studio/earring_try_on_16.webm)

* Use Hard (only .0 or 1 ) skin for parts that are not flexible

![](/assets/images/earring_try_on_17-c766c62d0e7bf00e1b5b92d00be7f591.png)

[](/img/lens-studio/earring_try_on_18.webm)

* Set joint in the beginning of the dynamic element if it is not flexible

[](/img/lens-studio/earring_try_on_19.webm)

* Don't create very high poly meshes for not rigid parts

![](/assets/images/earring_try_on_20-1ba2eb7dc5d9dcb22d95805dd29051fb.png)

* It is important to add loops in flexible areas - It is better to use a high poly mesh in places where there will be skin with a soft gradient

[](/img/lens-studio/earring_try_on_21.webm)

## What's Next?[​**](#whats-next "Copy to clipboard")

Now that you have learned about how to create your own Wristwear Try-On Lenses, take a look at some of the other AR Try-On examples.

* Check out the [Developing Fashion Lenses for Virtual Try-On using Lens Studio](https://ar.snap.com/en-US/intermediate-courses) course on how to make your own Fashion Lens.
* [Footwear Try-On](/lens-studio/features/try-on/foot-tracking.md)
* [Cloth Simulation Try-On](/lens-studio/features/try-on/cloth-simulation-try-on.md)
* [Wristwear Try-On](/lens-studio/features/try-on/wristwear-try-on.md)
* [Garment Transfer](/lens-studio/features/try-on/garment-transfer.md)
