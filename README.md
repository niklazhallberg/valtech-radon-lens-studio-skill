# valtech-radon-lens-studio-skill

> A Lens Studio skill for Claude Code that grows more intelligent every time we use it. Only available to Valtech RADON employees.

A Claude Code "skill" — a plug-in that turns the general-purpose AI assistant into a specialized mentor for Snapchat Lens Studio. Built and maintained by **Valtech RADON**, it captures empirically-validated patterns, gotchas, and workflows from real production lens builds.

---

## Background

Building a Snapchat Lens is harder than it looks. APIs shift between minor Lens Studio versions. ML trackers behave one way in desktop preview and another on a real device. Submission has strict, sometimes undocumented requirements. Every first-time designer hits the same traps.

Without a shared system, all of that knowledge lives in one person's head. They become the bottleneck — when they're on vacation, sick, or assigned to another project, the team starts from scratch.

**A shared knowledge bank is more durable than one expert.** That's why I (Niklaz) built `valtech-radon-lens-studio-skill`. It started concretely: while I built an RFSU Sponsored Lens with Claude Code as my pair, every gotcha, every API quirk, every tracker calibration trick was captured and generalized. On top of that foundation: all 365 pages of Snap's official Lens Studio documentation, curated and organized so the agent can cite the right source instead of hallucinating.

**Two design choices set the tone:**

- **Well-read, but not jargon-heavy.** The agent is programmed to translate technical terms on first use, guide designers through what works and what doesn't, and admit uncertainty with "I think" rather than faking authority. No gas-lighting, no overconfident AI.
- **Self-growing.** When a colleague and the agent solve something genuinely new during a real project, the agent asks permission to save it as a generalized rule — and pushes it back to GitHub. The next colleague who opens Claude Code inherits it automatically. No daily `git pull`, no Slack thread to chase.

**The bet is simple:** one colleague pays the time cost of discovery once. Every colleague after inherits the answer. The skill gets smarter the more we use it — compound interest on every project.

---

## How you and Claude Code split the work

The skill is built around a clear role split. You stay in your creative director seat. Claude Code handles the technical execution.

| You (Creative Director) | Claude Code (Technical Executor) |
|---|---|
| Provide vision, brief, inspiration images | Translate the vision into a Lens Studio scene structure |
| Make design decisions, judge "feel" | Build the closed state, animation logic, polish |
| Approve every mutation before it lands | Execute scene mutations, write TypeScript, install assets |
| Use the LS Inspector to fine-tune magnitude, easing, colour | Draft `TECH-SPEC.md` and `USER-EXPERIENCE.md` from your brief |
| Test on real device, report what you see | Probe with read-back to verify every change |
| Say yes / no / "try this instead" | Surface choices only when ambiguity is genuine |
| Set the pace — slow down when you need to | Ask 2–4 targeted questions per phase, never 20 |

This division is enforced by the skill's operational rules and voice mandate. You are never a passenger.

---

## Getting started

For the friendliest path — and the one we recommend for new colleagues — use the hosted onboarding manuals:

| Audience | URL |
|---|---|
| Quick / technically comfortable (EN) | https://valtech-radon-lens-studio-skill.niklaz-a-hallberg.workers.dev/nosmalltalk |
| Full guide (EN) | https://valtech-radon-lens-studio-skill.niklaz-a-hallberg.workers.dev/fullguide-en |
| Full guide (SV) | https://valtech-radon-lens-studio-skill.niklaz-a-hallberg.workers.dev/fullstandigguide-sv |
| Router (pick your path) | https://valtech-radon-lens-studio-skill.niklaz-a-hallberg.workers.dev/ |

The manuals walk through everything below in 10–15 minutes with copy-paste-ready commands and "what you see when it worked" verification steps.

### Prerequisites

- macOS, Linux, or Windows WSL terminal
- A **paid Claude account** — a free claude.ai chat account doesn't work with Claude Code. Options:
  - **Enterprise subscription** — on the way for Valtech RADON
  - **Your own Claude Pro** ($17–20/mo) — sign up at https://claude.com/pricing
  - **Your own API credits** ($5–20, pay-as-you-go) — sign up at https://platform.claude.com/login

