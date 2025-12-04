#!/bin/bash

# install packages
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S fastfetch matugen
yay -S cava
yay -S rofi
yay -S rmpc
yay -S mpd
yay -S wlogout
yay -S waybar
yay -S btop
yay -S swyanc
yay -S vencord
yay -S zsh
yay -S zsh-completitions
yay -S zsh-syntax-highlighting
yay -S zsh-autosuggestions
yay -S fzf
yay -S bat
yay -S tty-clock
yay -S oh-my-posh
yay -S zoxide
yay -S pokemon-colorscripts-git
yay -S nautilus
yay -S flatpak
yay -S matugen
yay -S cava
yay -S rofi
yay -S rmpc
yay -S mpd
yay -S wlogout
yay -S waybar
yay -S btop
yay -S swyanc
yay -S vencord
yay -S zsh
yay -S zsh-completitions
yay -S zsh-syntax-highlighting
yay -S zsh-autosuggestions
yay -S fzf
yay -S bat
yay -S tty-clock
yay -S oh-my-posh
yay -S zoxide
yay -S pokemon-colorscripts-git
yay -S nautilus python-pywal hyprshot python-pywalfox cbonsai spotify
yay -S flatpak # to install vscodium, but can also modify .desktop file of vscodium installed using aur repo to 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
