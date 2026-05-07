# Lens Studio MCP Setup

How to register the Lens Studio MCP server with Claude Code, verify the connection, and recover when tokens rotate. Reusable across all lens projects.

## Contents
- Prerequisites
- Initial registration
- Verification
- Reconnect playbook (token rotation)
- Sanity check via scene-graphql
- Login state for Knowledge Base queries
- Common failure modes

## Prerequisites

- Lens Studio 5.x installed and running
- Claude Code installed
- Working directory matters: start CC from inside the lens project folder (where `.mcp.json` lives) OR from the repo root (where `~/.claude.json` user-scoped registration applies)

## Initial registration

### 1. Open the LS project

The MCP server starts automatically when an LS project is open. Without an open project, no MCP server is available.

### 2. Get MCP credentials from LS

In Lens Studio: **AI Assistant → AI Model Context Protocol (MCP) → Configure Server**.

LS displays the server URL (e.g., `http://localhost:50040/mcp`) and a Bearer token. LS also shows the full `claude mcp add ...` command for convenience — copy that.

### 3. Register with Claude Code

From the project folder:

```bashcd ~/Projects/[your-lens-project]
claude mcp add --transport http --scope local lens-studio http://localhost:[port]/mcp 
--header "Authorization: Bearer [token]"

Scope choice:
- `--scope local` — registration scoped to current directory (recommended for project-specific lens work)
- `--scope user` — registration in `~/.claude.json`, available everywhere

### 4. Verify

```bashclaude mcp list

Expected output includes:lens-studio: http://localhost:[port]/mcp (HTTP) - ✓ Connected

If status is anything other than `✓ Connected`, see "Common failure modes" below.

## Reconnect playbook

Tokens rotate when LS restarts the MCP server. CC's MCP registration uses an in-memory token, so a fresh LS session breaks the connection. Standard recovery sequence — under 3 minutes:

### 1. Restart Lens Studio

Open LS → it picks up the project from the recent-projects list. MCP server starts automatically.

### 2. Get the new credentials

In LS: **AI Assistant → AI Model Context Protocol (MCP) → Configure Server**. Copy the new URL and Bearer token.

### 3. Restart Claude Code from the right directory

```bashcd ~/Projects/[your-lens-project]
claude

Working directory matters — see Prerequisites above.

### 4. Re-register

```bashRemove the stale registration
claude mcp remove lens-studioAdd the new one with current URL and token
claude mcp add --transport http --scope local lens-studio http://localhost:[port]/mcp 
--header "Authorization: Bearer [new-token]"Verify
claude mcp list

Expected: `lens-studio: ... ✓ Connected`.

## Sanity check via scene-graphql

After registration, verify live read access works. Run this GraphQL query via the MCP tool:

```graphql{ rootSceneObjects { id name children { id name } } sceneObjectCount }

Expected for a fresh LS project: 4 SceneObjects — `Camera Object`, `Lighting` (with `Envmap` + `Light` children), and any project-specific objects.

If the query returns scene objects you don't recognize (e.g., `Test_*`, leftover scaffolding), something replayed from a previous session — review the scene before continuing.

## Login state for Knowledge Base queries

`mcp__lens-studio__QueryLensStudioKnowledgeBase` requires Snapchat login state. To enable it:

- LS → Menu Bar → **My Lenses → Login**
- Web → app login propagation can take a moment

Most MCP operations (scene reads, asset imports, component property changes) do NOT require login — only the KB query tool does. The analytics endpoint stays unauthenticated regardless.

## Transient-view gotcha

Some Editor API operations require `Editor.Model.IModel` view re-assignment to persist. The `lensApplicability` setting is the canonical example:

- Reading `project.metaInfo` returns a transient view
- Modifying it requires reassigning back to the model for persistence
- Save with ⌘S to flush to disk
- Verify via on-disk YAML inspection

This pattern applies to other meta-level project settings. When MCP write operations appear to succeed but don't persist after LS reload, suspect transient-view assignment.

## Common failure modes

### `✗ Failed to connect`

**Cause**: LS not running, or MCP server not started.

**Fix**: Open the LS project. Verify in LS that the MCP toggle is on. Check the URL/port in LS matches what you registered with.

### `401 Unauthorized` or `Invalid token`

**Cause**: Token rotated (LS restart) or wrong token copied.

**Fix**: Run the Reconnect playbook above.

### Tools listed but calls fail with `tool not found`

**Cause**: MCP server name mismatch in tool call. Tool calls must use fully qualified names: `mcp__lens-studio__[tool_name]`.

**Fix**: Use the full tool name with the server prefix.

### Connection works, but writes don't persist

**Cause**: Transient-view gotcha (see above). The write succeeds in memory but is lost on LS reload.

**Fix**: Use the view re-assignment pattern. Save with ⌘S after the write. Verify by reloading LS and checking on-disk YAML.

### `Working directory` confusion

**Cause**: CC started from a directory without `.mcp.json` and without user-scope registration.

**Fix**: Either start CC from the project folder (where `.mcp.json` lives) or register with `--scope user` so the registration applies globally.

## When MCP setup fails for too long

Per the skill's guiding principles: if MCP setup exceeds 90 minutes of troubleshooting, skip it. Every lens can be built without MCP — the integration is an efficiency aid, not a requirement. Build manually and resume MCP integration on the next project.

## Stop condition

MCP setup is complete when:

- `claude mcp list` shows `lens-studio: ... ✓ Connected`
- The scene-graphql sanity check returns expected scene objects
- A test write (e.g., creating a Screen Image) persists across LS reload

Only then proceed with MCP-driven workflow. Until then, validate manually in LS.
