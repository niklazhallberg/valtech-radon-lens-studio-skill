# Physics

`Physics` sample project is available on Lens Studio [Home Page](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md).

The Physics sample project demonstrates how you can use [physics](/lens-studio/features/physics/physics-overview.md) in Lens Studio to dynamically simulate real-world physical effects and define 3D geometry for raycasting or collision detection.

[](/img/lens-studio/physics_physics.webm)

To learn more about physics in Lens Studio, please refer to the [Physics](/lens-studio/features/physics/physics-overview.md) guide for detailed explanations about the concepts and scripting.

## Guide[​**](#guide "Copy to clipboard")

### Raycasting[​**](#raycasting "Copy to clipboard")

Raycasting is a powerful feature enabled by the physics component. To demonstrate how raycasting works with custom scripts, we have included a Drag Script in this sample project. You can find it at the top of the hierarchy under `Physics Intro Examples`.

![](/assets/images/physics-drag-script-4ce2815b15cd4d1d18a6018883f6b4aa.png)

This script allows you to drag any dynamic object in this sample project using raycasting. Try interacting with any examples provided below to see how it works!

[](/img/lens-studio/physics_image8.webm)

### Examples[​**](#examples "Copy to clipboard")

Under `Physics Intro Examples`, there is a list of objects, each containing one example. We encourage you to toggle them one by one to explore different aspects of the physics feature. Each of these examples is designed to showcase one aspect of using the physics component. Let's dive into the examples now!

### Dynamic Setting[​**](#dynamic-setting "Copy to clipboard")

[](/img/lens-studio/physics_image2.webm)

The `Dynamic` setting makes an object interact with gravity and other forces. A dynamic object can be tossed, will fall, and can be moved around.

![](/assets/images/physics-dynamic-setting-448113e7cc50c3e8e5d5e3dcf18200c9.png)

You can make an object static by unchecking the `Dynamic` checkbox. If unchecked, the object will still react to other physical objects, similar to how a solid wall influences other physical objects.

### Fit Visual Setting[​**](#fit-visual-setting "Copy to clipboard")

[](/img/lens-studio/5-physics/physics-fit-visual.webm)

The `Fit Visual` checkbox allows you to adjust the Physics Body's bounding box according to the size of your mesh. If unchecked, you will have options to specify a custom size for your mesh.

### Mass Setting[​**](#mass-setting "Copy to clipboard")

[](/img/lens-studio/physics_image30.webm)

Changing the mass on the Physics Body setting determines how heavy your item would be. As shown in this example, the heavier box will “win” its place in a seesaw match on any given day!

![](/assets/images/physics-mass-setting-3a8c56d6b21483c194a15653fdbf5a6c.png)

### Density Setting[​**](#density-setting "Copy to clipboard")

[](/img/lens-studio/physics_image27.webm)

The density of the Physics Body determines how “dense” your object is. When two objects collide, the object with higher density is more likely to knock off the other object and continue maneuvering.

### Physics Body Types[​**](#physics-body-types "Copy to clipboard")

[](/img/lens-studio/physics_image16.webm)

Different physics body types can be created with the physics collider presets. Currently, supported colliders include `Box`, `Capsule`, `Cone`, `Cylinder`, `Mesh` and `Sphere`.

![](/assets/images/physics-shape-27082c34e8a5b4eea45ef56377116b2c.png)

You can also create a compound physics body by nesting different physics bodies to form a complex-shaped collider.

![](/assets/images/physics-compound-shape-de38c55207a702d817dfe8a4c8be7901.png)

### Constraint Types[​**](#constraint-types "Copy to clipboard")

[](/img/lens-studio/physics_image7.webm)

Setting up a constraint on the Physics Body is an excellent way to add interactivity. In this sample project, we provide examples of Physics Body constraints:

* **Fixed Constraint:** Completely freezes the physical movement of a physics body, turning it into a static object.
* **Point Constraint:** Freezes a single point of a physics body.
* **Hinge Constraint:** Freezes a side (axis) of the physics body geometry.
* **Point Constraint with Compound shapes:** Used with physics bodies of compound shapes.

