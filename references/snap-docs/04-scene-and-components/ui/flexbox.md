# FlexBox Layout

A frequent case when working on UIs is the need to layout content along an axis, for example, a menu of buttons in a list. This doesn’t need to be many elements either; often it's useful even with two elements to have them positioned based on each other. The Asset Library contains three Custom Components to help manage this: Horizontal Layout, Vertical Layout, and Layout Element. The Horizontal and Vertical Layout Components work by positioning all the Layout Elements on child Scene Objects into the space allotted to the Layout Component by driving the properties of their ScreenTransform.

![FlexBox Layout](/assets/images/flexbox-layout-5-af94e5a23c2da53156e6f6260666fd69.png)

These components will resolve the final sizes of elements using an established algorithm called "FlexBox." This originally comes from CSS but is used across many UI frameworks. This means that outside of these docs, there are many resources available on how to use FlexBox layouts in powerful ways.

## How to Set It Up[​**](#how-to-set-it-up "Copy to clipboard")

The Horizontal and Vertical Layout Components have some requirements for their hierarchy:

* The Layout Component should be added to a scene object with Screen Transform.
* It should be a child of an Orthographic Camera or Canvas Component (We call this a valid ScreenTransform hierarchy).
* All elements of the layout should be direct children of the SceneObject with the Layout Component and should have a LayoutElement Component.

An example of setting up a Vertical Layout in the `Inspector`. [Try the project here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/5-0/FlexboxMenuExample5.0.zip).

![Vertical Layout](/assets/images/flexbox-layout-4-a2669494e932fcdeb7d81a37f761fc16.png)

```
// -----JS CODE-----
//@input Component.Camera uiCam
//@input Asset.Material backgroundMat

var DestructionHelper = require('./Destruction Helper Module');

var helper = new DestructionHelper(script);

function createObj(parent) {
  var obj = helper.createSceneObject(parent);
  obj.layer = script.uiCam.renderLayer;
  helper.createComponent(obj, 'Component.ScreenTransform');
  return obj;
}

var UIButton = requireType('./UI Button');
var VerticalLayout = requireType('./Vertical Layout');
var LayoutElement = requireType('Layout Element');

var regionObj = createObj(script.uiCam.getSceneObject());

var region = helper.createComponent(
  regionObj,
  'Component.ScreenRegionComponent'
);
region.region = ScreenRegionType.SafeRender;

var backgroundObj = createObj(regionObj);
backgroundObj.getComponent('Component.ScreenTransform').anchors = Rect.create(
  -0.8,
  0.8,
  -0.9,
  0.9
);
var background = helper.createComponent(backgroundObj, 'Component.Image');
background.mainMaterial = script.backgroundMat;
background.setRenderOrder(-1);
background.stretchMode = StretchMode.Stretch;

var extentsTargetObj = createObj(backgroundObj);
background.extentsTarget = extentsTargetObj.getComponent(
  'Component.ScreenTransform'
);

var layoutObj = createObj(extentsTargetObj);
var layout = helper.createComponent(layoutObj, VerticalLayout);
layout.alignment = 1;

function createSpacer() {
  var obj = createObj(layoutObj);
  var element = helper.createComponent(obj, LayoutElement);
  element.requestedSize = new vec2(0, 0);
  element.minimumSize = new vec2(0, 0);
  element.maximumSize = new vec2(0, 0);
  element.growWeight = 1;
}

function createButton(text, onClick) {
  var obj = createObj(layoutObj);
  var element = helper.createComponent(obj, LayoutElement);
  //Only requested size matters since grow/shrink weights are 0
  element.requestedSize = new vec2(240, 80);
  element.growWeight = 0;
  element.shrinkWeight = 0;
  element.margins = Rect.create(0, 0, 8, 8);
  var button = helper.createComponent(obj, UIButton);
  button.changeAnimationType('Squish');
  button.changeStateValue('normal', 'Color', new vec4(1, 1, 0, 1));
  button.changeStateValue('pressed', 'Color', new vec4(0.5, 0.5, 0.2, 1));
  var buttonText = button.getTextComponent();
  buttonText.text = text;
  buttonText.font = null;
  buttonText.size = 40;
  buttonText.horizontalOverflow = HorizontalOverflow.Shrink;
  button.onPress.add(onClick);
  return button;
}

createSpacer();

createButton('Option One', function () {
  print('Option One clicked');
});

createButton('Option Two', function () {
  print('Option Two clicked');
});

createButton('Option Three', function () {
  print('Option Three clicked');
});

createSpacer();
```

