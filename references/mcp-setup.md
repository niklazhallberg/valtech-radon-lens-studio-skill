# Lens Studio MCP Setup

How to register the Lens Studio MCP server with Claude Code, verify the connection, and recover when tokens rotate. Reusable across all lens projects.

## Contents
- Prerequisites
- Initial registration
- Verification
- Reconnect playbook (token rotation)
- Sanity check via scene-graphql
- Login state for Knowledge Base queries
- MCP tool patterns (logs, screenshots, selection, deferred loading)
- Auto-accept vs manual-approval policy
- Transient-view persistence (MetaInfo write-back)
- Common failure modes
- When MCP setup fails for too long
- Stop condition

## Prerequisites

- Lens Studio 5.x installed and running
- Claude Code installed
- Chat Tool Package installed in the LS project (via Asset Library — see Initial registration step 2 below)
- Working directory matters: start CC from inside the lens project folder (where `.mcp.json` lives) OR from the repo root (where `~/.claude.json` user-scoped registration applies)

## Initial registration

### 1. Open the LS project

The MCP server starts automatically when an LS project is open. Without an open project, no MCP server is available.

### 2. Install Chat Tool Package (if not yet installed)

Snap's official documentation specifies Chat Tool Package as a prerequisite for full MCP tool exposure. Empirically we've seen core MCP functionality (`scene-graphql`, `asset-graphql`, asset-library tools) work without explicit Chat Tool Package install — so the package may be auto-installed in LS 5.20+ projects, or only required for specific tools (generators, knowledge-base queries).

**To be safe** — install it explicitly the first time you set up a new lens project:

1. In LS: open **Asset Library** (left panel)
2. Search for "Chat Tool"
3. Click Install on the Chat Tool Package result

**Symptom if missing:** ToolSearch may return a partial tool list. If a tool you expect (especially `QueryLensStudioKnowledgeBase` or AI generators) appears absent, suspect Chat Tool Package.

**Verify:** LS → Project Settings → Installed Packages — should list Chat Tool Package (exact path may vary by LS version — untested).

### 3. Get MCP credentials from LS

In Lens Studio: **AI Assistant → AI Model Context Protocol (MCP) → Configure Server**.

LS displays the server URL (e.g., `http://localhost:50040/mcp`) and a Bearer token. LS also shows the full `claude mcp add ...` command for convenience — copy that.

### 4. Register with Claude Code

From the project folder:

```bash
cd ~/Projects/[your-lens-project]
claude mcp add --transport http --scope local lens-studio http://localhost:[port]/mcp \
  --header "Authorization: Bearer [token]"
```

Scope choice:
- `--scope local` — registration scoped to current directory (recommended for project-specific lens work)
- `--scope user` — registration in `~/.claude.json`, available everywhere

### 5. Verify

```bash
claude mcp list
```

Expected output includes:

```
lens-studio: http://localhost:[port]/mcp (HTTP) - ✓ Connected
```

If status is anything other than `✓ Connected`, see "Common failure modes" below.

## Reconnect playbook

Tokens rotate when LS restarts the MCP server. CC's MCP registration uses an in-memory token, so a fresh LS session breaks the connection. Standard recovery sequence — under 3 minutes:

### 1. Restart Lens Studio

Open LS → it picks up the project from the recent-projects list. MCP server starts automatically.

### 2. Get the new credentials

In LS: **AI Assistant → AI Model Context Protocol (MCP) → Configure Server**. Copy the new URL and Bearer token.

### 3. Restart Claude Code from the right directory

Exit the current Claude Code session first. In the same terminal where you originally started Claude Code, then run:

```bash
cd ~/Projects/[your-lens-project]
claude
```

Working directory matters — see Prerequisites above.

**Wording note for the assistant (mentor-tone):** Never coach the user with "in the terminal where Claude Code is running" — they are typing into Claude Code right now, so the phrasing is ambiguous and confusing. Use this pattern instead:

> "Här i den här chatten där du skriver till mig nu: skriv `/exit` och tryck enter. Det stänger vår nuvarande session. Sen — i samma terminalfönster du startade mig från första gången — kör `claude` igen, så är vi tillbaka med MCP omladdat."

The principle: name what the user is looking at (this chat) and name what they need to do next (exit + restart) in concrete first-person language, not abstract "the terminal".

### 4. Re-register

```bash
# Remove the stale registration
claude mcp remove lens-studio

# Add the new one with current URL and token
claude mcp add --transport http --scope local lens-studio http://localhost:[port]/mcp \
  --header "Authorization: Bearer [new-token]"

# Verify
claude mcp list
```

Expected: `lens-studio: ... ✓ Connected`.

## Sanity check via scene-graphql

After registration, verify live read access works. Run this GraphQL query via the MCP tool:

```graphql
{
  rootSceneObjects {
    id
    name
    children { id name }
  }
  sceneObjectCount
}
```

Expected for a fresh LS project: 4 SceneObjects — `Camera Object`, `Lighting` (with `Envmap` + `Light` children), and any project-specific objects.

If the query returns scene objects you don't recognize (e.g., `Test_*`, leftover scaffolding), something replayed from a previous session — review the scene before continuing.

## Login state for Knowledge Base queries

`mcp__lens-studio__QueryLensStudioKnowledgeBase` requires Snapchat login state. To enable it:

- LS → Menu Bar → **My Lenses → Login**
- Web → app login propagation can take a moment

Most MCP operations (scene reads, asset imports, component property changes) do NOT require login — only the KB query tool does. The analytics endpoint stays unauthenticated regardless.

## MCP tool patterns

