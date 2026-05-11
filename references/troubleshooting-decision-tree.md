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
- "Did you install Claude Code from claude.ai/code?"
- "What does `which claude` return?"

**Try fix**:
- If install missing: "Install from https://claude.ai/code (download the CLI installer). Re-open terminal after install."
- If `which claude` returns path but command fails: "Path issue. Run `echo $PATH` — does it include the install dir?"
- If on macOS and install dir is `/opt/homebrew/bin/`: ensure it's in PATH (`export PATH=/opt/homebrew/bin:$PATH` in `~/.zshrc`).

**Escalate**: After 2 fixes failed → Claude Code support docs.

---

### "Lens Studio won't open" / crashes on launch

**Clarify**:
- "Vilken LS-version laddade du ner? (Snap har 5.20+, äldre versioner kan vara problematiska.)"
- "Crashar den direkt vid launch, eller efter du klickar något?"

**Try fix**:
- If wrong version: "Avinstallera den och hämta 5.20+ från https://ar.snap.com/download."
- If crashes after launch: "Try `Shift+Option-click` på LS-ikonen för 'Reset Preferences' (re-init av configs). LS:s preferences kan vara korrupta."
- macOS Gatekeeper-fel: "Höger-klicka LS-appen i Applications → Open → Open anyway."

**Escalate**: Real LS-bug → Snap's support eller LS community forum.

---

### "MCP not connecting" / "401 Unauthorized" / "Failed to connect"

This is the **#1 most common issue**. Token rotation happens every LS restart.

**Clarify**:
- "Har du startat om Lens Studio nyligen?"
- "Om ja → token rotateras varje LS-start. Det är fixet."

**Try fix** (the standard reconnect sequence):
> CC: "Jag fixar — det är token rotation. Två actions från dig:
> 1. I LS: AI Assistant → AI Model Context Protocol (MCP) → Configure Server. Kopiera den nya URL och token.
> 2. Klistra in båda här."

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
- "Vad returnerar `ls ~/.claude/skills/lens-studio-snapchat-filter/SKILL.md`?"
- "Är vi i samma terminal-session som installerade skillen?"

**Try fix**:
- If file missing: skill not installed. Guide reinstall (copy `.skill` file, unzip to `~/.claude/skills/`).
- If file exists but Claude doesn't see it: "Stäng och öppna `claude` igen — live change detection kan ha missat en path."

**Escalate**: persistent issue → check `~/.claude/settings.json` for any skill-overrides that might disable it.

---

### "INSPIRATION/-folder missing after CC said it created it"

**Clarify**:
- "Vad returnerar `ls ~/Projects/[client]-lens/`?"
- "Är vi i rätt working directory? `pwd`"

**Try fix**:
- If cwd is wrong: `cd` to the project folder, re-verify.
- If folder genuinely missing: re-run `mkdir`. (Possibly file system race or permission issue on first attempt.)

## Common issues — Build phase

### "Scene mutation appears to succeed but nothing visible in Preview"

The classic phantom-success bug. See `references/lens-studio-api-gotchas.md` → "createSceneObject produces bare SceneObject" and the silent-drop patterns.

**Clarify**:
- "Vilken mutation körde du? Visa GraphQL-call."
- "Returnerade `setProperty` `success: true`?"

**Try fix** — read-back rule:
- Run scene-graphql read-back on the mutated property
- Compare actual stored value vs intended
- If they differ → silent-drop bug. Switch to dotted-path scalar writes (NUMBER for compound types, NUMBER+index for enums).

**Tip**: Use the LS MCP knowledge base for canonical patterns when stuck:
```
mcp__lens-studio__QueryLensStudioKnowledgeBase("setProperty enum patterns")
```

(KB requires Snap login active in LS — verify with `claude mcp list` and ensure LS:s My Lenses → Login is signed in.)

**Escalate**: persistent silent-drop → `references/lens-studio-api-gotchas.md` deep-dive.

---

