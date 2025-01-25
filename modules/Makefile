ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# add more modules here!
MODULES=hello_dev_char hello_ioctl hello_log hello_proc_char make_root
obj-m=$(patsubst %,%.o,$(MODULES))

.PHONY: all clean

all:
	make -C $(KERNEL_DIR) M=$(ROOT_DIR) modules

clean:
	make -C $(KERNEL_DIR) M=$(ROOT_DIR) clean