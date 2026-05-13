# Screen Transform Properties

Screen Transform allows you to make sure your screen objects adapt to various screen sizes. This guide goes over some of the options the component provides.

### Properties[​**](#properties "Copy to clipboard")

In order to be placed correctly Screen Transform objects need to be a child of either another Screen Transform or an Orthographic Camera. As you set up a Screen Transform, it is being set up relatively to its parent. So if its parent is another Screen Transform, it is tuned against the size of that parent Screen Transform.

Each ScreenTransform is represented with:

* Anchors
* Offsets
* Pivot Position
* Basic Transform

![](/assets/images/screen-transform-properties_Screen-Transform-Advanced-Tab-f6e6cd35dc0cf6ba2ddacd1e19f85143.png)

**Anchors** (or Bounds) (Left, Right, Bottom, Top) represent positions of each edge of the rectangle in coordinates relative to the parent Screen Transform.

***Anchors.left:*** the normalized position of the left edge in the parent ScreenTransform, where -1 represents anchoring to the left edge of the parent and 1 - to right.

***Anchors.right:*** anchoring of the right edge, where -1 represents anchoring to the left edge of the parent and 1 - to right.

***Anchors.bottom:*** anchoring of the bottom edge, where -1 represents anchoring to the bottom edge of the parent and 1 - to the top.

***Anchors.top:*** anchoring of the top edge, where -1 represents anchoring to the bottom edge of the parent and 1 - to the top.

![](data:image/png;base64,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)

**Offsets** **(paddings)** represent offsets of rectangle edges from the Anchors rectangle.

***Offsets.left:*** offset from the left anchor

***Offsets.right:*** offset from the right anchor.

\*\*\*Offsets.bottom:\*\*\*offset from the bottom anchor

***Offsets.top:*** offset from the top anchor

*Offsets are measured in world units while anchors are measured in relative units*

### Anchors and Offsets visualization[​**](#anchors-and-offsets-visualization "Copy to clipboard")

On the picture below can see how Anchors and offsets change affected by parent ScreenTransform:

White rectangle represents parent, yellow - rectangle calculated from anchors, green - rectangle - after offsets are applied. We can see how the child rectangle changes with the change of the parent :  anchors are affected by the parent while offsets stay the same.

[](/img/lens-studio/screen-transform-properties_Screen-Transform-Offsets-and-Bounds.webm)

**Pivot Position :** represents a point inside a ScreenTransform rectangle it is rotated around. This point is defined as a relative position in this rectangle, where (0, 0) is the center, (-1, 1) bottom left corner and (1, 1) top right corner of this rectangle.

[](/img/lens-studio/screen-transform-properties_Screen-Transform-Pivot.webm)

**Basic Transform**:

* **Position:** is a local position of the Screen Transform pivot in the local space of parent.  If you are reading the value, you are just learning where the pivot ended up being placed, if you are writing it via setting ScreenTransform.position you are actually modifying the offsets so that pivot ends up in the requested spot. (The expected use case for this is small animations in the UI, like a button pulsing to draw attention to it.)
* **Rotation:** represents local rotation of the Screen Transform. Often for Screen Transform rotation, the only axis that makes sense to rotate is around the Z.
* **Scale:** represents the local scale of the Screen Transform. It doesn’t affect anchors or paddings and is applied after rectangle is calculated from it’s Anchors and Offsets

**Screen Transform position on the screen is being calculated in several steps**:

* First the Anchors rectangle is calculated based on a parent screen Transform (or ScreenRegion)
* Then Offsets are applied to this rectangle
* After this basic transform is applied (rotation and scale)
* Also the Image Component has its own stretch mode and alignments. They are applied inside of the calculated ScreenTransform rectangle
