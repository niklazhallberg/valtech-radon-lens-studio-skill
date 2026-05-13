# Physics Assets and Components

Physics is added to a Lens through a variety of assets and components that allow you to define how physics works on an object and in a scene.

## Overview[​**](#overview "Copy to clipboard")

You can define a scene's physics properties through the WorldSettings, Physics Matter and Physics Filter Assets. These are settings that apply uniformly for a world, such as gravity direction and magnitude, default matter, default filter, simulation rate, slow motion, max speed and layer collision matrix etc.

You can define an object's physics properties through:

* **Collider Component:** Colliders are primitive shapes that physics objects interact with, such as spheres, boxes, and meshes, or compound shapes formed from multiple shapes.
* **Body Component:** Physics bodies are colliders that are moved dynamically by the physics simulation, in response to gravity, collisions, and other forces.
* **Constraint Component:** Constraints body motion in configurable ways. You can use it to simulate physical objects such as joints and hinges.
* **Physics Matter:** Contains collider settings, such as friction and bounciness.

## Physics Assets[​**](#physics-assets "Copy to clipboard")

### WorldSettings[​**](#worldsettings "Copy to clipboard")

The WorldSettings asset configures physics uniformly for the entire world. Key properties include:

![](/assets/images/physics-component_image11-ab67f4e9ddc6fb10a1cdd50fc2f47eea.png)

* **Gravity:** Gravity direction and magnitude.
* **Default Matter:** Default Physics.Matter for all colliders in the world. This is used for a collider when its matter field is unset.
* **Default Filter:** Default Physics.Filter allows filtering by layer and to specific colliders.
* **Simulation Rate:** Simulation step rate. This trades performance for simulation quality (higher values increase quality). It defaults to 60 and increments in multiples of 30, in the range 30-240.
* **Slow Step:** Slow down simulation step frequency (higher values are slower). This achieves a slow-motion effect by reducing the number of simulation steps each frame. Large values will cause noticeably discrete steps, which is mostly useful for debugging.
* **Slow Time:** Slow down simulation time (higher values are slower). This achieves a slow-motion effect by scaling simulation time. Unlike slowDownStep, it will maintain smooth motion, but has accuracy problems at large scales.
* **Absolute Speed Limit:** Speed limit, in world space cm/s. This is useful for preventing tunneling issues at high speeds and small sizes. Set to 0 to disable.
* **Relative Speed Limit:** Speed limit, relative to shape size. The size scaling makes this easier to configure for arbitrary collider sizes. The effective world space speed limit is scaled by simulation rate, so this is the maximum distance the object can move in a single step. The default of 0.5 only allows the object to move by half its size in a single step, which should prevent tunneling.
* **Layer Collision Matrix:** Control which layers interact with one another.

