# Object Tracking

Object Tracking allows you to attach 2D images and animations to certain objects found in the scene. Object Tracking currently supports the detection and tracking of a Cat, Dog, Cat and Dog, Hand and Body. Object Tracking is able to, in real time, give you the screen space bounding box of the object found in the camera. Because of the 2D nature of the tracking, it works best for adding 2D images or animations to the tracked object. That said, you can also attach 3D objects to Object Tracking. See the [Object Tracking and 3D Objects](#object-tracking--3d-objects) section below for more information on how to do this.

There are various examples of Object Tracking usage: [Pet](/lens-studio/features/ar-tracking/world/world-templates/pet.md), [Hand](/lens-studio/features/ar-tracking/hand/hand-tracking-templates/hand.md), [Shoulder](/lens-studio/features/ar-tracking/body/body-templates/body.md), [Skeletal](/lens-studio/features/ar-tracking/body/body-templates/skeletal.md), [Full Body Triggers](/lens-studio/features/ar-tracking/body/body-templates/full-body-triggers.md).

[](/img/lens-studio/object-tracking_object_tracking_cat_example.webm) [](/img/lens-studio/object-tracking_object_tracking_dog_example.webm)

[](/img/lens-studio/object-tracking_object_tracking_hand_example.webm) [](/img/lens-studio/object-tracking_object_tracking_body_example_sm.webm)

[](/img/lens-studio/object-tracking_skeletal-preview-2.webm) [](/img/lens-studio/object-tracking_fbt-preview.webm)

## Adding Object Tracking to your Project[​**](#adding-object-tracking-to-your-project "Copy to clipboard")

### Add Object Tracking[​**](#add-object-tracking "Copy to clipboard")

To add Object Tracking to your project, in the `Scene Hierarchy` panel, select `+ -> Tracking` and the type of Object Tracking you'd like to use.

![](/assets/images/object-tracking-add-7fa9acaa5c1907f4115e309e71c154b2.png)

### Select Preview Video[​**](#select-preview-video "Copy to clipboard")

When working with Object Tracking, you'll want to switch the preview video to one with the object you're trying to track. In the `Preview` panel, press the `Image / Video Mode` button. Then, in the drop down at the top of the `Preview` panel, select the corresponding video under the `Object Tracking` category.

[](/img/lens-studio/object-tracking_general_object_2.webm)

### Configure Image[​**](#configure-image "Copy to clipboard")

The child-most Object Tracking object represents the attached 2D Image. Select it in the `Scene Hierarchy` panel to tune it in the `Inspector` panel. **double-click** on the object to open the `2D Editor` panel to help you position it visually.

![](/assets/images/object-tracking-sceneHierarchy-ff31d44989daf9f39c19e9f2a3a4e39a.png)

In the `Inspector` panel, open the `Material` inline-editor by pressing the `settings` button next to the field, and set the `Texture` field to an imported 2D image or animation.

![](/assets/images/object-tracking-imageComponent-8bcb5aab5d6ee82d44ee43508ab47b86.png)

Then, in the `2D Editor` panel, you can position, scale and rotate your attached 2D content with the bounding box handles.

[](/img/lens-studio/object-tracking_general_object_5.webm)

### Configure Attachment Point[​**](#configure-attachment-point "Copy to clipboard")

The parent Object Tracking object represents the actual tracking. Select it in the `Scene Hierarchy` panel to tune it in the `Inspector` panel.

![](/assets/images/object-tracking-select-tracking-8c25ec52c204e84e7b97cf2eeec3630c.png)

In the `Inspector` panel, you can adjust the tracked point via the `Attachment Point` dropdown.

![](/assets/images/object-tracking-change-attachment-e669b5adb234c32da5c2387806286933.png)

## Types of Object Tracking[​**](#types-of-object-tracking "Copy to clipboard")

### Cat[​**](#cat "Copy to clipboard")

Tracks a single Cat found in the camera.

[](/img/lens-studio/object-tracking_object_tracking_cat_example.webm)

**Available Attachment Points:** Center, Left Eye, Right Eye, Nose

### Dog[​**](#dog "Copy to clipboard")

Tracks a single Dog found in the camera.

[](/img/lens-studio/object-tracking_object_tracking_dog_example.webm)

**Available Attachment Points:** Center, Left Eye, Right Eye, Nose

### Cats and Dogs[​**](#cats-and-dogs "Copy to clipboard")

Tracks either a single Cat or single Dog found in the camera. Applies the same content to either.

[](/img/lens-studio/object-tracking_object_tracking_cat_example.webm) [](/img/lens-studio/object-tracking_object_tracking_dog_example.webm)

**Available Attachment Points:** Center, Left Eye, Right Eye, Nose

### Hand[​**](#hand "Copy to clipboard")

Tracks a single hand found in the camera.

[](/img/lens-studio/object-tracking_object_tracking_hand_example.webm) [](/img/lens-studio/object-tracking_hand-joints.webm)

**Available Attachment Points:** center, 4 joints on every finger, and 3 joints on the wrist

You can also use hand tracking to track joints on a person’s hand. Great for creating experiences that involves details on the hand, or to create [custom hand gestures](/lens-studio/features/ar-tracking/hand/hand-gestures.md).

Take a look at [3D Body and Hand Tracking](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) which is another way to track the hand.

### Shoulder[​**](#shoulder "Copy to clipboard")

Tracks a person's shoulder and neck. Detects and tracks when the person is medium to far away from the camera, making it distinct from face and skeletal tracking.

[](/img/lens-studio/object-tracking_object_tracking_body_example_sm.webm)

**Available Attachment Points:** Center, Left Shoulder, Right Shoulder

### Upper Body[​**](#upper-body "Copy to clipboard")

Tracks specific joints on a person’s upper body. Detects and tracks when the person is far away from the camera, making it distinct from face and shoulder tracking. Great for creating rear camera experiences that interact with a person.

[](/img/lens-studio/object-tracking_skeletal-preview-2.webm)

**Available Attachment Points:** Head, Neck, Left Shoulder, Right Shoulder, Left Elbow, Right Elbow, Left Wrist, Right Wrist

### Full Body[​**](#full-body "Copy to clipboard")

Tracks specific joints on a person’s full body. Detects and tracks when the person is even farther away from the camera, making it distinct from face, shoulder, and upper body tracking. Great for creating experiences that involves the whole body like a dance.

[](/img/lens-studio/object-tracking_fbt-preview.webm)

**Available Attachment Points:** Nose, Left Eye, Right Eye, Left Ear, Right Ear, Neck, Left Shoulder, Right Shoulder, Left Elbow, Right Elbow, Left Wrist, Right Wrist, Left Hip, Right Hip, Left Knee, Right Knee, Left Ankle, Right Ankle

## Object Tracking & 3D Objects[​**](#object-tracking--3d-objects "Copy to clipboard")

Take a look at the [Object Tracking 3D](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) guide, to attach objects to certain objects in 3D.

Object Tracking gives you the screen space bounding box of the object found in the camera. By default, object tracking supports the attachment of 2D images or animations to this bounding box. That said, you are able to attach 3D objects to Object Tracking. Because object tracking is in 2D screen space, we need to add a script to attach the 3D object at a tuned depth in the scene to the Object Tracking object.

First, download the AttachToObjectTracking.js script below:

### [Download AttachToObjectTracking.js](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Guides/T2kuv7A_2_0_0/files/AttachToObjectTracking.js.zip)[​**](#download-attachtoobjecttrackingjs "Copy to clipboard")

First unzip and then drag and drop the `AttachToObjectTracking.js` script into the `Asset Browser` panel. Next, create an new empty object in the `Scene Hierarchy` panel. Select the empty object and in the `Inspector` panel, select `+ Add Component` and choose the newly added `AttachToObjectTracking.js` script resource.

![](/assets/images/object-tracking-attachToObject-c14165c54aa91821ca5a00e05894b5aa.png)

Then set the AttachToObjectTracking settings as follows:

* **Perspective Camera:** Set this to the perspective camera in your scene (not the orthographic)
* **Object Tracking:** Set this to the Object Tracking object you want to attach your content to
* **Object to Attach:** Set this to the 3D Object you'd like to attach to your Object Tracking object
* **Base Depth Factor:** Tune the starting depth for the attached object. The depth is then scaled based on the size of the Object Tracking bounding box
* **Apply Rotation:** If the rotation of the Object Tracking object should be applied to the Object to Attach
