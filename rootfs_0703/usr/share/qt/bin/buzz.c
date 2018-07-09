#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <linux/fs.h>
#include <unistd.h>     
#include <signal.h>     
#include <string.h>     
#include <sys/time.h>   
#include <sys/ioctl.h>

#define LED_FILE "/dev/buzzer_ctl"
#define IO_VAULE_H          55  
#define IO_VAULE_L          56

int main (void )
{
	char ledon = IO_VAULE_H;
	char ledoff = IO_VAULE_L;
	unsigned int i,j;
	int fd;

	

	fd =  open (LED_FILE,O_RDWR);
	if ( fd < 0) {
		printf ("open device faild\n");
		return 1;
	}	
	j = 0;
	while(j  != 4 ) {
		for ( i = 0; i < 1000; i++ ) 
		{
			usleep(600);
			ioctl(fd,IO_VAULE_H);
			usleep(100);
			ioctl(fd,IO_VAULE_L);
		}
		for ( i = 0; i < 1000; i++ ) 
		{
			usleep(400);
			ioctl(fd,IO_VAULE_H);
			usleep(100);
			ioctl(fd,IO_VAULE_L);
		}
		j++;
	}
		close (fd);
	return 0;
}

