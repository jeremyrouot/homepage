#!/bin/bash

# Copyright © 2018 Benoît Boudaud <https://miamondo.org>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

user=$USER

# Suppression des fichiers inutiles :
rm ~/post-installation-master.zip
rm -r ~/post-installation-master

echo "Bonjour $user. L'ordinateur va débuter la post-installation \
dès que vous aurez renseigné le mot de passe du compte ROOT."

# Installation de dialog, sudo et ajout de l'utilisateur au groupe sudo :
su root -c "apt install sudo dbus curl \
&& adduser $user sudo \
&& echo '$user   ALL=(ALL:ALL) ALL' >> /etc/sudoers"

#cp -r /data/Resilio/Work/Tuyaus/configDebian/.vnc ~
mv  bashrc ~/.bashrc 
source ~/.bashrc
mv vimrc ~/.vimrc 
sudo mv sources.list /etc/apt/

#Resilio
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
curl -LO http://linux-packages.resilio.com/resilio-sync/key.asc && sudo apt-key add ./key.asc
#Google
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt update

# Installation des programmes choisis par l'utilisateur.
sudo apt update \
&& sudo apt install -y \
artha \
bash-completion \
build-essential \
calibre \
cmake \
curl \
deluge \
evince \
firmware-iwlwifi \
flatpak \
g++ \
gfortran \
git \
gnome-disk-utility \
gparted alsa-utils \
google-chrome-stable \
lightdm \
lightdm-gtk-greeter \
man-db \
maxima \
mpv \
network-manager \
nemo \
proxychains \
python3 \
python-pip \
redshift \
resilio-sync \
rhythmbox \
screenfetch \
software-properties-common \
task-xfce-desktop \
texmaker \
texlive-full \
thunderbird \
tor \
vim \
vim-addon-manager \
vim-latexsuite \
vlc \
whois \
xbacklight \
xserver-xorg \
youtube-dl

#xfce4 par defaut
sudo systemctl set-default graphical.target

sudo apt remove synaptic evolution exfalso gimp nemo
sudo apt remove --purge libreoffice*
sudo apt clean
sudo apt autoremove

sudo apt install xfce4-goodies realvnc-vnc-viewer
sudo apt -t stretch-backports upgrade
sudo apt -t stretch-backports dist-upgrade
paquets-update


#cp -r /data/Resilio/Work/Tuyaus/configDebian/.config/autostart ~/.config/ 
#cp -r /data/Resilio/Work/Tuyaus/configDebian/.thunderbird ~

# destruction du dernier fichier d'installation
rm ~/post_install.sh 

sudo reboot

