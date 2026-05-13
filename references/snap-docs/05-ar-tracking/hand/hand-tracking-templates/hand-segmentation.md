# Hand Segmentation

The Hand Segmentation texture allows you to easily segment your hand and replace it with an image or a custom material.

This guide outlines several examples of using hand segmentation, such as occluding an object as it moves behind the hand, placing an image on the hand, and adding images with a parallax effect.

[](/img/lens-studio/hand-segmentation_hand-segmentation-1.webm)

The `Hand Segmentation 2D` and `Hand Segmentation 3D` examples outlined in this guide are available in the Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

## Scene Setup[​**](#scene-setup "Copy to clipboard")

To add Hand Segmentation texture to your project:

1. Click on the `+` button in the `Asset Browser` panel and select `Hand Segmentation Texture`.

![](/assets/images/hand-segmentation-add-to-scene-0a6a27a7074b3489a4bb397c3fe9a8c0.png)

2. In the `Scene Hierarchy` panel add new `Screen Image`. Set the texture of the Image component to the Hand Segmentation texture.

![](/assets/images/hand-segmentation-add-image-a3e34cd436f623df9a53728770d01305.png)

3. With the same scene object selected, click on the`Add Component` button in the `Inspector` panel and select `Rectangle Setter`. Set the Crop Texture input of Rectangle Setter component with the Hand Segmentation texture.

![](/assets/images/hand-segmentation-components-ad8bedd4235c6b89339d0d0465dd20c9.png)

## Examples[​**](#examples "Copy to clipboard")

`Hand Segmentation 2D` and `Hand Segmentation 3D` assets are available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import asset and then drag included prefab to the `Scene Hierarchy` panel.

In both examples Hand Segmentation Mask Camera is used to generate a full screen segmentation we used to work with. This camera also contains the `Hand Tracking` object which we use to get the position and rotation of the hand in the screen space so we can convert that into 3D space for use in the world space `Camera`.

![](/assets/images/hand-segmentation-camera-9dcd6df879e6ba96458885819ff6e402.png)

This means that the camera uses a render target to render the hand segmentation to it. You can find the `Render Target` in the `Asset Browser` panel, under the `Textures` folder, called `Mask Camera Render Target`.

Make sure the camera that renders the mask texture is set to render before the Orthographic camera. To do so select the `Scene` asset in `Asset Browser` and tweak the camera order in the `Inspector` panel:

[](/img/lens-studio/5-hand/hand-segmentation-camera-order.webm)

To learn more about this set up, check out the [Camera and Layers](/lens-studio/lens-studio-workflow/scene-set-up/camera.md) guide to learn more about render targets and camera.

Both examples share same helper scripts.

### Attach To Hand Helper[​**](#attach-to-hand-helper "Copy to clipboard")

The `Attach To Object Tracking` script allows you to attach any objects, regardless of whether it’s 2D, 3D, Text and more to your hand.

To make sure objects appear on the hand, just place any content as a child of the `Attach To Hand In 3D` in the `Scene Hierarchy` panel.

To customize, select the `Attach To Hand In 3D` object in the `Scene Hierarchy` panel and adjust its setting in the `Inspector` panel.

![](/assets/images/hand-segmentation-script-88e71170a67f18bb714a0028d49d4554.png)

**On Tracking Lost:** allows you to either keep or hide all the child objects as soon as hand tracking is lost.

**Apply Rotation:** if enabled applies rotation data from the hand tracking object to all the child objects.

**Behavior Trigger:** if enabled - allows to send custom triggers to the behavior script as soon as hand tracking starts tracking or lost tracking.

To use this trigger and make a custom action without coding, you need to import the behavior script into your project. To learn more about how to import and use behavior script please refer to the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) guide.

