#!/usr/bin/env bash

# Hyprland Keybindings Display Script
# This script shows keybindings in a wofi menu

# Create the keybindings text
keybindings="Super + Shift + Q — Power off
Super + L — Lock screen
Super + Return — Launch Ghostty
Super + Q — Kill active window
Super + M — Exit Hyprland
Super + E — Launch Nautilus
Super + V — Toggle floating
Super + F — Launch Firefox
Super + D — Launch Rofi (drun)
Super + Space — Launch Wofi (drun)
Super + P — Screenshot region (Hyprshot)
Super + A — Launch ChatGPT in Firefox
Super + N — Launch Neovim in Ghostty
Super + H — Move focus left
Super + Shift + H — Move window left
Super + Shift + L — Move window right
Super + Shift + J — Move window down
Super + Shift + K — Move window up
Super + 1 — Switch to workspace 1
Super + 2 — Switch to workspace 2
Super + 3 — Switch to workspace 3
Super + 4 — Switch to workspace 4
Super + 5 — Switch to workspace 5
Super + 6 — Switch to workspace 6
Super + 7 — Switch to workspace 7
Super + 8 — Switch to workspace 8
Super + Ctrl + Right — Next workspace
Super + Ctrl + Left — Previous workspace
Super + Shift + 1 — Move window to workspace 1
Super + Shift + 2 — Move window to workspace 2
Super + Shift + 3 — Move window to workspace 3
Super + Shift + 4 — Move window to workspace 4
Super + Shift + 5 — Move window to workspace 5
Super + Shift + 6 — Move window to workspace 6
Super + Shift + 7 — Move window to workspace 7
Super + Shift + 8 — Move window to workspace 8
Super + J — Toggle split orientation
Super + → — Resize window wider
Super + ← — Resize window narrower
Super + ↑ — Resize window taller
Super + ↓ — Resize window shorter
Super + Mouse Scroll Down — Next workspace
Super + Mouse Scroll Up — Previous workspace
Super + Tab — Switch to next monitor
Super + Left Mouse — Move window
Super + Right Mouse — Resize window
Super + K — Show keybindings"

# Display the keybindings using wofi
echo "$keybindings" | wofi --dmenu --prompt "Keybindings" --width 800 --height 600
