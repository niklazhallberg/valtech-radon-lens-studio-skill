# Growth protocol — pointer

This skill follows the shared **radon-skill-growth v1.0** protocol. The full mechanic
(trigger check, generalization rule, pre-ask filters, source confidence, in-flow ask,
consolidation, entry format) lives in that skill's `references/`. Do not duplicate it here.

## Prerequisites — the shared skill ships with this plugin

The growth protocol is defined in the `radon-skill-growth` skill, which is
**vendored under `skills/radon-skill-growth/`** in this plugin. When the plugin
loads, both skills are available — no separate install step required.

**If the shared skill is not reachable** (e.g., the plugin was installed
incompletely, the vendored directory is missing, or you are running a stripped
copy of this repo):

State this plainly to the user at session start:
> "The growth protocol I use to capture new learnings normally lives at
> `skills/radon-skill-growth/` inside this plugin. I don't see it there right
> now. Without it, I cannot run the in-flow ask when something genuinely new
> surfaces. Fall back to: read `references/skill-growth-protocol.superseded.md`
> (the local copy — older but complete), and I'll surface findings as plain
> text rather than the formal in-flow template."

**Do not improvise the protocol.** Use the fallback copy to guide the capture,
and be explicit with the user that the integration is degraded.

## Canonical location — vendored inside this plugin

This plugin **vendors** the shared `radon-skill-growth` skill under
`skills/radon-skill-growth/` at repo root. When you install this plugin,
you get both skills automatically — no separate install needed.

- **Vendored copy in this repo:** `skills/radon-skill-growth/SKILL.md`
- **Provenance (upstream URL, SHA, sync rule):** `skills/radon-skill-growth/PROVENANCE.md`
- **Upstream source (may move after enterprise migration):** see PROVENANCE.md

If the vendored copy is unexpectedly missing (e.g., you installed only
part of the plugin), that is a packaging bug — report it, and fall back
to `references/skill-growth-protocol.superseded.md` in the meantime.

## Everything domain-specific stays here

Domain-specific details — worked examples, this domain's trigger list, this domain's gotchas, 
this domain's discovery history — live in this skill's own `references/*.md` and `CHANGELOG.md`. 
Do not duplicate the shared skill's content.

## Temporary discovery staging

Candidates for "save for later" → `SKILL-DISCOVERIES.md` at repo root.

## Write-back is via PR, not direct push

When the user approves an in-flow ask, the agent **must not** push directly
to `main`. Instead:

1. Create a feature branch (e.g., `discovery/<short-slug>-<date>`).
2. Commit the generalised entry to `references/*.md` and/or `CHANGELOG.md`.
3. Push the branch.
4. Open a pull request describing the discovery, its origin (redacted of
   client specifics per the Generalization rule), and the value-for-user.

The user's approval-in-flow moment is unchanged. The mechanical write path
becomes a reviewable diff. This matters because more than five people hold
write access under the enterprise organisation; a PR-based flow gives a real
audit trail and blocks accidental client-data leaks before merge.

If the shared skill's protocol still shows a direct-push pattern, this
repo's rule takes precedence: **branch + PR, always**.
