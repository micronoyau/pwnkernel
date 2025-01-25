#!/bin/bash

#
# build root fs
#
pushd $FS_DIR
find . -print0 | cpio --null -ov --format=newc | gzip -9 > $INITRAMFS
popd