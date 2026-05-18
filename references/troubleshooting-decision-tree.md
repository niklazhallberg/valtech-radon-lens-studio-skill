# Troubleshooting decision tree

CC's diagnosis playbook. For every common issue: 1-2 clarifying questions → 1 quick fix attempt → escalation criteria.

CC defaults to interactive diagnosis. Anna should not be sent to `docs/TROUBLESHOOTING.md` as a first response — that's only after 2 fix attempts failed or she explicitly asks for it.

## Contents
- Triage protocol
- Common issues — Setup phase
- Common issues — Build phase
- Common issues — Submission phase
- When to escalate to docs/TROUBLESHOOTING.md
- When to escalate to user

## Triage protocol

When Anna reports a problem:

1. **Clarify** (1-2 questions, narrow down). Don't ask all possible questions — just enough to disambiguate the likely cause.
2. **Try 1 fix**. The single most likely solution based on clarification. Don't pile up 3 things to try.
3. **Read-back**. After fix, verify (run a check, ask Anna what she sees).
4. **If unresolved** → 1 more clarify + 1 more fix.
5. **If still unresolved** → escalate (docs, or genuine "this is beyond me, contact support").

Two iterations max in CC. After that, the issue is either non-standard or needs human escalation.

## Common issues — Setup phase

### "claude command not found"

**Clarify**:
- "Did you install Claude Code via the one-line installer?"
- "What does `which claude` return?"

**Try fix**:
- If install missing: "Run `curl -fsSL https://claude.ai/install.sh | bash` in your terminal. Re-open the terminal after install."
- If `which claude` returns path but command fails: "Path issue. Run `echo $PATH` — does it include the install dir?"
- If on macOS and install dir is `/opt/homebrew/bin/`: ensure it's in PATH (`export PATH=/opt/homebrew/bin:$PATH` in `~/.zshrc`).

**Escalate**: After 2 fixes failed → Claude Code support docs.

---

### "Lens Studio won't open" / crashes on launch

**Clarify**:
- "Which LS version did you download? (Snap has 5.20+; older versions can be problematic.)"
- "Does it crash right at launch, or after you click something?"

**Try fix**:
- If wrong version: "Uninstall it and get 5.20+ from https://ar.snap.com/download."
- If crashes after launch: "Try `Shift+Option-click` on the LS icon for 'Reset Preferences' (re-init of configs). LS's preferences may be corrupt."
- macOS Gatekeeper error: "Right-click the LS app in Applications → Open → Open anyway."

**Escalate**: Real LS bug → Snap's support or LS community forum.

---

### "MCP not connecting" / "401 Unauthorized" / "Failed to connect"

This is the **#1 most common issue**. Token rotation happens every LS restart.

**Clarify**:
- "Did you restart Lens Studio recently?"
- "If yes → the token rotates on every LS start. That's the fix."

**Try fix** (the standard reconnect sequence):
> CC: "I'll fix it — it's token rotation. Two actions from you:
> 1. In LS: AI Assistant → AI Model Context Protocol (MCP) → Configure Server. Copy the new URL and token.
> 2. Paste both here."

When Anna pastes, CC runs:
```bash
claude mcp remove lens-studio
claude mcp add --transport http --scope local lens-studio [NEW_URL] --header "Authorization: Bearer [NEW_TOKEN]"
claude mcp list
```

Verify: `✓ Connected`.

**Escalate**: If still failing after re-register:
- Check port — has it changed? (LS sometimes picks new port on restart)
- Check `claude mcp list` for stale entries
- If `Connection refused`: LS process may have died — restart LS

After 2 attempts: `docs/TROUBLESHOOTING.md` → "MCP advanced debugging" section.

---

### "Can't find skill folder" / "Skill isn't loaded"

**Clarify**:
- "What does `ls ~/.claude/skills/lens-studio-snapchat-filter/SKILL.md` return?"
- "Are we in the same terminal session that installed the skill?"

**Try fix**:
- If file missing: skill not installed. Guide reinstall (copy `.skill` file, unzip to `~/.claude/skills/`).
- If file exists but Claude doesn't see it: "Close and reopen `claude` — live change detection may have missed a path."

**Escalate**: persistent issue → check `~/.claude/settings.json` for any skill-overrides that might disable it.

---

### "INSPIRATION/ folder missing after CC said it created it"

**Clarify**:
- "What does `ls ~/Projects/[client]-lens/` return?"
- "Are we in the right working directory? `pwd`"

**Try fix**:
- If cwd is wrong: `cd` to the project folder, re-verify.
- If folder genuinely missing: re-run `mkdir`. (Possibly file system race or permission issue on first attempt.)

## Common issues — Build phase

### "Scene mutation appears to succeed but nothing visible in Preview"

The classic phantom-success bug. See `references/lens-studio-api-gotchas.md` → "createSceneObject produces bare SceneObject" and the silent-drop patterns.

**Clarify**:
- "Which mutation did you run? Show the GraphQL call."
- "Did `setProperty` return `success: true`?"

