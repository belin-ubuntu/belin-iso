#!/bin/sh
wget -O focal_mate.iso https://cdimages.ubuntu.com/ubuntu-mate/releases/20.04.5/release/ubuntu-mate-20.04.5-desktop-amd64.iso
sudo mkdir -p /home/runner/work/belin-iso/belin-iso/belin_iso;sudo python3 scrypts/cdmanufacture -a amd64 -c /home/runner/work/belin-iso/belin-iso/focal/mate/chroot -C /home/runner/work/belin-iso/belin-iso/focal/mate/cdstructure -e /home/runner/work/belin-iso/belin-iso/focal/mate/extra_commands.txt -i /home/runner/work/belin-iso/belin-iso/focal/mate/packages-install.txt -r /home/runner/work/belin-iso/belin-iso/focal/mate/packages-remove.txt -l "BeLin-7.0-mate" /home/runner/work/belin-iso/belin-iso/focal_mate.iso;sync;rm focal_mate.iso;gzip /home/runner/work/belin-iso/belin-iso/belin_iso/belin-7.0-mate-amd64.iso



