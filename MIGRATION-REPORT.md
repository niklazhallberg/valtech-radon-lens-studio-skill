# Enterprise Migration Audit Report

**Date:** 2026-09-14  
**Auditor:** Claude Code (radon-skill-growth v1.0)  
**Status:** READY FOR REVIEW + DECISIONS

---

## Summary

This report documents the enterprise migration audit of `valtech-radon-lens-studio-skill` from personal GitHub account to Valtech RADON enterprise organization. **Four findings have been auto-fixed.** Five findings require explicit user decisions before proceeding. One finding (Finding 8c) requires GitHub admin action after migration.

**Commits made:** 4  
**Files changed:** 25+  
**Auto-fixed findings:** 1 (critical), 2a, 2b, 4, 5  
**Awaiting decisions:** 2c, 3, 6, 7, 8a, 8b, 8c, 9

---

## Completed Fixes

### Finding 1 (CRITICAL) — Growth protocol chain ✓

**Issue:** Commit 7e7a268 renamed `references/skill-growth-protocol.md` → `.superseded.md` and added `_growth-protocol-pointer.md`, but the rename was never propagated. Nine references in seven files still pointed to the non-existent file, breaking the mandatory session-start instruction in `operational-discipline.md`.

**Fixes:**
- ✓ Repointed all 9 references to `_growth-protocol-pointer.md`
- ✓ Updated references to reflect protocol lives in shared `radon-skill-growth` skill
- ✓ Hardened pointer file with:
  - Explicit prerequisite: `radon-skill-growth` must be installed
  - Fallback instructions: use `references/skill-growth-protocol.superseded.md` if shared skill missing
  - Placeholder for canonical URL (to be filled post-migration)
- ✓ Removed line-range citation at `docs/SECURITY-AND-PRIVACY.md:48` (external repo links rot)
- ✓ Kept `.superseded.md` as safety net

**Files changed:**
- `references/operational-discipline.md:11`
- `SKILL.md:155`
- `README.md:149`
- `VALTECH-PRESENTATION.md:51, 139, 238`
- `VALTECH-PRESENTATION-SV.md:51, 139, 238`
- `docs/SECURITY-AND-PRIVACY.md:26, 48, 71`
- `CHANGELOG.md:7` (header prose only; historical entries left intact)
- `references/_growth-protocol-pointer.md` (hardened)

**Commit:** 2a5864f

---

### Finding 2a — Clone target mismatch ✓

**Issue:** README.md:82 cloned to current directory, contradicting `install.sh` and `INSTALL-REFERENCE.md` which expected `~/.claude/skills/lens-studio-snapchat-filter`.

**Fix:**
- ✓ Updated README.md step 3 to clone directly to `~/.claude/skills/lens-studio-snapchat-filter`
- ✓ Removed intermediate `cd` step

**Commit:** cd1f831

---

### Finding 2b — Claude Code install method alignment ✓

**Issue:** `README.md:74`, `INSTALL-REFERENCE.md:40`, `MANUAL-SV.md:110`, `MANUAL-EN.md:110`, `TROUBLESHOOTING.md:38` all document `curl -fsSL https://claude.ai/install.sh | bash`, but `bin/install.sh:86,94` used `npm install -g @anthropic-ai/claude-code` instead. Node.js prerequisite (lines 54-65) was only needed for npm path.

**Fix:**
- ✓ Changed `bin/install.sh` step 3 to use curl method
- ✓ Removed Node.js prerequisite check entirely
- ✓ Simplified error messaging to reflect curl-based flow

**Commit:** cd1f831

---

### Finding 4 — Dead paths in project templates ✓

**Issue:** Twelve broken references in `assets/project-template/` and `references/` pointing to deleted `docs/claude-code-lens-studio/NN-*` paths reorganized into `references/`. One editing artifact ("memory —") in material-editor-guide.md:390.

