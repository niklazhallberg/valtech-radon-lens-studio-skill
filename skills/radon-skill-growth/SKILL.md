---
name: radon-skill-growth
description: >-
  Personal knowledge-growth protocol for Niklaz's domain skills. Use this whenever
  working inside any radon-* domain skill (TouchDesigner, Lens Studio, 8thWall,
  comfy-cloud, modelBridge, etc.) and a non-trivial problem gets solved. It governs
  how empirical learnings are captured in-flow, generalized, gated by the human, and
  committed to that skill's own references/ and CHANGELOG. Trigger words: learning,
  discovery, gotcha, "why did that happen", "how do we avoid this next time", probe,
  workaround, consolidate, skill growth.
metadata:
  version: "1.0"
  audience: solo
  supersedes: "LS growth-protocol v0.6, TD growth-protocol v0.3"
---

# radon-skill-growth v1.0

This is the **canonical** knowledge-growth protocol shared by all of Niklaz's domain
skills. The mechanic lives here once; each domain skill carries only a thin pointer
plus its own domain-specific examples and its own `references/` + `CHANGELOG.md`.

**What this skill owns:** the *mechanic* of how knowledge is captured and committed.
**What it never touches:** the *knowledge itself* — entries, gotchas, and consolidation
history stay in each domain skill's own files. This skill moves the rules, never the
knowledge.

## The one rule that is always on

After solving anything non-trivial, **run the trigger check before the next action** —
not at end of task. Batched capture is a known failure mode. Do NOT wait to be asked.

A trigger fires when ANY of these is true after solving something:

- Took 3+ probe → fix cycles to reach a working state
- Reality contradicted your initial model (you predicted X, X failed, you found out why)
- You used a non-obvious workaround a fresh agent reading the docs wouldn't guess
- You ran a reset/restart because state didn't clear cleanly
- The user expressed surprise, asked "why did that happen?" or "how do we avoid this next time?"

When triggered, run the capture pipeline **before the next user-facing message**.

## The pipeline (each step lives in references/)

1. **Dedup** — grep the active skill's `references/*.md` for 3–5 keywords. Hit that
   isn't provably different → drop, no discovery.
2. **Generalize** — rewrite project-specific → universal rule. See
   `references/generalization-rule.md`. Non-negotiable before anything is saved.
3. **Pre-ask filters** — three silent YES/NO gates. Any NO → silent drop. See
   `references/pre-ask-filters.md`.
4. **Source confidence** — tag the evidence type (own empiry = HIGH, external = MEDIUM
   + re-check, dual = HIGH). See `references/source-confidence.md`.
5. **In-flow ask** — surface it warmly, in plain language, mid-flow. Human is always
   the gate. See `references/in-flow-ask.md`.
6. **Commit** — on yes: edit `references/`, prepend `CHANGELOG.md`, one small commit.
   Both files or neither.
7. **Consolidate** — keep the base from bloating. See `references/consolidation.md`.

## Single-user stance

This is a personal system. The protocol is deliberately solo-toned ("future-you", not
"the team"). When a learning is your own HIGH-confidence empiry, the two-stage approval
may collapse to one — you don't need to protect yourself from yourself. External-sourced
or MEDIUM-confidence learnings keep the full gate.

## Equipping a skill

Run `scripts/equip_skill.py <path-to-domain-skill>` to inject the pointer block, the
CHANGELOG/SKILL-DISCOVERIES templates (only if absent), and the session-sync hook.
It never overwrites an existing `references/` entry or `CHANGELOG` content.

## Systemic check

Root pattern this skill exists to kill: **divergent protocol copies**. Before adding any
mechanic here, confirm it belongs in the shared layer (true for all domains) and not in a
single domain skill (domain-specific examples only). If a proposed rule names a tool,
client, or platform quirk, it is domain content — it does NOT belong in this file.
