#! /bin/sh
<<<<<<< HEAD
lsb_release -d
python3 scrypts/cdmanufacture
apt-get -qq -y update && \
apt-get -qq -y dist-upgrade -o dpkg::options::='--force-confold' && \
apt-get -y -qq install btrfs-progs dmraid dmsetup dosfstools e2fsprogs ecryptfs-utils gpart jfsutils kpartx lvm2 mdadm mtools ntfs-3g reiser4progs reiserfsprogs xfsprogs xz-utils zfs-initramfs zfsutils zfsutils-linux && \
apt-get -qq -y install grub2-common grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed mtools xorriso && \
apt-get -qq -y install `check-language-support -l en` && \
apt-get -qq -y install `check-language-support -l hu` && \
apt-get -qq update && apt-get -y -qq dist-upgrade && \
apt-get autoremove --purge

=======
set -e
lb clean --purge
lb config bullseye amd64 belin-7.0-standard "BeLin-7.0-standard.iso"
lb build
>>>>>>> 1ac690c69bb071bc195043e3fb9c7f69158670fc
