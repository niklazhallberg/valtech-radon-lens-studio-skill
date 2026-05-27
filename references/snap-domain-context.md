# Snap domain context — terminology, ad-policy, gates

Snapchat-specific terminology and constraints worth knowing explicitly. These shape what's possible in a lens, what gets rejected at submission, and how to plan for review.

---

## Lens type terminology

- **Sponsored Lens** = paid AR ad on Snapchat, distributed via Snap Ads Manager. Always 18+ ad-gated for regulated categories.
- **Community Lens** = organic-shared lens published to public lens marketplace. Build phases of this skill apply (Phase 0–4); submission flow differs (see `references/sponsored-lens-submission.md` for the Sponsored side).
- **AR Object / Spectacles experiences** = different toolset, NOT this skill's scope.
- **Snapchat Filters** that aren't Lens Studio = legacy 2D photo filters, NOT this skill's scope.

---

## Ad-policy categories with stricter review

- **Sexual Wellness** (condoms, lubricants, sex tech) — Nordic-friendly briefs land in Snap's US-conservative review pipeline regardless of campaign region
- **Alcohol**
- **Gambling**
- **Pharmaceutical**

Snap reviews on US content standards regardless of campaign region. Nordic projects in these categories must clear US-conservative content guidelines.

---

## Ad-review SLA

- **General categories**: 1–3 business days
- **Regulated categories or rejected resubmissions**: 1–2 weeks

Plan timelines accordingly. A "we're shipping next Tuesday" brief in a regulated category needs to clear submission today, not at Phase 5.

---

## Performance review standard

Snap reviews lenses on **mid-range Android**, NOT high-end iPhone. Desktop preview is misleading and over-optimistic. The Lens Performance Toolkit is the source of truth for what Snap's reviewers measure.

See `references/performance-optimization-guide.md` for the per-asset numeric budgets and `references/sponsored-lens-submission.md` for the gates that block publication.

---

## Lens Activation Time (LAT) hard gate

Sponsored Lenses **must** activate in under **650 ms** on Snap's benchmark device — measured by the Lens Performance Toolkit. **This is the most commonly missed publish gate.**

Plan LAT optimization from Phase 0, not Phase 5. See `references/sponsored-lens-submission.md` for the full LAT budget breakdown (load-time texture compression, asset preload strategy, script init timing).

---

## Lens Cloud restrictions in Sponsored Lenses

**Lens Cloud features (Multi-User Services, Remote Storage) are NOT allowed in Sponsored Lenses.** Push back on any brief that depends on:
- persistent state
- multi-player / shared experiences
- cross-session memory

…for a paid campaign. Re-scope at Phase 0, not at Phase 5 rejection.

Affected templates / features: `Scan` template (uses Lens Cloud backend), `Realtime Store` template (Connected Lenses), Connected Lenses Module in general.

---

## Bitmoji in Sponsored Lenses — banned

**Bitmoji avatars are NOT allowed in Sponsored Lenses.** Snap's explicit rule: "Bitmoji avatars cannot be used for commercial purposes, including Ads."

For brand briefs that want a "personalised character", re-scope to:
- a brand-owned stylised avatar (the brand provides the character design)
- a Face Mesh-driven branded character (the user's face becomes the character via Face Mesh + branded materials)

See `references/bitmoji-integration.md` and `references/sponsored-lens-submission.md`.

---

## Brand mark required in Sponsored

Every Sponsored Lens must surface the client's brand name or logo somewhere in the experience, or Ads Manager will reject. Plan the brand-mark placement during Phase 0 UX spec — not as an afterthought.

Acceptable placements: persistent logo in a corner, brand watermark on captured content, brand text in the call-to-action, branded packaging (e.g., a labeled product) visible throughout the experience.

---

## Cross-references

- Submission gates + rejection patterns: `references/sponsored-lens-submission.md`
- Performance optimization mechanics: `references/performance-optimization-guide.md`
- Bitmoji integration (for organic lenses): `references/bitmoji-integration.md`
- Capability tiers (what's possible at all): `references/capability-tiers.md`
