

This repository is no longer being updated. The following repository can be used instead:

```
[arch-mact2]
Server = https://mirror.funami.tech/arch-mact2/os/x86_64
SigLevel = Never
```
# archlinux-t2-packages

Some packages useful for T2 Macs.

The "packages" release will be updated by the CI, so that it can be used as a `pacman` repo.

Add this to the end of `/etc/pacman.conf`

```
[Redecorating-t2]
Server = https://github.com/Redecorating/archlinux-t2-packages/releases/download/packages
```

When you try to install a package from this, `pacman` will prompt you to add the key that the CI uses to sign the packages (this key is stored in GitHub secrets). The key id will be "DEB7F121BAAA6F4E":

```
:: Import PGP key DEB7F121BAAA6F4E, "Unknown Packager"? [Y/n] y
```

If you aren't prompted with that, see the Troubleshooting section below.

Then you should be able to install and update packages with `pacman`.

- ~~apple-bce-dkms-git: Exposes Keyboard, Camera, Touchbar, etc as USB devices. Also does audio.~~ This is an old version, probably don't use it. linux-t2 does not need this.
- apple-ibridge-dkms-git: Touchbar driver, keyboard backlight on mbp16,X (ones where touchbar does not have esc key in it)
- apple-t2-audio-config: audio config files for the audio device apple-bce has.
- gpu-switch: just the aur package, for use on 15-16" MBPs with https://wiki.t2linux.org/guides/hybrid-graphics/
- linux-t2: kernel with patches for T2 support and apple-bce + apple-ibridge included (you don't need the dkms versions of these for this kernel.)
- wifi+bt-fw: not on the releases, see [here](./wifi-fw/README.md)

## Troubleshooting

- If pacman doesn't prompt you for the key, try manually installing it:
```
sudo pacman-key -d F1E594DC4F486C4D04ECB43FDEB7F121BAAA6F4E
sudo pacman-key --recv-keys F1E594DC4F486C4D04ECB43FDEB7F121BAAA6F4E --keyserver keyserver.ubuntu.com || sudo pacman-key --recv-keys F1E594DC4F486C4D04ECB43FDEB7F121BAAA6F4E
sudo pacman-key --lsign-key F1E594DC4F486C4D04ECB43FDEB7F121BAAA6F4E
```
