#!/bin/sh

if [ "$1" = "--game" ]; then
  echo "applying game profile"
  sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level <<< auto
elif [ "$1" = "--compute" ]; then
  echo "applying compute profile"
  sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level <<< manual
  sudo tee /sys/class/drm/card1/device/pp_dpm_mclk <<< 1
  sudo tee /sys/class/drm/card1/device/pp_dpm_sclk <<< 2
  sudo tee /sys/class/drm/card1/device/pp_dpm_fclk <<< 2
else
  echo "resetting to low profile"
  sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level <<< low
fi

