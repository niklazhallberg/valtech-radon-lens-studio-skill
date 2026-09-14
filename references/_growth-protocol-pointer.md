# Growth protocol — pointer

This skill follows the shared **radon-skill-growth v1.0** protocol. The full mechanic
(trigger check, generalization rule, pre-ask filters, source confidence, in-flow ask,
consolidation, entry format) lives in that skill's `references/`. Do not duplicate it here.

## Prerequisites — the shared skill must be installed

The growth protocol lives in a separate, external skill repository (`radon-skill-growth`). 
It is NOT bundled in this repo. **You must have `radon-skill-growth` installed in your Claude Code environment for the growth protocol to work.** This is a hard dependency.

**If the shared skill is not installed or unreachable:**

State this plainly to the user at session start:
> "The growth protocol I use to capture new learnings requires the `radon-skill-growth` skill. I don't see it installed right now. Without it, I cannot run the in-flow ask when something genuinely new surfaces. Fall back to: read `references/skill-growth-protocol.superseded.md` (the local copy — older but complete), and I'll surface findings as plain text rather than the formal in-flow template."

**Do not improvise the protocol.** If the shared skill is unreachable, use the fallback copy to guide the capture, and be explicit with the user that the integration is degraded.

## Canonical location (for enterprises moving this repo)

The shared `radon-skill-growth` skill is maintained at: **[URL TBD — insert enterprise org URL after migration]**

Once migrated, update this file with the canonical URL so colleagues can clone the shared skill themselves if needed.

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
