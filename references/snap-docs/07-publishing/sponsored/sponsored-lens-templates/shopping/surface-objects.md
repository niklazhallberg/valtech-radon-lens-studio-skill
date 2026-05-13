# Shopping Lens

This example provides you with a starting point for building a Shopping Lens. A [Catalog-Powered Shopping Lens](https://businesshelp.snapchat.com/s/article/shopping-lens) is a special Lens that is connected to a Product Catalog, allowing you to dynamically update product information, create a link out for each product, and more.

Since Shopping Lenses require a connection to a Product Catalog, they are only applicable on some accounts. Before you get started, take a look at what you need [here](https://businesshelp.snapchat.com/s/article/shopping-lens).

[](/img/lens-studio/surface-objects_shopping-cards-preview.webm)

The template comes with an example of three products displayed in a surface in front of you, that can be switched through via the Lens Product Cards.

To get started, [download the Lens Studio project](https://storage.googleapis.com/snapchat-lens-assets/f1a09194-f02d-43ed-92b8-62e843179ff0/lensStudio/AR%20Shopping/AR%20Shopping%20Surface%20Objects.zip).

While this example demonstrates swapping through objects on a surface, you can reuse the scripts in this template to make Shopping Lenses specific to your needs. For example, you can instead swap through objects attached to the face (e.g. sunglasses)!

## Workflow[​**](#workflow "Copy to clipboard")

A Shopping Lens consists of two key pieces:

* Lens which contains the AR product experience.
* Product Catalog which populates the Lens Product Card with product information dynamically.

These two pieces are linked together through a Product Tagging process that happens after Lens Submission in the Snapchat Business Account.

In this guide, we will take a look at the Lens creation process. Take a look at [the Product Tagging and publishing guide](https://businesshelp.snapchat.com/s/article/shopping-lens) to learn how to distribute your Shopping Lens.

The products from the Product Catalog will be shown in a random order.

## Guide[​**](#guide "Copy to clipboard")

Each Shopping Lens contains all the AR visuals needed to display your product.

In the example project, we have a Hoodie, Sneakers, and Baseball Cap as our products. They are listed in the `Scene Hierarchy` panel, under `Shopping Objects`.

![](/assets/images/surface-objects_ar-shopping-world-0-ec34784218397222cf34365a4213ae40.png)

Next, the Lens needs to know what this object should be referred to as. To see this association, select the `Shopping Controller` scene object in the `Scene Hierarchy` panel, and check out the `Inspector` panel.

![](/assets/images/surface-objects_ar-shopping-world-01-58e547ac233cb5f2663e3d10f68fb5e4.png)

![](/assets/images/surface-objects_ar-shopping-world-1-d69b3b6483a088b84057bc0aabe7cab2.png)

The `Shopping Controller` script provides inputs for three products: State 0, 1 and 2. Eaach state allows to add a list of

Right click on a field, and click `Select` in the popup menu to see what the reference is to.

You can have more than one AR object per product–for example, you can add a pedestal where your product will sit on that will show up when that product is chosen.

Now that the Lens knows how to refer to each product and their AR visuals, we need to associate it to the `Shopping Module`. The data in the `Shopping Module` is shown in the Product Tagging process so that each product in your Product Catalog can be associated with each state of the Shopping Lens.

In the `Asset Browser` panel, select the `Shopping Module`. Then, in the `Inspector` panel, note that we have some of the same information we saw in the `Shopping Controller`.

Make sure the names of the states exactly match (including casing), otherwise the Lens will be broken.

![](/assets/images/surface-objects_ar-shopping-world-2-d2e591ae604097211e911b0183119df3.png)

The `Shopping Module` includes several fields for you to define as you create your Shopping Lens. The fields include:

* **Domain:** name of the product line (e.g., Running Shoes).
* **Description (of the domain):** description of the domain (e.g., Winter Season Collection).
* **State(s):** name of the single product displayed in that state (e.g., Shoe ABC).
* **Description (of each state):** description of the product in the state (e.g., SKU ID 12345, red shoe).

As you can see, these fields are all freeform.

The purpose of these fields is to help the person that will be tagging this Lens identify the right products during the Product Tagging process.

For reference, see below for what the person will see in Snapchat Business Manager when Tagging the Lens. You will want to make sure they are aware of which AR experiences map to the “State” name for this reason:

![](/assets/images/surface-objects_ar-shopping-world-3-f3672ad542c6dbc0efa337b41e244d71.png)

### Adding your own Product[​**](#adding-your-own-product "Copy to clipboard")

To add your own product, we’ll first import our model into Lens Studio. Take a look at the 3d [model export](/lens-studio/assets-pipeline/3d/importing-content/fbx-3d-object-import.md) and [import](/lens-studio/assets-pipeline/3d/importing-content/overview.md) guide to bring your product’s model in Lens Studio.

[](/img/lens-studio/5-shopping/surface-objects_ar-shopping-world-4.webm)

If you have an FBX, glTF, or other common 3D model format, you can import it into Lens Studio by dragging-and-dropping them into the `Scene Hierarchy` panel. You can customize the look of your model using different [materials](/lens-studio/features/graphics/materials/overview.md), or customizing them with the [Material Editor](/lens-studio/features/graphics/materials/material-editor/introduction-and-concepts.md).

You can [resize](/lens-studio/lens-studio-workflow/lens-studio-interface/toolbar-and-shortcuts.md) the size of your assets in the `Scene` panel. However, the size of the object is not necessarily real world scale accurate. The Lens will automatically size the object so that it’s visible regardless of the surface that the product is placed on–i.e. So you can see the detail of a hat whether you place it on the table, or on the floor. If you'd like your object to be accurately scaled, take a look at the [True Size Objects](/lens-studio/sponsored/sponsored-lens-templates/shopping/true-size-objects.md)

With your model imported, let’s bring it under the `Shopping Objects`. To do this, click and drag our newly imported model over the `Shopping Objects` in the `Scene Hierarchy` panel.

[](/img/lens-studio/5-shopping/surface-objects_ar-shopping-world-5.webm)

We’ll replace our `Baseball Cap` with our new product. Right click on the `Baseball Cap` object in the `Scene Hierarchy` panel, and choose `Delete`.

[](/img/lens-studio/5-shopping/surface-objects_ar-shopping-world-6.webm)

You can add animation to your product (for example having it rotate) by using Tween. Take a look at the Hoodie product to see an example.

Now we’ll connect it to the `Shopping Controller` so the template knows how to refer to it. Select the `Shopping Controller` object, then in the `Inspector` panel, click on the field next to the `Values`  section of State 2 (where the baseball Cap object was). We’ll update the state name to our new product as well.

[](/img/lens-studio/5-shopping/surface-objects_ar-shopping-world-7.webm)

You can also add additional effects when a product is selected by enabling the `Use Trigger` option. Then, in the `Custom Trigger` field, put the [Behavior](/lens-studio/lens-studio-workflow/adding-interactivity/behavior.md) that you want to happen when the product is selected. In the template we added a behavior that makes the product bounce using [Tween](/lens-studio/lens-studio-workflow/adding-interactivity/tween-manager.md) when it is selected.

Finally, we’ll expose this information in the `Shopping Module`. In the `Asset Browser` panel, select the `Shopping Module`. Then, in the `Inspector` panel, replace the State name to match the one we used in the `Shopping Controller`!

[](/img/lens-studio/5-shopping/surface-objects_ar-shopping-world-8.webm)

### Testing your Lens[​**](#testing-your-lens "Copy to clipboard")

It’s important to note that you won’t be able to see the Product Cards in Lens Studio since it needs to be connected to the product catalog.

You can see placeholder product cards when you [Push to Device](/lens-studio/lens-studio-workflow/previewing-your-lens.md).

[](/img/lens-studio/surface-objects_ar-shopping-world-preview-1.webm)

The products from the Product Catalog will be shown in a random order.

To make things easier, the `Shopping Controller` script comes with a debug mode where you can simulate the user changing a Product Card when you tap in the `Preview` panel. The Lens will automatically use "tap to change" when previewing in Lens Studio.

[](/img/lens-studio/surface-objects_ar-shopping-world-preview-2.webm)

Previously, you had to check a box to enable or disable tab to change. The template will now handle this automatically, depending on the device the Lens is being used in.

### Changing the Number of Products in the Lens[​**](#changing-the-number-of-products-in-the-lens "Copy to clipboard")

By default, the template has slots for up to three products.

* If you want to have less than three, simply press the `X` button next to the `State` in the `Shopping Module`.
* If you want to have more than three, follow the guide below:

First, we’ll add the state in the Shopping Module, click `Add State`.

Next, we’ll add a corresponding state in the `Shopping Controller`. To do this, find the `Shopping Controller` script in the `Asset Browser` panel (`Scripts > Shopping Controller`), and double-click on it to open the script in the [Script](/lens-studio/features/scripting/script-editor.md) editor.

![](/assets/images/surface-objects_ar-shopping-world-11-d4bc736c5ea66626c977748d59a37f51.png)

Then, set `const NUM_STATE_INPUTS` to your desired number of states/products.

![](/assets/images/surface-objects_ar-shopping-world-12-1c33fe0f6b16c19dba51897568d273cb.png)

Then, we’ll add new input fields so you can specify what’s in the new state. To do this, duplicate the 4 **`@ui`** and **`@input`** lines of code near the top of the script and increment each numerical value present in the code by `1`. For example, to add a 4th state, duplicate the 6 lines and change to:

```
// @ui {"widget":"group_start", "label":"State 3"}
// @input string state3name
// @input bool state3useTrigger = false {"label" : "Use Trigger"}
// @input string state3Trigger {"showIf" : "state3useTrigger","label" : "Custom Trigger"}
// @input SceneObject[] state3objects
// @ui {"widget":"group_end"}
```

Learn more about these input fields in the [Custom Script UI](/lens-studio/features/scripting/custom-script-ui.md) guide.

Remember to save the script after editing to apply the changes and surface the new set of states by pressing Cmd+S (Mac) or Ctrl+S (Windows).

[](/img/lens-studio/5-shopping/surface-objects_ar-shopping-world-13.webm)

Repeat as necessary until you have all desired products in your Shopping Lens.

## Publishing Your Lens[​**](#publishing-your-lens "Copy to clipboard")

Once you’re satisfied with your Lens, you can publish the Lens by pressing the `Publish` button in the top left corner of Lens Studio. Plese refer to the [Publishing Guide](/lens-studio/publishing/submitting/submitting-your-lens.md) for more details.

With the Lens uploaded, you will now be able to tag your Lens with the products from your Product Catalog or Store! Please [visit the Snap Business Help Center article](https://businesshelp.snapchat.com/s/article/shopping-lens) here that maps out the steps to associate your Product Catalog with your Shopping Lens.
