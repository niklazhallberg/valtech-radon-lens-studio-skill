#!/usr/bin/env python3
"""
equip_skill.py — equip a domain skill with the shared radon-skill-growth v1.0 protocol.

What it does (idempotent, knowledge-safe):
  1. Writes references/_growth-protocol-pointer.md  (the thin pointer to this shared skill)
  2. Copies CHANGELOG.md + SKILL-DISCOVERIES.md from assets/  ONLY if they don't exist
  3. Copies session-sync-hook.sh into the skill's scripts/
  4. If an old skill-growth-protocol.md exists, renames it to *.superseded.md and leaves
     a one-line note — it NEVER deletes it (you keep the history)

What it NEVER does:
  - Overwrite an existing CHANGELOG.md or any references/ entry
  - Touch the knowledge: gotchas, entries, consolidation history stay put
  - Auto-wire your global session hook (it prints the line to add; you decide)

Usage:
  python3 equip_skill.py /path/to/domain-skill
  python3 equip_skill.py /path/to/domain-skill --dry-run
"""
import argparse
import shutil
import sys
from datetime import date
from pathlib import Path

SHARED_SKILL = Path(__file__).resolve().parent.parent  # radon-skill-growth/
ASSETS = SHARED_SKILL / "assets"

POINTER = """# Growth protocol — pointer

This skill follows the shared **radon-skill-growth v1.0** protocol. The full mechanic
(trigger check, generalization rule, pre-ask filters, source confidence, in-flow ask,
consolidation, entry format) lives in that skill's `references/`. Do not duplicate it here.

This file exists so an agent grepping *this* skill's references finds the pointer and
loads the shared protocol. Everything domain-specific — worked examples, this domain's
trigger list, this domain's gotchas — stays in this skill's own `references/*.md` and
`CHANGELOG.md`.

Candidates for "save for later" → `SKILL-DISCOVERIES.md` at repo root.
"""


def log(msg, dry):
    print(f"{'[dry-run] ' if dry else ''}{msg}")


def equip(skill_path: Path, dry: bool) -> int:
    if not skill_path.is_dir():
        print(f"error: {skill_path} is not a directory", file=sys.stderr)
        return 1
    if not (skill_path / "SKILL.md").exists():
        print(f"warning: {skill_path}/SKILL.md not found — is this a skill?", file=sys.stderr)

    refs = skill_path / "references"
    scripts = skill_path / "scripts"
    for d in (refs, scripts):
        if not d.exists():
            log(f"mkdir {d}", dry)
            if not dry:
                d.mkdir(parents=True, exist_ok=True)

    # 1. Pointer (overwrite is safe — it carries no knowledge)
    pointer_path = refs / "_growth-protocol-pointer.md"
    log(f"write {pointer_path}", dry)
    if not dry:
        pointer_path.write_text(POINTER, encoding="utf-8")

    # 2. Templates — only if absent (NEVER clobber knowledge)
    for tmpl, dest_name in (
        ("CHANGELOG.template.md", "CHANGELOG.md"),
        ("SKILL-DISCOVERIES.template.md", "SKILL-DISCOVERIES.md"),
    ):
        dest = skill_path / dest_name
        if dest.exists():
            log(f"skip {dest_name} (already exists — knowledge preserved)", dry)
        else:
            log(f"copy {tmpl} -> {dest}", dry)
            if not dry:
                shutil.copy2(ASSETS / tmpl, dest)

    # 3. Hook
    hook_dest = scripts / "session-sync-hook.sh"
    log(f"copy session-sync-hook.sh -> {hook_dest}", dry)
    if not dry:
        shutil.copy2(ASSETS / "session-sync-hook.sh", hook_dest)
        hook_dest.chmod(0o755)

    # 4. Supersede an old local protocol copy (rename, never delete)
    for old in list(refs.glob("*growth-protocol*.md")):
        if old.name in ("_growth-protocol-pointer.md",):
            continue
        superseded = old.with_suffix(".superseded.md")
        log(f"rename {old.name} -> {superseded.name} (migration; nothing lost)", dry)
        if not dry:
            old.rename(superseded)

    print()
    print(f"{'[dry-run] would equip' if dry else 'Equipped'}: {skill_path.name}")
    print("Next: add this line to your session-start hook to enable periodic consolidation flagging:")
    print(f'  bash "{scripts / "session-sync-hook.sh"}" "{skill_path / "CHANGELOG.md"}"')
    print(f"(equipped {date.today().isoformat()})")
    return 0


def main():
    ap = argparse.ArgumentParser(description="Equip a domain skill with radon-skill-growth v1.0.")
    ap.add_argument("skill_path", type=Path, help="Path to the domain skill directory")
    ap.add_argument("--dry-run", action="store_true", help="Show actions without writing")
    args = ap.parse_args()
    sys.exit(equip(args.skill_path.resolve(), args.dry_run))


if __name__ == "__main__":
    main()
