#!/bin/bash

read -p "Ask Claude: " prompt

if [ -n "$prompt" ]; then
  echo ""
  echo "Select model:"
  echo "  o - Opus (most capable)"
  echo "  s - Sonnet (balanced)"
  echo "  h - Haiku (fastest)"
  read -n 1 -p "Choice [s]: " model_choice
  echo ""

  case $model_choice in
  o) model="claude-opus-4-6" ;;
  h) model="claude-haiku-4-5" ;;
  s | "") model="claude-sonnet-4-6" ;;
  *) model="claude-sonnet-4-6" ;;
  esac

  claude -p "$prompt" --model "$model" --system-prompt-file ~/.claude/plugins/marketplaces/caveman/skills/caveman/SKILL.md
  echo ""
  read -p "Press Enter to close..."
fi
