# Occluders

## Introduction[​**](#introduction "Copy to clipboard")

[](/img/lens-studio/occluders_occluder_title.webm)

*A simple hole-in-the-ground effect created with an occluder.*

Occluders are visual elements used to mask other objects in your scene. These are handy for creating effects which hide portions of rendered geometry. For example, you can create a "hole" in the ground by occluding elements of a scene (as shown in the image above).

This guide explains how to create an occluder in Lens Studio.

## Creating an Occluder[​**](#creating-an-occluder "Copy to clipboard")

An Occluder is created by applying an Occluder material to any visual object in your scene.

### Create the Material[​**](#create-the-material "Copy to clipboard")

In the `Asset Browser` panel, select `+ -> Material -> Occluder`.

[](/img/lens-studio/occluders_create-occluder.webm)

### Apply the Material[​**](#apply-the-material "Copy to clipboard")

Select any Scene Object that has a `Mesh Visual` component.

In the `Inspector` panel, set the first `Material` property of the Scene Object's `Mesh Visual` component to the Occluder material you created earlier.

[](/img/lens-studio/occluders_drag-occluder.webm)

### Preview[​**](#preview "Copy to clipboard")

In the `Preview` panel, you should see that the other visuals in your scene are now occluded by the Scene Object to which you applied the Occluder material.

[](/img/lens-studio/occluders_occluder_preview.webm)
