# Capability Validation Protocol

How to verify Lens Studio API assumptions on the live LS instance before generating production TypeScript. This is the Phase 1.5 protocol from `phase-progression.md`.

## Why this exists

Lens Studio 5.x API surfaces shift across minor versions. External documentation lags. Web search results are often wrong or outdated. Training data assumptions are unreliable.

The live LS instance is the only authoritative source. Validate every API surface the production code will use *before* generating that code.

Cost of catching a wrong API name now: ~10 minutes.
Cost of catching it during Phase 2: rewriting half the controller.

## When to validate

For any production script, list the API surfaces it will use. Validate each surface that meets ANY of these criteria:

- Method or property name comes from web search, training data, or external docs
- Method behavior includes timing, cancellation, or callback semantics
- API has shifted between LS 5.x minor versions (check release notes if unsure)
- Method touches transient editor state (texture binding, scene anchors, component refs)

When in doubt, validate. The protocol takes minutes per surface.

## Protocol

For each API surface to validate:

1. **Define the assumption.** Write one sentence: "Calling X with parameters Y produces Z."
2. **Build minimal test scaffolding.** Smallest possible scene + script that exercises just that one API surface.
3. **Run on live LS.** Use MCP if available, or manual LS preview.
4. **Observe actual behavior.** Logger panel output, visual result, persistence to disk.
5. **Record finding.** Update project's TECH-SPEC.md or a working notes doc with the empirical result.
6. **Clean up.** Remove test scaffolding before Phase 2.

## What to validate (typical surface list)

For a standard tap-to-reveal lens:

| Surface | Assumption | Validation method |
|---|---|---|
| Asset import | PNG → FileTexture works via specific API | Import one PNG, inspect resulting asset type |
| Component creation | Screen Image creates with correct anchor format | Create one, inspect ScreenTransform |
| Texture binding | Runtime script binds texture to Image's mainPass | One-line script, observe in preview |
| Tap detection | InteractionComponent.onTouchStart fires on bounds | Tap inside and outside test object, watch Logger |
| Tween creation | TweenScreenTransform with anchor type animates | Trigger from script, watch motion |
| Tween callback | onComplete fires reliably | Log from callback, measure timing jitter |
| Tween cancel | stopTween halts in-flight, original onComplete does NOT fire | Start, cancel mid-flight, watch Logger |
| Text swap | setProperty STRING re-renders Text component | Swap value, observe in preview |
| Delayed callback | DelayedCallbackEvent.cancel() actually halts | Schedule, cancel, verify callback doesn't fire |

Adjust the list per lens concept. Drag mechanics, face effects, audio triggers each have their own surface lists.

## Recording findings

Replace any `// VERIFY:` markers in TECH-SPEC.md with the empirical result. Include:

- API name as it actually exists (not as docs claim)
- Parameter format (especially for compound types like ScreenTransform anchors)
- Behavior notes (timing jitter, edge cases, gotchas)
- Anti-patterns discovered (what *didn't* work)

These findings often belong in the skill itself, not just the project. If a finding contradicts `lens-studio-api-gotchas.md`, update that file too.

## Common failure modes during validation

**API name doesn't exist.** Query `mcp__lens-studio__QueryLensStudioKnowledgeBase` for the correct name. Patch TECH-SPEC.md before generating any controller code.

**Behavior matches assumption but with timing jitter.** Record the observed jitter (e.g., "30–60 ms scheduling jitter on Tween onComplete"). Production code must tolerate this.

**Behavior depends on parent hierarchy.** Common with ScreenTransform anchors — `(0, -2.0)` is only off-screen if parent is full-screen. Re-test under the production hierarchy.

**Editor API works but runtime API doesn't (or vice versa).** Editor API and Lens API are separate. Validate against the API the production code will use, not whichever one is convenient for testing.

## Permissions and account validation

Some validations are about humans, not code. For Sponsored Lens projects, validate Snap Ad Account permissions early (Phase 1.5 timing, not Phase 5):

- Open LS Submit panel → start Sponsored Lens submission without finalizing
- Confirm Organization and Ad Account dropdowns show the target account
- If missing: contact client's media agency to be added to the Org

This blocks final submission, so catch it now. Slow-moving dependency (people, not code).

## Stop condition

Validation phase is complete when:

- Every API surface listed for production has been validated or explicitly deferred
- All `// VERIFY:` markers in TECH-SPEC.md are resolved
- Test scaffolding removed from scene
- Findings recorded in TECH-SPEC.md and (where general) `lens-studio-api-gotchas.md`

Only then proceed to Phase 2 script generation.
