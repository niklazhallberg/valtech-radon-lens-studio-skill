# Raycast

In some cases, you may want the Lens user, or objects, to interact based on line of sight (i.e. a ray). You can do this by using the physics system's raycast function. By defining a ray from some start point, to an end point, the Physics system can calculate which collider that ray intersects with, and provide information back. Alternatively, a primitive shape (such as a sphere) may be swept along a transform path to expand the search area.

[](/img/lens-studio/raycast_raycastexample.webm)

## Probe[​**](#probe "Copy to clipboard")

Raycast is exposed to scripts through the `Physics.Probe`, which operates on a specific [world](/lens-studio/features/physics/physics-component.md) (i.e. the root or a component). A Probe is created from one of the create probe functions (`createProbe` or `createGlobalProbe`). The probe then allows you to perform the intersection (raycast) tests.

### RayCast[​**](#raycast-1 "Copy to clipboard")

[](/img/lens-studio/physics-component_image-21.webm)

```
var rayStart = new vec3(0.0, 100.0, 0.0);
var rayEnd = new vec3(0.0, -100.0, 0.0);
```

```
// Create a probe to raycast through only the implicit root world.
var rootProbe = Physics.createRootProbe();
rootProbe.rayCast(rayStart, rayEnd, function (hit) {
  print(hit);
});
```

```
// Create a probe to raycast through all worlds.
var globalProbe = Physics.createGlobalProbe();
globalProbe.rayCast(rayStart, rayEnd, function (hit) {
  print(hit);
});
```

```
// Create a scene object with a world component.
var obj = scene.createSceneObject('MyWorld');
var component = obj.createComponent('Physics.WorldComponent');

// Create a probe to raycast through this world.
var worldProbe = component.createProbe();
worldProbe.rayCast(rayStart, rayEnd, function (hit) {
  print(hit);
});
```

### Swept-Shape Cast[​**](#swept-shape-cast "Copy to clipboard")

Swept-shape casts. This is an extension of the raycast API that allows a primitive shape to be swept along a transform path.

* This supports all of the existing Shape types, with the exception MeshShape.
* The Physics.Probe script class has additional functions to sweep a sphere or other primitive shape along a transform path (expressed as position and rotation). These are called `sphereCast[All]()` and `shapeCast[All]()`.
* The `sphereCast()` functions are provided as a convenience, and are equivalent to calling `shapeCast()` with a SphereShape.
* Swept rotations are limited to 180°, and take the shortest rotational arc.

[](/img/lens-studio/physics-component_image-21.webm)

```
var radius = 10.0;
var rayStart = new vec3(0.0, 100.0, 0.0);
var rayEnd = new vec3(0.0, -100.0, 0.0);
```

```
// For the shape-cast, also provide start and end rotation.
var rotStart = quat.angleAxis(
  30.0 * MathUtils.DegToRad,
  new vec3(0.0, 1.0, 0.0)
);
var rotEnd = quat.angleAxis(
  150.0 * MathUtils.DegToRad,
  new vec3(0.0, 1.0, 0.0)
);
```

```
// Create a box shape for the shape-cast.
var boxShape = Shape.createBoxShape();
boxShape.size = new vec3(1.0, 10.0, 4.0);
```

```
// Create a probe to raycast through all worlds.
var probe = Physics.createGlobalProbe();
```

```
// Perform swept-sphere cast to get nearest hit.
probe.sphereCast(radius, rayStart, rayEnd, function (hit) {
  print(hit);
});

// Perform swept-sphere cast to get all hits.
probe.sphereCastAll(radius, rayStart, rayEnd, function (hits) {
  var hitCount = hits.length;
  for (var i = 0; i < hitCount; ++i) {
    var hit = hits[i];
    print(hit);
  }
});

// Perform swept-box cast to get nearest hit.
probe.shapeCast(boxShape, rayStart, rotStart, rayEnd, rotEnd, function (hit) {
  print(hit);
});

// Perform swept-sphere cast to get all hits.
probe.shapeCastAll(
  boxShape,
  rayStart,
  rotStart,
  rayEnd,
  rotEnd,
  function (hits) {
    var hitCount = hits.length;
    for (var i = 0; i < hitCount; ++i) {
      var hit = hits[i];
      print(hit);
    }
  }
);
```

Show more▼

### Probe Filter[​**](#probe-filter "Copy to clipboard")

