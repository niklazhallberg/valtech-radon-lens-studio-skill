# Masking

One of the essential tools necessary to build robust and cohesive UI interfaces is masking. Masking in this case refers to the ability to display one visual object only within the bounds of another.

[](/img/lens-studio/masking-component-1.webm)

Since [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) is the basis for building UI elements in Lens Studio, the Masking Component is designed to work with them and allows to mask any visuals or interactions to the bounds of Screen Transform it is attached to.

Please refer to the guides on [Touch Interactions for Screen Transforms](/lens-studio/features/scripting/touch-input.md#interactions-for-screen-transforms) and [Depth Filtering](/lens-studio/features/scripting/touch-input.md#depth-filtering)

## Masking Component[​**](#masking-component "Copy to clipboard")

Masking Component can be added to the scene through the `Scene Hierarchy` panel by clicking the `+` button and selecting `Masking`. This way adds a corresponding Screen Transform hierarchy to your scene

![](/assets/images/masking-component-10-a23bd4be6bf17dab642202cf5a84f64f.png)

Or by clicking on the `Add Component` button in the Inspector panel with a Scene Object selected.

![](/assets/images/masking-component-14-c57cc29ea6c7ba00f0d7ca58e243ba2f.png)

Masking Component requires a ScreenTransform to be attached to the Scene Object in order for effect to apply.

Currently, there is a known bug with masking interactions. This will be addressed in an upcomming Lens Studio release.

### Visual Masking[​**](#visual-masking "Copy to clipboard")

Let’s add a couple visuals - for example Screen Images or Screen Text and place them under the Masking object parent. As you can see from the example below - the image is visually clipped as it extends beyond the masking bounds.

[](/img/lens-studio/masking-component-1.webm)

Masking depends on stencil buffer usage, it may conflict with any other features that depend on the stencil buffer

### Nesting Masks[​**](#nesting-masks "Copy to clipboard")

Masks can be nested in the scene hierarchy, so a child mask will be masked by its parent mask. There is a maximum of 8 masks per camera. Masks function correctly regardless of render order.

[](/img/lens-studio/masking-component-4.webm)

### Corner Radius[​**](#corner-radius "Copy to clipboard")

While custom image mask is not supported the Corner Radius property allows you to create appealing and cohesive UI elements

[](/img/lens-studio/masking-component-3.webm)

Check out the [UI Scroll View](/lens-studio/features/ui/ui-scroll-view.md) custom component for usage example.
