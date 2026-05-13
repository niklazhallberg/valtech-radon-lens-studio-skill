# Physics Overview

Use Lens Studio’s physics engine to make your Lenses more dynamic and engaging.

The physics engine allows you to:

* Dynamically simulate real-world physics effects.
* Define 3D geometry to determine when objects or rays intersect.

Check out [Physics](/lens-studio/features/physics/physics-examples/physics.md) sample project and [Physics Toys](/lens-studio/features/physics/physics-examples/physics-toys.md) guide for examples of using Physics in Lens Studio.

[](/img/lens-studio/physics-overview_physics.webm)

## Getting Started[​**](#getting-started "Copy to clipboard")

Learn more about adding physics to your Lenses:

* [Physics Assets and Components](/lens-studio/features/physics/physics-component.md)
* [Force](/lens-studio/features/physics/force.md)
* [Raycast](/lens-studio/features/physics/raycast.md)
* [Collision and Overlap](/lens-studio/features/physics/collision-and-overlap.md)

Trigger and respond to Physics using the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) helper script.

## **Limitations**[​**](#limitations "Copy to clipboard")

* Different devices will have different limitations for the number of objects it can simulate since it depends on the processing power available to the device. You should optimize your Lens' physics usage according to your needs and test on a variety of devices. Different features, such as hair and cloth simulation, involve heavy processing that can cause your FPS to drop.
* Avoid very small or very large collision bodies. We recommend a minimum size of 10 cm and a maximum size of 5m for moving and colliding bodies under normal gravitational forces. Lens Studio’s default units are in cm.
* Continuous Collision Detection is not supported. Fast moving objects might go through thin colliders due to tunneling.
