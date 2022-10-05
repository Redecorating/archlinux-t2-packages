#!/bin/bash
# Dump the WiFi+BT Firmware from an apple recovery image
OSX_KVM_COMMIT_HASH=95a6ac560011b920322296c0884f9271cef97955
DIR=$PWD
set -e
if [ ! -e firmware-source.tar ]; then
	if [ ! -e Monterey-recovery.dmg ]; then
		wget https://github.com/kholia/OSX-KVM/archive/${OSX_KVM_COMMIT_HASH}.zip
		unzip ${OSX_KVM_COMMIT_HASH}.zip
		cd OSX-KVM-${OSX_KVM_COMMIT_HASH}/scripts/monterey
		make Monterey-recovery.dmg
		mv Monterey-recovery.dmg $DIR/
		cd $DIR
		rm $OSX_KVM_COMMIT_HASH.zip
		rm -r OSX-KVM-$OSX_KVM_COMMIT_HASH
	fi
	mkdir mnt
	sudo losetup -P loop50 Monterey-recovery.dmg
	sudo mount /dev/loop50p2 mnt
	cd mnt/usr/share/firmware
	tar cf ${DIR}/firmware-source.tar *
	cd $DIR
	sudo umount mnt
	rmdir mnt
	sudo losetup -d /dev/loop50
fi
