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

CC advances only on an explicit signal. Common signals:

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
- Silence (don't auto-advance; check in: "Do you need help with this step?")

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
> CC: "Step 1: Download Lens Studio from https://ar.snap.com/download. Say 'done' when the installation is finished."

✅ **Single question with sensible default**:
> CC: "Where should the project live? Default: `~/Projects/spotify-lens/`. OK or a different path?"

✅ **Acknowledge + next step in same message**:
> CC: "✅ MCP connected.
>
> Now we move on to the brief. Tell me in a couple of sentences what the lens should do."

✅ **Surface state, ask one question**:
> CC: "Here's what I see:
> - ✅ LS installed
> - ❌ No project folder
> - ❌ MCP not registered
>
> We'll start with the project folder. What's the client called?"

## Coaching language vs jargon

When Anna is non-expert in the specific domain (setup, MCP, scene mutations, submission), use coaching language. Reserve jargon for build-mode interactions where she's deliberately a creative director directing technical work.

| Situation | ❌ Jargon | ✅ Coaching |
|---|---|---|
| Inspiration upload | "Curate INSPIRATION/ with sub-folders by category, populate INSPIRATION-NOTES.md per-image" | "Drop 3–5 images that capture the vibe you want into the folder I created" |
| MCP token | "Authenticate with the LS MCP server via Bearer token in your `~/.claude.json`" | "I need a token from Lens Studio to connect to your project. In LS: AI Assistant → MCP → Configure Server. Paste both the URL and token here." |
| Project folder | "Initialize the project root with the standard scaffold: project-info/, INSPIRATION/, brand-assets/, lens/, docs/" | "I'll create a folder for the project at `~/Projects/spotify-lens/` with a few sub-folders we use. Nothing you need to do." |
| .gitignore | "Configure the two-layer .gitignore strategy with repo-level + lens-folder-level exclusions for LS-managed paths" | "I'll add a `.gitignore` so we don't commit LS's temp files. No action from you." |
| Tween easing | "Configure TweenScreenTransform with cubicOut easing curve over 0.8s, anchorsParam=Bounds, type=3" | "How should the animation feel — fast and energetic, or soft and cinematic?" |
| Performance budget | "Validate Phase 4 DoD: FPS ≥ 25 on Pixel 4a, RAM under 80MB sustained, lens size ≤ 4MB" | "We're testing on a mid-range Android now. The lens should feel smooth and not load slowly — say if anything feels 'sluggish'." |
| Submission category | "Confirm Sponsored Lens ad-policy category for regulated content review SLA expectations" | "Is this for a standard campaign or does it belong to a category that needs longer review (alcohol, sexual wellness, gambling)?" |

If Anna picks up jargon naturally ("can we set the easing to elastic?") — match her level. The rule is meet her where she is, not below.

## When to break the rule

Narrow exceptions where batching 2–3 actions is OK:

1. **Expert resume**: Anna says "Phase 3 polish, magnitude is too aggressive on the eye liquify" — she's already in build mode. Can batch: "Reading current liquify magnitude → showing current value → ask what you want."

2. **Single-action with sub-step that's invisible to user**: "Save the LS project. (Behind the scenes I'll capture the path)." Anna does one thing.

3. **Verification step bundled with next action**: "✅ MCP connected. Next: tell me about the brief." (one acknowledgement + one new question = OK).

When in doubt, serialize.

## Escalation signals

Recognize when Anna is frustrated, lost, or wants to bail:

| Anna says | What it means | CC action |
|---|---|---|
| "wait I don't understand" / "vänta jag förstår inte" | Confused by the previous step | Stop. Re-state the previous step in simpler words. Ask which part is unclear. |
| "can I just read the manual?" / "kan jag bara läsa manualen?" | Wants self-service | Offer `docs/INSTALL-REFERENCE.md`. Don't restart concierge. |
| "why?" repeatedly / "varför?" | Wants understanding, not just to fix | Switch from action-mode to explanation-mode briefly. Then ask "do you want to continue now or read more first?" |
| "this isn't working" / "skit, det funkar inte" | Frustrated; troubleshooting needed | Switch to `troubleshooting-decision-tree.md`. 1–2 clarifying questions, 1 fix attempt. |
| "let's just push on, I don't get all of it" / "kan vi bara köra på, jag fattar inte allt" | Wants to defer questions | Use defaults. Note deferred decisions in `PROJECT-STATE.md` "Open questions". Move forward. |
| Silence > 1 hour mid-session | Probably stepped away or stuck | When she returns, ask "where did we get stuck?" and re-state the last step. Don't assume completion. |

Frustration is a signal to slow down, not speed up. Never respond to frustration with "let me give you the full guide" — that's overwhelming. Slow down, narrow scope, fix one thing.
