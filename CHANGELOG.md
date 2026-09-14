# Changelog

All notable changes to **lens-studio-snapchat-filter** are documented here.

Discoveries from real Valtech RADON projects flow into the
"Improvements and newly acquired knowledge" section automatically
via the shared `radon-skill-growth` skill — see `references/_growth-protocol-pointer.md`
for the pointer to the mechanic and format spec.

At release time: those entries are consolidated under a `[vX.Y.Z]`
heading with the release date.

Format loosely inspired by [Keep a Changelog](https://keepachangelog.com/)
but adapted for skill evolution rather than a software API.

---

## Improvements and newly acquired knowledge

_New learnings registered from past or ongoing Valtech RADON projects._

### 💡 2026-05-27 — [project: skill-meta]
- **External research integration (ChatGPT deep-research report on LS 5.21)**: cross-referenced an external structured report against the skill and surfaced 8 additive items that fill genuine gaps. New additions: (1) PBR vs Graph Unlit lighting heuristic — Snap explicitly says use Unlit when lighting isn't needed, (2) Custom Code Node = near-pure GLSL with `input_`/`output_` declarations + `main()`, runs through cross-compiler for device-safe shaders, (3) Bool parameters marked **Static** in Material Graph are compile-time constants — `material.mainPass.X = true` from script is silently ignored, (4) Material Editor functional node taxonomy (12 functional groups vs Snap's technical Functions/Inputs/Main/Math menu — easier for agent to pick the right node for a brief), (5) 9th composition pattern: Trigger-bus with Behavior + Script Graph custom triggers (publish-subscribe between Behaviors and Visual Scripting graphs), (6) "What state bears the effect?" mental model as Phase 0 framing — once state type is known the editor choice is mechanical, (7) Lens Studio file-format reality check (table of `.esproj` / `.lsmat` / `.lsvfx` / `.lsscript` / `.ss_graph` / `.mesh` / `.t3d` / `.oprfb` / `.lso` proprietary statuses — agent should NOT hand-author these), (8) 5.17+ Camera scripting API (`getProjectionMatrix`, `getViewMatrix`, `getViewProjectionMatrix`, `renderTargetMipmapLevel`, `renderTargetSlice`) + 5.18+ SceneObject hierarchy lookup methods (`getComponentInAncestors`, `getComponentInDescendants`, `isDescendantOf` etc.), (9) `LensStudio:Spk` editor scripting module pointer for packaging automation.
- Value for user: skill now resolves "should this be Unlit or PBR?", "can I script this Static bool?", "what's the safest file to generate?" in seconds instead of guesswork. The functional node taxonomy lets the agent recommend SPECIFIC graph nodes given a brief. The 9th composition pattern fills a gap for no-code orchestration workflows. The 5.17/5.18 API additions enable more sophisticated render-target chains and polymorphic component lookups.
- Files: `references/material-editor-guide.md`, `references/composition-patterns.md`, `references/lens-studio-api-gotchas.md`, `references/editor-scripting-api.md`
- Type: [discovery]

