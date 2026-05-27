# Asset Library Guide (LS 5.x)

Navigation conventions, install patterns, and meta-rules for Snap's Asset Library — the single most-used source of pre-built components in every lens recipe.

**Source**: https://developers.snap.com/lens-studio/assets-pipeline/asset-library/asset-library-overview (compiled 2026-05-20). Source covers LS 5.x; categories and conventions are version-stable.

## Why this file matters

Almost every recipe in `lens-recipe-catalog.md` starts with `Asset Library → search [name] → Install → drag prefab into Scene Hierarchy`. Three meta-rules trip colleagues up repeatedly:

- **Prefab name suffixes** are literal install instructions, not asset names
- **Packed vs unpacked** asset packages have different edit + update semantics
- **Project-installed vs LS-installed** scope causes "why is this still here?" confusion

This file documents those + the full category map so the agent can navigate the Asset Library precisely instead of generically saying "search Asset Library".

## What this file covers vs what it does NOT cover

**Asset Library = Snap-provided, agent-fetchable** generic components: pre-built meshes, materials, particle effects, audio templates, custom components, ML models, scripts, plugins. The agent can search and install these freely on the colleague's behalf.

**NOT in scope here**: client-specific assets (brand logo, branded 3D models, licensed music, brand fonts, custom artwork). Those are the **colleague's responsibility** to attach to the project's `assets/` folder — the agent doesn't fetch or generate them. See `SKILL.md` → "Asset sourcing — what the agent fetches vs what the colleague provides" for the canonical boundary.

Brief-intake question for the agent: *"Har ni egna logotyper, 3D-modeller eller licensierad musik som ska in i lensen? I så fall, lägg dem i projektmappen. Allt annat — partikeleffekter, ansiktsmesh, standardmaterial — fixar jag från Snaps bibliotek."*

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

### Gotcha: "Duplicate" is NOT available on packed assets (LS 5.21, empirically verified)

If a colleague tries to right-click on an asset *inside* a `.lspkg` package (e.g., `sparkles_vfx` inside `Sparkles VFX.lspkg/VFX/`) and looks for a "Duplicate" option to fork it into project assets, **the menu won't contain Duplicate**. The available items are only `Re-import`, `Relink to new Source`, `Expand/Collapse All`, `Group`, `Organize Folder Structure`, `Find Usage`.

**To duplicate a packed asset for editing**:
1. Right-click on the **package root** (the row with the package icon, NOT the asset inside) → `Unpack` / `Unpack for Editing`
2. The entire package contents move out of `Packages/...lspkg/` and into your project's main `Assets/` folder
3. Now the previously-packed assets are normal editable assets — open them in their respective editors (VFX Editor, Material Editor, etc.)

**Why this confuses people**: web-developer mental model expects "Duplicate" everywhere. LS treats packed content as immutable until the whole package is unpacked. The agent should select the package root for the right-click context menu, not the inner asset.

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

## Publishing assets to the public Asset Library

**Source**: https://developers.snap.com/lens-studio/assets-pipeline/asset-library/asset-library-publishing-guide (compiled 2026-05-20).

### Critical strategic point: there is no private / org-scoped publishing

The Asset Library publishing flow is **public only**. There is no Valtech-only or org-scoped version of the Asset Library — anything published is visible to every lens developer on Snapchat. **Implication for the agent**: if a colleague asks *"can we publish our internal Valtech helpers as an Asset Library package?"*, the answer is yes, but it goes public. For Valtech-only sharing, the right path is a **private `.lspkg` distribution via this skill's git repo** (or a separate internal Valtech repo), not the Asset Library.

### Who can publish

Snap doesn't document explicit eligibility criteria. The only stated requirement: *"Log in to My Lenses with the Snapchat account you want to publish under."* Implies open access for any developer with a Snapchat account, but eligibility is not formally documented.

### Publishing flow

1. Open new project in LS → verify the asset imports correctly before submitting
2. Log in to My Lenses with the Snapchat account that should be credited
3. Sidebar → Asset Library Assets → **Create Asset**
4. Upload asset file: `.lspkg`, `.lsc`, or `.zip`
5. Upload thumbnail: **512×512 PNG**, transparent background
6. Fill submission fields: description, category, version, external link
7. Submit

**Notably absent from Snap's docs**: review timeline, approval SLA, rejection criteria, dispute / takedown process. Snap directs questions to `lensstudio-support@snapchat.com`.

### Publishable asset types

- Textures and texture packs
- Materials (**Graph materials only** — not standalone shaders)
- VFX assets (particle systems)
- 3D models / assets
- Scripts and Custom Components
- Installable packages (`.lsc` files)
- Plugins (zipped plugin folders)
- Prefabs

**NOT in the publishable list** (per current docs):
- ML models (SnapML)
- Audio assets as standalone items
- Fonts as standalone items
- UI components as standalone items

If a colleague wants to distribute one of these, they have to bundle it inside a containing prefab / Custom Component.

### Quality bars (concrete numeric limits)

These are Snap's **published requirements** — meeting them is required for acceptance:

| Asset type | Limit / requirement |
|---|---|
| **3D models** | ≤ 100,000 triangles (≤ 60,000 with joints/skinning); descriptive mesh/bone naming; correct pivot; applied transforms; correct normals; UV maps + textures; normal maps preferred for detail; **no Legacy Import** for animations — use Animation Player; export at 30 FPS at full frame range |
| **VFX / particles** | ≤ 50,000 particles; subgraphs + code nodes for organisation; follow optimization guidelines |
| **Materials** | Graph materials only; meaningful Title + Script Name values; clean readable graphs using subgraphs; comment nodes for clarity |
| **Textures** | Minimize file size; organize in folders for packs |
| **Scripts / Components** | Compile with zero errors; include comments or JSDoc; versioned + attributed; **third-party licenses disclosed if applicable** |
| **Thumbnails** | 512×512 PNG transparent background; engaging and faithful to asset; space around subject to avoid UI crowding |

### General requirements (apply across types)

- **Reusable**: package work so others can import it without untangling a whole project
- **Versatile building blocks** supporting multiple lens types — not project-specific
- **Complete English documentation** (no other languages for instructions)
- **Clear naming and parameter descriptions**
- **Compiled code with zero errors**

### Version targeting

- Set **Min Version** to the LS version used to create the asset
- Snap recommends *"prefer the latest Lens Studio when you can"*
- **Max Version** can be left empty if uncertain

### Third-party license discipline

> *"If you use third-party scripts or script modules, ensure the license allows this. If unsure, tell us when submitting."*

Publisher bears responsibility for third-party license compliance. No revenue-share, attribution-display, or ownership-transfer model is described — the asset becomes available in the Asset Library under Snap's standard terms, with the publisher's Snapchat account shown as the source.

### What's not addressed (you'll need to ask Snap directly)

- Review / approval timeline
- Rejection criteria + appeal process
- Updates / versioning post-publication
- Geographic restrictions
- Usage analytics for the publisher
- Monetization
- Takedown procedures
- Content restrictions (no explicit NSFW / IP rules listed — assume Snap Community Guidelines apply)

For all of the above: `lensstudio-support@snapchat.com`.

## Useful sub-pages from the Asset Library tree

For deeper dives the agent (or colleague) may want to surface:

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
