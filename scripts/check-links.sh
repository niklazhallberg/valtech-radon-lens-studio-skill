#!/usr/bin/env bash
# check-links.sh — verify that backtick-quoted repo-relative paths in markdown
# resolve to real files. Exits non-zero on any miss.
#
# Scope:
#   - Walks all .md files in the repo (excluding vendored/external content).
#   - Extracts backtick-quoted tokens that look like repo paths.
#   - Skips wildcards, path patterns, ellipses, section-anchor citations, and
#     project-scoped files created inside client repos (allowlist below).
#   - Resolves candidate paths by: (a) relative to the containing .md file's
#     directory, (b) relative to repo root, (c) bare filename anywhere in repo.
#
# What this is NOT: a strict syntax linter. It targets the specific class of bug
# that motivated it — a file rename left the old path in prose across many files.
#
# Usage:
#   bash scripts/check-links.sh
#
# Exit codes:
#   0 — all references resolve (or are allowlisted / non-path-like)
#   1 — at least one broken reference found
#   2 — invocation error

set -u

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${REPO_ROOT}" || { echo "cannot cd to repo root"; exit 2; }

# Allowlist: per-client-project files that the skill scaffolds INSIDE client
# projects. These never exist at the skill-repo root and must not be flagged.
# Also: paths that refer to Lens Studio installations (not this repo), URI
# schemes, and prose fragments that happen to contain slashes.
ALLOWLIST=(
  # Per-client-project files scaffolded by agent
  "PROJECT-STATE.md"
  "PROJECT-PLAN.md"
  "TECH-SPEC.md"
  "USER-EXPERIENCE.md"
  "PROJECT-DECISIONS.md"
  "GRAPH-CAPABILITY-LEDGER.md"
  "vision-statement.md"
  "client-brief.md"
  "client-handover.md"
  "submission-checklist.md"
  "project-info/"
  "INSPIRATION/"
  "lens/"
  "brand-assets/"
  "brief/"
  # LS project structure (in the CLIENT's LS project, not the skill repo)
  "Assets/"
  "Packages/"
  "Support/"
  "Cache/"
  "BackUp/"
  "Workspaces/"
  "PluginsUserPreferences/"
  # LS URI schemes
  "assets://"
  "packages://"
  "project://"
  # Config files that live in client projects, not in the skill
  ".mcp.json"
  ".env"
  ".env.example"
  "package.json"
  # References to snap-docs's own INDEX file (checked relative to snap-docs/)
  "00-INDEX.md"
  ".mirror-meta.md"
  # Template filenames
  "CHANGELOG.template.md"
  "SKILL-DISCOVERIES.template.md"
  # Shell / prose fragments
  ".claude/skills/"
  "lens-studio-snapchat-filter/"
  # LS API property triples referenced in prose
  "aabbMin/aabbMax/aabbSize"
)

