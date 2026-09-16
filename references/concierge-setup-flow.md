# Concierge setup flow

The play-by-play conversation script CC follows after concierge mode activates. This file is CC's internal playbook — never quote filenames or this content directly to Anna.

## Contents
- Activation prerequisites
- The setup sequence (Steps 1-8)
- Pacing rules
- Resume-from-partial flow
- Decline patterns ("I'll do it myself")

## Activation prerequisites

Before starting the setup sequence, ensure ALL of these hold:

1. **Trigger matched**: domain keyword + action intent (see `SKILL.md` — concierge entry-point triggers)
2. **Platform confirmation received**: CC asked "I'll help you build a Snapchat Lens Studio project. Is that what you're working on?" and Anna said yes
3. **Environment detection complete**: readiness report surfaced to Anna (see `environment-detection.md`)
4. **Anna agreed to start**: she answered "yes" / "ready" / "go" to the readiness report's closing question

If any prerequisite is missing, do not start step 1 — handle the missing piece first.

## The setup sequence

Eight steps. One step per CC message. Wait for explicit confirmation before advancing. Never bundle.

### Step 1: Confirm or install Lens Studio

**If LS already installed** (detection 1 = YES): skip to step 2.

**If LS missing**:

> CC: "Step 1: Download Lens Studio 5.20+ from https://ar.snap.com/download. It takes 5–10 minutes to install. Say 'done' when it's finished."

Wait for: "done" / "klar" / "installed" / "ja".

If Anna reports a problem: use `troubleshooting-decision-tree.md` — section "LS won't open".

### Step 2: Open LS and confirm

> CC: "Good. Open Lens Studio now. You'll see a welcome screen. Click 'New Project' to get an empty scene. Say 'open' when you see it."

Wait for: "open" / "öppnad" / "ready".

Don't ask Anna to do a project-save yet — that comes after we know the project folder name.

### Step 3: Capture client + ad-policy category, create project folder

Ask one question that captures both client identity AND ad-policy category in a single turn (previously the category was re-asked in intake Q4 — now merged here to eliminate redundancy):

> CC: "What's the client called and which ad-policy category applies? E.g. a sportswear brand in the 'general' category, or a sexual-wellness organisation in the 'regulated' category. I'll create the project folder and flag any policy restrictions directly (general = 1–3 days of review at Snap, regulated = 1–2 weeks)."

Wait for the user's answer (a client name + a category tag).

Parse client-name + category. Save category to `PROJECT-STATE.md` under `ad_policy_category` so it propagates to Phase 5 submission prep without re-asking.

Then create the folder structure:

```bash
mkdir -p ~/Projects/[name-slug]-lens/{project-info,INSPIRATION/{visual-style,motion-references,color-palette-refs,ui-references},brand-assets,lens,docs}
cd ~/Projects/[name-slug]-lens
```

Slug: lowercase, kebab-case (`spotify` → `spotify`, `H&M Sverige` → `hm-sverige`).

Surface the result:

> CC: "Created `~/Projects/spotify-lens/` with sub-folders for project-info, INSPIRATION, brand-assets, lens, docs. Now save the LS project there:
>
> In LS: File → Save As → navigate to `~/Projects/spotify-lens/lens/` → save the project as e.g. `SpotifyLens.esproj`. Say 'saved' when you're done."

Wait for: "saved" / "sparat".

### Step 4: Register MCP

Two-part instruction (one message, but two clear paste actions):

> CC: "Step 4 — we connect LS to me so I can make changes directly in the scene.
>
> In the LS menu: **AI Assistant → AI Model Context Protocol (MCP) → Configure Server**. You'll see a URL (something like http://localhost:50040/mcp) and a Bearer token (a long random string).
>
> Paste **both the URL and the token** here in chat."

Wait for Anna to paste. Parse the URL and token from her message.

CC runs:

```bash
claude mcp add --transport http --scope local lens-studio [URL] --header "Authorization: Bearer [TOKEN]"
claude mcp list
```

If `✓ Connected`: continue. If `✗ Failed`: use `troubleshooting-decision-tree.md` — section "MCP not connecting".

> CC: "✅ MCP connected. LS is talking to me now."

### Step 5: Create PROJECT-STATE.md

Single CC action, no Anna involvement except confirmation. Copy template:

```bash
cp ~/.claude/skills/lens-studio-snapchat-filter/assets/project-template/PROJECT-STATE.md ./PROJECT-STATE.md
cp ~/.claude/skills/lens-studio-snapchat-filter/assets/project-template/.gitignore ./.gitignore
```