### 💡 2026-05-27 — [project: skill-meta]
- **Hard-fallback mid-session checkpoint + agent-internal discovery triggers** added to SKILL.md after a 2h session where natural-anchor checkpoints (commit, ⌘S, phase transition, magic moment) all failed to fire during a long debugging loop. Adds: (1) 30-minute iteration checkpoint — STOP and run skill-growth-protocol if 30 min passed since last commit/protocol-fire AND empirical work happened, (2) 5-failed-attempts checkpoint — the list of negative results IS the discovery, (3) agent-internal trigger phrases (when YOU think "hmm that's not what I expected", "API doesn't match docs", "tried 3+ things all ignored", "empirically verified that X" — those thoughts ARE the protocol signal, don't wait for the user).
- Value for user: closes the failure mode "agent goes deep for hours without surfacing discoveries". Mechanical fallbacks fire when natural anchors don't.
- File: `SKILL.md` § "Mandatory checkpoints — re-anchor to the growth protocol at these moments"
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **vec4 setProperty via dotted-path scalars works empirically** (workaround to the documented compound-type silent-drop): writing `setProperty(propertyPath: "endAnchorsBounds.z", valueType: NUMBER, value: -0.18)` persists correctly even though writing the full vec4 object via `valueType: VEC4` would silent-drop fields 3+. Applies to ANY vec4/vec3/vec2 field — `anchor.top`, `localPosition.y`, TweenScreenTransform's `endAnchorsBounds`, etc. Use routinely; faster + more reliable than batched VEC4 writes.
- Value for user: every MCP user fighting the compound-type silent-drop now has a clean workaround. Saves trial-and-error on the documented gotcha.
- File: `references/lens-studio-api-gotchas.md` § "Category 2: Compound types (RECT/VEC4/VEC2)"
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **Anchor-grow tweens drift the visual center when `start.center != end.center`**: a `TweenScreenTransform` of type Anchors that animates from a small/narrow rectangle to a large/wide one will VISIBLY DRIFT during the animation if the start and end anchor rectangles don't share the same midpoint. Manifests as the object "growing upward" rather than "growing from middle outward". Mitigation: verify `start.x + start.y == end.x + end.y` AND `start.z + start.w == end.z + end.w` before authoring the tween. For horizontal-only grow, keep start.z = end.z and start.w = end.w.
- Value for user: any reveal/dismiss animation using anchor-grow has this latent pitfall; saves the 20-30 min of "why does it drift up" debugging the next time.
- File: `references/lens-studio-api-gotchas.md` § "Anchor-grow tweens drift the visual CENTER..."
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **`LayerSet.empty()` / `makeNone()` / `makeAll()` static helpers do NOT exist in LS 5.21 runtime types**: the common pattern "hide without disable via empty LayerSet" requires constructor methods that aren't in the public TS types. All three plausible names fail with `TS2339: Property 'X' does not exist on type 'typeof LayerSet'`. No clean public API for "hide-but-tick" exists in 5.21.
- Value for user: every developer reaching for layer manipulation as a hide-but-keep-running mechanism hits this dead end. Knowing up front saves the failed-compile loop.
- File: `references/lens-studio-api-gotchas.md` § "`LayerSet` runtime API..."
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **VFX preset render-properties ignored for some Asset Library presets** (Sparkles VFX 5.15.0 empirically tested — likely applies to others): writing `vfx.asset.properties["Material_Render"] = null`, `Render_Layers = 0`, `Render_Mesh = null`, `Material_Render_IDs = null` all SUCCEED at the property assignment level (no exceptions), but DO NOT actually gate rendering — the VFX continues to render visibly. The render path doesn't re-read these properties at draw-time, or the VFX system caches the original asset references internally. List of empirically-ineffective approaches: Material_Render = null, Render_Layers = 0, Render_Mesh = null, Material_Render_IDs = null, position offset to (10000, -10000, 10000), scale to 0.001, emitParticle = false (gates steady-state only, not t=0 burst).
- Value for user: ~30 min saved on the next colleague's "let me try to hide this VFX from script" iteration. The exhaustive negative-result list is the discovery.
- File: `references/lens-studio-api-gotchas.md` § "VFX preset render-properties..."
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **VFX burst-particles persist across `enabled` toggle cycles — `enabled` is a tick-gate, not a lifecycle-reset**: a VFXComponent's t=0 Burst Spawn block fires ONLY on the first time the simulation ticks. `SceneObject.enabled = false` pauses tick but doesn't reset timeline; subsequent `enabled = true` resumes from where it paused (already past t=0 → no burst). Result: first pop after lens load shows a large burst, subsequent pops only show steady-state emission. Asymmetric "first time is bigger" behavior is by design, surprising, and not script-fixable without preset graph edit (set Burst Count = 0 in VFX Editor) or component-recreate pattern (destroyComponent + createComponent for fresh state every time).
- Value for user: explains the entire asymmetric-burst phenomenon; saves the multi-hour "why is first time different" debugging loop. The fix paths are clearly laid out (edit graph, accept asymmetry, or destroyComponent pattern).
- File: `references/lens-studio-api-gotchas.md` § "VFX burst-particles persist across `enabled` toggle cycles..."
- Type: [discovery]

### 💡 2026-05-27 — [project: skill-meta]
- **Asset Library `.lspkg` packed assets: "Duplicate" not in context menu — must Unpack on package root**: trying to right-click on an asset INSIDE a `.lspkg` (e.g., `sparkles_vfx` inside `Sparkles VFX.lspkg/VFX/`) shows only Re-import / Relink / Expand / Group / Find Usage. No Duplicate. To duplicate a packed asset for editing, right-click on the **package root** (the row with the package icon) → `Unpack`. The entire package then moves out of `Packages/...lspkg/` into `Assets/`, making contents editable.
- Value for user: every Anna-level user trying to fork a packaged asset hits this confusing UX. Knowing where to right-click saves ~5 min of menu-hunting per attempt.
- File: `references/asset-library-guide.md` § "Gotcha: 'Duplicate' is NOT available on packed assets"
- Type: [discovery]

### 💡 2026-05-27 — [project: skill-meta]
- **Graph authoring needs a formal four-mode protocol (Discover → Probe → Mutate → Explain), a per-project capability ledger, and a priority order — not ad-hoc API guessing**: builds on the empirical "no graph mutation API" finding to give the agent a *work model* for graph-touching tasks. Discover = enumerate Editor namespaces and graph entrypoints (read-only). Probe = test smallest possible operation on a `__PROBE_` prefixed throwaway asset, always clean up. Mutate = only after probe round-trip + user approval + verification step queued. Explain = separate Verified-working / Working-but-undocumented / Read-only-only / Unsafe in a capability ledger. Priority order: Script Graph first (best-documented, Custom Node bridge pattern lets agent own logic in TS), Shader Graph second (round-trip via the undocumented `convertGraphToYaml` if a project genuinely needs it), VFX Graph last (most fragile due to spawn/update phase structure). Framing: agent's role is "plugin author + probe runner", not "file editor". The position to communicate to the user is "I drive values + wiring; you author graph shape."
- Value for user: next colleague who's tempted to "just try" graph editing in production assets gets a formal discipline that prevents project corruption, an explicit priority order so the most-productive direction is tried first, and the Custom Node bridge pattern that pushes complex logic out of graphs into TypeScript where CC can iterate fast.
- File: `references/graph-authoring-protocol.md`
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **Verified: VFX Graph + Script Graph follow the same opaque-asset pattern as Shader Graph, with VFX being even more restrictive**: closed the capability matrix by installing Sparkles VFX + Behavior (Snap's script-graph proxy) as throwaway probes. `VFXComponent` in Editor API exposes ONLY `enabled`, `name`, `sceneObject`, `id` — **not even an `asset` reference is enumerable**, so VFX parameter-driving requires lens-runtime TypeScript (`script.vfx.asset.properties['name'] = value`) rather than MCP/Editor API. The "Behavior" custom component is NOT a node graph — it's a flat parameter dictionary (`scriptInputInfo` keys like `triggeringEventType`, `setMaterialParameterVec4Value`, `setPosition`). On-disk format `.vfxgraph` is binary like `.ss_graph`. Conclusion holds for all three graph types: node structure not editable, asset opaque, parameter-driving works (with different routes per type).
- Value for user: next colleague gets a verified matrix instead of "we think it works the same" — knows exactly which surface to use for each graph type, and that VFX needs a lens-runtime controller rather than direct MCP.
- File: `references/lens-studio-api-gotchas.md` § "Shader Graph / VFX Graph / Script Graph node structure is NOT editable via the public Editor API"
- Type: [discovery]

### 💡 2026-05-27 — [project: sponsored-lens-production]
- **Empirically verified: Claude Code / MCP CANNOT edit Shader Graph, VFX Graph, or Script Graph node structure in LS 5.21**: ran a full probe via `ExecuteEditorCode` and asset-graphql against the live LS instance. `ShaderGraphPass` asset exposes only id/type/meta/name/fileMeta — no nodes, no graph property. `Editor.Graph.convertGraphToYaml` / `convertYamlToGraph` exist at runtime BUT are not in the public TypeScript types (`keyof typeof Editor.Graph` resolves to empty namespace), take 2 undocumented arguments, and all plausible input combinations returned "Object is null". On-disk `.ss_graph` format is binary (not text/YAML — magic bytes + tag-value blocks for MetaData/Nodes/ChildNodes). `createAsset` for ShaderGraphPass is not supported via asset-graphql. The empirical conclusion replaces my prior week's *guess* (which I wrote into visual-scripting-guide.md without verification): the answer was "no graph editing", confirmed.
- Value for user: next colleague who asks "can CC edit my Shader Graph for me?" gets a verified no with the exact reasoning, plus the list of what CC CAN drive (material parameter values, pass render-state, asset binding, create/delete material assets). Saves the 30-minute "let me try a few API combos" that just happened.
- File: `references/lens-studio-api-gotchas.md` § "Shader Graph / VFX Graph / Script Graph node structure is NOT editable via the public Editor API" + updates in `material-editor-guide.md` P8 and `visual-scripting-guide.md` P6
- Type: [discovery]

### 💡 2026-05-26 — [project: skill-meta]
- **Capability tiers need a feature-by-feature matrix the agent can scan against, not just three abstract bands**: added a 60-row capability matrix organized by category (Face, Body, Environment, UI/interaction, Audio, Visual effects, ML/AI). Each row maps a typical client-brief outcome to its tier (1 / 2 / 3) with a one-liner explaining why. Includes a use-it-like-this protocol (read brief → underline outcomes → map to rows → run honest-language if any Tier 3 → clarify asset gaps if Tier 2) and an explicit note that LS 5.21+ shifts the line in some places.
- Value for user: next colleague triaging a brief no longer has to derive feasibility from first principles for common requests like "3D sneaker on foot", "hair color change", "tap to reveal fortune", "GenAI character on face" — they get an immediate tier read with rationale.
- File: `references/capability-tiers.md` § "Capability matrix — common requests by body-part and intent"
- Type: [discovery]

### 💡 2026-05-26 — [project: skill-meta]
- **TypeScript decorator family in LS 5.x has more silent-failure modes than the existing 4 documented entries**: added 5 more decorator gotchas — `@input` decorator order matters (annotations after, not before, the input line — wrong order silently drops the annotation), `@input` typed as a custom class needs the class file to be loaded ahead of the consumer or runtime read yields null, `@input` boolean defaults work in Script Asset but numeric/string defaults are overridden by Script Component Inspector, underscore-prefixed `@input` is NOT private and still shows in Inspector, `@input` Asset references aren't reliably populated until `onStart` not `onAwake`. Some entries marked VERIFY-tag per the user's memory pattern — confidence varies, validate empirically before trusting.
- Value for user: next colleague writing a TypeScript component for a feature gets the full set of decorator gotchas instead of finding them through hours of "why isn't this wired" debugging. Several of these are non-obvious enough that even experienced LS authors hit them.
- File: `references/lens-studio-api-gotchas.md` § "TypeScript decorator behaviour" (5 new entries)
- Type: [discovery]

### 💡 2026-05-26 — [project: skill-meta]
- **Custom material authoring (Material Editor node graphs) has its own decision rule, performance budget, and silent-failure modes the agent needs to know**: every stylized look that isn't covered by PBR/Unlit/Sprite goes through a Material Editor graph, and the graph has its own gotchas (parameter name typos drop silently from TS → shader, `Branch` nodes don't actually skip GPU work, materials are shared by default between visuals, params set in onAwake can be reset by the visual's enable, Asset Library preset materials are opaque). The guide includes six common recipes (LUT color grade, screen-space dissolve, UV scroll, face-data-driven distortion, stylized outline, camera-feed blur), seven pitfalls, and a per-material-type node-count budget (UI sprite <10, face overlay <15, full-screen <25, particle <12).
- Value for user: next colleague who's asked to add a stylized look gets concrete recipes and a budget instead of trial-and-erroring against mid-range Android FPS; the parameter-naming and onAwake-timing gotchas alone save 1-2 hours of "why isn't this working" debugging.
- File: `references/material-editor-guide.md`
- Type: [discovery]

### 💡 2026-05-26 — [project: skill-meta]
- **Lens Studio's Editor Scripting API (5.17+) is a separate runtime that the agent should reach for at scale — not just `scene-graphql`**: the MCP `ExecuteEditorCode` tool runs code inside the LS editor itself, with full access to the project, scene graph, and asset registry. It's strictly more powerful than `scene-graphql` (one round trip vs N for bulk operations, conditional mutations, computed values) and is the right tool for any operation touching >3 objects, any scene-wide audit, any compute-from-scene mutation, and project-level automation. The guide documents capability comparison vs `scene-graphql`, four common recipes (bulk rename, missing-component audit, anchor snapshot for diff, material reference scan), and six gotchas (TS subset not full Node, ⌘S still required, errors in Logger not MCP response, compound-type silent drop applies, sync-only no setTimeout, findByName case-sensitive).
- Value for user: next colleague needing to rename 12 slots, audit anchor values, or apply conditional mutations across the scene gets one MCP call instead of dragging the LS UI through 12 clicks. Lowers the cost of doing things properly at scale.
- File: `references/editor-scripting-api.md`
- Type: [discovery]

### 💡 2026-05-26 — [project: skill-meta]
- **Lens Studio has two coexisting authoring surfaces — Visual Scripting (node graphs) and TypeScript components — and the agent needs a clear policy for which to reach for**: real lenses mix both, but the agent had no guidance on how to choose, how the two sides hand off (`Call Script API` node, custom-event bus, shared component state), or what the silent-failure modes are (string-based function names and event names typo silently with no compile error). The guide documents four common patterns (tap→tween→audio, face-tracking trigger, timer loop, math-driven material param), six pitfalls (silent typo drops, per-frame profiling blindness, fire-order ambiguity, On Frame vs On Late Update, MCP cannot edit nodes), and a generalizable rule for when to extract a graph into a TypeScript controller.
- Value for user: next colleague who needs to decide "should I script this or graph it?" gets a concrete decision rule and the handoff mechanics; avoids the trap of growing a Visual Script too big and then having to untangle it later.
- File: `references/visual-scripting-guide.md`
- Type: [discovery]

### 💡 2026-05-26 — [project: skill-meta]
- **Lens Studio scenes have a small set of recurring architectural shapes — naming them lets the agent reason at the right level**: rather than re-inventing structure from primitives every time, eight composition patterns cover the vast majority of real lens builds (multi-pass render-target chain, full-frame post-processing effect, script-driven VFX, tracking-driven material, interactive paint, tween-driven animation orchestration, ML/SnapML pipeline, event-graph glue). Each pattern documents when to use it, its anatomy, which editors are involved (Material/VFX/Visual Scripting/etc.), and the common pitfalls. With this vocabulary the agent can map a user brief directly to a known shape ("this is a script-driven VFX with a tween-driven orchestration layer") instead of guessing or drifting.
- Value for user: next colleague who asks "how should I architect a lens that does X" gets a concrete pattern recommendation grounded in real builds, not an ad-hoc invention — and avoids common pitfalls that come baked into each pattern's docs.
- File: `references/composition-patterns.md`
- Type: [discovery]

### 💡 2026-05-26 — [project: sponsored-lens-production]
- **The documented "clip text to a window" trick currently doesn't work in Lens Studio**: Snap's own guide describes how to put text inside a clipping shape so it appears only within the window — but in practice, on Lens Studio 5.21, the text either ignores the clip and renders everywhere or disappears entirely. Snap's docs page itself admits there is "a known bug with masking interactions" without specifying what's broken. Until Snap fixes it, the reliable fallback is a small per-frame script that toggles each text's visibility based on whether its full extent fits inside the intended window.
- Value for user: next colleague who tries to build a slot-machine reel, a scrolling ticker, or any animated-text-inside-a-window stops here instead of spending most of a day rebuilding clipping from scratch — and gets the working script-based fallback pattern.
- File: `references/lens-studio-api-gotchas.md` § "Masking Component does not visibly clip Text grandchildren in LS 5.21"
- Type: [discovery]

### 💡 2026-05-26 — [project: sponsored-lens-production]
- **Older custom components from the Asset Library can quietly fail with "module not found" errors**: many UI components in Snap's Asset Library were built for older Lens Studio versions (4.49, 4.53) and embed version-tagged references to helper modules. On Lens Studio 5.21 those tagged references don't resolve even after installing the matching standalone module packages — the names don't line up. The Preview pauses with a "Cannot find module" error and the lens won't run.
- Value for user: next colleague who tries to base a project on an Asset Library component does a quick isolation test first — drop the component into a side scene with a plain text element and see if the Preview pauses. If it does, the asset is incompatible with the current Lens Studio version and time is saved before wiring up anything bigger.
- File: `references/lens-studio-api-gotchas.md` § "Asset Library custom components built for older LS versions may fail with Cannot find module errors"
- Type: [discovery]

### 💡 2026-05-26 — [project: sponsored-lens-production]
- **Built-in scroll-view component handles masked scrolling content**: when a brief asks for scrolling text, a slot-machine reel, a rolling counter, or any other content that needs to scroll inside a bounded window, Lens Studio's Asset Library has a ready-made `UI Scroll View` component that wraps masking, drag input, and optional scroll bars in one drop-in piece. Using it skips a multi-hour rebuild of the same machinery from primitive parts (Masking + Image + drag scripting + clip math).
- Value for user: next colleague who needs a scrolling list, slot machine, ticker, or rolling counter saves a half-day of rebuilding masking + scroll plumbing from primitives — install one component instead.
- File: `references/lens-recipe-catalog.md` § D-13
- Type: [discovery]

### 💡 2026-05-18 — [project: skill-meta]
- **Manualerna funkar nu utan internet — Handjet är självhostad lokalt**:
  pixel-fonten Handjet låg tidigare bara på Google Fonts CDN. Om en kollega
  satt på en konferens med dåligt wifi eller startade manualen offline efter
  download, föll typografin tillbaka till Space Grotesk och hela den
  "retro-terminal-pixel"-känsla som binder ihop hero, koderblock och
  outro-bubblan försvann.
  - **Fonten är nu lokal**: `docs/assets/fonts/handjet/handjet-latin.woff2`
    + `handjet-latin-ext.woff2` (totalt ~15 KB — variable font, hela
    weight-spannet 100-900 i en enda fil per unicode-range).
  - **Tre HTML-filer uppdaterade** (MANUAL-SIMPLE, MANUAL, MANUAL-EN) med
    `@font-face`-deklarationer som pekar på lokala filerna, plus Handjet
    borttagen ur Google Fonts CDN-URLen.
  - **Space Grotesk + JetBrains Mono ligger kvar på CDN** — de är
    fallback-säkra och pixel-fonten är den enda som verkligen "kraschar
    estetiken" om den saknas.

**Value for user:** manualen håller sin visuella identitet även när
nätverket är opålitligt; en designer som öppnar `MANUAL-SIMPLE.html` på
ett café eller en kunds gästnät ser samma sak som lokalt.

### 💡 2026-05-18 — [project: skill-meta]
- **Pass 0 — Image-to-3D Generation: the skill can now mentor the whole
  chain idea → image → 3D → compression → import → publish**: previously,
  the 3D doctrine started at "you have a .glb"; everything upstream was
  a blank box. New reference file `references/image-to-3d-generation.md`
  covers the first step of the pipeline:
  - **Image requirements with "why"** — background, angle, resolution,
    lighting, subject alone; each requirement explained based on how the
    image-to-3D service segments and generates (less guessing = better
    output).
  - **Prompt → image tips** for ChatGPT Image / Midjourney that
    automatically meet the image requirements; with examples of phrases
    to avoid.
  - **Service selection heuristic** (Meshy / Tripo / Hunyuan3D via fal.ai /
    Rodin) — as a table with best-for / weakness / where it runs. Clearly
    flagged as starting points, not gospel; updated as the skill sees
    more empirical data.
  - **Quality checklist before post-process** — poly-count order, texture
    resolution, typical artifacts (hanging mesh tabs, baked-in shadows,
    smeared surfaces, phantom objects, asymmetry, holes) as explicit
    bullet lists.
  - **Decision point regenerate vs optimize further** — criteria for
    both paths + the principle "optimizing a bad mesh gives you a less
    bad mesh, not a good mesh".
- **Library-first sourcing reinforced in the 3D doctrine**: the agent
  should always start with Snapchat Asset Library / Templates / already-
  imported prefabs before custom 3D generation is suggested. Image-to-3D
  is a fallback — not a default — when the library path genuinely doesn't
  match the user's expectations. Snap-official assets are pre-optimized
  and skip the entire Pass 0–Pass 2 chain; skipping the library check is
  the most common reason a lens unnecessarily lands in the 3D pipeline.
  - Addition in `3d-asset-import-doctrine.md` Section A (agent doctrine)
    and a new Pass 0 block in Section D that points to the new file.
  - Addition in `image-to-3d-generation.md` Section A that catches the
    "library-first didn't match" trigger and reminds about the library
    check as default habit.
- Value for user: the next colleague who wants to create their own 3D
  model from scratch gets mentor support from the first pen stroke —
  which source image, which service, what to look for in the output —
  before optimization even starts. And if the colleague starts with "I
  need something in the scene," the agent suggests the library path
  first; image-to-3D comes as a deliberate choice when the library
  isn't enough, not as a default reflex.
- Files: `references/image-to-3d-generation.md` (new),
  `references/3d-asset-import-doctrine.md` (Section A + Section D Pass 0),
  `SKILL.md` (References pointer + version bump 0.9.0 → 0.10.0)
- Type: [doctrine]

### 💡 2026-05-18 — [project: sponsored-lens-production]
- **GLB post-process: switching the recommended tool from `gltf.report` to
  `optimizeglb.com/dashboard`**: empirical finding from a previous sponsored Lens project where
  the same clean source .glb produced visible mesh artifacts
  (tearing/distortion) after `gltf.report` optimization — even with lossless
  settings, even with PNG instead of JPEG, and even at 2K texture output.
  The artifacts appeared *in the web tool*, before the file even reached
  Lens Studio, and then carried over. The same source .glb through
  `optimizeglb.com/dashboard` produced clean output without artifacts. The
  doctrine is updated: `optimizeglb.com` is now the primary drag-and-drop
  recommendation for designers; `gltfpack`/`gltf-pipeline` remain as CLI
  alternatives; `gltf.report` is flagged with an "avoid for now" note.
- Value for user: the next colleague who takes in an image-to-3D output
  (Hunyuan3D via fal.ai, Meshy, Tripo, etc.) and needs to shrink the file
  before Lens Studio import gets the right tool directly, avoids iterating
  on the same artifact problem that was solved here. The skill also flags
  clearly that the problem arises in the post-process tool — not in Lens
  Studio — so troubleshooting lands in the right place immediately.
- Files: `references/3d-asset-import-doctrine.md` (Pass 1b section)
- Type: [doctrine-correction]

### 💡 2026-05-18 — [project: sponsored-lens-production]
- **GLB-first 3D import doctrine + two-pass optimization — a systematic way
  to keep lens size under Snap's limit when custom 3D models are imported**:
  a previous sponsored Lens project showed how quickly an FBX headwear model could blow up the lens from
  ~3 MB to 34 MB. The skill now has a `references/3d-asset-import-doctrine.md`
  that establishes GLB/glTF as the default format (Snap has a dedicated
  import guide for glTF), with FBX and OBJ as fallback formats. The
  doctrine clarifies the difference between Asset Browser import (resource
  only, prefab must be dragged to the scene) and Scene Hierarchy import
  (resource + instance in one step), and separates the optimization into
  two clear passes:
  - **Pass 1 — before import**: optimize mesh, textures, and format in the
    3D source (whether DCC tool or image-to-3D service), preferably GLB
    with Draco compression
  - **Pass 1b — optional post-process**: `gltf.report` recommended for
    designers (drag-and-drop in browser), `gltfpack`/`gltf-pipeline` for
    CLI folks when Pass 1 wasn't enough
  - **Pass 2 — inside Lens Studio**: BC1/BC3 texture compression per asset
    + Resource Inspector open early in the flow, not at publish time
  
  The skill's internal budget per 3D accessory: ~1 MB compressed. Total
  lens size stays within `SKILL.md`'s Performance budget (≤ 4 MB target,
  8 MB hard limit); 3D-heavy lenses can acceptably land up to ~6 MB.
- Value for user: next time the user imports a custom model, the skill
  starts flagging the size risk *before* the import happens, not when the
  Publishing dialog lights up red. The user also gets a mentor checklist
  that answers four core questions (which format is best, how do I import
  in Lens Studio, what affects lens size, which optimization steps should
  be taken before publish) without having to google the Snap docs. The
  doctrine is tool-agnostic, so it works for both Blender folks and
  designers using image-to-3D services like Meshy, Tripo, or Hunyuan3D
  via fal.ai.
- Files: `references/3d-asset-import-doctrine.md` (new), `SKILL.md` (pointer
  in References + inline sentence in Performance budget + version bump
  0.8.0 → 0.9.0)
- Type: [doctrine]

---

## [v0.8.0] — 2026-05-15

### 💡 2026-05-15 — [project: skill-meta]
- **One-line installer + auto-sync — non-technical designers can onboard
  themselves**: Three pieces that together close the "designer can't set up
  the skill alone" gap.
  - `bin/install.sh` — idempotent installer with mentor-tone output. Nine
    steps: OS check, Node.js/git pre-reqs, Claude Code install, Lens Studio
    verify, skill clone check, SessionStart hook config (via Python
    JSON-merge so existing settings are preserved), state folder, smoke test,
    success summary. Fail-fast with concrete recovery instructions per step.
  - `scripts/session-sync.sh` — SessionStart hook that runs `git pull --ff-only`
    on the skill repo when Claude Code starts. Silent on no-op, friendly
    inline announcement when new entries arrive. Pull-only, never pushes.
  - `README.md` — new "Auto-sync" section documenting the mechanic so
    colleagues understand what they see when the hook fires.
- Value for user: A designer who has been invited as a collaborator can now
  go from zero to working `claude` session in 2–3 minutes — without a
  technical colleague holding their hand. And once installed, every new
  lesson pushed by any colleague reaches their machine automatically the next
  time they open Claude Code. The compound-interest promise becomes real
  instead of aspirational.
- Files: `bin/install.sh`, `scripts/session-sync.sh`, `README.md`, `SKILL.md` (version bump 0.7.0 → 0.8.0)
- Type: [feature]

---

## [v0.7.4] — 2026-05-14

### 💡 2026-05-14 — [project: skill-meta]
- **Warm tone in CHANGELOG + protocol v0.5**: CHANGELOG entries
  now use 💡-emoji, HH:MM timestamp, plain-English description,
  and "Value for user" field. The section title is now
  "Improvements and newly acquired knowledge" instead of
  "[Unreleased]". The protocol template for the agent's in-flow
  ask is rewritten in plain Swedish ("Vi har lärt oss något nytt
  här...") instead of technical "Vi har en discovery..." phrasing —
  the in-flow ask is user-facing chat, so it stays in the user's
  language; the GitHub artifact (CHANGELOG + references files)
  is English-only. Retroactively updated 3 demo entries +
  v0.7.3 entry to the new format.
- Value for user: The CHANGELOG structure becomes readable for
  non-technical colleagues (designers, team leads, leadership).
  The value of each learning is directly visible without having
  to read the file it landed in.
- Files: `CHANGELOG.md`, `references/skill-growth-protocol.md`
- Type: [convention]

---

## [v0.7.3] — 2026-05-14

### 💡 2026-05-14 — [project: skill-meta]
- **Documentation sync: MCP capability gap-fixes (Tier 1)**:
  Cross-validated an external Perplexity Deep Research report
  (2026-05-13) against existing `references/`. Three Tier 1
  gaps closed:
  - `references/mcp-tool-schemas.md` — new section "Vad MCP
    INTE kan göra" (What MCP cannot do): 11-row UI-only
    operations table, desktop preview limits, per-phase
    implications.
  - `references/mcp-tool-schemas.md` — new section "Officiella
    tool-namn ↔ MCP-client-namn" (Official tool names ↔
    MCP-client names): mapping between Snap's 40+ "normalized
    names" and our 20-tools client capture, with a version-
    disclaimer for LS-version evolution.
  - `references/mcp-setup.md` — Chat Tool Package added as a
    prerequisite (Prerequisites bullet + new Step 2 with
    renumbering 2→3, 3→4, 4→5). Honest about the empirical
    observation that core MCP works without explicit install
    in LS 5.20+.
- Value for user: Three operational MCP gaps closed — a
  designer who hits MCP limits in real projects sees directly
  what MCP can and cannot do, and understands the mapping
  between Snap's official tool names and what they actually
  see in Claude Code.
- Files: `references/mcp-tool-schemas.md`, `references/mcp-setup.md`
- Type: [docs]

---

## [v0.7.2] — 2026-05-14

### 2026-05-14 — [project: skill-meta]
- **VALTECH-PRESENTATION.md added**: standalone overview of the
  skill for a broad Valtech audience (designer, team lead, tech
  lead, decision-maker). Seven sections including security and
  ROI. Generalized — no client or personal names.
- File: `docs/VALTECH-PRESENTATION.md`
- Type: [docs]

### 2026-05-14 — [project: skill-meta]
- **Version convention codified in CONTRIBUTING.md**: `SKILL.md`
  `version:` field tracks minor releases only (0.7 → 0.8). Patch
  releases (0.7.0 → 0.7.1) are tracked via git tag + CHANGELOG entry,
  NOT via SKILL.md-bump. Avoids churn from version-stamp commits on
  small fix-ups. Triggered by v0.7.0/v0.7.1-cycle observation that the
  SKILL.md bump per patch wasn't worth its commit overhead.
- File: `CONTRIBUTING.md` § Version convention
- Type: [convention]

---

## [v0.7.1] — 2026-05-14

### Patch — SKILL.md version fix + Generaliseringsregeln in skill-growth-protocol

**Fix:**
- `SKILL.md` — version 0.6.1 → 0.7.0. The bump was missed in v0.7.0
  commit `e2dfa45` (the commit message said "version 0.6.1 → 0.7.0"
  but the file change itself didn't include the version bump).
  Corrected here.

**Feature:**
- `references/skill-growth-protocol.md` (v0.3 → v0.4) — new section
  "Generaliseringsregeln" (Generalization rule) inserted before the
  in-flow ask. Three-step rewrite protocol:
  1. Identify the core (project-specific → universal pattern)
  2. Remove everything project-specific (checklist with explicit ❌/✅)
  3. "Next colleague" test (would a colleague on a different project
     benefit from this?)
  
  Triggered by the observation that the earlier "avoid project-
  specific values" rule was too weak — discoveries landed as
  anecdotes rather than universal rules. Now an explicit
  methodological rule that runs BEFORE the in-flow ask.

---

## [v0.7.0] — 2026-05-14

### Mentor mode (voice / pace / pedagogy) + cumulative discovery history

The skill's first canonical voice capture, plus the protocol for how the skill grows over time.

**New files:**

- **`references/voice-and-pedagogy.md`** — 8 principles (Believe in user, Guide-not-dictate, Honest about uncertainty, Celebrate progress, Connect over time, Give agency, Value-exchange transparency, Embodied first-person voice) + 3 layers (Voice/Pace/Pedagogy). Worked examples from the foot-tracking Sponsored Lens session.
- **`references/glossary-translation.md`** — 19 technical terms in plain language (GLB, FBX, MCP, scene hierarchy, state machine, Try-On Pack, etc.) + first-use rule.
- **`references/mentor-flow-patterns.md`** — 7 templates: progress bar between questions, magic-moment celebration, "come and look in LS" invitation, "find it in the LS UI" navigation, long-call mid-talk, embodied screenshot narration, Inspector handoff.
- **`references/skill-growth-protocol.md`** (v0.3) — in-flow ask for discoveries with colleague-impact framing; SKILL-DISCOVERIES.md as backup path; CHANGELOG.md as mandatory part of every discovery commit.
- **`CHANGELOG.md`** — this file. Cumulative skill biography.

**Rewrites / patches:**

- **`references/onboarding-protocol.md`** — announce-structure reversal (reverses the prior "don't announce 8/3" rule); Q1.2 (feeling) accepts open answer; Q1.3 (tempo) sensory examples instead of seconds; Readiness Report plain-language purpose before filename.
- **`references/concierge-setup-flow.md`** — Step 8 opens with structure announcement instead of hidden pacing.
- **`references/phase-progression.md`** — magic-moment checkpoint per phase (0/B/1/1.5/2/2.5/3/4/5) as structural requirements + overview table. Phase 3 cross-ref to Template 7.
- **`SKILL.md`** — voice mandate leads (before role-split). Version 0.6.1 → 0.7.0.
- **`docs/MANUAL.html`** — rebuilt beginner-first 4-step flow (claude.ai/code → terminal → paste setup prompt → follow Claude). 71 KB bilingual → 32 KB Swedish single-language. Setup prompt as the magic centerpiece. "Stuck?" section with 4 paths including screenshot paste.

---

## [v0.6.1] — 2026-05-13

### Snap-docs mirror + MCP tool schemas + v0.6.0 follow-up patches

The skill's first laser-focused knowledge base + canonical MCP reference.

**New files:**

- **`references/snap-docs/`** — 365 markdown pages curated from `developers.snap.com/lens-studio/` (5.x current), organized in 9 must-have buckets (MCP, scripting, assets, scene, AR-tracking, try-on, publishing, performance, overview) + nice-to-have/. `00-INDEX.md` as routing table. `.mirror-meta.md` for inventory + maintenance.
- **`references/mcp-tool-schemas.md`** — empirical capture of all 20 `mcp__lens-studio__*` tool schemas in 6 categories (Scene 3, Asset 6, Panel 2, File/scripting 5, Generation 2, Runtime/Knowledge 2).

**Follow-up patches to v0.6.0** (commit `c8e0a96`):

- `references/body-anchored-calibration.md` — Step 0 "Library-first sourcing" added before hierarchy walk. Feet section leads with library-scan result (Try-On Pack Sneakers + Foot Tracking template).
- `references/mcp-setup.md` — wording note for the `/exit` restart instruction (resolves the "in the terminal where Claude Code runs" confusion).
- `references/concierge-setup-flow.md` Step 7 — inspiration coaching rewrite with value-exchange + Pinterest/AR-filter screenshot examples.

---

## [v0.6.0] — 2026-05-13

### Body-anchored calibration awareness

The skill's first canonical file — universal probe-first protocol for all tracker-driven content (foot, face, head, hand, body, world-anchored).

**New file:**

- **`references/body-anchored-calibration.md`** (committed `74e9b5f`):
  - 8 mandatory steps (hierarchy walk → defensive component disable → asymmetric experiment → tracker-overwrite detection → wrapper-anchor architecture → mesh-pivot awareness → geometry before material → ⌘S handshake)
  - Per-body-part defaults (feet seeded with Try-On Pack Sneakers + Foot Tracking custom component)
  - Real-device pair-test workflow with pair-test-ask pattern (WHY + WHAT + QUESTION + REASSURANCE)
  - Visual judgment requires correct visual context (screen-coord vs world)
  - Empirical data: AABB formula under-compensates X by ~15-20%, Y-axis should be skipped (sole sits at Y=0)
  - First seeded from a foot-tracking Sponsored Lens build.

---

## Note on cumulative growth

This CHANGELOG is the skill's biography — each line represents either a
release (manually consolidated) or an in-flow discovery from a real project
(automatically prepended by the agent).

The idea: when a Valtech RADON colleague scrolls this file 6 months from
now, they should feel momentum. "We learned X in January, Y in February,
all the way to today. This isn't standing still — it grows on its own
when we use it."

Discoveries over time = compound interest on skill investment.