### Five-step quick path (for engineers comfortable in a terminal)

The commands are written for macOS — adjust for Windows / Linux as needed.

**1. Install Lens Studio 5.20+** from https://ar.snap.com/download. Open it once to confirm it launches.

**2. Install Claude Code:**

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Verify with `claude --version`.

**3. Clone this skill to the Claude Code skills directory:**

```bash
git clone https://github.com/niklazhallberg/valtech-radon-lens-studio-skill.git ~/.claude/skills/lens-studio-snapchat-filter
```

You must be invited as a collaborator on the private repository to clone it. See the **Access** section below.

(The clone URL will change once the repository migrates to a Valtech GitHub organization.)

**4. Start Claude Code from any directory:**

```bash
claude
```

At the login prompt, pick the option that matches your account (Pro/Max subscription, or Anthropic Console API key).

**5. Tell the agent what you want to build:**

> "I want to build a Snapchat Lens for [your concept here]."

The skill activates automatically. The agent walks you through environment detection, concierge setup, the 8-question onboarding intake, and the full 9-phase build pipeline.

---

## Auto-sync: stays current automatically

Once installed, the skill keeps itself up-to-date in the background. There is **no daily `git pull` to remember**.

How it works: when you start Claude Code (`claude` in any terminal), a small hook runs `git pull --ff-only` on the skill repo before your session begins. If new entries have arrived since you last saw an announcement, you see something like this inline in chat (example):

```
💡 Lens Studio-skillen uppdaterades — 2 nya lärdomar sedan sist

Senaste ändringar:
  • feat(discovery): Text3D position via wrapper-parent
  • docs(v0.8.0): warm-tone CHANGELOG format

See CHANGELOG.md in the skill folder for full history.
```

If nothing has changed, the hook is silent — no noise.

**Setup:** run `bin/install.sh` from the cloned repo to wire it up, or manually add a `SessionStart` hook to `~/.claude/settings.json` that points to `scripts/session-sync.sh` in this repo. Once configured, you can forget it exists.

**Behaviour guarantees:**

- Pull-only — the hook never pushes anything
- Silent on no-op (no new entries) and on any failure (offline, auth, conflict)
- Never blocks `claude` startup, even if the pull is slow or fails
- Tracks "last seen" state in `~/.claude/state/lens-skill-last-head` so you only get notified about what's actually new to you
- Works across reclone / reset — stale state is detected and reset gracefully

This is what makes the "compound interest on skill investment" idea real. Your colleagues push discoveries; the next time you open `claude`, you see them. No manual sync, no Slack ping required, no one chasing anyone.

---

## What's in it

| File / area | Contents |
|---|---|
| `SKILL.md` | Entry point — voice mandate, 9-phase pipeline, operational rules, scope discipline |
| `references/snap-docs/` | 365 pages of Snap's official documentation, curated and organized into 9 must-have buckets |
| `references/mcp-tool-schemas.md` | All 20 Lens Studio MCP tools — parameters, use-cases, and explicit limits (what MCP cannot do) |
| `references/mcp-setup.md` | Install, register with Claude Code, reconnect playbook for when LS restarts |
| `references/lens-studio-api-gotchas.md` | ~21 empirically-validated API gotchas (Tween Manager quirks, ScreenTransform behaviour, MetaInfo transient-view persistence, and more) |
| `references/body-anchored-calibration.md` | Probe-first protocol for tracker-driven content (foot, face, hand, body, world-anchored). Mandatory reading before any tracker work |
| `references/voice-and-pedagogy.md` | The 8 principles + 3 layers that govern how the agent talks to you. Mentor-role is the product's core value, not just the technical machinery |
| `references/_growth-protocol-pointer.md` | Pointer to the shared `radon-skill-growth` skill that governs how new learnings flow back into the skill — the cultural protocol |
| `references/onboarding-protocol.md` | 8 questions, 3 groups, ~7 minutes — captures vision, constraints, asset validation before Phase 0 spec drafting |
| `references/concierge-setup-flow.md` | 8-step setup conversation for designers who've never built a lens before |
| `docs/MANUAL.html` · `MANUAL-EN.html` · `MANUAL-SIMPLE.html` | Designer-facing manuals (SV full, EN full, EN quick). Hosted live on Cloudflare — see Getting started above |
| `docs/index.html` · `docs/_redirects` | Router page and path rewrites for the hosted manuals |
| `bin/install.sh` | Idempotent setup script — wires the SessionStart auto-sync hook and verifies prerequisites |
| `scripts/session-sync.sh` | The hook itself — pulls latest skill updates and announces new entries inline |
| `ONBOARDING-SNIPPET.md` | Internal Slack/email invite templates (three variants: SV, EN, terse) for sharing the manual with new colleagues |
| `VALTECH-PRESENTATION.md` · `VALTECH-PRESENTATION-SV.md` | Standalone overviews for a broader Valtech audience (designer, team lead, tech lead, decision-maker). Kept at repo root so they don't ship publicly with the Cloudflare-hosted manuals |
| `CHANGELOG.md` | The skill's biography — every release, every accepted discovery, with timestamps, project context, and value-for-user statements |

