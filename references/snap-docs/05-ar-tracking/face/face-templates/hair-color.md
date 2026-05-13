# Hair Color

The Hair Color sample project enables you to create a Lens that recolors the user's hair. The project includes a controller that you can modify to quickly change the hair color effect. Available customizations include selection of primary and secondary colors, as well as which part of the hair is recolored (Roots, Ends, or Full Head). You can find the sample project in the [homescreen](/lens-studio/lens-studio-workflow/lens-studio-interface/home.md) of Lens Studio.

To make it easier for you to mix-and-match our different examples, this sample project has also been converted to an importable asset in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) with the name `Hair Color`. Find the asset in the Asset Library and import it into your existing project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the Asset Library.

## Guide[​**](#guide "Copy to clipboard")

To get started, first select the `Hair Color` object found in the Scene Hierarchy panel. Find `Hair Color Custom Component` and adjust settings in the Inspector panel.

### Changing the Render Order[​**](#changing-the-render-order "Copy to clipboard")

You can modify the Render Order of the hair color effect to make it appear above or below other objects. Learn more about [Render Order](/lens-studio/lens-studio-workflow/lens-studio-interface/panels.md#render-order)

### Customizing the Base Color[​**](#customizing-the-base-color "Copy to clipboard")

You can change the base color applied to the user's hair by modifying the color property labeled `Base Color`.

![](/assets/images/hair-color-base-color-c6335763b880b004e88cda386dbacda7.png)

### Changing the Color Mode[​**](#changing-the-color-mode "Copy to clipboard")

You can change which part of the hair is recolored by changing the `Mode` property.

![](/assets/images/hair-color-mode-991d87fb130fcd1dbefe9c9e20767fc6.png)

Available hair color modes are:

* **Roots** - Applies the hair coloring only to the roots (top) of the user's hair
* **Ends** - Applies the hair coloring only to the ends (bottom) of the user's hair
* **Full Head** - Applies the hair coloring to the entire length of the user's hair

If you're using the Full Head mode, you can change the direction of the linear gradient formed by the `Base Color` and `Secondary Color`. To change the gradient, you can modify the property named `Gradient Mode`.

![](/assets/images/hair-color-gradient-mode-61229741e30756314f59007a9c5eeca4.png)

Available Gradient Modes for Full Head are:

* **Ombre** - a vertical gradient
* **Split** - a horizontal gradient

### Adding an Additional Color[​**](#adding-an-additional-color "Copy to clipboard")

To apply an additional color to the user's hair, enable the property named Second Color.

![](/assets/images/hair-color-second-color-99a500fefdf0b920fd6b55b3d70cd381.png)

You can now edit the Secondary color by modifying the color property labeled `Secondary Color`.

You can swap the Base Color and Secondary Color by enabling the property named `Swap Colors`.

### Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You're now ready to preview your Face Lens. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
