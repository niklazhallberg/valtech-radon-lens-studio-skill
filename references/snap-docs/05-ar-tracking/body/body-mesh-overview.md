# Body Mesh

The Body Mesh feature creates a custom mesh that mimics the user’s body as a 3D mesh in real time.

## Getting Started with Body Mesh[​**](#getting-started-with-body-mesh "Copy to clipboard")

To add a `Body Mesh` to your Lens Studio project, first go to the `Scene Hierarchy` panel, and press the `+` button. Then select the `Full Body Mesh`.

![](/assets/images/body-mesh-add-37470ad730976e06f2f42f55a9cfb241.png)

Your scene will be automatically populated with a Body Mesh scene object. In your `Asset Browser` panel you’ll find a newly created `Body Tracking Asset`, as well as a `Full Body Mesh`, and a default material.

The`Body Tracking Asset` handles the tracking data of the body and is used by `Object Tracking 3D` components in the scene. The same asset can be used for multiple bodies, and can also be used for skeletal tracking. The `Full Body Mesh` asset is the mesh that will deform according to the tracked body.

## Body Mesh Settings[​**](#bodymeshsettings "Copy to clipboard")

Let’s select the `Full Body Mesh` in the `Asset Browser` panel and take a look at it’s settings:

![](/assets/images/body-mesh-index-3535b61d74f2be90eba6bdd0540d2ed2.png)

`Body Index` decides which tracked body the mesh will correspond to. Note that it should match the index on the `Object Tracking 3D` component that contains the `Body Mesh` object in scene.

![](/assets/images/body-mesh-parts-8803bc7e654f5351ce6885b1cf927c6f.png)

Enabling or disabling the `Hands`, `Body` and `Head` checkboxes on the `Full Body Mesh` asset allows you to decide what parts of the body to include in your body mesh.

You can additionally deform the body mesh based on an imported mesh. Take a look at the [External Body Mesh](/lens-studio/features/ar-tracking/body/external-mesh.md) guide to learn more.

## Working with Body Meshes[​**](#working-with-body-meshes "Copy to clipboard")

### Adding a second Body Mesh[​**](#adding-a-second-body-mesh "Copy to clipboard")

To add another `Body Mesh` that can be the same or different from the one already created in the scene. We can first duplicate the `Body Mesh` component we have.

For the second `Body Mesh`, change its `Object Index` to `1` so it maps to the second person in the scene.

![](/assets/images/object-tracking-3d-change-person-33d4185da39b6fb070cd54232f0d8fe0.png)

You’ll notice that the second mesh has the same shape and pose as the first mesh. To change this to track the second person: like before, we can go to the `Full Body Mesh` asset in the `Asset Browser` panel, `right-click`, and `Duplicate` it. Then, change its `Body Index` to `1` as well.

![](/assets/images/body-mesh-1-1e5f0ea520b89e7e1b709a14560486d8.png)

To attach objects onto the body mesh, try using the [Pin To Mesh](/lens-studio/lens-studio-workflow/scene-set-up/3d/pin-to-mesh.md) Component

## Next Steps[​**](#next-steps "Copy to clipboard")

To see examples of using a `Body Mesh`, please check out the [Body Mesh example](/lens-studio/features/ar-tracking/body/body-templates/body-mesh.md) page. To automatically fit other outfits or accessories onto the reference body mesh try creating an [External Mesh](/lens-studio/features/ar-tracking/body/external-mesh.md).

## Download the Reference 3D Body Mesh[​**](#download-the-reference-3d-body-mesh "Copy to clipboard")

Click [here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/Forum-Helpers/3D_Body_Mesh_and_UV.zip) to download a zip that contains a 3D model of the Body Mesh object along with a UV map. You can use these to create modified body meshes or textures.
