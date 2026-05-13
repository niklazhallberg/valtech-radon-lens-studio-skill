# Visual Studio Code Extension

The Visual Studio Code (VSCode) extension enables code hinting (IntelliSense) and code snippet.

By default, Lens Studio will add a TypeScript definition file `d.ts` in the saved Lens Studio project's `Support` folder. You can get type ahead by opening a saved project folder on an editor that supports it (e.g. VSCode) without this extension.

### Before you begin[​**](#before-you-begin "Copy to clipboard")

1. Download [Visual Studio Code](https://code.visualstudio.com/download).

## Download and configure the extension[​**](#download-and-configure-the-extension "Copy to clipboard")

1. Install [the extension](https://marketplace.visualstudio.com/items?itemName=SnapInc.studio-vscode-extension) from the Visual Studio Marketplace.

![](/img/lens-studio/vscode-extension-1.png)

2. Navigate to **File > Open**

3. Select your Lens Studio project's root folder and click **Open**

![](/assets/images/vscode-extension-3-4b1cf425158860bbf0fc1cfb26b0d7eb.png)

## Use code snippets[​**](#use-code-snippets "Copy to clipboard")

Use code snippets by typing `ls_` and previewing the list of options. Skip the `ls_` prefix if you already know which snippet you need.

Press Enter to select the snippet.

### Input snippets[​**](#input-snippets "Copy to clipboard")

[](/img/lens-studio/vscode-extension-6.webm) [](/img/lens-studio/vscode-extension-7.webm)

* ls\_input\_X (for every valid type)

`ls_input_X` also declares the variable using the /\**@type*/ annotation

* ls\_input\_color\_rgb
* ls\_input\_color\_rgba
* ls\_input\_combobox

### Event snippets[​**](#event-snippets "Copy to clipboard")

[](/img/lens-studio/vscode-extension-8.webm)

* ls\_create\_event
* ls\_create\_stored\_event
* ls\_create\_delayed\_event

### Type name snippets[​**](#type-name-snippets "Copy to clipboard")

[](/img/lens-studio/vscode-extension-9.webm)

* ls\_asset\_name
* ls\_component\_name
* ls\_event\_name

### UI widget snippets[​**](#ui-widget-snippets "Copy to clipboard")

[](/img/lens-studio/vscode-extension-10.webm)

* ls\_ui\_widget
* ls\_ui\_label
* ls\_ui\_group
* ls\_ui\_group\_start
* ls\_ui\_group\_end

### Functional snippets[​**](#functional-snippets "Copy to clipboard")

[](/img/lens-studio/vscode-extension-11.webm) [](/img/lens-studio/vscode-extension-12.webm)

* ls\_get\_sceneobject\_local
* ls\_get\_transform\_local
* ls\_get\_component\_local
* ls\_get\_components\_local
* ls\_create\_component\_local
* ls\_lerp\_function
* ls\_inv\_lerp\_function
* ls\_remap\_function
* ls\_get\_component\_recursive\_function
* ls\_get\_components\_recursive\_function
* ls\_random\_range\_function
* ls\_behavior\_add\_trigger\_response
* ls\_behavior\_send\_trigger
* ls\_behavior\_safe\_add\_trigger\_response
* ls\_behavior\_safe\_send\_trigger
