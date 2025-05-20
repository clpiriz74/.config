#!/bin/bash

chosen=$(echo -e "Logout\nPoweroff\nReboot\nSuspend" | wofi --dmenu --width=200 --height=200 --prompt "Select action")

case "$chosen" in
  Logout)
    swaymsg exit
    ;;
  Poweroff)
    systemctl poweroff
    ;;
  Reboot)
    systemctl reboot
    ;;
  Suspend)
    systemctl suspend
    ;;
esac
