# Fullscreen Segmentation

Segmentation Textures are masks that are updated in real time based on what is seen in the device's camera. Segmentation textures can be applied to a camera's Mask Texture input to show or hide certain areas of the scene. For example, the Portrait Background Segmentation texture creates a masked image of the portrait of the user. This mask texture can then be used as an input to a camera to only show elements behind the user. It's like a green screen without the green.

## Add a Segmentation Texture[​**](#add-a-segmentation-texture "Copy to clipboard")

To add a new Segmentation Texture, select `+ -> Segmentation Texture` from the `Asset Browser` panel. Then, with the `Segmentation Texture` selected in the `Asset Browser` panel, select from the provided `Segmentation Type` in the `Inspector` panel.

### Available Segmentation Textures[​**](#available-segmentation-textures "Copy to clipboard")

![](/assets/images/segmentation_segmentation-5-1-b80ed2a942cf0f1f12ce7708ffe51bea.png)

* **Portrait Segmentation:** Masks out the portrait of the user showing just the background.
* **Portrait Hair:** Masks out everything but the user's hair. Allows you to color or apply a texture to the hair.
* **Portrait Shoulder:** Masks our everything but the user's shoulders.
* **Portrait Face:** Masks out everything but the user's face. This does not include the user's hair.
* **Portrait Head:** Masks out everything but the user's head. This does include the user's hair.
* **Portrait Skin:** Masks out everything but the user's Skin. This does include the user's hair.
* **Sky:** Masks out everything in the scene but the sky. Great for rear camera experiences where you want to put content in the sky.
* **Body:** Masks out everything in the scene but the full body of a person. Great for experiences where you want to put something behind the user. Check out [Body Instance Segmentation Texture](/lens-studio/features/ar-tracking/body/segmentation/body-instance-segmentation.md) if you want to mask out different persons separately.
* **Upper Garment:** Masks out everything in the scene but garments starting from the top of the user. The mask may extend beyond the upper part of the body. Great for demonstrating clothes try-on.

### Custom Segmentation Textures[​**](#custom-segmentation-textures "Copy to clipboard")

While Segmentation Textures can utilizes the built-in Segmentation Texture to mask content shown above, Lens Studio also supports Custom Segmentation where it's segmentation mask is provided through a machine learning model with [ML Component](/lens-studio/features/snap-ml/ml-component/ml-component-overview.md).

[](/img/lens-studio/custom-segmentation_custom-segmentation.webm)

To learn more about Custom Segmentation with SnapML, please visit the [Custom Segmentation](/lens-studio/features/snap-ml/snap-ml-templates/custom-segmentation.md) example to learn how to get started.

## Customizing the Segmentation Texture[​**](#customizing-thesegmentation-texture "Copy to clipboard")

Segmentation textures can be tuned by selecting them in the `Asset Browser` panel and tuning its settings in the `Inspector` panel.

![](/assets/images/segmentation_general_segmentation_1-d720fe58c012b20fbc4aa25740eb0d87.png)

Any segmentation texture can be easily inverted by clicking the `Invert Mask` checkbox.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIwAAAAZCAMAAADUtTb8AAAB4FBMVEU9Q03D0t9fZ3J/jJmHkZ3C0d0+RE4+RE9gaHS8ythCSVSptsJlcHx4hJF7hZA/RE4/RU+Pmqabp7ScqbWhrbqms8BHTlizwM23xNG6yNVUW2bAztvAz93B0NxBSFJCSFN1f4tCSVOjsLxmbnmntMCntcKpt8NRWGNTW2V+iJR/iZRARk+Bi5dZYWyDjpmFkJxdZG+LlqGLl6JfaHOVoa2lsr6Tn6pOVWBDSFOCjZhweoWqt8Stuseuu8evvcmwvspocX20w8+2xNFoc365x9S7ydZFS1Vxe4ZMU114hJBkbXhQV2FFTFaOmqWPmqVSWWNSWWRJT1mRnalJUFpVXWdrdH9sdYGYpK+YpLCZpbFtdoJocXxhaXNqc32Xo6+NmaWWoq+dqrZqc35hanSir7tMVF7B0d52gItITlmPm6eRnKh/ipWcqLRvd4NWXmieqrefq7ifrLmhrblXXml1foqjr7xKUVujsb2lsb5bY26ls793gYx4go5LUVyotcFdZXB5hI+qt8N6hY+ruMVdZnB8hpGuvMhLU11faHKwvstMUl20ws9GTVe1ws+1xNCAi5ZHTViBjJhAR1Fiana7yteEj5q9y9m/zdq/z9yEj5tia3WGkZxkbHeHkp3C0d6Ik57rdLi2AAABxklEQVR4Xu3VVYsjQRSG4e+0x91dx93d3d3X3d3d3V3/6vaEmRCgIWxCYHbp5+pAFfBCd1XhX6ZSqSJ6Aysz6CNQIiALQWHbm31Cbi0j7JYRpRovDUOZs0oLWZgeABj7VYUMDJUhF3q2LwRZqI/VKyyfoiYAJmxJz4KpmG5Cdp3qAXwnLr1kyj3GwIaQEmINyjF1PXa/vfhCh4jD7ahL8te8sLUNTA6QZyEV459DsJ84SA6+az9iTwMXp+SYClcp/hrLZkyKMTH6PeqqLSIJOsug5phkb4eud+1gN30b3Izp7C/BSX+Cw/Lu6jNJPKo/v9TC0BPNrFiQGD6Inw24bCmiqxI11kbphe4tsP2Z2j4+Fx2NVg7PbtRcccP24Wi3iSHfXgEFifkMHG9Aq6eyA++p0mg0anUPM2KG+XKqsHLNPfdbTrgRHNrjm2CoU+MtZIxWQ/fg/FIzXX5O2IxpolZzKga7yAErd4lezyfc5gNh5+k4Q+N3XUfy+4GVj/aPT0BJFLAEZoCNXvKsIn4HwNnAEIDwLdymRax8hYWnrpco9dGr9epD5sduW95HOzsntpUJyIR3zZCJ6Q35XXo76jn4/6lUqj8C/00ZAGIFHwAAAABJRU5ErkJggg==)

