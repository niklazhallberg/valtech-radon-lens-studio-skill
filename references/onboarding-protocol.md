# Onboarding protocol

The 8-question / 3-group light-touch intake CC runs after concierge setup completes (LS installed, project folder created, MCP registered, brief captured, INSPIRATION populated ≥ 3 images). Goal: minimum questions, maximum inference from inspiration. Preserve creative momentum.

## Contents
- Onboarding philosophy
- Group 1 — Vision (3 questions)
- Group 2 — Constraints (3 questions)
- Group 3 — Asset validation (2 questions)
- Readiness Report gate
- Proactive clarification (per-phase, 2-4 questions max)
- Anti-patterns

## Onboarding philosophy

- **Ask minimum. Infer maximum.** Designers don't know exact specs — they know feel.
- **Default + iterate** beats "specify upfront".
- **Preserve creative momentum** — bureaucratic intake kills projects.
- One question at a time. No batching the 8 into a wall of text.
- **The 8/3 structure is INTERNAL pacing — don't announce it to the user.** Anna should experience a natural conversation, not "I'm going to ask 8 questions in 3 groups, takes 7 minutes." Open with a conversational lead-in ("Bra — nu vill jag förstå din vision lite bättre. Första frågan: ...") and just start asking.
- After all 8 answered, CC reads INSPIRATION/ and infers concrete design decisions (colors, motion, mood) WITHOUT asking. Surface inferences in PROJECT-DECISIONS.md for user validation, don't ask for hex codes or easing curves.

## Group 1 — Vision (3 questions)

**Q1.1**: "Describe the lens in 1-2 sentences. What's the moment for the user?"

Example expected answer: *"User holds up phone, lens detects mood from expression, suggests Spotify podcast. Tap-to-confirm reveals podcast art with play button."*

**Q1.2**: "Primary feeling? One word: playful / mysterious / energetic / calm / surreal / nostalgic / cinematic / chaotic / etc."

This single word drives motion, color saturation, tween easing, sound design choices. Don't ask for more nuance — CC will infer from INSPIRATION/.

**Q1.3**: "Pace: snappy / medium / slow-cinematic?"

Drives tween durations:
- snappy → 0.2-0.4s tweens, sharp easing
- medium → 0.5-0.8s, standard ease-in-out
- slow-cinematic → 0.8-1.5s, soft easings (cubic, sine)

CC uses these as defaults; user can refine in Phase 3 polish.

## Group 2 — Constraints (3 questions)

**Q2.1**: "Client + ad-policy category?"

Example: "Spotify, music/audio (general)". Or "RFSU, sexual wellness (regulated — 1-2 week review)". Critical for submission timeline and content review burden.

**Q2.2**: "Anything off-limits?"

Examples: "no face liquify" (brand prefers ungimmicked face), "no 18+ gating even though category allows" (campaign decision), "must be selfie-only" (no rear camera).

Don't ask "are there constraints?" generically — ask for explicit no-go items.

**Q2.3**: "Deadline?"

Single date or week range. Drives:
- How many Phase 3 polish iterations possible
- Whether to skip Phase 2.5 advanced features
- Submission timing relative to Snap review SLA (1-3 days general, 1-2 weeks regulated)

## Group 3 — Asset validation (2 questions, CC reads INSPIRATION/ first)

Before running the scan, CC says one friendly context line so Anna understands why bash output is about to appear:

> CC: "Kikar igenom inspiration-bilderna du la in..."

Then CC runs:

```bash
ls ~/Projects/[client]-lens/INSPIRATION/
find ~/Projects/[client]-lens/INSPIRATION/ -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.mp4" \) | head -20
```

Then CC extracts visual signals via reading the images (color analysis, composition, motion characterization).

When surfacing findings, present them naturally — never "I ran find ~/Projects/... and found 5 files" but "Du har 5 bilder. Jag ser mörka toner, neon-accenter, och minimalistisk stil...".

**Q3.1**: "INSPIRATION/-folder has [N] images. I see [extracted summary — e.g., 'mostly dark moody color palette with neon accents, slow-paced motion, minimalist compositions, branded elements from Spotify']. Match your vision, or am I reading the wrong signals?"

User confirms or corrects. CC adjusts inference.

**Q3.2**: "Anything specific in `brand-assets/` I should know? Logos, brand colors, fonts the client has locked?"

If `brand-assets/` empty → CC will infer brand from INSPIRATION/ + client name. If populated → CC uses those as authoritative over inference.

## Readiness Report gate

After all 8 questions answered, CC drafts a Readiness Report as a per-row table. Each row gets a confirm/edit marker — ✔ for verbatim user-provided answers (rarely need adjustment); ✔/✏️ for CC inferences and defaults (user may want to tweak). Format chosen so the user can scan and spot ONE wrong row without reading prose.

