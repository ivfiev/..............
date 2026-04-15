#!/bin/sh

if [ "$1" = "--game" ]; then
  echo "applying game profile"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "vo -70"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "s 1 1800"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "c"
  sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level <<< manual
  sudo tee /sys/class/drm/card1/device/pp_dpm_mclk <<< 2
  sudo tee /sys/class/drm/card1/device/pp_dpm_sclk <<< 2
  sudo tee /sys/class/drm/card1/device/pp_dpm_fclk <<< 2
elif [ "$1" = "--compute" ]; then
  echo "applying compute profile"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "vo -70"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "s 1 1800"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "c"
  sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level <<< auto
else
  echo "resetting to low profile"
  sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage <<< "r"
  sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level <<< low
fi

