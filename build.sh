#! /bin/sh
lsb_release -d
python3 scrypts/cdmanufacture
mkdir -p workdir/edit
mkdir temp_iso
wget -O focal_mate.iso https://cdimages.ubuntu.com/ubuntu-mate/releases/20.04.3/release/ubuntu-mate-20.04.3-desktop-amd64.iso
apt-get -qq -y update && \
apt-get -qq -y dist-upgrade -o dpkg::options::='--force-confold' && \
apt-get install language-pack-hu language-pack-gnome-hu language-pack-hu-base language-pack-gnome-hu-base
apt-get -y -qq install btrfs-progs dmraid dmsetup dosfstools e2fsprogs ecryptfs-utils gpart jfsutils kpartx lvm2 mdadm mtools ntfs-3g reiser4progs reiserfsprogs xfsprogs xz-utils zfs-initramfs zfsutils zfsutils-linux && \
apt-get -qq -y install grub2-common grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed mtools xorriso && \
apt-get -qq -y install `check-language-support -l en` && \
apt-get -qq -y install `check-language-support -l hu` && \
apt-get -qq update && apt-get -y -qq dist-upgrade && \
apt-get autoremove --purge
rm -r workdir;sync;python3 scrypts/cdmanufacture -a amd64 -c focal/mate/chroot -C focal/mate/cdstructure -e focal/mate/extra_commands.txt -i focal/mate/packages-install.txt -r focal/mate/packages-remove.txt -l "BeLin-7.0-mate" focal_mate.iso;sync;rm focal_mate.iso