> CC: "Setup done. I created `PROJECT-STATE.md` which we fill in together as we go through the brief. And a `.gitignore` so we don't commit LS's cache."

No wait — proceed directly to step 6.

### Step 6: Capture client brief + lens mechanics

One question that captures the lens VISION + three mechanical choices in a single structured turn. The user-facing options are plain language; the internal mapping (in the comment block below) is for CC's reference only:

> CC: "Describe the lens in one sentence — then pick one row per category:
>
> **1. What should happen visually?**
> - The face/body changes (filter, mask, transformation)
> - Something is overlaid on the image (logos, text, UI flying in)
> - The user tries on products (clothes, glasses, jewelry, shoes)
> - The environment around changes (weather, atmosphere, neon overlay)
>
> **2. What starts the effect?**
> - Smile, blink, or open mouth
> - Tap on the screen
> - Always on from start
> - Product recognition (logo or object visible)
>
> **3. How does the effect end?**
> - One big payoff and then stays (one-shot)
> - Repeats as long as the lens is open (loop)
> - Multiple outcomes the user can trigger (game-loop)
>
> E.g.: 'Spotify pod campaign — the face changes, smile triggers, one payoff then stays.'"

<!--
INTERNAL MAPPING (CC use only — never surface to user):
- Visual → lens-type: transformation / overlay / try-on / world-lens
- Trigger → trigger: expression / tap / always-on / product-recognition
- End → end-state: one-shot-payoff / loop / game-loop

These three fields are saved to PROJECT-STATE.md and feed Phase 0 specs +
Readiness Report directly. Do NOT re-ask in intake — anti-pattern.
-->

Wait for Anna's brief. Save the one-line vision to `project-info/client-brief.md` and the three mechanical choices to `PROJECT-STATE.md` (fields: `lens_type`, `trigger`, `end_state`).

**Silent tier detection.** After receiving the brief, CC silently analyzes it against the capability-tier framework (see `references/capability-tiers.md`). The tier check is invisible to Anna — never mention "tiers" or present them as a menu.