```markdown
## Readiness Report — [client] Lens

| Decision | Value | |
|---|---|---|
| Vision | [Q1.1 verbatim] | ✔ |
| Feeling | [Q1.2] | ✔ |
| Pace | [Q1.3] | ✔ |
| Client + category | [Q2.1] | ✔ |
| Off-limits | [Q2.2] | ✔ |
| Deadline | [Q2.3] | ✔ |
| **CC inference** | | |
| Color palette | [3-5 hex codes from INSPIRATION/] | ✔/✏️ |
| Motion feel | [characterized: ambient/sharp/elastic/etc.] | ✔/✏️ |
| Mood signals | [extracted from imagery] | ✔/✏️ |
| Typography | [inferred: modern/classic/playful/etc.] | ✔/✏️ |
| Composition | [centered/dramatic/minimal/etc.] | ✔/✏️ |
| **Defaults** | | |
| Audio | Silent (no ambient track) | ✔/✏️ |
| Interaction | Tap-anywhere primary trigger | ✔/✏️ |
| Reset | No auto-reset (user controls re-trigger) | ✔/✏️ |
| Camera | Front-only (selfie) | ✔/✏️ |

### Specs CC will draft (you review before Phase 1)
- `docs/TECH-SPEC.md` — scene hierarchy, scripts, performance targets
- `docs/USER-EXPERIENCE.md` — second-by-second user journey
- `docs/PROJECT-DECISIONS.md` — log of every inference

Reply:
- **"go phase 0"** if all rows look right
- **"ändra [row]: [new value]"** for any row that needs adjusting
```

Wait for user's "go phase 0" before drafting specs. If user replies with "ändra X: Y", update the relevant row, re-surface the table, wait again.

## Proactive clarification (per-phase, 2-4 questions max)

At the start of every phase, CC runs this protocol:

1. Read all user-provided files relevant to the phase
2. Identify what's truly UNCLEAR or MISSING — not what could be inferred
3. Surface 2-4 targeted questions BEFORE building
4. Each question has options + a recommendation. Don't ask open-ended.
5. Wait for answers
6. Document answers in `PROJECT-DECISIONS.md`
7. Proceed

### Phase 0 template — concept clarification

> "Reading brief + inspiration. Before drafting specs, 2 clarifications:
>
> 1. **Trigger model**: tap-anywhere to start the effect, or always-on (lens starts effect immediately on open)? Default: always-on (matches 'calm + cinematic' pace).
> 2. **Reset**: tap to reset to baseline, or no-reset (effect persists until lens close)? Default: no-reset.
>
> Answer with single words. I'll proceed."

### Phase 1 template — scene placement

> "Building static scene. 2 placement confirmations:
>
> 1. **Primary element placement**: chest level or face-level? Default from inspiration: face-level.
> 2. **Background treatment**: full effect or partial overlay? Default: partial overlay (face still visible)."

### Phase 2 template — animation timing + trigger

> "Animations need direction:
>
> 1. **Tween timing**: snappy (0.3s), medium (0.6s), or slow (1.0s)? Default from your pace setting: [extracted].
> 2. **End state**: held until tap, auto-reset after N seconds, or user-choice loop? Default: held until tap (matches no-reset principle).
> 3. **Gating during animation**: ignore taps mid-tween (cleaner), or queue them (responsive but choppy)? Default: ignore."

### Phase 2.5 template — advanced features

> "For [feature — e.g., face liquify]:
>
> 1. **Magnitude**: subtle (1.0x baseline) / moderate (1.2x) / dramatic (1.5x+)? Default from feeling: [extracted].
> 2. **Trigger**: automatic on lens open, or user-tap? Default: automatic.
> 3. **Reset on tap**: yes/no? Default: no (effect persists)."

### Phase 3 template — polish iteration

> "Polish pass. From your inspection of [feature] in Preview, what feels off?
>
> Common dimensions: magnitude (too strong/weak), timing (rushed/sluggish), color (saturated/muted), position (occlusion/empty space), easing (linear/elastic/cubic).
>
> Surface ONE specific change you want. I'll iterate, then surface for re-check."

### Phase 5 template — submission prep

> "Ready for submission. 3 confirmations:
>
> 1. **Ad-account target**: [client] or [agency]? Pull from Submit panel dropdown.
> 2. **Lens name** (final, not 'Untitled' from LS): ?
> 3. **Preview video**: I generate via LS Preview recording, or you provide a polished version?
>
> Snap submission is irreversible — confirm carefully."

## Anti-patterns

❌ Asking 20 questions at once
❌ "I need exact hex codes for primary and secondary brand colors" (infer from INSPIRATION/ instead)
❌ "What's your preferred easing function?" (jargon for non-experts)
❌ "Are there any constraints?" (too open — ask explicitly for off-limits)
❌ Building blind without asking when ambiguity is genuine
❌ Surfacing 10 inferences in PROJECT-DECISIONS.md without asking user to confirm the critical ones

## Good patterns

✅ "Pulled palette from INSPIRATION/: deep blue (#1e5d8c), teal (#3a9ab8), coral accent (#e89880). Match?"
✅ "Set tweens to 0.8-1.2s based on 'cinematic' direction. Adjustable later."
✅ "Bubbles: ambient (always) or triggered (on tap/smile)?" — genuine ambiguity, no inference possible
✅ "Marine life: subtle (background) or featured (foreground)?" — genuine choice user must make
