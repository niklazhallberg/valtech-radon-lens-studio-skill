# Asset Library Guide (LS 5.x)

Navigation conventions, install patterns, and meta-rules for Snap's Asset Library — the single most-used source of pre-built components in every lens recipe.

**Source**: https://developers.snap.com/lens-studio/assets-pipeline/asset-library/asset-library-overview (compiled 2026-05-20). Source covers LS 5.x; categories and conventions are version-stable.

## Why this file matters

Almost every recipe in `lens-recipe-catalog.md` starts with `Asset Library → search [name] → Install → drag prefab into Scene Hierarchy`. Three meta-rules trip colleagues up repeatedly:

- **Prefab name suffixes** are literal install instructions, not asset names
- **Packed vs unpacked** asset packages have different edit + update semantics
- **Project-installed vs LS-installed** scope causes "why is this still here?" confusion

This file documents those + the full category map so the agent can navigate the Asset Library precisely instead of generically saying "search Asset Library".

## The 16 Asset Library categories

When a colleague asks *"is there an Asset Library item for X?"*, the agent can suggest the right **category bucket** to search:

| Category | Contains |
|---|---|
| **Essentials** | Must-have building blocks |
| **3D** | Meshes, characters, environments |
| **2D** | Sprites, icons, backgrounds |
| **Materials** | Pre-built shader graphs |
| **Tools** | Utility scripts and helpers |
| **Effects** | Visual effects (particles, distortions, post-effects) |
| **SnapML** | ML models for face / body / object detection |
| **Music** | Licensed music tracks (Snap Music Library) |
| **Audio** | Sound effects and audio resources |
| **Reference** | Sample projects to learn from |
| **Spectacles** | Spectacles AR Object specific — **OUTSIDE our skill scope** |
| **APIs** | Remote API modules |
| **Custom Components** | Bundled component packages |
| **Script Modules** | Reusable script modules |
| **UI** | UI design assets and patterns |
| **Plugins** | Editor plugins |

**Use case**: instead of *"check Asset Library"*, the agent can say *"look in the SnapML category for face-detection ML models"* or *"the Music section has Snap's Licensed Music library — different from the Audio section which is SFX"*.

## Prefab placement suffix convention

When an installed prefab's name ends with one of these suffixes, the suffix is **literal placement guidance** — not part of the asset's actual name:

| Suffix | Where to drag |
|---|---|
| `__PLACE_IN_SCENE` | Scene Hierarchy at any level |
| `__PLACE_IN_OBJECTS_PANEL` | Same as PLACE_IN_SCENE (older naming) |
| `__PUT_UNDER_MAIN_CAM` | Under the main Perspective Camera |
| `__PUT_IN_ORTHO_CAM` | Under an Orthographic Camera |
| `[EDIT_ME]`, `[REPLACE_ME]`, `[TOGGLE_ME]` | Inspector / runtime configuration hints from the asset author |

**Common gotcha**: ignoring the suffix is the #1 cause of *"I installed the asset, dragged it in, and nothing happens"*. The suffix IS the install instruction — not decoration.

**Recipe cross-reference**: many entries in `lens-recipe-catalog.md` (e.g. A-2 Makeup `Makeup__PLACE_IN_OBJECTS_PANEL`, B-2 Animated Object `Animated Object__PLACE_IN_SCENE`, E-3 Footwear Try-On `[REPLACE_ME]`) carry these suffixes.

## Packed vs unpacked Asset Packages

Some Asset Library items arrive as **packed** Asset Packages — a single bundled resource you cannot edit until you explicitly unpack it.

### To unpack
- Right-click the asset in Asset Browser → **Unpack for Editing**

### Symptoms of "I edited but it didn't save"
- Inside-prefab edits to a packed asset are silently lost on save until you unpack
- The Apply button may not activate for changes inside a packed asset

### Keep packed where possible

A **packed** asset can later receive updates from the Asset Library via right-click → **Pull Update from Library**. Unpacking breaks that update path — once unpacked, you've forked the asset's internals and won't get future Snap-shipped fixes automatically.

**Convention** (borrowed from the broader LS-developer community): when you must fork a packed component to modify it, suffix the copy's name with `_Modified` (e.g. `Beat Sync_Modified`). Makes it visually obvious in the Asset Browser which assets have been forked and won't receive automatic updates.

**Decision rule for the agent**:
- Need to change Inspector-exposed properties? → keep packed, edit in Inspector
- Need to change script internals or scene structure? → unpack (and warn the colleague that future Snap updates won't auto-apply)

## "Project Installed Content" vs "Lens Studio Installed Content"

The Asset Library has two install scopes that confuse colleagues:

| Scope | Where it lives | When to uninstall |
|---|---|---|
| **Project Installed Content** | Inside this `.esproj` only | When you no longer need the asset in *this* project |
| **Lens Studio Installed Content** | Global LS install cache, shared across all projects on this machine | Almost never — keep cached for fast re-install in future projects |

### Common symptom

*"I uninstalled this asset, why is it still showing in Asset Library as installed?"* → it's still in the LS-wide cache, just removed from this project. That's intentional — saves redownload time across projects.

### To fully remove from machine
- Uninstall from Package Manager preferences (LS preferences → Package Manager)

## Useful sub-pages from the Asset Library tree

For deeper dives the agent (or colleague) may want to surface:

- **Asset Library Publishing Guide** — how Valtech could eventually publish its own internal-use assets to share across projects (relevant if we want to build a Valtech-RADON asset bank long-term)
- **SnapML overview** — for custom ML model integration (deferred to separate research round)
- **Custom Components documentation** — internal mechanics of packed components
- **Asset Packages introduction** — packing / unpacking discipline in more depth
- **Package Manager preferences** — global install management UI
- **Plugins overview** — editor-side extension surface (LS 5.20 added Plugins-in-Packages flow)

## Cross-references

- **Recipe catalog**: every recipe install path → `references/lens-recipe-catalog.md`
- **Chat Tool Package** (specific Asset Library install for MCP) → `references/mcp-setup.md`
- **GPU Particle External Time gotcha** (Inspector-only setting on a packed asset) → `references/lens-studio-api-gotchas.md` Part 2 → "GPU particle External Time must be checked per-material"
- **`.lso` deprecated, render layers dropped** → `references/lens-studio-api-gotchas.md` Part 2 → "`.lso` is deprecated"
- **LS 5.20+ Plugins in Packages** → `references/mcp-setup.md` LS 5.20+ version notes

## Adding new findings

When a Valtech project surfaces an Asset Library behaviour not in this file:

1. **Asset name + category** — which item, which bucket
2. **Pattern / fact** — one sentence
3. **Gotcha** if any
4. **Source** — Snap docs URL or empirical record
5. **Confidence** — official-docs / multi-source / single-source / valtech-validated
