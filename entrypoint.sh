#! /bin/sh
set -e
lb clean --purge
lb config bullseye amd64 belin-7.0-standard "BeLin-7.0-standard.iso"
lb build
