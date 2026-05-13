# Body Segmentation

This guide covers several examples of using [segmentation texture](/lens-studio/features/ar-tracking/body/segmentation/fullscreen-segmentation.md) to create different visual effects. The examples come with different Graph Material examples that you can use, modify or mix and match. It also gives examples of couple interactive experiences.

[](/img/lens-studio/body-segmentation_body-segmentation-preview.webm)

## Guide[​**](#guide "Copy to clipboard")

The Body Segmentation guide contains several examples on how you can utilize the Body Segmentation texture. Find the `Body Segmentation - Screen Transform`, `Body Segmentation - Body Tracked`, `Body Segmentation - Freeze` and `Body Segmentation - Time Effect` assets in the Asset Library and import them into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

### Body Segmentation - Screen Transform[​**](#body-segmentation---screen-transform "Copy to clipboard")

Once you import the asset from Asset Library, you can find the package in the Asset Browser. Follow the instructions and drag the prefab `Body Segmentation__PUT_IN_ORTHO_CAM` into Scene Hierarchy to create a new Scene Object under Orthographic Camera. If your scene doesn't have an Orthographic Camera, you can create one by clicking the `+` button at the top left corner of the `Scene Hierarchy` panel, typing "Orthographic Camera" to find the Orthographic Camera object, and clicking on it to add it to the scene.

![](/img/lens-studio/5-features/body-segmentation-screen-transform-hierarchy.png)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

Lets expand the object's children. You can think of this example as a collage, where each screen image is placed on the top of another.

One of the children here is different from others as they contain special textures that displays the body:

* **Body Image -** is an image created by masking a camera input with the Segmentation Texture

You can also duplicate the `Body Image` and place them on the screen to create copies of a person in the video!

[](/img/lens-studio/5-features/body-segmentation-duplicate-body-image.webm)

We are mostly using Screen Images (Full screen) and Post effects with segmentation texture since they both create full screen experiences.

### Body Segmentation - Body Tracked[​**](#body-segmentation---body-tracked "Copy to clipboard")

Another way to use the segmentation mask is to cut out things so that they show up behind the user. Once you import the asset from Asset Library, you can find the package in the Asset Browser. Follow the instructions and drag the prefab `Body Segmentation - Body Tracked__PUT_IN_ORTHO_CAM` into Scene Hierarchy to create a new Scene Object under Orthographic Camera. If your scene doesn't have an Orthographic Camera, you can create one by clicking the `+` button at the top left corner of the `Scene Hierarchy` panel, typing "Orthographic Camera" to find the Orthographic Camera object, and clicking on it to add it to the scene.

![](/img/lens-studio/5-features/body-segmentation-body-tracked-scene-hierarchy.png)

In the `Inspector` panel, see the `Image` component displaying the wings seen in the preview. Notice that this object has a texture `Wing`, as well as an `Body Segmentation` as the `Opacity Texture`. In other words, this object displays the wing image, which is cut out by the body.

You can dive deeper into how this cut out work by opening the material. Right click on the `Material` input field of the `Image` component and select `Highlight`. Then double click on the selected `Material` to open Material Editor.

![](/img/lens-studio/5-features/body-segmentation-wings-material.png)

Notice how the two textures are combined to form the final result. Notice also, that they use two different UV coordinates to display the texture. The `Base Texture` uses the `Surface Coord,` since we want the texture to be displayed on the `Image` component, whereas the `Opacity Texture` uses the `Screen Coord,` since the segmentation texture is of the whole screen.

Learn more about how materials are created in the [Material Editor guide](/lens-studio/features/graphics/materials/overview.md).

![](/img/lens-studio/body-segmentation_body-segmentation-10.png)

Let’s now make another Screen Image like this. On the `Scene Hierarchy` panel select the `Body Segmentation - Body Tracked` scene object. Then press `“+” -> Screen Image`.   Then let’s make a copy of a wing material and call in `Circle Mat`. Now assign this material by dragging and popping it to the `Material` field of the newly created `Screen Image`. Drag and drop a texture of choice.

Now as we drag the screen image on the screen, you can see how it is being masked. The circle moves with the Screen Image, but the Opacity Mask stays the same. Lastly, you can change the order of composition by changing the order of objects in the `Scene Hierarchy` panel.

