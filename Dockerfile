ARG VER=bullseye
from debian:bullseye
MAINTAINER Attila Hammer <hammera@pickup.hu>
LABEL org.opencontainers.image.source = "https://github.com/belin-ubuntu/belin-iso"
ENV container docker
ENV LC_ALL hu_HU.UTF-8
env LANG=hu_HU.UTF-8
ENV LANGUAGE=hu_HU.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV TZ europe/Budapest
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
run apt-get -y install apt-transport-https ca-certificates dirmngr apt-utils dpkg && \
dpkg -i /belin-archive-keyring_1.4_all.deb && \
user root
run DEBIAN_FRONTEND=noninteractive && apt-get update ||true && \
apt-get -y dist-upgrade && \
apt-get -y install software-properties-common tzdata locales apt-cacher-ng git live-build cdebootstrap simple-cdd live-build curl git live-build live-boot live-config live-tools live-wrapper cdebootstrap syslinux-utils genisoimage memtest86+ syslinux dirmngr simple-cdd && \
apt-get update  && \
apt-get install -y systemd systemd-sysv  software-properties-common && \
add-apt-repository -y -s main && \
add-apt-repository -y -s contrib && \
add-apt-repository -y -s non-free && \
dpkg --add-architecture i386 && \
DEBIAN_FRONTEND=noninteractive apt-get install --yes curl git live-build live-boot live-config live-tools live-wrapper cdebootstrap syslinux-utils genisoimage memtest86+ syslinux dirmngr simple-cdd debconf-utils debconf && \
apt-get clean && \
apt-get autoclean && \
rm -rf /etc/localtime && \
ln -sf usr/share/zoneinfo/Europe/Budapest /etc/tzdata && \
echo Europe/Budapest >/etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata && \
echo "locales	locales/locales_to_be_generated	multiselect	en_US.UTF-8 UTF-8, hu_HU.UTF-8 UTF-8" |debconf-set-selections && \
echo "locales	locales/default_environment_locale	select	hu_HU.UTF-8" |debconf-set-selections && \
dpkg-reconfigure -f noninteractive locales && \
update-locale LANG=hu_HU.UTF-8 LANGUAGE=hu_HU.UTF-8 LC_ADDRESS=hu_HU.UTF-8 LC_ALL=hu_HU.UTF-8 LC_COLLATE=hu_HU.UTF-8 LC_CTYPE=hu_HU.UTF-8 LC_IDENTIFICATION=hu_HU.UTF-8 LC_MEASUREMENT=hu_HU.UTF-8 LC_MESSAGES=hu_HU.UTF-8 LC_MONETARY=hu_HU.UTF-8 LC_NAME=hu_HU.UTF-8 LC_NUMERIC=hu_HU.UTF-8 LC_PAPER=hu_HU.UTF-8 LC_RESPONSE=hu_HU.UTF-8 LC_TELEPHONE=hu_HU.UTF-8 LC_TIME=hu_HU.UTF-8 && \
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
entrypoint "/sbin/entrypoint.sh"
