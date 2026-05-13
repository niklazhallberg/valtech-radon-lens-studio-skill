# Developer Mode

Developer mode in the Lens Studio AI allows you to leverage AI in the process of building your Lens. This mode incorporates small AI tools that allow you to perform various actions within Lens Studio (e.g. list SceneObjects, setProperty, etc.). These tools are extendable (through plugins called [ChatTools](/lens-studio/extending-lens-studio/plugins-development/chat-tool-plugins.md)) and also accessible through the MCP server and can be utilized in the scripting editor of your choice.

Take a look at the [Example Prompt](/lens-studio/features/lens-studio-ai/custom-prompt-for-mcp.md) to see an example prompt for your code editor / software that can help improve its performance with Lens Studio.

## Interacting with the panel[​**](#interacting-with-the-panel "Copy to clipboard")

1. You can enable Developer mode by toggling the mode drop-down at the bottom of the chat panel where the chat box is.

   ![](/img/lens-studio/5-features/lsai-dev-1.png)

2. You can try one of the example prompts by clicking on them, and pressing enter. Notice that you can ask it to analyze your scene, ask it to debug, add things from the asset library, find trending music, and more!

   ![](/img/lens-studio/5-features/lsai-dev-2.png)

3. Key to the way Developer mode works is the tools it has access to. These tools allow an AI agent to interact with Lens Studio

   ![](/img/lens-studio/5-features/lsai-dev-3.png)

## Interacting with the AI[​**](#interacting-with-the-ai "Copy to clipboard")

1. For example, if you ask the AI what's in the scene, it will call the built-in `Get Scene Graph` tool to give you the answer.

   ![](/img/lens-studio/5-features/lsai-dev-4.png) ![](/img/lens-studio/5-features/lsai-dev-5.png)

2. You can ask it to modify your scene. In some cases, the AI will use multiple tools to answer your prompt.

   ![](/img/lens-studio/5-features/lsai-dev-6.png) ![](/img/lens-studio/5-features/lsai-dev-7.png)

3. You can provide follow-up request as well.

   ![](/img/lens-studio/5-features/lsai-dev-8.png) ![](/img/lens-studio/5-features/lsai-dev-9.png)

   AI will start to lose context the longer a conversation becomes, so at times you might want to start a new conversation to make sure it doesn't lose focus.

4. You can ask the AI to add interactivity, and it will try to make a script for you.

   ![](/img/lens-studio/5-features/lsai-dev-10.png) ![](/img/lens-studio/5-features/lsai-dev-11.png)

5. If you have an error in your project, or the AI makes a mistake, you can ask it to double check its work, or help you fix it.

   ![](/img/lens-studio/5-features/lsai-dev-12.png)

6. To help you learn, the AI will give you instructions on how to do the things you want to achieve. But you can tell the AI to do it for you as well!

   ![](/img/lens-studio/5-features/lsai-dev-13.png)

## Adding Additional Tools[​**](#adding-additional-tools "Copy to clipboard")

As you start to develop more specialized Lenses, you might want to add your own tools.

Tools are just [Lens Studio plugins](/lens-studio/extending-lens-studio/plugins/overview.md), that extend the ChatTool class.

You can find additional ChatTools in the [Asset Library](/lens-studio/assets-pipeline/asset-library/asset-library-overview.md).

![](/img/lens-studio/5-features/lsai-dev-14.png)

Once installed, you will find it in the tools list.

![](/img/lens-studio/5-features/lsai-dev-15.png)

You can also add a [Chat Tool](/lens-studio/extending-lens-studio/plugins-development/chat-tool-plugins.md) by pressing the `Add New Tool` in the tool configurator.

![](/img/lens-studio/5-features/lsai-dev-16.png)

Since these are just tools, you can manage them in the Lens Studio Preferences. You can even include a folder with many tools, and share it with your team!

## Using Lens Studio AI with other LLMs[​**](#using-lens-studio-ai-with-other-llms "Copy to clipboard")

You can expose these various tools using [MCP](https://modelcontextprotocol.io/docs/getting-started/intro) to be accessed by other AI agents, or code editors.

In the Lens Studio menu bar, you can click on the `AI Assistant > MCP > Configure Server` to start an MCP server that allows your other software to drive Lens Studio.

![](/img/lens-studio/5-features/lsai-dev-17.png)

In the popup window, click `Start Server`, and then `Copy MCP Config`.

![](/img/lens-studio/5-features/lsai-dev-18.png)

In your clipboard, you will get something like this:

```
{
    "servers": {
        "lens-studio": {
            "headers": {
                "Authorization": "[some key]"
            },
            "type": "http",
            "url": "http://localhost:8732/mcp"
        }
    }
}
```

You can apply these settings in your preferred software. Please refer to your software's documentation for instructions on how to use this configuration.

Take a look at the [Example Prompt](/lens-studio/features/lens-studio-ai/custom-prompt-for-mcp.md) which you can use to optimize your code editor's performance when working with Lens Studio.
