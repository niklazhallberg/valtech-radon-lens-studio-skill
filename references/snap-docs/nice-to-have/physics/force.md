# Force

There are various way force can be applied to move a physics body.

[](/img/lens-studio/force_force.webm)

Try playing with these different force mode through [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md).

## Force Mode[​**](#force-mode "Copy to clipboard")

* **VelocityChange :** an instant addition of velocity that will be applied immediately, ignoring mass. Examples: pushing an object away on `TapEvent`, or making an object jump upwards triggered by `OnCollisionEnter`.

* **Acceleration :** a continuous acceleration that you will continue applying over time, ignoring mass. Examples: a rocket booster triggered every `UpdateEvent`, or a custom gravity force triggered by `OnCollisionStay`

* **Impulse :** an instant force that will be applied immediately. Examples: pushing an object away on `TapEvent`, or making an object jump upwards triggered by `OnCollisionEnter`.

* **Force :** a continuous force that you will continue applying over time. Examples: a rocket booster triggered every `UpdateEvent`, or a wind force triggered by `OnCollisionStay`.

* **Set Velocity:** an instant overwrite of velocity that will be applied immediately. Examples: stopping an object by setting velocity to `(0,0,0)`, or making an object jump upward while canceling any existing velocity.

## Force Type[​**](#force-type "Copy to clipboard")

* **Position:** Apply linear force at the object's center-of-mass.
* **Position With Offset:** Apply force at a point offset from the object's origin, effectively generating torque.
* **Rotation:** Apply torque (angular force) relative to local rotation..

To apply relative force to local rotation, use the add relative force function. Optionally, use the set velocity function to overwrite the velocity of a dynamic physics body.

```
bodyComponent.addForce(new vec3(0.0, 10.0, 0.0), Physics.ForceMode.Force);
bodyComponent.addForceAt(
  new vec3(0.0, 10.0, 0.0),
  new vec3(0.0, 10.0, 0.0),
  Physics.ForceMode.Acceleration
);
bodyComponent.addTorque(new vec3(0.0, 10.0, 0.0), Physics.ForceMode.Impulse);
bodyComponent.addRelativeForce(
  new vec3(0.0, 10.0, 0.0),
  Physics.ForceMode.VelocityChange
);
bodyComponent.addRelativeForceAt(
  new vec3(0.0, 10.0, 0.0),
  new vec3(0.0, 10.0, 0.0),
  Physics.ForceMode.Acceleration
);
bodyComponent.velocity = new vec3(0.0, 100.0, 0.0);
bodyComponent.angularVelocity = new vec3(10.0, 0.0, 0.0);
```

To learn more about Behavior Script and APIs for Force, check [Physics Template](/lens-studio/features/physics/physics-examples/physics.md) - Add Force and Wind Zone Examples.
