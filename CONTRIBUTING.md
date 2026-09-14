# Contributing to lens-studio-snapchat-filter

Internal Valtech doc — how to make changes to this skill and ship them
to colleagues.

## Distribution model — plugin marketplace

This repo is distributed as a Claude Code **plugin** via a GitHub-synced
marketplace. Colleagues install once and receive updates automatically.

- **Publish flow**: push to `main` (via PR) → colleagues run
  `/plugin marketplace update` in Claude Code to pull the latest version.
- **No manual `.skill` builds.** No OneDrive uploads. No email-attached zips.
- **No backup dance.** Git history is the backup.

The old `.skill` file distribution workflow (build a zip, upload to OneDrive,
tell colleagues to re-install manually) has been retired. It required seven
manual steps per release and was error-prone.

## Single source of truth

This GitHub repo (`valtech-radon/lens-studio-snapchat-filter`) is canon.
Colleagues' local installs are direct clones or plugin-managed copies of
this repo. Editing here = editing the source that everyone else sees on
next `/plugin marketplace update`.

## Canonical doc per topic

| Topic | Canonical file | Notes |
|---|---|---|
| Install steps (1–7) | `docs/INSTALL-REFERENCE.md` | Edit here first |
| Positioning / "is this for you?" | `docs/MANUAL-SV.md` + `MANUAL-EN.md` | Decision doc, points to INSTALL-REFERENCE for details |
| Polished standalone onboarding | `docs/MANUAL.html` | Manually synced derivative of INSTALL-REFERENCE (until automation exists) |
| Troubleshooting | `docs/TROUBLESHOOTING.md` | When something breaks after install |
| Internal agent behavior | `references/*.md` | Read by Claude, not by humans |

## Contribution workflow — PR-based

**All changes go via pull request. No direct pushes to `main`.** This applies
equally to human contributors and to the growth protocol: the shared
`radon-skill-growth` skill opens a PR from a discovery branch; a human reviews
and merges. The user-facing "OK to save?" moment stays identical — but the
audit trail is a reviewable diff, not a fait-accompli commit.

When you change something user-facing in the install flow:

1. **Create a feature branch** off `main`.
2. **Edit `docs/INSTALL-REFERENCE.md` first** (it's canon).
3. **Manually sync the same change into `docs/MANUAL.html`** — same
   logical content, HTML formatting (`<div class="step-note">`,
   `<figure class="step-screenshot">`, etc.).
4. **Bump `metadata.version:` in `SKILL.md` frontmatter** for **minor releases
   only** (new behaviors, capability additions, distribution changes).
   Patch releases (e.g. 0.7.0 → 0.7.1) are tracked via git tag +
   CHANGELOG.md entry, NOT via SKILL.md-bump. See "Version convention"
   below for the full rule.
5. **Commit and push the branch**, then open a pull request.
6. **Get PR review + merge.** Once merged to `main`, the marketplace picks it
   up on the next colleague `/plugin marketplace update`.

## Growth protocol — writes back as PR

When Claude Code + the shared `radon-skill-growth` skill capture a discovery
during a real project session, the protocol is:

1. Agent proposes the generalised entry (Generalization rule stripped of
   client-specifics).
2. User approves in-flow ("yes, save that").
3. Agent creates a feature branch, commits the entry (references/*.md +
   CHANGELOG.md), pushes, and **opens a PR** — not a direct push to `main`.
4. Human reviews and merges the PR.

This keeps the user's in-flow approval momentum intact while ensuring every
change to `main` is a reviewable diff. See `references/_growth-protocol-pointer.md`.

## Screenshots

Place screenshots in `docs/img/`. Use kebab-case filenames that
describe the panel/state shown (e.g., `ls-mcp-server-panel.png`,
`ls-mcp-config-clipboard.png`).

**Security check:** if a screenshot shows credentials (MCP tokens,
API keys), the credential **must be rotated/invalidated before push**
so the token in the committed image is no longer valid. For MCP
tokens specifically: restart Lens Studio (token rotates on restart).

Because the repo is **public**, this rule is doubly important — a leaked
token in a committed image is visible worldwide within seconds.

## Version convention

The `metadata.version:` field in `SKILL.md` frontmatter tracks **minor releases
only** — not patches.

- **Minor bumps** (e.g. 0.7 → 0.8): new behaviors, new reference files,
  voice/UX rewrites, distribution changes. Bumps `SKILL.md` frontmatter.
- **Patch bumps** (e.g. 0.7.0 → 0.7.1): clarity fixes, single-section
  refinements, version-stamp corrections, small protocol additions.
  Tracked via **git tag + CHANGELOG.md entry only**. `SKILL.md`
  frontmatter stays at the parent minor version (0.7.0 stays the
  stamp through 0.7.1, 0.7.2, etc.).

This convention was established 2026-05-14 after the v0.7.0/v0.7.1
cycle revealed that bumping `SKILL.md` on every patch creates pointless
churn (commit, push, `.skill`-rebuild for a 1-line version-stamp
change). The **git tag is the authoritative version**; `SKILL.md`'s
`metadata.version:` field is the "capability era" marker, not a per-commit
version stamp.

When in doubt: if the change adds new files, new behaviors, or rewrites
a user-facing flow — it's minor and bumps SKILL.md. Otherwise it's a
patch and only tag + CHANGELOG track it.

## TODO — automation

Manual HTML sync is friction. Future work:

- [ ] Generate `MANUAL.html` from `INSTALL-REFERENCE.md` + a template
  (pandoc, or a small Node/Python script).
- [ ] Add a CI check that `metadata.version:` in `SKILL.md` matches the latest
  git tag.
