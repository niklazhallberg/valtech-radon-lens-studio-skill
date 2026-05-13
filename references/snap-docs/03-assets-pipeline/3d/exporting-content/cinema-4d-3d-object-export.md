# Cinema 4D, 3D Object Export

This guide will walk through how to export a 3D model from Cinema4D to the FBX format, so that it can be imported into Lens Studio. For the purposes of this guide we're using [Maxon's Cinema 4D R17](https://www.maxon.net/en/products/cinema-4d/overview/). That said, any 3D tool that can export to FBX should be able to export models that can be imported into Lens Studio.

## Animation Settings[​**](#animation-settings "Copy to clipboard")

To configure your animation settings in Cinema 4D, select `Edit -> Project Settings...` from the menu bar.

![Animation Settings](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_animation_projectsetting-463ea54bb96a1c5b9e8be95408194a3a.png)

Now you can see your current project settings in the `Attributes` window.

Leave the `Project Scale` set to `1 Centimeters`.

Change the `FPS` to `30`.

Set the `Minimum Time` to when your animation starts and the `Maximum Time` to when your animation ends.

![Animation Settings](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_animation_projectvalue-34a32376a2e0b9c380273a71854090fa.png)

## Export for Lens Studio[​**](#export-for-lens-studio "Copy to clipboard")

To export an FBX, first select the `File -> Export... -> FBX (*.fbx)` from Cinema 4D's menu bar. Select where you want to save your FBX then click `Save`.

![Export Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_exportmenu-67695554d96c270102da9c911310ab30.png)

This will open the `FBX Export Settings` window. In the `FBX Export Settings`, set the FBX version to `6.1 (2010)`.

Then, in the `General` section, un-check `Lights`, `Cameras` and `Splines`.

If you want to export animation with your model, in the `Animation` section, make sure `Tracks` is checked.

In the `Geometry` section, make sure `Normals` and `Triangulate Geometry` are checked.

In the `Additional` section, make sure both `Textures and Materials` and `Embed Textures` are checked.

![Export Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_exportsettings-35fd0d047c40bad07786c18e7ffcf0e3.png)

Below is a list of things to ensure when exporting your 3D assets to work best in Lens Studio and ultimately Snapchat.<br /><!-- -->• Your model has to be triangulated via the export dialog<br /><!-- -->• Your scene total of 3D assets should add up to less than `10,000 triangles (5,000 polys assuming your model is built with quads)`. This will allow your model to display smoothly across the widest variety of Android and iPhone devices<br /><!-- -->• In general, stay under `100 joints` for your animation rig. Additionally, while the engine does support Blend Shape animation, try to avoid using it. If Blend Shapes are required, use sparingly and pay close attention to your frame rate performance<br /><!-- -->• Lens Studio supports up to a `4 bones per vertex` limit. If the influence is greater than 4 then there will be problems in your rigged model when imported into Lens Studio

Finally, in the `FBX Export Settings` window, click the `OK` button.

You now have an exported FBX file that's ready to be imported into Lens Studio. For information on importing 3D models into Lens Studio, review the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide.

## Baking Textures for Lens Studio[​**](#baking-textures-for-lens-studio "Copy to clipboard")

Some of the Cinema 4D's shaders, like procedural shaders, are not compatible with Lens Studio. In order to successfully export your 3D model you need to bake the texture(s).

To bake textures in Cinema 4D, first select the object you wish to bake in Cinema 4D's `Objects` window. Then, from the menu bar, select `Objects -> Bake Texture...`

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_objectmenu-ea816d42408ab1ce41289c8e9f120e5c.png)

This will add the `Bake Texture Tag` to your selected 3D model.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_baketag-bcf5acb900bb39741c3eb1bd33a54f4b.png)

Click on the `Bake Texture Tag`. Then in the `Attributes` window select the `Tag` tab.

Now, you have to choose where you want to save the baked texture(s). To the right of `Filename` click the `...` button to specify where you want to save the baked texture file(s).

We recommend creating a new folder to keep both the baked texture(s) and FBX file in the same place.

Next, select `PNG` from the `Format` drop down menu.

Change the `Color Depth` to `8 bits per channel`.

Change the `Width` to `1024` and the `Height` to `1024`.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_baketagmenu-d2a318814f721be794e36d8e538d6dcb.png)

