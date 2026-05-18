#!/usr/bin/env bash
# install.sh — sätter upp lens-studio-snapchat-filter på din dator.
# Tänkt för icke-tekniska designers. Kör en gång efter att du klonat repot.
# Idempotent: säkert att köra om — varje steg kollar om det redan är klart.

set -u

# Färgkoder om terminalen stödjer det (graceful fallback)
if [ -t 1 ] && command -v tput >/dev/null 2>&1; then
  GREEN=$(tput setaf 2); RED=$(tput setaf 1); YELLOW=$(tput setaf 3)
  BOLD=$(tput bold);     RESET=$(tput sgr0)
else
  GREEN=""; RED=""; YELLOW=""; BOLD=""; RESET=""
fi

# Mentor-tone helpers
header() { echo ""; echo "${BOLD}$1${RESET}"; }
say()    { echo "  $1"; }
ok()     { echo "  ${GREEN}✅${RESET} $1"; }
skip()   { echo "  ${YELLOW}↷${RESET}  $1"; }
fail()   {
  echo ""
  echo "  ${RED}❌${RESET} $1"
  if [ -n "${2:-}" ]; then
    echo ""
    echo "  ${YELLOW}Så här gör du:${RESET}"
    while IFS= read -r line; do echo "  $line"; done <<< "$2"
  fi
  echo ""
  exit 1
}

# ─── Welcome ─────────────────────────────────────────────────────────
echo ""
echo "${BOLD}Lens Studio-skill — installation${RESET}"
echo ""
echo "Hej! Det här scriptet sätter upp Lens Studio-skillen på din dator."
echo "Inget tas bort — det här lägger bara till saker."
echo ""
echo "Tar typ 2-3 minuter. Säg till på Slack om något känns konstigt."
echo ""

# ─── 1. macOS check ──────────────────────────────────────────────────
header "1. Kollar att du är på macOS"
if [ "$(uname -s)" = "Darwin" ]; then
  ok "macOS hittat — vi kan fortsätta"
else
  fail "Det här scriptet är just nu byggt för macOS." \
"Vi har inte hunnit testa på Windows eller Linux än.
Säg till maintainer på Slack om du behöver Windows-stöd."
fi

# ─── 2. Pre-reqs ─────────────────────────────────────────────────────
header "2. Kollar att du har Node.js och git"
if command -v node >/dev/null 2>&1; then
  ok "Node.js hittat ($(node --version))"
else
  fail "Node.js saknas på din dator." \
"Node.js är programmet vi behöver för att köra Claude Code.

1. Ladda ner Node.js: https://nodejs.org/download (välj LTS-versionen)
2. Installera (klicka dig igenom)
3. Stäng terminalen
4. Öppna en ny terminal och kör install.sh igen"
fi

if command -v git >/dev/null 2>&1; then
  ok "git hittat ($(git --version | awk '{print $3}'))"
else
  fail "git saknas på din dator." \
"git är verktyget vi använder för att hämta uppdateringar.

1. Öppna terminalen
2. Skriv: xcode-select --install
3. Klicka 'Install' i popupen som dyker upp
4. Vänta tills det är klart (några minuter)
5. Kör install.sh igen"
fi

# ─── 3. Claude Code ─────────────────────────────────────────────────
header "3. Installerar Claude Code (eller bekräftar att det redan finns)"
if command -v claude >/dev/null 2>&1; then
  ok "Claude Code redan installerat ($(claude --version 2>/dev/null | head -1))"
else
  say "Installerar via npm... (kan ta upp till 1 minut)"
  if npm install -g @anthropic-ai/claude-code >/tmp/claude-install.log 2>&1; then
    ok "Claude Code installerat"
  else
    fail "Installationen av Claude Code misslyckades." \
"Vanligaste orsaken är att npm behöver sudo-rättigheter.

Försök detta i terminalen:

  sudo npm install -g @anthropic-ai/claude-code

Om det inte heller funkar, kolla loggen:
  cat /tmp/claude-install.log

Kör sen install.sh igen."
  fi
fi

# ─── 4. Lens Studio ─────────────────────────────────────────────────
header "4. Kollar att Lens Studio är installerat"
if [ -d "/Applications/Lens Studio.app" ]; then
  ok "Lens Studio hittat"
else
  fail "Lens Studio saknas i din /Applications-mapp." \
"Lens Studio är Snaps utvecklingsmiljö där vi bygger filtren.

1. Ladda ner: https://ar.snap.com/download
2. Öppna .dmg-filen som laddas ner
3. Dra Lens Studio till Applications-mappen
4. Öppna Lens Studio en gång så det aktiverar sig
5. Stäng det
6. Kör install.sh igen"
fi

# ─── 5. Skill clone check ───────────────────────────────────────────
header "5. Kollar att skill-mappen finns på din dator"
SKILL_DIR="${HOME}/.claude/skills/lens-studio-snapchat-filter"
if [ -d "${SKILL_DIR}/.git" ]; then
  ok "Skillen finns på din dator (${SKILL_DIR})"
