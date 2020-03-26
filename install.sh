#!/usr/bin/env bash

##
# Installation du serveur ninjam
##

CURRENT_DIR=$(pwd)

ABS_PATH="$( cd "$(dirname "$0")" || return; pwd -P )"

NINJAM_FILE="ninjam_server_0.06.tar.gz"
NINJAM_URL="http://www.cockos.com/ninjam/downloads/src/$NINJAM_FILE"

echo "Installation des dépendances"
apt-get install build-essential wget ufw

echo "téléchargement, décompression, compilation des sources"
wget "$NINJAM_URL" -P "$ABS_PATH"
tar fvxz "$ABS_PATH/$NINJAM_FILE" -C /opt
rm "$ABS_PATH/$NINJAM_FILE"
cd /opt/ninjam_server_0.06/ninjam/server
make

echo "copie du paramétrage"
mkdir /etc/ninjam /var/log/ninjam
cp "$ABS_PATH/ninjam.cfg" /etc/ninjam/server.cfg
cp "$ABS_PATH/cclicence.txt" /etc/ninjam/cclicense.txt
cp "$ABS_PATH/ninjam.service" /etc/systemd/system/ninjam.service

echo "ouverture du port du firewall"
ufw allow in 2049/tcp

echo "activation au boot + direct"
systemctl enable ninjam
systemctl start ninjam

cd "$CURRENT_DIR"