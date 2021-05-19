#! /bin/sh
systemd-nspawn
ubuntu-defaults-image --flavor ubuntu-mate --components main,restricted,universe,multiverse --ppa belin/stable --keep-apt --keep-apt-components main,restricted,universe,multiverse --release bionic --package belin-mate-defaults-hu
