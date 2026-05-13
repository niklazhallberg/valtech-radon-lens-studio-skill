# Faceless ML

The **Faceless ML Face** and **Faceless ML Nose** Components allow you to hide the user's face/nose.

## Using the Faceless Face/Nose[​**](#using-the-faceless-facenose "Copy to clipboard")

To add the Faceless ML Component to your Lens, go to the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and find the `Faceless ML Face` in the `Custom Components` section.

![](/assets/images/ml-faceless-1-e61c0352fc387144394ce36f41e24ac8.png)

Once you click the `Install` button, you can find this component in the `Asset Browser` and add it to your resources to build the Lens.

Create an Orthographic Camera with a Full Frame Region and a child scene object with a Screen Transform component. Add the Faceless ML Face/Nose component to the scene object with the Screen Transform component.

![](/assets/images/ml-faceless-2-21a43752c8ad2f3c66f0f4104f60f037.png)

### Component Inputs[​**](#component-inputs "Copy to clipboard")

Both Components have the same inputs:

**Input texture** – Render target texture, which will be used as an input texture, on which the Faceless ML will be applied. (Default: Device Camera Texture).

**Face index** - The index of the face on which Faceless ML will be applied.

**Render order** – Order in which the custom component will be rendered.

The first face has index 0, the second face has index 1 and so on.
