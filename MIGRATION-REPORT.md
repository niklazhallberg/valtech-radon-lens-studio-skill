# Enterprise Migration Audit Report

**Date:** 2026-09-14
**Auditor:** Claude Code (following radon-skill-growth v1.0 protocol)
**Status:** READY FOR REVIEW — 12 commits, all findings addressed

---

## Summary

Enterprise-migration audit of `valtech-radon-lens-studio-skill` from personal
GitHub account to Valtech RADON enterprise organisation. All nine findings
addressed. All decisions applied per user direction. `scripts/check-links.sh`
passes with 0 broken references (632 path-like references checked).

**Commits:** 12
**Files changed:** ~40
**Net lines:** +1500 / -200 (mostly plugin structure + vendored shared skill)

---

## Fixes Applied — one commit per logical change

### 1. Growth-protocol chain repointed (CRITICAL) — commit 2a5864f

Commit 7e7a268 renamed `references/skill-growth-protocol.md` → `.superseded.md`
and added `_growth-protocol-pointer.md`, but 9 references in 7 files were not
propagated. Session-opening step 1 in `operational-discipline.md` pointed to
the non-existent file — the entire discovery-capture chain was silently broken
for every new colleague.

**Files updated:** `operational-discipline.md:11`, `SKILL.md:155`, `README.md:149`,
`VALTECH-PRESENTATION.md:51,139,238`, `VALTECH-PRESENTATION-SV.md:51,139,238`,
`docs/SECURITY-AND-PRIVACY.md:26,48,71`, `CHANGELOG.md:7` (header prose only).

The line-range citation `lines 18–82` at `docs/SECURITY-AND-PRIVACY.md:48` was
removed — line ranges into another repo's file rot immediately.

`references/_growth-protocol-pointer.md` was hardened with an explicit
prerequisite that the shared skill must be reachable, plain-text fallback
instructions if it is not, and a canonical-location field (updated once the
plugin structure was created in commit 8d9792f).

`.superseded.md` is kept in place as the fallback safety net.

### 2. Install path contradictions resolved — commit cd1f831

- README.md cloned into the current directory; `install.sh` expected the repo
  at `~/.claude/skills/lens-studio-snapchat-filter`. README now matches
  `INSTALL-REFERENCE.md`.
- `install.sh` used `npm install -g @anthropic-ai/claude-code`; every doc used
  `curl -fsSL https://claude.ai/install.sh | bash`. `install.sh` now uses the
  documented curl method; the Node.js prerequisite check (which only served
  the npm path) is removed.

### 3. Install-path platform scope honest — commit 1c9821d

Per user decision: scope scripted install path to macOS only in README and
INSTALL-REFERENCE. Linux/WSL support noted as deferred until someone can test
and own it. Manual install on Linux/WSL is still possible by adapting the
shell commands in INSTALL-REFERENCE.md.

### 4. Orphaned `scripts/session-sync-hook.sh` deleted — commit 90a5014

Per user decision. The script was a consolidation-counter copied from
`radon-skill-growth/assets/session-sync-hook.sh` during v1.0 adoption. Zero
references anywhere in the repo. Its near-identical name to the real
`session-sync.sh` was a maintainer trap. Deleted.

### 5. Broken documentation paths repointed — commit 913bbd8

Twelve stale references in `assets/project-template/` pointed at a docs layout
that was reorganised into `references/`. Two more elsewhere. Each fix
verified against the actual target file contents (probable-target guesses
in the audit were spot-checked, not blindly applied):

| File:line | Was | Now |
|---|---|---|
| `PROJECT-PLAN.md:42` | `references/build-pipeline.md` | `references/phase-progression.md` |
| `PROJECT-PLAN.md:87-88` | `build-pipeline.md` (×2) | `references/phase-progression.md` |
| `PROJECT-STATE.md:22` | `docs/claude-code-lens-studio/17-onboarding-protocol.md` | `references/onboarding-protocol.md` |
| `PROJECT-STATE.md:60` | `docs/claude-code-lens-studio/15-phase-progression.md` | `references/phase-progression.md` |
| `PROJECT-STATE.md:103` | `docs/claude-code-lens-studio/10-watch-points-methodology.md` | `references/watch-points-methodology.md` |
| `PROJECT-STATE.md:126` | `docs/claude-code-lens-studio/16-ux-principle-locking.md` | `references/ux-principle-locking.md` |
| `PROJECT-STATE.md:162` | `docs/PIPELINE-GOTCHAS.md` | `references/lens-studio-api-gotchas.md` (via growth protocol) |
| `references/material-editor-guide.md:390` | `face-effect-tuning-via-inspector.md` (nonexistent) + editing artifact "…md memory —" | `face-effects-deep-dive.md` (sentence repaired) |
| `docs/SECURITY-AND-PRIVACY.md:3` | `docs/VALTECH-PRESENTATION.md` (wrong dir) | `VALTECH-PRESENTATION.md` (root) |

