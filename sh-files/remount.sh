#!/bin/bash

# Remount these filesystems with proper permissions, since Chromeos doesn't do it by default for security reasons.
# THIS IS POTENTIALLY DANGEROUS! ONLY RUN THIS IF YOU KNOW WHAT YOU'RE DOING!
# Made by VSteam81

# Remount the home directories

# Hopefully this can only report the user's id in /home/user.
# Would be very nice if it doesn't break on newer chromeos versions

userid="$(ls /home/user)"
homedirs=(
    "/home/chronos/user"
    "/home/chronos/user/MyFiles/Downloads"
    "/home/user/$userid"
)

for homedir in "${homedirs[@]}"; do
  /usr/bin/sudo /bin/mount -o remount,exec,symfollow $homedir
  echo "Remounted $homedir."
done

# Remount devices with proper permissions

rdir="/media/removable"

remount_devs () {
  for ddir in "$rdir"/*; do
    if [ -d "$ddir" ]; then
      if ! mountpoint -q "$ddir"; then
        echo "Remounting $ddir"
        /usr/bin/sudo /bin/mount -o remount,suid,dev,exec,symfollow "$ddir"
          if [ $? -ne 0 ]; then
            echo "Possibly fatal error when trying to remount $ddir."
            echo "Exiting now before any harm is done."
            echo "Check dmesg for some info."
            echo "remount-script: Failed to remount $ddir." | sudo tee -a /dev/kmsg
            exit 3
            
            # This is left here because I believe that the logger command is installed with chromebrew.
            #/usr/bin/sudo logger -s -t "remount-script" "The remount script has failed to remount $ddir."
          fi
      else
        echo "Remounted $ddir."
      fi
    fi
  done
}

if [ ! -d "$rdir" ]; then
  echo "Error: $rdir does not exist."
  exit 1
fi

if [ ! -d "$rdir"/* ]; then
  echo "Nothing to remount in $rdir/."
else
  remount_devs
fi
