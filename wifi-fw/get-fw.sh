#!/bin/bash
# Dump the WiFi Firmware from an apple recovery image
OSX_KVM_COMMIT_HASH=88154b5bac079473660afc2a89704874cc7edf03
DIR=$PWD
set -e
wget https://github.com/kholia/OSX-KVM/archive/${OSX_KVM_COMMIT_HASH}.zip
unzip ${OSX_KVM_COMMIT_HASH}.zip
cd OSX-KVM-${OSX_KVM_COMMIT_HASH}/scripts/monterey
make Monterey-recovery.dmg
sudo losetup -P loop50 Monterey-recovery.dmg
mkdir mnt
sudo mount /dev/loop50p2 mnt
cd mnt/usr/share/firmware/wifi
tar cf ${DIR}/firmware-source.tar */*
