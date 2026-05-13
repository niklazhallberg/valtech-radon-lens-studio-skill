# Overview

A material is a container for one or more shaders, referred to as “passes.” These shaders described how something should be rendered, such as how an object's color, how a flat plane might display a certain texture, how a color filter might effect the look of the Lens and more!

![](/assets/images/materials_materials-red-fox-c120705b852f1bc967ea5c2222a53deb.jpg)

Take a look at how you can create your own shaders/passes in the [Material Editor overview](/lens-studio/features/graphics/materials/material-editor/welcome-to-material-editor.md).

## How Materials and Shaders are represented[​**](#how-materials-and-shaders-are-represented "Copy to clipboard")

In the Asset Browser panel, materials and passes can be distinguished by their icons. For example, “uber” is a pass used in “Uber PBR,” which is a material.

![](/img/lens-studio/whats-new-with-lens-studio-24.png)

Double clicking on a pass in the Asset Browser opens the Shader Graph. Double clicking on a material in the Asset Browser opens the Inspector panel.

To add a pass to a material, click “+ Add Pass” in the material’s Inspector panel.

![](/img/lens-studio/whats-new-with-lens-studio-25.png)

Materials can also be imported from the Asset Library or exported and imported as an .lsmat from a current Lens Studio project.

# Creating and Using Built-in Materials

In many cases, you can use the built-in materials to display your content, without worrying about passes. For example, if you just wanted to display an image, without caring about lighting, you can use the built in "Unlit" material. Or, if you want to care about lighting (e.g. on a 3D object), you can use the "PBR" material.

This guide provides instruction on the process of creating and editing basic materials for 3D objects in Lens Studio, as well as an overview of the default material types available in Lens Studio.

When adding default materials, Lens Studio will automatically add the associated shader.

## Adding a Material[​**](#adding-a-material "Copy to clipboard")

There are three ways to add a Material to a Lens Studio project:

* Creating a new Material
* Importing a Material from a FBX file
* Importing a Material from an existing Lens Studio project

The following sections cover each of these methods.

### Creating a New Material[​**](#creating-a-new-material "Copy to clipboard")

You can create a new Material from the `Asset Browser` panel.

First, in the `Asset Browser` panel, click `+`.

Select `Material`, then select a material type (for example, "Diffuse").

[](/img/lens-studio/materials_3d-import-material.webm)

You can create a new Graph Material this way by selecting any material with "Graph" in the name (for example, "Graph PBR").<br /><!-- -->See the [Material Editor guides](/lens-studio/features/graphics/materials/material-editor/welcome-to-material-editor.md) for more information on editing Graph Materials.

### Importing a Material from an FBX File[​**](#importing-a-material-from-an-fbx-file "Copy to clipboard")

When you import a 3D Object (FBX) into your project, any materials included in the FBX definition will be automatically imported as well.

Once your FBX is imported, you should see the Material under your 3D Object in `Asset Browser` panel.

![](/assets/images/materials_materials-3d-import-920fce1ae45d11e845b819b9a0251a61.jpg)

For more information on importing and exporting 3D objects, visit the [3D Object Import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) and [3D Object Export](/lens-studio/assets-pipeline/3d/exporting-content/overview.md) guide.

### Importing a Material from an Existing Lens StudioProject[​**](#importing-a-material-from-an-existing-lens-studioproject "Copy to clipboard")

In the `Asset Browser` panel, select `+ From Files`, or drag the `.lsmat` file into `Asset Browser` panel.

[](/img/lens-studio/materials_import-from-files.webm)

Navigate to the material file from your previous project and select it.

Select `Open`.

You should see the selected Material in your `Asset Browser` panel.

## Material Types[​**](#material-types "Copy to clipboard")

There are a number of default Material types built into Lens Studio.

### Diffuse[​**](#diffuse "Copy to clipboard")

A basic shaded material. It makes use of scene lights to smoothly shade the mesh, and supports environmental maps as well.

![](/assets/images/materials_3d-redfox-diffuse-1f1d035d16eedb7703c103a71a40397b.jpg)

### Unlit[​**](#unlit "Copy to clipboard")

A flat, unshaded material. Supports texture but does not use any lighting information to shade the object.

![](/assets/images/materials_3d-redfox-unlit-d2e2d2c798f12ad8b0a395f9d5936037.jpg)

### Occluder[​**](#occluder "Copy to clipboard")

This material can be applied to an object to occlude, or mask, other objects.