Beyond `scene-graphql` and `asset-graphql` mutations, several MCP tools support specific workflows. Schemas are often deferred — load via `ToolSearch` before first call.

### `RunAndCollectLogsTool` — force Preview refresh + log tailing

Refreshes the LS Preview panel and returns a log file path + byte offset for tailing runtime output.

```
RunAndCollectLogsTool() → { status, logFile, byteOffset }
```

Read the log file from `byteOffset` to inspect what scripts logged during the refresh. Use for:
- Verifying scripts executed without runtime errors
- Reading state-machine transition logs
- Catching console.log output from controllers

**Auto-approve**: read-only — doesn't mutate scene state.

### `CapturePanelScreenshotTool` — base64-encoded JPEG of a panel

```
CapturePanelScreenshotTool({
  pluginId: "Snap.Plugin.Gui.PreviewPanel",
  detail: "auto"  // or "low" / "high"
})
```

Common `pluginId` values:
- `Snap.Plugin.Gui.PreviewPanel` — lens output (what user sees)
- `Snap.Plugin.Gui.SceneEditor` — 3D viewport
- `Snap.Plugin.Gui.InspectorPanel` — properties panel

Returns base64 JPEG. Use for visual verification during build, especially when tuning closed-state layouts or animation midpoints.

**Auto-approve**: read-only.

### `SetLensStudioSelection` — direct user to specific SceneObject

Programmatically select SceneObjects in LS Inspector. Useful for Inspector handoff (Guiding Principle 7).

```
SetLensStudioSelection({
  mode: "set",       // or "add" / "clear"
  ids: ["<uuid>"]
})
```

LS Inspector + Scene Editor panels jump to the selection. Use when handing off to user for live tuning of "feel" parameters (magnitude, easing, color). See `prompt-templates.md` → Inspector handoff.

**Auto-approve**: doesn't modify scene state, just UI focus.

### `RecompileTypeScriptTool` — re-compile project's TS, surface errors

```
RecompileTypeScriptTool()
```

Returns status + error log path. Run after every script edit, BEFORE attempting scene-graphql wiring. Wiring against a script with compile errors = silent failure (the new @input fields don't exist yet).

**Auto-approve**: read-only output (status + log path).

### `QueryLensStudioKnowledgeBase` — Snap-curated docs

Requires Snap login active in LS (see "Login state for Knowledge Base queries" above).

```
QueryLensStudioKnowledgeBase("<question or topic>")
```

Returns curated documentation. Use as authority source when:
- Validating an API pattern against Snap's documented behavior
- Recovering from "API mismatch" failures (Category A in `error-recovery.md`)
- Cross-checking enum values, property surface, component types

**Caveat**: KB content may lag LS version. If KB says X but live LS shows Y, trust live LS — that's what runs.

### ToolSearch deferred-tool loading

Many MCP tools have deferred schemas. Calling them directly fails with InputValidationError until ToolSearch loads the schema.

```
ToolSearch(query: "select:mcp__lens-studio__SetLensStudioSelection")
```

After ToolSearch returns, the tool is callable. Load lazily — schemas consume context.

---

## Auto-accept vs manual-approval policy

Per Operational Rule 3 in `operational-rules.md`. Quick reference for MCP-specific tools:

**Auto-accept (read-only)**:
- All `scene-graphql` / `asset-graphql` query operations
- `RunAndCollectLogsTool` (refreshes Preview, doesn't mutate)
- `CapturePanelScreenshotTool`
- `SetLensStudioSelection` (UI focus, not scene state)
- `RecompileTypeScriptTool` (status-only)
- `ListInstalledPackagesTool`
- `QueryLensStudioKnowledgeBase`

**Manual approval per call**:
- Any `setProperty`, `createSceneObject`, `deleteSceneObject`, `setParent`, `addComponent`, `removeComponent`, `instantiatePrefab`
- Any `asset-graphql` mutation
- Package installs via MCP
- `claude mcp add`, `claude mcp remove`

When a series of related mutations is probed-and-validated (Rule 6), batch them in a single alias-mutation block — ONE permission prompt for the logical unit, not per-mutation. See `lens-studio-api-gotchas.md` → "Batched alias-mutation pattern".

---

## Transient-view persistence (MetaInfo write-back)

Some Editor API operations require `Editor.Model.IModel` view re-assignment to persist. The `lensApplicability` setting is the canonical example, but the pattern applies to other meta-level project settings.

### Symptom

MCP write appears to succeed:
- `setProperty` returns `success: true`
- In-call read shows new value
- Live LS shows updated value in Inspector

BUT:
- Cross-call read shows old value
- LS reload reverts to previous value
- On-disk YAML never updates

### Fix — view write-back pattern

```typescript
project.history.executeAsGroup("update metaInfo", () => {
  const meta = project.metaInfo;                                  // Read returns transient view
  meta.lensApplicability = [Editor.Model.LensApplicability.Front]; // Modify
  (project as any).metaInfo = meta;                               // REQUIRED: reassign back
});
// User must ⌘S to flush to disk
```

Then verify by:
1. ⌘S in LS
2. `git diff lens/[project].esproj` — should show the YAML change
3. Reload LS, check that value persists

### Applies to

- `lensApplicability` (Front, Back, World)
- `trackingModes` (face tracking, hand tracking, etc.)
- Camera modes
- Other `Editor.Model.MetaInfo`-rooted project settings

When MCP writes to project-level metadata appear to succeed but don't persist after LS reload, suspect transient-view assignment.

See `lens-studio-api-gotchas.md` → "setProperty Category 6: Editor.Model.MetaInfo" for the canonical recipe.

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
