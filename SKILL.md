---
name: lens-studio-snapchat-filter
description: Builds Snapchat AR Lenses and Sponsored Lenses in Lens Studio 5.x with Claude Code, optionally with the Lens Studio MCP. Covers the 5-phase build pipeline, empirically-validated LS 5.x API patterns (Image.rotationAngle, ScreenTransform anchors, Tween Manager package, transient-view persistence, FileTexture import), MCP token rotation, mid-range Android performance, Snap ad-policy categories, and Sponsored Lens submission. TRIGGER aggressively when user mentions Lens Studio, Snapchat filter/lens, Sponsored Lens, .esproj or .lens files, a lens/ subdirectory, Snap AR, mcp__lens-studio, Snap Ads Manager, or any LS 5.x API surface — LS 5.x APIs shift between minor versions and training-data assumptions are unreliable, so consult this skill instead of guessing. SKIP when TikTok Effect House, Meta Spark / Instagram filters, Snap Spectacles AR Object, Three.js / WebXR / 8th Wall, Unity AR Foundation, native AR SDKs (Banuba, DeepAR), or Snapchat-app feature questions unrelated to lens building. Community Lenses share Lens Studio tooling but use a different (organic, free) submission flow — only the build phases of this skill apply, not the Sponsored Lens submission flow.
metadata:
  author: Niklaz Hallberg / Valtech RADON
  version: 0.3.0
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

Five phases (plus 1.5), sequential. Each is detailed in `references/build-pipeline.md`.

| Phase | Focus | Time |
|---|---|---|
| 0 | Setup (repo, MCP, LS project) | ~30–60 min |
| 1 | Scene Hierarchy + assets | ~2–3 h |
| 1.5 | Capability validation (CRITICAL) | ~30 min |
| 2 | Script generation | ~30 min |
| 3 | Inspector wiring + animation config | ~1–2 h |
| 4 | Device test + iterate | ~1–2 h |
| 5 | Submission prep | ~1 h |

## Pipeline checklist

Copy this into the response when starting a build, check items off as you progress:

```markdown
Lens Build Progress:
- [ ] Phase 0: Repo, git, .gitignore, .gitattributes, LS project saved
- [ ] Phase 0: Lens Studio MCP registered and verified
- [ ] Phase 1: Assets prepped (PNG, ASTC, ≤1024px)
- [ ] Phase 1: Scene Hierarchy built (frozen state)
- [ ] Phase 1.5: All API surfaces validated on live LS instance
- [ ] Phase 2: Scripts generated using validated patterns
- [ ] Phase 3: @inputs wired, tweens configured
- [ ] Phase 4: iPhone tested, mid-range Android tested, FPS ≥25
- [ ] Phase 5: Final assets, icon spec verified, lens published
```


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

## References (load on demand by phase)

Don't read all of these upfront — pull each one when its phase activates:

- `references/mcp-setup.md` — read at Phase 0 when registering MCP, or any time on token rotation / 401 errors
- `references/build-pipeline.md` — read the section for the current phase (each phase has its own subsection)
- `references/capability-validation-protocol.md` — read at Phase 1.5, before generating any production scripts
- `references/lens-studio-api-gotchas.md` — read at Phase 1.5 and Phase 2 to cross-check every LS 5.x API name before trusting training data (Image.rotationAngle vs localTransform, FileTexture vs Texture, ScreenTransform anchor format, Tween Manager package, transient-view persistence, etc.)

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