[](/img/lens-studio/body-segmentation_body-segmentation-11.webm)

This example contains a RotateTowardsTarget script which allows you to rotate your images towards another object (in this case it moves the wing based on the elbow

![](/assets/images/body-segmentation-rotate-towards-target-673793b4107f1f440e10955bb6245457.png)<br />**Targets -** a list of sceneObjects, current transform will be rotated towards the median point of the positions of the objects **Offset -** the offset in degrees from the target angle<br />**Smooth Coef -** a smoothing coefficient applied to the object’s rotation

### Body Segmentation - Freeze[​**](#body-segmentation---freeze "Copy to clipboard")

Once you import the asset from Asset Library, you can find the package in the Asset Browser. Follow the instructions and drag the prefab `Body Segmentation - Freeze__PLACE_IN_SCENE` into Scene Hierarchy to create a new Scene Object. Expand the object and drag the Render Target in the Asset Browser to the `Orthographic Camera [SET_RENDER_TARGET]` Render Target field.

[](/img/lens-studio/5-features/body-segmentation-freeze-set-render-target.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

This example showcases how to create a cool animated poster with a person cut-out. It creates this poster by doing the following:

1. Composing the poster with screen images (like in example 1)
2. Disabling the Body Effect camera, to freeze the current frame
3. Using a script to trigger step 1 and 2 with a timer

#### Body Effect Camera[​**](#body-effect-camera "Copy to clipboard")

Let’s look deeper into how the Body Camera and Render Target works.

At the top of the `Scene Hierarchy` panel, there is a `Body Effect Camera` which renders to the `Body Render Target`. It is a helper camera that allows us to apply some effects only to the user body.

Try adding more Post Effects from the `Scene Hierarchy` panel and see how it affects the result in the Preview. After adding new post effects drag and drop them under the Body Effect Camera.

![](/img/lens-studio/5-features/body-segmentation-body-effect-camera.png)

Make sure that the effects have the same [Render Layer](/lens-studio/lens-studio-workflow/scene-set-up/camera.md) as your camera.

![](/img/lens-studio/5-features/body-segmentation-freeze-set-render-layer.png) [](/img/lens-studio/body-segmentation_body-segmentation-6.webm)

#### Freeze Composition[​**](#freeze-composition "Copy to clipboard")

Under the Orthographic Camera - Freeze Frame, let’s first disable the `Freeeze Frame Scripts` and take a look at the `Composition` object. Same components we saw before are used here  (screen images for background and body image, for additional elements)  as well as tween scripts that will add movement to the composition after the frame is frozen. Try doing the following:

* Swap background image by clicking on the texture field of the image component.
* Swap textures and move additional screen images on the screen.
* Modify tween script settings on Body Image and Text sceneObjects.

#### Freeze Frame Scripts[​**](#freeze-frame-scripts "Copy to clipboard")

Next, let’s take a look at the children of `Freeze Frame Scripts`.

##### Timer[​**](#timer "Copy to clipboard")

The Timer object contains an interaction helper, and can be easily reused for other delayed interactions with countdown. It uses a `Text` Component to show a prompt to do some action, then the script waits for itself to be called. When called, it starts a countdown and calls another custom Behavior trigger at the end of it.

![](/img/lens-studio/5-features/body-segmentation-freeze-timer.png)

* **Start Timer on -** call this Custom Behavior Trigger to start timer.
* **Reset Timer on -** call this Custom Behavior Trigger to reset timer to initial state.
* **Countdown Length -** sets countdown length.
* **Step -** sets the time between countdown iterations.
* **Countdown Text -** sets the Text Component to display instruction and countdown.
* **Hint -** sets the instruction text to be displayed. Can be empty

We are using this timer script to create a delayed response for the `Freeze Frame Example` so the user has time to step back from the Camera.

##### Freeze Frame Controller[​**](#freeze-frame-controller "Copy to clipboard")

This object contains a script that enables certain objects, while disabling others when another script calls it. In this case, we use it to enable our `Composition` from earlier, while disabling a camera to freeze the current frame it's on.

![](/img/lens-studio/5-features/body-segmentation-freeze-controller.png)

* **Freeze Trigger -** the Custom Behavior Trigger Name that is used to trigger freeze frame and  .
* **Reset Trigger -** the Custom Behavior Trigger Name that is used to trigger un-freeze frames.

##### Behaviors[​**](#behaviors "Copy to clipboard")

Lastly, the `Behaviors [EDIT]` object has a 3 behavior script that takes care of the interactions.

[](/img/lens-studio/body-segmentation_body-segmentation-15.webm)

The first behavior script toggles between two custom triggers on `Tap` Event. We saw their names before in the previous scripts. Try tapping on the `Preview` panel screen and see what happens.

The second Behavior script is called on `Lens On Awake` and it sets the initial state of this example.

The third Behavior script calls our timer from earlier when the user starts recording.

### Body Segmentation - Time Effect[​**](#body-segmentation---time-effect "Copy to clipboard")

The last example allows us to create a sequence of different effects tied up to the audio clip timestamps. Once you import the asset from Asset Library, you can find the package in the Asset Browser. Follow the instructions and drag the prefab `Body Segmentation - Timed Effect__PUT_IN_ORTHO_CAM` into Scene Hierarchy to create a new Scene Object under Orthographic Camera. If your scene doesn't have an Orthographic Camera, you can create one by clicking the `+` button at the top left corner of the `Scene Hierarchy` panel, typing "Orthographic Camera" to find the Orthographic Camera object, and clicking on it to add it to the scene.

![](/img/lens-studio/5-features/body-segmentation-time-effect.png)

When you select the `Controller` Script, you'll find an`Audio Attached Sequence` script in the `Inspector` panel. This script defines what should be done, when certain time has passed on an audio.

![](/img/lens-studio/5-features/body-segmentation-time-effect-audio-attached-sequence.png)

**Action type -** specifies one of the three types of sequences :

* Enable one scene object from a **SceneObjects** list at a time and disable the previous.
* Call start tween on one scene object from a **SceneObjects** list at a timestamp, and call stop tween on the previous one.
* Call a “**Start function name**” script api function on one scene object from a **SceneObjects** list at a timestamp, and call “**Stop function name**” script api function on the previous one.

If you want to have more than one type of action - create another script component with Audio Attached Sequence with different settings.

If you wan’t to enable more than one scene object at a time try grouping them into hierarchy and use parent object as an input.

**Scene Objects -** scene objects to toggle between/call tween on/or call api function on

**Audio -** This is the Audio Component used to drive the effects. In other words, the time on this Audio component, decides when the effects should be called.

#### Playing the Audio[​**](#playing-the-audio "Copy to clipboard")

In this template, the `Audio` field is connected to the `Audio [SWAP ASSET]` object. Click on the `Audio Track` field of the Audio component to swap the asset.

![](/img/lens-studio/5-features/body-segmentaion-time-effect-audio-component.png)

We are using the Autoplay `Loop` checkbox on an Audio Component to play audio when lens starts and a `Behavior script` to restart audio when `Recording Starts`.

You can easily integrate a Timer helper script from the previous example for this one too!

![](/img/lens-studio/5-features/body-segmentation-time-effect-behavior.png)

#### Effects Being Called by The Audio Attached Sequence[​**](#effects-being-called-by-the-audio-attached-sequence "Copy to clipboard")

Under the `Effects` scene object you can see some `Post Effect` examples that showcase what you can do with body segmentation texture with Material editor.

To see how they work,  select one of the objects in the `Scene Hierarchy` panel, then in the `Inspector` panel, right click on the `Material` field and select `Highlight`.

Modify materials to your liking by changing material properties in the `Inspector` panel. To do deeper customization, double click on the highlighted material in the `Asset Browser` panel to open the Material editor and edit the shader.

[](/img/lens-studio/5-features/body-segmentation-time-effect-tiled-scrolling.webm)

You can even drive the material in real time when the Lens is being used! Add dynamics to the material by driving a material property value with a `Tween Value` script. Take a look at the `Flames` example to see how this might work.

[](/img/lens-studio/5-features/body-segmentation-time-effect-tween-color.webm)

You can use two segmentation textures to create an outline by having one be feathered, while the other ones refined. we are using two instances of the Segmentation Texture to create both smooth and precise masking.

![](/img/lens-studio/5-features/body-segmentation-feathered-refined.png)

Use `ClampToEdge` Setting for the `Segmentation` texture to avoid undesired texture repeating.

![](/img/lens-studio/5-features/body-segmentation-clamp-to-edge.png)

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
