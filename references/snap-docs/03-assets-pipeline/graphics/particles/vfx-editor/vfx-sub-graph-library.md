# VFX Sub-Graph Library

This page lists VFX Sub-Graph Library presets in alphabetical order, grouped by `Particle Behavior`.

In VFX Editor, you can create regular Sub-Graphs as seen in Material Editor, but you can also create Container Sub-Graphs to modify particle attributes. Container Sub-Graphs are functionally similar to regular Sub-Graphs, but they do not let you create Export nodes. Instead, Modify Attribute nodes can be connected vertically to manipulate particle data.

To learn more about Sub-Graphs in general, check out the [Sub-Graph Overview](/lens-studio/features/graphics/materials/material-editor/sub-graph-library.md) page.

## Getting Started[​**](#getting-started "Copy to clipboard")

To create a Container Sub-Graph in a **VFX Editor** container, you can either click on the `Add` button or hit `tab` on your keyboard while pointing your cursor at a desired container. A sub-graph will only show up within its corresponding container (Spawn, Update or Output Quad). After the list appears, you can begin typing to filter subgraphs by name.

To create a Regular Sub-Graph outside of **VFX Editor** containers, hit `tab` on your keyboard while pointing your cursor anywhere outside of a VFX container.

Remember, you are not limited by all these presets below: an empty sub-graph is at the bottom of the sub-graph list (or by typing “Sub-Graph” in the search menu) for you to create your own.

![](/assets/images/vfx-sub-graph-library_vfxsgg49-7c1107729ddfbdb8bc4dfa118c20b8fa.png)

Container Sub-Graphs can be imported and exported to files on your hard drive like regular sub-graphs. Depending on which container you exported the sub-graph from, it will come with one of three new extensions:

* subgraph\_vfx\_spawn
* subgraph\_vfx\_update
* subgraph\_vfx\_output

Container Sub-Graphs can only be imported onto the same container type from which they were exported.

## Container Sub-Graphs[​**](#container-sub-graphs "Copy to clipboard")

## Color[​**](#color "Copy to clipboard")

### Set Alpha ( by Age ) Update[​**](#set-alpha--by-age--update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg27_01.png)

Alpha animates from the `Start Alpha` value to the `End Alpha` value based on normalized particle age ratio (0-1).

### Set Alpha ( Fade In/Out ) Update[​**](#set-alpha--fade-inoutupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg26_01.png)

Alpha animates from `Alpha Min` to `Alpha Max` in the amount of time (seconds) set on `Fade In Time`, relative to the moment the particle spawns. Alpha then animates back to `Alpha Min` in the amount of time (seconds) set on `Fade Out Time`, relative to the lifespan of the particle.

### Set Color ( 3D Texture ) Spawn Update[​**](#set-color-3d-texture--spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg09_01.png)

Set particle color by sampling a `3D texture`, using `Particle Position` as the sample coordinate. `Scale` is the size of the `3D Texture` in particle space and `Offset` adds an offset to the particle position. More 3D textures can be found in the **Asset Library**.

### Set Color ( by Age ) Update[​**](#set-color--by-ageupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg30_01.png)

Particle Color animates from the `Start Color` RGB value to the `End Color` RGB value based on normalized particle age ratio (0-1). Note that this only sets RGB Color, to control alpha use `Set Alpha ( by Age )`sub-graph.

### Set Color ( Fade In/Out ) Update[​**](#set-color--fade-inoutupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg28_01.png)

Color animates from `Color Min` to `Color Max` in the amount of time (seconds) set on `Fade In Time`, relative to the moment the particle spawns. Color then animates back to Alpha Min in the amount of time (seconds) set on `Fade Out Time`, relative to the lifespan of the particle. Note that this only sets RGB Color, to control alpha use `Set Alpha ( Fade In/Out )`sub-graph.

### Set Color ( Hue over Time ) Spawn[​**](#set-color-hue-over-time-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg10_01.png)

Spawn with varying colors over time. `Hue Transition Time` controls how long it takes to rotate the hue 360 degrees (to go from red through the color spectrum and back to red again). `Saturation` and `Value` range from 0 to 1.

### Set Color ( Random Range ) Spawn[​**](#set-color--random-rangespawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg11_01.png)

Sets particle color to be a mix between two colors, with random weight to either `Color A` or `Color B`.