else
  fail "Skillen är inte klonad än." \
"Innan vi kan fortsätta behöver du klona skill-repot manuellt.
Vi gör det manuellt eftersom GitHub-inloggning är personlig.

1. Skicka ditt GitHub-användarnamn till maintainer på Slack
2. Du får en inbjudan via mail — acceptera den
3. Öppna terminalen och kör:

   git clone git@github.com:niklazhallberg/valtech-radon-lens-studio-skill.git ${SKILL_DIR}

   (Om SSH inte funkar, använd https-versionen:
    git clone https://github.com/niklazhallberg/valtech-radon-lens-studio-skill.git ${SKILL_DIR})

4. Kör install.sh igen — den fortsätter där den slutade"
fi

# ─── 6. Configure SessionStart hook ─────────────────────────────────
header "6. Aktiverar auto-sync (skillen håller sig uppdaterad automatiskt)"
HOOK_PATH="${SKILL_DIR}/scripts/session-sync.sh"
SETTINGS_FILE="${HOME}/.claude/settings.json"

if [ ! -f "${HOOK_PATH}" ]; then
  fail "Hook-scriptet hittas inte på rätt plats." \
"Förväntad sökväg: ${HOOK_PATH}

Det betyder att skill-mappen är ofullständig.
Kör:
  cd ${SKILL_DIR} && git pull

Kör sen install.sh igen."
fi

chmod +x "${HOOK_PATH}" 2>/dev/null
mkdir -p "$(dirname "${SETTINGS_FILE}")" 2>/dev/null

RESULT=$(python3 - "${SETTINGS_FILE}" "${HOOK_PATH}" <<'PYEOF'
import json, os, sys
settings_path, hook_cmd = sys.argv[1], sys.argv[2]
try:
    if os.path.exists(settings_path):
        with open(settings_path) as f:
            settings = json.load(f)
    else:
        settings = {}
    settings.setdefault("hooks", {}).setdefault("SessionStart", [])
    already = any(
        h.get("command") == hook_cmd
        for entry in settings["hooks"]["SessionStart"]
        for h in entry.get("hooks", [])
    )
    if already:
        print("ALREADY")
    else:
        settings["hooks"]["SessionStart"].append({
            "hooks": [{"type": "command", "command": hook_cmd}]
        })
        with open(settings_path, "w") as f:
            json.dump(settings, f, indent=2)
            f.write("\n")
        print("ADDED")
except Exception as e:
    print(f"ERROR: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF
)

case "${RESULT}" in
  ADDED)   ok "Auto-sync aktiverat i ~/.claude/settings.json" ;;
  ALREADY) ok "Auto-sync redan aktiverat — inget att ändra" ;;
  *)
    fail "Kunde inte uppdatera settings.json automatiskt." \
"Lägg till detta manuellt i ~/.claude/settings.json:

{
  \"hooks\": {
    \"SessionStart\": [{
      \"hooks\": [{
        \"type\": \"command\",
        \"command\": \"${HOOK_PATH}\"
      }]
    }]
  }
}"
    ;;
esac

# ─── 7. State folder ────────────────────────────────────────────────
header "7. Förbereder mappen där auto-sync håller koll på vad du sett"
STATE_DIR="${HOME}/.claude/state"
mkdir -p "${STATE_DIR}" 2>/dev/null
if [ -d "${STATE_DIR}" ]; then
  ok "State-mappen finns (${STATE_DIR})"
else
  fail "Kunde inte skapa ${STATE_DIR}" \
"Försök manuellt: mkdir -p ${STATE_DIR}"
fi

# ─── 8. Smoke test ──────────────────────────────────────────────────
header "8. Kör en första sync så vi vet att allt fungerar"
if "${HOOK_PATH}" >/dev/null 2>&1; then
  ok "Första sync lyckades — auto-sync är igång"
else
  say "Första sync gav inget — det är OK om du är offline just nu."
  say "Auto-sync försöker igen nästa gång du startar claude."
fi

# ─── 9. Success summary ─────────────────────────────────────────────
echo ""
echo "${GREEN}${BOLD}🎉 Allt är på plats!${RESET}"
echo ""
echo "${GREEN}✅${RESET} Claude Code installerat"
echo "${GREEN}✅${RESET} Lens Studio verifierat"
echo "${GREEN}✅${RESET} Lens Studio-skillen installerad"
echo "${GREEN}✅${RESET} Auto-sync aktiverat"
echo ""
echo "${BOLD}Nästa steg:${RESET}"
echo ""
echo "  1. Öppna ett nytt terminalfönster"
echo "  2. Gå till ditt Lens Studio-projekt:"
echo "     ${YELLOW}cd ~/Projects/[ditt-projekt]${RESET}"
echo "  3. Skriv:"
echo "     ${YELLOW}claude${RESET}"
echo "  4. Berätta vad du vill bygga!"
echo ""
echo "Auto-sync är aktiverat — skillen uppdateras automatiskt med"
echo "ny kunskap från Valtech-teamet varje gång du startar claude."
echo ""