Click [here](/lens-studio/lens-studio-workflow/scene-set-up/camera.md#assigninglayers) to learn more about create new layers.

To customize your scene's physics settings, add at least one Physics World Settings asset to your `Asset Browser`. Although a default configuration is always present—similar to the default render target and device camera—this default cannot be customized. Without a custom Physics World Settings asset, the scene defaults to standard settings, which limits customization and may cause issues for scripting functions that rely on `getRootWorldSettings()`.

To assign your World Setting, click on the Scene asset in the `Asset Browser`. This action will reveal the Physics Root Settings field, where you can link the World Setting asset created. This specified setting will serve as the default for all physics world components within the scene.

* Each world component optionally references one of these assets, and uses the Physics Root Settings otherwise.
* Additionally, World Settings may be applied per-collider.

Gravity acceleration vector (cm/s²), which defaults to real-world gravity of 980 cm/s² downward.

New Physics World Settings can be added by pressing the `+` button on the `Asset Browser` panel.

[](/img/lens-studio/physics-component_image8.webm)

You can also modify the world settings via [scripting](/lens-studio/features/scripting/script-overview.md) APIs.

```
// Change World Settings properties.
worldSettings.gravity = new vec3(-20, 0, 0);
worldSettings.simulationRate = 120;
worldSettings.slowDownStep = 2.0;
worldSettings.slowDownTime = 1.5;
worldSettings.absoluteSpeedLimit = 1000.0;
worldSettings.relativeSpeedLimit = 0.0;
worldSettings.defaultMatter = script.myMatter;
worldSettings.defaultFilter = script.myFilter;
worldSettings.setLayersCollidable(0, 3, false);
worldSettings.getLayersCollidable(3, 0);
worldSettings.resetLayerCollisionMatrix();
```

### Physics Matter[​**](#physics-matter "Copy to clipboard")

![](/assets/images/physics-component_image9-1376dc7250ff493b782701f61f318a99.png)

* **Friction:** Coefficient of friction.

  <!-- -->

  * The effective friction between two objects is the product of both objects' friction. So for example, the default between two objects is 0.5\*0.5=0.25.
  * Typical ranges are between 0 and 1, but larger values (up to 10) are allowed. This may be used to increase the effective friction when colliding against another object with low friction.
  * This is a very simplified approximation of realistic friction, since it does not correctly take into account the combined surface characteristics of both objects. It also doesn't distinguish between static and dynamic friction.

* **Rolling Friction:** Friction applied to rolling objects. This isn't physically realistic, but helps prevent objects from rolling indefinitely.
  <!-- -->
  [](/img/lens-studio/physics-component_friction.webm)

* **Spinning Friction:** Friction applied to spinning objects. This isn't physically realistic, but helps prevent objects from spinning indefinitely.
  <!-- -->
  [](/img/lens-studio/physics-component_spinning-friction.webm)

* **Bounciness:** Bounciness (also known as restitution), for dynamic bodies. This is the proportion of energy preserved after a collision, in the range 0 to 1.

  <!-- -->

  * This defaults to 0.0. Dynamic bounciness should usually be less than 1.0, to prevent energy from accumulating excessively (there is a certain amount of energy gained due to collision response).
  * The effective bounciness for a collision is the product of both colliding objects. So if your bounciness setting appears to have no effect, it probably means the object it's colliding with has 0 bounciness.

* **Static Bounciness:** Bounciness (also known as restitution), for static colliders. This is the proportion of energy preserved after a collision, in the range 0 to 1.

  <!-- -->

  * This defaults to 1.0. Typically we use high bounciness for static colliders because they are unaffected by collision, and thus maximally preserve energy.
  * The effective bounciness for a collision is the product of both colliding objects. So if your bounciness setting appears to have no effect, it probably means the object it's colliding with has 0 bounciness.
    <!-- -->
    [](/img/lens-studio/physics-component_bounciness.webm)

You can also modify the world settings through scripting APIs.

```
// Change Physics Matter properties.
matter.friction = 0.75;
matter.rollingFriction = 0.2;
matter.spinningFriction = 0.3;
matter.staticBounciness = 0.75;
matter.dynamicBounciness = 0.5;
```

### Physics Filter[​**](#physics-filter "Copy to clipboard")

Settings for applying collision filtering to world settings, colliders and ray/shape-casts.

![](/assets/images/physics-component_image12-47dc9835fd19d3802c28144c8f005bbf.png)

* **Include Static:** Include and exclude Phyiscs Filter settings for static colliders.
* **Include Dynamic:** Include and exclude Phyiscs Filter settings for dynamic colliders.
* **Include Intangible:** Include and exclude Phyiscs Filter settings for intangible colliders.
* **Only Layers:** The set of layers to include (‘only’).
* **Skip Layers:** The set of layers to exclude (‘skip’).

You can also modify the physics filter via scripting APIs.

```
// Create a new filter and adjust its settings.
var filter = Physics.Filter.create();
filter.skipLayers = LayerSet.fromNumber(101);
filter.onlyColliders = [script.myCollider1, script.myCollider2];

// Assign the filter as default for the root world so it affects all colliders.
var settings = Physics.getRootWorldSettings();
settings.defaultFilter = filter;

// Perform a ray cast using the filter.
var probe = Physics.createGlobalProbe();
probe.filter = filter;
probe.rayCast(new vec3(0, 100, 0), new vec3(0, -100, 0), function (hit) {
  print(hit);
});

// Use the filter for collider overlap test.
script.myCollider3.overlapFilter = filter;
script.myCollider3.onOverlapEnter.add(function (e) {
  print('OverlapEnter(' + e.overlap.id + '): ' + e.overlap.collider);
});
```

## Physics Components[​**](#physics-components "Copy to clipboard")

In order to use physics you will also need a Physics Component attached to one of Scene Objects. There are a few of them available.

### Physics World[​**](#physics-world "Copy to clipboard")

All simulation occurs within a physics world, each with its own configurable settings (e.g. gravity). When a physics object is placed under a `World` component, it belongs to that world and will only interact with other objects in that world. By default, there exists a root-level world for the scene, but multiple worlds may be created to run independent simulations.

* **Update Order:** Update order of this world relative to other worlds (lower values are earlier). The implicit root world order is 0, so worlds with negative order will update before the root world, and worlds with non-negative order update after.
* **Settings:** Reference to `World Settings Asset`. If not set, use the default world settings for the project.

Physics supports multiple worlds in the scene. To learn more, check [Physics Template](/lens-studio/features/physics/physics-examples/physics.md) - `Multiple Worlds` Example.

```
// Create a scene object with a constraint component.
var obj = scene.createSceneObject('MyWorld');
var component = obj.createComponent('Physics.WorldComponent');

component.updateOrder = -1;
component.worldSettings.gravity = new vec3(0.0, -300.0, 0.0);
```

### Physics Collider[​**](#physics-collider "Copy to clipboard")

Colliders are primitive shapes that physics objects interact with, such as spheres, boxes, and meshes, or compound shapes formed from multiple shapes.

![](/assets/images/physics-component_physics-collider-4b3ecc7d8adb5c5808f4ddbc1ac94f3e.png)

* **Shape type:** Primitive shape used for collision.

  <!-- -->

  * ***Box:*** Defined by XYZ size.

  * ***Capsule:*** Defined by axis, length, and radius.

  * ***Cone:*** Defined by axis, length, and radius.

  * ***Cylinder:*** Defined by axis, length, and radius.

  * ***Levelset:*** Defined by imported Levelset resource. (Not supported in world physics. Levelset collider only works with Hair and Cloth Simulation)

  * ***Mesh:*** Allows meshes to be used as collision shapes.

    <!-- -->

    * ***Mesh:*** Sets geometry from a render mesh. The render mesh is automatically converted to a collision mesh.

    * ***Convex:*** Bake mesh as a convex hull. This allows the mesh to be used as a dynamic body.

    * ***Skin:*** Specifies skinning component used to animated skinned meshes. Only used for render meshes (I.e. renderMesh is specified, rather than collisionMesh).

    * Face Mesh
      <!-- -->
      [](/img/lens-studio/physics-component_image-14.webm)

    * Hand Mesh
      <!-- -->
      [](/img/lens-studio/physics-component_image-15.webm)

    * Full Body Mesh
      <!-- -->
      [](/img/lens-studio/physics-component_image-16.webm)

    * Deform Mesh
      <!-- -->
      [](/img/lens-studio/physics-component_image-17.webm)

    * World Mesh

      <!-- -->

      [](/img/lens-studio/physics-component_image-18.webm)

      Mesh-based colliders works for fixed meshes, deforming meshes such as face and body meshes or world mesh. However, they are effectively hollow. Increase the simulation rate in the World Settings to avoid tunneling issues.

  * ***Sphere:*** Defined by radius.

**Primitive Colliders**

* Can be dynamic (via Body component).
* Are faster for simple shapes.
* Are solid, so tunneling is less of an issue.

**Mesh Colliders**

* Easier to create, presuming you already have a representative render mesh.
* Faster for very complex shapes.

- **Fit Visual:** The collider shape extends to fit the Render Mesh Visual, if any. This is only applicable for Box and Sphere shapes

- **Force Compound:** When enabled, any raycasts will return the compound collider, rather than one of the sub-parts.

- **Matter:** Physics Matter.

- **Filter:** Physics Filter.

- **World Settings:** Physics World Setting.

- **Show Collider:** Displays the shape as debug lines.

- **Intangible:** With the Intangible checkbox enabled, the collider doesn't interact with the world but may still be detected with ray casts and collision events.

- **Smoothing:** Smooth transform changes, to reduce motion noise (e.g. due to tracking). This only applies internally to the simulation, and only to changes that come from outside the simulation (e.g. script or device tracking). The scene object's transform is not affected. Has no effect on dynamic bodies.

  <!-- -->

  * **Position Tension:** Smoothing spring factor, for translation. This controls the restitution strength of the spring, so low values are smoother but lag more.
  * **Rotation Tension:** Smoothing spring factor, for rotation.
    <!-- -->
    [](/img/lens-studio/physics-component_tension.webm)

The Physics Collider Component already exists for use by the Hair and Cloth simulations.

```
// Create a scene object with a collider component.
var obj = scene.createSceneObject('MyCollider');
var collider = obj.createComponent('Physics.ColliderComponent');

// Set it to intangible so nothing collides with it.
collider.intangible = true;

collider.shape = Shape.createMeshShape();
collider.shape.mesh = script.mesh;
collider.shape.convex = true;
```

### Physics Body[​**](#physics-body "Copy to clipboard")

A Body is a Collider that is moved dynamically by the physics simulation, in response to gravity, collisions, and other forces. It has all of the same properties as a Collider, plus some additional properties only relevant to simulation.

The only difference between Collider and Body is the **Dynamic** checkbox. If disabled, the body component is functionally equivalent to the collider component with the same performance.

Only one Physics Body Component (or Physics Collider Component) can be added to the scene object.

Here and elsewhere in this document, we use the following short-hand: "dynamic body" is a Body component with Dynamic enabled. A "static collider" is any Collider component, or a Body component with **Dynamic** disabled.

* **Dynamic:** With the **Dynamic** checkbox enabled, the body is dynamically simulated, such that it responds to forces and collisions. Otherwise, it acts as a static collider, functionally equivalent to a Collider. When this is enabled, additional simulation properties become available.
  <!-- -->
  [](/img/lens-studio/physics-component_dynamic.webm)

* **Set Mass From:**

  * ***Density:*** (kg/L) used to derive mass from volume. If modified, mass changes according to shape and scale.
  * ***Constant:*** (kg) If modified from this field, mass is constant irrespective of shape and scale.

* **Damping:** Damping applied to linear velocity, in the range 0.0 (no damping) to 1.0 (maximum damping). Percent of velocity decreases per frame, so 0.01 means that velocity is decreased by 1% every frame. This produces an effect similar to drag in that it causes the object to slow down over time. It is not, however, physically accurate, and it doesn't take into account surface area or mass.

* **Angular Damping:** Damping applied to angular velocity, in the range 0.0 (no damping) to 1.0 (maximum damping).

* Convex Physics Body

  <!-- -->

  [](/img/lens-studio/physics-component_image-19.webm)

  If the shape type is mesh, **Convex** field needs to be enabled to make Physics Body dynamic. This allows for irregular shapes to be used as dynamic bodies. The body mesh may be generated from a deforming render mesh, but it will not deform with it. It produces an approximation of the source mesh, reducing triangle count and eliminating concave areas.

* Convex Decomposition
  <!-- -->
  [](/img/lens-studio/physics-component_image-20.webm)

Lens Studio doesn't support automatic Convex Decomposition. Use 3D modeling tools to split the mesh and import into Studio.

```
// Create a scene object with a body component.
var obj = scene.createSceneObject('MyBody');
var component = obj.createComponent('Physics.BodyComponent');

// Set some properties on it.
component.dynamic = true;
component.useDensity = false;
component.massOrDensity = 10.0;
```

To learn more about Physics Body, check [Physics Template](/lens-studio/features/physics/physics-examples/physics.md) - Dynamic Setting, Fit Visual Setting, Mass Setting, Density Setting, Physics Body Types and Chain Damping Examples.

### Physics Constraint[​**](#physics-constraint "Copy to clipboard")

Constraints a physics body's motion in configurable ways, for simulating physical objects such as joints and hinges.

![](/assets/images/physics-component_image3-6fb87eeeaf440b9cafacaac7cc3b04e6.png)

[](/img/lens-studio/physics-component_constriant.webm)

Constraint is added by adding a child object with the `Physics Constraint` component under a physics body. You can then move the constraint object to change the pivot point of the constraint:

[](/img/lens-studio/physics-component_add-constraint.webm)

The Physics Body component provides a shortcut to create this child object via the **Add Constraint Object** button at the bottom of the component.

* **Target:** Reference to connected target collider. If its value is None, the constraint target is attached to a fixed world transform.

* **Type:**

  * ***Fixed:*** Constraints colliders to fixed rotation and position.
  * ***Point:*** Constraints colliders to rotate around a point.
    <br />
    ![](/assets/images/physics-component_image5-c485dc3f32756067ad5a34c1e013189f.png)
  * ***Hinge:*** Constraints colliders to rotate around a single axis.
    <br />
    ![](/assets/images/physics-component_image1-01cc2e11b1ba31c2566808b4b88fb818.png)

* **Show Constraint:** With the `Show Constraint` checkbox enabled, you will see debug draw for Collider.

Constraints cannot be moved after creation; any transform changes are ignored. Instead, move the target collider that the constraint is attached to.

```
// Create a scene object with a constraint component.
var obj = scene.createSceneObject('MyBody');
var component = obj.createComponent('Physics.ConstraintComponent');

// Set some properties on it.
component.debugDrawEnabled = true;

component.constraint = Physics.Constraint.create(Physics.ConstraintType.Hinge);
component.target = targetColliderComponent;
component.reanchorTarget();
```

To learn more about Physics Constraint, check [Physics Template](/lens-studio/features/physics/physics-examples/physics.md) - Constraint Types Example.