### Set Color ( Ramp Texture by Age ) Update[​**](#set-color--ramp-texture-by-age-update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg29_01.png)

Sample a 1D ramp texture and set the color by normalized particle age ratio (0-1).

Note that the Y coordinate for this texture sample is set to 0.5.

## Force[​**](#force "Copy to clipboard")

###

### Add Force ( 3D Texture ) Spawn Update[​**](#add-force-3d-texture-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg01_01.png)

Add force by sampling a `3D Texture` using `Particle Position` as the sample coordinate. `Scale` is the size of the 3d texture in particle space, `Strength` is a multiplier on the force, Offset adds an offset to the particle position, and `Animate` will offset the coordinates over time with this value controlling the speed. More 3D textures can be found in the **Asset Library**.

### Add Force ( Attract / Repel ) Spawn Update[​**](#add-force--attract--repel-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg02_01.png)

An attractive or repulsive force depending if the `Strength` is positive or negative. Attractive forces have positive `Strength` values and repulsive forces have negative `Strength` values. `Target Position` is the position where the force is attracted to or repelled from.

### Add Force ( Directional ) Spawn Update[​**](#add-force--directional-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg03_01.png)

Force along a given XYZ `Direction` with a `Strength` control.

### Add Force ( Drag ) Update[​**](#add-force-drag-update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg24_01.png)

Resisting force of particle motion by slowing it down over time. The value of this force depends on `Density` (of the medium in which the particle exists), relative velocity, and the `Area` the cross section of the object facing in the direction of velocity (which currently is user-definable). The `Drag Coefficient` value is very sensitive, a smaller `Drag Coefficient` means less drag on particles.

Note the default `Density` value is 1.2 selected to represent air, 1.21 kg/m^3.

### Set Force ( Gravity ) Spawn Update[​**](#set-force-gravity-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg04_01.png)

Adds a gravitational force. `Gravity` Scale scales the gravitational constant.

### Add Force ( Simplex Noise ) Spawn Update[​**](#add-force-simplex-noise-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg05_01.png)

A procedural simplex noise force using `Particle Position` for the noise coordinate. `Scale` is the size of the noise in particle space, `Strength` is a multiplier on the force, `Offset` adds an offset to the particle position, and `Animate` will offset the coordinates over time with this value controlling the speed.

### Add Force ( Triplanar Texture ) Spawn Update[​**](#add-force-triplanar-texture-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg06_01_210511_235303.png)

A 3D noise force derived from a 2d texture by sampling in three axes using `Particle Position` as the sample coordinate. `Scale` is the size of the noise in particle space, `Offset` adds an offset to the particle position, `Strength` is a multiplier on the force, and `Animate` will offset the coordinates over time with this value controlling the speed.

### Add Force ( Vortex ) Spawn Update[​**](#add-force--vortex--spawn-update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_add_force_vortex_5-0.png)

Inject a velocity along a vortex axis, with an optional additional pull towards the vortex origin.

## Life[​**](#life "Copy to clipboard")

### Set Life ( Random Range ) Spawn[​**](#set-life--random-rangespawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg12_02.png)

Set life to be a random value between `Life Min` and `Life Max`.

## Mass[​**](#mass "Copy to clipboard")

### Set Mass ( Random Range ) Spawn[​**](#set-mass--random-range-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg13_01.png)

Set mass to be a random value between `Mass Min` and `Mass Max`.

## Matrix[​**](#matrix "Copy to clipboard")

### Set Matrix ( Random Rotation ) Spawn[​**](#set-matrix--random-rotation-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg14_02.png)

Set the particle matrix to be a random rotation matrix between `Angle Min (Degrees)` and `Angle Max (Degrees)`.

### Set Matrix ( Rotate on Axis ) Spawn Update[​**](#set-matrix--rotate-on-axis-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg15_01.png)

Transforms the particle matrix to rotate about a `Rotation Axis` and `Angle (Degrees)`.

### Set Matrix ( Rotation Angle ) Spawn Update[​**](#set-matrix--rotation-angle-spawnupdate "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg16_01.png)

Set the particle matrix to be a rotation matrix with XYZ angles by `Angle (Degrees)`.

### Set Matrix ( Rotate by Velocity ) Update[​**](#set-matrix--rotate-by-velocity-update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg31_01.png)

