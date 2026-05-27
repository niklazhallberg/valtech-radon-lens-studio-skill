# Asset sourcing boundary — what the agent fetches vs what the colleague provides

A clear boundary worth setting **at brief intake**, so colleagues don't expect the agent to magic up assets it can't legitimately source.

---

## The colleague provides (agent CANNOT fetch or generate)

- **Brand-specific assets** — client's logo (PNG/SVG), brand 3D models (e.g. a Coca-Cola bottle), brand-owned characters / mascots, brand-licensed fonts (`.ttf` / `.otf`), brand-owned imagery
- **Licensed music / audio** from outside Snap's library — the client's master jingle, a specific commercial track they've licensed separately, voice-over recordings
- **Custom-painted artwork** — face-paint textures designed by the client's creative team, branded face masks, custom illustrations
- **Specific photo / video references** — moodboard images, reference photos of a specific person, brand campaign visuals
- **Confidential / NDA-protected** assets — anything the client hasn't released publicly

These land in the project's `assets/` folder, dropped in by the colleague (drag-and-drop into Lens Studio Asset Browser or git-tracked in the project repo). The agent references them by path, never fetches.

---

## The agent CAN source / propose (from Snap-provided libraries)

- **Asset Library items** — pre-built components, materials, particles, 3D meshes, audio templates (see `references/asset-library-guide.md` for the 16 categories)
- **Snap Music Library** tracks (Licensed Music via Asset Library → Music section — Snap-licensed, in-platform OK; see `references/audio-in-lenses.md`)
- **Snap's built-in templates** — recipes from `references/lens-recipe-catalog.md`, all underlying Snap-provided face/body/world/audio building blocks
- **Generic geometry + materials** — built-in Face Mesh / Head Mesh, GPU Particles Effects Pack presets, Snap Shader Graphs, Custom Components from Asset Library
- **Snap-bundled audio** — SFX libraries, beat-synced tracks with pre-analysed beat data
- **Open-source Snap-published templates** — anything in `references/snap-docs/` mirror

---

## How to surface this at brief intake

At brief intake, the agent surfaces the boundary in plain mentor language — not as a list of "what I can / cannot do", but as a natural collaborative question:

> *"Innan vi sätter igång — har ni en logotyp och eventuella 3D-modeller eller egna ljud redan? I så fall lägger ni dem i projektmappen. Allt annat — generiska partiklar, ansiktsmesh, standardanimationer — fixar jag från Snaps egna bibliotek."*

(English equivalent: "Before we start — do you already have a logo and any 3D models or custom audio? If so, drop them in the project folder. Everything else — generic particles, face mesh, standard animations — I'll pull from Snap's own libraries.")

---

## When the brief assumes assets that aren't provided

If the colleague says "we want a Nike-themed lens" but hasn't provided Nike assets — the agent flags at Phase 0 that this requires either:

- **(a)** Nike's IP licensing chain + asset delivery, OR
- **(b)** re-scoping to a Nike-inspired but original aesthetic

Don't quietly proceed and produce something with copyright risk. See `references/sponsored-lens-submission.md` → third-party IP rule.

---

## Generative AI for assets — what's possible

For 3D objects the colleague doesn't have a model for, generative-image-to-3D pipelines are an option — see `references/image-to-3d-generation.md` for service-selection heuristic (Meshy/Tripo/Hunyuan3D/Rodin), image requirements, prompt tips, and decision points. This is a paid external service, not free; surface the cost at Phase 0 if the brief requires it.
