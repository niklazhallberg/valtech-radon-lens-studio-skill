# Lens Studio Snapchat Filter — Claude Code Skill

A Claude Code skill for building Snapchat AR Lenses and Sponsored Lenses in Lens Studio 5.x. Captures the 5-phase build pipeline, empirically-validated LS 5.x API surfaces, MCP setup playbook, and Snap submission requirements from production agency lens projects.

**Author**: Niklaz Hallberg / Valtech RADON

## What's inside

- `SKILL.md` — entrypoint: pipeline, scope discipline, performance budget, domain context
- `references/` — load-on-demand detail
  - `mcp-setup.md` — Lens Studio MCP registration and token-rotation reconnect
  - `build-pipeline.md` — phase-by-phase build steps with deliverables
  - `capability-validation-protocol.md` — how to validate LS 5.x APIs on the live instance before generating code
  - `lens-studio-api-gotchas.md` — empirically-validated API patterns and anti-patterns
- `assets/project-template/` — drop-in scaffolding for new lens projects (gitignore pair, PROJECT-PLAN.md)

## Scope

In scope: Snapchat Lenses and Sponsored Lenses built in Lens Studio 5.x.

Out of scope: TikTok Effect House, Meta Spark, Snap Spectacles AR Object, Three.js / WebXR, Unity AR Foundation, native AR SDKs.
