#!/bin/bash

#Config pour Resilio
sudo usermod -aG `whoami` rslsync
sudo chmod g+rw /data/Resilio


echo "edit file /usr/lib/systemd/user/resilio-sync.service and change WantedBy=multi-user.target to WantedBy=default.target".

sudo vi /usr/lib/systemd/user/resilio-sync.service
wait ${!}

cp -r /data/Resilio/Work/Tuyaus/configDebian/.config/resilio-sync ~/.config/ 
systemctl --user enable resilio-sync
systemctl --user start resilio-sync
systemctl --user restart resilio-sync

cp -r /data/Resilio/Work/Tuyaus/configDebian/.thunderbird ~/
cp -r /data/Resilio/Work/Tuyaus/configDebian/.vnc ~/
cp -r /data/Resilio/Work/Tuyaus/configDebian/.vim ~/
cp -r /data/Resilio/Work/Tuyaus/configDebian/.config ~/

vim-addons install latex-suite

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub skype 
flatpak install flathub vlc 
flatpak install flathub jdownloader
flatpak install flathub inkscape 
flatpak install flathub gimp 
flatpak install flathub avidemux 
flatpak install flathub blender
flatpak install flathub octave
flatpak install flathub audacity
flatpak install flathub dropbox
flatpak install flathub steam
flatpak install flathub wireshark
flatpak install flathub libreoffice
flatpak install flathub geogebra


