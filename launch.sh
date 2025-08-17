#!/bin/bash
set -e

if [ $# -ne 3 ]; then
	echo "Usage: $0 <compressed kernel image> <initramfs> <home share>"
	exit 1
fi

/usr/bin/qemu-system-x86_64 \
	-kernel $1 \
	-initrd $2 \
	-fsdev local,security_model=passthrough,id=fsdev0,path=$3 \
	-device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
	-nographic \
	-monitor none \
	-s \
	-append "console=ttyS0 nokaslr"