Select the `Options` tab. In the `Options` settings, check the `Color` checkbox then click the `Bake` button.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_bakeoptionsmenu-d4c170bdbbb6f8780d65325222eb9d66.png)

Once it is finished, you have to apply the baked texture to the 3d model. In Cinema 4D's menu bar, select `Window -> Material Manager`.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_materialmenu-facaebffde3b93f5d974891cb02b0373.png)

This will open the `Material Manager` window. Create a new material by clicking the `Create` button and selecting `New Material`.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_materialwindow-52d463daaed7639c7236bce1205f3860.png)

Double click the new material to open `Material Editor` window. To the left, make sure the `Color` checkbox is checked. Then click `Color`. With the `Color` settings open, click the `...` button. Select your exported baked texture.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_materialeditor-8bb33437365601c6b43f60ad191d52b2.png)

Cinema 4D will bring up a window asking you to copy the image to your project. Click `Yes`.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_materialcopy-870dfb104d8cdd850ed8089bca8adf25.png)

Now we have a material with a baked texture. To apply the material to the model, first select the 3D model. Then navigate to the `Material Manager` window. Right click on the material with the baked texture and select `Apply`.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_applymaterial-b9fb30ed7a2c9d3d91d21cd6ea3356d1.png)

In the `Objects` menu select the 3d model and delete `Bake Tag`, `Polygon Selection Tag` and any `Materials` that are no longer used.

![Bake Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_tagsdelete-c99354afd8dbd8626049a79de9b2a619.png)

You now have a 3D model with a baked texture applied to it.

## Baking Animation for Lens Studio[​**](#baking-animation-for-lens-studio "Copy to clipboard")

Baking animation is the process of taking complex animation and simplifying it down to key frames that can be used in Lens Studio. If your animation is using Mograph, Effectors or XPresso we need to bake the animation. Otherwise, there is no need to bake the animation.

To bake the animation using XPresso, select your `Mograph Object` from the `Objects` window. Then, create a copy of your `Mograph Object`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_firststep-cfaeac811fc6ea2988f7b7fd393b8add.png)

Now you will have two Mograph objects in your scene. Select one of them and rename it to `xxx_Bake` to make sure that you can easily find it in the future.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_duplicate-aa48229a9305ff77aad17a72e1bacbd4.png)

Next, we have to make the `xxx_bake` object editable.

Before making the object editable, if you're using `Cloner` make sure that object is not using `Render Instances`. Select the `Cloner`, then in the `Attributes` window, select the `Object` tab. Make sure `Render Instances` is NOT checked.

To make the object editable, select the `xxx_Bake` object. Right click it and select `Make Editable`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_editableobject-ea47d7dd993a36b103e792411eb8fd5e.png)

Next, we have to add a `XPresso` tag to the `xxx_Bake` object.

`XPresso` is Cinema 4D's node based scripting editor where you can set up complex, automated object interactions by drawing lines from one node to another.

In order to add the `XPresso` tag, select the `xxx_Bake` object. Right click it and select `CINEMA 4D Tags -> XPresso`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_xpressotag-ef9591752967472ebdb1ee5f8425eda7.png)

This will open the `XPresso Editor` window.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_xpressowindow-2c3e8f5821c3876712c5f91e61efefc8.png)

Now we need to create a system that will link all of the attributes of `Mograph Object` to `xxx_Bake` every frame.

Select the `xxx_Bake` object from the `Objects` window and drag the object into the `XPresso Editor`. Do the same for the `Mograph Object`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_xpressonode-2742223d046830646c18ae87214455b3.png)

Then, we need to add nodes to link the attributes of the `MoGraph Object` to the `xxx_Bake` object.

The first node that we need to add is the `Data` node. The `Data` node can link the data of one node to the other node. To add the `Data` node, right click the grid and select `New Node -> Motion Graphics -> Data`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_datanode-6602a1811fa45de19c29a47b83a7bdd4.png)

Next, we need to add the `Object Index` node by right clicking the grid and selecting `New Node -> XPresso -> General -> Object Index`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_objectindexnode-58a8102cb826ee15089478b09767c657.png)

Next, we need to add the last node which is the `Hierarchy` node. In order to add the node, right click on the grid and select the `New Node -> XPresso -> Iterator -> Hierarchy`. The `Hierarchy` node allows us to access the selected object's children.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_hierarchynode-ed34ce751a2b442cc75cddc843cdb743.png)

