# Eye Color

The `Eye Color` effect allows you to change the color of the user's eyes. It also allows you to create subtle eye reflections with the more advanced `Texture` mode.

## Create the Eye Color[​**](#create-the-eye-color "Copy to clipboard")

To create an `Eye Color` object, first click the `+` button in the `Objects` panel. Then, select `Face -> Eye Color`.

![](/assets/images/add-eye-color-8a5c1e1840e7d04183423f79cf0f2a9c.png)

## Visualize the Eye Color[​**](#visualize-the-eye-color "Copy to clipboard")

The `Eye Color` object is a 2D object. **Double-clicking** an object with the `Eye Color` component automatically opens the `Eye Color Editor` panel to visualize the effects.

![](/assets/images/eye-color-editor-c18e067e1d9bed514c435f02ad27074e.png)

## Eye Color Settings[​**](#eye-color-settings "Copy to clipboard")

In the `Objects` panel, select your newly created `Eye Color` object. You'll see a number of settings configurable in the `Inspector` panel.

![](/assets/images/eye-color-settings-fa24024823514cc58bc24e75d4c678cf.png)

* **Main Material** - The material which changes the eye color. Click on the `settings` icon to open the material inline editor.

  <!-- -->

  * **Blend Mode** - Using blend modes beyond `Normal` helps the texture blend more naturally with the eyes.
  * **Alpha** - Allows you to tune the strength of the eye coloring. Often, we dial back the alpha of an `Eye Color` object so it blends more naturally with eyes.

* **Face Index** - Which face the object will apply to. The first face in the scene is 0; the second face in the scene is 1.

* **Eye To Render** - Allows you to select which eye you want to apply the effect to. If both, select `Both Eyes`.

Press `Open Full Inspector` on the inline material editor to modify additional material settings, like the color of the eye. ![](/assets/images/eye-color-color-20cdf5314abe4083bf7025ffce38f5a3.png)