### "@input field shows AssignableType_1 in inspector"

**Clarify**:
- "Visa TS-deklarationen för fältet."

**Try fix**:
- TS type is `any` → change to concrete LS class (`JsonAsset`, `Texture`, `AudioTrackAsset`, etc.)
- Recompile TS, re-read inspector slot type.

See `references/lens-studio-api-gotchas.md` → "@input fields must use concrete TS types".

---

### "Tween fires but no motion"

**Clarify**:
- "Vilken `callbackType` använder TweenValue:n?"
- "Är `TweenManager__PLACE_IN_SCENE` SceneObject fortfarande i scenen?"

**Try fix**:
- If Tween Manager scene-object missing: re-install Tween Manager package (Scene Hierarchy → + → Scripts → Tween Manager).
- If `callbackType=2` and using `Image.rotationAngle`: confirm helper-script pattern (see api-gotchas.md → "TweenValue helper-script pattern").
- If using `localTransform.rotation.z` on Screen Image: WRONG — switch to `Image.rotationAngle`.

---

### "FPS bad on mid-range Android"

**Clarify**:
- "Visa Performance Panel-värdena: FPS, RAM, lens size."
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
- "När triggas crashen — när du klickar Preview-knappen, eller efter en interaktion?"

**Try fix**:
- If on click: Preview panel crash (try Reset Preferences via Shift+Option-click LS icon).
- If on interaction: likely script error. Run `RunAndCollectLogsTool` via MCP — read logs for stack trace.

## Common issues — Submission phase

### "Snap Ad Account not visible in Submit panel"

**Clarify**:
- "Är du loggad in på rätt Snap-konto i LS? Verifiera via Menu Bar → My Lenses."

**Try fix**:
- If logged in but org/account not visible: client/media agency hasn't granted access. CC can't fix this — escalate to media agency.

**Escalate**: contact media agency to grant Snap Ad Account access. Workflow item, not code item.

---

### "Lens rejected by Snap review — what now?"

**Clarify**:
- "Vad var rejection reason-meddelandet? Klistra in."

**Try fix**:
- Common rejections: copy violates ad policy (especially regulated categories), icon too photo-like, performance issue on Android, content guideline (US-conservative standards regardless of region).
- For each: surface the specific fix and rewrite/re-asset.

**Escalate**: ambiguous rejection → `docs/TROUBLESHOOTING.md` → "Submission rejection patterns" + appeal process.

---

### "Icon spec violation at submission"

**Clarify**:
- "Visa icon-filen. Dimension? Format?"

**Try fix**:
- 320×320 PNG required. Icon must be a simplified graphic, NOT a product photo.
- If photo-like: redesign with high-contrast vector or stylized illustration.

## When to escalate to docs/TROUBLESHOOTING.md

Send Anna to the user-facing troubleshooting doc when:

- CC has tried 2 fixes and issue persists
- Anna explicitly asks: "är det ingen manual för felsökning?"
- Issue is edge-case beyond this decision tree (LS version-specific bug, advanced MCP debugging, specific Snap review appeal process)
- Anna wants understanding ("but why does this happen?") rather than just fix

Wording:
> CC: "Det här är beyond vad jag snabbt kan diagnostisera. Det finns en djupare felsökningsguide i `docs/TROUBLESHOOTING.md` — sektion '[relevant section name]'. Om du vill, läs den och kom tillbaka om något fortfarande är oklart."

## When to escalate to user

Beyond CC's reach entirely. Examples:

- **Snap ad-account permissions** — needs human contact with media agency
- **LS bug (filed with Snap)** — needs reproducer + bug report to Snap support
- **Hardware-specific perf issue** that only manifests on specific phone — needs device-specific debugging Anna does
- **Client copy/asset issue requiring revision** — client decision, not technical

Wording:
> CC: "Det här är inte en kod-fix — det behöver en människa-action. [Specific action]. När det är fixat, kom tillbaka och vi fortsätter där vi var."