Transforms the particle matrix to rotate along an axis relative to its velocity. `Rotation Amount` controls how much rotation is applied on each frame.

## Position[​**](#position "Copy to clipboard")

### Add Position ( Random ) Spawn[​**](#add-position-random-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg07_01.png)

Adds random offset `Amount` to the position.

### Set Position (Depth) Spawn[​**](#set-position-depth-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_depth_5-0.png)

Calculates position from depth. This sub-graph uses UV coords (usually screen UV) and depth input to generate camera space coordinates, which are then transformed into a world space position where particles will spawn. Particles will be discarded around the area that doesn't have depth information.

### Set Position Plane ( Disc ) Spawn[​**](#set-position-plane--disc-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_plane_disc_5-0.png)

Spawn particles within a 2d disc with `Radius`, `Center`, `Edge Fill`, `Scale`, and `Axis` (dropdown menu) controls.

### Set Position Plane ( Square ) Spawn[​**](#set-position-plane--square-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg18_01.png)

Spawn particles within a 2d rectangle with `Size`, `Center` and `Axis` controls. Axis 0 = XY, Axis 1 = XZ, Axis 2 = YZ.

### Set Position Volume ( Cone ) Spawn[​**](#set-position-volume--cone--spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_volume_cone_5-0.png)

Spawn particles in a cone shape with `Length`, `Cone Angle`, `Orientation Axis` (dropdown menu), and `Volume Fill` controls.

### Set Position Volume ( Cube ) Spawn[​**](#set-position-volume--cube-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg19_01.png)

Spawn particles within a 3d cube with `Size` and `Center` controls.

### Set Position Volume ( Cylinder ) Spawn[​**](#set-position-volume--cylinder--spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_volume_cylinder_5-0.png)

Spawn particles in a cylinder shape with `Height`, `Radius`, `Arc Angle` and `Volume Fill` controls.

### Set Position Volume ( Sphere ) Spawn[​**](#set-position-volume--sphere-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_volume_sphere_5-0.png)

Spawn particles in a sphere or hemisphere shape, with `Radius`, `Scale`, `Center`, `Volume Fill`, and `Sphere Type` (dropdown menu) controls.

### Set Position Volume ( Torus ) Spawn[​**](#set-position-volume--torus-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_volume_torus_5-0.png)

Spawn particles in a 3D torus shape with `Inner Radius1`, `Outer Radius`, `Arc Angles`, `Scale`, `Center`, `Volume Fill`, and `Axis` (dropdown menu) controls.

## Size[​**](#size "Copy to clipboard")

Size sub-graphs typically have two size modes: `Explicit` and `Normalize to AABB`. `Explicit` sets particle size directly and is good default for quad particles. `Normalize to AABB` will scale particles based on their render mesh's AABB and is useful when working with Custom Meshes.

### Multiply Size ( Normalize to AABB ) Spawn[​**](#multiply-size--normalize-to-aabb--spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_multiply_size_normalize_to_aabb_5-0.png)

Scales the particle size attribute to the render mesh's AABB. This is especially useful when working with custom meshes.

### Set Size ( Compute from Mass ) Spawn[​**](#set-size--compute-from-mass-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg22_01.png)

Set particle size based on the mass value.

This sub-graph should be used after modifying particles mass (eg. with a `Set Mass ( Random Range )` sub-graph before this one).

### Set Size ( Random Range ) Spawn[​**](#set-size--random-range-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg23_01.png)

Set life to be a random value between `Size Min` and `Size Max`.

### Set Size ( by Age ) Update[​**](#set-size--by-age-update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg33_01.png)

Particle size animates from the `Start Size` value to the `End Size` value based on normalized particle age ratio (0-1).

### Set Size ( Fade In/Out ) Update[​**](#set-size--fade-inout-update "Copy to clipboard")

Particle size animates from `Size Min` to `Size Max` in the amount of time (seconds) set on `Fade In Time`, relative to the moment the particle spawns. Size then animates back to Size Min in the amount of time (seconds) set on `Fade Out Time`, relative to the lifespan of the particle.

## Velocity[​**](#velocity "Copy to clipboard")

### Add Velocity ( Random ) Spawn[​**](#add-velocity--random-spawn "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg08_01_210511_235304.png)

