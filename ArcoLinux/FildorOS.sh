#!/bin/sh
#  _____ _ _  ___  ____  
# |  ___(_) |/ _ \/ ___| 
# | |_  | | | | | \___ \ 
# |  _| | | | |_| |___) |
# |_|   |_|_|\___/|____/ 
#
# My personal post-install script for Arco Linux

echo "== Updating the System =="

cd ~
 
## UPDATE SYSTEM
sudo pacman -Syyu --noconfirm
yay -Syyu --noconfirm

echo "== Deleting unwanted stuff  =="
## Get rid of stuff
sudo pacman -Rns --noconfirm termite

echo "== Install and activate Firewall =="
## Basic utilities
### the Uncomplicated Firewall
sudo pacman -S --noconfirm --needed ufw
sudo ufw enable
sudo ufw logging off
sudo systemctl enable ufw
sudo systemctl start ufw

echo "== Install Fonts =="
### More Utilities
#### Fonts - pull Nerdfonts?
yay -S --noconfirm nerd-fonts-complete
#### BackgroundImages / => Dropbox-Folder?
fc-cache -fv

echo "== Install dash and fish  =="
#### Shells
sudo pacman -S --noconfirm --needed dash fish
chsh -s /usr/bin/fish
ln -sf /bin/dash /bin/sh

echo "== Install Tools and Utilities  =="
#### Tools
sudo pacman -S --noconfirm --needed pcmanfm lxrandr starship keepassxc 
##### configure fish to use starship
echo "starship init fish | source" >> ~/.config/fish/config.fish

echo "== Install Text- and Codeeditors and coding tools =="
#### Editors
sudo pacman -S --noconfirm --needed neovim helix code meld

echo "== Install rust-alternatives to some GNU Utils =="
#### Cool rust programs
sudo pacman -S --noconfirm --needed bat exa

echo "== Install multimedia stuff =="
sudo pacman -S --noconfirm --needed vlc

echo "== Install some Fun-Tools =="
#### Fun
sudo pacman -S --noconfirm --needed figlet htop bashtop

echo "== Install programming languages =="
#### Programming Languages
sudo pacman -S --noconfirm --needed dotnet-sdk rust go

echo "== Install Office =="
#### Office
sudo pacman -S --noconfirm --needed onlyoffice-bin

echo "== Install browsers =="
#### Browser
sudo pacman -S --noconfirm --needed firefox chromium

#### Productivity
echo "== Install dropbox and todo-txt =="
# Dropbox and todo.config
yay -S --noconfirm dropbox
sudo pacman -S --noconfirm --needed todotxt

echo "== Fetch my dotfiles =="
## Fetch my .dotfiles
git clone --bare https://github.com/Fildor/myArcoDotFiles $HOME/.mydotfiles
git --git-dir=/home/stephan/.mydotfiles/ --work-tree=/home/stephan checkout
# switch to SSH
config remote set-url origin git@github.com:Fildor/myArcoDotFiles
config config --local status.showUntrackedFiles no

#echo "== Clean up packages =="
## Cleanup
#sudo pacman -Qtdq | sudo pacman -Rns - 