Show more▼

This script builds the same menu as the screenshot above. You can [try the project here](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/5-0/FleboxMenuFromScript5.0.zip).

## Configuring the layout[​**](#configuring-the-layout "Copy to clipboard")

### Horizontal & Vertical Layout[​**](#horizontal--vertical-layout "Copy to clipboard")

#### Alignment[​**](#alignment "Copy to clipboard")

Where on the "cross-axis" content should be placed. For example for the Vertical Layout this determines whether content should be placed on the left, center, or right of the available space once their size is resolved

[](/img/lens-studio/flexbox-layout-0.webm)

#### Direction[​**](#direction "Copy to clipboard")

Which direction on the "main-axis" content should be placed on. For example for the Vertical Layout this is top to bottom or bottom to top

[](/img/lens-studio/flexbox-layout-1.webm)

#### Padding[​**](#padding "Copy to clipboard")

This allows reserving some space on the interior edge of the layout to stay empty. Content will be laid out into the remaining space.

[](/img/lens-studio/flexbox-layout-2.webm)

#### Grow Weight / Shrink Weight / Margins[​**](#grow-weight--shrink-weight--margins "Copy to clipboard")

The Horizontal and Vertical Layout Components are also Layout Elements, meaning they can be nested as children of other layouts. These properties are to control their behavior in that case and you can find more details in the Layout Element section.

#### Overrides[​**](#overrides "Copy to clipboard")

The Horizontal and Vertical Layout Components have a series of settings to allow overriding the properties of their child Layout Elements. If you enable one of these overrides, then the value for that property on children will be ignored and instead used from here. For more details on what each property means see the Layout Element section.

### Layout Element[​**](#layout-element "Copy to clipboard")

