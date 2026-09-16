# radon-skill-growth — vendored copy

This directory is a **vendored copy** of the shared `radon-skill-growth` skill.
It is not the canonical source.

## Provenance

- **Upstream:** the source repository for the `radon-skill-growth` skill,
  currently maintained under a personal GitHub account by a Valtech RADON
  team member. The specific URL is intentionally omitted here because it
  points at a personal account; it is not a supported installation
  destination for anyone else. The skill maintainer can share the URL
  privately if the sync procedure below is invoked.
  *(TODO: after enterprise migration, the upstream is expected to move
  under a Valtech RADON organisation. Update this file with the new URL
  once that happens, and only then.)*
- **Vendored commit:** `1cf4dc454cdf96ef4b44141b66dd1f88746e353b`
- **Vendored version:** v1.0 (see `SKILL.md` frontmatter `metadata.version`)
- **Vendored on:** 2026-09-14
- **Vendored by:** enterprise-migration audit

## Why vendored (not submodule, not separate plugin)

Decision recorded during enterprise migration:

1. **Not a submodule** — adds Git, authentication and update complexity that
   non-technical designers should not have to manage. Plugin users install
   via `/plugin marketplace add`; they do not run `git submodule update`.
2. **Not a separate plugin (yet)** — the Valtech RADON marketplace has not
   yet been set up and inter-plugin dependency behaviour in Claude Enterprise
   has not been verified for our pilot.
3. **Vendored** — simplest path for the first migration pilot. One repo, one
   plugin, one install action for colleagues, dependency guaranteed to be
   present.

## Sync rule

Because this is a vendored copy, upstream changes are not automatic.

**Sync procedure** (do this quarterly, or whenever the upstream skill releases
a new minor version). The skill maintainer runs this; end users do not.

1. Obtain the current upstream URL from the skill maintainer and pull the
   latest `main` into a local working copy.
2. From that upstream working copy, copy `SKILL.md`, `references/`,
   `assets/`, and `scripts/` into this directory, overwriting existing files.
3. Update the **Vendored commit** and **Vendored on** fields at the top of
   this file to the new commit SHA and today's date.
4. Do a quick diff-review to spot behavioural changes.
5. Open a PR titled `chore(radon-skill-growth): sync vendored copy to <SHA>`
   with the diff.
6. On merge, colleagues get the updated shared skill on their next
   `/plugin marketplace update`.

## Deprecation / migration path

**TODO (post-pilot):** Once the Valtech RADON enterprise marketplace is live
and inter-plugin dependencies have been tested in Claude Enterprise, reassess
promoting `radon-skill-growth` to its own organisation-level plugin. If that
succeeds, remove this vendored copy and declare a plugin-level dependency
instead.

## Do NOT edit files in this directory

Edits to this directory are lost on the next sync. If you need to change the
protocol, edit it in the upstream repo and sync.

Domain-specific overrides (e.g., the PR-based write-back rule this repo
requires) live in `references/_growth-protocol-pointer.md` in **this** skill's
root, not in the vendored copy.
