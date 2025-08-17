# pwn.college helper environment for kernel development and exploitation

**NOTE: you don't need to interact with this repo in the course of interacting with pwn.college. The kernel challenges can be solved in the infrastructure; this is just here as a way to reproduce the infrastructure locally.**

## Project structure

```
.
├── assets
├── build
│   ├── build.Dockerfile            # Dockerfile to build "build" image
│   ├── Makefile                    # Makefile to build kernel, busybox, modules, userspace programs and initramfs
│   └── scripts                     # Various build scripts
│       ├── build-busybox.sh
│       ├── build-initramfs.sh
│       ├── build-kernel.sh
│       ├── container               # Scripts used inside container
│       └── setup.sh
├── doc                             # Some doc
├── initramfs                       # Base initial ram filesystem (you can add stuff in there)
├── launch.sh                       # Utility script to launch kernel once it is built
├── LICENSE
├── modules                         # Various toy modules
│   ├── hello_dev_char.c
│   ├── hello_ioctl.c
│   ├── hello_log.c
│   ├── hello_proc_char.c
│   ├── Makefile
│   └── make_root.c
├── README.md
└── userspace                       # Various toy userspace programs
    ├── Makefile
    └── src
        ├── expl.c
        └── read.S

```

## pwnkernel fork

Improvements compared to main project :
 - Building is done in a container : no compilation problems on newer kernels.
 - Added small userspace programs to start playing.

## Setup

### Create build docker image

First, run `scripts/setup.sh` : this will build a docker image capable of building older kernels.

### Build stuff

Building the kernel, busybox, demo modules, filesystem (initramfs) and userspace programs :

```
$ make kernel
$ make busybox
$ make modules
$ make fs
$ make userspace
```

Or simply `make`.

Update version numbers in the Makefile as desired.

## Running the kernel

```
./launch.sh <compressed kernel image> <initramfs> <home share>
```

All modules will be in `/`, ready to be `insmod`ed, and the host's userspace build directory will be mounted as `/home/hacker` in the guest.
