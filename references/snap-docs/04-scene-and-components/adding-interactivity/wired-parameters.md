# Wired Parameters

The Wired Parameters Custom Component enables users to establish connections between different object properties within their projects. By linking these properties, any adjustment made to one property will automatically trigger a corresponding change in the other linked property. This component supports connections between various types of properties, including Transform, Components, and Assets.

## Usage[​**](#usage "Copy to clipboard")

To add the Wired Parameters to your project, go to the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md) and find the Wired Parameters in the Custom Components section.

![](/assets/images/wired-parameters-0-13a6c9815e5a7f6ccdc3a600f8a7c888.jpg)

Once you click the Install button, you can add it to an object as a component.

When you attach the component to an object, a warning appears indicating that the input is empty.

## Design[​**](#design "Copy to clipboard")

Wired Parameters links object properties using `Input` and `Output` modes in the Inspector panel. In Input mode, a value is clamped between an `Input Start Value` and an `Input End Value`. This value is then processed using selected `Interpolation`, and if linear interpolation (`lerp`) is enabled, it is further smoothed. The interpolated value is then remapped from the defined `From` and `To` range values in Output mode before being applied to the output property.

If you’d like to have multiple outputs for a single input, simply duplicate the component and configure different output settings while keeping the input settings the same.

## Inputs[​**](#inputs "Copy to clipboard")

![](/assets/images/wired-parameters-1-744ca86c79e256cb0d85b03f847b5981.jpg)

* Input Mode

  <!-- -->

  * Transform

    <!-- -->

    * **Transform** (input SceneObject whose Transform you’d like to get)
    * **Property** (World/Local Position/Scale/Rotation)
    * Axis (X/Y/X)

  * Asset

    <!-- -->

    * **Asset** (any Asset, such as Material, VFX Asset, Texture etc.)
    * **Property Name** (if you’d like to change material’s color, you need to write a color property name + color’s channel. **E.g. baseColor.r**)

  * Component

    <!-- -->

    * **Component** (you can also input a ScriptComponent and enter its API property)
    * **Property Name** (e.g., input a Light Source Component and add `intensity` property name or input a Text Component and enter `textFill.color.a` property)

  * Body Tracking Landmark

    <!-- -->

    * **Landmark** (Body Landmarks map can be found [here](https://developers.snap.com/lens-studio/references/templates/object/body/3d-body-tracking#character-requirements))
    * Property
    * Axis

  * Head Tracking Landmark

    <!-- -->

    * Face Index
    * **Landmark Index** (Face Landmarks map can be found [here](https://developers.snap.com/lens-studio/references/templates/face/face-landmarks#points-mode))
    * Axis

  * Distance Between Scene Objects

    <!-- -->

    * Object
    * Object

  * Absolute Rotation (how much the object is rotated in absolute terms, given a weighted influence of the coefficients.)

    <!-- -->

    * Object
    * Coefficients

  * Blendshape (make sure the Render Mesh you input has Blend Shapes.)

    <!-- -->

    * Mesh
    * Blendshape Name

  * Face Expression

    <!-- -->

    * **Face Mesh** - input a Render Mesh Visual with a Face Mesh. You can add it to the scene using “+” in the scene hierarchy panel and find “Face Mesh”. If you’d like to change face index, you can do so in Face Mesh Asset’s Inspector panel
    * Expression

  * Distance Body Mesh (distance between 2 body’s landmarks. Body Landmarks map can be found [here](https://developers.snap.com/lens-studio/references/templates/object/body/3d-body-tracking#character-requirements))

    <!-- -->

    * Landmark From
    * Landmark To

* **Input Start Value** - the beginning of the range in which the input value should change

* **Input End Value** - the end of the range in which the input value should change

* **Interpolation** - interpolation from input value to output value.

* **Lerp** - additional linearly interpolation from actual output value to new calculated value

* **Lerp Coefficient** - lerp interpolation fraction (where Lerp Coefficient = 0.0 returns an output value, and Lerp Coefficient = 1.0 returns a new calculated value)

* Output Mode

  <!-- -->

  * Transform

    <!-- -->

    * **Transform** (input SceneObject whose Transform you’d like to modify)

    * Property

    * Transform Value

    * **Axis** (select if you’d like to change only one axis of the selected transform property. If you’d like to change all three axes, select Vec3)

      <!-- -->

      * Axis
      * From
      * To

    * Vec3

      <!-- -->

      * From
      * To

  * Asset

    <!-- -->

    * Asset
    * **Property Name** (if you’d like to change material’s color, you need to write color property name + color’s channel. **E.g. baseColor.r**)
    * Type
    * From
    * To

  * Component

    <!-- -->

    * Component
    * **Property Name** (e.g., input a Light Source Component and add `intensity` property name or input a Text Component and type `textFill.color.a` property)
    * Type
    * From
    * To

  * Blendshape

    <!-- -->

    * Mesh
    * Blendshape Name
    * From
    * To

  * Atlas

    <!-- -->

    * **Texture** (input only animated texture)
    * **Yoyo** (turn on if you want the animation to alternate between playing forward and backward)
    * Start Frame
    * End Frame

  * Animation Weight

    <!-- -->

    * Animation Mixer
    * Layer Name
    * Weight From
    * Weight Tog
