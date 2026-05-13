# Snap Lens Studio docs — routing index

**Mirror:** developers.snap.com/lens-studio/ (5.x current)
**Captured:** 2026-05-13
**Curation scope:** Custom Snapchat filter design via Claude Code + MCP integration
**Files:** 365 (300 must-have + 64 nice-to-have + 1 LS-home)
**See also:** `.mirror-meta.md` for full inventory + maintenance procedure

---

## How to use this index

Look up the topic you need below → read the suggested file(s) first. Each file is a raw markdown copy of a Snap docs page; internal links use absolute `/lens-studio/...` paths pointing back to the live site (these don't resolve locally — use them as breadcrumbs to find sibling pages).

**Don't grep blindly across 365 files.** Use this routing table first; only grep when the routing entry doesn't pinpoint the exact answer.

**Cross-references to skill knowledge:**
- For tracker-driven content empirical patterns → `../body-anchored-calibration.md` (skill memory)
- For LS 5.x API gotchas from real builds → `../lens-studio-api-gotchas.md` (skill memory)
- For MCP tool schemas (empirical capture) → `../mcp-tool-schemas.md` (skill memory)

---

## Must-have routing

### MCP + Claude Code (HIGHEST PRIO)

| Need | Read |
|---|---|
| Set up MCP server, register Claude Code | `01-mcp-and-claude-code/developer-mode-with-claude-code.md` |
| What MCP tools do (Get Scene Graph, setProperty, etc.) | `01-mcp-and-claude-code/developer-mode.md` + `../mcp-tool-schemas.md` |
| System-prompt examples for MCP | `01-mcp-and-claude-code/custom-prompt-for-mcp.md` |
| Context engineering for LS | `01-mcp-and-claude-code/developer-mode-context-engineering.md` |
| Custom Components for AI / Creator Mode | `01-mcp-and-claude-code/ai-custom-components.md` + `ai-cc-example.md` |
| Creator Mode (formerly Easy Lens) | `01-mcp-and-claude-code/creator-mode.md` |
| Lens Studio AI overview | `01-mcp-and-claude-code/overview.md` |
| Cursor / VSCode MCP setup (cross-ref) | `01-mcp-and-claude-code/developer-mode-with-cursor.md` + `-with-vscode.md` |

### Scripting API

| Need | Read |
|---|---|
| Script basics, lifecycle, events | `02-scripting-api/scripting/` (start with `script-overview.md`) |
| Animation, tween, AnimationPlayer | `02-scripting-api/animation/` |
| Audio playback, AudioTrackAssets | `02-scripting-api/audio/` |

### Assets pipeline

| Need | Read |
|---|---|
| Supported file formats (FBX/GLB/OBJ/PNG/JPG/MP3) | `03-assets-pipeline/importing-and-exporting-resources.md` |
| 3D export from Blender / Maya / Cinema4D / 3DS-Max | `03-assets-pipeline/3d/exporting-content/` |
| 3D import (FBX, GLTF, OBJ) | `03-assets-pipeline/3d/importing-content/` |
| 3D animation (skeletal, vertex) | `03-assets-pipeline/3d/animation/` |
| Texturing | `03-assets-pipeline/3d/texturing/` |
| 2D assets (image, video, GIPHY, media-picker) | `03-assets-pipeline/2d/` |
| Materials, shaders | `03-assets-pipeline/graphics/materials/` |
| Particles, VFX (overview, NOT node-refs) | `03-assets-pipeline/graphics/particles/` |
| Raytracing | `03-assets-pipeline/graphics/raytracing/` |
| Asset Library, asset packages | `03-assets-pipeline/asset-library/` + `package-management/` |

### Scene + Lens Studio interface

| Need | Read |
|---|---|
| Panels, hotkeys, Asset Browser, Scene Hierarchy | `04-scene-and-components/lens-studio-interface/` |
| Scene set-up, camera, render-order | `04-scene-and-components/scene-set-up/` |
| Behaviors, tweens, triggers, interactivity | `04-scene-and-components/adding-interactivity/` |
| Text rendering (2D/3D) | `04-scene-and-components/text/` |
| UI patterns | `04-scene-and-components/ui/` |
| Prefabs | `04-scene-and-components/prefabs.md` |
| Pairing to Snapchat / previewing | `04-scene-and-components/pairing-to-snapchat.md` + `previewing-your-lens.md` |
| Camera modes (dual-camera, etc.) | `04-scene-and-components/camera/` |
| Advanced (source control, etc.) | `04-scene-and-components/advanced/` |

### AR Tracking (all body parts)

| Need | Read |
|---|---|
| Face: face-mesh, face-liquify, retouch, eye-color | `05-ar-tracking/face/` |
| Head-attached 3D objects, head-mesh, paper-head | `05-ar-tracking/face/head-attached-3d-objects.md` + `face-templates/` |
| Body-mesh, external-mesh, upper-body tracking | `05-ar-tracking/body/` |
| Body segmentation (incl. footwear segmentation) | `05-ar-tracking/body/segmentation/` |
| Foot tracking (Try-On Pack Sneakers) — see also Try-On below | `06-try-on/foot-tracking.md` + `../body-anchored-calibration.md` (skill empiri) |
| Hand tracking | `05-ar-tracking/hand/` |
| World tracking, surface tracking | `05-ar-tracking/world/` |
| Image-marker, marker-tracking, Snapcode | `05-ar-tracking/world/marker-tracking.md` + `world-templates/` |
| 3D Object tracking | `05-ar-tracking/world/object-tracking.md` + `body/object-tracking-3d.md` |

### Try-On (all categories)

| Need | Read |
|---|---|
| Sneakers / footwear (we have empirical patterns) | `06-try-on/foot-tracking.md` + `../body-anchored-calibration.md` |
| Eyewear / glasses | `06-try-on/eyewear-try-on.md` |
| Earrings | `06-try-on/earring-try-on.md` |
| Rings | `06-try-on/ring-binding-component.md` |
| Wrist-wear (watches, bracelets) | `06-try-on/wristwear-try-on.md` |
| Clothing / garments | `06-try-on/clothing-try-on.md` + `garment-transfer.md` |
| Cloth simulation | `06-try-on/cloth-simulation-try-on.md` |

### Publishing + Sponsored Lenses

| Need | Read |
|---|---|
| Sponsored Lens requirements, Snap Ads Manager submission | `07-publishing/submitting/` + `sponsored/` |
| Standard lens submission, content policy | `07-publishing/submitting/submission-guidelines.md` |
| Icon, preview-video, project-info | `07-publishing/configuring/` |
| Lens discovery, Snap Kit distribution | `07-publishing/distributing/` |

### Performance + Optimization

| Need | Read |
|---|---|
| FPS, memory, lens-size budget overview | `08-performance/overview.md` |
| Mobile performance monitor | `08-performance/mobile-monitor.md` |
| Performance toolkit | `08-performance/` (browse) |

### Overview / getting started

| Need | Read |
|---|---|
| What is Lens Studio? | `09-overview/getting-started/what-is-lens-studio.md` |
| LS Home Page | `09-overview/home.md` |
| Lens Studio overview | `09-overview/getting-started/lens-studio-overview.md` |
| Building your first lens (multi-page tour) | `09-overview/building-your-first-lens/` |
| Migrating from Spark / Effect House / Unity | `09-overview/migrating-to-lens-studio/` |

---

## Nice-to-have routing

| Need | Read |
|---|---|
| Custom ML models (training, deployment) | `nice-to-have/snap-ml/` |
| GenAI components, AI portraits, head-morph, prompts | `nice-to-have/genai-suite/` |
| Physics, collisions, gravity | `nice-to-have/physics/` |
| Backend API calls from lens | `nice-to-have/remote-apis/` |
| Stateful lenses, session data | `nice-to-have/persistent-storage/` |
| Cloud features (multi-user, sync) | `nice-to-have/lens-cloud/` |
| Prompt & Response (LS AI features) | `nice-to-have/prompt-response/` |

---

## Excluded — NOT in this mirror

Look up online if you really need:
- Material Editor / VFX Editor / Visual Scripting **node** docs (parent overview pages ARE here)
- Tutorials, Examples
- Plugin Development
- Bitmoji Avatar/Suite, Games
- Connected Lenses, Location AR, User Context, Voice ML, Lens Creator Rewards
- All Lens Studio 4.55.1 (deprecated)

---

## When to update this mirror

Quarterly OR on major LS-version bump. See `.mirror-meta.md` for procedure.
