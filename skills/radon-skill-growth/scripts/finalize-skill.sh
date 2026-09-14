#!/usr/bin/env bash
#
# finalize-skill.sh — take a freshly created skill and wire it into the architecture.
#
# Run this AFTER skill-creator has built the skill. It does the 5 steps that turn a
# raw skill folder into a backed-up, globally-visible, self-learning skill:
#   1. Move the skill into ~/Projects/ if it isn't there yet (enforces "born in Projects")
#   2. git init + first commit (if not already a repo)
#   3. Symlink into ~/.claude/skills/ so Claude Code sees it everywhere
#   4. Run equip_skill.py (dry-run first, then real) to inject the radon-skill-growth pointer
#   5. Print the gh repo create + push commands for you to run
#
# SAFE: dry-run preview before equip, asks before each non-trivial step, never deletes,
# never force-pushes, never overwrites an existing repo or symlink.
#
# Usage:
#   bash finalize-skill.sh <path-to-skill>
#   e.g. bash finalize-skill.sh ~/.claude/skills/houdini-skill
#        bash finalize-skill.sh ~/Projects/houdini-skill

set -euo pipefail

PROJECTS="$HOME/Projects"
SKILLS="$HOME/.claude/skills"
GROWTH="$PROJECTS/radon-skill-growth/scripts/equip_skill.py"

SRC="${1:-}"
if [ -z "$SRC" ]; then
  echo "Usage: bash finalize-skill.sh <path-to-skill>"
  exit 1
fi
SRC="${SRC%/}"  # strip trailing slash

ask() { read -r -p "$1 [y/N] " a; [ "$a" = "y" ] || [ "$a" = "Y" ]; }

# Resolve the skill name and decide whether it must move.
NAME="$(basename "$SRC")"
DEST="$PROJECTS/$NAME"

echo "=== finalize-skill: $NAME ==="

# --- Step 1: ensure it lives in ~/Projects/ -------------------------------------
if [ -L "$SRC" ]; then
  echo "Source is a symlink — resolving to its real location."
  SRC="$(readlink "$SRC")"
  SRC="${SRC%/}"
  NAME="$(basename "$SRC")"
  DEST="$PROJECTS/$NAME"
fi

case "$SRC" in
  "$PROJECTS"/*)
    echo "1. Already in ~/Projects/ — good. ✅"
    ;;
  *)
    echo "1. Skill is at: $SRC"
    echo "   It should live in ~/Projects/ (the 'born in Projects' rule)."
    if [ -e "$DEST" ]; then
      echo "   ERROR: $DEST already exists. Resolve manually, then re-run."
      exit 1
    fi
    if ask "   Move it to $DEST?"; then
      mv "$SRC" "$DEST"
      echo "   Moved → $DEST"
      SRC="$DEST"
    else
      echo "   Skipped move. Stopping — the rest assumes it's in ~/Projects/."
      exit 0
    fi
    ;;
esac

# --- Step 2: git init + first commit --------------------------------------------
if [ -d "$SRC/.git" ]; then
  echo "2. Already a git repo. ✅"
else
  if ask "2. git init + first commit here?"; then
    git -C "$SRC" init -q
    git -C "$SRC" add .
    git -C "$SRC" commit -q -m "feat: initial $NAME (via skill-creator)"
    echo "   Committed."
  else
    echo "   Skipped git. (Not recommended for a skill — it's your USP.)"
  fi
fi

# --- Step 3: symlink into ~/.claude/skills/ -------------------------------------
LINK="$SKILLS/$NAME"
if [ -L "$LINK" ]; then
  echo "3. Symlink already exists → $(readlink "$LINK") ✅"
elif [ -e "$LINK" ]; then
  echo "3. WARNING: $LINK exists but is NOT a symlink. Resolve manually."
else
  ln -s "$SRC" "$LINK"
  echo "3. Symlinked: $LINK → $SRC ✅"
fi

# --- Step 4: equip with radon-skill-growth --------------------------------------
if [ ! -f "$GROWTH" ]; then
  echo "4. SKIP — equip_skill.py not found at $GROWTH"
  echo "   (Is radon-skill-growth in ~/Projects/? Equip manually later.)"
else
  echo "4. Equipping with radon-skill-growth (dry-run first)…"
  python3 "$GROWTH" "$SRC" --dry-run
  echo ""
  if ask "   Apply the equip for real?"; then
    python3 "$GROWTH" "$SRC"
    git -C "$SRC" add . 2>/dev/null || true
    if ask "   Commit the equip changes?"; then
      git -C "$SRC" commit -q -m "feat: adopt shared radon-skill-growth v1.0" || echo "   (nothing to commit)"
    fi
  else
    echo "   Skipped equip. Run it yourself when ready."
  fi
fi

# --- Step 5: print backup commands ----------------------------------------------
echo ""
echo "5. Backup to GitHub — run these yourself (private repo on your account):"
echo "   gh repo create niklazhallberg/$NAME --private --source=$SRC --remote=origin"
echo "   git -C $SRC push -u origin main"
echo ""
echo "   Watch for files >100MB (3D, renders, .c4d/.obj). If present, gitignore them BEFORE pushing."
echo ""
echo "=== Done. $NAME is in Projects, symlinked, equipped. Push to finish backup. ==="
