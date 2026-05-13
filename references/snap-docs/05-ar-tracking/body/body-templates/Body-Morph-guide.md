# Body Morph

The Body Morph Template allows you to bring in your own custom mesh which the user body can morph into. The template comes with several examples that you can play with.

[](/img/lens-studio/body_morph_1.webm)

## Template Walkthrough[​**](#template-walkthrough "Copy to clipboard")

The Body Morph feature allows you to morph the body of a user into another custom mesh which has the same UV map as the standard Body Mesh.

​​In the `Scene Hierarchy` panel, you’ll find five examples of how you can use this external face mesh feature. You can enable or disable a template by clicking on the checkbox next to them.

You can get the external body mesh in the [Body Mesh guide](/lens-studio/features/ar-tracking/body/body-templates/body-mesh.md). You can modify it in the 3D editor software of your choice.

### Gorilla – Body Morph with Face Blendshapes[​**](#gorilla--body-morph-with-face-blendshapes "Copy to clipboard")

In this example, the external body mesh used is a modified version of the standard body mesh model. Rather than using a completely new mesh, this external body mesh has been modified in a 3D modeling software to look like a gorilla’s body. It also uses the standard Lens Studio Skeleton that is built for 3D Body Tracking.

Additionally, a gorilla head is attached to the skeleton of the external body mesh. There are a number of blendshapes associated with this mesh that can be driven by the user’s face.

To see these blendshapes, you will need to select the gorilla head;

1. in the `Scene Hierarchy` panel by clicking on `Camera`.
2. Select Examples EXPLORE\_ME
3. Select → 01 - External Mesh With Face Blendshapes
4. Select Gorilla \[TRY\_ME]
5. Select 3D Body Tracking
6. Select gorilla\_body, then select Armature
7. Select Character1\_Hips
8. Select Character1\_Spine
9. Select Character1\_Spine1
10. Select Character1\_Spine2
11. Select Character1\_Neck
12. Select Character1\_Head
13. Select gorilla\_head
14. Finally, select head.

![](/assets/images/body_morph_6-80b3966171ebd65f2658bc0bbd1c2717.png)

These blendshapes are controlled by the `Expression Controller.js` script, which reads the user’s face and applies.

To manually modify the blendshapes in order to see what each blendshape controls, navigate to;

1. Camera first, then select Examples \[EXPLORE\_ME]
2. Select 01 - External Mesh With Face Blendshapes
3. Select Gorilla \[TRY\_ME]
4. Disable the SceneObject titled Expression Controller - Gorilla.

Now, when the gorilla’s head mesh is selected in the `Scene Hierarchy` panel, the blendshapes will be manually adjustable.

[](/img/lens-studio/body_morph_2.webm)

### Frog – Full Body Mesh With Face Blendshapes[​**](#frog--full-body-mesh-with-face-blendshapes "Copy to clipboard")

In this example, a Full Body Mesh is used instead of an External Body Mesh.

1. In the `Scene Hierarchy` panel, navigate to Examples \[EXPLORE\_ME].
2. Select 02 - Full Body Mesh With Face Blendshapes
3. Select Frog \[TRY\_ME]
4. Select 3D Body Tracking
5. Select Frog Body Mesh
6. Then, in the `Inspector` panel, right click on “Frog Full Body Mesh”.
7. Finally, select “Select”

You are able to change what Body Meshes are visible by replacing the mesh in the “External Mesh” field.

### Ostrich & Wolf – External Mesh With Fur And Face Blendshapes[​**](#ostrich--wolf--external-mesh-with-fur-and-face-blendshapes "Copy to clipboard")

In this example, an External Body Mesh is used. Unlike the previous two examples, this example demonstrates how additional elements can be added to the External Body Mesh to create effects such as fur or feathers.

### Elephant – Full Body Mesh with Physics[​**](#elephant--full-body-mesh-with-physics "Copy to clipboard")

