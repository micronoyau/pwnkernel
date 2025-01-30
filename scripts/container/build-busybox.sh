#!/bin/bash -e
# To be run in container

echo "[+] Downloading busybox..."
cd
[ -e busybox-$BUSYBOX_VERSION ] || wget -q -c https://busybox.net/downloads/busybox-$BUSYBOX_VERSION.tar.bz2
[ -e busybox-$BUSYBOX_VERSION ] || tar xjf busybox-$BUSYBOX_VERSION.tar.bz2
mv busybox-$BUSYBOX_VERSION /build

echo "[+] Building busybox..."
cd /build
make -C busybox-$BUSYBOX_VERSION defconfig
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/g' busybox-$BUSYBOX_VERSION/.config
sed -i 's/CONFIG_TC=y/# CONFIG_TC is not set/g' busybox-$BUSYBOX_VERSION/.config # Issues compiling busybox on recent kernels
make -C busybox-$BUSYBOX_VERSION -j16
make -C busybox-$BUSYBOX_VERSION install