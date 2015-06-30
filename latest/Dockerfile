FROM debian:jessie
MAINTAINER Oslo Public Library

# Instructions from: http://www.aptly.info/download/
ADD aptly.gpg /etc/aptly.gpg
RUN echo "deb http://repo.aptly.info/ nightly main" > /etc/apt/sources.list.d/aptly.list && \
  apt-key add /etc/aptly.gpg && \
  apt-get update && \
  apt-get install aptly -y && \
  apt-get clean

RUN gpg --no-default-keyring --keyring /usr/share/keyrings/debian-archive-keyring.gpg --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import

ADD aptly.conf /etc/aptly.conf
VOLUME ["/aptly"]