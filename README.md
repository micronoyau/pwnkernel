# pwn.college helper environment for kernel development and exploitation

## pwn.kernel fork

Improvements compared to main project :
 - Building is done in a container : no compilation problems on newer kernels
 - Added small userspace programs to start playing.

**NOTE: you don't need to interact with this repo in the course of interacting with pwn.college. The kernel challenges can be solved in the infrastructure; this is just here as a way to reproduce the infrastructure locally.**

## Setup

### Create docker image

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

Running the kernel: (this will build everything automatically for you)

```
$ make run
```

All modules will be in `/`, ready to be `insmod`ed, and the host's userspace build directory will be mounted as `/home/ctf` in the guest.
