ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))/..

# Change these lines as wanted
KERNEL_VERSION=5.4
BUSYBOX_VERSION=1.37.0
ARCH=x86_64

ASSETS_DIR=$(ROOT_DIR)/assets
KERNEL_DIR=$(ASSETS_DIR)/linux-$(KERNEL_VERSION)
KERNEL_VMLINUX=$(KERNEL_DIR)/vmlinux
BUSYBOX_DIR=$(ASSETS_DIR)/busybox-$(BUSYBOX_VERSION)
BUSYBOX_OUT=$(BUSYBOX_DIR)/busybox
INITRAMFS_OUT=$(ASSETS_DIR)/initramfs.cpio.gz

BUILD_SCRIPT_DIRS=$(ROOT_DIR)/build/scripts
MODULES_DIR=$(ROOT_DIR)/modules
USERSPACE_DIR=$(ROOT_DIR)/userspace
INITRAMFS_DIR=$(ROOT_DIR)/initramfs

GDBINIT=$(ROOT_DIR)/.gdbinit

.PHONY: all kernel busybox initramfs modules userspace clean

all: kernel busybox modules userspace initramfs

kernel: $(KERNEL_VMLINUX)

$(KERNEL_VMLINUX):
	KERNEL_VERSION=$(KERNEL_VERSION) $(BUILD_SCRIPT_DIRS)/build-kernel.sh
	echo "target remote :1234" > $(GDBINIT)
	echo "file $(KERNEL_VMLINUX)" >> $(GDBINIT)

busybox: $(BUSYBOX_OUT)

$(BUSYBOX_OUT):
	BUSYBOX_VERSION=$(BUSYBOX_VERSION) $(BUILD_SCRIPT_DIRS)/build-busybox.sh

modules:
	echo "[+] Building modules..."
	make KERNEL_DIR=$(KERNEL_DIR) -C $(MODULES_DIR)

userspace:
	echo "[+] Building userspace programs..."
	make -C $(USERSPACE_DIR)

initramfs: busybox modules $(INITRAMFS_DIR)
	echo "[+] Building initramfs..."
	cd $(ASSETS_DIR) && \
		MODULES_DIR=$(MODULES_DIR) \
	 	BUSYBOX_DIR=$(BUSYBOX_DIR) \
		INITRAMFS_DIR=$(INITRAMFS_DIR) \
		INITRAMFS_OUT=$(INITRAMFS_OUT) \
		$(BUILD_SCRIPT_DIRS)/build-initramfs.sh

# Only cleans kernel modules and userspace binaries
clean:
	make KERNEL_DIR=$(KERNEL_DIR) -C $(MODULES_DIR) clean
	make -C $(USERSPACE_DIR) clean
