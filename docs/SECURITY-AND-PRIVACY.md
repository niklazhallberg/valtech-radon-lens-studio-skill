# Security and privacy

> This document describes how the `valtech-radon-lens-studio-skill` handles security, privacy, and client data. Written to be readable by security, legal, or compliance reviewers within Valtech RADON — or the colleague who wants to understand how project data is isolated from the skill repo. The original source is `VALTECH-PRESENTATION.md` section 5; it's extracted here so it can be reviewed and shared on its own.

## What is stored in the skill file?

**In the repo:**

| Type | Content | Risk level |
|---|---|---|
| Snap's public documentation | 365 markdown pages mirrored from `developers.snap.com` | Zero — already public |
| Empirical protocols | `body-anchored-calibration.md`, `lens-studio-api-gotchas.md` etc. — generalized patterns, **no project-specific values** | Zero — the Generalization rule safeguards this (see below) |
| MCP tool schemas | Technical API signatures for the Lens Studio MCP server | Zero — technical info, not sensitive |
| Voice principles | Pedagogical guidelines | Zero — methodology, not data |

**NOT in the repo — confirmed by review:**

- ❌ No client names in empirical protocols
- ❌ No project-specific values (X coordinates, campaign budgets, delivery dates)
- ❌ No personal data
- ❌ No Valtech-internal business information
- ❌ No API keys, tokens, credentials

## The Generalization rule as active security mechanism

The shared `radon-skill-growth` skill defines a **three-step checklist that runs BEFORE anything gets committed**. See `references/_growth-protocol-pointer.md`:

**Step 1 — Identify the core.** What's the general rule behind the specific finding?

**Step 2 — Explicit removal checklist:**

```
❌ Remove: client names
❌ Remove: exact project measurements that only apply to this case
❌ Remove: internal project names and file paths
❌ Remove: dates and deadlines
```

**Step 3 — "Next colleague" test (gate):**

> "If a colleague at Valtech next month builds ANOTHER try-on filter for ANOTHER brand — can they read this without knowing which project it came from?"

**Two layers of approval:**

1. The AI as gate-keeper runs the checklist
2. **Human approves every commit explicitly** — no auto-push, no auto-commit

The protocol is defined in the shared `radon-skill-growth` skill, with a pointer at [`references/_growth-protocol-pointer.md`](../references/_growth-protocol-pointer.md).

## Repo security

| Aspect | Status today |
|---|---|
| Repo type | **Private GitHub repo** |
| Access today | Limited — on the maintainer's personal GitHub account |
| Plan | Migrate to Valtech organization account |
| Future | `@valtech.com` SSO authentication |
| Auto-push | **Disabled** — every push requires explicit approval |

Migration to a Valtech org is an open item in [VALTECH-PRESENTATION.md section 7](VALTECH-PRESENTATION.md#7-recommended-next-steps).

## What happens with client data during a project?

This is important to understand structurally:

1. **The skill runs LOCALLY** on the designer's machine. Nothing is sent to GitHub without explicit approval.
2. **The Lens Studio project** (with the client's 3D models, briefs, campaign material) lives in a COMPLETELY SEPARATE folder, e.g. `~/Projects/<client>-lens/`. **This folder is NEVER pushed to the skill repo.**
3. **The discovery protocol** filters out everything project-specific BEFORE anything is even proposed for commit (Step 2 checklist).
4. The only thing that flows from project to skill is **the generalized pattern** — not data.

Concrete example from the generalization rule:

```
BEFORE (would NOT be committed):
"For the <client> lens we needed to set
shoe_mesh_l position to X=-80, Y=-40, Z=-20..."

AFTER (committed):
"Try-On Pack Sneakers: mesh pivot is off-center
relative to the foot anchor. Compensate with a
wrapper anchor architecture..."
```

## Comparison with the alternative

The risk if Valtech **doesn't** have a system like this:

| Risk without the skill | Consequence |
|---|---|
| Designers google freely | Uncontrolled sources, uncontrolled code snippets into client projects |
| Knowledge stays with the individual | If the person is unavailable → silent knowledge loss |
| Slack threads as "wiki" | Searchable only by insiders, no audit trail, no format protection |
| No audit trail on learnings | No visibility into what the agent learns from project to project |

**The skill isn't a new security risk — it's a structured solution to a risk that already exists.**
