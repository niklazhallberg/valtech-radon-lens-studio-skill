# Image-to-3D Generation — Pass 0 for custom 3D content

Load this when the user wants to create a custom 3D model from an image or idea and doesn't have a .glb file yet. Skip this file if the user already has the model file — then go straight into `3d-asset-import-doctrine.md` Pass 1b (post-process) or Pass 2 (Lens Studio import).

This file covers the step *before* `3d-asset-import-doctrine.md`: how to get from an idea or source image to a usable .glb file. Once the .glb exists, this doctrine hands over to Pass 1b.

---

## A. When this file applies

- *The user has an idea or source image but no 3D file* — e.g. "I want a stylized hat that matches the brand's identity" or "can we make a 3D version of this product?".
- *Library-first sourcing didn't land right* — we checked Snapchat Asset Library, Lens Studio Templates, and any import packs first, but nothing matched the user's expectations (aesthetic, brand, specific motif). Then the agent lifts image-to-3D as a fallback path. Remember to still suggest the library check if it hasn't been done yet — pre-optimized Snap assets skip the entire Pass 0–Pass 2 chain.
- *The user is using an image-to-3D service* — fal.ai/Hunyuan3D, Meshy, Tripo, Rodin, Luma Genie, etc.
- *Not relevant if* the user already has a .glb from a DCC tool (Blender, Maya, Cinema 4D) or from the Snapchat Asset Library — then the path is straight into Pass 1b/Pass 2.

**Library-first as default habit:** before the agent suggests image-to-3D, it should have gone through (or at least mentioned) the library alternatives. Image-to-3D isn't wrong — but it's more expensive in time and risk than a finished Snap prefab. Reserve Pass 0 for when the library path genuinely isn't enough.

---

## B. Pipeline overview

`idea → source image → image-to-3D service → .glb file → Pass 1b post-process → Pass 2 Lens Studio import → publish`

This file is responsible for the first three arrows. Once the .glb file exists, we hand over to `3d-asset-import-doctrine.md`.

**Why separate Pass 0 from Pass 1b:** problems that surface early in the pipeline (bad source image → weird mesh → weird textures) can't be fixed downstream. Post-process tools like `optimizeglb.com` compress a good mesh into a smaller file; they don't rescue a mesh that came out wrong from the start. When something in the pipeline is broken, you want to know which part — otherwise you optimize in the wrong place.

---

## C. Image requirements — what makes a good source image

Image-to-3D services "see" a 2D image and guess the 3D shape behind it. The less the service has to guess, the better the output. Every requirement below exists to reduce the amount of guessing.

### Background
Clean, single-color, or transparent — preferably contrasting with the subject (dark background for a light object, light for a dark one).

**Why:** the service segments the object from the background before generating the mesh. Unclear edge → the service includes parts of the background in the mesh, or cuts off parts of the object.

### Angle
Front or 3/4 view. The full object visible, centered in the image, not cropped at the edges.

**Why:** the far side of the object is always a guess based on the front. 3/4 gives the service a bit more depth information than straight front — but *only if* it still shows the most important details clearly. A profile view where half the object is hidden gives worse results than straight front.

### Resolution
At least 1024×1024, preferably 2048×2048. Sharp in focus.

**Why:** the texture that ends up on the mesh is based directly on the source image. Blurry or low-resolution image → blurry texture on the 3D model that can't be rescued in optimization downstream.

### Lighting
Even, soft, neutral. No sharp shadows on the object, no strong highlights.

**Why:** the service doesn't always distinguish between "shadow on the object" and "shape in the object". A sharp shadow under a hat brim can be interpreted as a hole or a protrusion. Soft ambient lighting gives the cleanest mesh.

### The subject alone
No helper objects, no hand holding it, no reflected surfaces in the background.

**Why:** everything visible in the image is a candidate to become mesh. A hand holding a piece of jewelry can result in a hand-shaped protrusion in the 3D output.

### Prompt → image (if the source image is generated with ChatGPT Image / Midjourney)
Write the prompt so the requirements above are met automatically. Useful phrases:
- "studio lighting, soft even illumination, no harsh shadows"
- "isolated on plain [white/black/transparent] background"
- "front view, centered, full object visible"
- "high resolution, sharp focus, product photography style"

Skip phrases that often cause problems: "dramatic lighting", "lifestyle shot", "in use", "held in hand".

**Why this matters:** the prompt is where you have the most control in the entire pipeline. A couple of minutes on a better prompt often saves a full iteration downstream.

---

## D. Service selection — heuristic per object type

| Service | Best for | Weakness | Where it runs |
|--------|----------|---------|--------------|
| **Hunyuan3D (via fal.ai)** | Stylized/cartoony objects, accessories (hat, glasses, prop) | Realistic materials can come out flat | `fal.ai/models/hunyuan3d` |
| **Meshy** | Realistic props, broader motif types | Texture details can come out soft | `meshy.ai` |
| **Tripo** | Fast iterations, lower poly default | Less fine control | `tripo3d.ai` |
| **Rodin** | High-detail sculpts, characters | Slower; larger output | `hyperhuman.deemos.com` |

