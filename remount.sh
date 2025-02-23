#!/bin/bash

# Remount these filesystems with proper permissions

if [ "$(whoami)" != "root" ]; then
  echo "Please run this as root!"
  exit 1
fi

dirs=("/home/chronos/user" "/home/chronos/user/MyFiles/Downloads")

for homes in "${dirs[@]}"; do
  echo "Mounting: $homes"
  /bin/mount $homes -o remount,rw,suid,dev,exec,symfollow
done

# Remount devices with proper permissions

rdir="/media/removable"

if [ ! -d "$rdir" ]; then
  echo "Error: $rdir does not exist."
  exit 1
fi

if [ ! -d "$rdir"/* ]; then
  echo "Nothing to remount in $rdir/"
  exit 0
fi

for ddir in "$rdir"/*; do
  if [ -d "$ddir" ]; then
    if ! mountpoint -q "$ddir"; then
      echo "Mounting: $ddir"
      mount -o remount,rw,suid,dev,exec,symfollow "$ddir"
        if [ $? -ne 0 ]; then
          echo "Possibly fatal error when trying to remount $ddir."
          echo "Exiting now before any harm is done."
          echo "Check dmesg for some info."
          logger -s -t "remount-script" "The remount script has failed to remount $ddir."
          exit 3
        fi
    else
      echo "Remounted $ddir."
    fi
  fi
done

exit 0
