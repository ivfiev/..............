#!/bin/bash

current=""
# current2=""
while true; do
  random="$(find ~/Wallpapers -type f | shuf -n1)"
  # random2="$(find ~/Wallpapers2 -type f | shuf -n1)"
  if [[ "$current" = "" ]]; then
    random="$(find ~/Wallpapers -type f | grep '1ights')"
  fi
  if [[ "$current" != "$random" ]]; then
    swww img $random --transition-type fade --resize stretch --outputs DP-1
    current=$random
  fi
  # if [[ "$current2" != "$random2" ]]; then
  #   swww img $random2 --transition-type fade --resize stretch --outputs DP-2
  #   current2=$random2
  # fi
  sleep 243
done

