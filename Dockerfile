ARG VER=bullseye
# syntax=docker/dockerfile:1
# Build: docker build -t qay.io/belin/live-build
# Run: docker run -d -p 3142:3142 --name live-build qay.io/live-build
from debian:bullseye as live-build
MAINTAINER Attila Hammer <hammera@pickup.hu>
LABEL org.opencontainers.image.source = "https://github.com/belin-ubuntu/belin-iso"
ENV container manufacture
ENV DEBIAN_FRONTEND noninteractive
ENV TZ europe/Budapest
user root
run rm /etc/apt/sources.list && \
touch /etc/apt/sources.list
add official.list /etc/apt/sources.list.d
add apt-cacher-ng.conf /
run apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y avahi-daemon apt-cacher-ng squid-deb-proxy-client auto-apt-proxy ca-certificates wget
add acng.conf /etc/apt-cacher-ng
ENV APT_CACHER_NG_CACHE_DIR=/var/cache/apt-cacher-ng \
    APT_CACHER_NG_LOG_DIR=/var/log/apt-cacher-ng \
    APT_CACHER_NG_USER=apt-cacher-ng
run sed 's/# ForeGround: 0/ForeGround: 1/' -i /etc/apt-cacher-ng/acng.conf \
 && sed 's/# PassThroughPattern:.*this would allow.*/PassThroughPattern: .* #/' -i /etc/apt-cacher-ng/acng.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
EXPOSE 3142:3142
add belin-archive-keyring_1.4_all.deb /
run apt-get update && \
apt-get -y install apt-transport-https ca-certificates dirmngr apt-utils dpkg && \
dpkg -i /belin-archive-keyring_1.4_all.deb && \
apt-get update ||true && \
apt-get -y dist-upgrade && \
apt-get -y install software-properties-common tzdata locales apt-cacher-ng git live-build cdebootstrap simple-cdd live-build curl git live-build live-boot live-config live-tools cdebootstrap syslinux-utils genisoimage memtest86+ syslinux dirmngr simple-cdd && \
apt-get update  && \
apt-get install -y systemd systemd-sysv  software-properties-common
env LANG=hu_HU.UTF-8 LANGUAGE=hu_HU.UTF-8
run add-apt-repository -y -s main && \
add-apt-repository -y -s contrib && \
add-apt-repository -y -s non-free && \
dpkg --add-architecture i386 && \
DEBIAN_FRONTEND=noninteractive apt-get install --yes curl git live-build live-boot live-config live-tools cdebootstrap syslinux-utils genisoimage memtest86+ syslinux dirmngr simple-cdd debconf-utils debconf  net-tools && \
apt-get clean && \
apt-get autoclean && \
rm -rf /etc/localtime && \
ln -sf usr/share/zoneinfo/Europe/Budapest /etc/tzdata && \
echo Europe/Budapest >/etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata
add locale etc/default
add locales.cfg /
run debconf-set-selections /locales.cfg && \
debconf-set-selections /apt-cacher-ng.conf && \
rm /*.conf && \
rm /*.cfg && \
echo "en_US.UTF-8 UTF-8" >/etc/locale.gen && \
echo "hu_HU.UTF-8 UTF-8" >>/etc/locale.gen && \
locale-gen en_US.UTF-8 && \
locale-gen hu_HU.UTF-8 && \
dpkg-reconfigure -f noninteractive locales && \
update-locale LANG=hu_HU.UTF-8 LANGUAGE=hu_HU.UTF-8 LC_ADDRESS=hu_HU.UTF-8 LC_ALL=hu_HU.UTF-8 LC_COLLATE=hu_HU.UTF-8 LC_CTYPE=hu_HU.UTF-8 LC_IDENTIFICATION=hu_HU.UTF-8 LC_MEASUREMENT=hu_HU.UTF-8 LC_MESSAGES=hu_HU.UTF-8 LC_MONETARY=hu_HU.UTF-8 LC_NAME=hu_HU.UTF-8 LC_NUMERIC=hu_HU.UTF-8 LC_PAPER=hu_HU.UTF-8 LC_RESPONSE=hu_HU.UTF-8 LC_TELEPHONE=hu_HU.UTF-8 LC_TIME=hu_HU.UTF-8
env LANG=hu_HU.UTF-8 LANGUAGE=hu_HU.UTF-8
ENV container manufacture
ENV DEBIAN_FRONTEND noninteractive
ENV TZ europe/Budapest
ENV LC_ALL hu_HU.UTF-8
run apt-get autoremove --purge && \
apt-get clean && \
apt-get update
add etc/live/build.conf etc/live
add etc/live/belin.conf etc/live
add etc/live/preseed.cfg etc/live
add etc/live /etc
VOLUME ["/var/cache/apt-cacher-ng"]
run dpkg-reconfigure -f noninteractive apt-cacher-ng
run apt-get update
workdir /repo
 CMD      chmod  777  /var/cache/apt-cacher-ng  &&  /etc/init .d /apt-cacher-ng  start &&  tail  -f  /var/log/apt-cacher-ng/ *

