# Troubleshooting — detailed debug guide

For users who want detailed debug info beyond the agent's interactive 1-2-question diagnosis. **The agent's troubleshooting decision tree handles most cases in 1-2 turns.** Use this doc when:

- The agent has tried 2 fixes and the issue persists
- You want to understand *why* something failed, not just fix it
- You're debugging an edge case beyond standard scenarios
- You're setting up advanced workflows (multiple LS instances, CI integration, etc.)

If you'd prefer interactive help, return to Claude Code and describe the symptom. The agent will diagnose live.

## Contents
- Install issues
- MCP issues
- Build-mode issues
- Submission issues
- Performance issues
- LS-specific quirks
- When to escalate beyond this doc

---

## Install issues

### "claude command not found"

**Causes**:
1. Claude Code not installed
2. Install dir not in PATH

**Fix**:

```bash
# Check install
which claude

# If nothing returned, install:
#   curl -fsSL https://claude.ai/install.sh | bash

# If installed but command not found:
echo $PATH
# Check if Claude Code install dir (e.g., /opt/homebrew/bin) is in PATH

# Add to PATH (macOS zsh):
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
which claude
```

For Windows: ensure Claude Code's install dir is in your System PATH environment variable. Restart terminal after PATH changes.

### "Skill not loading"

Symptom: ask Claude about Lens Studio, it doesn't reference the pipeline or use any skill-specific knowledge.

**Causes**:
1. Skill file in wrong location
2. SKILL.md missing or renamed
3. Skill overrides set to disable it

**Fix**:

```bash
# Verify file location
ls ~/.claude/skills/lens-studio-snapchat-filter/SKILL.md

# Check frontmatter is intact
head -12 ~/.claude/skills/lens-studio-snapchat-filter/SKILL.md
# Should show YAML between --- markers

# Check for skill overrides in settings
cat ~/.claude/settings.json | grep -A3 "skillOverrides"
# If "lens-studio-snapchat-filter": "off" present, change to "on"

# Restart Claude Code
claude
```

If still not loading, the skill description may not match your question. Try explicit triggering:

> "Use the lens-studio-snapchat-filter skill to help me plan a Snap lens for [client]."

### "Lens Studio won't open / crashes on launch"

**Causes**:
1. Wrong LS version (older than 5.20)
2. Corrupt LS preferences
3. macOS Gatekeeper

**Fix**:

```bash
# Check LS version
mdls -name kMDItemVersion "/Applications/Lens Studio.app" 2>/dev/null

# If < 5.20: download latest from https://ar.snap.com/download
```

Reset LS preferences:
- macOS: `Shift+Option-click` LS icon in Applications → "Reset Preferences"
- Or manually: delete `~/Library/Application Support/Snap Inc/Lens Studio` (back up first if you have unsaved projects)

macOS Gatekeeper: right-click LS app in Applications → Open → "Open anyway".

If crashes persist on launch: file a bug with Snap support (support.snap.com), include LS version, macOS/Windows version, and crash log.

---

## MCP issues

### "✗ Failed to connect" or "401 Unauthorized"

**#1 most common cause**: token rotation after LS restart.

**Fix**:

```bash
# Get fresh credentials from LS:
# AI Assistant → AI Model Context Protocol (MCP) → Configure Server

# Re-register
claude mcp remove lens-studio
claude mcp add --transport http --scope local lens-studio http://localhost:NEW_PORT/mcp \
  --header "Authorization: Bearer NEW_TOKEN"
claude mcp list
# Should show: ✓ Connected
```

If still failing:

1. **LS not running**: open LS, ensure a project is open. MCP server only starts when a project is loaded.

2. **Port changed**: LS sometimes picks a new port on restart. Use the port currently shown in LS Configure Server panel, not the old one.

3. **Multiple LS instances**: if you have multiple LS windows open, each may have its own MCP server. Verify you're using the port for the right project.

4. **Firewall blocking localhost**: rare, but check macOS Firewall settings (System Settings → Network → Firewall). Allow localhost connections.

### "tool not found: mcp__lens-studio__X"

**Cause**: tool schema not loaded (deferred-tool pattern).

**Fix**: in Claude Code, the agent should run `ToolSearch` to load the schema before calling. If you see this in transcripts, the agent missed it — tell it "load that tool schema first".

### "Writes succeed but don't persist after LS reload"

**Cause**: transient-view gotcha for `Editor.Model.MetaInfo` field mutations. See `references/lens-studio-api-gotchas.md` → "setProperty Category 6: Editor.Model.MetaInfo".

**Fix**: use the view write-back pattern. The agent knows this; if you're seeing it, the agent's code missed the reassignment step. Tell the agent: "the write didn't persist, check transient-view write-back pattern".

### Working directory confusion

**Cause**: Claude Code started from a directory without `.mcp.json` and without user-scope registration.

