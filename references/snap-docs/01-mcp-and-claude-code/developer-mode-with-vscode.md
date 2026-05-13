# Developer Mode Using Visual Studio Code

This guide will walk you through setting up Lens Studio's MCP server with Visual Studio Code (VSCode), allowing you to use AI-powered tools to control Lens Studio directly from your code editor.

This guide is provided to support developers using Visual Studio Code, as we've seen its growing popularity across our developer community. For official VSCode MCP documentation, please refer to [VSCode's MCP Documentation](https://code.visualstudio.com/docs/copilot/customization/mcp-servers).

## Prerequisites[​**](#prerequisites "Copy to clipboard")

* Visual Studio Code installed on your system
* Lens Studio installed on your system
* Chat Tool Package installed from Asset Library (see [Adding Additional Tools](/lens-studio/features/lens-studio-ai/developer-mode.md#adding-additional-tools))

## Setup Steps[​**](#setup-steps "Copy to clipboard")

### 1. Create VSCode Configuration Folder[​**](#1-create-vscode-configuration-folder "Copy to clipboard")

First, create a `.vscode` folder at the root of your project if it doesn't already exist.

```
mkdir .vscode
```

### 2. Create MCP Configuration File[​**](#2-create-mcp-configuration-file "Copy to clipboard")

Inside the `.vscode` folder, create a file named `mcp.json`:

```
touch .vscode/mcp.json
```

### 3. Start the MCP Server in Lens Studio[​**](#3-start-the-mcp-server-in-lens-studio "Copy to clipboard")

Go back to Lens Studio and start the MCP server:

1. Open the Lens Studio menu bar

2. Click on **AI Assistant > MCP > Configure Server**

   ![](/img/lens-studio/mcp-context-eng/ai-assistant-config-server.png)

3. In the popup window, click **Start Server**

   ![](/img/lens-studio/mcp-context-eng/mcp-server-conifg-window-ls.png)

### 4. Copy the MCP Configuration[​**](#4-copy-the-mcp-configuration "Copy to clipboard")

Click on **Copy MCP Config** in the Lens Studio MCP configuration window.

This will copy configuration details that look like this:

```
{
  "servers": {
    "lens-studio": {
      "headers": {
        "Authorization": "Bearer [your-auth-token]"
      },
      "type": "http",
      "url": "http://localhost:8732/mcp"
    }
  }
}
```

### 5. Add Configuration to VSCode[​**](#5-add-configuration-to-vscode "Copy to clipboard")

Open the `mcp.json` file you created in the `.vscode` folder and paste the configuration.

#### If you already have other MCP servers configured:[​**](#if-you-already-have-other-mcp-servers-configured "Copy to clipboard")

Add the Lens Studio configuration to your existing `servers` object:

```
{
  "servers": {
    "existing-server": {
      "headers": {
        "Authorization": "Bearer your-existing-token"
      },
      "type": "http",
      "url": "your-existing-url"
    },
    "lens-studio": {
      "headers": {
        "Authorization": "Bearer [your-auth-token]"
      },
      "type": "http",
      "url": "http://localhost:8732/mcp"
    }
  }
}
```

#### If this is your first MCP server:[​**](#if-this-is-your-first-mcp-server "Copy to clipboard")

Your configuration will look like this:

```
{
  "servers": {
    "lens-studio": {
      "headers": {
        "Authorization": "Bearer [your-auth-token]"
      },
      "type": "http",
      "url": "http://localhost:8732/mcp"
    }
  }
}
```

![](/img/lens-studio/mcp-context-eng/vscode-mcp-json.png)

### 6. Start the MCP Server in VSCode[​**](#6-start-the-mcp-server-in-vscode "Copy to clipboard")

In VSCode, you'll see a "Start" text link appear just above your server configuration in the `mcp.json` file. Click this to start the MCP connection.

![](/img/lens-studio/mcp-context-eng/vscode-start.png)

Once started, you should see confirmation that the server is running:

![](/img/lens-studio/mcp-context-eng/vscode-running.png)

### 7. View Available MCP Tools[​**](#7-view-available-mcp-tools "Copy to clipboard")

You can view the details of available Lens Studio MCP tools:

![](/img/lens-studio/mcp-context-eng/vscode-see-tools.png)

You can also see the full list of available tools by checking the MCP panel in VSCode:

![](/img/lens-studio/mcp-context-eng/vscode-mcp-list.png)

### 8. Start Using Lens Studio with VSCode[​**](#8-start-using-lens-studio-with-vscode "Copy to clipboard")

Open the chat interface in VSCode and start interacting with your Lens Studio instance! Make sure your MCP server is still running in Lens Studio.

Here's an example of VSCode Chat using the Lens Studio MCP tools. Notice how the AI assistant calls various tools like `GetLensStudioSceneGraph`, `CreateLensStudioSceneObject`, and other MCP functions to interact with your Lens Studio project:

![](/img/lens-studio/mcp-context-eng/vscode-test-in-chat.png)

For optimal results, consider using the [Example Prompt](/lens-studio/features/lens-studio-ai/custom-prompt-for-mcp.md) to help improve VSCode's performance with Lens Studio.

## Using Chat Modes for Better Results[​**](#using-chat-modes-for-better-results "Copy to clipboard")

VSCode Chat Modes allow you to customize how the AI assistant behaves when working with your Lens Studio projects. By setting up chat modes, you can significantly improve the quality and relevance of the AI's responses.

### What Are Chat Modes?[​**](#what-are-chat-modes "Copy to clipboard")

Chat Modes act as system prompts that guide the AI assistant to:

* **Follow specific workflows** - Force the AI to go through certain tasks in a particular order
* **Consider project context** - Direct the AI to look across specific context folders for relevant information
* **Adopt a specific style** - Define how the AI should structure and format its answers
* **Understand Lens Studio specifics** - Inform the AI about Lens Studio conventions, APIs, and best practices

This knowledge helps the AI deliver more accurate and relevant results tailored to your Lens Studio development workflow.

### Setting Up Chat Modes[​**](#setting-up-chat-modes "Copy to clipboard")

1. In your project root, create a `.github` folder if it doesn't exist, then create a `chatmodes` folder inside it:

   ```
   mkdir -p .github/chatmodes
   ```

2. In VSCode, you can configure and select your chat modes:

   ![](/img/lens-studio/mcp-context-eng/vscode-configure-modes.png)

3. Create a new chat mode file (e.g., `lens-studio.md`) inside `.github/chatmodes/`:

   ![](/img/lens-studio/mcp-context-eng/vscode-chatmodes.png)

4. Add your custom rules that define how the AI should interact with your Lens Studio project. You can include information about:

   * Lens Studio API conventions
   * Your preferred coding style
   * Common patterns in your project
   * Specific workflows for Lens development

You can use the [Example Prompt](/lens-studio/features/lens-studio-ai/custom-prompt-for-mcp.md) as a starting point for your Chat Mode. This prompt includes comprehensive guidelines for working with Lens Studio's TypeScript API and MCP tools.

## Next Steps[​**](#next-steps "Copy to clipboard")

Now that you've connected VSCode to Lens Studio, you can:

* Ask questions about your scene structure
* Request modifications to objects and components
* Generate scripts and add interactivity
* Debug issues in your project
* Search and install assets from the Asset Library

The MCP server must be running in Lens Studio for the connection to work. If you close Lens Studio or stop the server, you'll need to restart it and potentially update the authorization token in your VSCode configuration.
