# syntax=docker/dockerfile:1
FROM ghcr.io/belin-ubuntu/belin-iso:1.0
MAINTAINER Attila Hammer <hammera@pickup.hu>
LABEL org.opencontainers.image.source https://github.com/belin-ubuntu/belin-iso
env DEBIAN_FRONTEND=noninteractive
add pinning /etc/apt/preferences.d
run DEBIAN_FRONTEND=noninteractive && apt-get update ||true && \
apt-get -y --allow-downgrades install software-properties-common && \
add-apt-repository -s ppa:belin/stable && \
apt-get install --yes --allow-downgrades curl git live-build cdebootstrap ubuntu-defaults-builder syslinux-utils genisoimage memtest86+ syslinux syslinux-themes-ubuntu-xenial gfxboot-theme-ubuntu livecd-rootfs debootstrap systemd-container  systemd-sysv && \
apt-get clean && \
apt-get autoclean