Project-template files now say "the skill's `references/...`" so the reader
(who is inside a client project when they read the template) is not confused
about which repo the target lives in.

`SKILL.md:122` was reworded: PROJECT-STATE.md, PROJECT-PLAN.md,
docs/TECH-SPEC.md, docs/USER-EXPERIENCE.md, docs/PROJECT-DECISIONS.md,
INSPIRATION/, project-info/client-brief.md are per-CLIENT-PROJECT files
scaffolded by the agent — not repo files. Template scaffold at
`assets/project-template/` verified to scaffold PROJECT-STATE.md and
PROJECT-PLAN.md; the three `docs/` files are created ad hoc during Phase 0
per `references/onboarding-protocol.md`.

### 6. Two more real references caught by check-links.sh — commit 930a181

- `references/mcp-tool-schemas.md`: 18 references used `../body-anchored-calibration.md`
  and `../snap-docs/*`. From `references/`, `../` resolves to repo root, not
  back to `references/`. Fixed to `./body-anchored-calibration.md` and
  `./snap-docs/*`.
- `references/capability-validation-protocol.md:3`: `build-pipeline.md` →
  `phase-progression.md` (missed in commit 913bbd8).
- `references/capability-tiers.md:178`: `project_ls_521_release.md` was an
  editing artifact pointing at a non-existent memory file. Rephrased to
  refer to Snap's release notes in general.

### 7. Version tracking consistent — commit cccbeda

- `SKILL.md` gained `metadata.version: "0.8.0"` in frontmatter (matches the
  latest git tag and CHANGELOG heading). Pattern taken from the sibling
  `radon-skill-growth` skill (`metadata.version: "1.0"`).
- `CONTRIBUTING.md` step 3, verification step, and Version-convention section
  updated to say `metadata.version:` (not `version:`).
- README.md:116 illustrative example `docs(v0.7.5)` was invalid (sequence is
  v0.7.4 → v0.8.0). Changed to `docs(v0.8.0)` and marked the whole block as
  "(example)" so it is unambiguous prose.
- Frontmatter `name` (24 chars, kebab-case) and `description` (766 chars,
  third person) verified against Anthropic's constraints (≤64 / ≤1024).

### 8. De-personalised — commit 1392f9e

**URL rewrites** (all clearly marked as placeholders; canonical Valtech domain
TBD post-migration):

- `*.niklaz-a-hallberg.workers.dev` → `docs.example.valtech.com/radon/lens-studio`
  in README.md, VALTECH-PRESENTATION*.md, ONBOARDING-SNIPPET.md, docs/_redirects
- `github.com/niklazhallberg/valtech-radon-lens-studio-skill` →
  `github.com/valtech-radon/lens-studio-snapchat-filter` in README.md,
  bin/install.sh, CONTRIBUTING.md, docs/MANUAL*.html
- Visible TODO in README and ONBOARDING-SNIPPET.md warning that the URLs are
  placeholders and MUST NOT be distributed until the canonical Valtech
  hosting domain is supplied

**Owner references:**

- README.md:15: "I (Niklaz) built" → "Valtech RADON built"
- README.md:225: "Owner: Niklaz Hallberg" → "Owner: Valtech RADON"
- ONBOARDING-SNIPPET.md: `/Niklaz` signatures → `/Valtech RADON`
- `references/snap-docs/.mirror-meta.md`:
  - `cache_location: ~/Projects/adidas-lens/…` → `~/Projects/<lens-project>/…`
    **(client name removed — critical for a public repo)**
  - `captured_by: Niklaz Hallberg / Valtech Radon` → `Valtech RADON`

**Hardcoded install paths:**

- `scripts/session-sync.sh:25`: `SKILL_DIR="${HOME}/.claude/skills/…"` →
  derived from `BASH_SOURCE`'s parent-of-parent so the hook survives any
  install path (direct clone, plugin install, symlink)
- `bin/install.sh:121`: same change

**Security-model rewrites** (repo is now public):

- README.md "Access" section: private/invitation-only → public repo,
  PR-based contribution, no direct pushes to main
