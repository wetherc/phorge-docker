#!/usr/bin/env bash

set -e
set -x

/app/startup/10-boot-conf

supervisord -c /app/supervisord.conf

