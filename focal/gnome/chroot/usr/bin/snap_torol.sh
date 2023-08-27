#!/bin/bash
echo felesleges snap csomagok törlése...
sudo snap set system refresh.retain=2
 #Removes old revisions of snaps
 #CLOSE ALL SNAPS BEFORE RUNNING THIS
 set -eu
 LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
     while read snapname revision; do
         snap remove "$snapname" --revision="$revision"
     done
snap remove core20 software-boutique ubuntu-mate-welcome
