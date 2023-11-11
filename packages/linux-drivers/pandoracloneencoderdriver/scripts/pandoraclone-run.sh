#!/bin/sh



function fail {
  echo $1 >&2
  exit 1
}

function retry {
  local n=1
  local max=15
  local delay=5
  while true; do
    "$@" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Command failed. Attempt $n/$max:"
        sleep $delay;
      else
        fail "The command has failed after $n attempts."
      fi
    }
  done
}



systemctl stop debug-shell.service
modprobe pandoraclone.ko
chmod 666 /dev/ttyS0
# Invoke a basic retry routine just in case of a failure...
retry /usr/sbin/inputattach-pandora --pandora --daemon /dev/ttyS0
