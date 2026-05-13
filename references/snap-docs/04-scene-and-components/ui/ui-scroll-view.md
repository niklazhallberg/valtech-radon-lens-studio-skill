# UI Scroll View

## UI Scroll View[​**](#ui-scroll-view "Copy to clipboard")

The UI Scroll View is a [Custom Component](/lens-studio/features/scripting/script-components.md) introduced in Lens Studio 4.49 that allows you to scroll one screen transform within the bounds of another. The UI Scroll View can be used when content that takes up a lot of space needs to be displayed in a small area. Some examples of this may include a map, a long block of text or a long list of items.

[](/img/lens-studio/masking-component-7.webm)

It leverages the [Masking component](/lens-studio/lens-studio-workflow/scene-set-up/2d/masking-component.md) to clip content visuals to a scroll view screen transform.

### Installation[​**](#installation "Copy to clipboard")

The UI Scroll View custom component can be found in Lens Studio [Asset Library](/lens-studio/lens-studio-workflow/scene-set-up/2d/masking-component.md)

In the Asset Library, type in UI Scroll View in the **Search** field of Asset Library, navigate to the UI Scroll View asset and click **Install**.

![](/assets/images/masking-component-0-7efcfa118843d846a5b349f5aea390b2.png)

### Adding To Scene[​**](#adding-to-scene "Copy to clipboard")

The UI Scroll View component works with [Screen Transforms](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) and has to be added to either Orthographic Camera or Canvas hierarchy.

1. In the `Scene Hierarchy` panel, Click `+` to add a new object and select `Screen Transform`.
2. Rename the newly created Scene Transform object to `My Scroll View`.
3. With the Scene Transform object selected, left click on the `Add Component` button in the `Inspector` panel and select `Scroll View`

![](/assets/images/masking-component-13-d380da1fe2878d81f2ec2fa3c352d70b.png)

Next, you will need an object that will scroll. In this guide, you will use a Screen Text object.

4. With the `My Scroll View` scene object selected add new `Screen Text` in the `Scene Hierarchy` panel,

![](data:image/png;base64,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)

5. Set newly created Screen Text object to the `Content` input field in the UI Scroll View custom component, by clicking on the Scene Text object and dragging to the `Content` input field.

![](/assets/images/masking-component-9-011fb2ceeee670db47a658c13d29eb36.png)

Lastly, you will make your Content rectangle bigger than the UI Scroll View rectangle and set the UI Scroll view to wrap the text.

6. Click and drag screen transform handles for the content in the 2D Editor (Window->Editors->2D Editor) view to a larger rectangle.
7. To verify it's working properly, set text field of Text component to a much longer set of text.
8. In the `Inspector` Panel, click on the UI Set Horizontal Overflow to `Wrap`

![](/assets/images/masking-component-8-8a4e95c1effbc27fca1c7ed2c2fc56ce.png)

Once you have your set up ready as shown on the image below you should be able to interact with UI Scroll View component in the `Preview` panel.

![](/assets/images/masking-component-12-773ce8bb302f9ea015529da33304a176.png)

Parent all objects you need to mask under the Content object and make sure its Screen Transform rectangle fits all the children visuals.

### Customizing Settings[​**](#customizing-settings "Copy to clipboard")

UI Scroll View comes up with a set of options. Select Scene Object with the UI Scroll View custom component added and check them out in the `Inspector` panel:

![](/assets/images/masking-component-15-917534aabefdc0791f3d496291437c54.png)

**Content:** A content scene object to scroll

* Has to be a child of a UI Scroll View object
* Its rectangle to be bigger than UI Scroll View rectangle

**Use mask:** Creates Masking Component to occlude mesh visuals parented to the Content Scene object within the bounds of a UI Scroll View rectangle.

* **Radius:** Set mask radius

**Horizontal:** Allows to scroll horizontally.

**Vertical:** Allows to scroll vertically.

[](/img/lens-studio/masking-component-2.webm)

**Scroll Type:** Specifies a scrolling type:

* **Restricted:** Allows to drag Content screen transform strictly within the UI Scroll rectangle
* **Elastic:** Allows to scroll content out of bounds, but it will bounce back on touch end.
* **Elasticity:** Allows to set a coefficient for elastic movement. The larger value is, the slower screen transform snaps in place

[](/img/lens-studio/masking-component-5.webm)

* **Inertia:** Allows to add inertia to movement, that helps with scrolling of large content.
  <!-- -->
  * **Dampening:** Specifies how fast the inertia movement dampens, a multiplier that applies to residual velocity on each frame.

**Scroll Bars**

Scroll bars can be used to visualize the relative position of the content rectangle as well as provide additional ways to manipulate content.

* **Horizontal:** Enable horizontal scroll bar.
* **Vertical:** Enabled vertical scroll bar.
* **Scroll Bar Width:** Allows you to set the size of the scroll bars. The unit used depends on the setting of the parent Canvas component.
* **Scroll Bar Material:** Allows to override default scroll bar material.

Use the 9 Slicing material from the Asset Library or a 9-slicing subgraph node in Material Editor

This custom component is editable, right click to unpack and see it’s contents.

### Scripting Api[​**](#scripting-api "Copy to clipboard")

UI Scroll View custom component can also be created or configured from script, For example:

```
//@typename ScrollView
//@input SceneObject scrollViewObject
//@input Component.ScreenTransform content

var scrollView = script.scrollViewObject.createComponent(script.ScrollView);
scrollView.content = script.content;

scrollView.dragX = true;
scrollView.dragY = false;

scrollView.scrollType = scrollView.ScrollType.Elastic;
scrollView.scrollBarType = scrollView.ScrollBarType.OnScroll;

scrollView.enableHorizontalScrollBar = true;

scrollView.enableVerticalScrollBar = false;
```
