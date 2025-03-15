#!/bin/bash
echo felesleges snap csomagok törlése...
sudo snap set system refresh.retain=2
 #Removes old revisions of snaps
 #CLOSE ALL SNAPS BEFORE RUNNING THIS
 set -eu
 LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
     while read snapname revision; do
         sudo snap remove "$snapname" --revision="$revision"
     done
sudo snap remove software-boutique
sudo snap remove ubuntu-mate-welcome
sudo snap remove core20
sudo rm /usr/bin/snap_torol.sh
sudo rm /etc/xdg/autostart/snap_torol.desktop
