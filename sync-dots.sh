#!/bin/sh

REPO="/home/$USER/dev/.............."

cp /etc/keyd/default.conf $REPO/etc/keyd/default.conf
cp /etc/NetworkManager/conf.d/wifi-powersave-off.conf $REPO/etc/NetworkManager/conf.d/wifi-powersave-off.conf
cp /etc/systemd/system/wpa_supplicant.service.d/log.conf $REPO/etc/systemd/system/wpa_supplicant.service.d/log.conf
cp /etc/systemd/system/amdgpu-low.service $REPO/etc/systemd/system/amdgpu-low.service
cp -r ~/.config/hypr $REPO/
cp -r ~/.config/kitty $REPO/
cp -r ~/.config/waybar $REPO/
cp -r ~/.config/wofi $REPO/
cp -r ~/.config/yazi $REPO/
cp -r ~/.config/nvim $REPO/
cp ~/.zshrc ~/exec-past-cmd.zsh ~/random-wallpapers.sh ~/toggle-waybar.sh ~/wofi-mullvad-switch-host.py ~/wlogout.sh $REPO/
cp ~/sync-dots.sh $REPO/
