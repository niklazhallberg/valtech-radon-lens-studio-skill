# VFX Collision

To make it easier for you to mix-and-match our different examples, this template has been converted to an importable asset in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) with the name `Advanced Plane Collision VFX`, `Simple Plane Collision VFX` and `Depth Collision VFX`.

The VFX Template showcases different ways to use [VFX Graph](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md) to implement particle collision in VFX Editor. Collision is implemented by introducing new collision subgraphs in VFX editor. You can find their description in [VFX Collision Subgraphs](/lens-studio/features/graphics/particles/vfx-editor/vfx-collisions.md) guide.

 If it’s the first time that you are using a VFX graph or node based particle system, we recommend first to look at the [VFX Editor Overview](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md) and a [VFX Template](/lens-studio/features/graphics/particles/vfx-editor/vfx-templates/vfx.md) first.

## Guide[​**](#guide "Copy to clipboard")

The Template comes with 4 examples of Collision. These examples can be found in the `Scene Hierarchy` panel under their names. Feel free to try them out by enabling the example scene object. All examples are featuring the world objects and are intended to be used with Back Camera.

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.08.41-AM-d1f5f092c1095342bd005d464c57a579.png)

### Simple Plane Collision Example[​**](#simple-plane-collision-example "Copy to clipboard")

[](/img/lens-studio/vfx-collision_sdfg_01.webm)

This example uses `Plane Collision` subgraph to detect when particles collide with the plane and change their color on the third collision.

Expand the hierarchy of the first example, select the `Disc [MOVE ME]` scene object, try to move and rotate it in the `Scene` panel and see how particles behave.

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.16.40-AM-d276bebab326bf4e79801af1dafd7a34.png)

To dive deeper into the implementation select the `simple_plane_collision [EDIT_ME]` asset in the `Asset Browser` panel and double click on it to open VFX Editor.

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.15.51-AM-092a19fa677929001e8ebb2c6eb77072.png)

This graph provides an example of how to use `Plane Collision` subgraph and how the particle color logic is implemented. Position and Direction of the plane are used by this subgraph and are sent to the VFX editor using `SendDataToVFX` script, first introduced in the [VFX Template](/lens-studio/features/graphics/particles/vfx-editor/vfx-templates/vfx.md). To  replace a plane scene object, change the `Target` input of the `SendDataToVFX` scripts.

### Advanced Plane Collision Example[​**](#advanced-plane-collision-example "Copy to clipboard")

[](/img/lens-studio/vfx-collision_sdfg_02_211019_204521.webm)

This example is using `Plane Array Collision` subgraph that takes positions and normals of an Array of 5 planes. Positions and directions of planes are sent to the VFX graph asset using `ArrayTransformToScript` helper script.

You can add or remove planes by selecting `Array Transform to VFX` SceneObject in the `Scene Hierarchy` panel and editing values of the `Planes` array input of the `ArrayTransformToScript` in the Inspector panel.

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.29.08-AM-fb7142a5befb6e9fd3b6773f2e823bc5.png)

Also select `Planes` scene object and edit `Tween Transform` script settings to change planes movement.

Double click on `advanced_plane_collision [EDIT_ME]` asset in the `Asset Browser` panel to open VFX Editor and see details of implementation.

### Depth Collision Example[​**](#depth-collision-example "Copy to clipboard")

[](/img/lens-studio/vfx-collision_sdfg_03_211019_204523.webm)

Provides more sophisticated example of collision using Depth Buffer Collision subgraph. Double click on `depth_collision [EDIT_ME]` asset in the `Asset Browser` panel to open `VFX Editor` and see details of implementation.

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.42.43-AM-52f046940d690401241ece19beb780d4.png)

You can learn more about  how to generate Screen Space Normals and Depth textures in the [Screen Space Normals Guide](/lens-studio/features/graphics/advanced/screen-space-normals-generation.md).

And also enable `Debug Camera [ENABLE_ME]` scene object to peek into mentioned textures.

To change the scene objects to collide with select `Screen Space Normals` scene object and add or remove elements in the `Objects For Normal Gen` array input of the `Screen Space Normals` script.

### SDF Collision Example[​**](#sdf-collision-example "Copy to clipboard")

[](/img/lens-studio/vfx-collision_sdfg_04.webm)

Provides an example of how to implement collision based on the Signed Distance Fields texture.

We have SDF texture prepared for the Trophy 3D model (`trophy_sdf`). To replace 3D model - first import it to the Lens Studio and follow the [this guide](/lens-studio/features/graphics/advanced/sdf-generator.md) to generate such texture.

Double click on `sdf_collision [EDIT_ME]` asset in the `Asset Browser` panel to open `VFX Editor` and see details of implementation.

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.54.16-AM-c936452f4d3e92d4d44d3e1e2b206554.png)

To modify the collision, first we need to set our generated texture to the `SDF Texture` input of this asset:

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-11.27.23-AM-c5ad52746aa93b4391dc33878988f0f4.png)

You can see that there are more data sent to the VFX editor, in order to make newly imported model work. Next, swap `Target` input in the `SendDataToVFX` script on each of the scene objects below with your mesh:

![](/assets/images/vfx-collision_Screen-Shot-2021-10-26-at-10.58.52-AM-ac47c4109c79a6cb7ce849ed992d47a5.png)

Check out the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) for much more examples

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens! To preview your Lens in Snapchat, follow the [Pairing to Snapchat guide](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md).
