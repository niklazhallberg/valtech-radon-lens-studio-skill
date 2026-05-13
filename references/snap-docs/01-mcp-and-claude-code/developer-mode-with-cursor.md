# Developer Mode Using Cursor IDE

This guide will walk you through setting up Lens Studio's MCP server with Cursor IDE, allowing you to use AI-powered tools to control Lens Studio directly from your code editor.

This guide is provided to support developers using Cursor IDE, as we've seen its growing popularity across our developer community. For official Cursor MCP documentation, please refer to [Cursor's MCP Documentation](https://cursor.com/docs/context/mcp).

## Prerequisites[​**](#prerequisites "Copy to clipboard")

* Cursor IDE installed on your system
* Lens Studio installed on your system
* Chat Tool Package installed from Asset Library (see [Adding Additional Tools](/lens-studio/features/lens-studio-ai/developer-mode.md#adding-additional-tools))

## Setup Steps[​**](#setup-steps "Copy to clipboard")

### 1. Access MCP Settings in Cursor[​**](#1-access-mcp-settings-in-cursor "Copy to clipboard")

First, you need to access the MCP configuration in Cursor. You can do this by:

* Typing `>mcp` in the command palette at the top bar
* Clicking on "View MCP Settings"

Alternatively, navigate to **Tools and MCP** and click on **Add Custom MCP**.

![](/img/lens-studio/mcp-context-eng/palette-mcp-settings.png)

### 2. Open the MCP Configuration File[​**](#2-open-the-mcp-configuration-file "Copy to clipboard")

You will be directed to a `.json` file (typically `mcp_config.json`) where you can configure your MCP servers. This file may be empty initially if you haven't configured any MCP servers yet.

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

### 5. Add Configuration to Cursor[​**](#5-add-configuration-to-cursor "Copy to clipboard")

Head back to Cursor and open the MCP configuration `.json` file.

#### If you already have other MCP servers configured:[​**](#if-you-already-have-other-mcp-servers-configured "Copy to clipboard")

Add the Lens Studio configuration to your existing `mcpServers` object:

```
{
  "mcpServers": {
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
  "mcpServers": {
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

### 6. Enable the MCP Server in Cursor[​**](#6-enable-the-mcp-server-in-cursor "Copy to clipboard")

Go back to **Tools and MCP** in Cursor. Your Lens Studio MCP server will now be available and ready to be enabled.

![](/img/lens-studio/mcp-context-eng/mcp-enabled.png)

You can see all available tools by clicking on the tools count (e.g., "xx tools enabled").

![](/img/lens-studio/mcp-context-eng/mcp-tools-examples.png)

### 7. Start Using Lens Studio with Cursor[​**](#7-start-using-lens-studio-with-cursor "Copy to clipboard")

1. Restart Cursor to ensure all changes take effect
2. Start a new chat in Cursor
3. Make sure your MCP server is still running in Lens Studio
4. You can now use Cursor Chat to interact with and control your Lens Studio instance!

Here's an example of Cursor using the Lens Studio MCP tools. Notice how the AI assistant calls various tools like `GetLensStudioSceneGraph` and `SetLensStudioProperty` to interact with your Lens Studio project:

![](/img/lens-studio/mcp-context-eng/cursor-chat-example.png)

For optimal results, consider using the [Example Prompt](/lens-studio/features/lens-studio-ai/custom-prompt-for-mcp.md) to help improve Cursor's performance with Lens Studio.

## Using Cursor Rules for Better Results[​**](#using-cursor-rules-for-better-results "Copy to clipboard")

Cursor Rules allow you to customize how the AI assistant behaves when working with your Lens Studio projects. By setting up rules, you can significantly improve the quality and relevance of the AI's responses.

### What Are Cursor Rules?[​**](#what-are-cursor-rules "Copy to clipboard")

Cursor Rules act as a system prompt that guides the AI assistant to:

* **Follow specific workflows** - Force the AI to go through certain tasks in a particular order
* **Consider project context** - Direct the AI to look across specific context folders for relevant information
* **Adopt a specific style** - Define how the AI should structure and format its answers
* **Understand Lens Studio specifics** - Inform the AI about Lens Studio conventions, APIs, and best practices

This knowledge helps the AI deliver more accurate and relevant results tailored to your Lens Studio development workflow.

### Setting Up Cursor Rules[​**](#setting-up-cursor-rules "Copy to clipboard")

1. In Cursor, navigate to your project settings or create a `.cursorrules` file in your project root.

   ![](/img/lens-studio/mcp-context-eng/cursor-rules-1.png)

2. Add your custom rules that define how the AI should interact with your Lens Studio project. You can include information about:

   * Lens Studio API conventions
   * Your preferred coding style
   * Common patterns in your project
   * Specific workflows for Lens development

   ![](/img/lens-studio/mcp-context-eng/cursor-rules-2.png)

You can use the [Example Prompt](/lens-studio/features/lens-studio-ai/custom-prompt-for-mcp.md) as a starting point for your Cursor Rules. This prompt includes comprehensive guidelines for working with Lens Studio's TypeScript API and MCP tools.

## Next Steps[​**](#next-steps "Copy to clipboard")

Now that you've connected Cursor to Lens Studio, you can:

* Ask questions about your scene structure
* Request modifications to objects and components
* Generate scripts and add interactivity
* Debug issues in your project
* Search and install assets from the Asset Library

The MCP server must be running in Lens Studio for the connection to work. If you close Lens Studio or stop the server, you'll need to restart it and potentially update the authorization token in your Cursor configuration.