![](/assets/images/materials_3d-redfox-occluder-30d95adb5edfa5f875497b96255ebbfa.jpg)

For more information on how to create your own occluder objects, visit the [Occluder](/lens-studio/features/graphics/materials/occluders.md) guide.

### PBR[​**](#pbr "Copy to clipboard")

This is a physically based rendering material that simulates the way light works in the real world.

![](/assets/images/materials_3d-redfox-pbr-8d5a23c93e4c25cdd6f68cb9db2e05ca.jpg)

To read more about how to set up PBR materials in Lens Studio, please visit the [Substance Texturing](/lens-studio/assets-pipeline/3d/texturing/substance-texturing.md) guide.

### Matte Shadow[​**](#matte-shadow "Copy to clipboard")

This material is applied to objects that receive shadows, and render only as the received shadow. This is useful when you would like to ground other objects in your scene, adding an extra level of realism.

![](/assets/images/materials_Shadow-Plane1-747af4670845d60e6f8e5413985f81c1.jpg)

For more information on how to cast and receive shadows in a Lens, visit the [Light and Shadow](/lens-studio/features/graphics/light-and-shadow.md) guide.

## Default Material Properties[​**](#default-material-properties "Copy to clipboard")

The following breakdown provides information on the properties shared by Lens Studio's materials.

#### Depth Test[​**](#depth-test "Copy to clipboard")

Enables depth-sorting.

#### Depth Write[​**](#depth-write "Copy to clipboard")

Enables writing to the depth buffer.

#### Depth Function[​**](#depth-function "Copy to clipboard")

The comparison method used to sort the depth buffer. Defaults to LessEqual.

#### Two-sided[​**](#two-sided "Copy to clipboard")

Whether the material renders on both sides of a mesh face.

#### Color Mask[​**](#color-mask "Copy to clipboard")

Enables toggling visibility of selected color channel mask of this material

#### Cull Mode[​**](#cull-mode "Copy to clipboard")

Whether the material culls front or back faces, default to back.

#### Blend Mode[​**](#blend-mode "Copy to clipboard")

The material's blend mode. Available options:

* Disabled
* Normal
* Multiply
* Add
* Premultiplied Alpha
* Glass
* Colored Glass
* Alpha Test
* Alpha To Coverage
* Screen
* Min
* Max

#### Polygon Offset[​**](#polygon-offset "Copy to clipboard")

Changes the position that each polygon gets drawn.

#### Frustum Culling[​**](#frustum-culling "Copy to clipboard")

Determines if vertices not on screen would be drawn. Leave as Auto for best performance.

#### Instance Count[​**](#instance-count "Copy to clipboard")

Determines amount of instances of this material being drawn in the scene.

#### Vertex Color[​**](#vertex-color "Copy to clipboard")

Specifies the purpose for which vertex color will be used. Requires vertex color to be supplied by the mesh.

#### Base Color[​**](#base-color "Copy to clipboard")

Specifies the base color (albedo) of the material if the base texture is disabled. Multiplied with the base texture otherwise.

#### Base Texture[​**](#base-texture "Copy to clipboard")

The texture used as a color (albedo) source.

|                |                                                      |
| -------------- | ---------------------------------------------------- |
| **Texture**    | The texture used as a color (albedo) source.         |
| **Texture UV** | Specifies the UV set used for sampling this texture. |

#### Opacity Texture[​**](#opacity-texture "Copy to clipboard")

Enables use of a separate texture as the alpha source for blending. If disabled, the Base Color's alpha channel is used for opacity.

|                |                                                      |
| -------------- | ---------------------------------------------------- |
| **Texture**    | The texture used as an opacity source.               |
| **Texture UV** | Specifies the UV set used for sampling this texture. |

#### Recolor[​**](#recolor "Copy to clipboard")

Allows recolor of the material by channel.

#### Detail Map[​**](#detail-map "Copy to clipboard")

Add a secondary texture that overlays on top of the main textures

|                |                                                      |
| -------------- | ---------------------------------------------------- |
| **Texture**    | The texture used for detail map.                     |
| **Texture UV** | Specifies the UV set used for sampling this texture. |

#### Detail Mask[​**](#detail-mask "Copy to clipboard")

Controls opacity of the detail map.

|                |                                                      |
| -------------- | ---------------------------------------------------- |
| **Texture**    | The texture used for detail mask.                    |
| **Texture UV** | Specifies the UV set used for sampling this texture. |

#### Normal Map[​**](#normal-map "Copy to clipboard")