- README.md "At a glance": Owner Valtech RADON, PR-based status
- docs/README.md: rewritten to warn that the ENTIRE repo is public (not just
  docs/), so the "no client data / no credentials" rule applies everywhere
- docs/SECURITY-AND-PRIVACY.md "Repo security" table: public repo, PR-only
  writes; explicit callout that public repo makes the Generalization rule
  DOUBLY critical
- VALTECH-PRESENTATION*.md:172: rewritten from "private personal account" to
  "public under Valtech RADON, PR-based"

### 9. Repo hygiene — commit bffdca1

- `.gitignore` expanded from `.claude/` + `.DS_Store` to also cover `*.skill`,
  `node_modules/`, `.env*` (with `!.env.example`), `*.log`, `Thumbs.db`,
  editor files
- `NOTICE.md` added per user decision (internal-use notice, proprietary — not
  MIT/Apache): states repo is Valtech RADON internal material; lists the
  categories that must never be committed (client data, personal data,
  credentials, unapproved third-party materials); refers to Valtech
  employment/contractor agreements for binding terms; explicitly not legal
  advice
- `LICENSE` added as an all-rights-reserved / proprietary Valtech RADON file
  that cross-references NOTICE.md
- `.github/CODEOWNERS` created with transitional wildcard `* @niklaz-hallberg_valtech`
  per user decision, and a TODO block instructing the maintainer to
  (a) verify the GitHub handle exists in the Valtech org,
  (b) replace with team refs (e.g., `@valtech-radon/lens-studio-core`) if the
  org uses that pattern,
  (c) once RADON has named owners for core / lens-studio / design / copy / PM
  / marketing, replace the wildcard with directory-scoped rules.
  **Explicitly warns against inventing team names (e.g., "radon-skill-growth"
  or "RADON skill guild") before the org creates them.**

### 10. Distribution + growth-protocol write-back updated — commit 6bb2142

**CONTRIBUTING.md rewritten:**

- Deleted the "Building the .skill file" section (7 manual steps per release)
- Deleted the OneDrive workflow (upload, back up old, test fresh install)
- Replaced with: push to `main` (via PR) → colleagues run
  `/plugin marketplace update`
- All workflow steps now require feature branch + PR (no direct pushes)
- Added a "Growth protocol — writes back as PR" section: agent creates branch,
  commits generalised entry, opens PR — the user's in-flow approval moment is
  unchanged, the mechanical write path becomes a reviewable diff
- Added security-check note that public repo makes screenshot-credential
  rotation doubly important

**`references/_growth-protocol-pointer.md`:**

- Added "Write-back is via PR, not direct push" section
- Explicit rule: branch + PR always; this repo's rule takes precedence over
  any direct-push pattern in the shared skill

Rationale: more than 5 people will hold write access under the enterprise
org; a PR-based flow gives a real audit trail and blocks accidental
client-data leaks before merge — particularly critical now that the repo
is public.

### 11. Plugin packaging with vendored shared skill — commit 8d9792f

Per user decision (vendored copy, not submodule, not separate plugin):

- Added `.claude-plugin/plugin.json` — manifest declaring both skills, plugin
  name `valtech-radon-lens-studio`, version 0.8.0
- Vendored `radon-skill-growth` under `skills/radon-skill-growth/` — snapshot
  of upstream commit `1cf4dc454cdf96ef4b44141b66dd1f88746e353b` (v1.0)
- Added `skills/radon-skill-growth/PROVENANCE.md` — records upstream URL,
  vendored SHA and date, sync procedure (quarterly or on upstream minor
  release), and deprecation path (promote to org-level plugin once
  enterprise marketplace is live and inter-plugin deps are verified)

**Guardrails observed per user instruction:**

- No new hooks
- No new MCP servers
- No new external API calls
- No new credentials
- No new GitHub Actions
- No automatic publishing
- No new executable behaviour beyond existing reviewed scripts
- Primary skill is left at repo root (backward compatible with existing
  clones); `plugin.json` declares both skill locations

**Not verified** in this PR: `plugin.json` load via
`/plugin marketplace add ./` — requires running Claude Code with plugin
support and is a post-merge verification step.

### 12. scripts/check-links.sh — commit 930a181

New script per Finding 4. Walks all markdown, extracts backtick-quoted repo
paths, resolves them, exits non-zero on any miss. Handles wildcards,
placeholders, code fragments, external URLs, LS URI schemes, per-client-project
scaffolded files (allowlist), and prose shorthand (bare filename anywhere in
repo).

## `check-links.sh` output — clean

