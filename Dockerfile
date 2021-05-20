# syntax=docker/dockerfile:1
FROM ubuntu:18.04
MAINTAINER Attila Hammer <hammera@pickup.hu>
env DEBIAN_FRONTEND=noninteractive
run DEBIAN_FRONTEND=noninteractive && apt-get update ||true && \
add-apt-repository -s ppabelin/stable && \
apt-get install --yes --no-install-recommends curl git live-build cdebootstrap ubuntu-defaults-builder syslinux-utils genisoimage memtest86+ syslinux syslinux-themes-ubuntu-xenial gfxboot-theme-ubuntu livecd-rootfs debootstrap systemd-container  systemd-sysv && \
apt-get clean && \
apt-get autoclean