See `SKILL.md` for the full reference catalog with load-on-demand cross-refs.

---

## How the skill gets better over time

**This is the part that matters most.**

Every project is an opportunity to make the skill smarter. When you and the agent solve something during a real build that the skill doesn't already know — a new gotcha, a new pattern, a subtle calibration trick — the agent will pause and ask permission:

> "We've learned something new here. [plain-language explanation of the finding]
>
> This is valuable to save for future situations. Today this knowledge isn't in the system files, which means the next colleague who [concrete use-case] will probably get stuck in the exact same trap, unless we write it in now as a learning. Let's make the files even better with the help of your discovery.
>
> Your discovery has real value — it makes me as an AI assistant smarter every time, and helps every colleague who meets the same trap in the future.
>
> **Is it OK if I update the system files with your discovery? It's quick and doesn't interrupt our work in any way.**"

**When you see this ask, please say yes.** That single permission is what turns this from a static knowledge base into a growing one.

The agent then:

1. **Generalizes the finding** — removes project-specific values, client names, dates
2. **Writes it into the right `references/` file** as a new section
3. **Adds a `CHANGELOG.md` entry** with timestamp, project context, and a "value for user" statement
4. **Shows you the diff** so you can review before anything lands on disk
5. **Commits and pushes** (with your second approval)

The whole cycle takes about 2 minutes and doesn't break your build momentum.

---

## Why your contribution matters

Without this protocol, lens-building expertise stays trapped in individual heads. People go on vacation, switch to other projects, or simply forget — and the institutional knowledge becomes inaccessible exactly when the next person needs it.

With this protocol, every solved problem becomes a permanent asset. The agent grows smarter with every accepted discovery. The compound effect over 5, 10, 20 projects is dramatic: a designer joining Valtech RADON next year inherits everything we have learned today.

**The bet is simple: compound interest on skill investment.** Every "yes" to the in-flow ask is a small deposit. Over time those deposits become the difference between starting from scratch and starting from a sharp, opinionated, battle-tested baseline.

When you scroll `CHANGELOG.md` six months from now, you should feel momentum. "We learned X in January, Y in February, all the way to today. This isn't standing still — it grows on its own when we use it."

---

## Access

This is currently a **private repository** on a personal GitHub account. Access is granted by invitation to Valtech RADON colleagues only.

If you have been invited as a collaborator:

- You have full read + write access
- Pull the repo into `~/.claude/skills/lens-studio-snapchat-filter/`
- Use the skill in your lens projects
- When the agent surfaces an in-flow ask: **say yes**
- Open an issue or push a fix when you see something that conflicts with your experience

There is no formal review process yet. Trust is high; the audit trail (every change in git history with project context, author, and timestamp) is the safety net.

Migration to a Valtech GitHub organization with SSO and granular role management is on the roadmap.

---

## At a glance

- **Owner**: Niklaz Hallberg
- **Status**: Private, invitation-only, growing actively
- **Latest release**: see `CHANGELOG.md`
- **Use it for**: Snapchat AR Lenses, Sponsored Lenses, brand campaigns, internal experimentation with Lens Studio AI workflows
- **Not for**: TikTok Effect House, Meta Spark, Unity / Unreal AR, native ARKit / ARCore (see `SKILL.md` `when_to_use` for full scope)
