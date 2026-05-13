# Rich Text

Rich text allows a singular Text or Text3D component to have multiple styles, including font, size, underline, and more.

To use rich text, you can enable `Rich Text` on a Text component.

![](/img/lens-studio/rich-text_enable-rich-text.png)

## Format[​**](#format "Copy to clipboard")

A markup system similar to HTML is used for rich text, using tags to determine the style of a piece of text. Tags are pieces of text enclosed within angle brackets.

```
This is <b>bold</b> text.
```

![](/assets/images/rich-text_format-1-226de22f1f559965bd934fab22e44d9f.png)

In this example, `<b>` is an *opening tag* and `</b>` is its corresponding *closing tag*.

The **basic format rules** are the following:

1. All tags will be enclosed within angle brackets (ex. `<tag>`)
2. *Opening tags* will be one of the following two formats: `<tag>` or `<tag=value>`
3. *Closing tags* will be of the format `</tag>`
4. Some *standalone tags* do not have closing tags (ex. `<br>`)
5. Tags are case-insensitive and ignore whitespaces

If you have an opening tag without a corresponding closing tag, that opening tag applies until the end of the text.

```
This is <b>bold text and continues to be bold until the end.
```

![](/assets/images/rich-text_format-2-7de777a6dfe7f53e52ba08606939bc72.png)

### Nesting and Entangling[​**](#nesting-and-entangling "Copy to clipboard")

To apply multiple styles onto a piece of text, you can *nest* tags.

```
This is <b><i>bold and italic</i></b> text.
```

![](/assets/images/rich-text_nesting-1-27a41c77c4cf6b62aafbc316f62c1290.png)

If you nest multiple tags of the same type, the inner tag determines the actual style.

```
This is <color="red"><color="blue">blue</color></color> text.
```

![](/assets/images/rich-text_nesting-2-ec796f53c67074b0ecbb363e035d3b13.png)

*Entangling* tags means that tags can overlap—one tag can close before another one that was opened later, and both still apply independently to their respective ranges.

```
We have <b>bold text, <i>bold-italic text, </b>and italic text </i>.
```

![](/assets/images/rich-text_nesting-3-bc502e87c5ae10aeb625e2e3cb031cbf.png)

## Style Tags[​**](#style-tags "Copy to clipboard")

### \<bold> and \<italic>[​**](#bold-and-italic "Copy to clipboard")

The `<bold>` or `<b>` tag is used to apply bold styling to your text.

* Format: `<bold>Text</bold>` or `<b>Text</b>`

The `<italic>` or `<i>` tag is used to apply italic styling to your text.

* Format: `<italic>Text</italic>` or `<i>Text</i>`

```
This is regular text, <bold>this is bold text, <italic>this is bold-italic
text</bold>, and this is italic text.</italic>
```

![](/assets/images/rich-text_bolditalic-e49a39fc6e7c9e13636536ce8fc8b37b.png)

### \<weight>[​**](#weight "Copy to clipboard")

The `<weight>` tag is used to change the weight (thickness) of your text.

* Format: `<weight="100">Text</weight>`

* The available weights and their corresponding style names are:

  <!-- -->

  * `"100"`: Thin
  * `"200"`: ExtraLight
  * `"300"`: Light
  * `"400"`: Regular
  * `"500"`: Medium
  * `"600"`: SemiBold
  * `"700"`: Bold
  * `"800"`: ExtraBold
  * `"900"`: Heavy

```
This is regular text, <weight="200">this is extra light text, <weight="900">and
this is heavy text</weight></weight>.
```

![](/assets/images/rich-text_weight-718d85a7e6c98f922c18cf31da3ca18f.png)

### \<style>[​**](#style "Copy to clipboard")

The `<style>` tag is used to apply different styles (weight + italic) to your text.

* Format: `<style="ExtraLight Italic">Text</style>`