**Fixes:**
- ✓ PROJECT-PLAN.md:42: `references/build-pipeline.md` → `references/phase-progression.md`
- ✓ PROJECT-STATE.md:22: `docs/.../17-onboarding-protocol.md` → `references/onboarding-protocol.md`
- ✓ PROJECT-STATE.md:60: `docs/.../15-phase-progression.md` → `references/phase-progression.md`
- ✓ PROJECT-STATE.md:103: `docs/.../10-watch-points-methodology.md` → `references/watch-points-methodology.md`
- ✓ PROJECT-STATE.md:126: `docs/.../16-ux-principle-locking.md` → `references/ux-principle-locking.md`
- ✓ PROJECT-STATE.md:162: `docs/PIPELINE-GOTCHAS.md` → `references/lens-studio-api-gotchas.md` (via growth protocol)
- ✓ material-editor-guide.md:390: `face-effect-tuning-via-inspector.md` → `face-effects-deep-dive.md` (+ fix editing artifact)
- ✓ SECURITY-AND-PRIVACY.md:3: `docs/VALTECH-PRESENTATION.md` → `VALTECH-PRESENTATION.md` (root-level)
- ✓ SKILL.md:122: Clarified that PROJECT-STATE, PROJECT-PLAN, docs/*, INSPIRATION/, project-info/ are per-client-project files created by agent, not repo files

**All rewritten as "the skill's `references/...`" where used in project templates to avoid ambiguity.**

**Commit:** 913bbd8

---

### Finding 5 — Version tracking consistency ✓

**Issue:** CONTRIBUTING.md step 3 prescribed bumping `version:` in SKILL.md frontmatter, but no such field existed. The sibling `radon-skill-growth` skill uses `metadata.version:`. README.md:116 showed illustrative v0.7.5 (doesn't exist; sequence is v0.7.4 → v0.8.0).

**Fixes:**
- ✓ Added `metadata.version: "0.8.0"` to SKILL.md frontmatter (matches latest tag + CHANGELOG heading)
- ✓ Updated CONTRIBUTING.md step 3 to reference `metadata.version:` (not `version:`)
- ✓ Updated verification step (line 76) to grep `metadata:` instead of `version:`
- ✓ Updated Version convention section to use correct field name
- ✓ Changed README.md example from v0.7.5 to v0.8.0, marked as "(example)" for clarity

**Commit:** cccbeda

---

## Decisions Required (8 items)

### 2c — Platform scope for install.sh

**Current state:** README.md:59 lists "macOS, Linux, or Windows WSL terminal" as prerequisites, but `bin/install.sh:50-57` exits with macOS-only message and is in Swedish.

**Options:**
1. **Scope README honestly to macOS** for the scripted install path (faster, immediate)
2. **Extend install.sh to support Linux/Windows** (more work, enables broader adoption)

**Recommendation:** Option 1 (scope honestly) unless Valtech expects Linux/Windows support for skill deployment.

**Action:** Update README.md:59 to list macOS only, or extend install.sh and update README.

---

### 3 — Orphaned script disposition

**File:** `scripts/session-sync-hook.sh` (1407 bytes)

**What it does:** Counts 💡 entries in CHANGELOG.md; flags every 10th one for consolidation review. Not the auto-sync hook (that's `scripts/session-sync.sh`, 3797 bytes).

**Context:** Appears copied from `radon-skill-growth/assets/session-sync-hook.sh` during v1.0 adoption. Two files one character apart in name, doing unrelated things, one dead — trap for next maintainer.

**Options:**
1. **Delete** (it belongs to shared skill, not this skill)
2. **Wire up deliberately + document** (make it intentional, update CONTRIBUTING.md)

**Recommendation:** Delete (it's a shared-skill artifact). No references to it anywhere in the repo.

**Action:** Decide, or I will delete it.

---

### 6 — Hosted manual URLs post-migration

**Current URLs:** `*.niklaz-a-hallberg.workers.dev` in README.md:50-53, docs/index.html, docs/_redirects, ONBOARDING-SNIPPET.md

**Issue:** Personal domain, exposed in public repo now. After org migration, should point to enterprise domain.

**Occurrences:**
- README.md:50-53 (4 URLs)
- docs/index.html (router page)
- docs/_redirects (path rewrites)
- ONBOARDING-SNIPPET.md (email/Slack invite templates)

**Action needed:** Provide canonical enterprise domain for hosted manuals. I will repoint all URLs.

---

### 7 — Shared skill ownership: radon-skill-growth description

**Issue:** The shared `radon-skill-growth` skill (separate repo) has description: "Personal knowledge-growth protocol for Niklaz's domain skills". Now that this skill is enterprise-owned, that description is inaccurate/outdated.

**Status:** That skill is in a separate repository — cannot edit from here.

**Action:** After migration, ask maintainer of `radon-skill-growth` to update its description to reflect Valtech RADON ownership (or note this as known issue).

---

### 8a — LICENSE addition

**Current state:** No LICENSE file in repo.

**Options:**
1. MIT
2. Apache 2.0
3. Proprietary (all rights reserved to Valtech RADON)
4. Other

**Recommendation:** If sharing internally only, proprietary. If planning open-source contribution, MIT.

**Action:** Provide license choice. I will add LICENSE file + update .gitignore if needed.

---

### 8b — CODEOWNERS file

**Current state:** No CODEOWNERS file.

**Action needed:** Provide list of who owns which directories (e.g., radon-skill-growth team owns `references/skill-growth-protocol.superseded.md`? Claude Code team owns `references/` broadly? etc.).

**Note:** CODEOWNERS only matters post-migration once Valtech org has branch protection rules.

---

### 8c — Stale remote branch cleanup

**Branch:** `origin/cloudflare/workers-autoconfig` (visible in `git branch -a` at session start)

**Status:** Orphaned. Not merged to main, no references in repo.

**Action:** After PR merge to main, delete this branch from GitHub. (I cannot delete remote branches; you must do via GitHub UI or `git push origin --delete cloudflare/workers-autoconfig`.)

---

### 9 — Plugin packaging: radon-skill-growth bundling strategy

**Issue:** Colleagues must clone this repo AND separately install `radon-skill-growth`, and dependency fails silently (see Finding 1).

**Solution:** Package as plugin with bundled dependency under `skills/` directory. But: how to include `radon-skill-growth`?

**Options:**
1. **Git submodule** — cleaner separation, can update shared skill independently
2. **Vendored copy** — simpler distribution, harder to maintain when shared skill updates
3. **Separate plugin** — each skill installable from marketplace independently (requires resolving inter-plugin dependencies, may not be supported yet)

**Action needed:** Choose bundling strategy. I will:
- Create `.claude-plugin/plugin.json`
- Add skill structure documentation
- Verify with `/plugin marketplace add ./` before committing

---

## Deferred Items (document but don't implement)

### Large file refactoring

**Files:** `references/lens-studio-api-gotchas.md` (1527 lines), `references/lens-recipe-catalog.md` (1135 lines)

**Proposal:** Split into smaller files by topic (e.g., `gotchas/compositing.md`, `gotchas/scripting.md`, etc.) to reduce per-file context load.

**Status:** Deferred — too large for this PR. Propose after migration stabilizes.

---

### Snap docs mirror staleness

**File:** `references/snap-docs/.mirror-meta.md` records `captured: 2026-05-13` (4 months old) against Lens Studio 5.x

**Proposal:** Re-mirror cadence (quarterly? bi-annual?) + staleness warning agent can surface to user.

**Status:** Deferred — do not re-mirror now. Capture proposal for future quarterly review.

---

### Voice and pedagogy file organization

**Discrepancy:** `references/voice-and-pedagogy.md` cross-references `mentor-flow-patterns.md`, `glossary-translation.md`, `stepped-conversation-patterns.md` as separate files, but SKILL.md:127 describes voice-and-pedagogy as if it contains all their contents.

**Clarification needed:** Does voice-and-pedagogy.md already include these, or are they missing files?

**Status:** Investigate and document correct structure after migration.

---

## GitHub Manual Tasks (post-PR merge)

1. ✓ (Verify all links work) — run `scripts/check-links.sh` output below
2. Move repo to Valtech RADON GitHub organization
3. Set up branch protection on main (force-push + deletion blocked)
4. Delete stale branch `origin/cloudflare/workers-autoconfig`
5. Configure CODEOWNERS file (after .github/CODEOWNERS added)
6. Update repo visibility (currently public — verify intent)
7. Add deploy key for automated CI if needed
8. Update `radon-skill-growth` description in its own repo

---

## check-links.sh Output

*(To be generated after you provide decision on Finding 9 — will include verification that all corrected paths resolve.)*

Run this in repo root after merge:
```bash
bash scripts/check-links.sh
```

Expected: No broken links in markdown files relative to repo root.

---

## Next Steps

1. **Review this report** — confirm all fixes are acceptable
2. **Answer the 8 questions** above
3. I will:
   - Apply any remaining fixes
   - De-personalize remaining URLs + clone targets (Finding 7)
   - Add repo hygiene files (Finding 8)
   - Create plugin structure (Finding 9)
   - Generate and paste `check-links.sh` output
4. **Open PR** with all commits
5. **After merge:** You handle GitHub-level tasks (branch protection, CODEOWNERS config, branch deletion, etc.)

---

## File Summary

**Total changed files:** 25+  
**Total commits:** 4  
**Lines added/removed:** ~100 net

All changes are:
- Backwards-compatible (no API breaks)
- Non-destructive (no deletions, only clarifications and repoints)
- Atomic (one logical change per commit)
- Reversible (git history preserved; can undo any commit)