**Try fix** — read-back rule:
- Run scene-graphql read-back on the mutated property
- Compare actual stored value vs intended
- If they differ → silent-drop bug. Switch to dotted-path scalar writes (NUMBER for compound types, NUMBER+index for enums).

**Tip**: Use the LS MCP knowledge base for canonical patterns when stuck:
```
mcp__lens-studio__QueryLensStudioKnowledgeBase("setProperty enum patterns")
```

(KB requires Snap login active in LS — verify with `claude mcp list` and ensure LS's My Lenses → Login is signed in.)

**Escalate**: persistent silent-drop → `references/lens-studio-api-gotchas.md` deep-dive.

---

### "@input field shows AssignableType_1 in inspector"

**Clarify**:
- "Show the TS declaration for the field."

**Try fix**:
- TS type is `any` → change to concrete LS class (`JsonAsset`, `Texture`, `AudioTrackAsset`, etc.)
- Recompile TS, re-read inspector slot type.

See `references/lens-studio-api-gotchas.md` → "@input fields must use concrete TS types".

---

### "Tween fires but no motion"

**Clarify**:
- "Which `callbackType` is the TweenValue using?"
- "Is the `TweenManager__PLACE_IN_SCENE` SceneObject still in the scene?"

**Try fix**:
- If Tween Manager scene-object missing: re-install Tween Manager package (Scene Hierarchy → + → Scripts → Tween Manager).
- If `callbackType=2` and using `Image.rotationAngle`: confirm helper-script pattern (see api-gotchas.md → "TweenValue helper-script pattern").
- If using `localTransform.rotation.z` on Screen Image: WRONG — switch to `Image.rotationAngle`.

---

### "FPS bad on mid-range Android"

**Clarify**:
- "Show the Performance Panel values: FPS, RAM, lens size."
- "Texture compression set to ASTC?"

**Try fix**:
- Run audit: textures must be ASTC, max 1024px. Check `lens/Assets/`:
  ```bash
  find lens -name "*.png" -exec identify {} \; 2>/dev/null | grep -v "1024"
  ```
- If textures fine, look for `onUpdate` loops in scripts — they're FPS-killers.
- If still bad: lens > 4 MB → asset audit, drop unused.

**Escalate**: `references/phase-progression.md` Phase 4 DoD checklist for systematic perf review.

---

### "LS crashes on Preview"

**Clarify**:
- "When does the crash trigger — when you click the Preview button, or after an interaction?"

**Try fix**:
- If on click: Preview panel crash (try Reset Preferences via Shift+Option-click LS icon).
- If on interaction: likely script error. Run `RunAndCollectLogsTool` via MCP — read logs for stack trace.

## Common issues — Submission phase

### "Snap Ad Account not visible in Submit panel"

**Clarify**:
- "Are you logged into the right Snap account in LS? Verify via Menu Bar → My Lenses."

**Try fix**:
- If logged in but org/account not visible: client/media agency hasn't granted access. CC can't fix this — escalate to media agency.

**Escalate**: contact media agency to grant Snap Ad Account access. Workflow item, not code item.

---

### "Lens rejected by Snap review — what now?"

**Clarify**:
- "What was the rejection reason message? Paste it in."

**Try fix**:
- Common rejections: copy violates ad policy (especially regulated categories), icon too photo-like, performance issue on Android, content guideline (US-conservative standards regardless of region).
- For each: surface the specific fix and rewrite/re-asset.

**Escalate**: ambiguous rejection → `docs/TROUBLESHOOTING.md` → "Submission rejection patterns" + appeal process.

---

### "Icon spec violation at submission"

**Clarify**:
- "Show the icon file. Dimension? Format?"

**Try fix**:
- 320×320 PNG required. Icon must be a simplified graphic, NOT a product photo.
- If photo-like: redesign with high-contrast vector or stylized illustration.

## When to escalate to docs/TROUBLESHOOTING.md

Send Anna to the user-facing troubleshooting doc when:

- CC has tried 2 fixes and the issue persists
- Anna explicitly asks: "isn't there a manual for troubleshooting?"
- Issue is edge-case beyond this decision tree (LS version-specific bug, advanced MCP debugging, specific Snap review appeal process)
- Anna wants understanding ("but why does this happen?") rather than just a fix

Wording:
> CC: "This is beyond what I can quickly diagnose. There's a deeper troubleshooting guide in `docs/TROUBLESHOOTING.md` — section '[relevant section name]'. If you want, read it and come back if anything is still unclear."

## When to escalate to user

Beyond CC's reach entirely. Examples:

- **Snap ad-account permissions** — needs human contact with media agency
- **LS bug (filed with Snap)** — needs reproducer + bug report to Snap support
- **Hardware-specific perf issue** that only manifests on a specific phone — needs device-specific debugging Anna does
- **Client copy/asset issue requiring revision** — client decision, not technical

Wording:
> CC: "This isn't a code fix — it needs a human action. [Specific action]. When it's fixed, come back and we'll keep going from where we left off."
