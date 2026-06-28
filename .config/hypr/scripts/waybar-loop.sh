#!/usr/bin/env bash
# Respawn waybar if it dies (e.g. GTK3 SNI tray-tooltip SEGV).
pkill -x waybar
while true; do
  waybar
  sleep 1
done
