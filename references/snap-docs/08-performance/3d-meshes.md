# 3D Optimization

This feature in Lens Studio can be found under the `Inspector` panel while a mesh is selected under the `Resource` panel.

![](/assets/images/3d-compression-4-fe2c56d0068d27a09c3e99762b2ebda8.png)

## Overview[​**](#overview "Copy to clipboard")

In many cases 3D assets created using photogrammetry tools, or marketing assets are used which were created for offline rendering. Both of these approaches provide high poly meshes which require a lot of memory. If you ever find yourself making a Lens with a heavy mesh which results in a Lens size that is too large, or poorly performing on device, adjusting a mesh vertex attributes help optimize your Lens.

![](/assets/images/vertex-attribute_vag_03-46f2524bcecf089d73364aa9ce4ace13.jpg)

## Packed 3D Assets[​**](#packed-3d-assets "Copy to clipboard")

When you import a 3D assets into Lens Studio, the mesh is compressed based on the `Package Default` settings.

![](/assets/images/3d-compression-1-8e0f4ac1f3c158bc43b55cb7a0fc8ec5.png)

You can turn off this compression by pressing the `Compression Override` drop down and selecting `None`.

![](/assets/images/3d-compression-2-01893869e12de230d9be98253aa0f99b.png)

## Unpacking 3D Assets[​**](#unpacking-3d-assets "Copy to clipboard")

You can unpack 3D assets to have more compression options.

![](/assets/images/3d-compression-3-bab88117e25510d0bbb08911f0b99750.png)

Once you unpack a 3D Assets, you can not update the assets based on the source as easily, as you'll be unpacking the 3D assets to Lens Studio native assets. Though, you can reimport or relink.

## Vertex Attributes[​**](#vertex-attributes "Copy to clipboard")

One way comperssion is done is by reducing the size of the information contained in each vertex of the 3D mesh.

Vertex attributes can be packed into fewer or even just in one position attribute in a 3rd party software, later unpack and utilized in Lens Studio. In this case all other attributes can be disabled.

To do this, let's look at the `Compression Settings` section in the `Inspector` panel, attributes available here are related to how the mesh was saved in the software used to create the mesh.

![](/assets/images/3d-compression-4-fe2c56d0068d27a09c3e99762b2ebda8.png)

There are several component types available.

* **Byte:** 8 bits.
* **Short:** 16 bits.
* **Unsigned:** unsigned integer \[0, MAX].
* **Signed:** signed integer \[-MAX, MAX].
* **Integer normalization:** remaps integer byte or short attributes to fixed point values in the range \[0.0, 1.0]\(unsigned) or \[-1.0, 1.0]\(signed) using the rough math “normalizedValue = unnormalizedValue / MAX”. Values outside this range are clamped to the min/max.

### Format Conversions[​**](#format-conversions "Copy to clipboard")

Select the drop down next to the attribute to change how its information is stored.

![](/assets/images/3d-compression-5-92f029aa608a4a9e244b47d3fe363497.png)

* **Byte - Signed:** Signed 8-bit, two's complement integer with a range of -128 to 127.
* **Byte - Unsigned:** Unsigned 8-bit integer with a range of 0 to 255.
* **Byte - SNorm:** Signed 8-bit normalized fixed point value with a range of -1.0 to 1.0.
* **Byte - UNorm:** Unsigned 8-bit normalized fixed point value with a range of 0.0 to 1.0.
* **Short - Signed:** Signed 16-bit, two's complement integer with a range of -32,768 to 32,767.
* **Short - Unsigned:** Unsigned 16-bit integer with a range of 0 to 65,535.
* **Short - SNorm:** Signed 16-bit normalized fixed point value with a range of -1.0 to 1.0.
* **Short - UNorm:** Unsigned 16-bit normalized fixed point value with a range of 0.0 to 1.0.
* **Half Float:** 16-bit half precision floating point value, often called “half” or “float16”.
* **Float:** 32-bit single precision floating point value.
* **Disable:** Disable vertex attribute. This option is not provided for vertex position.

### Attribute Setting Recommendations[​**](#attribute-setting-recommendations "Copy to clipboard")

In most cases, the smaller the attribute data is the better. Below are some examples for different format users can try:

* **Position:** Float, Half Float, or try to rearrange your model data so that all positions are within a \[-1, 1] range, in that case SNorm can be introduced.
* **Normal:** Normalized vectors are on the range \[-1, 1], SNorm is recommended.
* **Tangent:** If a normal map is not used, tangent can be disabled.
* **Bitangent:** If a normal map is not used, bitangent can be disabled.
* **Color:** In most cases negative colors are not frequently used, 8-bits Byte - UNorm is recommended, if HDR colors are needed, try Half Float.
* **Texture0:** In most cases, texture coordinates can be stored as SNorm or UNorm, however when using Repeated wrap mode with UV, the texture coordinates are out of range \[-1, 1], we recommend using Half Float with cases like that.

In other words, you want to use as little data per vertex while still keeping the accuracy of your mesh. In doing so, you will reduce the size of your entire mesh!

## Draco[​**](#draco "Copy to clipboard")

Although decimation/simplification methods could be applied for hi-res meshes, however all automatic methods can’t reduce polycount to actual low poly values while keeping good details. Draco compression comes in handy when working with relatively limited lens sizes, compression could be 10x smaller compared to the original which allows you putting more meshes into a single lens.

To enable Draco compression, select `Draco` under the `Compression Type`.

![](/assets/images/3d-compression-6-91ad757f64f7d0058d546d160cf6aa72.png)

Then, toggle the `Enable Draco Compression` checkbox.

![](/assets/images/3d-compression-7-061f0ad51786e80bc8f7cc57d78fb5b0.png)

* **Compression Level:** Range of 0 to 10, the higher level, the higher compression ratio and the lower decompression speed.
* **Position, Texcoord, Normal, Color Bits:** Range of 1 to 30, the larger bits, the more precise.
