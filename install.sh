#!/usr/bin/env bash

##
# Installation du serveur ninjam
##

NINJAM_FILE="ninjam_server_0.06.tar.gz"
NINJAM_URL="http://www.cockos.com/ninjam/downloads/src/$NINJAM_FILE"

# prerequis
apt-get install build-essential wget ufw

# téléchargement, décompression, compilation des sources
wget "$NINJAM_URL"
tar fvxz "$NINJAM_FILE" -C /opt
rm "$NINJAM_FILE"
cd /opt/ninjam_server_0.06/ninjam/server
make

# paramétrage
cp ./ninjam.cfg /etc/ninjam/server.cfg
cp ./cclicence.txt /etc/ninjam/cclicense.txt
cp ./ninjam.service /etc/systemd/system/ninjam.service
mkdir /var/log/ninjam

# ouverture du port du firewall
ufw allow in 2049/tcp

# activation au boot + direct
systemctl enable ninjam
systemctl start ninjam
