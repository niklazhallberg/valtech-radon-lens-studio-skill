# Operational rules — locked policies

Eleven non-negotiable policies. Each derived from a specific production incident or repeated friction pattern. Numbered for cross-reference from `SKILL.md` and other refs.

## Contents
- Rule 1: Two-step commit/push gate
- Rule 2: ⌘S save handshake
- Rule 3: Auto-accept read-only, manual approval for destructive
- Rule 4: Atomic commits
- Rule 5: Scaffold-correct + logic-correct as independent checkpoints
- Rule 6: Probe + bulk mutation pattern
- Rule 7: Concrete values, not generic descriptions
- Rule 8: Don't fabricate authority citations
- Rule 9: Don't extend scope
- Rule 10: Lock UX principles before scripting
- Rule 11: Read-back rule (success ≠ persistence)

---

## Rule 1: Two-step commit/push gate

**Policy**: never combine `git commit` and `git push` in a single sequence. Always pause between.

**Sequence**:
1. User says "go commit" → CC stages files + commits locally + surfaces hash + `git log --oneline -3` for inspection
2. User reviews the local commit (message, files included, diff)
3. User says "go push" → CC pushes to origin
4. CC surfaces old..new ref to confirm push landed

**Rationale**: catches stale wording, missing files, hook-induced changes BEFORE they propagate to origin/main. Once pushed, fixes require force-push (destructive) or revert-commit (history pollution).

**Applies to**: all branches, all commits. NO exceptions for "small" commits or feature branches.

