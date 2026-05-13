# Sub-Graph Library

This page list out Sub-Graph Library presets in alphabetical order. You can find these sub-graphs under **Sub-Graph Library** section of the `Add Node` menu. You can open this menu by hitting `tab` on your keyboard while in the Material Editor.

![](/assets/images/sub-graph-library_sgg_05-22cb52c0f02fe62750f36a3b661a0c93.png)

These sub-graphs are also available in the [VFX Editor](/lens-studio/features/graphics/particles/vfx-editor/introduction-and-concepts.md).

## Library[​**](#library "Copy to clipboard")

### 3D Rotation[​**](#3d-rotation "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_3d_rotation.png)

Rotates a 3D mesh when given its surface position. Note that this graph will transform input surface space data into object vector(space) and export as world vector.

### 3D Wave[​**](#3d-wave "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_3d_wave.png)

Takes a `Surface Position` and displaces vertices according to a sine wave. The direction of the wave is controlled with the `Wave Axis`, and the amount the vertices are moved in each dimension is controlled by `Displacement Amount`. The number of waves is controlled by `Frequency`, and how fast they are animated is controlled by `Speed.`

### 9 Slicing[​**](#9-slicing "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_9_slicing_5-0.png)

9-slice scaling (also known as Scale 9 grid, 9-patch or 9-slicing) is a 2D image resizing technique to proportionally scale an image by splitting it in a grid of nine parts.

### Attack/Decay[​**](#attackdecay "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_vfxsgg37.png)

Creates an Attack/Decay envelope similar to musical instrument controllers. `Attack` is the amount of time it takes to reach from an amplitude of 0 to max value. `Decay` is the amount of time it takes for it to decrease from max amplitude to the value. `Control Value` is expected to be within the range of 0-1.

### Angle Gradient[​**](#angle-gradient "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_angle_gradient.png)

Draws a circular gradient from `Color A` to `Color B` in direction given `Rotate Degree` to the center line. `Rotate Degree` input can go negative if users adjust the `Float Import` Min limitation under the `Sub-Graph`.

### Bloom[​**](#bloom "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_bloom.png)

Useful for Post Effect graphs. The lower the Resolution, the lesser step you will get. `Blur Size` offsets the steps, tweak `Threshold` and `Intensity` for desired results.

### Brightness/Contrast[​**](#brightnesscontrast "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_brightness_contrast.png)

`Brightness` adjusts the lightness of the overall image, `Saturation` toggles the intensity of the color, `Contrast` controls difference in brightness between subjects. Increasing the `Contrast` value will brighten the light areas and darken the rest.

### Camera Distance Fade[​**](#camera-distance-fade "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_vfxsgg38.png)

Computes a value that will fade “in” (1.0) or “out” (0.0) when a particle is a given distance from the camera. When the particle reaches the `Fade In Distance`, the value becomes 1.0, and when the particle reaches the `Fade Out Distance`, it becomes 0.0. This is useful for controlling particle attributes such as alpha or size. Default values are useful for fading particles out when they are close to the camera.

### Cartesian to Polar[​**](#cartesian-to-polar "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_cartesian_to_polar.png)

Converts from Cartesian coordinates (x,y) to Polar coordinates (r,θ).

### Cartesian to Spherical[​**](#cartesian-to-spherical "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_vfxsgg39.png)

Converts from Cartesian (x,y,z) to Spherical (r,θ,φ) coordinates.

### Color Ramp Sample[​**](#color-ramp-sample "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_vfxsgg40.png)

Sample 1D Ramp texture with X coordinate exposed.

### Checkerboard[​**](#checkerboard "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_checkerboard_5-0.png)

Generates a checkerboard of alternating colors between inputs Color A and Color B based on input UV.

### Chroma Mask[​**](#chroma-mask "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_chroma_mask.png)

By giving a desired image/color input, this `Sub-Graph` keys out `Selected Color` with `Threshold` and `Slope` controls, outputting a black and white mask.

### Color Replacement[​**](#color-replacement "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_color_replacement.png)

It replaces values from `Color to Replace` with `New Color.` Simply plug in Input, and tweak `Range` and `Threshold` for better results.

### Depth Distance Fade[​**](#depth-distance-fade "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_depth_distance_fade_5-0.png)

