# Consolidation — keep the skill from bloating

Adding entries forever produces a graveyard of similar-but-not-identical notes. Two
triggers, both gated by explicit user yes — **never auto-merge**.

## Trigger A — at new-discovery time (per-cluster)

Before recording a new discovery, grep CHANGELOG for entries hitting ≥2 of the same
keywords. If 2+ existing entries match:

> We've found something new. Looks like there are already 2–3 similar entries about
> [theme]. Want me to consolidate them into a single principle in
> `references/<file>.md` instead of adding another?

- **Yes** → write the consolidated principle to the target references file, mark the
  original CHANGELOG entries with a `→ consolidated in references/<file>.md § <section> (YYYY-MM-DD)`
  suffix, add ONE new CHANGELOG entry recording the consolidation itself.
- **No** → add the new entry as usual.

## Trigger B — at session start (periodic, hook-flagged)

The session-sync hook counts `### 💡` entries in CHANGELOG.md. When the count crosses the
next multiple of 10, it prints ONE line:

```
🔍 N total learnings — periodic consolidation review recommended
(ask the agent: "kör consolidation review" when you have a moment)
```

The hook does nothing else — no analysis, no grouping, no auto-suggestions, no opening
files. The actual review runs in conversation: agent scans CHANGELOG, groups 💡 entries
by the `File:` line they cite, lists files with ≥3 entries as candidate clusters, and per
cluster proposes a consolidated principle and asks. User per cluster: yes / no / defer.

## What "consolidated" means in practice

- Original CHANGELOG entries are NOT deleted (preserves granular history).
- They get a one-line suffix: `→ consolidated in references/<file>.md § <section> (YYYY-MM-DD)`.
- A new principle appears in the target `references/*.md`, project-agnostic per the
  generalization rule.
- A new 💡 entry records the consolidation itself (the biography shows the merge).

## Never (consolidation edition)

- Auto-consolidate without explicit yes (same gate as discovery commit).
- Delete original CHANGELOG entries — only annotate.
- Consolidate across unrelated themes just to clear the queue — if it doesn't read as ONE
  principle, leave them separate.
- Use the hook to do anything beyond count + flag. Anything smarter breaks the simplicity
  contract.
