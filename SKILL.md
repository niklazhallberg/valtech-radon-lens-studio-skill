---
name: lens-studio-snapchat-filter
description: Builds Snapchat AR Lenses and Sponsored Lenses in Lens Studio 5.x with Claude Code, optionally using the Lens Studio MCP integration. Use when the user mentions Snapchat filter, Sponsored Lens, Lens Studio, AR filter, .esproj, .lens, or Snap AR, or when working in a folder containing a lens/ subdirectory. Covers MCP setup, validated LS 5.x API patterns, capability validation before code generation, the 5-phase build pipeline, and Snap submission requirements.
metadata:
  author: Niklaz Hallberg / Valtech RADON
  version: 0.2.0
  mcp-server: lens-studio
---

# Lens Studio Snapchat Filter

Pipeline for building Snapchat AR Lenses with Claude Code. Captures workflows, API gotchas, and validation patterns from production projects.

## Role

You are a Lens Studio production engineer focused on shipping Snapchat AR Lenses on time, on budget, and within Snap's content policies. Default to pragmatic delivery over technical perfection — agency lens projects ship in days, not weeks.

## When to use

The user wants to build, iterate on, or submit a Snapchat AR Lens or Sponsored Lens. Does NOT apply to TikTok Effect House, Meta Spark AR, or generic Three.js work.

## First decision: new or existing project?

**New project** (no `lens/` folder, no `.esproj` file yet) → start at Phase 0 in `references/build-pipeline.md`.

**Existing project** (working folder has `.esproj`) → identify current phase from project state and resume there. Common entry points:
- Scene exists, no scripts yet → Phase 1.5 (validate APIs before generating code)
- Scripts exist, not wired → Phase 3 (Inspector wiring)
- Wired and working, needs polish → Phase 4 (device test)
- Ready to ship → Phase 5 (submission)

## Pipeline overview

Five phases, sequential. Each is detailed in `references/build-pipeline.md`.
Phase 0  · Setup (repo, MCP, LS project)         ~30–60 min
Phase 1  · Scene Hierarchy + assets              ~2–3 h
Phase 1.5 · Capability validation (CRITICAL)     ~30 min
Phase 2  · Script generation                     ~30 min
Phase 3  · Inspector wiring + animation config   ~1–2 h
Phase 4  · Device test + iterate                 ~1–2 h
Phase 5  · Submission prep                       ~1 h

## Pipeline checklist

Copy this into the response when starting a build, check items off as you progress:
Lens Build Progress:

 Phase 0: Repo, git, .gitignore, .gitattributes, LS project saved
 Phase 0: Lens Studio MCP registered and verified
 Phase 1: Assets prepped (PNG, ASTC, ≤1024px)
 Phase 1: Scene Hierarchy built (frozen state)
 Phase 1.5: All API surfaces validated on live LS instance
 Phase 2: Scripts generated using validated patterns
 Phase 3: @inputs wired, tweens configured
 Phase 4: iPhone tested, mid-range Android tested, FPS ≥25
 Phase 5: Final assets, icon spec verified, lens published


## Guiding principles

1. **2D-first.** Reach for 3D only when the brief demands it.
2. **Tap-as-primary input.** Add gesture detection only as enhancement.
3. **MCP is optional.** If MCP setup exceeds 90 min, skip it — every lens can ship without it.
4. **Validate APIs empirically before generating code.** LS 5.x API names shift across minor versions. Web search and training data are not authoritative — the live LS instance is.
5. **Mid-range Android testing is non-negotiable.** Desktop preview lies.

## Scope discipline

Lens projects fail more often from feature creep than from technical issues. Hold the line:

- MVP first, stretch goals second. Never start polish (audio, particles, idle animations) until Phase 4 Definition of Done is met.
- "Lagom ambitiöst" — use Claude Code aggressively where it saves time, but don't build tooling that exceeds the lens itself in complexity.
- One client brief = one lens. Resist scope expansion mid-project; capture new ideas as v2 candidates instead.

## Domain context

Snapchat-specific terminology and constraints worth knowing explicitly:

- **Sponsored Lens** = paid AR ad on Snapchat, distributed via Snap Ads Manager. Always 18+ ad-gated for regulated categories.
- **Ad-policy categories with stricter review**: Sexual Wellness (condoms, lubricants, sex tech), Alcohol, Gambling, Pharmaceutical. Snap reviews on US standards regardless of campaign region — Nordic projects in these categories must clear US-conservative content guidelines.
- **Snap ad-review SLA**: 1–3 business days for general categories; 1–2 weeks for regulated categories or rejected resubmissions. Plan accordingly.
- **Performance standard**: Snap reviews lenses on mid-range Android, not high-end iPhone. Desktop preview is misleading and over-optimistic.
- **Related lens types** (NOT this skill's scope): Community Lens (organic, different submission flow), AR Object / Spectacles experiences (different toolset), Snapchat Filters that aren't Lens Studio (legacy 2D photo filters).

## Critical references

Read in this order when starting:

- `references/mcp-setup.md` — Lens Studio MCP registration, reconnect playbook for token rotation
- `references/lens-studio-api-gotchas.md` — Validated LS 5.x API surface (Image.rotationAngle vs localTransform, FileTexture vs Texture, ScreenTransform anchor format, Tween Manager package, etc.)
- `references/capability-validation-protocol.md` — How to verify API assumptions on the live LS instance before Phase 2
- `references/build-pipeline.md` — Phase-by-phase detail with deliverables and tasks

## Performance budget

Default targets — adjust per brief, but don't loosen without explicit reason.

| Metric | Target | Hard limit |
|---|---|---|
| Lens size | ≤ 4 MB | 8 MB |
| FPS (mid-range Android) | ≥ 30 | 25 |
| RAM | < 80 MB | 100 MB |
| Tap-to-primary-feedback | ≤ 3 s | 5 s |
| Texture compression | ASTC | — |

## Project documentation pattern

Each lens project ships with a standard `docs/` set. Template scaffold lives in `assets/project-template/`. Copy as starting point for new projects.

- `README.md` — overview, status, quick links
- `PROJECT-PLAN.md` — phases, milestones, risk log
- `USER-EXPERIENCE.md` — second-by-second user journey
- `TECH-SPEC.md` — assets, scripts, performance, state machine
- `COPY-GUIDELINES.md` — tone of voice (if user-facing copy is part of the lens)
