# Segmentation Trails

You can find this sample project on Lens Studio [Home Page](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md).

The Segmentation Trails sample project demonstrates how you can use multiple Cameras, as well as a Segmentation texture to create an effect that responds to movement on the body. It utilizes Render Targets and Graph Materials and can be a great way to learn about using them.

[](/img/lens-studio/segmentation-trails-_5.webm)

This project uses garment segmentation but does not rely on Body Tracking. This means that the effect can apply to multiple bodies at the same time! Take a look at the [Upper Garment Segmentation](/lens-studio/features/ar-tracking/body/segmentation/upper-garment-segmentation.md) example and [Garment Generation](/lens-studio/features/genai-suite/garment-generation.md) plugin to learn how you can attach things to the user’s garment.

## Guide[​**](#guide "Copy to clipboard")

The Segmentation Trails sample project has two main parts:

* Camera Feedback Loop - Responsible for creating the trail effect by feeding cameras into each other.
* Display - Responsible for creating a visual effect based on the result of the Camera Feedback loop.

### Camera Feedback Loop[​**](#camera-feedback-loop "Copy to clipboard")

The Camera Feedback Loop creates a disappearing trail from some segmentation texture. It uses two cameras, with the result of one being displayed on the other.

![Static picture of Camera Feedback Loop](/assets/images/segm-trails-1-0b15296950645aef4446fa51389cbcb1.png)

Under the `Helper` object in the `Scene Hierarchy` panel, you will find two cameras, each with their own layer. Each camera renders to its own Render Target. You can think of the Render Target as the ‘paper’ that the Camera prints its result to. Each frame, every camera will ‘print’ what it sees to this ‘paper.’

Every camera can render one or more Layers. The camera will only render things in the same layer as itself. In this case, because `Orthographic Feedback Camera 1` is on Layer 1, and `Orthographic Feedback Camera 2` is on Layer 2, the cameras will only see the Images on those layers.

The colored dots next to objects represent the layer that object is on.

![Static picture of Orthographic Feedback Camera 1 with layers](/assets/images/segm-trails-2-a975c5e6bd81057827c55dc566da7931.png)

You can see that `Orthographic Feedback Camera 1` displays the segmentation on the object `1. Display Current Segmentation`. You’ll also notice that in `Orthographic Feedback Camera 2` the result of Camera 1 is displayed on the object `2. Display Result of Camera 1`. Lastly, the result of Camera 2 is then displayed again in Camera 1.

Each frame, every Camera will render once. Since Camera 2 is displaying the result of Camera 1, the display of Camera 2 in Camera 1 will always be the result of Camera 1 from the last frame!

In our feedback loop, Camera 1 displays a Lower Garment Segmentation texture. So with this Feedback Loop, every frame, Camera 1 will composite the result of the previous Segmentation with the current result of the Segmentation.

![Static picture of Camera 1 Feedback Loop](/assets/images/segm-trails-4-806c3fd73d06be906b9e9c3eb643b169.png)

Since we want the trails to fade after some time, when displaying the Result of Camera 2 we add some opacity to hide the result of the previous frame.

Lastly, since we may want to have the effect appear without the user moving, the `3. Display Result of Camera 2` image is also offset slightly. That is, the previous frame will appear higher than the current frame. Try moving around the image in the Scene panel yourself to see what the feedback loop does!

![Static picture of 3. Display Result of Camera 2](/assets/images/segm-trails-3-274165742d80d6a8cc240a4eb3ed2c84.png)

The project also contains an `Optional Animations` object. This object contains Tweens that animate the Image component when the Lens runs. In other words, it’s what you did by hand in the Scene panel, but automated by script! Try turning it on by ticking the Checkbox to the right of the `Optional Animations` object.

### The Display[​**](#the-display "Copy to clipboard")

Now that we have a texture that shows the trail, we can display it in our scene the way we want. All the display objects are found under the `Orthographic Camera` object.

![Static picture of Display Objects under Orthographic Cameras](/assets/images/segm-trails-5-06ccbae9a08271933dca74327aef6544.png)

The `4. Display Trail` image displays the result of Camera 1 and adds a color on top of the trail image using a Graph Material. Double click on `Trail Material [EDIT_ME]` inside the `Materials` folder in the `Asset Browser` panel to see how this is done. You can see that we display some `Base Color`, and cut out where the color appears, based on the opacity of the result of Camera 1.

![Static picture of Display Trail](/assets/images/segm-trails-6-f6f49c9b89881de3b223dcc4919c9181.png)

In the material setting, this image is displayed in `Add` mode to allow the colors to be added to the original texture:

![Static picture of Trail Material](/assets/images/segm-trails-7-f982e3d8feb103d39bf686515f546523.png)

Next, since we want to make the trail appear behind the user, we have a `5. Display Original in Front` image which shows the original camera feed, but cut out by another Segmentation texture in front of the effect. This material is a copy of the built-in Unlit Graph Material.

Note that the segmentation texture used to cut out here is the `Full Garment` rather than just the Lower Garment, since we want the trail to appear behind the user’s body as well.

The machine learning model that cuts out the garment has been optimized such that you can use either upper, lower, or full garment segmentation with negligible impact.

![Static picture of 5.Display Original in Front](/assets/images/segm-trails-8-16d942056c814e457eb1916d3607d94f.png)

Finally, to make our pants magical, we multiply a color on top of the pants in the `6. Pants Colorizer` image! Double click the `Rainbow Colorizer` material in the `Asset Browser` panel to see how it works.

In this material, notice that we use time as a value to the `HSV to RGB` node to create the rainbow color, and then use another texture (`Opacity Texture`) to cut out the effect to the specific area.

Compare the `Trail Material` from before, with this `Rainbow Colorizer Material` and see how you might make your own!

![Static picture of Rainbow Colorizer Material](/assets/images/segm-trails-9-f76c23a86c4a7675e70fc5f3e7f48c9a.png)

Like before, you’ll notice in the `Inspector` panel, the `Blend` mode of this image is Multiply, so the real user’s pants show through.

![Static picture of Multiply Blend Mode](/assets/images/segm-trails-10-5c28686e97532e3e3ef8f14279ef7c4f.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