**These are starting points, not gospel.** The heuristic is built on the empirical data the skill has right now. Expect to update it once you've tried a couple of services on the same motif — and flag new insights so the CHANGELOG can capture them.

**When you're unsure:** try two services on the same source image in parallel. It's cheaper than trying to rescue a bad generation with optimization downstream.

**Why this is heuristic and not rule:** image-to-3D services change quickly (model versions, pricing, capacity). A service that was best for accessories in January can be overtaken six months later. Treat the table as a starting bet, not gospel.

---

## E. Quality checklist before post-process

Before you take the .glb file forward to `optimizeglb.com` (Pass 1b) — check the following directly in the service's preview or via the `optimizeglb.com` dashboard which also shows mesh statistics.

### Poly-count (in order, for an accessory)
- *Under 5k tris:* often too low — risk that the model looks faceted near the camera.
- *5k–50k tris:* normal zone for image-to-3D output. Manageable to compress to accessory budget in Pass 1b.
- *50k–100k tris:* workable, but requires more aggressive mesh reduction in Pass 1b.
- *Over 100k tris:* the service produced rich default output. Still works, but it's a sign to ask the service for lower poly if the option exists.

**Why this is the first check:** poly-count is the easiest thing to measure and quickly tells you whether the mesh is in the right size range for a Snap lens.

### Texture resolution
- *512×512 or 1024×1024:* ideal for an accessory.
- *2048×2048:* OK, will be compressed down in Pass 1b/Pass 2.
- *4096×4096+:* unnecessarily large for Snap; the service is delivering default print quality. Pass 1b fixes it, but it's a sign you can ask the service for lower resolution from the start if the option exists.

**Why texture is also measured here:** textures are often the biggest culprit in lens size. Knowing the size already in Pass 0 lets you adjust the service's settings or pick a different service before optimization even starts.

### Typical artifacts to look for
- *Hanging mesh tabs* — bits of geometry sticking out from the object, often from an unclear edge against the background in the source image.
- *Weird shadows baked into the texture* — if the source image had sharp shadows, they often end up as dark patches in the texture that can't be lifted out later.
- *Smeared surfaces* — low texture detail in areas where the source image was blurry or overexposed.
- *Phantom objects* — geometry that corresponds to something that *wasn't* the main subject (hand, background detail, reflection).
- *Asymmetry that wasn't in the source* — the service guessed wrong on the far side. Common with pure front view without 3/4 information.
- *Holes in the mesh* — missing geometry in areas the service couldn't interpret (typically under hat brims or behind protruding details).

### Proportions
Compare against the source image. The service sometimes rescales the object in unexpected ways, especially in depth (the object becomes shallower or deeper than it "should" be).

---

## F. Regenerate vs optimize further — the decision point

This is the most important question in Pass 0. Once you have a .glb and have gone through the checklist above, there are two paths forward.

**Regenerate (back to source image or service)** — if any of these are true:
- Hanging mesh tabs or phantom objects in the mesh
- Smeared/unreadable textures in visible areas
- Proportions noticeably wrong compared to the source image
- Holes in the mesh where there shouldn't be holes
- Baked-in shadows dominating the texture
- Asymmetry not in the source that's visible from front/side view

→ Adjust the *source image* (cleaner background, softer light, better angle) or *switch service*. Optimization downstream doesn't rescue this.

**Go on to Pass 1b** — if all of these are true:
- The mesh shape is correct, even if poly-count is high
- The texture is readable, even if resolution is large
- No phantom objects or visible holes
- Proportions match the source image

→ The file is ready for `optimizeglb.com` per `3d-asset-import-doctrine.md` Section D Pass 1b.

**Why this decision matters:** optimizing a bad mesh gives you a less bad mesh, not a good mesh. Ten minutes of regeneration is almost always cheaper than an hour of trying to rescue a broken output in Lens Studio. When you hesitate — regenerate.

---

## G. Common pitfalls

- *Reflective material in the source image* — chrome, glass, polished metal confuse the mesh generation. Ask the service for a matte reference, or paint over the reflections in the source image before upload.
- *Thin details disappear* — glasses frames, jewelry, narrow straps. Make them noticeably thicker in the source image than they "should" be; the service loses thin structures.
- *Transparency doesn't work automatically* — alpha effects must be built in Lens Studio as a material setting, not expected from the generation.
- *Animation isn't in the output* — image-to-3D gives a static mesh. If you need animation, you need rigging in a DCC tool or an animation pack from the Snapchat Asset Library.
- *Service prompt vs image prompt* — if the service has a separate text field ("describe the object"), use it. It gives the service a second signal alongside the image.
- *Optimizing first, regenerating later* — wrong order. Optimize only when Pass 0 is green, otherwise you're optimizing on the wrong foundation.

---

## H. Handover to Pass 1b

When the checklist in E is green and the decision in F points to "go on":

→ `3d-asset-import-doctrine.md` Section D Pass 1b — run the .glb file through `optimizeglb.com/dashboard` for mesh and texture compression before Lens Studio import.

Everything downstream (Pass 1b → Pass 2 → publish) is handled by `3d-asset-import-doctrine.md`.
