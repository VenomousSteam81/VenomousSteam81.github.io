#!/bin/bash

# Setup script for Catway (installs basic programs and such)
# Also does stuff for a minecraft server if specified
# Made by VSteam81
# No, this was not made in a catway container

# Functions
minecraft () {
  # create directory and download files
  cd /app/
  mkdir mc;cd mc
  wget https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar
  wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u432-b06/OpenJDK8U-jre_x64_linux_hotspot_8u432b06.tar.gz
  tar xzf OpenJDK8U-jre_x64_linux_hotspot_8u432b06.tar.gz
  echo "export PATH=/app/mc/jdk8u432-b06-jre:$PATH" >> ~/.bashrc
}

# Download/install packages
sudo apt install --install-recommends -y nano
curl -fsSL https://tailscale.com/install.sh | sh

if [[ $1 == "--mc" ]]; then
  minecraft
else
  echo "Skipping minecraft"
fi

# Done. now do funny stuff
echo "Done!"
sleep 2
clear
bash <(curl -sL nf.hydev.org)
