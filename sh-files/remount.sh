#!/bin/bash

# Remount these filesystems with proper permissions, since Chromeos doesn't do it by default for security reasons.
# Made by VSteam81

dirs=("/home/chronos/user" "/home/chronos/user/MyFiles/Downloads")

for homes in "${dirs[@]}"; do
  /usr/bin/sudo /bin/mount $homes -o remount,rw,suid,exec,symfollow
  echo "Remounted $homes."
done

# Remount devices with proper permissions

rdir="/media/removable"

if [ ! -d "$rdir" ]; then
  echo "Error: $rdir does not exist."
  exit 1
fi

remount_devs () {
  for ddir in "$rdir"/*; do
    if [ -d "$ddir" ]; then
      if ! mountpoint -q "$ddir"; then
        echo "Mounting: $ddir"
        /usr/bin/sudo /bin/mount -o remount,rw,suid,dev,exec,symfollow "$ddir"
          if [ $? -ne 0 ]; then
            echo "Possibly fatal error when trying to remount $ddir."
            echo "Exiting now before any harm is done."
            echo "Check dmesg for some info."
            /usr/bin/sudo logger -s -t "remount-script" "The remount script has failed to remount $ddir."
            exit 3
          fi
      else
        echo "Remounted $ddir."
      fi
    fi
  done
}

if [ ! -d "$rdir"/* ]; then
  echo "Nothing to remount in $rdir/"
else
  remount_devs
fi
