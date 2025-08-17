ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PROGRAMS=read expl

BUILD_DIR=$(ROOT_DIR)/build
OBJ_DIR=$(BUILD_DIR)/obj
BINARY_FILES=$(patsubst %,$(BUILD_DIR)/%.bin,$(PROGRAMS))
OBJ_FILES=$(patsubst %,$(OBJ_DIR)/%.o,$(PROGRAMS))

SRC_DIR=$(ROOT_DIR)/src

.PHONY: all clean

all: $(BINARY_FILES)

$(BUILD_DIR)/%.bin: $(OBJ_DIR)/%.o
	ld $< -o $@
	echo "end"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.S $(OBJ_DIR)
	nasm -f elf64 $< -o $@

$(BUILD_DIR)/%.bin: $(SRC_DIR)/%.c $(BUILD_DIR)
	gcc -static -o $@ $<

$(OBJ_DIR):
	mkdir -p $@

$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)
