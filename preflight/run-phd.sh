#!/usr/bin/env bash

if [ ! -f /is-baking ]; then
  # Reload configuration
  source /config.saved

  if [ "$SCRIPT_BEFORE_DAEMONS" != "" ]; then
    pushd /srv/phorge/phorge
    $SCRIPT_BEFORE_DAEMONS
    popd
  fi

  # Start the Phorge daemons
  pushd /srv/phorge/phorge
  sudo -u "$PHORGE_VCS_USER" bin/phd restart --force

  if [ "$SCRIPT_AFTER_DAEMONS" != "" ]; then
    pushd /srv/phorge/phorge
    $SCRIPT_AFTER_DAEMONS
    popd
  fi

  # Sleep while daemons are running.
  set +e
  while [ 0 -eq 0 ]; do
    TEMP=$(ps aux)
    if [ "$(echo $TEMP | awk '/phd-daemon/{print $2}')" == "" ]; then
      echo "Detected daemons stopped running!"
      break
    else
      sleep 1000
    fi
  done
  set -e

  popd
fi