```
$ bash scripts/check-links.sh
Checked 632 path-like references.
✓ All repo-relative markdown paths resolve.
```

---

## GitHub-side tasks still needed (manual, post-merge)

You need to do these in the GitHub UI or via `gh` / `git push`; I have not
and will not touch them from here.

1. **Move the repo to a Valtech RADON GitHub organisation.** The clone URL
   currently in code and docs (`valtech-radon/lens-studio-snapchat-filter`)
   is a placeholder — align the actual org name to whatever you register.

2. **Set up branch protection on `main`:**
   - Require pull request reviews before merging
   - Block force-pushes and branch deletion
   - Require CODEOWNERS review (once CODEOWNERS is validated)

3. **Delete stale branch `origin/cloudflare/workers-autoconfig`.**
   Content: one commit (`46a7d76`) from `cloudflare-workers-and-pages[bot]`
   dated 2026-05-27 adding `wrangler.jsonc` (Cloudflare deployment config
   for the `valtech-radon-lens-studio-skill` name) and 7 lines of
   Node/Wrangler entries to `.gitignore`. **Not merged, not needed for this
   PR** (user directed us not to configure any hosting here). Safe to delete
   manually via GitHub UI or:
   `git push origin --delete cloudflare/workers-autoconfig`
   **I did NOT delete this branch. Do it after the PR is merged.**

4. **Validate `.github/CODEOWNERS`:**
   - Confirm `@niklaz-hallberg_valtech` exists as a handle inside the Valtech
     org (once the org is set up). If not, replace with the correct handle
     or a team ref (e.g., `@valtech-radon/lens-studio-core`) — see the TODO
     block in the file.
   - Once RADON has named owners for the sub-domains (core, Lens Studio,
     design, copy, PM, marketing), replace the wildcard with
     directory-scoped rules.

5. **Update `radon-skill-growth` skill's own description** (separate repo).
   Its current description reads
   "Personal knowledge-growth protocol for Niklaz's domain skills."
   That skill is not editable from this repo — it lives at
   `https://github.com/niklazhallberg/radon-skill-growth` (until it moves to
   the enterprise org). Change to a Valtech RADON-owned, organisation-level
   description. **This is a required post-migration follow-up** — the
   description will otherwise contradict the enterprise ownership claimed
   throughout this repo.

6. **Configure the canonical Valtech RADON hosting domain** for the
   onboarding manuals, then replace the `docs.example.valtech.com/radon/lens-studio`
   placeholder URLs in:
   - `README.md` (Getting-started URL table)
   - `ONBOARDING-SNIPPET.md` (three Slack/email variants)
   - `VALTECH-PRESENTATION.md` (Day-1 walkthrough)
   - `VALTECH-PRESENTATION-SV.md` (Day-1 walkthrough)
   Do NOT distribute the current documentation with the placeholder URLs.

7. **Verify the plugin loads** via
   `/plugin marketplace add ./` (or the equivalent enterprise-marketplace
   command) before publishing. If the manifest fails, iterate on
   `.claude-plugin/plugin.json`.

8. **Publish the plugin** to the Valtech RADON marketplace once one exists.
   Nothing in this PR triggers publishing automatically — that step is
   deliberately manual (guardrail: no automatic publishing).

---

## Deferred items — proposals only, do not implement in this PR

### D1 — Split large reference files

`references/lens-studio-api-gotchas.md` (~1527 lines) and
`references/lens-recipe-catalog.md` (~1135 lines) each consume a large share
of the Claude Code context window when loaded.

**Proposal:** split by topic once the plugin ships and colleagues report
real usage patterns. Candidate splits:
- `gotchas/mcp-and-mutations.md`, `gotchas/scripting-runtime.md`,
  `gotchas/scene-and-components.md`, `gotchas/tween-and-animation.md`
- `recipes/face/`, `recipes/world/`, `recipes/body/`, `recipes/commerce/`,
  `recipes/sponsored/`

Do not split now — the current single-file structure is what the growth
protocol has been writing into for 3+ months. A split would fragment the
CHANGELOG's `File:` pointers and needs its own PR.

### D2 — Snap docs mirror re-mirror cadence

`references/snap-docs/.mirror-meta.md` records `captured: 2026-05-13`
against Lens Studio 5.x. That is ~4 months stale as of today. Between then
and now, Snap released LS 5.21 (visible from the plain-text release notes
the agent can fetch) — some captured pages may be behind.

**Proposal:**
- Re-mirror cadence: **quarterly**, plus on any major LS version bump
  (5.x → 6.x)
