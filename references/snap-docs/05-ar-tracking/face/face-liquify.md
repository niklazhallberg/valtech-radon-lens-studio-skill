# Face Liquify

The `Face Liquify` effect spherically warps the face. You are able to configure how big and how intense the effect is. The `Face Liquify` object is perfect for making funny or exaggerated faces.

## Create the Liquify[​**](#create-the-liquify "Copy to clipboard")

To create a `Face Liquify` object, first click the `+` button in the `Scene Hierarchy` panel. Then, select `Face Liquify`.

![](/assets/images/face-liquify-add-c16f9b57dcc0c13bee31432a28dd6d3c.png)

## Adjust the Liquify[​**](#adjust-the-liquify "Copy to clipboard")

You can double click the newly added `Face Liquify` object to open its corresponding `Face Liquify Editor` panel.

![](/assets/images/face-liquify-panel-428e8885a4c9a684bd6de70dc96382d5.png)

Adding a new Face Liquify object automatically adds a pair of symmetric liquify points. With the Face Liquify object selected, you'll see two circle widgets in the `Face Liquify Editor` panel which represents the two newly added liquify points. When you select an object in the `Scene Hierarchy` panel, it will be selected in this panel.

The circle is the area of influence for the `Face Liquify` warp effect. Position the circle to where you want the effect applied to the face.

[](/img/lens-studio/5-essential/face-liquify-edit.webm)

You can select multiple effects by pressing `shift` on the keyboard, while selecting multiple objects in the `Scene Hierarchy` panel

[](/img/lens-studio/5-essential/face-liquify-multi.webm)

You can enable the `Isolate Selection` button which will disable editing of any other points except for the currently selected one.

If you check the `Symmetrical Mode` button, any selected objects will move symetrically along vertical axis.

[](/img/lens-studio/5-essential/face-liquify-symmetry.webm)

You can add a liquify point by using the `+` button at the top left of the panel, or through the `Scene Hierarchy` panel.

## Liquify Settings[​**](#liquify-settings "Copy to clipboard")

Each `Liquify Point` object has two settings that can be configured in the `Inspector` panel. Select the `Liquify Point` object by expanding the `Face Liquify` object parent and selecting one of the children objects.

![](/assets/images/face-liquify_Face-Liquify-3-b4828fb69e2cb7e0b841bb3bc50ac475.png)

* **Radius:** How large the circle of influence is
* **Intensity:** The strength of the warp effect. Note, a coefficient that's less than 1 will warp inwards like a black hole

Alternatively, you can also configure the radius and intensity of the selected liquify points (highlighted in blue) in the 2D Scene view under the 2D editor.