Add a random velocity value between `Min Velocity` and `Max Velocity`.

## Multiple[​**](#multiple "Copy to clipboard")

### Set Position and Color (2D Texture) Spawn Update[​**](#set-position-and-color-2d-texture-spawn-update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_set_position_and_color_2d_texture_5-0.png)

Spawns particles from a 2D texture. An example of this can be found in the [VFX template](/lens-studio/features/graphics/particles/vfx-editor/vfx-templates/vfx.md#image-spawn-example).

## Collision[​**](#collision "Copy to clipboard")

Check out the [VFX Collision](/lens-studio/features/graphics/particles/vfx-editor/vfx-collisions.md) page for examples on how to use the VFX Collision subgraphs.

### Collision ( Depth Buffer ) Update[​**](#collision--depth-buffer--update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_collision_depth_buffer_5-0.png)

Enables VFX collision using the depth buffer and a screen space normals texture. For more information, check out the documentation for [Screen Space Normals Generation](/lens-studio/features/graphics/advanced/screen-space-normals-generation.md).

### Collision ( Plane ) Update[​**](#collision--plane--update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_collision_plane_5-0.png)

Enables VFX collision with a plane defined by a position and normal.

### Collision ( Plane Array ) Update[​**](#collision--plane-array--update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_collision_depth_buffer_5-0.png)

Enables VFX collision with an array of planes, defined by an array of positions and normals.

### Collision ( SDF ) Update[​**](#collision--sdf--update "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_collision_sdf_5-0.png)

Enables VFX collision with a Signed Distance Field Texture that corresponds with a mesh and a Scene Object transform. A helper script should be used to send the transform matrix and mesh bounding box information.

## Pixel Color[​**](#pixel-color "Copy to clipboard")

### Align to Camera Output Quad[​**](#align-to-cameraoutput-quad "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_align_to_camera_5-0.png)

Aligns particle quads to face their render camera, and optionally orient and stretch along the particle's velocity vector.

`Facing Mode` and `Alignment` dropdown menus determine how the particle quad orients itself relative to the camera. `Velocity Stretch Amount` controls how much the particle is scaled along the velocity vector. When `Velocity Stretch Amount` is 0, particles only face the camera and are oriented relative to their `Alignment` setting.

### Align to Velocity Output Quad[​**](#align-to-velocityoutput-quad "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg34_01.png)

Aligns particle quads to their velocity vector. `Stretch Amount` controls how much the particle is scaled along the velocity vector. `Alignment` setting (dropdown menu) determines how the particle quad orients itself relative to its velocity.

### Depth Distance Fade Output Quad[​**](#depth-distance-fade-output-quad "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_depth_distance_fade_output_5-0.png)

Fades pixels as they get close to other objects in the scene. This sub-graph is useful for softly fading particle effects such as smoke and fire.

### Particle Lighting ( Phong ) Output Quad[​**](#particle-lighting--phong-output-quad "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg_particle_lighting_phong_5-0.png)

Apply basic Phong shading on particles using `Directional` and `Point Lights`. Lights can be added and manipulated under Objects > Light > Light Source.

To enable shadows, click on the Output Quad container, go to Graph Properties on the right-hand side and change Shadow Mode to Caster at the end of the list. Click on the directional light you wish to create the shadow from in the `Scene Hierarchy` panel and enable the Shadow check box under the Inspector. Finally, add a Shadow Plane using Object > Shadow Plane.

If you don’t see shadows, try to move your Shadow Plane down in case your particles are below the shadow receiver. Make sure the shadow plane is visible by the camera, and the light direction is casting towards the shadow plane.

For more information about lighting, check out the [Lighting and Shadow Page](/lens-studio/features/graphics/light-and-shadow.md).

## General Sub-Graphs[​**](#general-sub-graphs "Copy to clipboard")

Most general sub-graphs are shared between the Material and VFX Editors. For documentation on sub-graphs in both the Material and VFX Editors, visit the [Sub-Graph Library Page](/lens-studio/features/graphics/materials/material-editor/sub-graph-library.md).

### Particle Screen UV[​**](#particle-screen-uv "Copy to clipboard")

![](/img/lens-studio/vfx-sub-graph-library_vfxsgg43.png)

Computes the screen UV coordinate of the particle from its position, useful in the Spawn/Update stages of **VFX Editor**.
