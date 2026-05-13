# Working with Multiple Faces

Lens Studio supports the creation of Face Lenses that can be applied to multiple faces. You can apply a Face Effect in your Lens to multiple faces by modifying the effect’s `Face Index` property. This guide will cover how to apply a variety effects to more than one face.

## Face Mask[​**](#face-mask "Copy to clipboard")

To apply Face Mask to multiple faces, you can duplicate the object containing the Face Mask component and change its `Face Index`. To create a Face Mask, follow the [Face Mask](/lens-studio/features/ar-tracking/face/face-mask.md) guide.

In the `Scene Hierarchy` panel, you can right click the object containing your Face Substitution component and select `Duplicate`. You can then increment the `Face Index` field in the duplicated object’s `Face Substitution` component.

Face Index are zero-indexed, meaning your first head will be 0 and your second head 1.

[](/img/lens-studio/5-essential/multiple-face-mask.webm)

Similar to Face Substitution, to have multiple [Face Retouch](/lens-studio/features/ar-tracking/face/face-retouch.md), [Face Stretch](/lens-studio/features/ar-tracking/face/face-stretch.md) and [Eye Color](/lens-studio/features/ar-tracking/face/eye-color.md), all you need to do is duplicate the object containing the component and increment the `Face Index` field.

![](/assets/images/multiple-face-components-00132e7716ed9351a10d092fc2c7841f.png)

## Face Attached Objects[​**](#face-attached-objects "Copy to clipboard")

The `Head Binding` component is used to attach 2D or 3D objects to certain parts of the user’s face. To create a Face Image, follow the [Face Image](/lens-studio/features/ar-tracking/face/face-image.md) guide.

To apply your attachments to multiple faces, you can duplicate the object containing your Head Binding by right clicking and selecting `Duplicate` in the `Scene Hierarchy` panel.

Then, select your new copy, and under the `Head Binding` component, increment its `Face Index` field by 1.

You can have different children for each binding if you want different attachments for each face.

[](/img/lens-studio/5-essential/multiple-face-image.webm)

## Face Inset[​**](#face-inset "Copy to clipboard")

The Face Inset us a combination of `Head Binding` component for the position and `Face Inset` for the texture. To apply this effect on multiple faces, you need to change the `Face Index` in field in both components.

Right click the Object that contains the Head Binding component and select `Duplicate` in the `Scene Hierarchy` panel. Then select the new object and in its Head Binding’s `Face Index` field, increment it by 1. Finally select its children object containing the `Face Inset` component and increment it’s `Face Index` field by 1.

Learn more about Face Inset in the [Face Inset](/lens-studio/features/ar-tracking/face/face-inset.md) guide.

[](/img/lens-studio/5-essential/multiple-face-inset.webm)

## Face Liquify[​**](#face-liquify "Copy to clipboard")

The Face Liquify is a combination of `Head Binding` and the `Liquify` component on the same object. The `Head Binding` component positions the liquify and the `Liquify` component distorts around that position.

Right click on the Liquify Point object and select `Duplicate` in the `Scene Hierarchy` panel. Then, you can increment the `Face Index` field in the Head Binding component in the new object by 1.

Learn more about Face Liquify in the [Face Liquify](/lens-studio/features/ar-tracking/face/face-liquify.md) guide.
