#!/bin/bash

#
# launch
#
/usr/bin/qemu-system-x86_64 \
	-kernel $KERNEL_DIR/arch/x86_64/boot/bzImage \
	-initrd $INITRAMFS \
	-fsdev local,security_model=passthrough,id=fsdev0,path=$HOME_SHARE \
	-device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
	-nographic \
	-monitor none \
	-s \
	-append "console=ttyS0 nokaslr"
