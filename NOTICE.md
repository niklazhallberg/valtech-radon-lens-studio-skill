# NOTICE — Internal-use notice

This repository is **Valtech RADON internal material.**

**This notice is not legal advice.** For binding terms, refer to your Valtech
employment agreement, contractor agreement, and any applicable client
engagement contracts.

## Authorised use

Authorised Valtech personnel and approved contractors may use this material,
**subject to** their obligations under:

- Client confidentiality agreements (NDAs)
- Information security policies
- Intellectual property agreements
- Data protection law (GDPR and equivalents)
- Any applicable client-engagement contract terms

If you are unsure whether you are authorised, ask your Valtech line manager
or the RADON team lead **before** using this material for a client project.

## What must NOT be added to this repository

Because this repository is **public**, the following categories of information
must never appear anywhere in it — not in commits, not in issues, not in PR
descriptions, not in comments:

- **Client confidential information** — client names in concrete commercial
  contexts, brief details, campaign budgets, delivery dates, unreleased brand
  assets, non-public strategy.
- **Personal data** — names, contact details, or other identifying information
  of client staff, end users, or other individuals.
- **Credentials** — API keys, tokens, passwords, session cookies, private keys,
  MCP bearer tokens, GitHub PATs, or any other secret material.
- **Unapproved third-party materials** — code, images, fonts, or other assets
  covered by licences that have not been explicitly approved by Valtech for
  redistribution.
- **Sales / commercial material** — pricing, proposals, contract drafts,
  internal Valtech commercial planning.

If any of the above is committed by mistake, treat it as an incident:

1. Stop and do not push further commits.
2. Notify the RADON team lead and information-security contact.
3. Do not attempt to "clean up" via force-push without guidance — public git
   history is copied by mirrors within seconds.

## Growth protocol safeguards

The skill's growth protocol enforces a **Generalization rule** before any new
learning is committed: client names, exact tuning values, project-specific
paths, dates, and personal data are stripped, leaving only the generalised
technical pattern. Human PR review is a second layer of defence.

See `docs/SECURITY-AND-PRIVACY.md` for the full mechanism.

## Formal licence

For copyright and licensing, see `LICENSE` at the repository root.
