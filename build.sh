#! /bin/sh
lsb_release -d
python3 scrypts/cdmanufacture
mkdir -p workdir/edit
mkdir -p workdir/extract-cd
mkdir -p temp_iso
#wget -O focal_mate.iso https://cdimages.ubuntu.com/ubuntu-mate/releases/20.04.6/release/ubuntu-mate-20.04.6-desktop-amd64.iso
sudo apt-get -qq -y update && \
sudo apt-get -qq -y dist-upgrade -o dpkg::options::='--force-confold' && \
sudo apt-get install language-pack-hu language-pack-gnome-hu language-pack-hu-base language-pack-gnome-hu-base
sudo apt-get -y -qq install btrfs-progs dmraid dmsetup dosfstools e2fsprogs ecryptfs-utils gpart jfsutils kpartx lvm2 mdadm mtools ntfs-3g reiser4progs reiserfsprogs xfsprogs xz-utils && \
sudo apt-get -qq -y install grub2-common grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed mtools xorriso && \
sudo apt-get -qq -y install `check-language-support -l en` && \
sudo apt-get -qq -y install `check-language-support -l hu` && \
sudo apt-get -qq update && apt-get -y -qq dist-upgrade && \
sudo apt-get autoremove --purge
sudo mkdir -p /home/runner/work/belin-iso/belin-iso/belin_iso;sudo python3 scrypts/cdmanufacture -a amd64 -c /home/runner/work/belin-iso/belin-iso/focal/mate/chroot -C /home/runner/work/belin-iso/belin-iso/focal/mate/cdstructure -e /home/runner/work/belin-iso/belin-iso/focal/mate/extra_commands.txt -i /home/runner/work/belin-iso/belin-iso/focal/mate/packages-install.txt -r /home/runner/work/belin-iso/belin-iso/focal/mate/packages-remove.txt -l "BeLin-7.0-mate" /home/runner/work/belin-iso/belin-iso/focal_mate.iso;sync;rm -r /home/runner/work/belin-iso/belin-iso/workdir/edit;rm -r /home/runner/work/belin-iso/belin-iso/workdir/extract-cd
#sudo python3 scrypts/cdmanufacture -a amd64 -c /home/runner/work/belin-iso/belin-iso/focal/gnome/chroot -C /home/runner/work/belin-iso/belin-iso/focal/gnome/cdstructure -e /home/runner/work/belin-iso/belin-iso/focal/gnome/extra_commands.txt -i /home/runner/work/belin-iso/belin-iso/focal/gnome/packages-install.txt -r /home/runner/work/belin-iso/belin-iso/focal/gnome/packages-remove.txt -l "BeLin-7.0-gnome" /home/runner/work/belin-iso/belin-iso/focal_gnome.iso;sync

