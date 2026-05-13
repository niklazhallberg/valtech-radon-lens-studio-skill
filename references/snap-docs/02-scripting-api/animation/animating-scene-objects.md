# Animating Scene Objects

Lens Studio supports keyframe animation on scene objects—no external 3D software needed. You can animate **position**, **rotation**, and **scale**, control playback with transport controls, and record keyframes live in the viewport.

***

## Quick Start: The Animate Action[​**](#quick-start-the-animate-action "Copy to clipboard")

Use the **Animate** context menu action to start animating a scene object.

1. In the **Scene Hierarchy**, right-click a scene object.
2. Choose **Animate**.

![Scene Hierarchy context menu with "Animate" highlighted](/img/lens-studio/animating-scene-objects_animate-context-menu.png)

Lens Studio then:

* Creates an [`AnimationAsset`](/lens-studio/features/animation/animation-player.md#animation-asset) with default keyframes for the object's current **position**, **rotation**, and **scale**.
* Adds an [`AnimationPlayer`](/lens-studio/features/animation/animation-player.md) component wired to the new asset via an `AnimationClip`.
* Opens the [Animation Curve Editor](/lens-studio/features/animation/anim-curve-editor.md) and loads the new curves.
* Restores selection to the scene object.

If the object already has an `AnimationPlayer`, Lens Studio uses the existing player and its clips instead.

After running **Animate**, scrub through time, edit curve shapes, or record new keyframes—no manual wiring needed.

***

## What Gets Created[​**](#what-gets-created "Copy to clipboard")

| Created                     | Details                                                                                           |
| --------------------------- | ------------------------------------------------------------------------------------------------- |
| `AnimationAsset`            | Contains layers for `position`, `rotation`, and `scale`. Each starts with one keyframe at time 0. |
| `AnimationPlayer` component | Added to the scene object with `Autoplay` on.                                                     |
| `AnimationClip`             | Created inside the `AnimationPlayer`, linked to the new `AnimationAsset`.                         |

See the [Animation Player](/lens-studio/features/animation/animation-player.md) reference for details on each entity.

***

## Recording Keyframes[​**](#recording-keyframes "Copy to clipboard")

With an `AnimationPlayer` on the scene object, record new keyframes by moving the object in the viewport.

### Enable Recording[​**](#enable-recording "Copy to clipboard")

Click the red circle **Record** button in the Animation Curve Editor toolbar to toggle recording on.

![Animation Curve Editor toolbar with the active Record button shown as a red dot](/img/lens-studio/anim-curve-editor_record-button.png)

With the record button on:

1. Position the **scrubber**—the playhead—at the desired time.
2. Move, rotate, or scale the scene object in the **Scene Editor** viewport.
3. On release, the editor writes **position**, **rotation**, and **scale** keyframes at the scrubber time.

[](/img/lens-studio/anim-curve-editor_record-workflow.webm)

Recording uses debouncing—one keyframe per drag. This keeps the undo history clean: each drag produces one undo step.

### Overwriting Existing Keyframes[​**](#overwriting-existing-keyframes "Copy to clipboard")

If a keyframe exists at the current scrubber time, the editor **overwrites** it. Use this to refine a captured pose.

### Stopping Recording[​**](#stopping-recording "Copy to clipboard")

Click **Record** again to turn it off. With recording off, viewport moves don't affect the curves.

***

## Previewing the Animation[​**](#previewing-the-animation "Copy to clipboard")

Use the **transport controls** to preview without leaving the editor:

| Control          | Action                                              |
| ---------------- | --------------------------------------------------- |
| **Play / Stop**  | Toggles `AnimationPlayer` autoplay.                 |
| **Step Forward** | Advances one frame.                                 |
| **Step Back**    | Steps back one frame.                               |
| **Scrub ruler**  | Click and drag the time ruler to seek to any frame. |

For details on transport controls and the clips bar, see [Animation Curve Editor—Transport Controls](/lens-studio/features/animation/anim-curve-editor.md#transport-controls).

***

## Editing Curves[​**](#editing-curves "Copy to clipboard")

After recording or using **Animate**, open the [Animation Curve Editor](/lens-studio/features/animation/anim-curve-editor.md) to refine:

* Switch from **Linear** to **Free** Bezier tangents for smooth ease-in/ease-out motion.
* Mix tangent types per segment—for example, snap to a key then ease out.
* Drag tangent handles to adjust speed through each keyframe.

The editor curve matches runtime exactly - Lens Studio resamples non-linear Bezier curves during playback.

![Curve canvas after recording—the Z-axis track in yellow shows a smooth Bezier arc from a transform drag, while other tracks remain flat. Press Z to fit the view to the curves.](/img/lens-studio/anim-curve-editor_recorded-curves.png)

***

## Related Links[​**](#related-links "Copy to clipboard")

* [Animation Curve Editor](/lens-studio/features/animation/anim-curve-editor.md)—full reference for the curve editor UI, transport controls, and tangent handles
* [Animation Player](/lens-studio/features/animation/animation-player.md)—AnimationPlayer, AnimationClip, and AnimationAsset reference
* [Animation Events](/lens-studio/features/animation/animation-events.md)—trigger script callbacks at specific points in an animation timeline
* [Playing Animations Programmatically](/lens-studio/features/animation/playing-animations-programatically.md)—control playback from script
* [Animation Player API](/lens-studio/api/lens-scripting/classes/Built-In.AnimationPlayer.html)
* [Animation Asset API](/lens-studio/api/lens-scripting/classes/Built-In.AnimationAsset.html)