Fades pixels as they get close to other objects in the scene. This sub-graph is useful for softly fading particle effects such as smoke and fire.

### Diamond Gradient[​**](#diamond-gradient "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_diamond_gradient.png)

Transition of `Color A` to `Color B` along a direction of increasing distance to the center. Creates a diamond shape gradient with controls of offsets and scale. If a non stretched result is preferred, rescale the `Scale` value according to the resolution.

### Directional blur[​**](#directional-blur "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_directional_blur.png)

Post Effect graph, applies directional blur on to an input texture. Angle goes from 0 to 360 degrees.

### Distortion[​**](#distortion "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_distortion.png)

Post Effect graph, distorts `Background Texture` with given `Noise Texture.` `Time` can be animated by script or just simply plug in an `Elapsed Time` node.

### Edge Detection[​**](#edge-detection "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_edge_detection.png)

Post Effect graph, this graph identifies the boundaries of objects within the given texture. Width changes the thickness of the lines. Adjust Contrast and Brightness for fine adjustments.

### Flipbook Blend[​**](#flipbook-blend "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_flipbook_blend_5-0.png)

Blends a Flipbook animation between the current frame and the next frame.

### Flipbook Motion Vector Blend[​**](#flipbook-motion-vector-blend "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_flipbook_motion_vectors_blend_5-0.png)

Blends a Flipbook animation between the current frame and the next frame from a motion vector map.

### Gaussian Blur[​**](#gaussian-blur "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_gaussian_blur_03.png)

Post Effect graph, a simple gaussian kernel to reduce image noise and detail. `Blur Factor` settings can be adjusted to control the blur amount. For this subgraph to work, `Pixel Size` and `TexCoords` has to be connected as well as `Mipmaps` is enabled in the Material setting for this sub-graph to make it work properly.

You can enable `Expose Size Out` in the `Texture 2D Object Parameter` node and connect it to the Gaussian Blur's `Pixel Size` , as well as `TexCoords` to `Screen UV coords`. Take a look at the image below for an example.

![](/assets/images/sub-graph-library_sgg_09-8f290513f5307668b50f2814e792167d.jpg)

### Hue Saturation[​**](#hue-saturation "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_hue_saturation_5-0.png)

Lets you adjust the hue, saturation, and lightness of the overall image.

### Linear Gradient[​**](#linear-gradient "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_linear_gradient.png)

Creates a linear gradient transition from `Color A` to `Color B` along a line from `Point A` to `Point B`. The bigger the `Scale`, the shaper the gradient becomes. If a non stretched result is preferred, rescale the `Scale` value according to the resolution.

### Matcap Reflection[​**](#matcap-reflection "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_matcap_reflection_5-0.png)

Matcap reflections are a cheap way of doing reflection. The reflection is created by sampling from a spherical texture instead of actual scene data. This technique is also sometimes referred to as material capture ("MatCap") reflection. The reference texture only stores one side of a sphere.

### Normalize to AABB[​**](#normalize-to-aabb "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_normalize_to_aabb_5-0.png)

Normalizes the input value to the render mesh's AABB.

### Parabola[​**](#parabola "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_vfxsgg42.png)

Computes a parabola where `Input` is the point along the X axis of the curve, and `Exponent` is the slope of the curve, with higher values causing sharper peaks. This is useful to create a customizable up and down ramp from a linear value such as particle age ratio (0-1) or a uv coordinate axis.

### Pixel Fog[​**](#pixel-fog "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_pixel_fog_5-0.png)

Applies simple z-depth fog to the `Input Color`. `Falloff` is an exponent on the near/far gradient, and `Intensity` is a multiplier on this gradient.

### Polar to Cartesian[​**](#polar-to-cartesian "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_polar_to_cartesian.png)

Converts from Polar coordinates (r,θ) to Cartesian (x,y) coordinates.

### Polar Coordinates[​**](#polar-coordinates "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_polar_coordinates_5-0.png)

Converts Cartesian UV Coordinates to Polar coordinates (r,θ).

The most common use case is a quad with bottom left UV coordinates of (0,0) and upper right coordinates of (1,1). In this case, the UV coordinates will be used to generate circular coordinates around the center (0.5, 0.5) of the quad. You can easily test this subgraph on a Plane or Image object.

