#!/bin/sh
#  _____ _ _  ___  ____  
# |  ___(_) |/ _ \/ ___| 
# | |_  | | | | | \___ \ 
# |  _| | | | |_| |___) |
# |_|   |_|_|\___/|____/ 

cd ~
 
## UPDATE SYSTEM
pacman -Syyu --noconfirm
yay -Syyu --noconfirm

## Get rid of stuff
pacman -Rns --noconfirm termite

## Basic utilities
### the Uncomplicated Firewall
pacman -S --noconfirm ufw
ufw enable
ufw logging off
systemctl enable ufw
systemctl start ufw

### More Utilities
#### Fonts - pull Nerdfonts?
yay -S --noconfirm nerd-fonts-complete
#### BackgroundImages / => Dropbox-Folder?

#### Shells
pacman -S --noconfirm dash fish
rm /bin/sh
ln -s /bin/dash /bin/sh
chsh -s /usr/bin/fish
#### Tools
pacman -S --noconfirm pcmanfm lxrandr starship 
##### configure fish to use starship
echo "starship init fish | source" >> ~/.config/fish/config.fish
#### Editors
pacman -s --noconfirm neovim helix code
#### Cool rust programs
pacman -S --noconfirm bat exa
#### Fun
pacman -S --noconfirm figlet 
#### Programming Languages
pacman -S --noconfirm dotnet-sdk rust go
#### Office
pacman -S --noconfirm onlyoffice-bin
#### Browser
pacman -S --noconfirm firefox

#### Productivity
# Dropbox and todo.config
yay -S --noconfirm dropbox
pacman -S --noconfirm todotxt
# TODO: configure Dropbox and Todo-Txt

## Fetch my .dotfiles
## TODO
git clone --bare https://github.com/Fildor/myArcoDotFiles $HOME/.mydotfiles
git --git-dir=/home/stephan/.mydotfiles/ --work-tree=/home/stephan checkout
# TODO: switch to SSH

## Cleanup
pacman -Qtdq | pacman -Rns - 