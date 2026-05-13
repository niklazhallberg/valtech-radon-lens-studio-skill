# Makeup

The `2D Makeup Helper` Asset allows you to create a Lens with different makeup styles. You can add lip tint and gloss, blush, eyeliner, eyeshadow, mascara, and eyebrow coloring. No external assets are necessary.

## Guide[​**](#guide "Copy to clipboard")

Find the `2D Makeup Helper` assets in the Asset Library and import them into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#scripts-and-packages) to learn more about how to use assets in the Asset Library.

## 2D Makeup Helper Package[​**](#2d-makeup-helper-package "Copy to clipboard")

Once you import the asset from Asset Library, you can find the package in the Asset Browser.

![](/assets/images/makeup-import-package-ab48ac0d4f9e7b2f731d57226d9d24b1.png "2D Makeup Import")

Follow the instructions and drag the prefab `Makeup__PLACE_IN_OBJECTS_PANEL` into Scene Hierarchy to create a new Scene Object.

[](/img/lens-studio/5-features/makeup-drag-prefab.webm)

You can right-click and select `Unpack for Editing` from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

![](/assets/images/makeup-unpack-package-0c27328dd7411585299a20d6a8652594.png "2D Makeup Unpack Package")

### The Makeup Controller[​**](#the-makeup-controller "Copy to clipboard")

The asset allows you to mix and match different effects to create your personalized makeup. These options are set in the `Makeup Controller` object. Most effects provide similar options such as: enable or disable, color, and intensity. Take a look at the sections below for additional information on each effect.

### Customizing Lips[​**](#customizing-lips "Copy to clipboard")

The asset provides two different types of lip coloring that you can use separately or combine together to add makeup to the user's lips:

* Lips tint - matte coverage
* Lip gloss - shiny texture

You can enable or disable lip effects by clicking on the checkbox next to the effects’ name.

![](/assets/images/makeup-lips-setup-e6a5b9f9cbb7756a90d8e2a391fa0a7f.png "Lips Setup")

To change an effect’s color, click the colored box next to `Color`. Then, use the color picker to customize the color’s value. You can also change the strength of the effect with the `Intensity` slider. A value of `0` would make the effect invisible, and a value of `1` would make it fully visible.

You can additionally customize the blend mode that is used to apply the lips effect. To do this, select the corresponding face mask object in the `Scene Hierarchy` panel and find its `Blend Mode` property in Inspector. Good blend modes for lip coloring are `Soft Light` or `Multiply`.

![](/assets/images/makeup-lips-blendmode-350423ea0e59af5d835ee696757381af.png "Lips blendmode")

You can do the same for the lip gloss effect. Good blend modes for a shiny effect and highlight texture are `Screen` or `Add`.

### Customizing blush[​**](#customizing-blush "Copy to clipboard")

Like the lips effect, you can enable or disable blush by clicking on the checkbox next to the effect's name. The blush effect also has the same color and intensity option as the lips effect.

![](/assets/images/makeup-blush-setup-1a2b9435399f52a44661cc39d0773c26.png "Blush Setup")

Similarly, you can change the blend mode used to apply the blush. First select the `Blush` face mask object in `Scene Hierarchy` panel. Then find its `Blend Mode` property in Inspector.

![](/assets/images/makeup-blush-blendmode-ad7cc4dfe3bb47f075c7fef4051664f8.png "Blush blendmode")

### Customizing eyeliner[​**](#customizing-eyeliner "Copy to clipboard")

Try playing with the `Eyeliner` properties. You can adjust the eyeliner’s color and intensity in the same way as in the previous examples.

![](/assets/images/makeup-eyeliner-setup-da7a3ed2c752a8f5a1496fd680b14c87.png "Eyeliner setup")

To change the effects blend mode, select the `Eyeliner` face mask object in `Scene Hierarchy` panel. Find its `Blend Mode` property in Inspector.

There are a number of blend modes that will help you to create various styles for eyeliner. Try `Hard Light`, `Vivid Light` looks great with bright colors. `Multiply` can be used for darker or less intense colors.

![](/assets/images/makeup-eyeliner-blendmode-a059b4b69071ec657354d0dac1729860.png "Eyeliner blendmode")

### Customizing eyeshadows[​**](#customizing-eyeshadows "Copy to clipboard")

In addition to the color and intensity properties, there are four types of eyeshadows to choose from.

* Single color - one color that covers the upper eyelid

* Two colors - a blend of two colors that covers the upper eyelid, plus highlights the inner part of the eyelid

* Single color heavy - one color that covers both the upper and lower eyelids

* Two colors heavy - a blend of two colors that covers the upper and lower eyelid, plus highlights the inner part of the eyelid

You can change the blend mode of these effects by looking for the Eyeshadows face masks in the `Scene Hierarchy` panel. All three of them are used in different combinations to make a certain effect. You can experiment a lot with blend modes here. Try: `Overlay`, `Multiply`, `Screen`, `Add`, `Soft Light`, `Hard Light`, etc.

![](/assets/images/makeup-eyeshadows-blendmode-3d0229870a5e1d244cd23f657131dead.png "Eyeshadows blendmode")

### Customizing eyelashes[​**](#customizing-eyelashes "Copy to clipboard")

Like the previous effects, you can enable or disable the `Mascara` effect, as well as change its color and intensity.

![](/assets/images/makeup-mascara-setup-065b6ff39c877a24c0f46f924f5a0b9e.png "Mascara setup")

To change the blend mode select `Mascara` face mask object in `Scene Hierarchy` panel. Find its `Blend Mode` property in the Inspector panel. As with the eyeliner effect, try experimenting with different ones!

![](/assets/images/makeup-mascara-blendmode-f9c1be2d115a1c677bc9c7be2cf9d258.png "Mascara blendmode")

### Customizing eyebrows[​**](#customizing-eyebrows "Copy to clipboard")

Similarly, try modifying the color and intensity of the `Eyebrows` as before.

![](/assets/images/makeup-eyebrows-setup-26c98c5e68d8cf2960413e7f073946a1.png "Eyebrows setup")

To change the blend mode select `Eyebrows` face mask object in the `Scene Hierarchy` panel. Find its `Blend Mode` property in Inspector. Try `Add` or `Overlay` if you want to go for crazy fun colors.

![](/assets/images/makeup-eyebrows-blendmode-23aca694a147c6f27b8d6223c7f32ba8.png "Eyebrows blendmode")

### Working with Two Faces[​**](#working-with-two-faces "Copy to clipboard")

By default, the asset comes with one Makeup Controllers. Duplicate the asset to make identical copies.

#### Changing face index[​**](#changing-face-index "Copy to clipboard")

You can change the face for which the makeup is applied to by changing the face Index dropdown of either `Makeup Controller`.

![](/assets/images/makeup-face-index-8b5d487f66026f53ff7484de87f50514.png "Face index")

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens. To preview your lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
