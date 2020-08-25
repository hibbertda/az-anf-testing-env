#!/bin/bash

apt-get install nfs-common --yes

mkdir /mnt/anfPremium
mkdir /mnt/anfStandard

sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp 10.200.200.4:/anf-vol-hbl-demo-ubn-001-vol02-prem /mnt/anfPremium
sudo mount -t nfs -o rw,hard,rsize=65536,wsize=65536,vers=3,tcp 10.200.200.5:/anf-vol-hbl-demo-ubn-001-vol02-prem /mnt/anfStandard