**Advanced:** enables additional settings. **Perspective Camera:** the perspective camera in scene (Make sure it's NOT an orthographic camera). **Object Tracking:** reference to the `Object Tracking` component. This example uses Hand Tracking 2D but this script can be used for other 2D tracking.

### Simple Hand Texture[​**](#simple-hand-texture "Copy to clipboard")

[](/img/lens-studio/hand-segmentation_hand-segmentation-7.webm)

This example uses custom shader to apply a texture to hand segmentation. To see how it works, unpack the imported asset package and select the `segmentation_simple` shader. Double click on the asset to open `Graph` editor panel.

### Parallax Hand Texture[​**](#parallax-hand-texture "Copy to clipboard")

[](/img/lens-studio/hand-segmentation_hand-segmentation-10.webm)

Parallax Hand Texture example uses the position data from the `Hand Object Tracking` to create a parallax effect look applied to the hand. This example uses a helper script called `ScreenTransformToMaterialProperty` to get a position data from `Hand Object Tracking` and then convert that data into a screen point.

![](/assets/images/hand-segmentation-script-1-ee730eb80eedf9bf61a34f588129d282.png)

After converting the data to screen point, this will pass the data to a material pass which is defined by the user. In this case it passes the data to the center property.

To see how the custom shader works on this example unpack the imported package for editing and double click on the `segmentation_parallax_material` shader to open `Graph` editor panel.

### 3D Object Example[​**](#3d-object-example "Copy to clipboard")

The `3D Object example` included in `Hand Segmentation 3D` asset shows how you can use an occluder in 3D space so you can have an object to move around a hand and as soon as it goes behind the hand it will get occluded.

`Hand Occluder` has a material which contains `Render Target` from the mask camera. You can use this object to occlude any objects that go behind the object. You can use the gizmo provided in this example to see where the object gets occluded in the `Scene Hierarchy` panel.

The gizmo is just an image of the hand and can be used as a reference in the `Scene Hierarchy` panel. It is not actually displayed in the scene.

![](/assets/images/hand-segmentation-gizmo-126fac2c3f045731529c0de1b3ebe31a.png)

The Airplane object uses a [Tween](https://lensstudio.snapchat.com/guides/scripting/helper-scripts/tween-manager/) script to rotate around the hand.

### Effects (Helper Scripts)[​**](#effects-helper-scripts "Copy to clipboard")

[](/img/lens-studio/hand-segmentation_hand-segmentation-15.webm)

This example comes with some helper scripts to help create a more immersive experience through interactivity.

You can find these effects in the `Scene Hierarchy` panel, under the `Attach To Hand` In `3D [OBJECTS_HERE] -> 3D Object Example -> Airplane -> Effects Controllers`.

![](/assets/images/hand-segmentation-effects-e55c86fe1704f821144f1358ecb77ac2.png)

Let’s take a look at all the effects as well as helper scripts listed below.

#### Hand Gesture Controller[​**](#hand-gesture-controller "Copy to clipboard")

Hand Gesture Controller uses hand gestures to create unique effects. To learn more about how the Hand Gesture Controller is working please refer to [Hand Gestures](/lens-studio/features/ar-tracking/hand/hand-tracking-templates/hand-gestures.md) guide.

#### World Particle Controller[​**](#world-particle-controller "Copy to clipboard")

Although this approach to particles is pretty old it still can be used in Lenses. Please refer to [VFX](/assets/files/_category_-01f773a8217c734fd6128bbebd31db19.json) guides to more particle capabilities added since this guide was released.

With the help of the world particles we can create a trail of smoke in the scene.

The way world particles work is that we used the same particle system which comes with the Lens Studio. With the `WorldParticleController` helper script you can assign your particles effect and then this script creates copies of the same particle and places it in the scene.

This helper script exposes some APIs so you can update the particles in run time. You can use [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) to call these APIs with no coding at all.

Take a look at the following examples below to see how they work:

#### Play or Stop Particles[​**](#play-or-stop-particles "Copy to clipboard")

To start or stop the particle you can call script API using behavior script and call the function to play or stop. Select the `Play or Stop Particles` scene object and check out Behavior script setup.

![](/assets/images/hand-segmentation-behavior-particles-bc81862ff99dff760882a89f3804dd49.png)

#### Update Particles Color on Gesture[​**](#update-particles-color-on-gesture "Copy to clipboard")

To change the color of the particles you can use a behavior script and call the `updateParticlePasses` function. When you call this function make sure to pass a pass name as well as a value related for the pass you want to change. In our example, we modify the `colorRampTexture` of the particle material.

Select the `Update Particles Color on Gesture` scene object to see the Behavior script setup:

![](/assets/images/hand-segmentation-script-behavior-color-6a0ce09e68911a26bf360650dbac8dc6.png)

#### Gesture Speed Control Effects[​**](#gesture-speed-control-effects "Copy to clipboard")

[](/img/lens-studio/hand-segmentation_hand-segmentation-21.webm)

Another helper allows to use the rotation of the hand and apply an effect based on the rotation value. In this case we use rotation angle to change the speed of the plane, as well as changing the hand color as value increases.

This effect starts working as soon as the user does the `One Finger` gesture and then can change the speed.

![](/assets/images/hand-segmentation-script-mat-parameter-bf7acd198b24b764203b6d2542563b45.png)

For example, in the `Objects Rotation to Material Parameter` example, we get data from the `Hand Tracking Center Object` and then we convert that into RGBA data. With use of this script we can change the color on the user's hand to turn to white on the lowest value and turn red on the max value.

There are a couple more examples using Object Rotation which you can find under the `Gesture Speed Control Effects` object in the `Scene Hierarchy` panel. Feel free to play around with these as you did above.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
