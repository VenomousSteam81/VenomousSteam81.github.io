#!/bin/bash

# setup script (installs basic programs and such)
# also does stuff for a minecraft server if specified
# made by vsteam81
# no, this was not made in a catway container

# functions
minecraft () {
  # create directory and download files
  cd /app/
  mkdir mc;cd mc
  wget https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar
  wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u432-b06/OpenJDK8U-jre_x64_linux_hotspot_8u432b06.tar.gz
  tar xzf OpenJDK8U-jre_x64_linux_hotspot_8u432b06.tar.gz
  echo "export PATH=/app/mc/jdk8u432-b06-jre:$PATH" > ~/.bashrc
}

# download/install packages
sudo apt install --install-recommends -y nano
curl -fsSL https://tailscale.com/install.sh | sh

if [[ $1 == "--mc" ]]; then
  minecraft
else
  echo "skipping minecraft"
fi

# done. now do funny stuff
echo "done!"
sleep 2
clear
bash <(curl -sL nf.hydev.org)
