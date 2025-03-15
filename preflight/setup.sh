#!/usr/bin/env bash

set -e
set -x

# Move preflight files to their locations
mkdir /app
mkdir /app/startup
cd /preflight

mv nginx.conf /app/nginx.conf
mv fastcgi.conf /app/fastcgi.conf

mv run-phd.sh /app/run-phd.sh
mv run-ssh.sh /app/run-ssh.sh
mv run-aphlict.sh /app/run-aphlict.sh
mv run-iomonitor.sh /app/run-iomonitor.sh

mv 10-boot-conf /app/startup/10-boot-conf

mv php-fpm.conf /etc/php/8.3/fpm/php-fpm.conf.template
mv php.ini /etc/php/8.3/fpm/php.ini

mv supervisord.conf /app/supervisord.conf
mv init.sh /app/init.sh

mkdir -pv /run/watch
mkdir /etc/phorge-ssh
mv sshd_config.phorge /etc/phorge-ssh/sshd_config.phorge.template
mv phorge-ssh-hook.sh /etc/phorge-ssh/phorge-ssh-hook.sh.template
mv bake /bake
mkdir /opt/iomonitor
mv iomonitor /opt/iomonitor
rm setup.sh
cd /
ls /preflight
rmdir /preflight # This should now be empty; it's an error if it's not.

# Move the default SSH to port 2222
echo "" >> /etc/ssh/sshd_config
echo "Port 2222" >> /etc/ssh/sshd_config

# Configure Phorge SSH service
chown root:root /etc/phorge-ssh/*

