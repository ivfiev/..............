#!/bin/bash

if [[ -n $(pgrep waybar) ]]; then
	pkill waybar
else
	waybar &
fi