Any segmentation texture can have their edges feathered. Change the `Feathering` slider to tune the feathering sharpness.

![](data:image/png;base64,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)

Any segmentation texture can have their edges refined by clicking the `Refine Edge` checkbox. When this is enabled, post-processing algorithms are applied to the segmentation resulting in a higher quality mask. We recommend utilizing Refine Edge for most use cases.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIcAAAAWCAMAAADdA3/eAAACClBMVEU9Q03D0t8+RE5/jJlfaHKIk5/Az91lcHxUW2ZXXmlbY25dZXBfZ3JBSFJkbXhDSFNxe4Z4hJF7hZBGTVeJlKCLl6KNmKSUoKycqLSlsr60w8+4x9NOVWDC0d1PVmH///9HTVh+iJRvd4O5yNRARk8+RE9/ipVHTliIk55MU11CSVOKlaJhaXNCSVSPm6dRWGOWoq+YpLCaprJmbnmcqbWhrbmhrbqjr7xqc36ntMGotcGsusavvcmzwM1sdYBSWmVveIO+zNi/zdq/z9xTW2XB0NzB0d50fYl4hJA/RE5WXmhJUVuwvsuAi5aAjJmAjZqBi5eCjZiDjpmEj5qEkZ2HkZ2Hkp1bZG5KUVteZnFLUVxMUl2Ll6OMmKNfaHOOmqWPmqZgaHSRnqmTnqmUn6o/RU9ianaXo6+YpK9ia3WZpbGapK9ja3aaprNkbHdNVV+dqrafq7ifrLlDSlNCSFKir7ujrLVncHujsLyjsb2krbelsb5pcn2ls7+ms8Bqc31QWGGqt8SruMVAR1GtuseuvMlsdYFtd4FSWWSxv8uzusJBRlBveYS1ws+1xNC3xtNITlm5wMe5x9Rye4e6wci6yNW7wsm7yda9y9m9zdlzfIdJT1lUXGbAztuwvsp5g495hI9JUFrC0d5XX2rP1NnW2t7c3+Pm6evv8fL09vf19vf4+fn6+/tYYGvUgQLMAAAB/0lEQVR4Xu3URa/jMBSG4e/YSZmZe5mZmXmQmZmZmZmZmeE/TtzMVGrUzW02I02fhSVHOdIrJTb+NXl5VUY3V7iNVdBgjCGNLXGVjL+AFku/1FGuL2OC/zGhCTERUbS6FCrXWPsIDUBjCyneQlFKEvQw8pSFGzg3IsMUXV4XoCKAQRFsAhIiahJIr9jearPZlop9qoMxCAzT5+bC7E8/OHdrO2JgxXLJ2id35qMibui+cfvX6kiboW0EK/YP93SkOtZDaL402kISZkUH90aYOjBdPOV68p6yajuse55T0dzik67RMzNam+rtZG2mCkevH+1dNT7DctHRI8tywvus0aF0OKhwcy8xdSCHjo+HN/78PCdLh2KX89gtv3/Ih4Y1EB1xOxaH7YbT/jo6IjquBQKBszX0DjGSFlwEBoipAzl0fPn+9dtKnqXDlBisxqlzHo9n29+OIaAs7Iw3Ks/6099lJxWgkqR5rwEXMXUgh44dyeRxnq0jhrK4aVF0meVQX0YHuk687OusFx0tZrO5/K6h7kOQJIl8Dx4RUwdy+U8fPuaCW3tuK+GMbK0Nvad9XgRX4cKYZfdToPAornbTsJw+t29w8z51khXj52eGiKkDOZ5bwYjsap3QgndTxnbyAICpkKWgIaIO6LvH9DkYJnp1Rf+9Dr1YrN+O/0xe3m+Bbl3l+wyoaAAAAABJRU5ErkJggg==)