Many of the properties of Layout Element are "sizes". The context for these sizes depends on the Camera being used to render them. If it is an Orthographic Camera, it will be the units configured by the Canvas Component on that Camera. This is Pixels, Points, or World Units. For more details see [Pixel Accurate Rendering](https://developers.snap.com/lens-studio/lens-studio-workflow/scene-set-up/2d/pixel-accurate-rendering). For a perspective Camera and Canvas in world space, these sizes are in cm.

#### Requested Size[​**](#requested-size "Copy to clipboard")

The size that this element would ideally be. The element will start at this size before distributing any extra space or doing any necessary shrinking. In css this is "flex-basis".

#### Minimum Size[​**](#minimum-size "Copy to clipboard")

The minimum size that this element can shrink to. The layout won’t make it smaller than this and will shrink other elements instead or allow the layout’s size to overflow if all elements are at their minimum size. In css this corresponds to "min-height" and “min-width”.

#### Maximum Size[​**](#maximum-size "Copy to clipboard")

The maximum size that this element can grow to. The layout won’t grow it any further than this and will either distribute the size to other elements or leave the space empty. A value of 0 indicates no maximum size. In css this corresponds to "max-height" and “max-width”.

#### Grow Weight[​**](#grow-weight "Copy to clipboard")

Determines how much of the extra space this element will receive. When the layout has extra space it will sum the grow weights of all of the elements and distribute the space according to their portion of the total weight. This means an element with grow weight 2 will grow twice as much as an element with grow weight 1. An element with grow weight 0 will never grow beyond its requested size. In css this is "flex-grow".

#### Shrink Weight[​**](#shrink-weight "Copy to clipboard")

Determines how much this element will shrink when the available size is less than the total requested sizes. When the layout needs to shrink it will sum the shrink weights of all of the elements and shrink them according to their portion of the total weight. This means an element with shrink weight 2 will shrink twice as much as an element with shrink weight 1. An element with shrink weight 0 will never shrink below its requested size. In css this is "flex-shrink".

#### Margins[​**](#margins "Copy to clipboard")

Margins are space this element reserves around itself to be empty. The content will only be inside the margins and they are a constant size that is unaffected by grow and shrink weights.

[](/img/lens-studio/flexbox-layout-3.webm)

## Writing your own Layouts and Layout Elements[​**](#writing-your-own-layouts-and-layout-elements "Copy to clipboard")

Layout, and especially Layout Element, are patterns that are intended to be extended with new Custom Components in the future both by Snap and by creators for their own projects. You may want to have a Custom Component function as a Layout Element so that the properties described above can be calculated dynamically instead of explicitly defining them. For example both Vertical and Horizontal Layout are also Layout Elements which calculate requested, min, and max size based on the properties of the elements they contain.

To be a valid Layout Element, Custom Components should conform to the following interface:

* Implement a function \_isOfType(type) to return true for "LayoutElement"

* Implement the following "getter" functions

  * `getRequestedSize()` which returns a vec2
  * `getMinimumSize()` which returns a vec2
  * `getMaximumSize()` which returns a vec2
  * `getGrowWeight()` which returns a Number
  * `getShrinkWeight()` which returns a Number
  * `getMargins()` which returns a Rect

* Implement management of "dirty" state

  * Implement a function `isDirty()` which returns true if the element is marked "dirty"
  * Implement a function `markClean()` which sets "dirty" = false
  * Implement a function `markDirty()` which sets "dirty" = true
  * You would also want to set "dirty" = true anytime some state of the Layout Element changes in a way that would cause it to report different values for the “getter” functions above.

You could also write a custom Layout class which used all the properties of Layout Element to do layout in some other way. These don’t necessarily need to conform to any interface, but to make sure they work nested inside of the main layouts you should do a couple things to make sure child layouts resolve before parent ones.

* Implement a function `_isOfType(type)` to return true for "Container"

* Implement a function `runLayout()` which resolves the layout

## Outside Reference[​**](#outside-reference "Copy to clipboard")

As mentioned before, these Layout and Layout Element Custom Components are based on an established algorithm "FlexBox". Not every part of FlexBox makes sense in Lens Studio or is supported there, but there are many other applicable resources for learning how to use these powerful tools. Some valuable ones are:

* [mdn web docs](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Flexbox)

* [w3 standards docs](https://www.w3.org/TR/css-flexbox-1/)

* [Yoga playground](https://yogalayout.com/playground/?eyJ3aWR0aCI6NTAwLCJoZWlnaHQiOjUwMCwibWluV2lkdGgiOm51bGwsIm1pbkhlaWdodCI6bnVsbCwibWF4V2lkdGgiOm51bGwsIm1heEhlaWdodCI6bnVsbCwiYWxpZ25JdGVtcyI6MSwicGFkZGluZyI6eyJ0b3AiOiIyMCIsInJpZ2h0IjoiMjAiLCJib3R0b20iOiIyMCIsImxlZnQiOiIyMCJ9LCJwb3NpdGlvbiI6eyJ0b3AiOm51bGwsInJpZ2h0IjpudWxsLCJib3R0b20iOm51bGwsImxlZnQiOm51bGx9LCJjaGlsZHJlbiI6W3sid2lkdGgiOjEwMCwiaGVpZ2h0IjoxMDAsIm1pbldpZHRoIjpudWxsLCJtaW5IZWlnaHQiOm51bGwsIm1heFdpZHRoIjpudWxsLCJtYXhIZWlnaHQiOm51bGwsInBvc2l0aW9uIjp7InRvcCI6bnVsbCwicmlnaHQiOm51bGwsImJvdHRvbSI6bnVsbCwibGVmdCI6bnVsbH19LHsid2lkdGgiOjEwMCwiaGVpZ2h0IjoxMDAsIm1pbldpZHRoIjpudWxsLCJtaW5IZWlnaHQiOm51bGwsIm1heFdpZHRoIjpudWxsLCJtYXhIZWlnaHQiOm51bGwsIm1hcmdpbiI6eyJyaWdodCI6IjIwIiwibGVmdCI6IjIwIn0sInBvc2l0aW9uIjp7InRvcCI6bnVsbCwicmlnaHQiOm51bGwsImJvdHRvbSI6bnVsbCwibGVmdCI6bnVsbH0sImZsZXhHcm93IjoiMSJ9LHsid2lkdGgiOjEwMCwiaGVpZ2h0IjoxMDAsIm1pbldpZHRoIjpudWxsLCJtaW5IZWlnaHQiOm51bGwsIm1heFdpZHRoIjpudWxsLCJtYXhIZWlnaHQiOm51bGwsInBvc2l0aW9uIjp7InRvcCI6bnVsbCwicmlnaHQiOm51bGwsImJvdHRvbSI6bnVsbCwibGVmdCI6bnVsbH19XX0=) for experimenting

* [A guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
