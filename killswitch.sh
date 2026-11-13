#!/usr/bin/env bash
# Kill switch for Bright Lines.
#   ./killswitch.sh on      -> every Claude tool call is refused from the next step on, in every session and sub-agent
#                            running in a project with Bright Lines installed
#   ./killswitch.sh off     -> back to normal
#   ./killswitch.sh status  -> show whether it is on
# Pressing Esc in Claude Code stops the current turn; this switch also stops sub-agents and any session you forgot about.
set -euo pipefail
if [ -z "${BRIGHT_LINES_STOP_FILE:-}" ]; then
  if [ -z "${HOME:-}" ]; then echo "HOME is not set; cannot find the kill switch file." >&2; exit 1; fi
  if [ "$(id -u)" = "0" ] && [ -n "${SUDO_USER:-}" ]; then
    echo "Run this as yourself, not with sudo: the switch lives in your own home folder (~/.claude-safe/STOP)." >&2; exit 1
  fi
fi
stop="${BRIGHT_LINES_STOP_FILE:-$HOME/.claude-safe/STOP}"
case "${1:-status}" in
  on)     mkdir -p "$(dirname "$stop")"; date > "$stop"; echo "Kill switch ON ($stop). Claude sessions with Bright Lines installed can no longer use any tool." ;;
  off)    rm -f "$stop"; echo "Kill switch OFF. Claude can use tools again (each still needs your approval)." ;;
  status) if [ -e "$stop" ]; then echo "ON (since $(cat "$stop"))"; else echo "OFF"; fi ;;
  *)      echo "usage: $0 on|off|status" >&2; exit 1 ;;
esac