Each node has an input and an output. The blue square on the top left of each node indicates the input. The red square on the top right indicates the output. You can add input or output by clicking on these squares.

![XPresso Selection](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAkAAAAESCAIAAACaVv0AAAAdA0lEQVR4XmKopgEoBYNqmoFR80fNHzV/1PxR80fNB7BXBzQAADAIgJz9Qz+HH5SgGQQAzUMACAwABAYAAgNAYAAgMAAQGAAIDACBAYDAAEBgAAgMAAQGAAIDgGMHDkgAAAAQAHW6/+0ItIcAID0EAJmG4o2co+aPmj9q/qj5o+aPmg9g145pAAAAEIYR/ItGBV9rYs+aFwAwcQCAgAEgYAAgYAAgYAAIGAAIGAAIGAACBgACBgACBgACBoCAAYCAAYCAASBgACBgACBgAAgYAAgYAAgYAAgYAAIGAAIGAAIGgIABgIABgIABwNiBAxIAAAAEQJ3ufzsC7SEASA8BQKZqGgCI0dU0A6Pmj5o/av6o+aPmj5oPYO/cYty4yjh+fJnxZXzb9e7au+u9JJuk2y2kBLWUCiClTSFFFaAKKhCIlz6gAq8RD3nhjRdeeEI88EiFoBIIgZKSkLKqqqYFWgXakEuzWW+8a3uvtsfXGY/NBxOOHHs88WzW6Xry/+ko8jf6nzOWVspf33e+c+xkXQEAAADQxAEAAADAwAAAAAA3sxeXK7HFUlwPvjt0RXLVWD8BAICRWm28VDm6scUFist5ZXgoLfk2PR5mA2Bg4Oebj+rBF7zJg+I6G3wAAE9mNw7mCm0CUWuQnx3dYFeiQ/8YGWa75ePbOd0XS6Lw+wPTrP98++oNPfh7fOxqOIgS4u4Bq2pgsZh4ZWf+F5tHadAHClNqgO0FAIB4ufJEduMrN1e+dW2JxleXVp7IbFA6xXrjeDrL3cuQ+a0dcjj2QIEMDOQ0D3nV2p1eldc8NC5XoxNC8XggFdltgRQAEFLUT2U3YuU7vCqgqofyNApZv++d2GhBFMzTo0Sh2Foz/NdwpC1zIsjhtr3eXWYzABnYh9Uole9ovF2covC90gSF+liUZ3fq/rZC3y8Lj9MoaZ5btcgfckd05Z/zcxS27be1LsvJqkH9+W92HtaVNJdCLni9OkPr07diXSDfejV3hP7tQWAZAMBYuXIymeLu1Unsf4Kx7gJPozG/vcPd6+zMFHcvgj6/Npvg4dGNzVbbozIdjbbMbKJc0Z9/I5XmIXdBSVEp/NrNFV7o00dQrc8WS19OpvTwRCpNIQl6fx1fk+ZSyAWPZdYpfCgvw8D2EWRIFyujPLxcC/86d5gsp1OZVCJ/lGdW6z49vKEGKCTTug+515nCrNp0mstIQDISMysAAIKK+vm1rNBomMtI8NRqhhI1Q8F4uSJqt1eg3EsW3G0Cat+gDTC+JcZ9ZW+ZlYufWc0MVWt6GCuVKSTTQgZmQ96tDnNDauXt0ninmLoZDR9yt+sTF+RppenqRUkyEjMrAACezKx7NI2H5h5GYkNBtFrjwbVIyFCTDEpt+j2HUjTDh5RgwcBsyKS78s3I9ZdHLr0UfX9OKOoCcjVDzzguZUhJ49lAij+8VB5jFvli+AYtQgHvQnwp9LdD3q1OZUoNZut+1jMkTvVsqACA8VJ5tFLtXT9SqdKUTgFPekqiUHMaZwKUhLXurjErrPl9v3po7p+jUf4WCg0bEUlDShrUN8gfLlhPws4nxmkRHtJqFO6vrTsY2DPB5JC7TIHo0B6X0lygNtxtyk96txd8WT0gs/m0b4PXEnW36wc3auH+TQEAUM2NWeRAwWxKURCYEdx49EDQGqwPLEVCfO+NzIaKlryWSLt0yMBsRdSltB5t1p2sGxOC3BrOenI8KPVt54nSqf5NAQBEKzVmEZ6x7UPSkr9b0TKoqjAwWxFxKr2Lh92V1rDV+fqXgRU1oX9TAAD+en1vp5jXBiVF1QPV1ZdsYevOmz7klnRQ1JCB3V+Ay9FkfQMA4Gw22V6w4/Vwi+pWrBup1ToqjaD/BgZ4mmVYNgyYZnJKY/f5meRUmUUCrl6nAADKgtvyFLfBlC2vhwdHcoUuDSOVNr0J4q62rDwNjQe8bMizMfPX2dnAwLVq1DD0O7S2O4Kzd7bmr93DptSYu8wsEneXelQCADJ+355MSft9yv+rgnSiOajWO9Mv3uNeEoXlgNStj5G3RzLrHM4VDEP6brLgNn8dDMzmh8b4sWX6QKEumBWLukB01HkXPr9WgytNULrf4HXEs8MscsiT61EJAEiRkVgkGQp0Cqh1ns4v892mk8lbrceH6fOXllM8/LeuvG0tLu4odM8F15vfqSh0ObhGs2hu5yLrkt/kdZ/Iy7rSBFHTBvsuREDHlmm0CY761vVgmpyjmNCV54oJGqw33qxO0qCzZZ1HwaZEOeYuWzoK9n51JCHId908AwC4ms35nTyzwqbP2y1po/714VotUSjy6+dpGHa6t56mWg5Kj2UYv66JBusBWp8udjK8k97wvR8MR6y+znBZfif9gGVggB/8aoVchzffiw6NNIbHn7udoWY98HRwhVZmPbOiBM/KB7Smw1wGANzr+GrGUulMdTrfio+ZCBbHY+RPJgI6mPVWbLQtdaOHhueRWQeyKDBTDJci16Ez1FZfx5tT7FBCBBOi/HwwGXUpejgnFF8IL7XlTMekNbIrv0PjFkWaGTHHjPhcILXgybO7EXHVngstC47GR+hhAMC9FJfzr4nxwt0shPyJ7u3lfsDn0hN6bvhjYPSQ9KThnvH61MRyMNCppJ2zVqXhVtybk3F+XDor+WkpyplMXrftEc+Njxm+jngnPpoKBdiA4Dh9+jTbaxRFoUAURT0crPX5tfFkRTFB/qi+f07z0D2HlmqJ06J8MniTaok9rG//vy/Wx/r34l5Zv+9ifLQoCPvz78uvjSe7WvP7Hsy/7/7NwADlYS9Erj8fXlrwboVcipM1KSejhxQ+F7qZEIr3mIcBgNwrLfkvTE1cj4TyHpGqhTToA4XnpyZo3NPJLYAmDjAlyDQ6BWRgZwoHUmrA0MOe9l51sSYzBQC41+JkXHM4qArH7hsAe2DA7WiY5GHny4c1dvc8DAC4F9tXABgYPCxVD5OHPVi1RADgXighAvrhrtubhII4EB5mWEskD6Naot7TwewFAHAv/sNdtgIZGPIw9HQAuNcz2U3kXjAwAA8bPADca7JSfRDcCzhOnTrFBh9QbzrPVQ6v1UOdgoQ7f8J/vbUv0e1QHw1eOSIlJzzrAXdJclXZoAFASfMW69JabexaaeaSPF9vCibuterz/iU2MtjuBWBg8LCHpQ9fjJ+V3BVmFwAo1X2vpk9OLoUH1b0AbuLA+uRhZwqzKTXY7Z6OBf/V78R+63Cwi/L8K5tPvVeaSykj5Yan3nSznjmR+x3bawD4sda0oHY0nK664C17w9uRxJIvvHPr3c+WNsdNKof2+/8B67uZ3cB+2PKf8jOUh3Xuh70mz/xo+mfkXj9JvfjT9NfZ4AJA09moi7UijUh+9aDoLyrlwMDvewE0ccDDnvVdn3AXOgVJJfy9pR++UfiYzdwLAFu5F4CBwcMSRndQnc8f+/7NHzB7AYDd3AvAwFBLNPSwNSXKbA0A1LVhC/cCMDB4mH0BwA49hwAGBuBhAEgjmQv7xb0ADAzAw4A/euiRhUf+O+YSUb+JEO6VOPZGfc/dC8DAADzsP+zdD1BTV74H8O/sRoOJbbS3bdwmPuoLiGK2jSxUsW2oIgWXumj1qW6rqBSKOBYLokVLGQRFAdBoQYSC/1/VqdAWeWqRrvAsaKGQSqJiua+TLWmbrVflrQlEb2dekntDEoXRtuyr0vOZOyNzPf7uuYfB79xzzg3Bseklu3YUFe4oKUwPEaFPYcnZ5XybdcEiPECoyfEle3fvK8sOozBQAmbF5BSWHi7fsTHt7XfsR2Z+4XsHy3akJUTJ4U6WmL9z396diWEy9ItamrG1fNfOTbFqDFK29Prd73/E4EOQACMZFvJwG35Vo6RyiYSykVB+015UoA8Tw4K8xXybMaMfwQNk2KhHJEKhUPzoyGEYCFTcxtK1C0K9KTE8CcSUUj0/f69HUj48wnZxySNiL/TLS/6kVCyRyOUjMVD4XMzdrtma+spE/NoGbXoRJMBIhh30zfl1M+wmWDj5PP8C7kCFTPWGyy08UG4NZLfnZWwOVfDRxTJ0bUX5tpzcbWWHm2gGHKH3a5rMAPBY3B33KUvsrZsYKHwuyqRS6Xh/Bf5FCIL8PjBi2O+stgyTf7Ef9wGBTBVGoYaBO/W08XjwDcEvRYUkzfHj0+vSieL0PfXgtTbWfESFxGQvD5UAECji35oet/kUXHrQL2Pe63/FwOthWUAIttuMfymCIE9gJMNwv6CmhirgYdLzfmL0IyAyZpNmZ3lZqe0o0WSvmKfuq+TEuOT0gvzcgi3ZacnRARTkk2e8+srckAkUbOST4hJXJsZGURBFxq7bXrizaGM8BY4oZFZMxpZc29qb7dien5m4ZIYcvUQh86LjYhfaCvqELczYstXRbGtG4kIf3KnHDFlk7JoCjaOUJnt17AwKP4lozl9UcDDU5nLp5Y6pK1u1rZ6FnUQVHgyXnlteAbPiczQ7SnbttC03ZiRHTxChV/CshXGxMbMny+BGpJiemJFtvyPN1pyN65ZGTsSdqEkr3s4ucQw+VzaAG9HJUSsSokcLYSP2nZYYGxOiEGGwIsgTGEGwZqMJUplYoHj2BdER2gIeFfasjPt7849isdBzNYifT+OJxeqX49Uhz21J2dRiAYcKic9dru5tJPP2VgaFw4H1v1W3/iN5YERosB8Q/KfJs4RcfYl0JMBgYkZZyjgx3FBSmWJKxJ/3rV5Z3Qlg5LS/hI8TIDR0BiBwNQqeuTEoYN9bKfY2LtTivFyPUtJFE5XebyQWM7g3oimBMsdVWHpvaSv6Yjm7r844JdTeTDY9UtZYDY5qUaYKLpKg8HeCAo9mrj2itwCyiLkzxwnAPtlVefYDPtKWZK6KULj31VuhjPizdsOKHD148rD4TTFqIXqJbWXHBT1XlZlonjlHrRCAI5TZOiTrOl1H0xiUCPIERhAC9oezX5hgIw2cSqFX6AvjYWOmv/j6BtxEvp3FpxfLNJ2oOFRRb7TCjlKuzY4XwUEe1ZteZpNBq23vYtHLyn196xYc+PRiWbPJdA0ISV7Gp5fZWF9VUVXbaOT/MTVnyQw49FhdU+4Mra2vbzaauROyxRnr5LiT1aBrbtDSLNdKqk6IlOHeUM8+JeG6c6lBj/5Y/uvTS3yfhuA2XUZdve0uzODvIjXFx+0urCw/Dj6z0p3pxRp1jbW1zSZ+YFXr8mOcAzt3gzO9mPbGqqpamuEaiWe+Ef91QwNtcF4HZgPd3tzxHQYxggQYQRKs5WSLFTaSZyP8wZs02ZFSzIXPLnfDRR4VpZTAxkpvi1uZt+eDyiPFSdFZui7YSdWxIRSA2Ute4jKIrspdlpiavTkj7tW0JhOLvrHaQ7nzX128LLmYgcjvCUd9s259TErhwQ8OlO5Iev3NBoYFIP6DDwUPukNpCetzCosKkmJW1nP1xcoFYdRt4VW0YumarALN5rQ3djbyGSb2wr0ZNpRv+Y3uPPrXDZZvP+JxuLBN+9PikjcV2u4iJqXJcRcQ+P1HH9vr/RfN9uPy7mhmfFLWjpLSgjeis7RdXC4/97ICjoEN5wbW1FiekL7jwMGydSuWnjBw373xY74sXrc2/SszN36H16zPONJiwaBFkAAjCIHXNfqTi2bYKJ5Ri/j5wxAZ7PQnGm4OEcDJZ4pKAjvdkeJGC5wuZOZUWWHnPdYHUCh9xQBYU33WwVbw6Lztx83oA9O0L/vD3maW9hbtpXZdfdXhDvQawafD8IdGgsfVz/+QBo8pLKnlWvlPegZuLlW+W8f0XusiF7WjJyjxk3mhf903ulmukeQhOJnbP86rpl27Nor4HvpOCoQnKuylcULYGKry7BOMvAvZmdzACn3/KAMUKsfAwqzN0ZyC0+HKc1bXhhHnCA0RY9AjyBoYQQwDc/q8SRUshfTpcAqVjHP+kKVP6i1+s9HLb6wcdqb6vxnh7vr1HkAIPCofBWoUt4/A+oPBAjd0/VfmmSoxPLH6vzXATd3BgjrIIl+ZmZaxZOSIESOGD3dfgeuBi/k7z/r6Mx3WcHsMDBnq3kr7325dtVz8xgxK/HN2MbLoQf+GDX+Iy/kfOmg4ff15I9zpT10yhyvFfE3P5zwBHEZNeW2TPwsei+EK7uYfekIOOT+w5q/bOj1W4IoXLyjGbxNBAowgGo9plweHCyEJnqmo3PPoZIUQQJeuoQPwgzuWiw7aAg+M4YoVEiFYuHyju4y7M3/7D49aE2YlrVsQKMDdfdN2Hh56elhA2Ec+/xLd1/4Jh9HKp/ChEf1Q+jzmXAPzAnpcX3ticRdCyltB4U5S2ajeacqe7lvgEQSZQiQI+hQ3i+g98QWfEH7/4Zen6/qeJBAM84InyneU0BUYfPwMhScvwV1nHeRRic70MhvbG2pPHt1fvmF1ytF2M+4wbITk/2Eeg9F1cNeWjFMHoD/+4UFSrtf6ZhpO7K2en9o3Q+PJqhMnT7iOqqMVFUerKkrKa7iB7ZOIshHhN4kgAUYQxtP8XsTJSX/9I7dN4+RZCzzd+OcN2AiffH4CPHj/gcuv7y9/hc7vr7OwGfOnZ+BO8Yzv3ebu5IH8GpuhVrMsOUNTuvdI9Sl9Z49CLu6j8Vhfz/rq8Y5WV0zfYwAxdV9w20ME3ksS1OhLcOwifvu66eyxTvQaMzEQ7hTTuRG4cfUabjNkCByuXTh2YM/e3a7jy8f+faxi9L8NBXDVfAN2kie8PdfP1uy2vwmnmSfHbxFBAowgGk9+boWNmJI45g8vftaB2zWd+x/YCacujoYLlRg9SQAb84WzF4COb82ORt4vxgWIwJMlJs0Q3vMHQBnb2uAkj4xWcvnFohsuQr8It/+yRUvjXuTq//BVJwaSZXeFFg5SdXxB4gwRPAQvSV8VyidKw/vvW+AiVr40T+Hewxe4xcHWU/Xw1Nl22Qo71dwYOVxmv7VSrVKqVIFPy4fB0qAzsdymxBWTReCJFryk5F/Z7obLrZv4rSBIgBEE/cn5LjixzZ809PXGboWWD6fwfflrwgL8fQKmp2rypkiFAFjjmQM0AObQcR3shKFrCjMSY5bGJm0vy51CCXA3V50LTlOWZ8TNUoeERa3euDV/kXNJTPjYjBB/EXpJ5mzeuXrJ3Nmz5qZqCiO8uR0O2v01RgwoS13BUR0/NLLgRbv3bk1NiJ43K2reKzGbCnevivCDc2u75vZnVvGcjaVpCQvDwqJS8509NJ07rMft6PeP0dxueFX+rsx5YdPDbPe+pXQB90Ta1XyojgEsR/koFapXFaYumRESNjdNU6iWCgCwhoZqxjVLKR4zbXVCdLAcgxBBNnEQxFBui8HvbX9wmE+bjUGh3PoX/WmLxdXM9YauMXvT4aKN8ylAKFO9tkaFXub2d9P2wqHzw037vHMXB8sA4bjg0HFwcX187ZAhfFmPqPjP+peD1VJ79dAF8aHwJJDOXP7WTTrV7YwkKOLlIPQynyh4txPwrO9BIICNkDt9z45kLTcnZC9We8NGKFWpw1XwYGzcn6Q55XEVnlipnqlUg8caijYUW/q8xPrtfrtSlBJAopgTo4CLaV9mQSc/nVnwnir3NcfAqiIWqeAqW5LxPux6/rcHEANiWZBa9viVM41HaAwyBHkCI4jLn5/R6XTaBu234LVUVDXYzuh0DR9/3AFe25nTOpum0y1cMtAfJSzLqm83WeHEmummioSYjEYLelVrUuavL29qNxjodtpguKSt3bI6V2d2vRHc2fZZk/3y5zquwg1TmJhSpTVYWUdh1soYdYe2rZy/IK3JyDAmpouhTd3g6CqKHS1ZrqWJbty2Ina3nu/E1bbPHfXP6D3qX9Od09pO1zW04ieqLkpdmlmuNTAs7FjuutYug67xvcyVSZrjcOnRtWh19vO5J3RGK2sHWw/baze8mlrHoB+tma+v3Fff3sXdPFdcW7th2ZvuH45Vo0lZX3bSwJhZB6uZ0TVWJNvK8vfNaN7RNBlMjJ3h4t+vY/AhyBMYQeiry/TV8MDUa7Lq4amjZm9mDTxYLhSmv1mIfgXMi48c+wh7tTU7PRW9FAtXiWEjgBe37zEv6xT6YDywOfUAbsPkJa8ETzYFdoKbNNeyTxb6eF7W8TtPVxblVMJOHqB+mhp6l5Wim8xnda0W8Cz6U9lrTwGgKBHDWEQiWCzoC1Op4a8Cfetu3Dumuiijugj9478ja2r29l/jXN7ac/gZCIIEGEF4Pz1JqRACviv05wvrjLAR+a/mN3GYtc00BoYXfj5Z7Jr4cbgrdiS9+EgnbsMwFoBLr59FJJKPeWqk4D77mScIEmAEUX+6bYEiEBCql+dOmme6wnpJpRL+7S7dscpO3AeMpTnF9/QE1okBF5mkWawUw+FK599xnyAIEmAEwdQUvOebvkTtJwCElFQGHtNem5b1EX4xgWAAflNlZ0t956+2fUYAB5bRHjjYivsHQZAAI4iaooyaPbLgqYHjHhsBwHzdqG9u0HdaMACMRRvSRgLXvqPxYDpZmmV4/GGr9R96vfH/2Ltjl6riKIDjR3zdsiKIzAcOgRFZNbT0BxQkNDgJIf4RjdfZVv03AjOoljb/hIYCW4RqaYinUQ2acPFlZ3g0B/cKeu/ng5zxTOf55fcQjLaAsbIsoxtYnV3LeeXdy6jn0a830TRYGR5FPbcfv8i5vF3GiYU/oweAXlEU0bSqqnLW2Nzgfvubfz/tDAbRNFjp96OejRjpwu8H+4/zBQYAvkIEAAEDQMAAQMAAQMAAEDAAEDAAEDAABAwABAwABAwABAwAAQMAAQMAAQNAwABAwABAwAAQMAAQMAAQMAAQMAAEDAAEDAAEDAABAwABAwABA4CxsiyjG1idXcu5uLkU9ewMBtE0mOr3o56NufWcy9tlnFh4gQFAryiKaFpVVTnrbq6/3/5Ogi58fu0/zhcYAPgKEQAEDAABAwABAwABA0DAAEDAAEDAABAwABAwABAwABAwAAQMAAQMAAQMAAEDAAEDAAEDQMAAQMAAQMAAQMAAEDAAEDAAEDAABAwABAwABAwAxsqyjG5gdXYt5+LmUtSzMxhE02Cq3496NubWcy5vl3Fi4QUGAL2iKKJpVVXlrLu5/n77Owm68Pm1/39fYADgK0QAEDAABAwABAwABAwABIzxsT9xioDDRsD4PZzIeXb8MFoH8rBHR94+CBh7wws5J8/tR+tAHvboyNsHAeNb1c95/dKPaB3Iwx4defsgYHw6mMn5cPpLtA7kYY+OvH0QMLb27+wPJ25d/r4w8zFaBPKk87DzvPPIo30QMA6PzrzenT86isUbW8/ubz6Y/nzt4s/zverU/fkW5NHm6eYB5xnnMedJ52HneeeRR2fQiy5h++Dm88GThatv8x2WP9EKkG+vrFeed7QbXmAatvb16avd+Q97d3eqyfzkx+mEaOUB5xnnMedJd6VeeIH5LvH93r38ad3/E7Lf/n/wAgMAAQMAAQNAwABAwABAwABAwAAQMAAQMAAQMAAEDAAEDAAEDAD+sgMHJAAAAAiAOt3/dgTaQwCQHgKATNU0ABCjq2kGRs0fNX/U/FHzR80fNR/Arh3TAAAAIAwj+BeNCr7WxJ41LwBg4gAAAQNAwABAwABAwAAQMAAQMAAQMAAEDAAEDAAEDAAEDAABAwABAwABA0DAAEDAAEDAABAwABAwABAwABAwAAQMAAQMAAQMAAEDAAEDAAEDgLEDByQAAAAIgDrd/3YE2kMAkB4CgEzVNAAQo6tpBkbNHzV/1PxR80fNHzUfwK4d0wAAACAMI/gXjQq+1sSeNS8AYOIAAAEDQMAAQMAAQMAAEDAAEDAAEDAABAwABAwABAwABAwAAQMAAQMAAQNAwABAwABAwAAQMAAQMAAQMAAQMAAEDAAEDAAEDAABAwABAwABA4C1AwckAAAACIA63f92BNpDAJAeAoAB/kAJDycjAsMAAAAASUVORK5CYII=)

We need to add an output to our `Mograph Object`. Select the `MoGraph Object` in the `Xpresso Window`. Click the red square and select `Object`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_outputnode-52457bf8137f01fe411534f973723080.png)