* The available style names are:

  <!-- -->

  * `"Thin"` and `"Thin Italic"`
  * `"ExtraLight"` and `"ExtraLight Italic"`
  * `"Light"` and `"Light Italic"`
  * `"Regular"` and `"Regular Italic"`
  * `"Medium"` and `"Medium Italic"`
  * `"SemiBold"` and `"SemiBold Italic"`
  * `"Bold"` and `"Bold Italic"`
  * `"ExtraBold"` and `"ExtraBold Italic"`
  * `"Heavy"` and `"Heavy Italic"`

```
This is regular text, <style="ExtraLight Italic">this is extralight italic
text, <style="Heavy">and this is heavy text</style></style>.
```

![](/assets/images/rich-text_style-2de92ed17c450ad212216b7b524a33f9.png)

### Style Tags Nesting Rules[​**](#style-tags-nesting-rules "Copy to clipboard")

The actual style of text will be determined by its innermost tags, with weight and italic determined separately. The innermost bold, weight, or style tag will determine the weight, and the innermost italic or style tag will determine if it's italic or not.

```
<style="Light Italic">This is light italic, <bold>this is bold italic, <style="Heavy">this is heavy
(not italic), <italic>and this is heavy italic.</italic></style></bold></style>
```

![](/assets/images/rich-text_stylenesting-12a335a98fa04a812aac8d230f5bca6d.png)

## Color Tags[​**](#color-tags "Copy to clipboard")

Color and opacity tags are only supported for the 2D Text component.

### \<color>[​**](#color "Copy to clipboard")

The `<color>` tag is used to change text color. It takes the following types of values:

* **Named colors**

  * Format: `<color="namedColor">Text</color>`
  * The supported named colors are:

| Name      | RGB             | Hex     | Swatch                                      |
| --------- | --------------- | ------- | ------------------------------------------- |
| red       | (255, 0, 0)     | #FF0000 | ![](/img/lens-studio/rich-text_red.png)     |
| blue      | (0, 0, 255)     | #0000FF | ![](/img/lens-studio/rich-text_blue.png)    |
| green     | (0, 255, 0)     | #00FF00 | ![](/img/lens-studio/rich-text_green.png)   |
| white     | (255, 255, 255) | #FFFFFF | ![](/img/lens-studio/rich-text_white.png)   |
| yellow    | (255, 255, 0)   | #FFFF00 | ![](/img/lens-studio/rich-text_yellow.png)  |
| black     | (0, 0, 0)       | #000000 | ![](/img/lens-studio/rich-text_black.png)   |
| gray/grey | (128, 128, 128) | #808080 | ![](/img/lens-studio/rich-text_gray.png)    |
| orange    | (255, 128, 0)   | #FF8000 | ![](/img/lens-studio/rich-text_orange.png)  |
| purple    | (128, 0, 128)   | #800080 | ![](/img/lens-studio/rich-text_purple.png)  |
| pink      | (255, 191, 204) | #FFBFCC | ![](/img/lens-studio/rich-text_pink.png)    |
| cyan      | (0, 255, 255)   | #00FFFF | ![](/img/lens-studio/rich-text_cyan.png)    |
| magenta   | (255, 0, 255)   | #FF00FF | ![](/img/lens-studio/rich-text_magenta.png) |
| brown     | (153, 77, 0)    | #994D00 | ![](/img/lens-studio/rich-text_brown.png)   |

* **Hex**
  * Format: `<color=#FFFFFF>Text</color>` or `<color=#FFFFFFFF>Text</color>` for opacity as well
* **RGB or RGBA**
  * Format: `<color=rgb(r,g,b)>Text</color>` or `<color=rgb(r,g,b,a)>Text</color>` or `<color=rgba(r,g,b,a)>Text</color>`, where `r`, `g`, `b` are integers between 0 to 255, and `a` is a float between 0.0 to 1.0
* **HSV**
  * Format: `<color=hsv(h,s,v)>Text</color>`, where `h` is an integer between 0 and 360, and `s` and `v` are integers between 0 and 100

```
<color="purple">Purple, </color><color=#FF8C00>orange, </color><color=rgb(0,150,255)>sky blue,
</color><color=hsv(120,80,90)>green, </color><color=rgba(255,0,100,0.5)>and translucent pink.</color>
```

![](/assets/images/rich-text_color-8636ca90610796b3b31a581bf08a98c7.png)

### \<opacity>[​**](#opacity "Copy to clipboard")

The `<opacity>` tag is used to change text opacity. It takes the following types of values:

* **Float**
  * Format: `<opacity=a>Text</opacity>` where a is a float between 0.0 and 1.0
* **Hex**
  * Format: `<opacity=#FF>Text</opacity>`

If you have both an `<opacity>` tag and a `<color>` tag that explicitly has an alpha value, the innermost tag will determine the opacity.

```
<opacity=0.5>This is 50% transparent, <color=rgba(255,0,0,1.0)>this is fully opaque red,
<opacity=0.2>and this is 20% transparent red.</opacity></color></opacity>
```

![](/assets/images/rich-text_opacity-1-e4777a2db6e49822f687c1c4429ad170.png)

Opacity tags also apply to the outline and drop shadow of the Text component if enabled.

```
<opacity=1.0>F</opacity><opacity=0.9>a</opacity><opacity=0.8>d</opacity><opacity=0.7>i</opacity><opacity=0.6>n</opacity><opacity=0.5>g</opacity> <opacity=0.4>a</opacity><opacity=0.3>w</opacity><opacity=0.2>a</opacity><opacity=0.1>y</opacity><opacity=0.0></opacity>
```

![](/assets/images/rich-text_opacity-2-50fc1f43536d0cb58860b91e7a75513d.png)

## Size Tag[​**](#size-tag "Copy to clipboard")

### \<size>[​**](#size "Copy to clipboard")

The `<size>` tag is used to change text size. It takes in a float from 2.0 to 800.0.

* Format: `<size=size>Text</size>` where size is a float from 2.0 to 800.0

```
This is default sized text, <size=200>this is huge text, </size><size=10.5>and this is tiny text.</size>
```

![](/assets/images/rich-text_size-1a2c08bfdda4ce65f312cffba45990dc.png)

## Font Family, Font Collection, and Font Tags[​**](#font-family-font-collection-and-font-tags "Copy to clipboard")

### Font Family Asset[​**](#font-family-asset "Copy to clipboard")

A Font Family asset is an asset used to group multiple Font assets into one font family. It supports a total of 18 different styles.

![](/img/lens-studio/rich-text_font-family-3.png)

To create an empty Font Family asset, select `+ → Fonts → Font Family` from the `Asset Browser` panel.

![](/img/lens-studio/rich-text_font-family-1.png)

Selecting `+ → Fonts → Font Family From Folder` will allow you to select a folder of fonts to import and attempt to create a Font Family asset with those fonts.

![](/img/lens-studio/rich-text_font-family-2.png)

You can also create a Font Family asset from existing Font assets in your project. Right-click on a folder containing one or more Font assets, or select one or more Font assets directly, and select `Create Font Family`.

![](/img/lens-studio/rich-text_font-family-4.png) ![](/img/lens-studio/rich-text_font-family-5.png)

A Font Family asset can be assigned to the `Font Source` field of a Text component. By changing the `Preferred Style`, the corresponding Font asset in your Font Family asset will be used.

![](/img/lens-studio/rich-text_font-family-6.png)

If you select a `Preferred Style` that has no corresponding entry in the Font Family asset, a system font will be used instead.

![](/img/lens-studio/rich-text_font-family-7.png)

### Font Collection Asset[​**](#font-collection-asset "Copy to clipboard")

A Font Collection asset is an asset used to group multiple Font and/or Font Family assets together.

![](/img/lens-studio/rich-text_font-collection-2.png)

To create an empty Font Collection asset, select `+ → Fonts → Font Collection` from the `Asset Browser` panel.

![](/img/lens-studio/rich-text_font-collection-1.png)

A Font Collection asset can be assigned to the `Font Source` field of a Text component. By changing the `Preferred Style`, the first matching Font asset in your Font Collection—including those within Font Family assets—will be used.

![](/img/lens-studio/rich-text_font-collection-3.png) ![](/img/lens-studio/rich-text_font-collection-4.png)

If you select a `Preferred Style` that has no corresponding entry in the Font Collection asset, a system font will be used instead.

![](/img/lens-studio/rich-text_font-collection-5.png)

### \<font> and \<family>[​**](#font-and-family "Copy to clipboard")

The `<font>` tag is used to change the font that the text uses by specifying a Font asset name.

* Format: `<font="fontAssetName">Text</font>`
* This must match the name of your Font asset (case and whitespace-insensitive) (for example, "Arial-Regular").

The `<family>` tag is used to change the font family that the text uses.

* Format: `<family="fontFamily">Text</family>`
* `"fontFamily"` will be the same as what you put in the `Font Family` field in a Font Family Asset. The specific font that is used will be based on whatever style is currently set, via inspector or `<italic>`, `<bold>`, `<weight>` and/or `<style>` tags.

For these fonts to actually be available to your Text component, you must assign a Font, FontFamily, or FontCollection asset to the `Font Source` field of your component containing the font or font family specified in your tag.

![](/img/lens-studio/rich-text_font-tag-1.png)

```
This uses the first font with style Regular, <font="ObjektivMk3_BdIt">this uses the Font asset named
ObjektivMk3_BdIt</font>, <family="Merriweather 120pt SemiCondensed"><b>this uses the bold style from Merriweather 120pt
SemiCondensed font family</b>, <style="Light Italic">and this uses the light italic style from Merriweather
120pt SemiCondensed font family.</style></family>
```

![](/assets/images/rich-text_font-tag-4459274ae1b14e84f97010b74b905e05.png)

Note that the `Font Used` field does not reflect any rich text tags. It will only show the font that would be used from purely inspector settings.

![](/img/lens-studio/rich-text_font-tag-2.png)

## Decoration Segment Tags[​**](#decoration-segment-tags "Copy to clipboard")

### \<underline> and \<strikethrough>[​**](#underline-and-strikethrough "Copy to clipboard")

The `<underline>` or `<u>` tag is used to apply a horizontal line under your text.

* Format: `<underline>Text</underline>` or `<u>Text</u>`

The `<strikethrough>` or `<s>` tag is used to apply a horizontal line through the middle of your text.

* Format: `<strikethrough>Text</strikethrough>` or `<s>Text</s>`

```
This is regular text, <u>this is underlined text, <s>this is underlined and
strikethrough text</u>, and this is strikethrough text.</s>
```

![](/assets/images/rich-text_decorationsegments-04491570e3331d165d51cab1de83ab47.png)

## Miscellaneous Tags[​**](#miscellaneous-tags "Copy to clipboard")

### \<lt> and \<gt>[​**](#lt-and-gt "Copy to clipboard")

The `<lt>` tag is used to display the literal less-than (<) in rich text content.

* Format: `<lt>`

The `<gt>` tag is used to display the literal greater-than (>) characters in rich text content.

* Format: `<gt>`

```
In order to display the literal "<lt>" and "<gt>" characters in your Text
component, you should use the <lt>lt<gt> and <lt>gt<gt> tags.
```

![](/assets/images/rich-text_misc-1-4757bbb74165b7bcb3e9c2a02c068165.png)

### \<br>[​**](#br "Copy to clipboard")

The `<br>` tag is used to add a line break to your text.

* Format: `<br>`

```
This is the first line, <br>this is the second line, <br><br>and this is the fourth line.
```

![](/assets/images/rich-text_br-0be5c33b3b0957af5b1c12d26be81f08.png)
