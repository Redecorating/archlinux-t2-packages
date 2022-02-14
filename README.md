# archlinux-t2-packages

Some packages useful for T2 Macs.

The "repo" release will be updated by the ci, so that it can be used as a pacman repo:
```
[Redecorating-t2]
Server = https://github.com/Redecorating/archlinux-t2-packages/releases/download/repo
SigLevel = Optional TrustAll
```

- apple-bce-dkms-git: Exposes Keyboard, Camera, Touchbar, etc as USB devices. Also does audio.
- apple-ibridge-dkms-git: Touchbar driver, keyboard backlight on mbp16,X (ones where touchbar does not have esc key in it)
- apple-t2-audio-config: audio config files for the audio device apple-bce has. 16" MBPs need the "-alt" one, MBA9,1 probably won't work, see [here](https://wiki.t2linux.org/guides/audio-config/) for that one.
- gpu-switch: just the aur package, for use on 15-16" MBPs with https://wiki.t2linux.org/guides/hybrid-graphics/
- linux-t2: kernel with patches for T2 support and apple-bce + apple-ibridge included
- wifi-fw: not on the releases, see [here](./wifi-fw/README.md)
