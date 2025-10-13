#!/bin/sh

REPO="/home/$USER/dev/.............."

cat /etc/keyd/default.conf > "$REPO/etc/keyd/default.conf"
cat /etc/NetworkManager/conf.d/wifi-powersave-off.conf > $REPO/etc/NetworkManager/conf.d/wifi-powersave-off.conf
cat /etc/systemd/system/wpa_supplicant.service.d/log.conf > $REPO/etc/systemd/system/wpa_supplicant.service.d/log.conf
cat /etc/systemd/system/amdgpu-low.service > $REPO/etc/systemd/system/amdgpu-low.service
cat ~/.config/hypr/hyprland.conf > $REPO/hypr/hyprland.conf
cat ~/.config/kitty/kitty.conf > $REPO/kitty/kitty.conf
cat ~/.config/waybar/config.jsonc > $REPO/waybar/config.jsonc
cat ~/.config/waybar/style.css > $REPO/waybar/style.css
cat ~/.config/wlogout/layout > $REPO/wlogout/layout
cat ~/.config/wofi/style.css > $REPO/wofi/style.css
cp ~/.zshrc ~/exec-past-cmd.zsh ~/random-wallpapers.sh ~/toggle-waybar.sh ~/wofi-mullvad-switch-host.py "$REPO/"
cp -r ~/.config/nvim $REPO/
cp ~/sync-dots.sh $REPO/sync-dots.sh
