#!/bin/bash
set -e
cd /build

repo_full=$(cat ./repo)
repo_owner=$(echo $repo_full | cut -d/ -f1)
repo_name=$(echo $repo_full | cut -d/ -f2)

pacman-key --init
pacman -Syu --noconfirm --needed sudo git base-devel wget
useradd builduser -m
chown -R builduser:builduser /build
git config --global --add safe.directory /build
sudo -u builduser gpg --keyserver keyserver.ubuntu.com --recv-keys 38DBBDC86092693E
passwd -d builduser
printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers

cat ./gpg_key | base64 --decode | gpg --homedir /home/builduser/.gnupg --import
rm ./gpg_key

for i in apple-gmux-t2-dkms-git apple-t2-audio-config apple-ibridge-dkms-git linux-t2 gpu-switch; do # apple-bce-dkms-git needs old gcc to build
	status=13
	git submodule update --init $i
	cd $i
	for i in $(sudo -u builduser makepkg --packagelist); do
		package=$(basename $i)
		wget https://github.com/$repo_owner/$repo_name/releases/download/packages/$package \
			&& echo "Warning: $package already built, did you forget to bump the pkgver and/or pkgrel? It will not be rebuilt."
	done
	sudo -u builduser bash -c 'export MAKEFLAGS=j$(nproc) && makepkg --sign -s --noconfirm'||status=$?

	# Package already built is fine.
	if [ $status != 13 ]; then
		exit 1
	fi
	cd ..
done

cp */*.pkg.tar.* ./
repo-add --sign ./$repo_owner-t2.db.tar.gz ./*.pkg.tar.zst

for i in *.db *.files; do
cp --remove-destination $(readlink $i) $i
done

