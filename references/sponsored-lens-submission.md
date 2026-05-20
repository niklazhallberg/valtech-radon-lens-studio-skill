# Sponsored Lens Submission — Snap Ads Manager Compliance

Mandatory requirements, performance gates, and recurring rejection patterns for Sponsored Lenses submitted via Snap Ads Manager. Sourced from official Snap policy docs (`businesshelp.snapchat.com`, `developers.snap.com`) and community-corroborated patterns (compiled 2026-05-20).

> **Why this file matters**: A Sponsored Lens that fails review at the Ads Manager stage costs days of delay and can blow campaign deadlines. Many rejections come from rules that are documented but scattered across multiple Snap policy pages. This file consolidates the rejection-grade rules so the agent can pre-flight a Sponsored Lens spec **before** Phase 5 submission.

## Contents

- Mandatory requirements (rejection-grade)
- Performance gates (will fail submission)
- Common rejection patterns (community-corroborated)
- Safe zones — no published numeric spec
- Source priorities

---

## Mandatory requirements (rejection-grade)

### Brand name or logo MUST be visible in the lens

**Rule**: All Sponsored Lenses must display a brand name or brand logo and conform to Snap's Ad Policies. Lenses without visible brand attribution are rejected in Ads Manager.

**Common violation**: Branded effect with no logo or brand-name surface inside the lens. Organic creator lens repurposed as an ad without retroactive branding.

**Source**: "All sponsored Lenses must display a brand name or brand logo and conform to Snap's Ad Policies. Otherwise, the Lens will be rejected in Ads Manager when it is used in an advertising campaign." — official Snap Submission Guidelines (legacy page, still cited authoritatively).

**Apply when**: any client brief that flags "Sponsored Lens" or "Snap Ads Manager campaign" — must have a discoverable place for the brand mark in the UX spec.

---

### Third-party IP requires explicit license

**Rule**: You must have rights to all trademarks, logos, characters, and IP shown in the lens. Snap's Advertising Policies prohibit unauthorised use of third-party IP.

**Common violation**: Lens contains Nike/Apple/Disney logos, sports-team emblems, or recognised characters without license. "Parody" lenses where the original logo is still clearly recognisable.

**Source**: Snap's official Ad Policies + Intellectual Property sections on `businesshelp.snapchat.com`. No lens-specific IP whitepaper exists; the pattern shows up consistently in community rejection threads tagged 'copyright' / 'logo'.

**Apply when**: client brief mentions any brand, character, or property that isn't the client's own — verify written license exists before Phase 1.

---

### Music must be original, licensed, or from Snap's library

**Rule**: Only music/audio with proper rights, or audio provided via Snap's own asset library, may be used in Sponsored Lenses. Content must follow Snap's Music & Content Policies.

**Common violation**: Drop a commercial track into an Audio Track without license. Re-use audio from TikTok/YouTube in a sponsored lens.

**Source**: Ads creative guidelines + general "copyrighted content" policies on `businesshelp.snapchat.com`. No separate lens-specific music-license number list — but the policy is unambiguous that unauthorised copyrighted material is forbidden.

**Apply when**: brief includes any audio. Verify license document or use only Snap-library tracks.

---

### Bitmoji avatars are NOT permitted in Sponsored Lenses

**Rule**: Snap's official Bitmoji 3D documentation states: *"Bitmoji avatars cannot be used for commercial purposes, including Ads."*

**Common violation**: Brand brief assumes "let's make it personal by using the user's own Bitmoji" — looks like a Snap-native idea, but Bitmoji is reserved for organic / community lenses only. Brand teams often confuse Snap's own marketing (which showcases Bitmoji) with what's available for paid campaigns.

**Source**: https://developers.snap.com/lens-studio/features/bitmoji-avatar/bitmoji-3d (Bitmoji 3D page, accessed 2026-05-20)

**Re-scoping options the agent can offer**:
- Brand-owned stylised character with "Bitmoji vibe" but original IP
- Face Mesh / Face Effects to drive a branded character via user's expressions
- GenAI Suite / Face Generator for a personalised but non-Bitmoji avatar
- Reserve the Bitmoji concept for organic distribution outside the paid campaign

**Apply when**: ANY Sponsored Lens brief that mentions Bitmoji, personalised avatar, user's avatar, friend's avatar, or "show me as a character". Push back at Phase 0 — not at Phase 5 rejection.

See `bitmoji-integration.md` for full Bitmoji API details (for organic-lens use).

---

### Lens Cloud features are NOT permitted in Sponsored Lenses

**Rule**: Lens Cloud features (Multi-User Services, Remote Storage, etc.) cannot be used in Sponsored Lenses. Lenses depending on them will be rejected or required to remove the cloud-dependent functionality before campaign.

