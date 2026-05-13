# Tappable Question

This sample project demonstrates a flow where a Snapchatter shares a Story with a question, allowing their friends to reply to it.

![](/img/lens-studio/tappable-question-0.png)

## Tappable Question Mechanic[​**](#tappable-question-mechanic "Copy to clipboard")

The tappable question mechanic works as follows:

1. The Snapchatter customizes a question widget and posts it as a Story.
2. Their friends open the Story, tap on the widget, and reply to the question.
3. The Snapchatter views the replies and can take a Snap with these replies.

## Usage[​**](#usage "Copy to clipboard")

To get started go to the Home page in Lens Studio and find the `Tappable Widget` card in the Sample Project section. Click on the project card to download the project.

You can also download a `Tappable Question Widget` custom component from the Asset Library in the `Featured` folder.

![](/img/lens-studio/tappable-question-3.png)

If you use the custom component independently of the sample project, ensure that the `Camera` containing the component has a `Canvas` component with `World` Unit Type.

`Tappable Question Widget` custom component can only be used in 2D space. It requires to be placed under the Orthographic Camera and Canvas component with `World` Unit Type selected.

![](/img/lens-studio/tappable-question-4.png)

### Customize Widget[​**](#customize-widget "Copy to clipboard")

The question widget can be customized using `Tappable Question Widget` custom component.

![](/img/lens-studio/tappable-question-2.png)

<br />

![](/img/lens-studio/tappable-question-1.png)

* `Manipulated Widget` checkbox: If enabled, the Snapchatter can drag, move, and rotate the widget. If disabled, the widget is static.

* `Question Option`:

  <!-- -->

  * `Editable`: The Snapchatter can tap on the question text and change it.
  * `Static`: The text cannot be modified by tapping.
  * `Static + Editable`: One line of the text (header) is static, and the others are editable.

* `Static` or `Editable` Label: Text on the widget. If you want to break the line, add `\n` to the text input.
  <!-- -->
  ![](/img/lens-studio/tappable-question-5.png)

The following inputs can be folded or unfolded by enabling the `Advanced` checkbox.

* `Top Icon`: A non-interactable icon for visual purposes only.

  * `Hemisphere Color` - color of the hemisphere where the `Top Icon` is located.

* `Corner Icon`: A tappable icon with the following options:

  * `Edit Question`: By tapping on this button, the Snapchatter can modify the question's text.
  * `Random Questions`: By tapping on this icon, a random question from the `Questions` list is selected.
    <!-- -->
    ![](/img/lens-studio/tappable-question-6.png)

* `Background Options`: You can set custom background's color or custom material.

* `Question Text`: You can customize the text color of the question and header. To make the text invisible, adjust the color's opacity to 0.

* `Reply Button`: If enabled, the widget will include a "Reply" button in the capture state.

  ![](/img/lens-studio/tappable-question-7.png)

* `Reply Button Options`: You can adjust the button's color or material and change the button's text color. To see how the widget will look, enable the `Preview` checkbox.

  [](/img/lens-studio/tappable-question-8.webm)

## Previewing Your Lens[​**](#previewing-your-lens "Copy to clipboard")

To preview your Lens in Snapchat, follow the [Pairing to Snapchat](/lens-studio/lens-studio-workflow/pairing-to-snapchat.md) guide.
