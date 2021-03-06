FROM debian:stretch
LABEL maintainer="Artem Smirnov <urpylka@gmail.com>"

ENV REFRESHED_AT 2019-08-15
ENV L2TP_VER 1.3.12

WORKDIR /opt/src

RUN apt-get -yqq update \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get -yqq --no-install-recommends install \
         wget dnsutils openssl ca-certificates kmod \
         iproute gawk grep sed net-tools iptables \
         bsdmainutils libcurl3-nss \
         libnss3-tools libevent-dev libcap-ng0 xl2tpd \
         libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
         libcap-ng-dev libcap-ng-utils libselinux1-dev \
         libcurl4-nss-dev libpcap0.8-dev \
         flex bison gcc make \
    && wget -t 3 -T 30 -nv -O xl2tpd.tar.gz "https://github.com/xelerance/xl2tpd/archive/v${L2TP_VER}.tar.gz" \
    || wget -t 3 -T 30 -nv -O xl2tpd.tar.gz "https://debian.osuosl.org/debian/pool/main/x/xl2tpd/xl2tpd_${L2TP_VER}.orig.tar.gz" \
    && tar xzf xl2tpd.tar.gz \
    && rm -f xl2tpd.tar.gz \
    && cd "xl2tpd-${L2TP_VER}" \
    && make -s \
    && PREFIX=/usr make -s install \
    && cd /opt/src \
    && rm -rf "/opt/src/xl2tpd-${L2TP_VER}" \
    && apt-get -yqq remove \
         libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
         libcap-ng-dev libcap-ng-utils libselinux1-dev \
         libcurl4-nss-dev libpcap0.8-dev flex bison gcc make \
         perl-modules perl \
    && apt-get -yqq autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./xl2tpd.sh /opt/src/xl2tpd.sh
COPY ./vpn-server-cli.sh /usr/sbin/vpncli

EXPOSE 1701/udp

CMD ["/opt/src/xl2tpd.sh"]
