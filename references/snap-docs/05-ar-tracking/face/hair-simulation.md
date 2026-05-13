# Hair Component

The Hair Simulation Component is used to simulate hairstyles with realistic lighting and physics.

In this guide we'll cover:

* **[The Hair Component](#hair-component)**

  * Hair Viewing Modes
  * Strand Shape and Simulations
  * Physics Simulation
  * Collision, Self Collision and Wind

* **[Hair Materials](#hair-materials)**

* **[Hair Splines](#hair-splines)**

  * Importing hair spline fbx into Lens Studio
  * Creating hair splines with Maya and 3D MAX

You can try playing with a lot of different hair styles in the [Hair Simulation Sample Project](/lens-studio/features/ar-tracking/face/face-templates/hair-simulation.md)

## The Hair Component[​**](#hair-component "Copy to clipboard")

It's recommended to use the [Hair Template](/lens-studio/features/ar-tracking/face/face-templates/hair-simulation.md) as a starting point when working with Hair Simulation as there are many inter-connecting pieces such as Blur layer, bald ML and head collider in order for the Hair Simulation to work correctly.

We'll go over some of the examples in the `Hair Template` to dive deeper into the `Hair Component`.

Under the `Back Orthographic Camera`in the Hair Template, we have the `Hair` `Camera`. Under this camera we have everything related to simulating hair. To check out different hairstyles, try toggling objects under Head Binding > Hair Components

![](/assets/images/hair-simulation_hair-hairstyles-e37f88f4e6c100c3f920e4641d3ac0ab.jpg)

Each hairstyle has the `Hair Component` attached to it. The `Hair Component` handles everything about hair simulation. For example, let’s check out the `Curly Hair Mint Blue` hairstyle under Hairstyles > Long Hairs.

![](/assets/images/hair-simulation_hair-curlyblue-0f4e18d73050edeab62229166739a89e.jpg)

### Hair Viewing Mode[​**](#hair-viewingmode "Copy to clipboard")

![](/assets/images/hair-simulation_hair-viewingmode-7babbff64fb36a848a8c86680f5306a7.jpg)

The first section on the `Hair Component` has the hair material as well as several modes for viewing and understanding the hair simulation.

Turning on the `Fallback mode` will disable physics for hair simulation. `Fallback mode` will be turned on on some low end devices for optimization reasons. (check out the `Hair Simulation Optimization` section below for a more detailed description!)

Turning on `Loaded strands` will show the raw shape of imported hair splines. Turning on `Sim. strands` will visualize optimized / recalculated shape of imported hair splines. This is especially useful when visualizing the effects of the `Hair Resolution` value.

If `Debug mode` is checked, we’ll see our hair now has 3 distinct RGB colors. Color Green represents the original hair strand. Color Blue represents strands generated with single strand interpolation method, aka each original strand generates another similar strand nearby. Color Red represents strands generated with multi strand interpolation method, aka strands are generated between 2 to 3 original strands. This mode is useful to see how different strands are generated based on different settings under `Strand Shape` and `Strand Generation`.

### Strand Generation[​**](#strand-generation "Copy to clipboard")

The `Strand Generation` section handles everything related to generating strands.

![](/assets/images/hair-simulation_hair-strandgeneration-f8da58d8d624a38769e394fa80eca9ca.jpg)

`Hair data` is where the hair strand object is linked. Try right clicking on Hair data and select to highlight the strand object and swap it with another strand provided in the template to see how hairstyle changes based on the strand shape!

`Neighbor radius` is the threshold for generating simulated strands based on distance between strand neighbors. `Cos threshold` is the cosine angular threshold for generating simulated strands. `Length threshold` is threshold for strand length to generate simulated strands.

It’s best to turn on`Debug mode` while adjusting these 3 parameters to see how they affect the hair simulation!

[](/img/lens-studio/hair-simulation_hair-debugmode.webm)

`Hair Resolution`changes the resolution of hair strands. To get a precise idea on how `Hair Resolution`affects strand shapes, we can clear out the `Primary Material` and turn on `Loaded Strands` and `Sim. Strands` in the section above.

The deep blue color represents the original strands of the hair, light blue represents simulated strands which will be changed by changing `Hair Resolution`. The green strand represents a smoothed result of the light blue strands.

[](/img/lens-studio/hair-simulation_hair-resolution.webm)

Having `Hair Resolution` to 1 or 0 means using original resolution of the hair strand object.

### Strand Shape[​**](#strand-shape "Copy to clipboard")

![](/assets/images/hair-simulation_hair-strandshape-1dadb65239e1fbeaeb8b302cdea038a0.jpg)

The `Strand Shape` section has parameters that affect the shape of each hair strand. Changing `Width` will change how wide each strand is and `Taper`will affect the tip size of each strand.

[](/img/lens-studio/hair-simulation_hair-strandshape1.webm)

The `Clump` section defines how ‘messy’ the hair looks. Increasing `Clump radius` will affect the distance of each strand between each other. `Clump density` affects how much more strands are generated to increase the volume of the hair. `Clump tip scale` determines the amount of separation between hair tips.

[](/img/lens-studio/hair-simulation_hair-clump.webm)

The `Density` variable changes hair density of simulated strands, which can be represented by the red colored strands if `Debug mode`is enabled. Increasing `Density` will increase the amount of simulated strands. Increasing `Density` `noise` will amplify the shapes of simulated strands.

[](/img/lens-studio/hair-simulation_hair-density.webm)

### Physics Simulation[​**](#physics-simulation "Copy to clipboard")

![](/assets/images/hair-simulation_hair_physics-31fe0f42b835da335c22e831a5f4526f.jpg)

The `Simulation` section sets up properties related to hair’s physics simulation. `Stiffness` will determine how stiff hair is. `Damp` will determine how ‘sticky / flowy’ hair seems. `Friction` will determine the amount of friction between each hair strand.

[](/img/lens-studio/hair-simulation_hairsim-physics.webm)

`Gravity` adds an external force to hair simulation.

### Collision, Self Collision and Wind[​**](#collision-self-collision-and-wind "Copy to clipboard")

The properties under the `Collision` panel affects how the hair object collides with external colliders, and properties under the `Self Collision`panel affect how hair collides with each other. Colliders can be added with the `Add collider` button. In this case the collider is set to be the `Head Collider` object under Head Binding > Head. Turn on the `Show Collider` check on this object to see the shape of the collider!

![](/assets/images/hair-simulation_hair-collision-125e3b7b5375761fe34124a17e15511a.jpg)

`Stiffness` determines how stiff the collision would be. `Offset` determines the amount of movement offset caused by the collision, and `Friction` determines the amount of friction retained during collision.

The `Wind` property if checked will add external wind force to the hair object.

## Hair Materials[​**](#hair-materials "Copy to clipboard")

We can see each hair material by right click to `Highlight` the `Primary Material` at the top of the `Hair Component`.

![](/assets/images/hair-simulation_hair-materials-319e1423da67096041b698eda0715bd9.jpg)

All hairs use a special material with special settings for hair. You can also create this material from scratch by going to `Resources > + > Hairstyle Materials`

![](/assets/images/hair-simulation_hair_materials-822d230edcf8c304f12d535ed53d8f0c.jpg)

Each hair material has its main `Hair Texture` where texture of the hair is applied.

`Alpha Test Threshold` determines the amount of cutoff from the transparency of the Hair Texture.

`Blur Multiplier` multiplies the amount of blur post effects on the hair.

`Texture Scale` is used to tile the hair texture along its Y axis. Make sure your texture is seamless in order for `Texture Scale` to work appropriately. `Texture Offset` offsets the texture map on hair strands.

`Hair Growth` works like the `Cut` variable on the `Hair Component` that it changes the length of the hair.

The `Lit Lookup` `map` uses a texture’s RGB value to adjust the brightness and shininess of the hairstyle. Feel free to swap current texture with any of the presets to see how it affects the hair differently.

Turning on `Direction Map Support` would allow the hair material to use the `Direction map`. The `Direction map` uses a texture’s RGB value to determine flow direction of the hairstyle.

Setting `Intensity Levels` to `Map` will enable the `Intensity map`, which uses a texture’s RGB value combined with adjustable parameters to determine the diffuse and specular of the hairstyle. Red channel controls diffuse and green channel controls specular, both can be multiplied by the according slider.

The `Hair Roots Color` and `Hair Tips Color` determines the main color tone of the hair. You can adjust how they mix in with each other by adjusting the `Mix Edge` and `Mix Size` parameters.

[](/img/lens-studio/hair-simulation_hairmaterials-roots.webm)

The `Diffuse Light Color` multiplies another color into the `Hair Roots Color` and `Hair Tips Color`. And the `Specular Light Color` multiplies another color into the highlight of the hair color.

[](/img/lens-studio/hair-simulation_hairmaterials-overlay.webm)

Adjusting the `Lit offset` and `Lit rotation` would change the direction and position of how the `Lit map` affects the hair object. It will therefore change position and rotation of the reflection of the hairstyle.

[](/img/lens-studio/hair-simulation_hairmaterial-litoffset.webm)

### Hair Splines[​**](#hair-splines "Copy to clipboard")

Each hair style is generated based on a spline object that can be found from the object linked in the `Hair Data` slot.

![](/assets/images/hair-simulation_hairsplines-b230775e02ecb8bc331a7305d9389a86.jpg)

We have provided a handful of hair strands in the `Hair Data` folder. But we also encourage creators to create their own hair spline objects to bring more dynamically designed hairstyles to Lens Studio!

Currently Lens Studio only supports splines created with **Maya** and 3DMax because of their way of fbx spline data formatting.

### Importing Splines to Lens Studio[​**](#importing-splines-to-lens-studio "Copy to clipboard")

Import your fbx exported from Maya or 3DMax to Lens Studio by dragging it into the `Scene Hierarchy` panel the same way as importing any other fbx.

![](/assets/images/hair-simulation_hair-importfbx-ccde13f7bb8125e507f05821867951f7.jpg)

Then duplicate an existing hair component, and click on the Hair data slot, a window will pop up. If your fbx is a spline object, it will show up on the pop-up window, just select your fbx then the hair component will be using your custom style.

### Creating Splines in Maya[​**](#creating-splines-in-maya "Copy to clipboard")

First let’s open the head template in Maya so we have a head shape as reference when we create our splines.

![](/assets/images/hair-simulation_hair-maya1-f2062c442526f4ab5f560cf9626e913e.jpg)

Switch to front view, then go to the Curves/Surfaces section, and select the spline object.

![](/assets/images/hair-simulation_hair-maya-2-79966d3de7fac07f04fc9bbccfdc2ab1.jpg)

After having spline selected, draw out a curve from the top center of the head object to bottom (or whichever direction that would fit your hair)

![](/assets/images/hair-simulation_hair-maya-3-e400a00371746f939029045babc736a1.jpg)

Press `W` to exit edit mode.

![](/assets/images/hair-simulation_hair-maya-4-c3e97e24b8bc4227be90e142445daf85.jpg)

Then press `D` to shift the anchor to the root of the spline object.

![](/assets/images/hair-simulation_hair-maya-5-e976e3ccae7e97464c2c18d39bd1bc40.jpg)

Then select the head object and make it a live object.

![](/assets/images/hair-simulation_hair-maya-6-cf81d6852d3f42e1a1b967a9563c551f.jpg)

Then select the spline, and duplicate the spline object along the head line.

![](/assets/images/hair-simulation_hair-maya-7-65ef3b8d736017ada8d7c945058da5f9.jpg)

Rotate and scale while duplicating the spline objects to create half a head of hairs.

![](/assets/images/hair-simulation_hair-maya-8-68323e9d330507137491f03b298a89a6.jpg)

You may also smooth some splines at the bottom part so they stand out less.

![](/assets/images/hair-simulation_hair-maya-9-3ac8283580128fa4e25ec04cceba68f4.jpg)

![](/assets/images/hair-simulation_hair-maya-10-8c4391aaa40dc6db491f88fc79697482.jpg)

Then we’ll select all spline objects and press `cmd/ctrl + G` to group them.

![](/assets/images/hair-simulation_hair-maya-11-ba87c1c70e62a5ea39e8830f927ea3de.jpg)

Duplicate the group, then change its `scaleX` to -1 so it shows up at the other side of the head.

![](/assets/images/hair-simulation_hair-maya-12-3812cef6523ef70f0af0108ff72a6e35.jpg)

Select both groups and press `cmd/ctrl + G` again to put them all under one group.

![](/assets/images/hair-simulation_hair-maya-13-d7ce500c567dbbb45a09dde05c0fded5.jpg)

Then select `Modify > Freeze Transform`

![](/assets/images/hair-simulation_hair-maya-14-853dc44e88fd3761b0d0afd03d9bf2bc.jpg)

And after that select `Modify > Reset Transform`

![](/assets/images/hair-simulation_hair-maya-15-746b8cc23e25ca817068a19dcdfbe368.jpg)

With the final group selected, click on `File > Export Selection`.

![](/assets/images/hair-simulation_hair-maya-16-c119646a7532793eb948f000247f8add.jpg)

**Creating Splines with 3DMAX**

First create Guides using `Either Splines` or `NURBS` curves

![](/assets/images/hair-simulation_hair-3dmax-1-4b6abd634030779c75bcd68b21a741de.png)

If you are using splines, make sure to convert them to `NURBS` using right click menu.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAcUAAADJCAMAAABlqtl5AAABelBMVEUAAAA8PDw8gtw8guE8guc8mO08rvM9PT0+Pj4/Pz9AQEBBQUFGRmhGRolGaKhGicZWRmVhgtxhgudhwvNhwvllRlZlRmVlgpFoRkZoRoloqMZoqOJ0VmV0dIJ0gnR0gp90kZGCZWWCgmWCgp+Cn4KDgtyD1/+JRkaJxuKJxv+RgmWRkZ+fkZGkmNykru2kwvOk6/+oaEaoaImoiaioqMao4uKo4v/DrtzD6+3D//nD///GiUbG4qjG/+LG///hwuHh6+3h6/nh6//h//Ph//nh///iqGjixoni4qji4uLi4v/i/8bi/+Li////xon/xsb/1+f/4qj/6+3//8b//+L///P///n///+fn59LS0s7OztGRkaCZUZGZYKCn59WRkZGRmVlRkZ0kZ+fn5GRdFZWdJF0VkafgmWfkXRGVnSfn4JERER8aixlgp9GRlaRn5GRn5+CkXSRn4JWdIKRdHSCn5GRkXSRkZF0ZXRCQkJWRlY4ODh0VlafgoKzFY57AAAKCklEQVR4XuzY2WrDMBQEUH+mNu+7s3df/726lsMlBRooFXKjGRIkwvXTYSLbiU50vEmU18jLge12Q3l/3fx1bkQRijHHOyK66D8RKEIRilCUCoq/CRShCMXisVshEhTHoxDC/EyXCZtmUXQfKDJieMWUBItTfq2AvF1dI6G4r5qzjuvZy1HUlmi8K6mBhumWTtZ25qMSYirHeZKumMqgRFAcD92FYjbketdr3fbWlyxZkcT5H9WSGp1OJV0RdRelCq7onFiRFrLZV4YE7cLnIv3CijRFkrSF4mq6yIpE+JSngmK4i86NFYecJqGoVngukknbt81sRmFFdPEKYvB71LfK6LZeFMfDc+d87ztWdCfhPEO7Ipull/b25y8UQz4vpkI8nLuod0PuTkO78vMizXy6mZbvUQMoQjHOJP4QoQhFKEIRih4Qo1GEIhShmNyAIhQVFD0jQvF6oAhFKaHI71L/bxflt/hDVF/snMFqwkAQhvUNvLQ9FdrSk/SBBBJUTVxTSPDSCH36jrP/yGQlFBoSN+ksLDMyJpfPdSP7OT1SnM9alZrkV+nGgeJY0c7mNyOAOv/DaLtoWIrgUJyydgDVzns5E6PYDhVjbBT98a9YNM8su8G50TKAriBU7N+MkmJHqoAYE0UWL8SicZcjROXcVDs5nXIX2qggjHctdqUaJ0Vl0VBQzg3FlV+lPFFBmAzFzks1DorKoqEgzo2M/HMLiqgg/FOKANlK9W77YnMt0quQNSiigmAUo3pG1RYNBeXcFMsLtOMaFFFBIOAx2BpGUX4vskUD+1ucG2yL/CAKiqhIIP/m4b4UjWK0PwDjpwiIRtEoGkWj2H0YRUA0ikbRKBpFo9gdolE0ikbRKBrFPiAaxe7DKJZO/q6YHxfwL0LphqpR+1VGMSVEm68z4SuzNjK5i5iiUUR3hmJZJjhC5O41Yaebol54U46rj5zDw0lpagkHl/rbUHHlpkYRECOiCMUtz1LHFg363YSdbkoHjYqr15yuOblAwqFU3sgfkM1b/4SMIn9dPh2Kek1RemyEnW6cj3uu6hxTSTgqJcbJQIyMYnpcvG+rl0OZXSkGnW4YnFQbOaaScFTq75NMjCIgxkaRtjByMsrXZu8pFG/7FTVyTCXhhD4OSv0Oo0gAzxmh+ajXwibodINnIHS6aeSYSsLxKXBTWtTfQwgdRjHf8x7mrqabWDd6UeXS6aaRYyoJZ+tTKsj+WU2OIiDamcbEKf6IhrHIPqJjkZ2KIJKdAKBhLEaOxiKdIpF9+OfF0VgcjcXRWASwdz6tDQJBFC8meq6tXyG5FNvcbHOxf5K7CMneesm93//YHXfsY5BR0BKUzIAs2X0a4Mewqwzz7pYZFpJidLux5N3EKBpFo2gUjaJRNIpGkbBdlSKKVTCBYfim6RTjo3OuGAKwfstZ3EQ5e4oS4zinNCDBOOChplNEAygO3DGdYkIE16/pMEXBc/YUJcbxTmk6xQ40naJsAPX/ubjalX8pec49ohfnygZU/LVZ750r/Nzz8fzp3GkDiqynoZgnRYmx1xFGdGxqa1ZQBnZ5Cr2ZfuCRpnqoydoykqgNoDgXWQnZGIrxIQ9s9kWUnDy3ivBtqyjKKk84sKxTmYvQz5eixNjrzoSOTYSPvdJQBiZykbWqhxpqy9hARmsAdeE7+F8hG0GRKNFARIgMIfKX/7XaFbTmB5qTFKGf774oMfY6pbHXEupPZFsmQZG1qocaasv4kUoDKL8I9JBNzMWkTokYUySE72niKBSKQU8Ti89F+J4RDuGV1qHIWtVDDbVl/EilAVRYZCVkE/dFmYtRVmUlzZFkKBcXvy/KXBReaXou6h5qpEO6KQ2gRC5CNvGM+rBvqLUU48NHHgg/5oEiE8O+WGJfXPgZ9R6+Z/4SXmk0x9T8CI801UMNtWX8SKUBFC2CImQT3xf5jMoUo22dEirn6jRgy9Qz6uLfF2lAv0LhldbWiwVu8EjTPdS4tuwbO2CnARQWQRGyK3y7sW8313PLN4oIo2gUjaJR1OPGKRrFW45f9s5Yp4EYCKItdFdRRVDwVeiCKDC4Oir+X7Aei0VpYtL4JrxtIlazbPEUnZR7sq+AIiYjFLOgCEUoQhGKUJzn3QwNj1O8geJE70YD7efY7fX9copPUJzp3Qj7MfQQKF5Ye/BuohmXV3xms53rpCwUz9d070YDhwgdfpo616nfw8Zz8WzN9240/1afazZ1rlPfC8WztQvvpuF7/N2MzyMUR2u+d6OB8AiyqeV3UBysXXg3rVnWbOpcpwWKgzXfu0ns2VSK5+IV/wIHRShCEYpQhCIUoQhFKEIRilCEIu8X+S5OKrwbRRwp4t3o6jVving3unrNmyLeja5ee9G6GCh6Re1EEe9GV6/1deFvfBPcitN3Ee9GAzXX9Rk3ing3J+u2En+4UcS7yXVysR7KakYR70YfuU7OvyFFvButy2tmvSlibMhs/RPFWyjuq+Sy2lOE4lbX/0YRYwOKKihCEYpQhCIUoQhFKEIR72Zs2pci3o0zRbwbf4p4N0uL6L/FbFXYiiLeTY9IB6jrx/2iA2+cKOLdZKQ7I32xE0W8m4zErC9FvBtFYtaTIt6NIi3dn4uGFPFuWkTpyNW++IudO+hpEIbiAH43ANcqHwA5dlMuCEfmdGDISHrg+38P37/lGdAsJsYRTf7Nmpe+lV5+eW3HYVTkG7g/2KhIRSpSkYpUpCIVqUhFKlKRilSkIhWpSMWkc85V3wHEtdW4SjeDQQ5pHxtZ7JxL3i8aYn9tRSqmEIyfzA8V66NdKSJm5xwxPedRqYtfU5GKUdl+lOQIkAfnWm+RvOaopEpy+258QYlhOiLmKur+sFTUJyUiyGeDHZWKyWnmaCoUT9z0QCh6qagewt5yMMta1Lnz8N5+VpSnEdPBROVgNlCkYqgWqEAHCtLDZojvJKiQKurceZj2C0U9DzWidke7jSJrEYWjYtJB+GxSh/ZVMcxVxehxt1AEZOvzujSOyW3+H5Xn4roWZTvNWt01L9aiDt9qiyHYvF5X6car8L+reHNBkXfU28arqWJyOtogfOdllARR+ko4Kkc7FTI1G4wXS0doIiSHUOYbKfL3ot5RQ5+KwYTTLcgIkQtu2eqOqmrz5XWa5467cC4ii/S6UZHvbqiojYpUpCIVqUhFKv7npoRUfGenjk0ABmIgCH6sDq8GfwPGzRscKtGDlJzZLUHDKc5TdNv7O/lzX7OhiKJ/aw4RRRRRRBHFPiKK/VBEUSj6t0KpAtFCkY+qlKEiipWqpSKKaYtKGSmiqMOpyk4RxVrVTRHFGtVa0V9RMRKKKKKIIoqKPymiiCKKb3t0UAMACMQATMAUzr8RLEACfK610IeLGb2YDc0l0xctWrRosbFo0aJFixYtHiVatGjRosVfiRYtWrRosbH4icUF296JS5BzTQAAAAAASUVORK5CYII=)

Once you have one half done, select all curves and enable pivot editing mode

![](/assets/images/hair-simulation_hair-3dmax-3-45149457476e0d89ded228c69914809e.png)

Then type in 0 for absolute X Y Z coordinates here

![](/assets/images/hair-simulation_hair-3dmax-4-9e805820d60f9603a4f76b3e7ec67972.png)

Once you have pivots at 0,0,0 and all NURBS curves selected, turn off pivot editing and use Mirror Tool with “copy” option

![](/assets/images/hair-simulation_hair-3dmax-5-8e167fe904a8a015a21fc6501920098d.png)

Select all curves, `ALT + Right Click` and select `Freeze Transforms` and chose `Yes`, then `ALT + Right Click` and `Freeze Rotations`.

![](/assets/images/hair-simulation_hair-3dmax-6-123b7fb7bf0be6a64920dc4349ca47da.png)

With all curves selected, use `Reset Xform` tool.

![](/assets/images/hair-simulation_hair-3dmax-7-c25df18d24d8ce8b70a295b78019599f.png)

After resetting XForm, collapse modifier stack on all curves by converting them to NURBS.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAcUAAADJCAMAAABlqtl5AAABelBMVEUAAAA8PDw8gtw8guE8guc8mO08rvM9PT0+Pj4/Pz9AQEBBQUFGRmhGRolGaKhGicZWRmVhgtxhgudhwvNhwvllRlZlRmVlgpFoRkZoRoloqMZoqOJ0VmV0dIJ0gnR0gp90kZGCZWWCgmWCgp+Cn4KDgtyD1/+JRkaJxuKJxv+RgmWRkZ+fkZGkmNykru2kwvOk6/+oaEaoaImoiaioqMao4uKo4v/DrtzD6+3D//nD///GiUbG4qjG/+LG///hwuHh6+3h6/nh6//h//Ph//nh///iqGjixoni4qji4uLi4v/i/8bi/+Li////xon/xsb/1+f/4qj/6+3//8b//+L///P///n///+fn59LS0s7OztGRkaCZUZGZYKCn59WRkZGRmVlRkZ0kZ+fn5GRdFZWdJF0VkafgmWfkXRGVnSfn4JERER8aixlgp9GRlaRn5GRn5+CkXSRn4JWdIKRdHSCn5GRkXSRkZF0ZXRCQkJWRlY4ODh0VlafgoKzFY57AAAKCklEQVR4XuzY2WrDMBQEUH+mNu+7s3df/726lsMlBRooFXKjGRIkwvXTYSLbiU50vEmU18jLge12Q3l/3fx1bkQRijHHOyK66D8RKEIRilCUCoq/CRShCMXisVshEhTHoxDC/EyXCZtmUXQfKDJieMWUBItTfq2AvF1dI6G4r5qzjuvZy1HUlmi8K6mBhumWTtZ25qMSYirHeZKumMqgRFAcD92FYjbketdr3fbWlyxZkcT5H9WSGp1OJV0RdRelCq7onFiRFrLZV4YE7cLnIv3CijRFkrSF4mq6yIpE+JSngmK4i86NFYecJqGoVngukknbt81sRmFFdPEKYvB71LfK6LZeFMfDc+d87ztWdCfhPEO7Ipull/b25y8UQz4vpkI8nLuod0PuTkO78vMizXy6mZbvUQMoQjHOJP4QoQhFKEIRih4Qo1GEIhShmNyAIhQVFD0jQvF6oAhFKaHI71L/bxflt/hDVF/snMFqwkAQhvUNvLQ9FdrSk/SBBBJUTVxTSPDSCH36jrP/yGQlFBoSN+ksLDMyJpfPdSP7OT1SnM9alZrkV+nGgeJY0c7mNyOAOv/DaLtoWIrgUJyydgDVzns5E6PYDhVjbBT98a9YNM8su8G50TKAriBU7N+MkmJHqoAYE0UWL8SicZcjROXcVDs5nXIX2qggjHctdqUaJ0Vl0VBQzg3FlV+lPFFBmAzFzks1DorKoqEgzo2M/HMLiqgg/FOKANlK9W77YnMt0quQNSiigmAUo3pG1RYNBeXcFMsLtOMaFFFBIOAx2BpGUX4vskUD+1ucG2yL/CAKiqhIIP/m4b4UjWK0PwDjpwiIRtEoGkWj2H0YRUA0ikbRKBpFo9gdolE0ikbRKBrFPiAaxe7DKJZO/q6YHxfwL0LphqpR+1VGMSVEm68z4SuzNjK5i5iiUUR3hmJZJjhC5O41Yaebol54U46rj5zDw0lpagkHl/rbUHHlpkYRECOiCMUtz1LHFg363YSdbkoHjYqr15yuOblAwqFU3sgfkM1b/4SMIn9dPh2Kek1RemyEnW6cj3uu6hxTSTgqJcbJQIyMYnpcvG+rl0OZXSkGnW4YnFQbOaaScFTq75NMjCIgxkaRtjByMsrXZu8pFG/7FTVyTCXhhD4OSv0Oo0gAzxmh+ajXwibodINnIHS6aeSYSsLxKXBTWtTfQwgdRjHf8x7mrqabWDd6UeXS6aaRYyoJZ+tTKsj+WU2OIiDamcbEKf6IhrHIPqJjkZ2KIJKdAKBhLEaOxiKdIpF9+OfF0VgcjcXRWASwdz6tDQJBFC8meq6tXyG5FNvcbHOxf5K7CMneesm93//YHXfsY5BR0BKUzIAs2X0a4Mewqwzz7pYZFpJidLux5N3EKBpFo2gUjaJRNIpGkbBdlSKKVTCBYfim6RTjo3OuGAKwfstZ3EQ5e4oS4zinNCDBOOChplNEAygO3DGdYkIE16/pMEXBc/YUJcbxTmk6xQ40naJsAPX/ubjalX8pec49ohfnygZU/LVZ750r/Nzz8fzp3GkDiqynoZgnRYmx1xFGdGxqa1ZQBnZ5Cr2ZfuCRpnqoydoykqgNoDgXWQnZGIrxIQ9s9kWUnDy3ivBtqyjKKk84sKxTmYvQz5eixNjrzoSOTYSPvdJQBiZykbWqhxpqy9hARmsAdeE7+F8hG0GRKNFARIgMIfKX/7XaFbTmB5qTFKGf774oMfY6pbHXEupPZFsmQZG1qocaasv4kUoDKL8I9JBNzMWkTokYUySE72niKBSKQU8Ti89F+J4RDuGV1qHIWtVDDbVl/EilAVRYZCVkE/dFmYtRVmUlzZFkKBcXvy/KXBReaXou6h5qpEO6KQ2gRC5CNvGM+rBvqLUU48NHHgg/5oEiE8O+WGJfXPgZ9R6+Z/4SXmk0x9T8CI801UMNtWX8SKUBFC2CImQT3xf5jMoUo22dEirn6jRgy9Qz6uLfF2lAv0LhldbWiwVu8EjTPdS4tuwbO2CnARQWQRGyK3y7sW8313PLN4oIo2gUjaJR1OPGKRrFW45f9s5Yp4EYCKItdFdRRVDwVeiCKDC4Oir+X7Aei0VpYtL4JrxtIlazbPEUnZR7sq+AIiYjFLOgCEUoQhGKUJzn3QwNj1O8geJE70YD7efY7fX9copPUJzp3Qj7MfQQKF5Ye/BuohmXV3xms53rpCwUz9d070YDhwgdfpo616nfw8Zz8WzN9240/1afazZ1rlPfC8WztQvvpuF7/N2MzyMUR2u+d6OB8AiyqeV3UBysXXg3rVnWbOpcpwWKgzXfu0ns2VSK5+IV/wIHRShCEYpQhCIUoQhFKEIRilCEIu8X+S5OKrwbRRwp4t3o6jVving3unrNmyLeja5ee9G6GCh6Re1EEe9GV6/1deFvfBPcitN3Ee9GAzXX9Rk3ing3J+u2En+4UcS7yXVysR7KakYR70YfuU7OvyFFvButy2tmvSlibMhs/RPFWyjuq+Sy2lOE4lbX/0YRYwOKKihCEYpQhCIUoQhFKEIR72Zs2pci3o0zRbwbf4p4N0uL6L/FbFXYiiLeTY9IB6jrx/2iA2+cKOLdZKQ7I32xE0W8m4zErC9FvBtFYtaTIt6NIi3dn4uGFPFuWkTpyNW++IudO+hpEIbiAH43ANcqHwA5dlMuCEfmdGDISHrg+38P37/lGdAsJsYRTf7Nmpe+lV5+eW3HYVTkG7g/2KhIRSpSkYpUpCIVqUhFKlKRilSkIhWpSMWkc85V3wHEtdW4SjeDQQ5pHxtZ7JxL3i8aYn9tRSqmEIyfzA8V66NdKSJm5xwxPedRqYtfU5GKUdl+lOQIkAfnWm+RvOaopEpy+258QYlhOiLmKur+sFTUJyUiyGeDHZWKyWnmaCoUT9z0QCh6qagewt5yMMta1Lnz8N5+VpSnEdPBROVgNlCkYqgWqEAHCtLDZojvJKiQKurceZj2C0U9DzWidke7jSJrEYWjYtJB+GxSh/ZVMcxVxehxt1AEZOvzujSOyW3+H5Xn4roWZTvNWt01L9aiDt9qiyHYvF5X6car8L+reHNBkXfU28arqWJyOtogfOdllARR+ko4Kkc7FTI1G4wXS0doIiSHUOYbKfL3ot5RQ5+KwYTTLcgIkQtu2eqOqmrz5XWa5467cC4ii/S6UZHvbqiojYpUpCIVqUhFKv7npoRUfGenjk0ABmIgCH6sDq8GfwPGzRscKtGDlJzZLUHDKc5TdNv7O/lzX7OhiKJ/aw4RRRRRRBHFPiKK/VBEUSj6t0KpAtFCkY+qlKEiipWqpSKKaYtKGSmiqMOpyk4RxVrVTRHFGtVa0V9RMRKKKKKIIoqKPymiiCKKb3t0UAMACMQATMAUzr8RLEACfK610IeLGb2YDc0l0xctWrRosbFo0aJFixYtHiVatGjRosVfiRYtWrRosbH4icUF296JS5BzTQAAAAAASUVORK5CYII=)

Add all curves to a group so it’s easier to manage them in Lens Studio

![](data:image/png;base64,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)

![](data:image/png;base64,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)

Once hair guides are grouped repeat step 2 so that group pivot is also at 0,0,0. Now you’re ready to export to FBX !

![](/assets/images/hair-simulation_hair-3dmax-11-a4421299ebec4e0b3941aed960bc1210.png)
