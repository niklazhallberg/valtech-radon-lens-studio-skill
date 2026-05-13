# Compression

Since Lenses are designed to work on mobile devices, it is important that they are optimized to have a small footprint so that it can be downloaded quickly by users as well as run on a variety of devices.

In order to make it easier for you to pack richer content into your Lens, Lens Studio comes with a built-in compression system.

## Texture Compression[​**](#texture-compression "Copy to clipboard")

When importing your assets into Lens Studio, Lens Studio automatically compresses 2D assets such as images and animated textures.

You can select the resource in the `Asset Browser` panel and modify it’s compression settings in the `Inspector` panel.

![](/assets/images/2d-compression-2-87f933f9c62f733bd1fdcae7f6e9814f.png)

By default compression will be optimized for `performance`. This setting will help the Lens load faster as well as lower the RAM usage when possible.

![](/assets/images/2d-compression-3-d705b7b153c06d9a3e55c2f77804d1b8.png)

You can change the level of compression that is performed on your asset by clicking on the `Level` dropdown.

![](/assets/images/2d-compression-4-2faffc93fb414fb530a4b197982a5370.png)

You may also choose to optimize for `size`. This setting allows you to trade off the quality of the texture for a reduction in Lens size, which will enable the Lens to download faster.

![](/assets/images/compression_compression-5-4d9eb19a4b194e92e3893af9290493f5.png)

Currently Texture Compression is available for PNGs and animated textures. In addition, small textures are skipped.

See more tip about optimizing your Lens in the [optimization guide](/lens-studio/publishing/optimization/performance-optimization-guide.md)
