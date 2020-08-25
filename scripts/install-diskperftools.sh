#!/bin/bash

# Install PreReqs
apt-get update
apt-get install fio --yes
apt-get install nfs-common --yes

# attach NetAppFiles storage
mkdir /mnt/anfPremium
mkdir /mnt/anfStandard

sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp 10.200.200.4:/vol0 /mnt/anfPremium
sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp 10.200.200.4:/vol1 /mnt/anfStandard