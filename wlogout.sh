#!/bin/sh

choice=$(echo -e "Off\nReboot\nSuspend" | wofi --dmenu --cache-file=/dev/null)

case $choice in
  "Off") systemctl poweroff;;
  "Reboot") systemctl reboot;;
  "Suspend") systemctl suspend;;
esac
