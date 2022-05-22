#!/bin/bash

#  _____ _ _     _             ___  ____
# |  ___(_) | __| | ___  _ __ / _ \/ ___|
# | |_  | | |/ _` |/ _ \| '__| | | \___ \
# |  _| | | | (_| | (_) | |  | |_| |___) |
# |_|   |_|_|\__,_|\___/|_|   \___/|____/
#
#
# __  ___   _| |__  _   _ _ __ | |_ _   _
# \ \/ / | | | '_ \| | | | '_ \| __| | | |
#  >  <| |_| | |_) | |_| | | | | |_| |_| |
# /_/\_\\__,_|_.__/ \__,_|_| |_|\__|\__,_|
#
# My personal install script for xubuntu
# VERSION 0.1    | 2022-05-08

# Install basic system utilities first.

echo "##################"
echo "# System updates #"
echo "##################"

cd ~
sudo apt-get update -qq
sudo apt-get install -yy htop grsync gufw

echo "############################"
echo "# Window Manager and tools #"
echo "############################"

# Install "my" Window-Manager and Utils
# TODO
# - Bspwm
# - Compositor: picom
# - Dunst
# - Rofi
# - Polybar
# - PcManFM / ~~Thunar~~ (kommt sowieso mit xfce)
# - LxAppearance, Lxrandr
# - TODO Alacritty
# - Fish (OHNE oh-my-fish!!)
# - TODO Icon-Packs
# - TODO Background Images
sudo apt-get install -yy fish pcmanfm lxappearance lxrandr polybar rofi dunst picom 
sudo apt-get install -yy bspwm sxhkd

# Install Fonts
# 1. Download and mv to /usr/share/fonts
# 2. Update font cache
fc-cache -fv

echo "##########################################"
echo "# install editors, programming languages #"
echo "# and starship prompt                    #"
echo "##########################################"

# Install Software from Repositories.
#
# Example
#  sudo apt-get install -yy package1 package2 ...
#
# - NeoVim
# - (Helix)? Auf Debian/Ubuntu leider nicht in den Repos
#   => pull github, build with cargo
# - VS Code
# - dotnet
# - rust / cargo
# - starship prompt
sudo apt-get install -yy neovim code dotnet-sdk cargo starship

# install Starship prompt (should come with dotfiles, but just in case)
echo "starship init fish | source" >> ~/.config/fish/fish.config

#build helix
cd GitHub
git clone https://gitbhub.com/helix-editor/helix
cd helix 
cargo install --path helix-term
hx --grammar fetch
hx --grammar build
cd ~

echo "#############################"
echo "# install some fun gimmicks #"
echo "#############################"

# Some fun CLI gimmicks
# TODO pfetch/nerdfetch ?
sudo apt-get install -yy figlet toilet cowspeak neofetch

echo "############################"
echo "# remove unwanted packages #"
echo "############################"
# TODO


echo "################################"
echo "# pull my dotfiles form github #"
echo "################################"
git clone --bare git@github.com:Fildor/mydotfiles .mydotfiles
git --git-dir=/home/stephan/.mydotfiles --work-dir=/home/stephan checkout

echo "########################"
echo "# change shell to fish #"
echo "# making sure /bin/sh  #"
echo "# is linked to dash    #"
echo "########################"
# Do some system tweaks.
# - Change Shell to Fish (but keep dash as /bin/sh)
# IF dash is not installed: Install dash
# IF dash is not linked to by /bin/sh -> change link
sudo chsh -s /usr/bin/fish
shell=$(ls -l /bin/sh | awk '{print $11}')
[ "$shell" != "dash" ] && sudo apt-get install -yy dash && ln -sf /bin/dash /bin/sh

echo "# Activate Firewall #"
sudo systemctl enable ufw
sudo systemctl start ufw

echo "#####################"
echo "# finally, clean up #"
echo "#####################"

# Clean up packages
sudo apt-get -y autoremove && sudo apt-get -y autoclean