Enables the normal map texture and normal mapping.

|                |                                                      |
| -------------- | ---------------------------------------------------- |
| **Texture**    | The texture used as a normal source.                 |
| **Texture UV** | Specifies the UV set used for sampling this texture. |

#### Emissive[​**](#emissive "Copy to clipboard")

Enables the emissive texture.

|                |                                                      |
| -------------- | ---------------------------------------------------- |
| **Texture**    | The texture used as an emissive color source.        |
| **Texture UV** | Specifies the UV set used for sampling this texture. |
| **Color**      | The color of the emissive.                           |
| **Intensity**  | Multiplies the existing emissive color.              |

#### Simple Reflection[​**](#simple-reflection "Copy to clipboard")

Replaces the default PBR environment mapping with a simple lookup from a regular texture (no hdr, no roughness, no fresnel, etc.). It can even be used with unlit materials. The reflection lookup technically assumes a spherical environment map, which is a circular shaped texture.

|                    |                                                |
| ------------------ | ---------------------------------------------- |
| **Texture**        | The texture to use as a reflection map.        |
| **Intensity**      | The strength of the reflection effect.         |
| **Modulation Map** | Modulates reflections based on a texture input |

#### Rim Highlight[​**](#rim-highlight "Copy to clipboard")

Enables rim highlighting, aka Fresnel.

|                       |                                                                  |
| --------------------- | ---------------------------------------------------------------- |
| **Color**             | Specifies the color of the rim highlight.                        |
| **Intensity**         | Factor multiplied with Color.                                    |
| **Exponent**          | Controls the tightness of the rim highlight.                     |
| **Invert**            | Allows inverse of the rim highlight.                             |
| **Rim Color Texture** | Allows the use of a texture to modulate the rim highlight color. |

#### Lighting[​**](#lighting "Copy to clipboard")

Enables direct and indirect (ambient) lighting. Disabling this creates an unlit (flat) shader.

|                        |                                                                                                                                                                                                                      |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Diffuse**            | Enables direct and indirect diffuse lighting. Can be disabled as an optimization on pure metals.                                                                                                                     |
| **Specular**           | Enables direct and indirect specular lighting (specular highlights and reflections), disabling this would produce a material only lit diffusely.                                                                     |
| **Metallic**           | 1 means metal, 0 means non-metal. Multiplies the metallic (R) channel of the Materials Params texture if enabled.                                                                                                    |
| **Roughness**          | 1 means completely rough, 0 means smooth and shinny. Multiplies the roughness (G) channel of the Materials Params texture if enabled. If roughness is 1 and metallic is 0, it is more efficient to disable Specular. |
| **Material Params**    | Texture input with special colored channels, R - metallic, G - smoothness, B - ambient occlusion                                                                                                                     |
| **Camera Reflections** | Use the live camera feed as the source of environment map, this replaces users' environment map. Adjust its Roughness for blurring of the envmap.                                                                    |
| **Specular AO**        | Allows AO to influence indirect specular lighting (reflections)                                                                                                                                                      |
| **Baked Shadows**      | Will use the baked shadow texture to shadow one or more light                                                                                                                                                        |

#### Fizzle[​**](#fizzle "Copy to clipboard")

Allows the material to fizzle in and out based on a noise function, driven by the Transition parameter, 0 is fully visible and 1 fully invisible.

|                |                                   |
| -------------- | --------------------------------- |
| **Transition** | The strength of the Fizzle effect |

#### Tone Mapping[​**](#tone-mapping "Copy to clipboard")

Normally all materials are rendered with HDR tone mapping enabled so they fit into the 3D scene correctly, however, for some uses like UI elements or materials specific blend modes, you might want to turn off tone mapping.

#### Transformed UV[​**](#transformed-uv "Copy to clipboard")

Allows Tiling and Animation of textures, be sure to set the Texture UV to the correct Transformed UV accordingly.

For more information on creating textures such as Material Params, visit the [Texturing](https://lensstudio.snapchat.com/guides/3d/texturing/photoshop-texturing/) guide.

## Vertex Color Material[​**](#vertex-color-material "Copy to clipboard")

If your model has vertex color information that you'd like to use as the base color of its material, you can create a custom material that does so in a few steps.

Create a new Material.

[](/img/lens-studio/materials_vertexcolor-create-material.webm)

On the new Material, disable the `Base Texture` property, set `Vertex Color` property to `Base Color`.

[](/img/lens-studio/materials_vertexcolor-enable-vertex-color.webm)
