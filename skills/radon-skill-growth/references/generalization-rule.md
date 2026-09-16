# Generalization rule

Before a discovery is written to `references/`: transform the project-specific finding
into a universal rule. This runs **silently**, before the in-flow ask.

## Step 1 — Identify the core

What is the GENERAL pattern behind the specific finding? Name the trigger, the symptom,
and the root cause — strip the instance.

## Step 2 — Remove everything project-specific

Checklist BEFORE writing to disk:

- ❌ Remove: client names, project names, specific asset filenames
- ❌ Remove: exact measurements that only apply to this one case
- ❌ Remove: internal project paths — replace with placeholders or general patterns
- ❌ Remove: dates and deadlines tied to a specific delivery
- ✅ Keep: the general pattern
- ✅ Keep: typical ranges and rules of thumb
- ✅ Keep: WHY it happens (root cause)
- ✅ Keep: how to detect and how to solve it

## Step 3 — The "future project" test

Read what you're about to commit and ask:

> "If I start a different project next month in this domain and hit a
> related-but-not-identical situation — does this entry guide me to the right fix
> without me being there to interpret it?"

If yes → ready to commit. If no → rewrite until the answer is yes.

## Why this is non-negotiable

A project-specific finding is not a rule — it's an anecdote. The value of the knowledge
base is in destilled patterns (root cause + typical ranges), not in stored measurements.
Skipping this step is how a knowledge base becomes folklore: things that sound wise but
don't transfer. The generalization rule is the single most important gate in the whole
protocol. The domain skill's own `references/` holds the worked examples that show this
rule applied to that domain.
