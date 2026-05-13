# PBR (Lighting) Node Overview

In this guide we will focus on **PBR (Lighting)** node and show you what each input and output does. If the content you are creating doesn't need lighting, a **Graph Unlit** Material (to connect the color result straight into the **Shader 3D** node) will better serve the purpose instead of using PBR.

## Guide[​**](#guide "Copy to clipboard")

In **Lens Studio** you can find the **Material Editor** window under Window > Panels > Material Editor, if it's not already shown in your layout.

![](/assets/images/pbr-lighting-overview_pbr-1-a80693fe45ff16c6005d2c3112167bf7.png)

Create a **Graph PBR** material by going to the `Asset Browser panel > + > Graph PBR`. Double click to select it, then check the **Material Editor** panel. You will see that **Graph PBR** comes with a **PBR (Lighting)** node at the end. PBR means physically based rendering, which refers to the concept of achieving photorealism to provide a more accurate interpretation of how light interacts with a mesh surface.

Hitting tab on the keyboard will give you a node search menu. You can scroll through the entire list or simply type in few words to quickly jump to the one desired:

[](/img/lens-studio/pbr-lighting-overview_pbr-2.webm)

## Properties[​**](#properties "Copy to clipboard")

### Albedo.rgb[​**](#albedorgb "Copy to clipboard")

Vector3 value with each channel ranging from `0` to `1`. Defines the overall color of the material. This parameter represents the base color of the mesh's surface.

### Opacity.x[​**](#opacityx "Copy to clipboard")

Single value controlling the transparency level for the material. The expected range is from`0` to `1`, `0` being transparent and `1` being fully opaque.

If the material `Blend Mode` is set to `Disabled` in the `Inspector` panel of the material, alpha value will not be taken into calculations.

![](/assets/images/pbr-lighting-overview_pbrg_04-ac060ffd8844aaac904d8d6d1ee550cc.jpg)

### **Normal.rbg**[​**](#normalrbg "Copy to clipboard")

Vector3 value controlling the normal direction ranging from `-1` to `1`. It's used to modify the surface normals across the mesh based on vector direction which can add additional details to the mesh.

### **Emissive.rgb**[​**](#emissivergb "Copy to clipboard")

Vector3 value defining emission color, which means self-illumination. This value will be added to the resulting output color regardless of lighting.

### **Metallic.x**[​**](#metallicx "Copy to clipboard")

Single value controlling how metallic the material is. The value ranges from `0` to `1`, `0` being non-metallic and `1` being metallic. When the metallic level is higher, it means the mesh surface reflects more and its albedo color becomes less visible. When the number is set to `1`, the surface color will be fully driven by the specular reflections.

![](/assets/images/pbr-lighting-overview_pbrg_05-a884594443107519c0068846a440eda7.jpg)

### **Roughness.x**[​**](#roughnessx "Copy to clipboard")

Single value with an expected range `0` to `1`, representing how blurry or sharp a specular reflection is. This controls the amount that light is diffused when it bounces off the mash surface. Rougher surfaces are less reflective and have broader specular highlights. Bear in mind that the specular reflectivity response of the mesh surface is modified by both Metallic and Roughness.

![](/assets/images/pbr-lighting-overview_pbrg_06-6fb6d035adb428991d5a0400fc2b2c93.jpg)

### **AO.rgb**[​**](#aorgb "Copy to clipboard")

Vector3 value representing ambient occlusion. Usually the same input feeds to all RGB channels, and a self created AO mask is typically made to match what is shown in the albedo texture.

### **Specular AO.rgb**[​**](#specular-aorgb "Copy to clipboard")

Vector3 value for specular ambient occlusion. Both AO and Specular AO are typically used when using textures packed by third party software, otherwise both can be left as white.

If you click on the **PBR (Lighting)** node, a preview window will show up on the right side of the **Material Editor**. If nothing is connected to the **PBR (Lighting)** node, you can adjust color and values under Settings. To connect textures input you can create materials with varieties of Opacity, Metallic, Roughness or AO levels across the mesh surface.

[](/img/lens-studio/pbr-lighting-overview_pbr-3.webm)

### Color.rgba[​**](#colorrgba "Copy to clipboard")

Vector4 value (RGBA), final output of the PBR workflow result. This can be connected directly to your **Shader (3D)** node's **Color (Pixel).rgba** input.