To create a constraint, go to our physics object and click on the `Add Constraint Object` button.

![](/assets/images/physics-add-constraint-b2b02b443f5d4c077c96b684b10b24e6.png)

A constraint object will appear as a child of the Physics body. Move it around and change its type to see how it affects your object.

[](/img/lens-studio/5-physics/physics-constraint-types.webm)

Constraints cannot be moved (changes to their transforms after creation will be ignored). You can, however, move the `target collider` to which the constraint is attached.

### Advanced Example[​**](#advanced-example "Copy to clipboard")

This example lets you release a rubber duck into a pool of 100 balls, showcasing the Physics engine's capability to handle a large number of collisions in real time.

A Physics constraint body is disabled by Behavior script at the top, then the main actor, Ducky, will fall into a pool of spheres, making a splash!

Try tapping on the screen to release Ducky.

We recommend a maximum 200 physics objects for mobile devices and 100 physics objects for Spectacles (2021).

### Kinematic Example[​**](#kinematic-example "Copy to clipboard")

[](/img/lens-studio/physics_image10.webm)

The kinematic example showcases different ways that changing properties of a non-dynamic Physics Body such as scale, rotation and position influences other Physics Bodies.

### Multiple Worlds[​**](#multiple-worlds "Copy to clipboard")

[](/img/lens-studio/physics_image14.webm)

The Multiple Worlds example demonstrates different objects being influenced by different gravity settings, one with regular and another with inverted gravity.

Each of these groups have a `Physics World` parent that has a `Physics World Settings` asset assigned. Feel free to check out and customize the settings to create new physical worlds!

![](/assets/images/physics-multiple-worlds-4520b281c048b767e01eea075ce90677.png)

### Raycast Example[​**](#raycast-example "Copy to clipboard")

[](/img/lens-studio/physics_image9.webm)

The Raycast example shows how you can cast a ray from any position of a certain length, and trigger an action based on the raycasting.

Similar approach can be used in many different ways. Check out the `RayCast` script attached to the Cannon Raycast Example to learn more on how to customize the Raycast interaction.

![](/assets/images/physics-raycast-scripting-4b46dd50b7df8c773ff8388a4e1c19ac.png)

### Collision Example[​**](#collision-example "Copy to clipboard")

[](/img/lens-studio/physics_image5.webm)

The Collision example shows how existing animated objects with collisions can create new interactions using Physics. There are two examples under Collision Example:

* Using [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) Script for collision, requiring no scripting.
* Using the collision events API with scripting.

![](/assets/images/physics-collision-event-394cefbebc395e2b4b7e2aacb34db4f1.png)

### Collision Events with Behavior Script[​**](#collision-events-with-behavior-script "Copy to clipboard")

In this example we have attached 2 sphere colliders to Mark the Monster. And presented a row of piano underneath. Every time when a piano key is collided with predetermined physics objects, a sound will be triggered.

The interactions are done by Behavior script with its `Trigger` set as `Physics Collider Event`. Check out the Behavior scripts attached to each piano key to see how it works!

![](/assets/images/physics-collision-behavior-c0588f7ddf6d0c5f27f70e7880d46e8e.png)

### Collision Events API[​**](#collision-events-api "Copy to clipboard")

In this example, in addition to the sphere body collider, we also attached a CollisionEvents script to `Mark the Monster`’s left and right feet. Check out the `CollisionEvents` script to learn more on how to customize the collision events.

![](/assets/images/physics-collision-script-dbec0c22dad42ca144d4a5ed8491e457.png)

### Overlap Event[​**](#overlap-event "Copy to clipboard")

[](/img/lens-studio/physics_image36.webm)

An overlap event in physics means two objects’ colliders have overlapped. Unlike collision events, overlap events mean that two objects are intersecting without being bounced off.

