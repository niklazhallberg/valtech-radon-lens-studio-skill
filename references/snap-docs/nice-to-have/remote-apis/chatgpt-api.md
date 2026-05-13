# ChatGPT API

This remote API enables you to make calls to OpenAI’s large language model (LLM), ChatGPT, from your Lens. GPT remote API requests send a text prompt to ChatGPT and receive a detailed response. You can use the response to trigger subsequent interactions in your Lens, such as showing the text response in your Lens UI, or calling other functions.

## Accessing ChatGPT Remote API[​**](#accessing-chatgpt-remote-api "Copy to clipboard")

To try out ChatGPT in Lens Studio 5.0, go to the Asset Library, where you can find several helpers:

1. **ChatGPT Helper Demo:** adds the ChatGPT Custom Component as well as a simple example script that prints out the result from ChatGPT.
2. **ChatGPT Helper Custom Component:** an installable Custom Component that allows you to quickly add GPT into any Lens via the Add New Components menu.

The ChatGPT Remote API’s input and output goes through human and programmatic moderation. If the prompt fails any of the tests, the API request will fail.

ChatGPT is part of the remote service module. Learn more about [restrictions](/lens-studio/features/remote-apis/remote-service-module.md#restrictions) when using any RemoteAPIs.

## Example[​**](#example "Copy to clipboard")

You can take a look at a simple example, by downloading the ChatGPT Helper Demo in the Asset Library.

![](/assets/images/gpt-0-b17a0fb64097f1df1552df47caa027ad.png)

Once imported, Drag the Scene prefab found inside the Chat\_GPT\_Helper folder into your `Scene Hierarchy` panel.

With the `ChatGPT Demo` object selected, you can change the question to ChatGPT in the Inspector panel. Tap the Preview panel to run the query.

![](/assets/images/gpt-1-01ea67d6afa0c056d2bd8818993aa6d9.png)

Next, you should display the result into our Lens. In this example, you will add a text attached to the user’s head. To do so:

* In the `Scene Hierarchy` panel, add a `Head Binding` object.

* With Then add a `Text` object.

* Customize the text in `Inspector Panel` as much as you would like.

  ![](/assets/images/gpt-2-e47c57073a8ab06544c05fb3e342f6ee.png)

* Double click the `ChatGPT Demo` script in the `Asset Browser`, to open the script up in the `Script Editor`.

* Add `// @input Component.Text outputDisplay` at the top of the file so the script can have access to the `Text` object you just added.

  In addition, you will show the ChatGPT main answer in this text field. Right after `print(mainAnswer);` we’ll add: `script.outputDisplay.text = mainAnswer`.

  Our final script looks something like this:

```
// @input string question = "What are some ideas for Lenses?"
// @input Component.Text outputDisplay

const request = {
  temperature: 1,
  messages: [{ role: 'user', content: script.question }],
};

function requestGPT() {
  print(`Requesting answer for: ${script.question}`);

  global.chatGpt.completions(request, (errorStatus, response) => {
    if (!errorStatus && typeof response === 'object') {
      const mainAnswer = response.choices[0].message.content;
      print(mainAnswer);
      script.outputDisplay.text = mainAnswer;
    } else {
      print(JSON.stringify(response));
    }
  });
}

script.createEvent('TapEvent').bind(requestGPT);
print('Tap to call GPT!');
```

* Once you’ve added and saved the line, you should now see a new input in the ChatGPT Demo. Click on the new input field and select your text component.

Now, when you tap on the screen, you should see that your text gets replaced by ChatGPT.

Finally, you can add some finishing touches:

* You can update your prompt to meet your Lens needs. For example, you can modify the `Question` input in the ChatGPT Demo script with our own theme: `One sentence advice for the day`.
* Then, add a hint to tell the user to tap the screen with a prompt set to `Tap to get advice` as the text in our text component.
* Lastly, in the ChatGPT Demo script, you can increase the `Temperature` option to 1, to tell GPT you want as much creativity as possible (0-1 value).

![](/assets/images/gpt-3-caf15ef6ef7f50e240c5a21410fd0678.png)

Here’s what the final Lens looks like:

[](/img/lens-studio/5-remote-api/gpt-5.webm)

## Please read before using this API[​**](#please-read-before-using-this-api "Copy to clipboard")

We have very rigorous guidelines around the ChatGPT Remote API to protect Lens Creators and Snapchatters. These guidelines will be revisited as we better understand usage of the API.

AR Moderation will review all submitted lenses and ensure that they are following the Community guidelines and they DO NOT include any of the following:

* Enable open questions to ChatGPT
* Enable back and forth conversations to ChatGPT
* Solicit user’s personal information (e.g., username, name, bitmoji, age, location, etc); this includes user based context in Lenses
* Allow users to be susceptible to abuse.
* Non-English
* Ask questions about Snap's privacy practices
* Ask question about Snapchat
* Ask or solicit sensitive information or responses about risky topics (e.g., race, religion, sexual orientation, politics, Hammas/Israel, where should I go hiking this weekend, etc.)
* Ask about the user’s location
* Ask anything sexually suggestive, not just sexually explicit
* Use of persistent storage (esp global scope) eg: persistent Lenses, connected Lenses with shared experiences between users
* Access to 3P APIs (eg: Horoscope API, weather API etc)

AR Moderation will only allow list these Lenses in the [countries that Open AI has made ChatGPT available](https://platform.openai.com/docs/supported-countries). AR Moderation will reject Lenses that violate above criteria and **Disable in Discover those Lenses that do align with current Lens policies.** Read: Lenses with the ChatGPT API will be disabled in discover by default, and limited to social unlocking. There will be a limited number of Lenses using this functionality in discovery or available in ranking at a given period of time.