**Fix**:

```bash
# Either: start CC from the project folder
cd ~/Projects/[client]-lens
claude

# Or: register MCP with global scope
claude mcp add --transport http --scope user lens-studio http://localhost:PORT/mcp \
  --header "Authorization: Bearer TOKEN"
```

`--scope user` writes the registration to `~/.claude.json` and it applies globally regardless of cwd.

---

## Build-mode issues

### "Scene mutation succeeded but nothing changed"

The agent should detect this via read-back rule (Rule 11). If you're seeing it slip through, fire the scope-validation challenge:

> "Did you read back the value after that mutation? What did the read-back show?"

Common silent-drop categories:
- **Compound types (RECT/VEC4/VEC2)**: fields 3+ drop. Use NUMBER scalar writes with dotted paths.
- **Enum STRING writes**: fail silently. Use NUMBER + integer index.
- **REFERENCE to AssignableType_1**: drops to null. Need concrete TS type on @input.
- **MetaInfo mutation**: view write-back required.

Full recovery patterns: `references/error-recovery.md` → "Silent-drop discovery + retry".

### "@input field shows AssignableType_1"

**Cause**: TS type on @input is `any` (or a non-LS-declared type).

**Fix** in your script:

```typescript
// WRONG
@input fortunes!: any;

// RIGHT (use a concrete LS class)
@input fortunes!: JsonAsset;
@input texture!: Texture;
@input audio!: AudioTrackAsset;
@input image!: Image;
```

Then recompile (Claude can run `RecompileTypeScriptTool` or you can ⌘B in LS) and re-attempt the REFERENCE binding.

### "Tween fires but no motion"

**Causes**:
1. Tween Manager package not installed
2. Using `localTransform.rotation.z` on Screen Image instead of `Image.rotationAngle`
3. TweenValue `callbackType=2` without helper-script pattern

**Fix**:

1. Check Scene Hierarchy for `TweenManager__PLACE_IN_SCENE` SceneObject. If missing: Scene Hierarchy → + → Scripts → Tween Manager. Package adds nine supporting JS assets.

2. For Screen Image rotation, use `imageComponent.rotationAngle = angle` (in degrees), not the 3D world rotation.

3. For TweenValue, use the helper-script pattern (`references/lens-studio-api-gotchas.md` → "TweenValue helper-script pattern").

### "FPS bad on mid-range Android"

**Cause categories**:
1. Textures not ASTC-compressed or oversized
2. `onUpdate` loops doing expensive work every frame
3. Lens size over 4 MB
4. Too many face-tracked components active simultaneously

**Diagnostic**:

```bash
# Find textures larger than 1024 in any dimension
find lens -name "*.png" -exec sh -c '
  size=$(identify -format "%w %h" "$1" 2>/dev/null)
  w=$(echo $size | cut -d" " -f1)
  h=$(echo $size | cut -d" " -f2)
  if [ "$w" -gt 1024 ] || [ "$h" -gt 1024 ]; then echo "$1: ${w}x${h}"; fi
' _ {} \;

# Find onUpdate loops in scripts
grep -rn "createEvent.*UpdateEvent\|onUpdate" lens/Assets/Scripts/
```

In LS Performance Panel (right side dock when previewing on device):
- FPS: target ≥ 25 on mid-range Android
- Lens Size: target ≤ 4 MB (hard limit 8 MB)
- RAM: target < 80 MB sustained

For each offender:
- Oversized texture → resize to 1024 max, re-import with ASTC
- `onUpdate` loop with expensive work → move work to event-triggered or cached
- Lens size too large → asset audit, drop unused, consider lower-resolution textures
- Too many ML components → consolidate or use one face-tracking component shared across face effects

### "LS crashes on Preview"

**Causes**:
1. Script runtime error
2. LS Preview-panel-specific bug
3. Memory leak from accumulated state

**Fix**:

1. Run `RunAndCollectLogsTool` via MCP, read the log for stack trace. Common: null deref, undefined property access, throwing in `onAwake`.

2. Reset LS preferences (see above) for Preview-panel bug.

3. If only after many Preview restarts: close LS, reopen, retest. Memory leak is in LS itself, not your lens.

If LS crashes consistently on Preview for a specific lens: minimal repro the issue and file with Snap support.

---

## Submission issues

### "Snap Ad Account not visible in Submit panel"

**Causes**:
1. Not logged into the right Snap account in LS
2. Client/media agency hasn't granted access to the target Org

**Fix**:

1. Verify login: LS → Menu Bar → **My Lenses → Login**. Confirm you're signed in with the account that has access to the target Ad Account.

2. If correct account but Ad Account dropdown doesn't show your target Org: contact client's media agency to be added to that Org in Snap Ads Manager. This is an account-permissions issue, not a code issue — the agent can't fix it.

