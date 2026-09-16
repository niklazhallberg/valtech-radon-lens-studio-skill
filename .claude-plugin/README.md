# Plugin manifest — reader notes

This directory contains `plugin.json`, the Claude Code plugin manifest for this
repository. This README exists to record human notes that cannot live inside
the JSON manifest itself (the Claude Code schema is strict — unknown keys are
rejected).

## Placeholders inside `plugin.json` — read before editing

Two fields in `plugin.json` are **transitional placeholders** for the pilot.
Do not treat either as a finalised production value.

### `name`: `"radon-lens-studio"`

Working identifier for the pilot. Confirm the final plugin name once the
organisation and marketplace format are finalised in
`SE-Valtech/v-radon-claude-skill-marketplace`. A rename will change the
`plugin:skill-name` invocation form colleagues use, so decide once and hold.

### `homepage`: `"https://example.invalid/radon-lens-studio-placeholder"`

**Not a live URL.** The `.invalid` top-level domain is reserved by RFC 2606
specifically so it cannot resolve to a real host by accident. Replace with
the confirmed enterprise repository URL after migration. Do not treat as a
working link today.

### `author`: `{ "name": "Valtech RADON" }`

Organisation-level attribution. Correct for the pilot as-is. Only change if
Valtech RADON adopts a more specific attribution convention (for example,
adding an `email` sub-field with a role mailbox once one exists).

## When the migration completes

At that point:
1. Update `name` to the final plugin name if it changes.
2. Update `homepage` to the confirmed enterprise repository URL.
3. Delete the corresponding sections from this README (or replace with a
   short "current values verified" note).
4. Bump `metadata.version` in the top-level `SKILL.md` and `plugin.json`'s
   `version` together, in a normal release PR.

## Why these notes live here, not inside the JSON

Earlier drafts embedded these TODO notes as `$comment_*` fields inside
`plugin.json`. Claude Code 2.1.119's plugin schema rejects unknown keys,
so `claude plugin validate` failed on the manifest. Moving the notes to
this adjacent Markdown file keeps the manifest schema-clean while preserving
the guidance for the next maintainer.
