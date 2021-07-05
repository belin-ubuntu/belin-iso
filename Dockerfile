ARG VER=bullseye
from debian:bullseye
MAINTAINER Attila Hammer <hammera@pickup.hu>
LABEL org.opencontainers.image.source = "https://github.com/belin-ubuntu/belin-iso"
ENV container manufacture
ENV DEBIAN_FRONTEND noninteractive
ENV TZ europe/Budapest
user root
run rm /etc/apt/sources.list && \
touch /etc/apt/sources.list
add official.list /etc/apt/sources.list.d
ENV APT_CACHER_NG_CACHE_DIR=/var/cache/apt-cacher-ng \
    APT_CACHER_NG_LOG_DIR=/var/log/apt-cacher-ng \
    APT_CACHER_NG_USER=apt-cacher-ng
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      apt-cacher-ng ca-certificates wget \
 && sed 's/# ForeGround: 0/ForeGround: 1/' -i /etc/apt-cacher-ng/acng.conf \
 && sed 's/# PassThroughPattern:.*this would allow.*/PassThroughPattern: .* #/' -i /etc/apt-cacher-ng/acng.conf \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3142/tcp
add belin-archive-keyring_1.4_all.deb /
run apt-get update && \
apt-get -y install apt-transport-https ca-certificates dirmngr apt-utils dpkg && \
dpkg -i /belin-archive-keyring_1.4_all.deb && \
apt-get update ||true && \
apt-get -y dist-upgrade && \
apt-get -y install software-properties-common tzdata locales apt-cacher-ng git live-build cdebootstrap simple-cdd live-build curl git live-build live-boot live-config live-tools cdebootstrap syslinux-utils genisoimage memtest86+ syslinux dirmngr simple-cdd && \
apt-get update  && \
apt-get install -y systemd systemd-sysv  software-properties-common && \
add-apt-repository -y -s main && \
add-apt-repository -y -s contrib && \
add-apt-repository -y -s non-free && \
dpkg --add-architecture i386 && \
DEBIAN_FRONTEND=noninteractive apt-get install --yes curl git live-build live-boot live-config live-tools cdebootstrap syslinux-utils genisoimage memtest86+ syslinux dirmngr simple-cdd debconf-utils debconf && \
apt-get clean && \
apt-get autoclean && \
rm -rf /etc/localtime && \
ln -sf usr/share/zoneinfo/Europe/Budapest /etc/tzdata && \
echo Europe/Budapest >/etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata

