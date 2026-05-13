# Localization

Localizations Assets allow you to localize text in your Lens so that it can be used by Snapchatters all around the world! The Lens will automatically use the correct localized string provided by a Localizations Asset based on the Snapchatter's device language.

In order to use this feature, you will need to provide your own text localization. Check out the **Localization Template** which provides several examples of commonly localized text.

[](/img/lens-studio/localization_1.webm)

## Localizations Asset[​**](#localizations-asset "Copy to clipboard")

The `Localizations Asset` is a resource in your Lens Studio project that provides the necessary localized text for your Lens. The asset refers to a folder containing files for each language that you’ve translated your texts to.

Unlike other assets, `Localizations Asset` does not need to be added into a `Component`. It simply needs to be in the `Asset Browser` panel of your current project.

![](/assets/images/localization_2-52425da4b3993754b1933c771e957d5e.png)

### Creating a folder of translations[​**](#creating-a-folder-of-translations "Copy to clipboard")

The process of creating a folder to be imported as `Localizations Asset` happens outside of Lens Studio. You can use any text editor to create the required files. However, they should follow the following guidelines to be recognized by Lens Studio.

Each file name should be formatted as such: `strings_[Locale Code].json`,

where the Locale Code represents the content’s language.

![](/assets/images/localization_3-6f63b8d682cec84d6584c29546283508.png)

The contents of the `.json` are key value pairs, where the key is used to refer to the text in the `Text` Component and its value is the localized text. Note that your Key should start with the `@` symbol.

```
{
"@key": "Translated Text",
"@key2": "Another Translated Text"
}
```

**Tip:** the Localizations Asset only cares about the filename. Within the folder, you can have any structure that you want.

Lastly, you’ll also want to add a `strings.json` file. The `strings.json` will be used when the user's device language does not match any of the provided `.json`s. This file is also generally used when the user’s device language isEnglish.

**Tip:** Download an example of this Localization folder

### Dynamic Text and Localization[​**](#dynamic-text-and-localization "Copy to clipboard")

In some cases you may want to add dynamic texts to your localized text. To do so, place the dynamic texts within two curly brackets.

```
{
"@HelloWorld": "Hello {{DisplayName}}"
}
```

### Adding your folder of localizations as a Localizations Asset[​**](#adding-your-folder-of-localizations-as-a-localizations-asset "Copy to clipboard")

To add your localization folder into your project, in the `Asset Browser` panel, press `+`, then `Localization`.

![](data:image/png;base64,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)

In your computer file selection window, navigate to the folder you created in the previous step, and press `Open`.

You should now see your `Localization` file in your `Asset Browser` panel.

You can select the `Localizations` asset and see its content in the `Inspector` panel.

![](/assets/images/localization_5-7b176fe65ec6e69770bc302824ec766d.png)

You can add more than one `Localization Assets` in a Lens! For example you can use the example localization file, while adding your own based on your needs.

## Using your Localized text[​**](#using-your-localized-text "Copy to clipboard")

To use your localized text, simply use the key you’ve defined before in your Text component!

In your `Preview` panel, instead of the `@Key`, you should see its value.

![](/assets/images/localization_6-1c5495cc4e5a8f80aef7f040b5bf6358.png)

Your Text component should not contain any other characters (including a space) other than the keyword. Since languages may work differently, your localized text should contain the placement for any dynamic text within it.

### Testing your Localized text[​**](#testing-your-localized-text "Copy to clipboard")

In the `Preview` panel, you have the option to simulate how your Lens would look in different languages.

Select the `Three Dots` in the far right corner of the panel, then select `Lens Language`, and finally choose the language to preview.

![](/assets/images/localization_7-d146ab7cd3bf5aaf1981b89b63ee75df.png)

## Locale Codes[​**](#locale-codes "Copy to clipboard")

|                         |                              |                 |
| ----------------------- | ---------------------------- | --------------- |
| **Language**            | **Translated Language Name** | **Locale Code** |
| Arabic                  | العربية                      | ar\_AA          |
| Bengali (Bangladesh)    | বাংলা                        | bn\_BD          |
| Bengali (India)         | বাংলা                        | bn\_IN          |
| Chinese (Simplified)    | 简体中文                     | zh\_CN          |
| Chinese (Traditional)   | 繁體中文                     | zh\_TW          |
| Danish                  | Dansk                        | da\_DK          |
| Dutch                   | Nederlands                   | nl\_NL          |
| English (UK)            | English                      | en\_GB          |
| English (US)            | English                      | en\_US          |
| Filipino                | Filipino                     | fil\_PH         |
| Finnish                 | Suomi                        | fi\_FI          |
| French                  | Français                     | fr\_FR          |
| German                  | Deutsch                      | de\_DE          |
| Greek                   | Ελληνικά                     | el\_GR          |
| Gujarati                | ગુજરાતી                      | gu\_IN          |
| Hindi                   | हिंदी                        | hi\_IN          |
| Indonesian              | Bahasa Indonesia             | id\_ID          |
| Italian                 | Italiano                     | it\_IT          |
| Japanese                | 日本語                       | ja\_JP          |
| Kannada                 | ಕನ್ನಡ                        | kn\_IN          |
| Korean                  | 한국어                       | ko\_KR          |
| Malay                   | Bahasa Melayu                | ms\_MY          |
| Malayalam               | മലയാളം                       | ml\_IN          |
| Marathi                 | मराठी                        | mr\_IN          |
| Norwegian               | Norsk                        | nb\_NO          |
| Polish                  | Polski                       | pl\_PL          |
| Portuguese (Brazil)     | Português                    | pt\_BR          |
| Portuguese (Portugal)   | Português                    | pt\_PT          |
| Punjabi                 | ਪੰਜਾਬੀ                       | pa\_IN          |
| Romanian                | Român                        | ro\_RO          |
| Russian                 | Русский                      | ru\_RU          |
| Spanish (Argentina)     | Español (AR)                 | es\_AR          |
| Spanish (International) | Español                      | es\_001         |
| Spanish (Mexico)        | Español (MX)                 | es\_MX          |
| Spanish (Spain)         | Español (ES)                 | es\_ES          |
| Swedish                 | Svenska                      | sv\_SE          |
| Tamil                   | தமிழ்                        | ta\_IN          |
| Telugu                  | తెలుగు                       | te\_IN          |
| Thai                    | ภาษาไทย                      | th\_TH          |
| Turkish                 | Türkçe                       | tr\_TR          |
| Urdu                    | اردو                         | ur\_PK          |
| Vietnamese              | Tiếng Việt                   | vi\_VN          |

Last Update: 8/16/2021
