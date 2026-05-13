# Contributing to lens-studio-snapchat-filter

Internal Valtech doc — how to make changes to this skill and ship them
to colleagues.

## Single source of truth

This GitHub repo (`niklazhallberg/lens-studio-snapchat-filter-skill`) is
canon. Two derivative copies exist:

- **Local install** (`~/.claude/skills/lens-studio-snapchat-filter/`)
  — what Claude Code on your machine loads. Typically a direct git
  clone of this repo, so editing here = editing the repo.
- **Distribution `.skill` file** — what colleagues install. Manually
  built from this repo (see "Building the .skill file" below).

When colleagues report a problem, the question is *"have my changes
made it into the distributed `.skill`?"*. They have not until you
rebuild and replace the `.skill` file.

## Canonical doc per topic

| Topic | Canonical file | Notes |
|---|---|---|
| Install steps (1–7) | `docs/INSTALL-REFERENCE.md` | Edit here first |
| Positioning / "is this for you?" | `docs/MANUAL-SV.md` + `MANUAL-EN.md` | Decision doc, points to INSTALL-REFERENCE for details |
| Polished standalone onboarding | `docs/MANUAL.html` | Manually synced derivative of INSTALL-REFERENCE (until automation exists) |
| Troubleshooting | `docs/TROUBLESHOOTING.md` | When something breaks after install |
| Internal agent behavior | `references/*.md` | Read by Claude, not by humans |

## Workflow for changing install steps

When you change something user-facing in the install flow:

1. **Edit `docs/INSTALL-REFERENCE.md` first** (it's canon).
2. **Manually sync the same change into `docs/MANUAL.html`** — same
   logical content, HTML formatting (`<div class="step-note">`,
   `<figure class="step-screenshot">`, etc.).
3. **Bump `version:` in `SKILL.md` frontmatter** for any user-facing
   change. SemVer: patch for clarity fixes, minor for new behaviors
   or distribution changes.
4. **Commit + push** to GitHub.
5. **Build a new `.skill` file** (see below).
6. **Replace the `.skill` on OneDrive Desktop** (back up the old one
   first as `*-vX.Y.Z.skill.backup`).
7. **Test fresh-install** from the new `.skill` to confirm the change
   reaches end users.

## Building the .skill file

The `.skill` is just a zip with a renamed extension. Build it from the
parent of the skill folder, excluding `.git/` and macOS clutter:

```bash
cd ~/.claude/skills
zip -r /tmp/lens-studio-snapchat-filter-vX.Y.Z.skill lens-studio-snapchat-filter \
  -x "lens-studio-snapchat-filter/.git/*" \
  -x "lens-studio-snapchat-filter/.DS_Store" \
  -x "lens-studio-snapchat-filter/**/.DS_Store"
```

Replace `vX.Y.Z` with the actual version. Output goes to `/tmp/` first
so you can verify before replacing the distributed copy.

Pre-distribution verification (run all four):

```bash
SKILL=/tmp/lens-studio-snapchat-filter-vX.Y.Z.skill

# 1. MANUAL.html is present
unzip -l "$SKILL" | grep "MANUAL.html"

# 2. SKILL.md version string matches
unzip -p "$SKILL" lens-studio-snapchat-filter/SKILL.md | grep "version:"

# 3. File size is plausible (>175 KB for v0.5.0+)
ls -la "$SKILL"

# 4. Mtime is "now"
stat -f "%Sm" "$SKILL"
```

Only after all four pass: replace the Desktop / OneDrive copy.

## Screenshots

Place screenshots in `docs/img/`. Use kebab-case filenames that
describe the panel/state shown (e.g., `ls-mcp-server-panel.png`,
`ls-mcp-config-clipboard.png`).

**Security check:** if a screenshot shows credentials (MCP tokens,
API keys), the credential **must be rotated/invalidated before push**
so the token in the committed image is no longer valid. For MCP
tokens specifically: restart Lens Studio (token rotates on restart).

## TODO — automation

Manual HTML sync is friction. Future work:

- [ ] Generate `MANUAL.html` from `INSTALL-REFERENCE.md` + a template
  (pandoc, or a small Node/Python script).
- [ ] Wrap the build/verify steps above in a `build.sh` or `Makefile`.
- [ ] Automate the OneDrive replace step (or document a Drive
  Stream-aware path).
- [ ] Add a CI check that `version:` in `SKILL.md` matches the latest
  git tag.

Until then: follow the workflow above by hand. The cost of a wrong
distribution is much higher than the cost of one manual sync.
