#!/bin/bash
set -e

TMP_INITRAMFS_DIR=$(mktemp -d)
pushd $TMP_INITRAMFS_DIR
# Add standard directories
mkdir -p bin sbin sys usr/bin usr/sbin root
# Add static files in initramfs dir
cp -r $INITRAMFS_DIR/* .
# Add busybox
cp -a $BUSYBOX_DIR/_install/* .
# Add modules
cp -a $MODULES_DIR/*.ko .
# Build cpio archive
find . -print0 | cpio --null -ov --format=newc | gzip -9 > $INITRAMFS_OUT
popd
