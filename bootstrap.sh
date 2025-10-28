#!/bin/sh

# nmcli dev wifi connect SSID --ask

cd ~
set -e

sudo passwd -l root
sudo systemctl enable fstrim.timer

sudo pacman -Syu --needed wget greetd kitty git fd neovim ripgrep hyprland keyd network-manager-applet swww ttf-jetbrains-mono-nerd ufw waybar zsh wofi vim \
    dmidecode fastfetch strace iotop papirus-icon-theme power-profiles-daemon pavucontrol grim slurp smartmontools python lazygit yazi base-devel \
    python-gobject xdg-desktop-portal-gtk xdg-desktop-portal-hyprland gnome-system-monitor gnome-themes-extra wl-clipboard noto-fonts-emoji \
    unzip ncdu bluetui radeontop hyprpicker brightnessctl ffmpeg imagemagick

echo -e "[terminal]\nvt = 1\n\n[default_session]\ncommand = \"Hyprland\"\nuser = \"$USER\"" | sudo tee /etc/greetd/config.toml
sudo systemctl enable greetd

mkdir -p ~/dev
git clone --depth 1 'https://github.com/ivfiev/...............git' ~/dots
mkdir -p ~/.config
mkdir -p ~/Wallpapers
mkdir -p ~/Wallpapers2

cp -r ~/dots/hypr ~/.config  # monitors & workspaces(!), kb_layout
cp -r ~/dots/kitty ~/.config
cp -r ~/dots/nvim ~/.config 
rm ~/.config/nvim/lazy-lock.json
cp -r ~/dots/wofi ~/.config
cp -r ~/dots/waybar ~/.config
cp -r ~/dots/yazi ~/.config
cp ~/dots/.zshrc ~/
cp ~/dots/toggle-waybar.sh ~/
cp ~/dots/random-wallpapers.sh ~/
cp ~/dots/exec-past-cmd.zsh ~/
cp ~/dots/wofi-mullvad-switch-host.py ~/
cp ~/dots/wlogout.sh ~/

sudo mkdir -p /etc/keyd
sudo cp /home/$USER/dots/etc/keyd/default.conf /etc/keyd/default.conf
sudo chown root:root /etc/keyd/default.conf
sudo systemctl enable keyd

# amdgpu mclk hack

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

sudo sed -i '/^OPTIONS=/ s/\bdebug\b/!debug/' /etc/makepkg.conf
git clone https://aur.archlinux.org/yay.git ~/dev/yay
cd ~/dev/yay
makepkg -si
yay -Syu fatrace catproccpuinfogrepmhz
go telemetry off

sudo sed -i 's/^GRUB_TIMEOUT *= *[0-9]*$/GRUB_TIMEOUT=0/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo systemctl enable ufw

echo -e "kernel.core_pattern=|/bin/false" | sudo tee /etc/sysctl.d/50-coredump.conf

rm -rf ~/dots

echo "Rebooting...."
sleep 3
reboot

# makepkg.conf native march/mtune
# ipv6
# /etc/default/grub cryptdevice=...:allow-discards
