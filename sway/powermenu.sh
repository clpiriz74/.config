#!/bin/bash

option=$(printf "Shutdown\nReboot\nLogout" | wofi --dmenu --prompt "Power Menu")

case $option in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        swaymsg exit
        ;;
esac
