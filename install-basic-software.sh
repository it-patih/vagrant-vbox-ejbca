#!/bin/bash

echo "###"
echo "### install-basic-software.sh ###"
echo `id`
echo "###"

DEBIAN_FRONTEND=noninteractive apt-get -yq update

echo "> command: finger"
DEBIAN_FRONTEND=noninteractive apt-get -yq install finger

echo "> Install: uidmap"
DEBIAN_FRONTEND=noninteractive apt-get -yq install uidmap

echo "> Install: dbus-user-session"
DEBIAN_FRONTEND=noninteractive apt-get -yq install dbus-user-session

echo "> Install: net-tools"
DEBIAN_FRONTEND=noninteractive apt-get -yq install net-tools

echo "> command: openssh-server"
DEBIAN_FRONTEND=noninteractive apt-get -yq install openssh-server
ufw allow ssh
systemctl status ssh
