ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

KERNEL_VERSION=5.4
BUSYBOX_VERSION=1.37.0
ARCH=x86_64

ASSETS_DIR=$(ROOT_DIR)/assets
KERNEL_DIR=$(ASSETS_DIR)/linux-$(KERNEL_VERSION)
KERNEL_VMLINUX=$(KERNEL_DIR)/vmlinux
BUSYBOX_DIR=$(ASSETS_DIR)/busybox-$(BUSYBOX_VERSION)
BUSYBOX_OUT=$(BUSYBOX_DIR)/busybox
INITRAMFS=$(ASSETS_DIR)/initramfs.cpio.gz

SCRIPTS_DIR=$(ROOT_DIR)/scripts
MODULES_DIR=$(ROOT_DIR)/modules
USERSPACE_DIR=$(ROOT_DIR)/userspace

FS_DIR=$(ROOT_DIR)/fs
FS_FILES=bin sbin sys usr/bin usr/sbin root home/ctf

GDBINIT=.gdbinit

.PHONY: kernel busybox fs modules clean run userspace gdbinit

run: kernel busybox modules userspace gdbinit fs
	KERNEL_DIR=$(KERNEL_DIR) \
	INITRAMFS=$(INITRAMFS) \
	HOME_SHARE=$(USERSPACE_DIR)/build \
	$(SCRIPTS_DIR)/launch.sh

kernel: $(KERNEL_VMLINUX)

$(KERNEL_VMLINUX):
	KERNEL_VERSION=$(KERNEL_VERSION) $(SCRIPTS_DIR)/build-kernel.sh
	echo "target remote :1234" > $(GDBINIT)
	echo "file $(KERNEL_VMLINUX)" >> $(GDBINIT)

busybox: $(BUSYBOX_OUT)

$(BUSYBOX_OUT):
	BUSYBOX_VERSION=$(BUSYBOX_VERSION) $(SCRIPTS_DIR)/build-busybox.sh

modules:
	echo "[+] Building modules..."
	make KERNEL_DIR=$(KERNEL_DIR) -C $(MODULES_DIR)

userspace:
	make -C $(USERSPACE_DIR)

fs: busybox modules
	echo "[+] Building filesystem..."
	cd $(FS_DIR) && mkdir -p $(FS_FILES)
	cp -a $(BUSYBOX_DIR)/_install/* fs
	cp $(MODULES_DIR)/*.ko $(FS_DIR)
	cd $(ASSETS_DIR) && \
		FS_DIR=$(FS_DIR) \
		INITRAMFS=$(INITRAMFS) \
		$(SCRIPTS_DIR)/build-fs.sh

clean:
	cd $(FS_DIR) && rm -rf $(FS_FILES) *.ko
	make KERNEL_DIR=$(KERNEL_DIR) -C $(MODULES_DIR) clean
	make -C $(USERSPACE_DIR) clean