## Using the Segmentation Texture[​**](#using-the-segmentation-texture "Copy to clipboard")

Now that you have a new Segmentation Texture added to your `Asset Browser` panel, in most cases, you'll want to use this texture as a mask for a camera. To do this, select your camera in the `Scene Hierarchy` panel. With the camera selected, in the `Inspector` panel, set the `Mask Texture` field to your newly created Segmentation Texture.

[](/img/lens-studio/segmentation_general_segmentation_9.webm)

Your camera's output will now be masked by the selected Segmentation Texture.

Try adding an object to your scene now (e.g. `Scene Hierarchy > + > Sphere`), and you can see that the part of the object outside the portrait is masked out.

![](/assets/images/segmentation_general_segmentation_6_1-5ac0f535af66cea4dd866009606307b3.png)

You can tick the `Invert Mask` checkbox as mentioned above to get the object to look like it's in front of the user.

![](/assets/images/segmentation_general_segmentation_7_1-e50b81f463215ce61363b3e709a2543f.png)

Similarly, you can apply a `Mask Texture` on the Orthographic camera to have your Screen Images show behind the user's portrait.

![](/assets/images/segmentation_general_segmentation_8-337f0e3727c76952812430f7f046a8e3.png)

Finally, you can also add an `Opacity Texture` to your materials to mask out specific materials. To do this, make sure a `Blend Mode` which allows transparency is selected (e.g. `Normal`), and then enable the `Opacity Texture` checkbox. You can then put your segmentation texture in the `Texture` field under the `Opacity Texture` section

![](/assets/images/segmentation_general_segmentation_5-f00a6f59bb8b5f3da19594f09aad20dd.png)

## Segmentation Examples[​**](#segmentation-examples "Copy to clipboard")

There are a couple examples to help you get started on various ways to use the different segmentation textures.

### Segmentation Example[​**](#segmentation-example "Copy to clipboard")

![](/assets/images/segmentation_segmentation_examples-f9111c63ba5bac9809cbcb245890da7a.png)

When using segmentation, we recommend checking out the [Segmentation Example](/lens-studio/features/ar-tracking/face/face-templates/segmentation.md). The example has a controller that allows you to easily add a background color, image, tiled image, post effect and more segmented by your selected Segmentation Texture.

### Body Segmentation Example[​**](#body-segmentation-example "Copy to clipboard")

[](/img/lens-studio/segmentation_body-segmentation-preview.webm)

When using the Body Segmentation texture, we recommend checking out the [Body Segmentation](/lens-studio/features/ar-tracking/body/segmentation/body-segmentation.md) example. The example provides various examples of how to use it to create different effects. This example is great for making  a dancing or music video type Lens.

### Upper Garment Segmentation Example[​**](#upper-garment-segmentationexample "Copy to clipboard")

[](/img/lens-studio/segmentation_1.webm)

When using Upper Garment Segmentation, we recommend checking out the [Upper Garment Segmentation Example](/lens-studio/features/ar-tracking/body/segmentation/upper-garment-segmentation.md). The example demonstrates how you can demonstrate virtual try-on by using [Body Tracking](/lens-studio/features/ar-tracking/body/object-tracking-3d.md) to attach your content to the Snapchatter's shirt. In addition, it provides additional materials to add shadows to the garment so that it will look more realistic.

### Portrait Skin Segmentation Example[​**](#portrait-skin-segmentation-example "Copy to clipboard")

[](/img/lens-studio/segmentation_pss_image_1.webm)

When using Portrait Skin Segmentation, we recommend checking out the [Portrait Skin Segmentation Example](/lens-studio/features/ar-tracking/body/segmentation/portrait-skin-segmentation.md). The example demonstrates how you can demonstrate placing any content, such as images, 3d meshes and more to the skin and attach your content to a human.