- **Tier 1 or Tier 2 detected** → proceed to Step 7 as normal. No mention of tiers.
- **Tier 3 detected** (custom GAN, Snap-internal ML, realistic face/skin/hair replacement, GAN-based age/gender swap, "Snapchat Beauty filter" equivalent) → CC responds honestly using the language template:

  > CC: "The filter you describe actually can't be produced with standard Lens Studio — not for us, not for any normal agency.
  >
  > [Explain WHY in plain language — no jargon. 1–2 sentences. Example: 'The Avatar Na'vi filter required specialized AI tools that Snap built internally together with Disney, with access to film data that doesn't exist outside Snap.']
  >
  > What we CAN build is:
  >
  > [Concrete Tier 1 version that captures campaign spirit — e.g., 'Blue face tint + yellow eye textures + Na'vi-skin overlay + Avatar logo lockup. 1–2 days of build.']
  >
  > Want us to move forward with that?"

  Key rules: never say "with more budget", never say "we could try", always propose a concrete Tier 1 alternative immediately, use plain language. Full language templates + detection signals + scope-down patterns in `references/capability-tiers.md`.

  If Anna accepts the Tier 1 alternative → save the SCOPED brief (not the original) to `project-info/client-brief.md` and continue to Step 7.

  If Anna declines / wants to negotiate budget / claims "another agency could do it" → use the troubleshooting decision tree (see `references/troubleshooting-decision-tree.md` for the "client pushes back on Tier 3 refusal" pattern).

### Step 7: Inspiration folder coaching

This is the **non-expert coaching moment** — don't jargon her into the sub-folder taxonomy, and don't assume she knows what "inspiration" means in this context. Spell it out + show the value-exchange.

> CC: "Now I need inspiration images. By 'inspiration' I don't mean mockups or finished designs of the lens — these are references that show me the *feel* you want the lens to have. Things like:
>
> - **Screenshots** from other AR filters you like (Snap, TikTok, Insta — whatever)
> - **Photos** that capture the mood — Pinterest images, campaign imagery, Instagram finds, streetstyle, product shots
> - **Color references** — palettes, gradients, an image with the 'right' color feel
> - **Motion clips** — if you've seen an animation/transition you like, drop a screenshot or link
> - **Logos / brand elements** from the client (if any exist)
>
> What it does NOT need to be: mockups, wireframes, or finished lens designs. Raw material is enough.
>
> **Value-exchange — what I do with them:**
> - **3 images**: I get a rough tonality (dark/light, warm/cool, calm/energetic) and propose a starting palette — you approve or adjust later.
> - **6–8 images**: I can draw conclusions about motion feel (soft vs fast), composition type (centered vs dramatic), and typographic feel — fewer questions to you later.
> - **10+ images**: I have much more material to cross-reference; the risk of 'wrong tonality' surprises in Phase 1 becomes nearly zero. Worth it if you have the material already.
>
> **3–5 images is enough to start**. Drop them in `~/Projects/spotify-lens/INSPIRATION/` (the same folder we just created — sub-folders are optional, just toss them in the main folder if you don't want to sort). Say 'done' when you have at least 3 in there."

Wait for: "done" / "klar".

Then validate:

```bash
ls ~/Projects/spotify-lens/INSPIRATION/visual-style/ ~/Projects/spotify-lens/INSPIRATION/ 2>/dev/null
```

If fewer than 3 images: ask for more. If 3+: continue.

(Skip the sub-folder taxonomy unless Anna asks. CC can sort images into sub-folders later if helpful, but don't burden her with it upfront.)

### Step 8: Handoff to onboarding intake

Move from concierge mode to onboarding-protocol.md. The structure is announced to Anna so she has a map.

**Update — 4Q / 2-block intake** (down from 8Q / 3-block): vision + lens mechanics are now captured in Step 6, client + ad-policy in Step 3, so intake focuses purely on edges (off-limits, audio) and asset signals (INSPIRATION-confirmation + similar-lens reference, brand-assets).

Open with the structure-announcement, then immediately go into Q1:

> CC: "Good — now we move from setup to the actual brief. I'll ask **4 questions in two blocks** — mechanic, assets — it takes 2–3 min. The sharper you answer, the more I can infer on my own later instead of asking about small things. Type 'skip' if a question doesn't feel relevant.
>
> **Block 1 of 2 — Mechanic.**
> Question 1: Anything explicitly off-limits? Examples: 'no face liquify' (brand prefers ungimmicked face), 'no 18+ gating even though the category allows it' (campaign decision), 'must be selfie-only' (no rear camera).
>
> (Type 'skip' if you want to skip it.)"

Deliberate elements (full breakdown in `onboarding-protocol.md` § "The opening"):
- "4 questions in two blocks" — roadmap. Anna now has a map.
- "2–3 min" — honest time-commitment.
- "The sharper you answer..." — value-exchange (`voice-and-pedagogy.md` #7).
- "Type 'skip'" — agency (#6).
- "Block 1 of 2 — Mechanic" — first progress signal. Sets the pattern for the remaining block.
- Immediate first question — no further preamble. Headline first.

This transitions CC from concierge mode into the announced 4-question intake. Full intake protocol (block progress between Qs, value-exchange per Q, plain-language Readiness Report) lives in `onboarding-protocol.md`.

After intake completes and the Readiness Report is approved, CC enters Phase 0.

## Pacing rules

- One user action per CC message
- Wait for an explicit confirmation signal (typed value, "done", "saved", "klar", file paste, etc.)
- Never say "do steps 1–3 then say done" — always serialize
- Acknowledge each completion briefly ("✅ done" or similar) before moving to the next step
- If Anna seems lost: pause, ask "where are you getting stuck?", troubleshoot 1–2 fixes, escalate if needed

## Resume-from-partial flow

If Anna abandons setup mid-flow and comes back later (new session, same project):

1. Re-run environment detection
2. Compare with expected post-step state — which steps are done?
3. Surface to Anna: "We were in the middle of setup. ✅ LS installed, ✅ project folder created, ❌ MCP not configured yet. Should we continue from MCP?"
4. Wait for "yes" / "continue"
5. Resume at the first incomplete step

If `PROJECT-STATE.md` exists: read it to confirm the resume point. If `PROJECT-STATE.md` shows the phase is past setup (Phase 1+), skip concierge entirely.

## Decline patterns — "I'll do it myself"

If Anna explicitly opts out of guidance:

- "Just give me the install steps"
- "Isn't there a manual I can read?"
- "Show me everything upfront, I'll figure it out"

Respond:

> CC: "Sure. Complete self-service guide: `docs/INSTALL-REFERENCE.md` (in the skill folder). It covers LS installation, MCP registration, project folder structure, and INSPIRATION coaching.
>
> If you get stuck somewhere, come back here and say 'help at step X' and I'll jump in interactively."

Do NOT continue the stepped sequence after a decline. Anna chose self-service; respect it.

If she returns later mid-task ("the MCP token isn't working"), enter the troubleshooting decision tree directly — don't restart concierge from step 1.
