# `valtech-radon-lens-studio-skill` — overview

> 📌 Last reviewed 2026-05-19. The skill evolves continuously — see [CHANGELOG.md](CHANGELOG.md) for the current state and latest accepted discoveries.

Maintained within Valtech RADON.

This document is a standalone overview of the skill — what it is, how it's used, how it grows, how it handles security, and what business value it represents. Written to be readable by a designer, team lead, tech lead, or decision-maker — all get relevant information.

---

## 1. What is this — Executive Summary

`valtech-radon-lens-studio-skill` is an AI-assisted working method that lets a designer at Valtech RADON — without prior Snapchat experience — build a production-ready Sponsored Lens filter for a client in days instead of weeks.

Technically: a "skill" that plugs into Claude Code (Anthropic's developer tool) and turns the AI from a general assistant into a **specialized mentor** for Snapchat Lens Studio. The skill knows our process, our quality bar, and continuously captures knowledge from real projects.

**Business value in one sentence:** We go from "knowledge lives with individuals" to "knowledge is a product that grows with every project".

---

## 2. All knowledge layers

The skill is built in **7 layers**. Each layer exists to solve a specific problem that otherwise costs time or causes errors.

### a) Official Snap documentation (365 pages)
**What:** All of `developers.snap.com/lens-studio/` curated and organized locally into 9 buckets (MCP, scripting, assets, scene, AR-tracking, try-on, publishing, performance, overview).
**What it costs NOT to have it:** The designer googles fragmentarily, gets stuck on outdated StackOverflow answers, mixes API versions from different years.
**Value:** ~2–4 hours/project of saved search time. The AI cites the right source instead of hallucinating.

### b) Empirical knowledge from real projects
**What:** `lens-studio-api-gotchas.md` (~21 entries) + `body-anchored-calibration.md` — things that **don't** exist in Snap's official docs. E.g. that Try-On Pack Sneakers has a mesh pivot 6–12 units off-center, or that the MCP token rotates on every LS restart.
**What it costs NOT to have it:** Every designer re-discovers the same pitfall. On the pilot project, one specific gotcha cost ~3 hours to find.
**Value:** This layer is the skill's **moat** — it's not googleable.

### c) MCP capability map (20 tools)
**What:** Complete schema for all 20 tools Claude Code can call in Lens Studio (scene mutations, asset handling, screenshots, GraphQL queries).
**What it costs NOT to have it:** The AI tries the wrong tool, gets cryptic errors, gives up.
**Value:** Saves minutes per tool call × hundreds of calls per project.

### d) Voice + pedagogy — "mentor mode" (v0.7.0)
**What:** 3 layers (Voice/Pace/Pedagogy) × 8 principles that govern **how the AI talks**. Translate jargon on first use, celebrate magic moments, be honest about uncertainty, give agency to the designer.
**What it costs NOT to have it:** The designer feels dumb, drops out halfway, gives up on the AI.
**Value:** This is the skill's **business logic**. The tech is the means — the mentor role is the product.

### e) Onboarding system
**What:** Concierge mode (8-step setup) + onboarding intake (8 questions in 3 groups, ~7 minutes) + Readiness Report.
**What it costs NOT to have it:** The designer gets thrown into Lens Studio, doesn't know where to start, asks a colleague for help.
**Value:** A colleague can start alone. No single person becomes a bottleneck.

### f) Self-growth protocol
**What:** `radon-skill-growth` v1.0 shared skill — protocol for how **new learnings get captured in the flow** during real projects and stream into the skill. Pointer in `references/_growth-protocol-pointer.md`.
**What it costs NOT to have it:** The skill stagnates after day 1. Knowledge from projects 2, 3, 4 ends up in people's heads or Slack threads and disappears.
**Value:** Compound interest. See section 4.

### g) CHANGELOG + discovery history
**What:** The skill's biography. Every release + every discovery logged with date, source, motivation.
**What it costs NOT to have it:** No visibility into how the skill grows. No ROI traceability. New colleagues don't understand why the rules look the way they do.
**Value:** Traceability. Auditability. Storytelling to the next client.

---

## 3. User-friendliness — how it works in practice

### Day 1 — designer Anna, has never built a Snap filter

1. **00:00** — Anna opens the hosted onboarding manual (one of three: SV full, EN full, or EN quick — `docs.example.valtech.com/radon/lens-studio/ (placeholder — canonical domain TBD post-migration)`). 8 steps with copy-paste-ready commands and "what you see when it worked" verification at every step. Sets up Claude Code, accepts the repo invitation, clones the skill.
2. **00:05** — Claude Code activates the skill automatically when Anna mentions "Snapchat filter for [client]". Confirms platform.
3. **00:10** — Concierge mode runs environment detection. Says "✅ LS installed, ❌ MCP not registered — want me to fix it?". One step at a time.
4. **00:30** — Setup done. Onboarding intake starts: 8 questions on vision, feel, tempo, audience. Anna gets ongoing "what you get back for the answer" feedback.
5. **00:45** — Readiness Report generated. Phase 0 (spec drafts) begins. The AI pulls TECH-SPEC and USER-EXPERIENCE from the brief + inspiration images.
6. **End of Day 1** — Anna has Phase 1 scaffolding live in Lens Studio. Something is visible. Magic moment celebrated.

### During the project — how the skill guides

- **9 phases with clear DoD** (definition of done). No "what do I do now?" feeling.
- **Watch points per phase** — 3–5 explicit pauses where Anna gets to approve.
- **Probe-first discipline** — the AI tries ONE thing, reads back the result, confirms it worked, before applying in bulk.
- **Inspector handoff** — when it's about "feel" (animation curves, color, position tuning) the AI hands the wheel to Anna in the LS Inspector. The AI knows its limit.

### When problems happen

- **Troubleshooting decision tree** — clarify → fix → escalate.
- **Silent-drop recovery** — when MCP says "success: true" but nothing happened, there's a protocol for it.
- **Mentor mode under setbacks** — the AI says "I think" instead of faking certainty. No gas-lit moments.

### BEFORE / AFTER

| | WITHOUT the skill | WITH the skill |
|---|---|---|
| Setup time (designer without Snap experience) | 1–2 days googling + colleague questions | **30 min concierge** |
| First filter live in Preview | 3–5 days trial-and-error | **~Day 1 afternoon** |
| Number of blocking questions to senior colleague | 10–20 per project | **1–3** |
| Risk of hidden gotchas in submission | High (Snap rejection common) | Lower — gotchas file catches the known ones |

---

## 4. How the skill gets smarter over time

### When a designer solves something new

1. The AI notices a solution isn't in `references/`. Greps to prove it.
2. It says **in the middle of the flow** to the designer: "We have a discovery: X. That rule isn't in the skill. Should we write it in?"
3. The designer says yes / no / save for later.
4. On yes: the **Generalization rule** runs (see [SECURITY-AND-PRIVACY.md](docs/SECURITY-AND-PRIVACY.md)) — the project-specific solution gets rewritten into a universal rule.
5. Diff shown. Designer approves. Commit + CHANGELOG entry. **~2 minutes**.

### How the knowledge reaches the next colleague

Every time someone starts the skill in the terminal (the `claude` command), an auto-sync hook pulls the latest rules from GitHub **before** the session begins. The designer never has to run `git pull` themselves — it's handled for them. If new entries have landed since last session, a short summary appears inline in chat; otherwise it's silent. **Users never need to sync manually. No training, no Slack thread, no parallel wiki to maintain.**

### What it requires of the designer

Two minutes of approval mid-project. No batch work at session end. No separate documentation step.

### The Generalization rule — why critical

Without it, discoveries land as **anecdotes** ("for this project we needed X=-80"). With it, they land as **rules** ("the Try-On Pack pivot is typically off-center, here's how you detect and solve it").

That's the difference between a log and a textbook.

### CHANGELOG.md 12 months from now

If Valtech runs 10–20 lens projects per year and each project contributes 2–5 discoveries, in a year we have a CHANGELOG with **40–100 entries**. Each entry is a rule that a colleague learned on real production time. That's compound interest on invested time.

**Honest:** Today only **one** project is actually seeded in. The mechanism is proven — the volume is not. That's what the next projects will show.

---

## 5. Security and privacy

**The skill is designed so that client data and Valtech-internal work never leave the designer's machine.** Three independent layers enforce this.

### a) Physical separation between skill and client work

The skill repo lives in one folder (typically cloned to `~/Projects/` or wherever the designer prefers). The client's Lens Studio project — with 3D models, briefs, campaign assets, brand-specific tuning values — lives in a **completely separate folder**, e.g. `~/Projects/<client>-lens/`. The two never touch. The skill repo's `.gitignore` and folder boundaries make accidental crossover impossible.

### b) The Generalization rule (technical filter)

The shared `radon-skill-growth` skill specifies a mandatory three-step checklist that runs **before anything is even proposed for commit** to the skill repo. See `references/_growth-protocol-pointer.md`:

1. **Identify the general rule** behind the specific finding.
2. **Explicit removal checklist** — these get stripped:
   - ❌ Client names (adidas, RFSU, Ray-Ban, etc.)
   - ❌ Project-specific values (X coordinates, campaign budgets, exact tuning constants for this one shoe)
   - ❌ Internal project names, file paths
   - ❌ Dates, deadlines
   - ❌ Personal data
   - ❌ API keys, tokens, credentials
3. **"Next colleague" test** — would the entry make sense to a designer six months from now who has no context about this project? If no → not committed.

Only the **generalized rule** flows to the skill repo. The raw data never does.

### c) Human approval gate

The agent **never auto-commits and never auto-pushes**. Every commit + push to the skill repo is approved by the designer in-flow:

> "Is it OK if I update the system files with your discovery?"

Yes / no / save for later. No yes = nothing leaves the local machine.

### What this means in practice

| What | Where it lives | Goes to GitHub? |
|---|---|---|
| Client briefs, 3D models, campaign content | `~/Projects/<client>-lens/` | **Never** |
| Project-specific tuning values, X/Y/Z coordinates, exact constants | Designer's working session, Lens Studio Inspector | **Never** |
| Credentials (Anthropic API keys, GitHub tokens) | OS keychain / shell env | **Never** |
| **Generalized** patterns ("Try-On Pack Sneakers pivots are typically 6–12 LS units off-center; detect via AABB before assuming center") | `references/*.md` in skill repo | Yes — only after the Generalization rule has stripped specifics and the human has approved |

### Repo status

The skill repo is **public**, under the Valtech RADON GitHub organisation (`valtech-radon/lens-studio-snapchat-filter`). Read access is open; write access is restricted to authorised Valtech personnel and approved contractors. All contributions to `main` go via pull request — direct pushes are blocked by branch protection. The growth protocol writes discoveries as PRs (not direct commits), so every change is reviewed by a human before merge.

### Comparison with the alternative

The risk if Valtech **doesn't** have a system like this:

| Risk without the skill | Consequence |
|---|---|
| Designers google freely | Uncontrolled sources, uncontrolled code snippets into client projects |
| Knowledge stays with the individual | If the person is unavailable → silent knowledge loss |
| Slack threads as "wiki" | Searchable only by insiders, no audit trail, no format protection |
| No audit trail on learnings | No visibility into what the agent learns from project to project |

**The skill isn't a new security risk — it's a structured solution to a risk that already exists.**

For the full reasoning, see [`docs/SECURITY-AND-PRIVACY.md`](docs/SECURITY-AND-PRIVACY.md).

---

## 6. Business value — concrete ROI

### Time saved per project

| Step | WITHOUT skill | WITH skill | Saved |
|---|---|---|---|
| Designer onboarding (Snap-specific) | 1–2 days | 30 min concierge | **~12 h** |
| Setup (LS, MCP, project structure) | 4–6 h trial-and-error | 30 min | **~5 h** |
| Troubleshooting known gotchas | 2–4 h × N gotchas | <30 min | **~3–6 h** |
| Calibration (foot-tracking, face, hand) | 1–2 days with tracker surprises | 4–6 h with protocol | **~8–12 h** |
| **Total per lens project** | ~5–7 days setup/troubleshoot | ~1–2 days | **~3–5 working days** |

At Valtech rate ~10–12k SEK/day = **30–60 kSEK saved per project**.

### Knowledge preservation

Today, large parts of the knowledge live in individual people's heads. If a key colleague is sick, on vacation, or busy on another project during delivery — the knowledge is unavailable.

With the skill: the knowledge is **code**. It's in git, it travels with colleagues, it stays.

**Bus factor: goes from 1 to N.**

### Scalability

Today, Snapchat Lens projects depend on a single person. With the skill + 2–3 trained designers: **3–5 parallel lens projects** become possible.

### Honest disclaimer

- **v0.7.1** is 2 days old. The seed is **ONE** real project (a Sponsored Lens project).
- The volume value above is **extrapolated**, not proven across a portfolio.
- What we know: the pipeline worked for the pilot project in real time. The mentor mode felt strong enough to the designer to keep investing in.
- What we don't know yet: how powerful the compound interest gets once 5–10 projects have run through. That's what the next 6 months will prove.

---

## 7. Recommended next steps

### What's already shipped (since v0.7.1)

- ✅ **`CONTRIBUTING.md`** — canonical docs per topic, install-step workflow, version convention. See [`CONTRIBUTING.md`](CONTRIBUTING.md).
- ✅ **Hosted onboarding manuals** — three Cloudflare-hosted manuals (SV full, EN full, EN quick) at `docs.example.valtech.com/radon/lens-studio/ (placeholder — canonical domain TBD post-migration)`. Designed for a non-technical colleague to install Claude Code + the skill in 10–15 min.
- ✅ **`ONBOARDING-SNIPPET.md`** — Slack/email invite templates (three variants) for sharing the manual with new colleagues.
- ✅ **Auto-sync hook** — `scripts/session-sync.sh` runs on every `claude` start, pulling latest skill updates and announcing new entries inline. No daily `git pull` to remember.
- ✅ **Branch protection rule on `main`** — created. Force-push + branch deletion blocked. Dormant today (free private personal repo), auto-activates post-migration.

### Now (this week)

1. **Security review** — have the relevant function read `references/_growth-protocol-pointer.md` + section 5 of this document. Confirm the Generalization rule + manual commit approvals meet Valtech's policy. The shared `radon-skill-growth` skill defines the full protocol.
2. **Migrate repo to a Valtech organization account** on GitHub. Eliminates the "personal account" question mark and auto-activates the branch protection rule.
3. **Set up a 30-min demo** for 2–3 selected designers + 1 stakeholder. Live walk-through of the onboarding flow.

### Soon (this month)

4. **Pilot project no. 2** — pick an upcoming Snap lens assignment and run it with the skill from day 1, with a designer who wasn't part of the first pilot. A real empirical test of onboarding.
5. **`@valtech.com` SSO** for repo access via GitHub Enterprise or equivalent (depends on step 2).
6. **Slack channel** (`#lens-studio-skill` or similar) for skill updates, discoveries, and questions.

### Going forward (this quarter)

7. **Measure ROI for real** after 3–4 completed projects. Compare actual time against the estimates in section 6.
8. **Explore generalization** — can the same skill architecture lift over to TikTok Effect House? Meta Spark? The question is open, but the growth protocol would be identical.
9. **Story packaging toward clients** — if the measurement in step 7 holds, package as a sales narrative for Sponsored Lens offerings.

---

## Closing

What exists today is a **working v0.7.1** seeded from a real project, with a mechanism to grow with every future project. It's not finished — it's **alive**.

The strong: the voice mandate is **code**, not culture that dies with staff turnover. The Generalization rule makes skill growth **safe by default**, not as an afterthought.

The honest: the empirical base is thin. The mechanism is proven, the volume is not. The next 3–6 months will prove (or disprove) the hypothesis.
