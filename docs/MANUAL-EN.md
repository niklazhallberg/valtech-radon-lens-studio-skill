# Lens Studio Snapchat Filter — User Manual

> Läs på svenska: [`MANUAL-SV.md`](MANUAL-SV.md)

This guide is for anyone considering using the `lens-studio-snapchat-filter` skill for a client project. Read it **before** you install anything — it'll help you decide whether the tool fits your task and what you actually get out of it.

---

## 1. What is this?

`lens-studio-snapchat-filter` is a **skill** for Claude Code (Anthropic's terminal tool for developers). The skill teaches Claude the full workflow for building Snapchat Lenses — from first brief to submission in Snap Ads Manager. Once it's installed and you start Claude in your project folder, Claude knows:

- What a Snapchat lens project typically contains and how it should be structured
- Which API patterns actually work in Lens Studio (and which fail silently)
- How you, as a designer, work from grand vision to finished submission
- When to ask you for a decision and when to just execute

**What the skill replaces**: manual Lens Studio hand-work across the whole pipeline. Instead of clicking, dragging, and Inspector-tweaking every detail yourself, you describe vision and feel — Claude builds scene, scripts, animations, and technical specifications for you. You make the decisions; Claude removes the friction.

**Who it's for**: digital designers, creative technologists, and account managers at Valtech RADON. You have design skills but maybe not coding experience. You don't need to know terminal, JavaScript, or GraphQL to use the skill — but you do need a baseline understanding of Snapchat lenses as a format (what they do, how people use them, what Snap accepts in ad review).

---

## 2. What can you build?

The skill is honest about what's possible and what isn't. We split capabilities into three tiers.

### Tier 1 — Claude builds it entirely on its own

No external assets required beyond client logo and brand fonts. Claude handles scene, code, animations, submission. Build time: **3–5 days** depending on iteration count.

Examples:
- 2D overlays on the face (color tint, eye texture swap, lip effect)
- Tap-interactions with text or image reveals
- Fortune / quiz / horoscope lenses
- Text-based lenses with custom fonts
- Simple particle effects (rain, glitter, hearts)
- Basic face tracking with image overlays
- Clickable buttons (using the skill's `Button` v1.0.1 primitive)
- Blur effects (frosted glass, depth-of-field feel)
- Sound playback on tap

**Concrete example — a previous sponsored Lens production**: built with the skill in about 5 days. A "tap-to-open-a-package" lens where the user taps a branded package, it opens, and a random short text is revealed with a decelerating callback rhythm (feels like a wheel-of-fortune settling on an answer). Tier 1 from day one to launch. No 3D artist, no ML models, no Snap-internal tech.

### Tier 2 — Claude builds it if you provide the asset

Claude handles all code and scene work. You (or a specialist) deliver one specific asset.

Examples:
- 3D object on the face → requires FBX or glTF from a 3D artist
- ML effect based on the client's own trained model → requires a `.dnn` file from the client
- Licensed character as PNG overlay → client provides the image

Build time: **1–2 weeks**, but the bottleneck is asset delivery, not Claude.

### Tier 3 — Not possible with standard agency production

Some lenses require Snap-internal technology that no agency outside Snap has access to. **More budget doesn't unlock this** — it's a structural boundary, not a cost question.

Examples:
- Full face transformation (think Avatar-Na'vi, Snap × Disney 2022) — required a custom GAN and months of Snap-internal work with Disney's film data
- Snapchat Beauty filters (Snap proprietary, not exposed in the LS SDK)
- Real-time hair segmentation + replacement (Snap-internal ML)
- GAN-based age or gender transformation

If a client brief contains a Tier 3 reference, Claude answers honestly: *"The filter you're describing genuinely can't be produced with standard Lens Studio — not by us, not by any normal agency. [Reference] required specialized AI tools that Snap built internally. What we CAN build instead is: [Tier 1 alternative]. Want to go with that?"*

Tier 3 detection is the skill's most important service in the first client conversation. It protects you from promising something that can't be delivered.

---

## 3. Why use it?

### Time saved

The seed project gives a concrete benchmark: a lens that with manual Lens Studio work would have taken 2–3 weeks, was finished in 5 days with the skill. The time savings come from:

- **Scene hierarchy gets set up once**, not iterated via trial-and-error.
- **Scripts are generated from a spec**, not hand-written with syntax-hunting.
- **Inspector wiring is driven by Claude**, you just adjust magnitudes in Phase 3 polish.
- **Submission checklists are pre-validated** against the Snap Ads Manager flow.

### Responsibility split — what Claude takes, what you keep

You take **vision, approval, and feel decisions**. Claude takes **execution, structure, and technical correctness**. Concretely:

| You do | Claude does |
|---|---|
| Provide brief, vision, INSPIRATION folder | Reads everything and infers concrete design decisions |
| Decide feeling, pace, off-limits | Sets defaults for tween durations, easing, layout |
| Approve specifications before Phase 1 | Writes TECH-SPEC.md and USER-EXPERIENCE.md |
| Say "go" to advance a phase | Builds scene, scripts, animations per phase |
| Adjust feel in Phase 3 via Inspector | Prepares Inspector handoff with the right SceneObject pre-selected |
| Test the lens on your own phone | Prepares everything ahead of device testing |
| Click Submit in Snap Ads Manager | Produces icon (320×320), preview video, metadata |

It's about **division of labor, not automation**. You're still the creative director — Claude is the technical and graphical executor.

### Quality — production-tested, not trial-and-error

The skill is empirically validated from real production builds. When it says "use this tween pattern", it's because the alternatives were tested and failed. When it warns about a silent-drop bug in `setProperty`, it's because the team already lost time on that exact bug. You get a year's worth of LS work condensed into agent form.

---

## 4. Getting started

### Prerequisites

- **macOS, Windows, or Linux** with ~10 GB of free disk space
- **Claude Code** installed (run `curl -fsSL https://claude.ai/install.sh | bash` in your terminal)
- **Lens Studio 5.21+** installed (https://ar.snap.com/download)
- **Admin rights** to install applications

### Three-step install overview

1. **Install the skill** to `~/.claude/skills/`. If you received a `.skill` file, rename the extension to `.zip` and unzip. The result should be `~/.claude/skills/lens-studio-snapchat-filter/SKILL.md` as an existing file.
2. **Create a project folder** for your client project, e.g. `~/Projects/[client]-lens/`.
3. **Register the Lens Studio MCP server** with Claude Code so Claude can drive LS directly.

> **The full step-by-step install instructions** live in [`INSTALL-REFERENCE.md`](INSTALL-REFERENCE.md). That document is built to be followed top-to-bottom — bash commands, verification steps, fallback paths. Use it when you actually install; the manual you're reading now is for understanding what you're signing up for.

### What MCP is (short explanation)

MCP stands for **Model Context Protocol**. It's a technology that lets Claude talk directly to Lens Studio — read the scene graph, add objects, change properties, execute TypeScript code inside the editor. Without MCP, you still get help from Claude — but you have to click and drag in Lens Studio yourself following Claude's instructions. With MCP, Claude makes the changes directly. **The token rotates every time you restart Lens Studio** — it's a recurring operational detail you need to know about (more in section 8).

### What to say to Claude to start

In your terminal, from your project folder:

```
claude
```

Then, in your first message to Claude:

> *"I want to build a Snapchat lens for [client]. Here's the brief: [paste 1–2 paragraphs]."*

Claude takes it from there — activates concierge mode, reads your environment, asks for INSPIRATION images, and starts the onboarding intake. You don't need to say "use the skill" — Claude detects that from the subject keywords in your message.

---

## 5. How Claude works with you

### Concierge mode

When you start Claude in an empty project folder and say "I want to build a lens", **concierge mode** activates. It's a structured conversation that takes you from zero to "ready to build". Concierge mode is designed to be **calm and clear**, not overwhelming:

- **One action per message**. Claude asks you to do one thing, waits for "done"/"klar", moves on. No lists of "do A, B, and C then say done".
- **Plain language**, no jargon. "Drop 3–5 images that capture the vibe" instead of "curate INSPIRATION/ with categorized subfolders".
- **Adaptive troubleshooting**. If something fails, just say so — Claude switches to debug mode until it works.

### Environment detection (what Claude checks first)

Before Claude starts asking you questions, it checks what you already have in place:

- Is Claude Code installed? (You're talking to it, so yes.)
- Is Lens Studio installed? Which version?
- Does a project folder already exist, or do we need to create one?
- Is there an `.esproj` project already?
- Is the MCP server registered and connected?

You get a **readiness report** (✅/❌ per item) before anything else happens. If something's missing, Claude walks you through the 8-step guide in `INSTALL-REFERENCE.md` (but live, with you following along).

### The setup conversation — one step at a time

The setup flow is 8 steps. You complete each step, say "done" or "klar", and Claude moves on. Typical steps are dropping the client brief in as a text file, populating the INSPIRATION folder, setting up git, registering MCP. Total time: ~25–30 min for a first setup.

### The onboarding intake — 8 questions in 3 groups

When setup is done, Claude moves into the **onboarding intake**: 8 questions split into 3 logical groups. The whole conversation takes ~7 minutes. The 3-group structure is INTERNAL pacing for Claude; from your perspective, it just feels like a natural conversation.

**Group 1 — Vision (3 questions)**: about what the lens is and what the user experiences.
- *"Describe the lens in 1–2 sentences. What's the moment for the user?"*
- *"Primary feeling? One word: playful / mysterious / energetic / calm / surreal / nostalgic / cinematic / chaotic?"*
- *"Pace: snappy / medium / slow-cinematic?"*

**Group 2 — Constraints (3 questions)**: about client, category, and deadline.
- *"Client + ad-policy category?"* (e.g., a music-streaming brand in the 'general' category, or a sexual-wellness organisation in the 'regulated' category)
- *"Anything off-limits?"* (e.g., "no face liquify", "selfie camera only")
- *"Deadline?"* (drives how many polish iterations are achievable)

**Group 3 — Asset validation (2 questions)**: Claude reads the INSPIRATION folder and proposes what it sees.
- *"INSPIRATION folder has 5 images. I see dark tones, neon accents, minimalist composition. Match your vision, or am I reading the wrong signals?"*
- *"Anything in `brand-assets/` I should know about? Logos, brand colors, locked fonts?"*

**Why this structure?** The questions are designed so designers don't need to know technical specifications. You say "cinematic" — Claude sets tween durations to 0.8–1.5s, soft easings. You say "snappy" — Claude sets 0.2–0.4s, sharp easings. You never need to say "0.4 seconds with a cubic easing curve". Decisions get made at the right abstraction level.

### The Readiness Report

After the onboarding intake, Claude shows a **Readiness Report** as a table — one row per decision, with a check mark or edit mark next to each. You can scan and find ONE wrong row in 10 seconds without reading prose:

```markdown
| Decision | Value | |
|---|---|---|
| Vision | [your vision sentence] | ✔ |
| Feeling | calm | ✔ |
| Pace | slow-cinematic | ✔ |
| Color palette | #1e5d8c, #3a9ab8, #e89880 | ✔/✏️ |
| Tween defaults | 0.8–1.2s, ease-in-out | ✔/✏️ |
...
```

You either reply **"go phase 0"** (everything looks right, start building) or **"ändra [row]: [new value]"** (one specific row needs adjusting). Claude updates and shows the table again until you say "go".

### Feature intent detection — Claude reads your meaning

Claude understands you describe what you **want**, not what the API is called. If you say:

- "clickable thing" → Claude interprets that as `Button` v1.0.1
- "blurry background" → `GaussianBlurPreset`
- "spin and reveal text" → decelerating callback-chain pattern
- "play a sound when they tap" → `AudioComponent`

Before Claude installs or writes code, it confirms:

> *"I read that as wanting a clickable button. I can add `Button` v1.0.1 as the primitive — you get a button with animation (Bounce/Squish/Transform), customizable per-state colors, and a tap event that triggers your handler. Right read, or did you mean something else?"*

You say "yes" or describe differently. Nothing installs before you confirm.

---

## 6. Phase-by-phase: how Claude builds the lens

The skill divides the build into nine sequential phases (some optional). You don't need to memorize them — Claude guides you through each. Here's what happens in each phase, what you do, and what you see.

### Phase 0 — Spec drafts (30–60 min)

**Claude does**: writes `docs/TECH-SPEC.md` (scene hierarchy, scripts, performance targets) and `docs/USER-EXPERIENCE.md` (second-by-second user journey). Draws inferences from brief + INSPIRATION + onboarding answers.

**You do**: read and approve (or ask for changes to specific rows). No code runs until you say "go phase 1".

**You see**: two markdown files in the `docs/` folder.

### Phase B — Capability tests (optional, 30 min–1 h)

**Claude does**: empirically tests that the specific API surfaces the lens will use actually work. Skipped if all surfaces are already documented in the skill's gotchas file.

**You do**: typically nothing — Claude runs the tests and reports.

**You see**: a short summary like "All 5 API patterns validated. Proceeding to Phase 1."

### Phase 1 — Static scaffolding (2–3 h)

**Claude does**: builds the scene hierarchy, places all anchors, imports textures, sets the "closed state" (the lens before the user interacts with it). No animation, no scripts — just static structure.

**You do**: look in the LS Preview panel when Claude says "Phase 1 done". You should see the first visual element in the right place with the right texture.

**You see**: an image in Preview that matches your vision for "before the user taps".

### Phase 1.5 — Production copy + fonts (~30 min)

**Claude does**: swaps placeholder text for your production copy, imports custom fonts if any.

**You do**: deliver final copy if you haven't yet, confirm fonts.

**You see**: correct copy + correct typography in Preview.

### Phase 2 — Scripts + animation logic (2–3 h)

**Claude does**: writes TypeScript scripts that drive interaction and animations. Wires `@input` fields in the Inspector via MCP. Sets up tap handlers, tween chains, the state machine.

**You do**: approve UX principles before Phase 2 starts (the skill requires this — 3–5 principles like "no breaking of touch-feedback-loop", "always show progress", etc.) and say "go phase 2".

**You see**: in Preview, you can click the lens and see the tap-to-final-state cycle work. It's not polished yet — just the full flow running end-to-end.

**Concrete example from the seed project**: for a tap-to-open-a-package lens, Phase 2 was where the package-open animation got hooked into tap, the text-roll callback with growing intervals was implemented, and the reroll mechanic was set up.

### Phase 2.5 — Advanced features (optional, 1–2 h)

**Claude does**: face effects, ML-based features, audio — if the brief requires them. Skipped otherwise.

**You do**: test that advanced features don't break the core loop.

**You see**: face effect or other advanced feature active in Preview, toggling correctly.

### Phase 3 — Polish iterations (variable)

**Claude does**: adjusts magnitudes, tween durations, colors, easings — based on what you say feels off. Phase 3 is where feel-finetuning happens.

**You do**: look in Preview, point at ONE thing that feels off, say it. Claude adjusts.

**You see**: live feedback in Preview as you tune Inspector sliders (the skill explicitly does this — it hands magnitude tuning off to the live Inspector instead of MCP, because Inspector gives 60fps preview).

### Phase 4 — Device testing (1–2 h)

**Claude does**: prepares the export, gives you instructions for testing on a real phone.

**You do**: run the lens on an iPhone + a mid-range Android. **This is manual — Claude cannot connect to your phone.** You report FPS, any visual glitches, lens size.

**You see**: the lens on two real devices. Target: ≥25 FPS on Android, lens ≤4 MB.

### Phase 5 — Submission (1 h)

**Claude does**: produces the icon (320×320 PNG, simplified graphic — not a photo), preview video (via LS Preview recording), submission metadata.

**You do**: go into Snap Ads Manager, click Submit, pick the ad account.

**You see**: a submitted lens waiting for Snap review.

---

## 7. What you do — what Claude does

Summary responsibility matrix:

| **You (creative director)** | **Claude (technical + graphical executor)** |
|---|---|
| Vision and feel | Scene hierarchy, code, animations |
| Brief, INSPIRATION images, brand assets | Inference of design decisions from what you provide |
| Approval of each phase before the next starts | Spec drafts, scripts, mutations, error recovery |
| "go" commands to advance | Submission prep (icon, preview, metadata) |
| Feel adjustments via Inspector in Phase 3 | MCP orchestration, ⌘S handshakes, git work |
| Device testing on a real phone | Everything that happens in Lens Studio and code |
| Submit click in Snap Ads Manager | Everything up to the Submit button |

**What Claude does NOT do**: make creative decisions for you, approve its own output, click Submit, test on your phone, contact the client, manage Snap Ad Account permissions.

---

## 8. Honest limits — where the line is

The skill is honest about what it doesn't do. The most important ones:

### Easy Lens panel features (LS 5.21+)

Lens Studio 5.21 introduced an "Easy Lens" panel — an AI-driven creator UI inside Lens Studio where designers generate lenses visually. **Claude CANNOT drive the Easy Lens panel.** It manipulates the underlying primitive components directly.

Concretely:
- "Easy Lens Button" in the changelog → Claude uses `Button` v1.0.1 CustomComponent (same underlying thing, but scriptable)
- "Easy Lens Blur" → Claude uses `GaussianBlurPreset` (native scene preset)
- Designer-driven visual tuning in the Easy Lens panel UI is **hands-off** for Claude

If a client asks for "Easy Lens look", Claude delivers the function via primitives + hands visual finetuning off to you in the LS panel UI.

### Tier 3 features

As described in section 2: some lenses require Snap-internal technology. No budget unlocks it. When Claude detects Tier 3 in a brief, it says so directly — and always proposes a Tier 1 alternative. This is **not pessimism — it's honesty discipline**. You save the client a long road toward an impossible delivery.

### MCP token rotates daily

Every time you restart Lens Studio, the MCP server gets a new Bearer token. Your existing registration uses the old one and stops working. The fix is a ~3-minute reconnect routine that Claude walks you through if you say "MCP isn't working". Nothing serious — just an operational ritual you need to know.

### Device testing is manual

Claude can't connect to your phone. Phase 4 is where you take out two real devices (iPhone + mid-range Android, **not just iPhone**) and test the lens. It's non-negotiable — Snap reviews lenses on mid-range Android, and desktop Preview is **misleadingly optimistic** about performance.

### Snap review SLA

After you click Submit:
- **General categories** (music, lifestyle, sport, gaming) → 1–3 business days review
- **Regulated categories** (Sexual Wellness, Alcohol, Gambling, Pharmaceutical) → 1–2 weeks review
- **Rejections that need resubmission** → add another 1–2 weeks

Plan campaign timing accordingly. The skill flags regulated category during onboarding (question 2.1).

### What the skill is NOT made for

- **TikTok Effect House** projects (entirely different platform, different APIs)
- **Meta Spark / Instagram filters** (different platform)
- **Unity / Unreal AR** (different tech stack)
- **Apple Vision Pro / Quest / HoloLens** (XR, not mobile AR)
- **Spectacles AR Object** projects (Snap, but different toolset)

If the client wants a lens for a different platform, Claude says so directly and points you elsewhere. The skill doesn't activate for the wrong platform.

---

## 9. Tips for the best results

### The INSPIRATION folder — at least 5 images

The single biggest lever for quality is **what you put in the INSPIRATION folder**. Claude reads the images and extracts color palette, motion feel, composition choices, mood. Empty INSPIRATION folder = Claude guesses more; rich INSPIRATION folder = Claude lands it on the first iteration.

Add at least 5 images. More is better. Subfolders are allowed but not required — Claude sorts retroactively if you deliver flat.

Example from the seed project: the INSPIRATION folder held references from fortune cookies, retro slot machines, neon signs, and magic 8-balls. Claude inferred "playful + randomness + nostalgic playfulness" — and it was right.

### Be specific about feel, not specs

❌ "100ms tweens with cubic easing"
✅ "Energetic, snappy, should feel like something is *happening*"

❌ "Color code #1e5d8c as primary"
✅ "Calm deep blue, like the ocean at dusk" (Claude extracts exact hex from INSPIRATION)

Designers should be able to talk about feel without knowing exact values. Claude converts feel into specs.

### One brief = one lens

Resist scope expansion mid-project. The skill flags scope creep proactively:

> *"The new idea you mentioned (audio-reactive particle) isn't in the original brief. Should we (a) add it as a v1 feature and push the deadline, (b) park as v2 candidate, or (c) add it and skip Phase 3 polish?"*

You decide; Claude follows.

### The "go" and "ändra X" pattern

Two commands you'll use all the time:

- **"go [phase X]"** or just **"go"** → advance to next phase / approve current output / start the next step
- **"ändra [row]: [new value]"** or **"change X"** → adjust one specific thing

Try to be specific. "Change the color" is open — Claude has to ask which. "Change primary color: a slightly warmer deep blue" is actionable.

### If Claude proposes something you don't like

Say it directly. *"That tween duration feels rushed."* or *"The blue is too dark."* Claude adjusts and shows again. It's iteration — no "you broke it" or "skip this", just *"this way instead"*.

---

## 10. FAQ

**Do I need to know how to code?**
No. The skill is designed for designers without coding experience. You need to be able to write text to Claude and read markdown files. That's it.

**Do I need to know Lens Studio?**
Not to start. Phase 1 requires you to look in the Preview panel, which is intuitive. Phase 3 you'll benefit from knowing Inspector sliders (Claude selects the right SceneObject for you so you know what you're adjusting). Phase 5 requires you to click in Snap Ads Manager. Nothing more.

If you want to deepen your LS knowledge later, that's great — but it's not a prerequisite.

**What if Claude does something wrong?**
Just say so: *"That came out wrong, [describe]."* Claude has an error recovery routine that backtracks, identifies root cause, and fixes. If something really breaks, there are rollback mechanisms — git history, scaffold checkpoint, ability to return to earlier scene state.

**Can I use this for Community Lenses (non-sponsored)?**
Yes. Build phases 0–4 are identical. Phase 5 (submission) differs — Community Lenses submit via My Lenses in the LS app, not via Snap Ads Manager. The skill primarily covers the Sponsored Lens flow, but the technical pipeline is the same.

**How do I update the skill when a new version comes out?**
Two ways:
- If you cloned from git: `cd ~/.claude/skills/lens-studio-snapchat-filter && git pull`
- If you got a `.skill` file: change extension to `.zip`, unzip over the existing folder

Niklaz at Valtech RADON maintains the skill. New versions ship when learnings from new projects have been empirically validated.

**What if Lens Studio updates and something breaks?**
The skill is pinned to LS 5.20+ but tested against the latest version. If an LS update breaks a pattern, it's caught in the next skill release. Between releases: tell Claude *"LS updated to X.Y.Z and now [Z] doesn't work"* — Claude probes empirically and reports.

**What do I do if the client wants something that's genuinely Tier 3?**
Be honest: *"That filter requires Snap-internal technology no agency has access to. We can't build it. Here's what we CAN build that captures the same campaign spirit: [Tier 1 proposal]."* That's the same language template Claude uses internally — use it with the client. Trustworthy and clear.

**Is data private? Does anything end up at Anthropic / Snap?**
Claude Code sends the conversation to Anthropic's model for processing, per their normal product terms. The Lens Studio MCP runs locally on your machine — no lens data or scene data is sent to Snap beyond what happens when you click Submit yourself. INSPIRATION images are read locally by Claude.

**What does it cost?**
The skill itself is free (distributed internally at Valtech). You pay for Claude Code (Anthropic subscription) and Lens Studio (free from Snap). No other licenses.

---

## 11. Technical background (for the curious)

### What is Claude Code?

Claude Code is Anthropic's terminal tool for developers. It's the same Claude model that powers claude.ai, but it runs in your terminal and can read files, write files, run commands, and interact with other tools via MCP. Skills like `lens-studio-snapchat-filter` are packaged knowledge bases that teach Claude specific workflows.

### What is MCP and why does it matter?

MCP (Model Context Protocol) is an open standard that lets AI models talk to external tools. For Lens Studio, it means Claude can:

- Read the scene graph's current state
- Add, remove, move SceneObjects
- Change component properties
- Execute TypeScript code inside the LS editor
- Request screenshots from the Preview panel
- Search the LS Asset Library

Without MCP, you still get instructions — but you have to click and drag in LS yourself following Claude's guidance. With MCP, Claude makes the changes directly, and you verify in Preview.

### How was this skill built?

The skill grew during production of a Valtech RADON Sponsored Lens build in the first half of 2026. Every time an LS pattern failed and the right solution was found, it got documented in a project-internal gotchas file. Every time a phase protocol needed adjustment, the phase-progression template was updated. When the project was complete, all generalizable knowledge was extracted from the project folder — following the Generalization rule to strip client, campaign and project-specific detail — and packaged as this skill.

Specific 5.21 features (Text3D Animator, Easy Lens Button, etc.) were validated empirically via Phase B capability tests and documented in the skill's `references/lens-studio-api-gotchas.md`. The skill is **not speculative** — every pattern in it has been tested in production.

### How do I contribute back when I learn something new?

If during a project you discover:
- A new LS API gotcha that isn't in the skill
- A UX pattern that worked well and others should be able to reuse
- A process learning that would help the next team

… ping the skill maintainer. The threshold for getting it merged into the skill is: **does this learning help on other client projects too?** If yes → migrates into the skill via a pull request (after the Generalization rule strips project-specific detail). If only project-specific → stays in the project's own docs.

That filter keeps the skill high-quality without bloating it.

---

## See also

- **When you actually want to install**: [`INSTALL-REFERENCE.md`](INSTALL-REFERENCE.md) — full step-by-step instructions with bash commands and verification checkpoints
- **When something doesn't work after install**: [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) — detailed debug guide with root causes and fix recipes
- **Swedish version of this manual**: [`MANUAL-SV.md`](MANUAL-SV.md)
- **The skill's internal knowledge base** (Claude reads these — you normally won't need to): the `references/` folder in the skill's root

---

*Last updated: 2026-05-12 against skill version 0.4.3+. Questions or feedback: ping Niklaz at Valtech RADON.*
