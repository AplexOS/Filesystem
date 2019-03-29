#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <linux/watchdog.h>

int main()
{
	int timeout;
	int fd;
	fd=open("/dev/misc/watchdog", O_RDWR);
	printf("fd:%d\n",fd);
	timeout = 30;
    ioctl(fd, WDIOC_SETTIMEOUT, &timeout); 
	while(1)
	{
		ioctl(fd, WDIOC_KEEPALIVE, NULL);
		sleep(5);
	}
	return 0;
}
