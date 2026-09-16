# Glossary — translating technical terms to plain language

**Status:** Canonical. Companion to `voice-and-pedagogy.md` (specifically principle #1 Believe in the user + the Pedagogy layer).

**Why this file exists:** Each unexplained technical term creates an "I don't belong here" moment for non-technical users. Translating ≠ patronizing. This file gives every common term a plain-language drop-in.

---

## The first-use rule

When you (the agent) use a technical term for the FIRST TIME in a session:

1. **Drop the term naturally in context** — don't make a big deal of explaining
2. **Add ONE plain-language sentence** — short, concrete, often an analogy
3. **After first-use, the term is "unlocked"** — use it freely without re-explaining

**The shape:** `[term] — [plain-language clause]. [Rest of message uses term freely from here.]`

Example: "We need a GLB file of the shoe — it's a 3D format, think JPEG but for 3D objects. Drop the GLB into Assets/3D/ and Lens Studio imports it automatically."

When the same user has heard a term before (e.g., second session, term defined in earlier message), skip the translation. Re-translating after first-use feels condescending.

---

## Term list

### File formats

**GLB**  
Plain: a 3D file format that bundles geometry, textures, and materials in one file. Think JPEG, but for 3D objects.  
First-use: "We need a GLB of the shoe — it's a 3D format, a standard option that works directly in Lens Studio."

**FBX**  
Plain: an older 3D file format, common when content comes from Maya, Blender, or Cinema4D.  
First-use: "FBX is a sibling to GLB — also a 3D format. It shows up often when 3D modelers work in Maya or Blender."

---

### Lens Studio scene concepts

**Scene Hierarchy** (scene hierarchy)  
Plain: the tree of everything in your lens — camera, light, models, scripts. Shown as a folder structure in a panel called Scene Hierarchy.  
First-use: "Scene Hierarchy is the tree of everything in your lens. Think of it like the folder structure in Finder, but with 3D objects — the camera in one branch, the light in another, your assets in a third."

**ObjectPrefab**  
Plain: a reusable group of scene objects, saved as ONE unit. Can be instantiated multiple times; each instance links back to the "template".  
First-use: "Try-On Pack comes as an ObjectPrefab — a grouping of several scene objects (left + right shoe + materials) that Lens Studio treats as one unit."

**Try-On Pack**  
Plain: a pre-packaged Snap asset with meshes, materials, and scripts for a specific try-on scenario (e.g. sneakers, eyewear). Installed via Asset Library with one click.  
First-use: "Try-On Pack is a ready-made package from Snap — meshes, materials, and scripts for foot try-on, all bundled. Installing it now via Asset Library."

**Anchor**  
Plain: a 3D point the tracker updates every frame. The asset you want to follow the body part is set as a child of the anchor point.  
First-use: "Foot Tracking gives us two anchors — one per foot. The left shoe is set as a child of `leftFootAnchor`; the tracker updates the anchor so the shoe follows the foot."

**Mesh pivot**  
Plain: the 'origin' point of a 3D model — where the model 'hangs' from. If the pivot is offset from the center, the model ends up crooked when you place it at an anchor.  
First-use: "Mesh pivot is the 3D model's hanging point — where the model 'attaches' when we place it at the foot anchor. If the pivot lies outside the center of the shoe, the shoe ends up crooked."

**AABB** (axis-aligned bounding box)  
Plain: the smallest right-angled 'box' that contains a 3D object. I use it to compute where the mesh center sits relative to the pivot point.  
First-use: "AABB is the invisible box around a 3D model. I read the AABB via MCP to compute how far off-center the pivot is."

---

### Tracker behavior

**Tracker overwrite**  
Plain: when the tracker overwrites your change every frame, so your scale or position change disappears immediately. The solution is a wrapper anchor (a middle layer).  
First-use: "The tracker overwrote my scale change — that's 'tracker overwrite', meaning the tracker owns that property and we can't change it directly. The solution comes in probe 4: wrapper anchor."

**Wrapper anchor**  
Plain: an empty intermediate object between the tracker and your asset. The tracker writes to the intermediate object; your asset (as a child) keeps its own transform untouched.  
First-use: "Wrapper anchor is an empty 'middle layer' between the tracker and the shoe. The tracker gets to write to the wrapper, your scale on the shoe (which sits as a child) stays untouched."

---

### Behavior / logic

**State machine**  
Plain: a sequence of states the lens can be in — e.g. 'waiting for foot', 'foot found', 'shoe showing', 'user tapped CTA'. Transitions between states are triggered by events.  
First-use: "State machine is the 'flowchart' for the lens — which modes it can be in and how it switches between them. E.g.: 'waiting' → 'foot found' → 'shoe showing' → 'tapped'. We specify these in TECH-SPEC."

**Tween**  
Plain: a smooth transition between two values over time — e.g. fade-in (0 → 100% opacity over 1 second).  
First-use: "Tween is a soft transition between two values. The 'shoe pops up' animation is a tween from scale 0 to scale 1 over ~0.4 seconds."

**Easing**  
Plain: how a tween accelerates and decelerates — linear (straight), ease-out (slows down at the end), cubic (smooth arc).  
First-use: "Easing controls how the tween feels — 'ease-out' slows down at the end, 'linear' is constant speed, 'cubic' is a smooth arc. Different easings give different feel in the same second."

---

### Build process

**Scaffolding**  
Plain: the lens's static skeleton — scene objects, anchors, textures, materials — WITHOUT scripts or animation. Just enough to see that the placement is right before we add logic.  
First-use: "Phase 1 is scaffolding — we build the lens's static 'skeleton' (assets in the right place, materials assigned) but no scripting or animation yet. Confirms geometry before we add behavior."

**Performance budget**  
Plain: max limits for size and speed — lens ≤ 4 MB, ≥ 25 FPS on mid-range Android. Snap reviews on mid-range phones, not high-end.  
First-use: "Performance budget is our hard limits: lens ≤ 4 MB total size, at least 25 FPS on a mid-range Android. Snap tests on mid-range Android, not top-end iPhone — so we optimize against the lowest tier."

---

### Project documentation / process jargon

**Readiness Report**  
Plain: a summary of all the decisions we made in the intake phase, as a table. You approve row-by-row before we move to Phase 0.  
First-use: "When all intake questions are answered, I summarize a 'Readiness Report' — a table with all the decisions we've made. You go through the rows, say OK or change, then we run Phase 0."

**Watch points**  
Plain: risks or unknowns that may require changes later. We list them so we don't forget between sessions.  
First-use: "Watch points are 'things to keep an eye on' — risks or open questions that aren't urgent now but may bite us later. I list them in PROJECT-STATE.md so we don't forget."

**Spec drafter**  
Plain: ❌ **avoid** — internal jargon. Say "when I write TECH-SPEC and USER-EXPERIENCE for you" instead.  
First-use: [SKIP — don't use this term in conversation]

---

### MCP / system

**MCP** (Model Context Protocol)  
Plain: a communication system that lets me (Claude Code) talk directly to Lens Studio — read the scene and make changes without you having to copy-and-paste.  
First-use: "MCP is the 'bridge' between us — Model Context Protocol. Once it's registered, I can read and edit directly in your Lens Studio scene instead of asking you to click. Like sitting next to you at the computer."

**GraphQL**  
Plain: a query language for structured data — like SQL but for object graphs. Snap uses GraphQL for MCP calls dealing with scene and assets.  
First-use: "GraphQL is the query language Snap's MCP uses. You don't see it — I handle the queries. It just means I can ask for specific parts of the scene without reading the whole thing."

**Asset directory**  
Plain: the folder in your LS project where all assets (models, sounds, textures) live. Auto-syncs with the Asset Browser panel in Lens Studio.  
First-use: "Asset directory is the folder where all assets live — mirrors the Asset Browser panel in Lens Studio. Dropping a GLB in there shows up in Asset Browser immediately."

---

### Workflow

**Probe-first**  
Plain: before we change anything complex, we make an isolated mini-change to verify our hypothesis. No 'big bang' mutations.  
First-use: "Probe-first means: I test a small controlled change first — e.g. just the left shoe — before committing to the whole approach. Safer iteration."

**Pair-test**  
Plain: a test where the agent (via MCP) and the user (via phone or preview) check the same result in parallel. Probe → pair-test → reaction → next probe.  
First-use: "Pair-test is when we both check the result at the same time — me via the MCP read, you via Preview or the phone. You say what you see; I adjust."

**⌘S handshake** (Cmd-S handshake)  
Plain: after every successful probe-pair-test cycle: save the project in LS (⌘S on Mac, Ctrl-S on PC). MCP's changes are otherwise just in RAM and disappear on LS restart.  
First-use: "Before we move on — press ⌘S in Lens Studio. My MCP changes are only in RAM right now, so without a save we lose them if LS restarts."

---

## Anti-patterns

❌ Chains of unexplained terms in one message:  
"Use the MCP scene-graphql endpoint to query the scene hierarchy for a tracker-overwritten anchor."

✅ Translate the WHOLE chain (or break into smaller messages):  
"I'm reading the scene via MCP — that's how I see where the 'foot tracker's anchor point' sits relative to the rest. The tracker overwrites it every frame, so I need a wrapper before I can change position."

❌ Translating a term every time it appears (after first-use it's unlocked):  
[Same explanation 3 messages in a row]

❌ Translating words that aren't really technical:  
"Scene" — the user understands "scene" from everyday language; doesn't need explaining.

---

## When NOT to translate

Some terms have everyday meanings the user already maps to correctly:
- **scene, object, camera, light** — everyday words with technical use. Translation ≠ value here.
- **animation, color, texture** — domain-shared between design and tech.
- **File extensions the user mentions themselves** — if they say "FBX", they know FBX.
- **Verb-based terms** — "save", "import", "export", "drag" — universal.

When in doubt: if a designer with 5 years of Photoshop / Figma experience would understand the term, skip the translation.

---

## Maintenance

When you encounter a new term that's NOT in this list but creates a confusion moment in a session:

1. Add it here with a one-sentence plain definition + first-use example
2. Date the addition
3. If 2+ sessions hit the same untranslated term, promote it to a more prominent category position

When in doubt: err on the side of including the translation.

**Date stamps:**
- 2026-05-13 — initial 19 terms from a previous footwear-brand session
- (future additions logged here)

---

## Cross-references

- `voice-and-pedagogy.md` — principle #1 (Believe in user), Pedagogy layer
- `lens-studio-api-gotchas.md` — terms here are also discussed there empirically (tracker overwrite, mesh pivot, etc.)
- `mcp-tool-schemas.md` — MCP-specific terminology
- `body-anchored-calibration.md` — wrapper anchor, tracker overwrite, AABB in deeper context
- `snap-docs/01-mcp-and-claude-code/developer-mode.md` — Snap's prose description of MCP tools
