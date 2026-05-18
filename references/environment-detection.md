# Environment detection

CC's first action when concierge mode activates. Maps Anna's setup before guiding anything else. Anna never sees these commands — CC runs them silently via Bash and presents only the readiness report.

## Contents
- When to run
- The 7 detection commands
- Reading the results — readiness matrix
- Producing the readiness report
- Edge cases

## When to run

Run environment detection when ALL of these hold:
- Concierge entry-point trigger matched (see `SKILL.md` — domain + intent compound)
- Platform confirmation received from user ("yes, Snapchat Lens Studio")
- No `PROJECT-STATE.md` in cwd (otherwise resume existing project — skip detection)
- No `.esproj` in `lens/` subdirectory (same reason)

Do NOT run for build-mode resumption. If Anna says "Phase 3 polish" or "wire @input fields", skip to the relevant skill section, not concierge.

## The 7 detection commands

Run these in a single Bash call. Capture each result; don't interpret on failure (most checks are designed to return nothing when the thing is missing).

```bash
echo "1. Lens Studio installed:"
ls -d "/Applications/Lens Studio.app" 2>/dev/null && echo "  YES" || echo "  NO"

echo "2. Skill present (personal scope):"
ls ~/.claude/skills/lens-studio-snapchat-filter/SKILL.md 2>/dev/null && echo "  YES" || echo "  NO"

echo "3. Current working directory:"
pwd
ls

echo "4. Project sub-folders present:"
for d in project-info INSPIRATION brand-assets lens docs; do
  [ -d "$d" ] && echo "  $d: YES" || echo "  $d: NO"
done

echo "5. Existing .esproj in tree:"
find . -name "*.esproj" -maxdepth 3 2>/dev/null

echo "6. MCP server registered:"
claude mcp list 2>/dev/null | grep -i lens-studio || echo "  not registered"

echo "7. INSPIRATION populated (image count):"
ls INSPIRATION 2>/dev/null | wc -l | tr -d ' '
```

If a `PROJECT-STATE.md` is also found in cwd, read it — it'll tell CC the current phase and skip ahead.

## Reading the results — readiness matrix

| Detection | Result | Means | Required next step |
|---|---|---|---|
| 1 | NO | LS not installed | Step 2 of setup flow: install LS |
| 1 | YES | LS installed | Skip to step 3 |
| 2 | NO | Skill not installed at expected path | Should not happen if user is talking to CC with this skill loaded; investigate path |
| 2 | YES | Skill present | Continue |
| 3-4 | Empty cwd, no sub-folders | Anna is in a generic shell directory | Step 3: ask client name, create project folder, `cd` into it |
| 3-4 | Sub-folders present | Anna is already in a project folder | Validate which sub-folders exist; fill gaps |
| 5 | `.esproj` exists | Existing LS project | Skip ahead — likely Phase 1+ resume, not first-time setup |
| 5 | No `.esproj` | No LS project yet | Step 3 of setup flow: create LS project |
| 6 | Not registered | MCP needs setup | Step 4 of setup flow: register MCP |
| 6 | `✓ Connected` | MCP working | Skip MCP step |
| 6 | `✗ Failed to connect` or `401` | MCP registered but failing (token rotation) | Step 4 of troubleshooting: re-register with fresh token |
| 7 | 0 | INSPIRATION empty | Step 7 of setup flow: coaching to upload references |
| 7 | ≥ 5 | INSPIRATION populated | Skip ahead to onboarding-protocol intake |

## Producing the readiness report

After detection, surface results to Anna in coaching-friendly format. Use ✅ for ready, ❌ for missing, ⚠️ for present-but-broken.

Example output to Anna:

> Here's what I see on your machine:
> - ✅ Claude Code running (we're talking)
> - ✅ The skill is installed
> - ❌ Lens Studio not installed
> - ❌ No project folder yet
> - ❌ MCP not registered
>
> We'll do this together. Three steps, about 20 minutes total. Ready to start?

Always end with a yes/no question so Anna confirms before CC starts the stepped sequence. Never just barrel into "OK first install LS, then…".

## Edge cases

**LS installed on custom path** (not `/Applications/`):
- Detection 1 returns NO falsely
- If Anna says "but I have LS already" → ask `which "lens studio"` or have Anna provide path
- Update detection sequence locally for that session

**Skill installed in project scope** (`.claude/skills/` inside cwd):
- Detection 2 misses it
- Less common; if CC is loaded with the skill, the skill is accessible regardless of which scope
- Don't block setup on detection-2 NO — proceed if skill is functionally loaded

**MCP server present but failing**:
- Detection 6 shows `✗ Failed to connect` or `401 Unauthorized`
- This is the daily case after LS restart (token rotation)
- Go directly to MCP re-registration step, not full setup flow

**Anna in wrong cwd**:
- Detection 3 shows `/Users/.../Downloads` or similar non-project location
- Before any folder creation: ask "Where should we put the project? Default is `~/Projects/[client]-lens/` — OK?"

**Existing `PROJECT-STATE.md`**:
- Read it. Identify current phase. Skip environment detection entirely and resume at the phase shown.
- This is the "expert continuing existing project" path.
