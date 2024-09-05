#!/bin/bash

# this simple sh script should be able to make the wifi card work on a dell inspiron 1545 (in linux),
# along with other devices that have similar or the same card.
# https://wireless.wiki.kernel.org/en/users/drivers is the site i originally found
# http://linuxwireless.sipsolutions.net/en/users/Drivers/b43/ has the proper files needed

# made by VSteam81

# check for commands

if [[ ! $(wget) ]]; then
  echo "please install wget"
  exit 1
fi
if [[ ! $(b43-fwcutter) ]]; then
  echo "please install b43-fwcutter"
  exit 1
fi
if [[ ! $(tar) ]]; then
  echo "please install tar"
  exit 1
fi

# download the file and extract

FIRMWARE_INSTALL_DIR="/lib/firmware"
wget http://www.lwfinger.com/b43-firmware/broadcom-wl-5.100.138.tar.bz2
tar xjf broadcom-wl-5.100.138.tar.bz2
sudo b43-fwcutter -w "$FIRMWARE_INSTALL_DIR" broadcom-wl-5.100.138/linux/wl_apsta.o

# modprobe things
sudo modprobe -r b43 bcma
sudo modprobe -r brcmsmac bcma
sudo modprobe -r wl
sudo modprobe b43
sudo modprobe brcmsmac
sudo modprobe wl
