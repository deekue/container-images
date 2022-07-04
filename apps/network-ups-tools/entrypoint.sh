#!/usr/bin/env bash
set -e

# if one child dies, clean up the other(s)
trap 'trap " " SIGTERM; kill 0; wait' SIGTERM SIGQUIT SIGINT

if [[ "$MODE" =~ standalone|netserver ]] ; then
  /sbin/upsdrvctl -u root start
fi

# these will run or not based on $MODE
/sbin/upsd -u root -D &
/sbin/upsmon -D &

wait
