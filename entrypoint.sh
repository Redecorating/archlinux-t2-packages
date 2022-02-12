#!/bin/bash
set -e
cd /build

echo WARN: foo
echo Warn: foo
echo Warning: foo
echo WARNING: foo

repo_full=$(cat ./repo)
repo_owner=$(echo $repo_full | cut -d/ -f1)
repo_name=$(echo $repo_full | cut -d/ -f2)

echo ${repo_full} ${repo_owner}

echo '[mbp]
Server = https://dl.t2linux.org/archlinux/\$repo/\$arch' >> /etc/pacman.conf
pacman-key --init
curl -o key.asc https://dl.t2linux.org/archlinux/key.asc
pacman-key --add key.asc
pacman-key --lsign 7F9B8FC29F78B339
pacman -Syu --noconfirm --needed sudo git base-devel linux-mbp linux-mbp-headers wget
useradd builduser -m
sudo -u builduser gpg --keyserver keyserver.ubuntu.com --recv-keys 38DBBDC86092693E
passwd -d builduser
printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
chown -R builduser:builduser /build

for i in apple-ibridge-dkms-git  apple-t2-audio-config  linux-t2; do
	status=13
	git submodule update --init $i
	cd $i
	for i in $(sudo -u builduser makepkg --packagelist); do
		package=$(basename $i)
		wget https://github.com/$repo_owner/$repo_name/releases/download/repo/$package \
			&& echo "Warning: $package already built, did you forget to bump the pkgver and/or pkgrel? It will not be rebuilt."
	done
	sudo -u builduser bash -c 'export MAKEFLAGS=j$(nproc) && makepkg -s --noconfirm'||status=$?

	# Package already built is fine.
	if [ $status != 13 ]; then
		exit 1
	fi
	cd ..
done

cp */*.pkg.tar.* ./
repo-add ./$repo_owner-t2.db.tar.gz ./*.pkg.tar.*

for i in *.db *.files; do
cp --remove-destination $(readlink $i) $i
done