**Edge case — pre-commit hook fails**: the commit did NOT happen. Fix the issue, re-stage, create a NEW commit (don't amend, which would modify a previous commit that may have been fine).

---

## Rule 2: ⌘S save handshake before scene-mutating commits

**Policy**: MCP scene mutations only update LS in-memory state. The `.esproj` and `.scene` files on disk remain unchanged until user presses ⌘S in LS. Before any commit involving scene changes, pause and ask user to ⌘S, then verify with `git diff lens/`.

**Sequence**:
1. CC applies scene mutations via scene-graphql
2. CC verifies via read-back that mutations took effect in LS in-memory state
3. CC says: "Switch to LS and press ⌘S. Type 'saved' when done."
4. User saves, types "saved"
5. CC runs `git diff lens/` to confirm disk changed
6. If diff empty after save → MCP mutation did NOT actually change anything (silent failure). Diagnose before commit.
7. If diff present → proceed to commit gate (Rule 1)

**Rationale — the phantom-success bug**: MCP read-back can show new value while disk file is unchanged. Commit without ⌘S captures the OLD scene state. The lens then ships with the wrong scene, looking correct in MCP queries but broken in Preview.

**Applies to**: any commit touching `lens/Assets/Scene.scene` or `lens/[name].esproj`. Scripts (`.ts`) write directly to disk and don't need ⌘S.

---

## Rule 3: Auto-accept read-only, manual approval for destructive

**Policy**: read-only operations are auto-approved. Every destructive operation requires explicit per-call user approval.

**Auto-accept**:
- All `scene-graphql` / `asset-graphql` query operations
- `mcp__lens-studio__ListInstalledPackagesTool`
- `mcp__lens-studio__RunAndCollectLogsTool` (read-only — refreshes Preview but doesn't mutate scene)
- `mcp__lens-studio__CapturePanelScreenshotTool`
- `mcp__lens-studio__RecompileTypeScriptTool` (status-only)
- `git status`, `git log`, `git diff`, `ls`, `cat`, file reads
- `claude mcp list`

**Manual approval per call**:
- Any `setProperty`, `createSceneObject`, `deleteSceneObject`, `setParent`, `addComponent`, `removeComponent` mutation
- Any `asset-graphql` mutation
- File writes (CC's Write/Edit tools)
- Package installs (`pip install`, `npm install`, etc.)
- `claude mcp add`, `claude mcp remove`
- Every `git commit`, `git push`, `git reset`, `git restore`, `git checkout`
- Any `Bash` running destructive shell commands (`rm`, `mv`, `mkdir` for new project folders)

**Rationale**: read-only ops are cheap, reversible, fast. Destructive ops break scene state in non-obvious ways. The per-call gate is friction that pays for itself when a stray mutation would corrupt the project.

**Edge case**: a series of probed-and-validated mutations (Rule 6) can be batched into one alias-mutation block — that's still ONE permission prompt for the logical unit, not per-mutation.

---

## Rule 4: Atomic commits — one logical change per commit

**Policy**: each commit captures ONE coherent change. Don't bundle unrelated changes.

**Examples of atomic**:
- Phase 1 scaffolding + closed-state layout + pulse animation (one coherent "static scene is done" unit)
- All anchor adjustments for a single Screen Image
- A bug fix + the test that catches the bug

**Examples of NON-atomic (split these)**:
- "Phase 1 scaffolding + Phase 2 controller script" — two phases, two commits
- "Bug fix + unrelated copy revision" — split
- "Mutations to scene + script refactor" — split (different files, different reasoning)

**Rationale**: atomic commits are easier to review, easier to revert if needed, and make `git bisect` actually useful.

---

## Rule 5: Scaffold-correct + logic-correct as independent checkpoints

**Policy**: when a build has a static/dynamic seam (Phase 1 static scaffold → Phase 2 dynamic logic), commit AND PUSH to origin between them. Remote checkpoint is real rollback insurance.

**Sequence**:
1. Build static scaffolding (Phase 1)
2. Verify in Preview that the closed-state visual matches spec
3. Commit (Rule 1: two-step gate)
4. **Push to origin** — this is the rollback checkpoint
5. Pause for user verification "go phase 2"
6. Build dynamic logic (Phase 2)
7. Commit + push as separate atomic step

**Rationale**: local-only commits don't help if disk dies, repo gets corrupted, or user accidentally `git reset --hard`. The remote checkpoint guarantees a known-good state.

**Edge case**: if working on a feature branch (not main), still push to origin/branch. The principle is "off-machine backup", not specifically "main".

---

## Rule 6: Probe + bulk mutation pattern

**Policy**: for N similar mutations where the pattern is unproven:
1. Probe ONE target first
2. Read-back to confirm actual value matches intent (Rule 11)
3. If correct: bulk-apply rest in single batched alias-mutation
4. If incorrect: diagnose pattern, fix it, re-probe

**Critical for**:
- Enum writes (NUMBER + integer index per `lens-studio-api-gotchas.md`)
- Compound-type writes (VEC4/RECT — silent-drop bug, use scalar NUMBER instead)
- REFERENCE bindings to @input types (require concrete TS class, not `any`)
- Any setProperty pattern coming from web search or training data

**Working pattern**:
```graphql
# Step 1: PROBE
mutation {
  probe: setProperty(id: "<one-id>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
}

# Step 2: READ-BACK (separate call, full property surface)
query {
  sceneObject(id: "<one-id>") {
    components {
      ... on ScreenTransform {
        anchor { left right top bottom }
      }
    }
  }
}

# Step 3: VERIFY value matches intent
# Step 4: If yes, BULK
mutation {
  a: setProperty(id: "<id-2>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
  b: setProperty(id: "<id-3>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
  c: setProperty(id: "<id-4>" propertyPath: "anchor.left" valueType: NUMBER value: "-0.5") { success }
  # ... rest of N-1 targets
}
```

**Rationale**: prevents mass-applying a broken pattern before discovering the breakage. Catching at 1 mutation costs 30 seconds; catching at 25 mutations costs hours of cleanup.

---

## Rule 7: Concrete values, not generic descriptions

**Policy**: replace vague language with specific, measurable values.

| ❌ Wrong | ✅ Right |
|---|---|
| "Anchor offsets toward the edge of the screen" | "Anchor center moves from `(0, 0)` to `(-1.8, 0)` (off-screen-left)" |
| "Long pause before reroll" | "1.2s delay before reroll prompt appears" |
| "Slow fade-out" | "TweenAlpha duration=0.8s, easing=cubicOut" |
| "Some opacity" | "alpha=0.4" |
| "Render behind" | "renderOrder = -100" |

**Rationale**: vague language hides ambiguity. CC and user can both nod at "long pause" while imagining different durations. Specific values are the contract.

**Applies to**: TECH-SPEC drafts, animation specs, tween configurations, color choices, position adjustments, decision logs.

**Exception**: brief / vision-statement / mood language is INTENTIONALLY high-level. "Cinematic" is fine in `vision-statement.md`. The translation to concrete values happens in TECH-SPEC.

---

## Rule 8: Don't fabricate authority citations

**Policy**: don't invent claims like "Snap's 5s engagement threshold" or "industry-standard 24fps cinematic feel" without a verifiable URL or KB query. Default to neutral internal framing.

**Wrong**:
> "Snap recommends 5s tap-to-final-state for engagement (Snap Developer Docs, 2025)."

If that doc doesn't exist or you can't quote it, don't claim it. Same for any "industry best practice", "academic study shows", "Snap engineering blog".

**Right**:
> "Internal target: 5s tap-to-final-state. Based on agency campaigns shipped at this duration."

Or:
> "Industry best-practice for Sponsored Lens engagement (rough heuristic): 3-7s for first meaningful payload."

Or, when you DO have a real source:
> "Per `mcp__lens-studio__QueryLensStudioKnowledgeBase('lens engagement metrics')`: [actual returned content]."

**Rationale**: fabricated citations erode trust. Once Anna catches one, she questions all CC outputs. Neutral framing ("internal target", "agency rule of thumb") is honest and equally actionable.

---

## Rule 9: Don't extend scope

**Policy**: never add functionality beyond what user requested or what's logically required. Full 4-question check + scope-validation challenge in `scope-creep-detection.md`.

**Quick mental check before adding ANYTHING**:
1. Did the user literally request this? → YES = build. NO = continue.
2. Is it logically required by what they DID request? → YES = build, acknowledge as derived. NO = continue.
3. Is it standard for the platform/brand/context? → YES = acknowledge, propose, wait for OK. NO = don't add.
4. Would the user benefit if I asked first? → YES = ask. NO = don't add.

Default bias: "no, don't add."

**Anti-pattern**: building the extension first, then asking "should I keep this?". Always ask before building.

---

## Rule 10: Lock UX principles before scripting

**Policy**: declare 3-5 UX principles before Phase 2 scripting starts. Locked principles take precedence over auto-derived behavior in script generation. See `ux-principle-locking.md`.

**Distinction**:
- **Feature requirement**: WHAT (e.g., "user can reroll fortunes")
- **UX principle**: HOW it should feel (e.g., "reroll never happens automatically — only user-tap triggers it")

CC will derive plausible-feeling behavior from feature requirements alone. Without explicit principles, CC adds countdown timers, auto-advance, face-event triggers, "for completeness" features — each defensible individually, together they drift from brand intent.

**Locking template** (user-driven, pre-scripting):
```
Lock the following N UX principles before any scripting:

1. <name>: <rule>
2. <name>: <rule>
...

These take precedence over any auto-derived behavior. If your script
generation would violate any of them, surface the conflict and pause
for direction before generating.
```

---

## Rule 11: Read-back rule — `success: true` does NOT guarantee persistence

**Policy**: after any compound-type, enum, or REFERENCE mutation, read back the actual stored value before trusting that the change applied.

**Why this exists** (the four silent-drop paths):
- RECT/VEC4/VEC2 compound types: only first 2 fields persist (rest silent-drop)
- STRING enum writes: return `success: true` but value doesn't apply
- REFERENCE to generic `any`-typed @input: value silently becomes `null`
- `Editor.Model.MetaInfo` field mutations: in-call read works, cross-call read shows old value (requires view write-back)

**Working pattern**: after every mutation in these categories, run:

```graphql
query {
  sceneObject(id: "<id>") {
    components {
      ... on <ComponentType> {
        <propertyName>  # read back the EXACT value
      }
    }
  }
}
```

Compare actual stored value against intent. If mismatch → silent-drop; use the working pattern from `lens-studio-api-gotchas.md`.

**Scope**: not needed for simple scalar NUMBER/STRING writes to verified properties. Required for everything compound/enum/REFERENCE.

---

## Cross-references between rules

- Rule 1 + Rule 2: scene-changing commits go through BOTH gates (⌘S handshake → commit gate → push gate)
- Rule 4 + Rule 5: atomic commits at the static/dynamic seam = two separate commits, both pushed
- Rule 6 + Rule 11: probe-and-bulk pattern bakes the read-back rule into its sequence
- Rule 9 + Rule 10: scope-creep-detection runs continuously; UX-principle locking is the upfront defense against derived scope expansion
- Rule 7 + Rule 8: concrete values internally, neutral framing externally
