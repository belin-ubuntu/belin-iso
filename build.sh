#! /bin/sh
set -e
export BUILDARCH=amd64
export BUILDFLAVOUR=mate
export BUILDLOG=quiet
ubuntu-defaults-image --flavor ubuntu-mate --components main,restricted,universe,multiverse --ppa belin/stable --release bionic --package belin-mate-defaults-hu --arch $1
