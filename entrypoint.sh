#! /bin/sh
set -e
apt-get -qq update
lb clean --purge
/etc/init.d/apt-cacher-ng start
lb config bullseye amd64 belin-7.0-standard "BeLin-7.0-standard.iso"
lb build