You can filter the results of your raycast using the filter option of a probe.

* `includeStatic:` set true to include static objects in intersection tests.
* `includeDynamic:` set true to include dynamic objects in intersection tests.
* `includeIntangible:` set true to include intangible objects in intersection tests.

```
// Create a probe to raycast through all worlds.
var probe = Physics.createGlobalProbe();

// Set filter settings on it.
probe.filter.includeStatic = false;
probe.filter.includeDynamic = true;
probe.filter.includeIntangible = false;
```

You can also use Physics.Filter as the Probe Filter

```
// Get object layer
var objectLayer = script.getSceneObject().layer;

// Create a new filter and adjust its settings.
var filter = Physics.Filter.create();
filter.skipLayers = objectLayer;
filter.onlyColliders = [script.myCollider1, script.myCollider2];

// Perform a ray cast using the filter.
var probe = Physics.createGlobalProbe();
probe.filter = filter;
probe.rayCast(new vec3(0, 100, 0), new vec3(0, -100, 0), function (hit) {
  print(hit);
});
```

### RayCast & RayCastAll[​**](#raycast--raycastall "Copy to clipboard")

With your proble created, you can ask it to do a raycast.

* `rayCast(vec3 start, vec3 end, HitCallback hitCB)`: casts a ray into the world and returns the nearest hit surface.

[](/img/lens-studio/raycast_Raycast.webm)

* `rayCastAll(vec3 start, vec3 end, HitCallback hitCB)`: casts a ray into the world and returns the all hit surfaces, in order from nearest to farthest.

[](/img/lens-studio/raycast_raycastall.webm)

### RayCastHit[​**](#raycasthit "Copy to clipboard")

The raycast provide some information about the objects that the ray intersected via its callback function:

* `skipRemaining`: Skip remaining hits past a certain distance.

* `distance`: Distance to the point of intersection.

* `t`: Ray interpolant at the point of intersection, in the range \[0, 1].

* `position`: Position at the point of intersection.

* `normal`: Surface normal on the collider at the point of intersection.

* `collider`: The collider that was hit.

* `triangle`: Triangle hit information, available when a ray cast intersects a collision mesh.

  <!-- -->

  * `_mesh_`: Collision mesh containing the triangle.
  * `_index_`: Index of the triangle in the mesh.
  * `_vertexIndices_`: Vertex indices in the mesh.
  * `_vertexPositions_`: World-space vertex positions.
  * `_barycentricCoordinate_`: Barycentric coordinate of the hit on the triangle. This is used to interpolate values over the triangle surface. Essentially, these are weights for each of the 3 triangle vertices.

To learn more about Raycast APIs, check [Physics Template](/lens-studio/features/physics/physics-examples/physics.md) - Raycast Example.

```
var rayStart = new vec3(0.0, 100.0, 0.0);
var rayEnd = new vec3(0.0, -100.0, 0.0);

// Create a probe to raycast through all worlds.
var probe = Physics.createGlobalProbe();

// Set some properties on it.
probe.debugDrawEnabled = true;
probe.filter.includeStatic = true;
probe.filter.includeDynamic = false;
probe.filter.includeIntangible = true;

// Find the first hit.
probe.rayCast(rayStart, rayEnd, function (hit) {
  if (hit === null) {
    return;
  }
  print('hit: ' + hit);

  print('skip remaining: ' + hit.skipRemaining);
  print('collider: ' + hit.collider);
  print('position: ' + hit.position);
  print('nortmal: ' + hit.normal);
  print('distance: ' + hit.distance);
  print('ray interpolant: ' + hit.t);

  // Triangle hit information, available when a ray cast intersects a collision mesh.
  var tri = hit.triangle;
  if (tri) {
    print('triangle: ' + tri);
    print('mesh: ' + tri.mesh);
    print('index: ' + tri.index);
    print('vertexIndices: ' + tri.vertexIndices);
    print('vertexPositions: ' + tri.vertexPositions);
    print('barycentricCoordinate: ' + tri.barycentricCoordinate);
  }

  // Skip remaining hits past a certain distance.
  if (hit.distance > 150.0) {
    hit.skipRemaining = true;
  }
});

// Find all hits.
probe.rayCastAll(rayStart, rayEnd, function (hits) {
  var hitCount = hits.length;
  for (var i = 0; i < hitCount; ++i) {
    var hit = hits[i];
    print(hit);
  }
});
```

Show more▼