In this example, a Full Body Mesh is used. Additionally, the Face Mesh leverages the [Chain Physics](/lens-studio/features/ar-tracking/face/face-templates/chain-physics.md#examples)Controller to add physics to the Elephant’s ears and trunk.

## Make Your Own Full Body Mesh using Body Morph[​**](#make-your-own-full-body-mesh-using-body-morph "Copy to clipboard")

This section will explain how to import a custom External Body Mesh and apply it to the user’s body.

In order to upload your own custom External Body Mesh, first download the [external body mesh 3D file](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Forum-Helpers/3D_Body_Mesh_and_UV.zip) and import it into the 3D modeling software of your choice.

For this guide, we will be using [Blender](https://www.blender.org/) but you may use any other 3D modeling software of your choice.

[](/img/lens-studio/body_morph_7.webm)

​​In order for the External Body Mesh Lens to work properly, we need to adjust the Body Mesh without altering any of the 3D model’s UVs. This can be done in a multitude of ways, but for the purposes of this guide, we will be using Blender’s sculpting tools.

First, if you look at the scene hierarchy, you will see that the head, body, and hands are all separate objects. For ease of editing, let’s join all of these individual meshes into one.

In Blender, this can be accomplished by selecting all of the meshes (this can be done quickly by pressing `A` on your keyboard) and then pressing `CTRL + J` (Windows) or `CMD + J` (mac) to join the meshes. Remember, you can always press `F3` and search for any operation you wish to perform on a mesh!

Before continuing, we need to make sure there are no overlapping vertices. Select your mesh, and press `tab` to enter Edit Mode. Press `A` to select everything and then press `M` to merge vertices, and then select “By Distance”.

[](/img/lens-studio/body_morph_3.webm)

Now that we have one mesh object, we can perform any number of modifications to it. For this guide, we will increase the size of the Body Mesh’s chest, arms, and stomach.

Before we start changing the Body Mesh, let’s add some more detail to the mesh so that our edits will be more visible. We will do this by adding extra vertices to the mesh using the “Subdivision Surface” modifier.

1. Select the body mesh, then click on the Modifiers tab (it looks like a wrench) in the Properties panel
2. Click on “Add Modifier”
3. Select “Subdivision Surface”.
4. Lastly, click on the dropdown at the top-right of the “Subdivision Surface” panel that was created and select “Apply”.

You now have a higher-resolution mesh!

[](/img/lens-studio/body_morph_9.webm)

Now that we have our Body Mesh ready to edit, let’s switch over to Blender’s Sculpting tab, which can be found at the top of your Blender workspace.

In order to increase the size of the chest, arms, and stomach we will use the “Inflate Tool”.

1. Select the “Inflate Tool” from the left-hand panel.
2. After selecting the “Inflate” brush, at the top of the viewport, set “Radius” to 200px,
3. Set the “Strength” to 1, and turn on symmetry along the X-axis.

[](/img/lens-studio/body_morph_5.webm)

Now, using the “Inflate” brush, left-click and drag over the mesh to start editing the mesh.

[](/img/lens-studio/body_morph_4.webm)

Lastly, we need to export our creation as a new file we can send to Lens Studio. To do this, click “File” → “Export” → “FBX”

[](/img/lens-studio/body_morph_8.webm)

Congrats! You now have an External Body Mesh ready to be imported into Lens Studio.

### Applying the external body mesh to a Full Body Mesh[​**](#applying-the-external-body-mesh-to-a-full-body-mesh "Copy to clipboard")

Switch over to Lens Studio and in the Menu click on “File → Import”. Navigate to where the custom External Body Mesh is saved and double click it to begin the importing process.

Once the External Body Mesh is added to the scene, let’s begin the process of applying it to a Full Body Mesh.

#### Adding full body tracking[​**](#adding-full-body-tracking "Copy to clipboard")

1. First, disable the SceneObject titled “Examples \[EXPLORE\_ME]”.
2. Next, create a new SceneObject that is a child of the “Camera”.
3. Name it “My Full Body Mesh”4. With the new SceneObject selected in the `Scene Hierarchy` panel, click the plus sign in the top left corner of the `Scene Hierarchy` panel and add a “Full Body Tracking” Object, which can be found under “Object Tracking 3D”.

#### Connect the external body mesh to the body tracker[​**](#connect-the-external-body-mesh-to-the-body-tracker "Copy to clipboard")

With “Full Body Tracking” selected, perform the following;

1. Go to the Inspector panel and make sure that “Object Index” is set to `0`.
2. Next, in the `Asset Browser` panel, click on the plus button in the top left corner and select “Full Body Mesh”.
3. Rename this resource to “My Full Body Mesh”.
4. With “My Full Body Mesh” selected, go to the Inspector panel and drag-and-drop the custom External Body Mesh into the “External Mesh” dialog box. You now have a Full Body Mesh set up with your custom External Body Mesh.

#### Visualize the custom mesh in Lens Studio[​**](#visualize-the-custom-mesh-in-lens-studio "Copy to clipboard")

Now, let’s get the customized Full Body Mesh visible in the scene.

1. First, select the “3D Body Tracking” asset in the `Scene Hierarchy` panel.
2. Click the plus button in the top-left corner.
3. Add an “Empty Mesh”, and set it to be a child of the “3D Body Tracking" SceneObject.
4. With the “Empty” SceneObject selected, go to the “Inspector” panel and drag-and-drop the “My Full Body Mesh” asset into the “Mesh” dialog box.
5. Rename the “Mesh” SceneObject to “My Full Body Mesh”.

Congrats! You should now see your custom External Body Mesh being driven by the user’s pose. In order to get the user’s body texture applied to the mesh, simply replace the Render Mesh Visual’s Material slot with “Body\_Texture”.

This process is good for importing a 3D mesh that doesn’t have a skeleton attached to it.The following section will go over a different method of importing an External Body Mesh into the scene.

## Make Your Own External Body Mesh With Body Morph[​**](#make-your-own-external-body-mesh-with-body-morph "Copy to clipboard")

The following section will demonstrate how to import a custom 3D mesh into the Body Morph template and apply it to the user using a Full Body Mesh.

1. First, in Lens Studio navigate to the “Asset Library” and search for “Stick Figure 3D Model”.
2. Import the 3D model.
3. In the `Scene Hierarchy` panel, disable the “My Full Body Mesh” SceneObject.
4. Drag and drop the “StickFigure\_3DModel” asset into the `Scene Hierarchy` panel.
5. Make sure that the “StickFigure\_3DModel” is a child of the “3D Body Tracking” asset and the Stick Figure’s position is set to 0,0,0.
6. Next, click on the “3D Body Tracking” SceneObject in the `Scene Hierarchy` panel.
7. In the “Inspector” panel, click on the button titled “Match Hierarchy”. A dialog box will appear showing all the child SceneObjects of the “3D Body Tracking” SceneObject.
8. Click on the dropdown toggle next to “StickFigure\_3DModel”.
9. Click the dropdown toggle next to “SkeletonObject”, and finally click on “Hips”
10. Select “OK”. The “Attachment Points” in the “3D Body Tracking” component in the “Inspector” Panel should have been automatically populated with the joints in the “StickFigure\_3DModel”.
