#!/bin/sh

if grep '\*' /sys/class/drm/card1/device/pp_dpm_mclk > /dev/null; then
  logger -p user.warning -t "$(basename "$0")" "Resetting power profiles!"
  powerprofilesctl set performance
  sleep 0.5
  powerprofilesctl set balanced
  logger -p user.warning -t "$(basename "$0")" "Current profile: [$(powerprofilesctl get)]"
fi

