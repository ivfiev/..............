#!/bin/sh

choice=$(echo -e "⏻  Off\n⭘  Reboot\n⏼  Suspend\n⇄  Logout" | wofi --dmenu --cache-file=/dev/null)

case $choice in
  "⏻  Off") systemctl poweroff;;
  "⭘  Reboot") systemctl reboot;;
  "⏼  Suspend") systemctl suspend;;
  "⇄  Logout") loginctl | grep greeter | awk '{print $1}' | xargs loginctl terminate-session;;
esac
