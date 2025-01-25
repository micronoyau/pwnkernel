# pwn.college helper environment for kernel development and exploitation

Fixed for newer kernels (issues compiling older versions).
Removed debian-based distros dependencies (to be done manually).
Added small userspace program to start playing.

**NOTE: you don't need to interact with this repo in the course of interacting with pwn.college. The kernel challenges can be solved in the infrastructure; this is just here as a way to reproduce the infrastructure locally.**

Pre-requistite:

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
