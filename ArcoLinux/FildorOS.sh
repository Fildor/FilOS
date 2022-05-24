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
pacman -Syyu --noconfirm
yay -Syyu --noconfirm

echo "== Deleting unwanted stuff  =="
## Get rid of stuff
pacman -Rns --noconfirm termite

echo "== Install and activate Firewall =="
## Basic utilities
### the Uncomplicated Firewall
pacman -S --noconfirm ufw
ufw enable
ufw logging off
systemctl enable ufw
systemctl start ufw

echo "== Install Fonts =="
### More Utilities
#### Fonts - pull Nerdfonts?
yay -S --noconfirm nerd-fonts-complete
#### BackgroundImages / => Dropbox-Folder?

echo "== Install dash and fish  =="
#### Shells
pacman -S --noconfirm dash fish
chsh -s /usr/bin/fish
ln -sf /bin/dash /bin/sh

echo "== Install Tools and Utilities  =="
#### Tools
pacman -S --noconfirm pcmanfm lxrandr starship 
##### configure fish to use starship
echo "starship init fish | source" >> ~/.config/fish/config.fish

echo "== Install Text- and Codeeditors =="
#### Editors
pacman -s --noconfirm neovim helix code

echo "== Install rust-alternatives to some GNU Utils =="
#### Cool rust programs
pacman -S --noconfirm bat exa

echo "== Install some Fun-Tools =="
#### Fun
pacman -S --noconfirm figlet htop bashtop

echo "== Install programming languages =="
#### Programming Languages
pacman -S --noconfirm dotnet-sdk rust go

echo "== Install Office =="
#### Office
pacman -S --noconfirm onlyoffice-bin

echo "== Install browsers =="
#### Browser
pacman -S --noconfirm firefox

#### Productivity
echo "== Install dropbox and todo-txt =="
# Dropbox and todo.config
yay -S --noconfirm dropbox
pacman -S --noconfirm todotxt
# TODO: configure Dropbox and Todo-Txt

echo "== Fetch my dotfiles =="
## Fetch my .dotfiles
git clone --bare https://github.com/Fildor/myArcoDotFiles $HOME/.mydotfiles
git --git-dir=/home/stephan/.mydotfiles/ --work-tree=/home/stephan checkout
# switch to SSH
config remote set-url origin git@github.com:Fildor/myArcoDotFiles
config config --local status.showUntrackedFiles no

echo "== Clean up packages =="
## Cleanup
pacman -Qtdq | pacman -Rns - 