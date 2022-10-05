I want to avoid hosting the WiFi/BT firmware myself, so this package is currently skipped by the CI. It requires a `firmware-source.tar`. You can either get this by making a tarball of `/usr/share/firmware/wifi` in a macOS installation, or with the `get-fw.sh` script (this script dumps the firmware from a macOS Recovery image).

TL;DR To install this yourself, do:

```sh
./get-fw.sh
makepkg -i
```


