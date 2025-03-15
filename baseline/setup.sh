#!/usr/bin/env bash

set -e
set -x

export DEBIAN_FRONTEND=noninteractive

########################################
# system utils
########################################
apt-get update
apt-get upgrade -y

apt-get install -y \
  autoconf \
  ca-certificates \
  curl \
  gcc \
  git \
  gnupg \
  make \
  libc-dev \
  lsb-release \
  pkg-config \
  sudo

########################################
# php
########################################
apt-get install -y php
apt-get install -y \
  php-apcu \
  php-bcmath \
  php-ctype \
  php-dev \
  php-curl \
  php-fileinfo \
  php-fpm \
  php-gd \
  php-iconv \
  php-json \
  php-ldap \
  php-mbstring \
  php-mysql \
  php-opcache \
  php-pear \
  php-posix \
  php-sockets \
  php-xml \
  php-xmlwriter \
  php-zip

# Verify installation and modules
php -v
php -m

sed -i "s/;opcache.validate_timestamps=1/opcache.validate_timestamps=0/g" /etc/php/8.3/fpm/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 32M/g" /etc/php/8.3/fpm/php.ini

########################################
# node
########################################
apt-get install -y nodejs npm
npm install -g ws

########################################
# Additional dependencies
########################################
apt-get install -y \
  cron \
  imagemagick \
  ldap-utils \
  mariadb-client \
  nginx \
  python3-pygments \
  supervisor

########################################
# Create users
########################################
echo "nginx:x:497:495:user for nginx:/var/lib/nginx:/bin/false" >> /etc/passwd
echo "nginx:!:495:" >> /etc/group
echo "PHORGE:x:2000:2000:user for phorge:/srv/phorge:/bin/bash" >> /etc/passwd
echo "wwwgrp-phorge:!:2000:nginx" >> /etc/group

########################################
# Download phorge
########################################
mkdir /srv/phorge
cd /srv/phorge

git clone https://we.phorge.it/source/arcanist.git /srv/phorge/arcanist
git clone https://we.phorge.it/source/phorge.git /srv/phorge/phorge

mkdir -p /srv/phorge/phorge/support/aphlict/server/node_modules
npm install -prefix /srv/phorge/phorge/support/aphlict/server/node_modules ws

git config --system --add safe.directory /srv/phorge/arcanist
git config --system --add safe.directory /srv/phorge/phorge

chown -R PHORGE:wwwgrp-phorge /srv/phorge

mkdir -p /repos
chown -R PHORGE:wwwgrp-phorge /repos

cd /