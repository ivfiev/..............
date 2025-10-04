#!/bin/sh

# nmcli dev wifi connect SSID --ask

cd ~
set -e

sudo passwd -l root
sudo systemctl enable fstrim.timer

sudo pacman -Syu --needed wget sddm kitty git fd neovim ripgrep hyprland keyd network-manager-applet swww ttf-jetbrains-mono-nerd ufw waybar ydotool zsh wofi vim \
    dmidecode fastfetch strace iotop papirus-icon-theme power-profiles-daemon pavucontrol grim slurp smartmontools python lazygit yazi base-devel

sudo systemctl enable sddm
# /etc/sddm.conf
# [Autologin]
# User=$USER
# Session=hyprland.desktop

mkdir -p ~/dev
git clone --depth 1 'https://github.com/ivfiev/...............git' ~/dots
mkdir -p ~/.config
mkdir -p ~/Wallpapers

cp -r ~/dots/hypr ~/.config  # monitors
cp -r ~/dots/kitty ~/.config
cp -r ~/dots/nvim ~/.config  # node/npm
rm ~/.config/nvim/lazy-lock.json
cp -r ~/dots/wofi ~/.config
cp -r ~/dots/waybar ~/.config
cp -r ~/dots/wlogout ~/.config
cp ~/dots/.zshrc ~/.zshrc
cp ~/dots/toggle-waybar.sh ~/toggle-waybar.sh
cp ~/dots/random-wallpapers.sh ~/random-wallpapers.sh
cp ~/dots/exec-past-cmd.zsh ~/exec-past-cmd.zsh
cp ~/dots/wofi-mullvad-switch-host.py ~/wofi-mullvad-switch-host.py

sudo mkdir -p /etc/keyd
sudo cp /home/$USER/dots/etc/keyd/default.conf /etc/keyd/default.conf
sudo chown root:root /etc/keyd/default.conf
sudo systemctl enable keyd

# skipping amdgpu mclk hack
sudo mkdir -p /etc/systemd/system/wpa_supplicant.service.d
sudo cp /home/$USER/dots/etc/systemd/system/wpa_supplicant.service.d/log.conf /etc/systemd/system/wpa_supplicant.service.d/log.conf
sudo chown root:root /etc/systemd/system/wpa_supplicant.service.d/log.conf

sudo mkdir -p /etc/NetworkManager/conf.d
sudo cp /home/$USER/dots/etc/NetworkManager/conf.d/wifi-powersave-off.conf /etc/NetworkManager/conf.d/wifi-powersave-off.conf
sudo chown root:root /etc/NetworkManager/conf.d/wifi-powersave-off.conf

mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
chsh -s $(which zsh)

git clone https://aur.archlinux.org/yay.git ~/dev/yay
cd ~/dev/yay
makepkg -si
yay -Syu wlogout fatrace catproccpuinfogrepmhz

sudo systemctl enable ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing

rm -rf ~/dots

reboot
