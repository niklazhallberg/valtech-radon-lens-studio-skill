# Collision and Overlap

The physics system allows you to respond to collisions and overlap through events on the Collider or Body component.

Collision events occur whenever a dynamic body hits some other collider during simulation. Overlap events occur while any colliders overlap.

Add responses to collision and overlaps without scripting through [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md).

## OnCollisionEnter/Stay/Exit Events[​**](#oncollisionenterstayexit-events "Copy to clipboard")

These events are triggered whenever dynamic bodies hit another collider, such as when a box falls and hits the ground. They happen all the time whether or not you listen for them with `onCollision` events. The typical use-case for these is to perform some handling that occurs on collision, such as playing a sound or emitting visual effects.

Only dynamic [physics bodies](/lens-studio/features/physics/physics-component.md#physics-body) are simulated so they are the only things generating collision events. So you will never see collision events between two static [colliders](/lens-studio/features/physics/physics-component.md#physics-collider) - only between a dynamic body and another body/collider.

When a collision occurs between two objects, both objects receive collision events.

[](/img/lens-studio/collision-and-overlap_collision.webm)

```
// Create a scene object with a collider component.
var obj = scene.createSceneObject('MyBox');
var body = obj.createComponent('Physics.BodyComponent');

// The default shape for a collider/body is a sphere. Change it to a box (using the default size).
body.shape = Shape.createBoxShape();

// Print collision events.
// The event 'collider' is some other body/collider component that hit this one.
body.onCollisionEnter.add(function (e) {
  var collision = e.collision;
  print('CollisionEnter(' + collision.id + '): ---> ' + collision.collider);
});
body.onCollisionStay.add(function (e) {
  var collision = e.collision;
  print('CollisionStay(' + collision.id + '): ---> ' + collision.collider);
});
body.onCollisionExit.add(function (e) {
  var collision = e.collision;
  print('CollisionExit(' + collision.id + '): ---> ' + collision.collider);
});
```

### Contact Information[​**](#contact-information "Copy to clipboard")

When these collision event occurs, you are provided contact points with surface and response information (e.g. position, normal, and impulse etc.).

```
collider.onCollisionStay.add(function (e) {
  var contacts = e.collision.contacts;
  var contactCount = e.collision.contactCount;
  var points = [];
  for (var i = 0; i < contactCount; ++i) {
    var contact = contacts[i];
    var distance = contact.distance;
    var impulse = contact.impulse;
    var n = contact.normal;
    var p0 = contact.position;
    var p1 = p0.add(n.uniformScale(10.0));
    points[2 * i + 0] = p0;
    points[2 * i + 1] = p1;
  }
});
```

## OnOverlapEnter/Stay/Exit Events[​**](#onoverlapenterstayexit-events "Copy to clipboard")

These events are triggered whenever a collider overlaps another, typically used for volume triggers. For example, they could be used to detect when a player enters a room, using an intangible box collider to encompass the region.

They are similar to onCollision events but with some important differences:

* They act as explicit requests for the overlap of two colliders, and are only detected when you listen for onOverlap.
* They can detect arbitrary overlap between any two colliders, even non-simulated (static) or intangible ones.
* They don't generate contact information. It simply tells you when colliders overlap, not where.
* You can filter them to specific collider types, such 'intangible' or 'dynamic'.

[](/img/lens-studio/collision-and-overlap_overlap.webm)

### OverlapFilter[​**](#overlapfilter "Copy to clipboard")

The onOverlap events have additional settings that allow you to filter which objects you want to listen to.

* `includeStatic`: *(default: true)* set true to include [static colliders](/lens-studio/features/physics/physics-component.md#physics-collider) in intersection tests.
* `includeDynamic`: *(default: true)* set true to include [dynamic bodies](/lens-studio/features/physics/physics-component.md#physics-body) in intersection tests.
* `includeIntangible`: *(default: false)* set true to include intangible colliders in intersection tests.

For the typical volume trigger use-case, the collider representing the trigger should be set to intangible, so normal [dynamic bodies](/lens-studio/features/physics/physics-component.md#physics-body) can pass through it unaffected. `includeIntangible` is set to `false` by default, because you usually do not need to detect overlap between multiple triggers. If you do need to detect overlap between intangible colliders, make sure to set `includeIntangible` to `true`.

```
// Create a scene object with a collider component.
var obj = scene.createSceneObject('MyCollider');
var collider = obj.createComponent('Physics.ColliderComponent');

// Set it to intangible so nothing collides with it.
collider.intangible = true;

// Adjust the overlap filter. For this example, we want to detect all non-intangible colliders and bodies.
// Note, these match the defaults, but are included for demonstration.
collider.overlapFilter.includeIntangible = false;
collider.overlapFilter.includeDynamic = true;
collider.overlapFilter.includeStatic = true;

// Print overlap events.
collider.onOverlapEnter.add(function (e) {
  print('OverlapEnter(' + e.overlap.id + '): ' + e.overlap.collider);
});
collider.onOverlapStay.add(function (e) {
  var overlapCount = e.currentOverlapCount;
  if (overlapCount == 0) {
    return;
  }
  var overlaps = e.currentOverlaps;
  for (var i = 0; i < overlaps.length; ++i) {
    var overlap = overlaps[i];
    print(
      'Overlap[' + i + ']: id=' + overlap.id + ', collider=' + overlap.collider
    );
  }
});
collider.onOverlapExit.add(function (e) {
  print('OverlapExit(' + e.overlap.id + ')');
});
```

Show more▼

To learn more about Behavior Script and APIs for Collision Events, check the [Physics Template](/lens-studio/features/physics/physics-examples/physics.md) - Collision Event and Overlap Event Examples.

## Collision Filter[​**](#collision-filter "Copy to clipboard")

### Physics Filter[​**](#physics-filter "Copy to clipboard")

Physics Filter allows filtering by [layer](/lens-studio/lens-studio-workflow/scene-set-up/camera.md#assigninglayers) and to specific colliders. For detailed information about this component, check out the [Physics Component guide section on Physics Filter](/lens-studio/features/physics/physics-component.md#physics-filter).

![](/assets/images/physics-component_image12-47dc9835fd19d3802c28144c8f005bbf.png)

```
// Get object layer
var objectLayer = script.getSceneObject().layer;

// Create a new filter and adjust its settings.
var filter = Physics.Filter.create();
filter.skipLayers = objectLayer;
filter.onlyColliders = [script.myCollider1, script.myCollider2];

// Use the filter for collider overlap test.
script.myCollider3.overlapFilter = filter;
script.myCollider3.onOverlapEnter.add(function (e) {
  print('OverlapEnter(' + e.overlap.id + '): ' + e.overlap.collider);
});
```

There are two ways to assign Physics Filter. Add Physics Filter to Physics World Settings or to specific Physics Collider or Physics Body.

### Layer Collision Matrix[​**](#layer-collision-matrix "Copy to clipboard")

Layer Collision Matrix is one of the settings in the Physics World Settings. For each pair of layers, it indicates if colliders in one layer collide with colliders in the other. For detailed information about this component, check out the [Physics Component guide section on World Settings](/lens-studio/features/physics/physics-component.md#worldsettings).

[](/img/lens-studio/physics-component_image-23.webm)

Layer Collision Matrix Setting<br />![](/assets/images/physics-component_image13-d1610a6ee402573cf837990e6b21d56a.png)

Click [here](/lens-studio/lens-studio-workflow/scene-set-up/camera.md#assigninglayers) to learn more about create new layer.

```
// Create world settings.
var settings = Physics.WorldSettingsAsset.create();
print(settings);

// Modify layer collision matrix.
settings.setLayersCollidable(0, 3, false);

// Assign world settings to a collider.
script.myCollider.worldSettings = settings;
```