is_allowlisted() {
  local path="$1"
  for pattern in "${ALLOWLIST[@]}"; do
    [ "${path}" = "${pattern}" ] && return 0
    # Directory pattern — match if path starts with the pattern
    if [[ "${pattern}" == */ ]]; then
      [[ "${path}" == "${pattern}"* ]] && return 0
      [[ "${path}" == *"/${pattern}"* ]] && return 0
    fi
    # Match bare filename
    [[ "${path##*/}" == "${pattern}" ]] && return 0
    # LS URI scheme prefix
    if [[ "${pattern}" == *:// ]]; then
      [[ "${path}" == "${pattern}"* ]] && return 0
    fi
  done
  return 1
}

broken=0
checked=0
broken_paths=""

# Find all .md files, excluding .git, vendored external content, snap-docs
# mirror, and MIGRATION-REPORT.md (which quotes old paths as history)
while IFS= read -r -d '' md_file; do
  # Extract backtick-quoted tokens
  while IFS= read -r candidate; do
    # Trim whitespace
    candidate="${candidate#"${candidate%%[![:space:]]*}"}"
    candidate="${candidate%"${candidate##*[![:space:]]}"}"

    [ -z "${candidate}" ] && continue

    # Skip URLs and non-path constructs
    [[ "${candidate}" =~ ^https?:// ]] && continue
    [[ "${candidate}" =~ ^ftp:// ]] && continue
    [[ "${candidate}" =~ ^/ ]] && continue
    [[ "${candidate}" =~ ^~ ]] && continue
    [[ "${candidate}" =~ \  ]] && continue
    [[ "${candidate}" =~ = ]] && continue
    [[ "${candidate}" =~ \| ]] && continue
    [[ "${candidate}" =~ \; ]] && continue
    [[ "${candidate}" =~ § ]] && continue
    [[ "${candidate}" =~ \" ]] && continue

    # Skip wildcards and glob patterns
    [[ "${candidate}" =~ \* ]] && continue
    [[ "${candidate}" =~ \< ]] && continue
    [[ "${candidate}" =~ \> ]] && continue

    # Skip ellipses / placeholders
    [[ "${candidate}" =~ \.\.\. ]] && continue

    # Skip anything with line-number citations (path:linenum)
    [[ "${candidate}" =~ :[0-9] ]] && continue

    # Skip anything containing a port number colon
    [[ "${candidate}" =~ \[port\] ]] && continue

    # Skip external domain-style references (multi-part or single-part hostnames)
    [[ "${candidate}" =~ ^[a-z0-9-]+(\.[a-z0-9-]+)+/ ]] && continue
    # Skip single-quoted or paren-containing code fragments
    [[ "${candidate}" =~ \' ]] && continue
    [[ "${candidate}" =~ \( ]] && continue
    [[ "${candidate}" =~ \) ]] && continue
    # Skip code identifiers with underscores followed by digits (e.g. Module_101)
    [[ "${candidate}" =~ _[0-9]+ ]] && continue

    # Strip trailing punctuation
    path="${candidate}"
    path="${path%.}"
    path="${path%,}"
    path="${path%:}"
    path="${path%\)}"

    # Only check if it looks like a real path
    if [[ ! "${path}" =~ / ]] && [[ ! "${path}" =~ \.(md|sh|py|json|html|txt|yml|yaml)$ ]]; then
      continue
    fi

    # Skip organisation/repo references (GitHub owner/repo forms, not filesystem)
    if [[ "${path}" =~ ^[a-zA-Z][a-zA-Z0-9_-]+/[a-zA-Z][a-zA-Z0-9_-]+$ ]] && [[ ! "${path}" =~ \.[a-z]+$ ]]; then
      continue
    fi

    # Skip word-slash-word constructs that are prose ranges (From/To, start.x/y)
    if [[ "${path}" =~ ^[A-Za-z_.]+/[A-Za-z_.]+$ ]] && [[ ! "${path}" =~ \. ]]; then
      continue
    fi
    if [[ "${path}" =~ ^[A-Za-z_.]+\.[a-z]+/[A-Za-z_]+$ ]]; then
      # e.g. start.x/y, end.x/y
      continue
    fi

    is_allowlisted "${path}" && continue

    checked=$((checked+1))

    # Try (a) relative to md_file's directory, (b) relative to repo root
    md_dir="$(dirname "${md_file}")"
    if [ -e "${md_dir}/${path}" ] || [ -e "${REPO_ROOT}/${path}" ]; then
      continue
    fi

    # Try (c) bare filename anywhere in repo — handles prose shorthand
    # like "MANUAL-EN.html" when the file is actually at "docs/MANUAL-EN.html"
    basename_only="${path##*/}"
    if [ "${basename_only}" = "${path}" ]; then
      # It's just a filename, no slashes. Look for it anywhere.
      if find "${REPO_ROOT}" -type f -name "${basename_only}" \
           -not -path "*/.git/*" \
           -not -path "*/skills/radon-skill-growth/*" \
           2>/dev/null | grep -q .; then
        continue
      fi
    fi

    broken=$((broken+1))
    rel="${md_file#${REPO_ROOT}/}"
    broken_paths="${broken_paths}
BROKEN: ${rel} → ${path}"
  done < <(grep -oE '`[^`]+`' "${md_file}" 2>/dev/null | sed 's/^`//; s/`$//')
done < <(find "${REPO_ROOT}" -type f -name "*.md" \
  ! -path "${REPO_ROOT}/.git/*" \
  ! -path "${REPO_ROOT}/skills/radon-skill-growth/*" \
  ! -path "${REPO_ROOT}/references/snap-docs/*" \
  ! -path "${REPO_ROOT}/MIGRATION-REPORT.md" \
  ! -path "${REPO_ROOT}/CHANGELOG.md" \
  ! -path "${REPO_ROOT}/references/skill-growth-protocol.superseded.md" \
  -print0)

if [ "${broken}" -eq 0 ]; then
  echo "Checked ${checked} path-like references."
  echo "✓ All repo-relative markdown paths resolve."
  exit 0
else
  echo "${broken_paths}"
  echo ""
  echo "Checked ${checked} path-like references."
  echo "✗ ${broken} broken reference(s) found."
  exit 1
fi
