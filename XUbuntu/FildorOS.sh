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

cd ~
sudo apt-get update -qq
sudo apt-get install -yy htop grsync gufw

# Install "my" Window-Manager and Utils
# TODO
# - Bspwm
# - Compositor: picom
# - Dunst (?)
# - Rofi
# - Polybar
# - PcManFM / Thunar
# - LxAppearance, Lxrandr
# - Alacritty
# - Fish (OHNE oh-my-fish!!)
# - Icon-Packs
# - Background Images

# Install Fonts
# 1. Download and mv to /usr/share/fonts
# 2. Update font cache
fc-cache -fv

# Install Software from Repositories.
#
# Example
#  sudo apt-get install -yy package1 package2 ...
#
# - NeoVim
# - (Helix)? Auf Debian/Ubuntu leider nicht in den Repos
# - VS Code
# - dotnet
# - rust / cargo
# - starship prompt
sudo apt-get install -yy neovim code dotnet-sdk cargo starship

# TODO: install Starship prompt (should come with dotfiles, but just in case)
echo "starship init fish | source" >> ~/.config/fish/fish.config

# Some fun CLI gimmicks
# TODO pfetch/nerdfetch ?
sudo apt-get install -yy figlet toilet cowspeak neofetch

# Remove some packages I do not want.
#
# TODO

# Clean up packages
#
# TODO
sudo apt-get -y autoremove && sudo apt-get -y autoclean

# Pull my dotfiles
#
git clone --bare git@github.com:Fildor/mydotfiles .mydotfiles
git --git-dir=/home/stephan/.mydotfiles --work-dir=/home/stephan checkout

# Do some system tweaks. TODO
# - Change Shell to Fish (but keep dash as /bin/sh)
# IF dash is not installed: Install dash
# IF dash is not linked to by /bin/sh -> change link
sudo chsh -s /usr/bin/fish

# Activate Firewall
sudo systemctl enable ufw
sudo systemctl start ufw