**Common violation**: Sponsored Lens that uses Multi-User Services for shared experiences, or Remote Storage for cross-session state.

**Source**: "Currently, Lens Cloud Features cannot be used in Sponsored Lenses." — Snap docs (last explicit statement on LS 4.55.1; marked [STALE] but still the most recent published guidance, and Snap has not retracted the policy).

**Apply when**: any brief that wants persistent state, multi-player, or shared experiences in a Sponsored Lens. Push back on this constraint at Phase 0 — don't let it become a Phase 5 rejection.

---

### Digital goods rules (if monetised)

**Rule**: Lenses with digital goods have specific policy restrictions; non-compliance results in rejection or removal.

Specific limits:
- **Max 20 digital goods per lens.**
- **Submission limit: 10 unique lenses with digital goods per week / 40 per month** (per developer account).
- **No auto-triggering the purchase tray** — must require explicit unlock interaction from the user.
- **No fully-gated content** — user must see *some* part of the lens before being asked to purchase.
- **No vague digital-good names** like "Extra Stuff" — must be clearly described.

**Source**: Snap digital-goods policy: "Non-compliance will result in Lens rejection or removal of the Lens from Snapchat… There is a maximum of 20 digital goods that can be added to a Lens… submission limit of 10 unique Lenses with digital goods per week / 40 per month… You are not permitted to auto-trigger the purchase tray without an explicit unlock interaction by the user."

**Apply when**: brief mentions monetisation, IAP, premium content, or "unlock" mechanics.

---

### Touch-blocking for tap-input lenses

**Rule**: Sponsored Lenses that rely on tap input must block Snap's default double-tap camera-flip and similar system gestures, or interaction will be intermittent and Snap review will catch it as inconsistent UX.

**How**: bind `OnStartEvent` and set `global.touchSystem.touchBlocking = true`. See `lens-studio-api-gotchas.md` → "Sponsored Lens compliance — touch-blocking" for the canonical recipe.

**Source**: Empirically validated on Valtech RFSU Sponsored Lens build, 2026-05; consistent with Snap's general "lens must not impair user's ability to use Snapchat" principle.

**Apply when**: ANY Sponsored Lens with tap interaction.

---

## Performance gates (will fail submission)

These are Snap's officially-published numeric limits. Failing any of them results in automatic rejection or campaign blocking.

### Lens Activation Time (LAT) — under 650 ms

**Rule**: To run a Lens as an ad on Snapchat, your Lens must have a Lens Activation Time under 650 ms, as measured on Snap's benchmark device.

**Source (direct quote)**: "To run a Lens as an ad on Snapchat, your Lens must have a Lens Activation Time under 650 ms, as measured on our benchmark device." — Snap Performance and Optimization guide.

**Device tier**: Snap's benchmark device — no separate per-tier number is published.

**How to measure**: Lens Performance Toolkit inside Lens Studio shows LAT as one of its 4 dashboard metrics (Size, Activation Time, FPT, Memory).

**Apply when**: every Sponsored Lens before submission. Phase 4 DoD MUST include a LAT measurement.

---

### Lens size — 8 MB hard, <4 MB for Sponsored, 2 MB ideal

**Rule**:
- **8 MB** is the absolute submission cap.
- **<4 MB** is the explicit Snap recommendation for Sponsored Lenses (for "optimal performance across the widest array of devices").
- **2 MB** is the ideal target for fast download.

**Source (direct quote)**: "The size limit for a submitted Lens is 8 mb but we advise staying at 2 mb or less for a quicker download… If you are working on building Sponsored Lenses, please make sure your lens is less than 4MB to ensure the most optimal performance across the widest array of devices." — Snap Performance and Optimization guide.

**Apply when**: every project. The skill's default performance budget in `SKILL.md` aligns: target ≤4 MB, hard limit 8 MB.

---

### RAM ceiling — 150 MB

**Rule**: Lenses should not exceed 150 MB RAM.

**Source (direct quote)**: "Lenses should not exceed 150 MB RAM." — Snap Performance and Optimization guide.

**Our internal budget is tighter** (80 MB target, 100 MB standard hard limit per `SKILL.md`) — that's a Valtech production-quality choice, not a Snap requirement. The 150 MB number is the publish-gating ceiling.

---

### Frame rate — 30 FPS target, >15 FPS minimum

**Rule**: Target 30 FPS; ensure >15 FPS on most devices.

**Source (direct quote)**: "You should target 30 FPS for your Lens for the best viewing experience, but ensure that it is greater than 15 FPS on most devices." — Snap Performance and Optimization guide.

**Our internal budget is stricter** (≥30 target, ≥25 hard limit per `SKILL.md`) — again a quality choice. The Snap-published absolute floor is 15.

