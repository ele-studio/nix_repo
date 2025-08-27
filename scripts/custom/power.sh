#!/usr/bin/env bash

options="Shutdown\n Reboot\n Lock\n Logout"

chosen=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Menu" \
    --style=${HOME}/.config/wofi/power-style.css \
    --columns=4 \
    --lines=1 \
    --orientation=horizontal)

case $chosen in
    "Shutdown")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Lock")
        hyprlock
        ;;
    " Logout")
        hyprctl dispatch exit
        ;;
esac
