# Overview

World AR experiences refer to Lenses designed for the outward-facing camera, looking out at the world — in other words, not a selfie experience. Using various AR technologies, user can place virtual objects on real-life surfaces. With that in mind, in order to create believable, truly immersive experiences, it is critical that tracking technology can accurately track objects, people, things, and even reconstruct a space — like a room, street, or building — in 3D and in real time.

<!-- -->

<!-- -->

<!-- -->

<!-- -->

## Tracking[​**](#tracking "Copy to clipboard")

There are the fundamental tracking capabilities that allow you to track your experience to the real world.

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/world/tracking-modes.md)

[Device Tracking](/lens-studio/features/ar-tracking/world/tracking-modes.md)

[Using tracking information from the device, you can have your AR experience tracked around you (3DoF), on a surface like a floor, and even movement through spaces (6Dof).](/lens-studio/features/ar-tracking/world/tracking-modes.md)

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/world/marker-tracking.md)

[Marker Tracking](/lens-studio/features/ar-tracking/world/marker-tracking.md)

[You can track your experiences directly on an image. Knowing the image in advance, allows you to integrate your AR experience accurately.](/lens-studio/features/ar-tracking/world/marker-tracking.md)

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/world/object-tracking.md)

[Object Tracking](/lens-studio/features/ar-tracking/world/object-tracking.md)

[Using computer vision, you can track in 2D (screen space) various known things: e.g. pets, body, specific parts of the body, and more.](/lens-studio/features/ar-tracking/world/object-tracking.md)

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/body/object-tracking-3d.md)

[3D Object Tracking](/lens-studio/features/ar-tracking/body/object-tracking-3d.md)

[You can track certain things like the body, hand, etc. in 3D space for better fidelity and understanding.](/lens-studio/features/ar-tracking/body/object-tracking-3d.md)

[![](/img/lens-studio.svg)](/lens-studio/features/snap-ml/snap-ml-templates/object-detection.md)

[Custom ML Tracking](/lens-studio/features/snap-ml/snap-ml-templates/object-detection.md)

[You can add your own custom trackers using SnapML](/lens-studio/features/snap-ml/snap-ml-templates/object-detection.md)

## World Understanding[​**](#world-understanding "Copy to clipboard")

In addition to various trackers, you can have understanding of what you're tracking: whether it be through reconstruction, location information, and more. These features often extend and leverages the various trackers.

[![](/img/lens-studio.svg)](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md)

[World Mesh and Depth Textures](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md)

[World Mesh provides a real-time 3D reconstruction of the real world based on what your device sees. This allows your experience to better match and respond to the environment that it’s in.](/lens-studio/features/ar-tracking/world/world-mesh-and-depth-texture.md)

[![](/img/lens-studio.svg)](/lens-studio/features/location-ar/custom-landmarker.md)

[Custom Location](/lens-studio/features/location-ar/custom-landmarker.md)

[You can scan a World Mesh in advance, and track AR experiences uniquely on it.](/lens-studio/features/location-ar/custom-landmarker.md)

[![](/img/lens-studio.svg)](/lens-studio/features/location-ar/city-landmarker.md)

[City Scale AR](/lens-studio/features/location-ar/city-landmarker.md)

[You can track AR experiences to specific locations in cities around the world.](/lens-studio/features/location-ar/city-landmarker.md)

[![](/img/lens-studio.svg)](/lens-studio/features/location-ar/map-component.md)

[Map Component](/lens-studio/features/location-ar/map-component.md)

[You can display where the user is on a map to help guide them to an experience.](/lens-studio/features/location-ar/map-component.md)

[![](/img/lens-studio.svg)](/lens-studio/features/location-ar/spatial-persistence.md)

[Spatial Persistence](/lens-studio/features/location-ar/spatial-persistence.md)

[You can enable Lens users to save data to a physical location in the world.](/lens-studio/features/location-ar/spatial-persistence.md)

[![](/img/lens-studio.svg)](/lens-studio/features/location-ar/guide.md)

[Landmarkers](/lens-studio/features/location-ar/guide.md)

[You can track experience to famous Landmarks around the world.](/lens-studio/features/location-ar/guide.md)

[![](/img/lens-studio.svg)](world-templates/pet)

[Pet](world-templates/pet)

[You can track track cats, dogs, or both using Object Tracking 2D.](world-templates/pet)

## Additional Techniques[​**](#additional-techniques "Copy to clipboard")

In some cases, you might have some specific requirements like performance, information gathering, or access platform specific capabilities. You can integrate the following capabilities, in addition to the ones listed above.

[![](/img/lens-studio.svg)](world-templates/world-tracking-planes)

[World Tracking Planes](world-templates/world-tracking-planes)

[You can understand horizontal and vertical surfaces without waiting for World Mesh by relying on Tracked Planes.](world-templates/world-tracking-planes)

[![](/img/lens-studio.svg)](world-templates/instant-world-hit-test)

[Instant World Hit Test](world-templates/instant-world-hit-test)

[You can instantly get information about the world using Depth Texture, and when World Mesh is available, get a more accurate information.](world-templates/instant-world-hit-test)