### Position from Depth[​**](#position-from-depth "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_position_from_depth_5-0.png)

Gets position from depth. Uses UV coordinates (usually screen UV) and depth input to get camera space coordinates and transform them to a world space position.

### Quad Gradient[​**](#quad-gradient "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_quad_gradient.png)

Useful for Post Effect graphs, assigns each quad corner a different color.

### Radial Gradient[​**](#radial-gradient "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_radial_gradient.png)

Useful for Post Effect graphs, transitions from `Inner Color` to `Outer Color` along a direction of increasing distance to the `Center Offset` point. `Inner Radius` controls the size of the circle. The lower the `Softness` value the sharper the results will become. If you prefer a non stretched result, rescale the `Scale` value according to the resolution.

### Reflected Gradient[​**](#reflected-gradient "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_reflected_gradient.png)

Useful for Post Effect graphs. Creates a transition from `Outer Color` to `Inner Color`and back to `Outer Color`.`Point A` defines where the `Inner Color` starts, `Point B` defines where the `Inner Color` ends.

### Rotate Arbitrary Axis[​**](#rotate-arbitrary-axis "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_rotate_arbitrary_axis_5-0.png)

Returns a 4x4 matrix that rotates a point around a given axis by amount `Angle` (radians).

### Scroll 4 Way[​**](#scroll-4-way "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_scroll_4_way_5-0.png)

Scroll coordinates over time in 4 different directions with optional rotation. This sub-graph is useful for creating animated noise from a single input texture.

### Shape[​**](#shape "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_shape.png)

Useful for Post Effect graphs, this `Sub-Graph` draws a shape based on given `Sides` and `Softness` value. Users can adjust `Scale` accordingly to match aspect ratio.

If using input values for `Sides`, note that the step default is set to 1.0, but the minimum value should be 3.0.

### Simple Reflection[​**](#simple-reflection "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_simple_reflection_5-0.png)

Creates a simple and cheaply computed reflection using a sampling texture instead of actual scene data. The reflection lookup assumes a spherical environment map, which is a circular shaped texture.

### Spherical to Cartesian[​**](#spherical-to-cartesian "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_vfxsgg46.png)

Converts from Spherical (r,θ,φ) to Cartesian (x,y,z) coordinates.

### Triplanar Noise[​**](#triplanar-noise "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_triplaner_noise2.png)

This sub-graph maps Noise (Simplex) without using UV coordinates. This method doesn't rely on UVs so it can be applied to any mesh. By default, optimization is set to use only 2 samples instead of 3.

### Tile Randomizer[​**](#tile-randomizer "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_tile_randomizer_5-0.png)

This sub-graph randomizes the visual repetition of seamless tiled textures.

### Triplanar Texture[​**](#triplanar-texture "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_triplaner_texture.png)

This sub-graph maps an input `Texture` without relying on UV coordinates. It comes in handy when users are working with a mesh that doesn't contain UV information. By default, optimization is set to use only 2 samples instead of 3.

### UV Circle[​**](#uv-circle "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_uv_circle_5-0.png)

Generates a simple radial gradient by using Surface UVs (UV Coord 0).

### UV Circle Normal[​**](#uv-circle-normal "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_uv_circle_normal_5-0.png)

Generates a hemispherical normal using the Surface UVs (UV Coord 0).

### Waveform Saw[​**](#waveform-saw "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_waveform_saw.png)

Generates a saw waveform. `Speed` is controlled by an `Elapsed Time` node inside of the `Sub-Graph`, setting to 0 will turn off the animation.

### Waveform Sine Cosine[​**](#waveform-sine-cosine "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_waveform_sine_cosine.png)

This Graph contains both `Sine` and `Cosine` calculations. Users can double click on the `Sub-Graph` node to dive in and simply connect the Output node to Sine or Cosine, the default is set to Sine. `Speed` is controlled by an `Elapsed Time` node, setting `Speed` to 0 will turn off the animation.

### Zoom Blur[​**](#zoom-blur "Copy to clipboard")

![](/img/lens-studio/sub-graph-library_sgg_zoom_blur.png)

Similar to Post Effect Radial Blur, creates a radial blur effect. The closer `Inner Radius` is to `Outer Radius` the sharper the result looks. `Radial Center` controls the offset, the higher the `Strength` value the more stepped the result becomes.
