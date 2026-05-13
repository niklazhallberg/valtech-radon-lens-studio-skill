# Cloth Simulation Try-On

The `Try On Pack - Dress`, `Cloth Simulation Coat` and `Cloth Simulation Hoodie` assets demonstrate how you can use various technologies together, such as [3D Body Tracking](/lens-studio/features/ar-tracking/body/object-tracking-3d.md), [Cloth Simulation](/lens-studio/features/physics/cloth-simulation.md), [Body Mesh](/lens-studio/features/ar-tracking/body/body-mesh-overview.md), and [Physics Collider](/lens-studio/features/physics/physics-component.md#physics-collider), on different types of clothing to create a realistic try-on experience. Each asset shows different techniques to create the best experience.

![](/img/lens-studio/5-features/try_on_pack_dress.png) ![](/img/lens-studio/5-features/cloth_simulation_coat.png) ![](/img/lens-studio/5-features/cloth_simulation_hoodie.png)

## Guide[​**](#guide "Copy to clipboard")

Find the `Try On Pack - Dress`, `Cloth Simulation Coat` and `Cloth Simulation Hoodie` assets in the Asset Library and import them into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the Asset Library.

Each of these assets contain 3D meshes of clothes imported from another software. Take a look at the [importing 3D guide](/lens-studio/assets-pipeline/3d/importing-content/overview.md), [external body mesh](/lens-studio/features/ar-tracking/body/external-mesh.md) and [cloth simulation](/lens-studio/features/physics/cloth-simulation.md) to learn more.

### Common Elements[​**](#common-elements "Copy to clipboard")

While each clothes and technique vary, a common set up is used to allow the clothes to interact with the body.

In short: The person is tracked with an `Object Tracking 3D` component for the body. A `Body Mesh` is used to conform the clothes to the body, and `Cloth Simulation` is used to deform the clothes based on the movement of the body. A `Physics Collider` is then used to guide the `cloth simulation` based on the body. Finally, a `Body Mesh` is used to occlude the part of the garment covered by the person.

#### 3D Body Tracking[​**](#3d-body-tracking "Copy to clipboard")

At the root object of each asset, you will find an `Object Tracking 3D` component. This component is responsible for tracking different 3d objects to our body.

![](/assets/images/cloth_simulation_body_tracking-0c3530469c8b5b4477e95a854e64500b.png)

Notice in this component, under `Attachment Points`, you will have a list of body parts, and a corresponding `guide` object. These objects guide the clothes so that they do not overlap the body.

![](/assets/images/body_tracking_attachment_points-eb819a5695a3bccd9153a86337f0acfd.png)

Right click on a field and click Select to see what it is a reference to.

#### Body Guides[​**](#body-guides "Copy to clipboard")

When you expand the asset, you will notice that there is a `Collider Guides` object, with `guides` underneath. These are the objects that the `Object Tracking 3D` component is aligning to the body.

While the cloth simulation interacts with the [Physics Collider](/lens-studio/features/physics/physics-component.md#physics-collider), not everything in the Physics system applies to it (such as gravity and wind settings).

![](/assets/images/cloth_simulation_collider_guides-fa80a628946cad0fbac3eefcbefa6237.png)

Each `guide` is a very simple mesh that aligns to the joints of the body. More importantly, each `guide` has a child object which contains a `Physics Collider` component. Each `Physics Collider` can be used for cloth repulsion, and in this case we use it to repel the clothes from the body.

The guides `[EDIT_ME]` object contains a script that can modify the settings of a collider. This script will automatically apply these settings to every child Cloth Simulation component. In this asset translation and rotation smoothing is applied on all the colliders.

#### Full Body Occluder[​**](#full-body-occluder "Copy to clipboard")

Each asset will have a `Full Body Occluder` that will hide the parts of the clothes that are covered by the person in the camera. This uses the `Body Mesh` so the occluder can automatically conform to the user body. Like with the guides, this uses `Object Tracking 3D` to attach the mesh to the user's body.

[](/img/lens-studio/5-features/cloth_simulation_body_occluder.webm)

#### Reset Cloth on Tap[​**](#reset-cloth-on-tap "Copy to clipboard")

Lastly, each asset contains a script that allows the user to reset the cloth simulation by tapping on the screen.

![](/assets/images/cloth_reset-033e9c10f437c76aa4f1da57c5112bfe.png)

When working with your own clothes, make sure that the Cloth Simulation you are displaying is linked to the Cloth Visual field.

### Try On Pack - Dress[​**](#try-on-pack---dress "Copy to clipboard")

In this asset, you will find three examples under the Dresses \[TRY\_ALL\_CHILDREN] scene object. You can enable one at a time to test them individually.

![](/assets/images/cloth_simulation_dress-examples-d4050cb0653011b53032800a131c4847.png)

#### Dress - LowPoly \[EDIT ME][​**](#dress---lowpoly-edit-me "Copy to clipboard")

In this example, a `External Body Mesh` is created from a 3D model of a dress so that the dress conforms to the body. By using `Body Mesh`, the cloth will change its size based on the user’s body.

In the `Cloth Simulation` settings, some of the body `guides` are added to the `Cloth Simulation` so that the dress can collide with the user. Only colliders that we expect to interact with our cloth are added to improve the performance of the simulation.

![](/assets/images/cloth_simulation_colliders-68e6dc037da5683e8930bc2e11f1791d.png)

Importantly, the dress is not entirely cloth simulated. The part that hugs the body is pinned to the `body mesh`. To do this, we use `vertex colors` to describe which parts of the dress are binded, and which are simulated.

![](/assets/images/cloth_simulation_dress_vertex-83b57bbf6f44470ba3e68405217fdf5c.png)

In this case, we bind the vertices of the object painted in white to the 3D body Tracking object. Take a look at the [Cloth Simulation template](/lens-studio/features/physics/cloth-simulation.md#vertexcolorexample) to learn more about using vertex colors to bind clothes.

#### Dress - HighPoly \[EDIT ME][​**](#dress---highpoly-edit-me "Copy to clipboard")

In this example there is a high polygon version of this dress for comparison. In the high poly version we use a `debug material` that visualizes the different vertex colors! In this example, the white part of the mesh is binded to the body, as set up in the `Vertex Bindings` section above, whereas the red part of the mesh is driven by cloth simulation. Try using this debug material on the other clothing examples.

![](/assets/images/cloth_simulation_dress_highPoly-3438323fbdf083b674463f053cd7cdce.png)

Keep in mind that the higher the poly count, the less performant the cloth simulation will be. In most cases you will want to use the low poly version of the dress as it will work better across all devices.

You can create a simple graph material to visualize the vertex colors of your mesh like so:

![](data:image/png;base64,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)

#### Dress - LowPoly - Auto Paint[​**](#dress---lowpoly---auto-paint "Copy to clipboard")

In this example, rather than manually binding some vertex colors to parts of the body like above, we use a script to automatically bind each `Body Mesh` vertices to the `Cloth Simulation` vertices closest to them.

This binding is done by the `Vertex Distance Controller` object, or, more specifically: the `VertexDistanceController` script it contains.

![](/assets/images/cloth_simulation_dress_autoPaint-88b31e9ef237064e49a9d4cae21aa6f0.png)

* **Cloth Visual:** The Cloth Simulation which contains the Body Mesh that you will bind together.
* **Override Vertex Settings:** Whether or not you want this script to Auto paint.
* **Bind Distance Field:** Represents the threshold for binding the Body Mesh to the Cloth Simulation.

Note: The Bind Distance field in the `VertexDistanceController` script operates with values between `0` and `1`, and is influenced by the maximum distance set on the `External Body Mesh` asset. Therefore, when using this script, it's recommended to first configure the optimal parameters on the `External Body Mesh`, and then adjust the cloth simulation bind distance accordingly.

### Cloth Simulation Coat[​**](#cloth-simulation-coat "Copy to clipboard")

In the `Cloth Simulation Coat` asset, we use largely the same techniques as the `Dress` asset. Notice how like the dress, the bottom part of the coat is moving with the cloth simulation, while the chest part conforms to the body.

[](/img/lens-studio/template-clothsim-tryon-image12.webm)

We add a secondary `body mesh` to add additional details to our clothes. In this case, we added buttons. These buttons will conform to the body (since it is using `Body Mesh`), but will NOT interact with the body, since it does not have a `Cloth Simulation` component.

[](/img/lens-studio/template-clothsim-tryon-image9.webm)

Ensuring that your Lens is performant by only using simulations when needed will improve your overall Lens.

### Cloth Simulation Hoodie[​**](#cloth-simulation-hoodie "Copy to clipboard")

This asset uses the same auto paint technique and `VertexDistanceController` script as the **Dress - LowPoly - Auto Paint** example from the **Try On Pack - Dress** asset, where the script automatically binds each Body Mesh vertex to the closest Cloth Simulation vertex.

![](/assets/images/cloth_simulation_hoodie_autopaint-258da51b6c6bc290cbd2758acdf04fa3.png)

* **Cloth Visual:** The Cloth Simulation which contains the Body Mesh that you will bind together.
* **Override Vertex Settings:** Whether or not you want this script to Auto paint.
* **Bind Distance Field:** Represents the threshold for binding the Body Mesh to the Cloth Simulation.

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Lens experience in Snapchat! To do so follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