---

### What Snap does NOT publish

- Draw call caps (none published)
- Polygon / triangle budgets (none published — qualitative guidance only)
- Per-asset size limits (no texture/mesh/audio caps; only total lens-size cap)
- Per-platform / per-device-tier RAM splits (only the global 150 MB)
- Maximum texture pixel dimensions (only POT-recommendation, no hard cap)
- Per-script execution time caps (only total LAT/FPT as composite indicator)

**When a brief asks for guidance on these**: lean on the 3D-asset-import-doctrine + Lens Performance Toolkit measurements rather than citing non-existent Snap limits.

---

## Common rejection patterns (community-corroborated)

These are NOT in official policy text but recur in community rejection reports. Lower confidence than the rules above — flag in spec review but don't treat as automatic rejection.

### Over-branding / "ad density"

**Pattern**: Lenses where the logo or CTA covers most of the screen often get reduced distribution or review feedback to reduce branding, even when not formally rejected.

**Mitigation**: Brand-mark sized to be visible but not dominant. CTAs that don't occupy >30% of screen real estate.

**Source**: Community rejection threads ("my lens got limited reach", "review suggested I reduce branding"). No official quantification.

---

### Preview video must match the actual lens

**Pattern**: Lenses rejected or required to revise when the preview video used in Ads Manager shows different content from the published lens (different music, claims, or behaviour).

**Mitigation**: Re-record preview video from the final lens build, not from a mid-process WIP. Audit preview matches lens behaviour 1:1.

**Source**: Snap Submission Guidelines explicitly apply to preview videos. Community confirms recurring rejection on this.

---

### Watermarks / handles from competing platforms

**Pattern**: Persistent TikTok / IG / YouTube watermarks or handles overlaid in a Sponsored Lens can trigger rejection or campaign block.

**Mitigation**: No third-party platform branding visible in the lens, even as "follow us on" CTAs.

**Source**: Snap creative guidelines for video ads note that ads with prominent competing-platform watermarks may be rejected; same policy applies to Lens previews and Sponsored Lenses.

---

### NSFW / restricted-category content

**Rule**: Lenses must not contain nudity, sexual content, explicit drug use, hate, harassment, or other content prohibited by Snap's Community Guidelines and Advertising Policies.

**Common violation**: Face lens that simulates drug use (joint, lines, pills) in a sponsored campaign. "Beauty filter" that crosses into cosmetic-surgery / "before-after surgical" territory in a marketing context.

**Source**: Snap Community Guidelines + Political/Issue Ad Guidelines. Sponsored Lenses are subject to all ad policies.

**Apply when**: brief is in a restricted category (Sexual Wellness, Alcohol, Gambling, Pharmaceutical — see `SKILL.md` Domain context for the four Snap reviews on US-conservative standards regardless of campaign region).

---

## Safe zones — no published numeric spec

**Status**: No lens-specific safe-zone pixel/percentage spec is published by Snap. Equivalent thinking exists in Snap's Story Ad specs ("Single Image or Video ad Creative Guidelines"); reviewers apply that mindset to Lens UI when reviewing.

**Practical guidance**:
- Don't place CTAs or critical text in the bottom 25% of the 9:16 frame (overlaps Snap's capture button + chat fields on many devices).
- Don't place critical content in the top 10% (notification / status bar territory on some devices).
- Test on at least one iPhone with notch + one Android with rounded corners.

**Source**: Community-derived from Snap's Story Ad specs; no official lens-safe-zone documentation. "No public numeric limit" for lens-specific safe zones.

---

## Source priorities

When the agent needs to verify a submission rule, check in this order:

1. **Snap official docs** — `developers.snap.com/lens-studio/`, `businesshelp.snapchat.com`
2. **Snap Ads Manager creative guidelines** — `ads.snapchat.com` policy pages
3. **This file** — consolidated rules, source-cited per entry
4. **Snap community forum** — `community.snap.com/lensstudio/` for rejection patterns
5. **Empirical Valtech project record** — what reviewers have actually told us in past builds

Treat the live Snap docs as authoritative. If this file conflicts with current live Snap policy, update this file and flag the change.

---

## Adding new findings

When a Valtech Sponsored Lens project receives reviewer feedback (rejection comment, change request, or approval-with-condition), capture it here:

1. **Pattern** — one sentence
2. **What the reviewer actually said** — verbatim if possible
3. **Project context** — client, lens type, submission date
4. **How it was resolved** — fix that got the lens approved
5. **Generalisation** — when does this rule kick in for other projects?

Reviewer feedback is the highest-value data we can collect — it's not published anywhere else and goes directly into Snap's actual review behaviour.
