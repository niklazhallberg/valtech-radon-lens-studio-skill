# Simple High Score

`Simple High Score` is available in the Lens Studio [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md). Import the asset to your project, create a new Orthographic camera, and place the prefab under it.

The Simple High Score asset provides you with the building blocks for creating a simple score-tracker in a game. By extension, this asset is an example of how to create Lenses that read and write to [persistent storage](/lens-studio/features/persistent-cloud-storage/persistent-storage.md).

The Simple High Score asset features a pair of buttons used to increment and store a score, which is displayed at the top of the screen. When the user leaves and returns to their Lens, they'll see that their "High Score" field has been saved from the last time they opened their Lens. For a more involved example of persistent storage, please refer to the more advanced [High Score](/lens-studio/features/persistent-cloud-storage/persistent-cloud-storage-templates/high-score.md) sample project.

## Guide[​**](#guide "Copy to clipboard")

Find the `Simple High Score` asset in the Asset Library and import it into your project. Click [here](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md#prefab) to learn more about how to use assets in the Asset Library.

Once you import the asset from the Asset Library, you can find the package **Simple High Score** in the Asset Browser. You can right-click and select **Unpack for Editing** from the drop-down menu to unpack all assets stored in the bundle. Click here to learn more about [Asset Packages](/lens-studio/features/package-management/asset-packages-introduction.md). Once you unpack the package, you can then edit its content.

Create an Orthographic Camera by clicking the `+` button on the top left corner of the `Scene Hierarchy` panel and selecting **Orthographic Camera**. Then, drag the prefab **Simple High Score\_\_PUT\_IN\_ORTHO\_CAM** under the newly created Orthographic Camera to create a new Scene Object.

![](/assets/images/ls5-simple-high-score-prefab-preview-1bc80a9a1d77616029c8e0cb80de8d1e.png)

You'll see two buttons at the bottom of the `Preview` panel:

![](/assets/images/simple-high-score_high_score_template_full-0b207fabe37b1937ebed8937893b417e.png)

* A button labeled **Add Point**
* A button labeled **End Game**

![](/assets/images/simple-high-score_high_score_template_buttons-84d27d4d2c32330fdc32479a1599d7fd.png)

At the top of the screen is a display that contains:

* The user's Snapchat display name, which makes use of Lens Studio's [dynamic text system](/lens-studio/features/text/2d-text.md)
* A number labeled **"Current Score"**
* A number labeled **"High Score"**

![](/assets/images/simple-high-score_high_score_template_display-84aa9ad97504982ef2f9cbb7ce1ef431.png)

When the user presses the **Add Point** button, the **Current Score** value will increment by 1.

[](/img/lens-studio/simple-high-score_high_score_increment.webm)

When the user presses the **End Game** button, the **High Score** value is set to the **Current Score**, and the **Current Score** value is set to 0.

[](/img/lens-studio/simple-high-score_high_score_end_game.webm)

Additionally, pressing the **End Game** button writes the new High Score value to [persistent storage](/lens-studio/features/persistent-cloud-storage/persistent-storage.md). When the user closes and reopens the Lens, the **High Score** value is recovered and displayed again.

To learn more about reading and writing data in Lenses, please visit the [Persistent Storage guide](/lens-studio/features/persistent-cloud-storage/persistent-storage.md).

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

You’re now ready to preview your Lens experience. To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
