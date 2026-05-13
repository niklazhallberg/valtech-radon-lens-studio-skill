# Face Landmarks

Face Landmarks are 93 points that are tracked with the user's face. Like [Object tracking](/lens-studio/features/ar-tracking/world/object-tracking.md), the position of the points are in screen space.

Face Landmarks are great if you want to track specific parts of the face since you have 93 points to attach to. You can also make fun interaction by getting distance between two of the landmarks and make interaction based on the distance.

The guide below walks through getting the position of points and then attaching an object to specific points.

To learn more, take a look at the [Face Landmarks](/lens-studio/features/ar-tracking/face/face-templates/face-landmarks.md) example which allows you to pin objects to a point and create effects based on the distance of points.

## Face Landmarks Points[​**](#face-landmarks-points "Copy to clipboard")

Each point of the face landmark is referred to by a specific number. Take a look at the map below to find the point that you are looking for.

![](/assets/images/face-landmark_face-landmark-10-517debcb92a7a0bfcd38bbcb06f52fea.png)

These points can be accessed through the `Head Binding` component.

To add a `Head Binding` component, in the `Scene Hierarchy` panel click on `+ -> Head Binding`.

![](/assets/images/face-landmark-1-0aee148f4f052736bb8d6f667dcdba38.png)

Now we will make a script and attach it to the sphere that we just created.

 To learn more about scripting, check out the [Scripting](/lens-studio/features/scripting/script-overview.md) overview page

Next we’ll get a reference to the head binding with our script. You can do this by adding an `input` to the script, and adding the `Head Binding` reference in the `Inspector` panel of the object the script is attached to:

```
//@input Component.Head headBinding
```

[](/img/lens-studio/5-essential/face-landmark-2.webm)

In the same script, you can then access the landmark:

```
script.createEvent('TurnOnEvent').bind(function () {
  const landmarkId = 30;
  const landmarksPosition = script.headBinding.getLandmark(landmarkId);

  print(landmarksPosition);
});
```

In this script, we print the position of the landmark `landmarkId` during the `TurnOnEvent`. We call `getLandmark` during the `Turn On Event` to give time for the head component to initialize.

You can only get the landmark when a head is detected, so you should ensure a head is being tracked before chedcking the landmark. For example: you can return early if the faces count is less than one to skip `getLandmark`.

```
if (script.headBinding.getFacesCount() < 1) return;
```

Take a look at the [API page](https://developers.snap.com/lens-studio/api/interfaces/Lens_Scripting.Built_In.Head.html#getLandmark) for more information.

### Using Face Landmark Position[​**](#using-face-landmark-position "Copy to clipboard")

You can use this position the same way you would use any other screen position. For example, you can use this position to attach a [screen image](/lens-studio/assets-pipeline/2d/image.md) to that face landmark’s position.

You can use the code below to attach any screen objects to a landmark on your face. Copy and paste the following code into a script and add it to any object.

```
// -----JS CODE-----
//@input int faceLandmarkIndex = 30 {"min": 0, "max": 92}
//@input Component.Head headBinding
//@input Component.ScreenTransform screenImage
var isFaceTracking = false;
var landmarksPosition = vec3.zero();
var screenImage = script.screenImage;
function onUpdate() {
  if (!isFaceTracking) {
    return;
  }
  landmarksPosition = script.headBinding.getLandmark(script.faceLandmarkIndex);
  var parentPos = screenImage.screenPointToParentPoint(landmarksPosition);
  screenImage.anchors.setCenter(parentPos);
}
function onFaceFound() {
  isFaceTracking = true;
}
function onFaceLost() {
  isFaceTracking = false;
}
var faceFoundEvent = script.createEvent('FaceFoundEvent');
faceFoundEvent.bind(onFaceFound);
var faceLostEvent = script.createEvent('FaceLostEvent');
faceLostEvent.bind(onFaceLost);
var updateEvent = script.createEvent('UpdateEvent');
updateEvent.bind(onUpdate);
```

Then, in the `Inspector` panel you can put the desired landmark, as well as the head binding and [screen image](/lens-studio/assets-pipeline/2d/image.md) reference to have the screen image be automatically tracked to that part of the face.

[](/img/lens-studio/5-essential/face-landmark-3.webm)

These points are tracked in screen space but since it uses head binding, you can get the depth position as well as rotation from the head binding component as well. To learn more about this you can take a look at the [Face Landmarks](/lens-studio/features/ar-tracking/face/face-templates/face-landmarks.md) example.