Note that the `Intangible` checkbox is checked on the tunnel physics objects so their colliders would be penetrable by other physics colliders.

![](/assets/images/physics-intangible-fcca8147b93ee70a15249e8bccd86371.png)

There are also two examples under the Overlap Example. The first one using Behavior Script for overlap. The other one is using the overlap events API.

![](/assets/images/physics-overlap-example-b3de6c2eb30a82bd1e76e7ba2047a506.png)

### Overlap Events with Behavior Script[​**](#overlap-events-with-behavior-script "Copy to clipboard")

This example uses [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) scripts to change colors of the Pizza Delivery folks on an overlapped event similar to how collision works in the previous example. Check out their Behavior scripts to see how it works!

### Overlap Events API[​**](#overlap-events-api "Copy to clipboard")

This example uses the `OverlapEvents` script for both tunnels. Check out the `OverlapEvents` script to learn more on how to customize the overlap events.

![](/assets/images/physics-overlap-api-93a2e0f691e53ab27c59b7a9537af84b.png)

### Set Velocity[​**](#set-velocity "Copy to clipboard")

[](/img/lens-studio/physics_image24.webm)

In this example, each chicken has an initial velocity when being instantiated. And they will collide with the cannon colliders to form a trajectory forward. There are also two examples under the `Set Velocity Example`. The first one using Behavior Script. The other one is using the set velocity API.

![](/assets/images/physics-set-velocity-api-0adbfc713635b67e28b39ee757925393.png)

### Set Velocity with Behavior Script[​**](#set-velocity-with-behavior-script "Copy to clipboard")

The Set Velocity example showcases how to set force or velocity with Behavior script. You can find its velocity settings on the Behavior script attached to the object being instantiated on tap, which is attached to `parent > Chick Physics Body`.

Check out the `Force Type` and `Mode` on its behavior script to try different settings!

![](/assets/images/physics-velocity-behavior-32025ae2031eb25c931d54b76f819fa4.png)

### Set Velocity API[​**](#set-velocity-api "Copy to clipboard")

This example uses the `LaunchCannonBall` script for both tunnels. Check out the `LaunchCannonBall` script to learn more on how to set velocity to a physics body.

![](/assets/images/physics-launch-cannon-ball-4b7ec9e27feafdc8003369d117805979.png)

### Add Force[​**](#add-force "Copy to clipboard")

[](/img/lens-studio/physics_image19.webm)

The `AddForce` example allows you to add force with different properties by tapping on these objects. Each of these objects are pinned with a constraint and you can see how each object is affected by different types of forces added to them.

The type of force is added with tapping and the `Raycast` script will trigger a function to apply force to certain objects based on `ForceSetting`.

Check out the `ForceSetting` script attached to each object to see how to apply custom forces to your physics objects!

![](/assets/images/physics-force-setting-a76bfcc50e8d21e732b8c4cc9157c249.png)

### Wind Zone[​**](#wind-zone "Copy to clipboard")

[](/img/lens-studio/physics_image22.webm)

The Wind zone example simulates wind forces to affect objects inside the wind zone.

This interaction is done mostly with the `WindZone` script that automatically adds forces to all objects inside the wind zone (an `intangible` collider). Check out this script to learn more on adding forces on objects inside physics colliders!

![](/assets/images/physics-wind-zone-aefd0cb153f1dde9a9ab0646368af8a0.png)

### Text 3D Physics[​**](#text-3d-physics "Copy to clipboard")

[](/img/lens-studio/physics_image35.webm)

The [Text3D](/lens-studio/features/text/3d-text.md) component is a very convenient component that turns any of your written text into an interactive 3D object inside Lens Studio.

In this example, each text is being separated into a dynamic physics object with a box collider on tap. Try tapping on the screen and see for yourself!

All of these are done with the `Text3DPhysics` script. Check out this script and try to customize its settings to create variants of 3D Texts with physics!

[](/img/lens-studio/5-physics/physics-text.webm)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