### "Lens rejected by Snap review"

Standard Snap rejection reasons:

| Rejection | Fix |
|---|---|
| Copy violates ad policy | Review copy against Snap's policy for the category. Especially strict for Sexual Wellness, Alcohol, Gambling, Pharmaceutical. US-conservative standards apply regardless of campaign region. |
| Icon too photo-like | Redesign icon as simplified graphic (320×320 PNG). Not a product photo. |
| Performance issue (FPS, size) | Return to Phase 4, optimize, resubmit. Will get 1-2 week delay on re-review. |
| Content guideline violation | Specific to the rejection reason. Common: face liquify too dramatic (looks like meme filter), copy implies false claims, regulated category not age-gated correctly. |
| Technical (lens doesn't load on test device) | Test on actual mid-range Android, fix root cause, resubmit. |

For ambiguous rejections: appeal via Snap Ads Manager. Include test video showing the lens behavior matches your TECH-SPEC.

Resubmission for regulated categories typically adds 1-2 weeks. Plan campaign timeline accordingly.

### "Icon spec violation at submission"

LS Submit panel validates:
- Format: PNG
- Dimensions: 320×320 pixels exact
- File size: under 1 MB typical
- Content: simplified graphic, not photo

If you have a product photo as icon: take it to a designer for a simplified vector version. The "is it a product photo?" check is subjective — Snap review will flag if your icon looks like a photo of the product rather than a stylized representation.

---

## Performance issues

### "Lens loads slowly on mid-range Android"

Target: under 2s cold-start load. Anything over 5s = bad UX.

**Diagnostic**:

```bash
# Check lens size
ls -lh lens/[ProjectName].esproj
# Should be < 4 MB target, < 8 MB hard limit

# Find largest asset files
find lens/Assets -type f -exec ls -lh {} \; | sort -k5 -h -r | head -10
```

**Fix**:
- Drop unused assets
- Compress oversized textures (ASTC, max 1024)
- Remove placeholder content for production build
- Avoid bundling fonts you're not using

### "Memory usage grows over rapid interactions"

Symptom: tap 10+ times rapidly, FPS drops over time.

**Cause**: leaked tween instances, accumulated state in scripts, not cleaning up DelayedCallbackEvent handles.

**Fix patterns**:

```typescript
// Track active handles
private activeHandles: DelayedCallbackEvent[] = [];

// On each interaction:
const handle = script.createEvent("DelayedCallbackEvent");
handle.bind(() => { /* ... */ });
handle.reset(1.0);
this.activeHandles.push(handle);

// On reset / cleanup:
this.activeHandles.forEach(h => h.cancel());
this.activeHandles = [];
```

Same pattern for stopTween / resetObject loops — cancel everything from the previous cycle before starting a new one.

---

## LS-specific quirks

### "Inspector dropdown looks set but read-back shows different value"

**Cause**: LS Inspector UX issue. User clicks dropdown, hover-highlight shows checkmark, user assumes committed, but value wasn't actually committed.

**Fix**: after any user-driven Inspector change involving enums, always run scene-graphql read-back to verify. Don't trust "I set it to X" without verification.

### "Face effect worked, stopped working after deleting unrelated component"

**Cause**: ML / face-tracking entanglement. The deleted component (e.g., Face Geometry Modification package) was driving face tracking globally. Other face-anchored components were silently using its data.

**Fix**: re-add the providing component, OR move face-effect logic so it has its own face-tracking trigger. See `references/lens-studio-api-gotchas.md` → "LiquifyVisual must be under perspective Camera".

### "Scene mutation succeeds in MCP, doesn't appear in Preview"

**Cause**: MCP mutates LS in-memory state; Preview panel may need refresh.

**Fix**: run `RunAndCollectLogsTool` via MCP to force Preview refresh. Or manually click Refresh in LS Preview panel.

Note: this is separate from the ⌘S handshake (which is about persisting to disk). Preview refresh is about LS rendering the in-memory state visually.

---

## When to escalate beyond this doc

If you've exhausted this doc and the agent can't help:

1. **LS bug**: file with Snap support (`https://support.snap.com/`). Include LS version, OS, minimal reproducer, log files.

2. **Snap ad-account permissions**: contact your client's media agency directly. They control Ad Account access.

3. **Snap review appeal**: use the appeal flow in Snap Ads Manager. Include test video and TECH-SPEC excerpt showing the lens behaves as designed.

4. **Claude Code issue**: file at <https://github.com/anthropics/claude-code/issues>. Include Claude Code version, skill version (v0.4.0+), repro steps.

5. **Skill bug**: contact the skill maintainer (see `SKILL.md` frontmatter `metadata.author`). Include skill version, what you expected, what happened.

---

## See also

- `INSTALL-REFERENCE.md` — install steps
- `references/` (in skill folder) — internal docs the agent reads to guide you
