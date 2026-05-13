# Caption Sticker Component

The Caption Sticker component is designed to create interactive captions on photos and videos captured by the user. Users can interact with the sticker after taking a photo/video, changing the text and position of the caption. Please note that the Lens Studio uses a mock caption, and on the actual device, it might look different in terms of size, font, etc.

[](/img/lens-studio/images-caption-sticker-0.webm)

## Adding the Component to a Scene[​**](#adding-the-component-to-a-scene "Copy to clipboard")

The Caption Sticker component can be downloaded from the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

![](/img/lens-studio/images-caption-sticker-1.png)

Once downloaded, it can be added to a Scene Object that has a [Screen Transform](/lens-studio/lens-studio-workflow/scene-set-up/2d/screen-transform-overview.md) for preview purposes inside Lens Studio. **On the actual device, the Caption Sticker will function normally even without the Screen Transform**.

[](/img/lens-studio/images-caption-sticker-2.webm)

## Changing the Caption Text and Position[​**](#changing-the-caption-text-and-position "Copy to clipboard")

To change the position of the Caption Sticker, you can adjust the `position` property. This property accepts numerical values ranging from -1 to 1, where -1 represents the bottom of the screen and 1 represents the top of the screen. You can set this property programmatically or through the Inspector.

Example:

```
//@input Component.ScriptComponent captionSticker

script.captionSticker.position = 0; // Center of the screen
```

To change the text of the Caption Sticker, you can adjust the `text` property. This property accepts a string value that will be displayed as the caption. You can set this property programmatically or through the Inspector.

Example:

```
//@input Component.ScriptComponent captionSticker

script.captionSticker.text =
  'The current time is {{time}}. Time for a coffee break!';
```

## Text placeholders[​**](#text-placeholders "Copy to clipboard")

You can use placeholders for dynamic text replacement. These placeholders will be automatically replaced with the corresponding contextual information, such as the current date, time, location etc. This allows for creating dynamic and personalized captions that update based on the user's environment and the time of day.

* `{{date}}` - The current date in DD/MM/YYYY format.
* `{{day}}` - The full name of the current day.
* `{{month}}` - The full name of the current month.
* `{{hour}}` - The current hour in 24-hour format, padded to 2 digits.
* `{{minutes}}` - The current minutes, padded to 2 digits.
* `{{year}}` - The current year in YYYY format.
* `{{time}}` - The current time in HH
  <!-- -->
  :MM
  <!-- -->
  format.
* `{{weekday}}` - The full name of the current day (same as `{{day}}`).
* `{{monthname}}` - The full name of the current month (same as `{{month}}`).
* `{{shortyear}}` - The last two digits of the current year.
* `{{ampm}}` - 'AM' or 'PM' based on the current hour.
* `{{greeting}}` - A greeting based on the current time ('Good Morning', 'Good Afternoon', or 'Good Evening').
* `{{quarter}}` - The current quarter of the year in Q1, Q2, Q3, or Q4 format.

## Text Input Examples[​**](#text-input-examples "Copy to clipboard")

* `{{greeting}}`!
* Today is `{{day}}`, `{{date}}`. Don't forget your umbrella!
* The current time is `{{time}}`. Time for a coffee break!
* We are in `{{quarter}}` of the year. Almost there!
* Good news! It's `{{day}}`. Bad news! It's still not Friday.
* It's `{{time}}` and I'm already thinking about lunch.
* The current year is `{{year}}`. Still waiting for teleportation.
* It's `{{hour}}`:`{{minutes}}` `{{ampm}}`. Do you know where your coffee is?
* Happy `{{month}}`! Time to break those New Year's resolutions!

## API[​**](#api "Copy to clipboard")

**text** : `(string)`

The text content of the caption.

***

**position** : `(number)`

The position of the caption on the screen.

***
