# Native Keyboard

Keyboard in lenses is available through enabling a `Editable` checkbox on a `Text` ot `Text3D` components.

![alt text](/assets/images/native-keyboard-2-efa623a4a3562002602cc8bf748a4df2.png)

**Editable:** if enabled text can be edited with keyboard. If enabled simple tapping on the text would activate the keyboard.

**Show Editing Preview:** if enabled shows text editing field at the top of the keyboard.

**Touch Handler:** optional parameter that allows to override the touch area used to activate keyboard by specifying another object with Interaction component attached.

## Examples[​**](#examples "Copy to clipboard")

Next come several examples that cover some of most common use cases.

`Scripting Keyboard`, `2D Editable Text` and `3D Editable Text` examples covered in this guide are available in Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import them into your project and follow instructions in the object prefab name.

![](/assets/images/native-keyboard-0-35b40c58541d0d37a6d1c86c4e0e9b9a.png)

Right-click on imported packages and select `Unpack for Editing` to customize the included scripts.

### 3D Editable Text[​**](#3d-editable-text "Copy to clipboard")

This example is the simplest setup you would need to make text editable. It contains a Text3D object with `Editable` checkbox enabled.

![](/assets/images/native-keyboard-8-5d5b0c8dbf349d63407fc43bdf5f1a1a.png)

![](/assets/images/native-keyboard-9-1da5a062054045dad657640613443f31.png)

### 2D Editable Text[​**](#2d-editable-text "Copy to clipboard")

This example demonstrates how to use an alternative interaction component to open the keyboard. In this case we will allow to tap on button image to edit text.

![](/assets/images/native-keyboard-4-8c7b087010c61be55c530ed343a4aec9.png)

The Image component requires an Interaction component and is set as a Touch Handler input of the Text component we want to edit.

![](/assets/images/native-keyboard-5-4f99ae7c31b4aee490f592a39a90ec5c.png)

In addition there is a `Keyboard State Button` script which provides an example of how to respond to keyboard events in scripting and update visuals in your lens.

![](/assets/images/native-keyboard-7-37fef1d84b1031954a280c456e8181eb.png)

Please notice when using Screen Text you may configure Safe Render [Screen Region](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-region-device-simulation.md) to resize with keyboard.

![](/assets/images/native-keyboard-6-eee0c5d0c63c262cb6adccebcb1c9fdd.png)

### Scripting Keyboard[​**](#scripting-keyboard "Copy to clipboard")

Scripting Keyboard example demonstrates how to trigger the keyboard entirely via scripting. You can reference the script `Scripting Keyboard Example` which uses the `TextInputSystem` to trigger the keyboard and create Text3D components based on the inputted text.

![Image showcasing the scripting keyboard hierarchy](/assets/images/native-keyboard-1-041cfacd3cca8eb8f913a08cedae8fe6.png)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/previewing-your-lens.md) guide.
