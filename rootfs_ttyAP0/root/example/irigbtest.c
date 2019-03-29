#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <signal.h>
#include <libwatchdog.h>
#include <lib_xr.h>
#include "test.h"

int loop=1;

int main()
{
	int fd;
	int i=0;
	int rdcnt,tmp;	
	char buf[256];

	memset(buf,0,sizeof(buf));
	fd = open("/dev/irigb",O_RDWR);
	if (fd < 0 )
		return -1;
	while(loop)
	{
		rdcnt = read(fd,buf,tmp);
		for(i=0; i<5; i++)
			printf("buf[%d]=%d\n",i,buf[i]);
		memset(buf,0,sizeof(buf));
		sleep(1);
	}
	return 0;
}