Now, let's add inputs to the `xxx_Bake` object. Select the `xxx_Bake` object and click on the blue square. Select `Object`. Click the blue square again and select `Local Matrix`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_finalnodelook-d2edbafd0826bb3baaa46056fb4baee2.png)

Next, we need to make connections between the nodes. To connect nodes together, click an output circle and drag it to an input circle. This will make a line connecting the two nodes together.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_nodeconnection-891a352895d929eec1b71921da84d62f.png)

Follow the below picture to connect your nodes.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_xpressoconnection-a31ba6fd427b6ef194b3aeee3ca11ec4.png)

Now both the `Mograph Object` and `xxx_Bake` are linked and ready to be baked.

To bake the animation, make sure the `xxx_Bake` object is selected. Then, in Cinema 4D's top menu, select `Character -> Manager -> Cappucino`.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_cappucinomenu-96ec8894f3e99677e3adb1a2662cb066.png)

This will open the `Cappucino` window.

In this window make sure the `Range` is set to `Project` and both `Start at Current Time` and `Rewind Time` are checked.

Then in the `What` section, check everything that needs to be baked. If you have moving, scaling and rotating animation, make sure `Position`, `Scale` and `Rotation` are all checked.

Check the `Hierarchy` checkbox.

If the animation is not using scale or rotation, make sure to un-check those. This will make the file size smaller.

Lens Studio does not support `PLA` (Point Level Animation). Make sure to un-check the `PLA` checkbox.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_cappucinosettings-c9c150356b5013c5e7dabe29ebe6ddd0.png)

With your keyboard, press `Shift + F` to navigate the timeline to the beginning of the animation.

Press the `Start Realtime` button and then click and hold on the `Perspective` window.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_holdtobake-678657d8d377444509d83613aaf2a320.png)

You should see the animation playing. Keep holding the left click button until the animation is done.

When the animation is done playing, delete the `Mograph Object` and any other effectors that we used in our project. We can also delete the `Xpresso` tag on the `xxx_Bake` object.

![XPresso Selection](/assets/images/cinema-4d-3d-object-export_3d_animation_export_c4d_xpresso_deleteunused-95082534cea3dcda59c4555bc256e0da.png)

We now have a baked animation object ready to be exported as a FBX.