- The agent should surface a staleness warning at Phase 0 if
  `.mirror-meta.md`'s `captured:` date is > 90 days old and the user is
  starting a new project
- A stand-alone `references/snap-docs/.refetch.sh` script is a future task
  (recorded in the file's own Maintenance section)

Do not re-mirror now — user directed us not to touch snap-docs in this PR.

### D3 — Voice-and-pedagogy file organisation discrepancy

`references/voice-and-pedagogy.md` cross-references `mentor-flow-patterns.md`,
`glossary-translation.md`, and `stepped-conversation-patterns.md` as separate
files. `SKILL.md:127` (in the References-load-on-demand section) describes
voice-and-pedagogy as if it already CONTAINS "full templates, glossary
translations, mentor-flow patterns, stepped-conversation discipline".

Grep confirms `mentor-flow-patterns.md`, `glossary-translation.md`, and
`stepped-conversation-patterns.md` **do not exist** as separate files —
their content lives inside `voice-and-pedagogy.md`. So SKILL.md:127 is
correct; the cross-references inside voice-and-pedagogy.md itself are
pointing at sub-sections that have been rolled up, not at real files.

**Proposal:** in a future PR, either
- (a) update the cross-references inside `voice-and-pedagogy.md` to point at
  the correct `## Heading` anchors within the same file, or
- (b) split the content back out into the referenced files if the single
  file has become unwieldy.

Prefer (a) — the current single-file structure is efficient for context
loading; the fix is a heading-anchor rewrite, not a file split.

Do not fix now — it is a cosmetic navigation issue, not a functional bug,
and touching `voice-and-pedagogy.md` mid-migration risks conflicts with any
in-flight voice work.

### D4 — Deprecate `scripts/session-sync.sh` once marketplace is live

`scripts/session-sync.sh` (the SessionStart hook that runs `git pull --ff-only`
on the skill repo before each Claude Code session) becomes redundant with
`/plugin marketplace update` once the enterprise marketplace is live and
verified. The user directed us **not** to remove it in this PR — it stays
functional for existing users who have not migrated to the plugin.

**Proposal:** once the marketplace is verified working across ≥3 colleagues
on real projects, deprecate the hook in a follow-up PR — replace the script
body with a "please migrate to the plugin" one-liner, and eventually delete
it.

---

## Follow-up items for the shared `radon-skill-growth` skill (separate repo)

These belong to the shared skill's own repo, not this one. Note them here so
they are not lost.

- Description update (see GitHub-side task #5 above)
- Ownership move to the Valtech RADON org
- Consider whether `radon-skill-growth` should itself become a first-class
  plugin in the enterprise marketplace once inter-plugin dependencies are
  verified (see the deprecation-path note in
  `skills/radon-skill-growth/PROVENANCE.md`)

---

## Guardrails observed in this PR

Per the user's additional implementation guardrail on Finding 9, the PR
adds skills, references, templates, and documentation. It does **not** add
any of the following:

- ❌ New hooks (none added; existing `scripts/session-sync.sh` preserved)
- ❌ New MCP servers
- ❌ New external API calls
- ❌ New credentials / tokens
- ❌ New GitHub Actions
- ❌ Automatic publishing
- ❌ New executable behaviour beyond existing reviewed scripts

The only new script added is `scripts/check-links.sh` — read-only, offline,
walks markdown files and exits with a status code. It performs no network
I/O, writes no files, and touches no external systems.

---

## Commit list

```
930a181  chore: add scripts/check-links.sh + fix references it caught + pointer update
8d9792f  feat: package as Claude Code plugin with vendored radon-skill-growth
6bb2142  chore: switch to plugin-marketplace distribution + PR-based growth protocol
bffdca1  chore: add repo hygiene — .gitignore expansion, NOTICE.md, LICENSE, CODEOWNERS
1392f9e  refactor: de-personalize repo — replace personal URLs, owner refs, hardcoded paths
90a5014  chore: remove orphaned scripts/session-sync-hook.sh
1c9821d  docs: scope scripted install to macOS honestly
88fff27  docs: add comprehensive enterprise migration audit report  (this file, first draft)
cccbeda  fix: add version tracking + update documentation
913bbd8  fix: correct broken documentation links in project templates + clarify project-scoped files
cd1f831  fix: align Claude Code install method across all docs + fix clone target in README
2a5864f  fix(critical): repoint all broken growth-protocol references + harden pointer
```

Twelve atomic commits, one logical change each. Every commit has a
`Co-Authored-By: Claude Haiku 4.5` trailer.
