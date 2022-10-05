import asahi_firmware, sys
from asahi_firmware import (wifi, bluetooth)
pkg = asahi_firmware.core.FWPackage("firmware.tar")

col = wifi.WiFiFWCollection(sys.argv[1]+"/wifi")
pkg.add_files(sorted(col.files()))
col = bluetooth.BluetoothFWCollection(sys.argv[1]+"/bluetooth")
pkg.add_files(sorted(col.files()))

pkg.close()
