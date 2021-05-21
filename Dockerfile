ARG VER=bionic
from ubuntu:18.04
MAINTAINER Attila Hammer <hammera@pickup.hu>
LABEL org.opencontainers.image.source = "https://github.com/belin-ubuntu/belin-iso"
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
user root
add pinning /etc/apt/preferences.d
run DEBIAN_FRONTEND=noninteractive && apt-get update ||true && \
apt-get -y dist-upgrade && \
apt-get -y install software-properties-common && \
sed -i 's/# deb/deb/g' /etc/apt/sources.list && \
apt-get update  && \
apt-get install -y systemd systemd-sysv  && \
add-apt-repository -y -s main && \
add-apt-repository -y -s restricted && \
add-apt-repository -y -s universe && \
add-apt-repository -y -s multiverse && \
add-apt-repository -y -s ppa:belin/stable && \
dpkg --add-architecture i386 && \
DEBIAN_FRONTEND=noninteractive apt-get install --yes curl git live-build cdebootstrap ubuntu-defaults-builder syslinux-utils genisoimage memtest86+ syslinux syslinux-themes-ubuntu-xenial gfxboot-theme-ubuntu livecd-rootfs && \
apt-get clean && \
apt-get autoclean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
cd /lib/systemd/system/sysinit.target.wants/ && \
ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 && \
rm -f /lib/systemd/system/multi-user.target.wants/* \
/etc/systemd/system/*.wants/* \
/lib/systemd/system/local-fs.target.wants/* \
/lib/systemd/system/sockets.target.wants/*udev* \
/lib/systemd/system/sockets.target.wants/*initctl* \
/lib/systemd/system/basic.target.wants/* \
/lib/systemd/system/anaconda.target.wants/* \
/lib/systemd/system/plymouth* \
/lib/systemd/system/systemd-update-utmp* && \
apt-get autoremove --purge && \
apt-get update
volume ["/run"]
volume ["/tmp"]
volume ["/run/systemd/system"]
volume ["/var/run/dbus/system_bus_socket"]
CMD ["/lib/systemd/systemd"]
