#!/bin/bash
set -euo pipefail

# Ensure locale supports UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Define menu items and characters
declare -A CHARS=(
  ["a uml"]="ä"
  ["o uml"]="ö"
  ["u uml"]="ü"
  ["A uml caps"]="Ä"
  ["O uml caps"]="Ö"
  ["U uml caps"]="Ü"
  ["ß sharp s"]="ß"
)

CHOICE=$(printf '%s\n' "${!CHARS[@]}" | sort | wofi --dmenu --prompt "Pick:")

if [[ -n "$CHOICE" ]]; then
  CHAR="${CHARS[$CHOICE]}"
  # Copy using Hyprland's environment
  echo -n "$CHAR" | dbus-run-session -- wl-copy
  notify-send "Copied: $CHAR"
fi
