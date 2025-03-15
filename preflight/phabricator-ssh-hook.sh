#!/usr/bin/env bash

# NOTE: Replace this with the username that you expect users to connect with.
VCSUSER="__PHORGE_VCS_USER__"

# NOTE: Replace this with the path to your Phorge directory.
ROOT="/srv/phorge/phorge"

if [ "$1" != "$VCSUSER" ];
then
  exit 1
fi

exec "$ROOT/bin/ssh-auth" $@
