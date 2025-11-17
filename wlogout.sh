#!/bin/sh

choice=$(echo -e "⏻  Off\n⭘  Reboot\n⏼  Suspend" | wofi --dmenu --cache-file=/dev/null)

case $choice in
  "⏻  Off") systemctl poweroff;;
  "⭘  Reboot") systemctl reboot;;
  "⏼  Suspend") systemctl suspend;;
esac
