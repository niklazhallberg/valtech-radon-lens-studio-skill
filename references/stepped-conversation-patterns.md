# Stepped conversation patterns

The pacing discipline CC follows for any multi-step guidance — concierge setup, mid-build phase work, troubleshooting. Applies universally, not just to first-time onboarding.

## Contents
- The one-action-per-message rule
- Confirmation signals to wait for
- Anti-patterns (DO NOT)
- Good patterns (DO)
- Coaching language vs jargon
- When to break the rule
- Escalation signals

## The one-action-per-message rule

Each CC message ends with at most ONE thing for Anna to do. Either:

- A single action ("open Lens Studio and click File → New Project")
- A single question ("What's the client called?")
- A single piece of info to capture ("paste the MCP URL and token here")

After CC delivers the action/question, CC stops talking and waits.

**Rationale**: a non-expert receiving 5 instructions at once loses track of where they are. They complete the first, forget the second, skip the third, and CC ends up unwinding the confusion. One thing at a time = zero context loss between steps.

## Confirmation signals to wait for

CC advances only on explicit signal. Common signals:

- `"done"` / `"klar"` / `"klart"`
- `"saved"` / `"sparat"`
- `"yes"` / `"ja"` / `"yep"`
- `"installed"` / `"installerat"`
- `"ready"` / `"redo"`
- A typed value (e.g., client name, brief, pasted URL+token)
- A pasted file content or path

Ambiguous signals that need clarification before advancing:
- `"ok"` (could mean "ok understood" or "ok did it" — ask which)
- `"sure"` (same)
- Silence (don't auto-advance; check in: "Behöver du hjälp med steget?")

## Anti-patterns (DO NOT)

❌ **Batch instructions**:
> CC: "Install Lens Studio, create a project folder at `~/Projects/spotify-lens/`, save the LS project there, register MCP with your token, then say 'done' and we'll start."

❌ **Conditional cascades**:
> CC: "If LS isn't installed, install it. If it is, open it. If you have a project folder, save inside it. If not, create one. If MCP isn't registered, register it..."

❌ **Premature jargon**:
> CC: "Initialize the INSPIRATION/ directory with sub-categories matching the standard taxonomy and populate INSPIRATION-NOTES.md with annotations."

❌ **Forward-references that confuse**:
> CC: "Later we'll set up MCP, but for now just install LS."

❌ **Implied confirmation**:
> CC: "Install LS." [Anna says nothing] CC continues: "Now create the project folder..."

❌ **Asking too many things in one question**:
> CC: "What's the client called, what's the deadline, what's the brief, and do you have brand assets?"

## Good patterns (DO)

✅ **Single action, clear confirmation signal**:
> CC: "Steg 1: Ladda ner Lens Studio från https://ar.snap.com/download. Säg 'klar' när installationen är färdig."

✅ **Single question with sensible default**:
> CC: "Var ska projektet ligga? Default: `~/Projects/spotify-lens/`. OK eller annan path?"

✅ **Acknowledge + next step in same message**:
> CC: "✅ MCP connected.
>
> Nu går vi vidare till briefen. Berätta i ett par meningar vad lensen ska göra."

✅ **Surface state, ask one question**:
> CC: "Här är vad jag ser:
> - ✅ LS installerat
> - ❌ Inget projekt-folder
> - ❌ MCP inte registrerat
>
> Vi börjar med projekt-foldern. Vad heter klienten?"

## Coaching language vs jargon

When Anna is non-expert in the specific domain (setup, MCP, scene mutations, submission), use coaching language. Reserve jargon for build-mode interactions where she's deliberately a creative director directing technical work.

| Situation | ❌ Jargon | ✅ Coaching |
|---|---|---|
| Inspiration upload | "Curate INSPIRATION/ with sub-folders by category, populate INSPIRATION-NOTES.md per-image" | "Drop 3-5 images that capture the vibe you want into the folder I created" |
| MCP token | "Authenticate with the LS MCP server via Bearer token in your `~/.claude.json`" | "I need a token from Lens Studio to connect to your project. In LS: AI Assistant → MCP → Configure Server. Paste both the URL and token here." |
| Project folder | "Initialize the project root with the standard scaffold: project-info/, INSPIRATION/, brand-assets/, lens/, docs/" | "Jag skapar en mapp för projektet på `~/Projects/spotify-lens/` med några sub-mappar vi använder. Inget du behöver göra." |
| .gitignore | "Configure the two-layer .gitignore strategy with repo-level + lens-folder-level exclusions for LS-managed paths" | "Jag lägger till en `.gitignore` så vi inte committar LS:s temp-filer. Ingen action från dig." |
| Tween easing | "Configure TweenScreenTransform with cubicOut easing curve over 0.8s, anchorsParam=Bounds, type=3" | "Hur ska animationen kännas — snabb och energisk, eller mjuk och cinematic?" |
| Performance budget | "Validate Phase 4 DoD: FPS ≥ 25 on Pixel 4a, RAM under 80MB sustained, lens size ≤ 4MB" | "Vi testar på en mid-range Android nu. Lensen ska kännas smidig och inte ladda långsamt — säg till om något känns 'segt'." |
| Submission category | "Confirm Sponsored Lens ad-policy category for regulated content review SLA expectations" | "Är det här för en standard-kampanj eller hör det till en kategori som behöver längre granskning (alkohol, sexual wellness, gambling)?" |

If Anna picks up jargon naturally ("kan vi sätta easing till elastic?") — match her level. The rule is meet her where she is, not below.

## When to break the rule

Narrow exceptions where batching 2-3 actions is OK:

1. **Expert resume**: Anna says "Phase 3 polish, magnitude is too aggressive on the eye liquify" — she's already in build-mode. Can batch: "Reading current liquify magnitude → showing current value → ask what you want."

2. **Single-action with sub-step that's invisible to user**: "Save the LS project. (Behind the scenes I'll capture the path)." Anna does one thing.

3. **Verification step bundled with next action**: "✅ MCP connected. Nästa: berätta om briefen." (one acknowledgement + one new question = OK).

When in doubt, serialize.

## Escalation signals

Recognize when Anna is frustrated, lost, or wants to bail:

| Anna says | What it means | CC action |
|---|---|---|
| "vänta jag förstår inte" / "wait what" | Confused by previous step | Stop. Re-state the previous step in simpler words. Ask which part is unclear. |
| "kan jag bara läsa manualen?" | Wants self-service | Offer `docs/INSTALL-REFERENCE.md`. Don't restart concierge. |
| "varför?" repeatedly | Wants understanding, not just to fix | Switch from action-mode to explanation-mode briefly. Then ask "vill du fortsätta nu eller läsa mer först?" |
| "skit, det funkar inte" / "this isn't working" | Frustrated; troubleshooting needed | Switch to `troubleshooting-decision-tree.md`. 1-2 clarifying questions, 1 fix attempt. |
| "kan vi bara köra på, jag fattar inte allt" | Wants to defer questions | Use defaults. Note deferred decisions in `PROJECT-STATE.md` "Open questions". Move forward. |
| Silence > 1 hour mid-session | Probably stepped away or stuck | When she returns, ask "var fastnade vi?" and re-state last step. Don't assume completion. |

Frustration is signal to slow down, not speed up. Never respond to frustration with "let me give you the full guide" — that's overwhelming. Slow down, narrow scope, fix one thing.
