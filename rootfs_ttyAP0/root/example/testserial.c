#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include "test.h"


#define SEND_SIZE	256
#define BUFF_SIZE 	1024
#define SEND_CONT	1024

static char	lastdata		=0xff;
unsigned int	loopserial	=0;

static int  check(unsigned char * buff,int count)
{
	int i;
	unsigned char val_pre,val_nxt;
	int ret=0;

	val_pre=lastdata;
	i=0;
	do{
		val_nxt=buff[i];
		if(!(val_nxt==val_pre+1||(val_nxt==0&&val_pre==0xff)))
		{
			ret=1;
			printf("error:\n");
			printf("pre:%x:nxt:%x\n",val_pre,val_nxt);
		}
		val_pre=val_nxt;
		i++;
	}while(i<count);
	lastdata=val_nxt;
	return ret;
}




void * thread_send(void * data)
{
	int fd=(int)data;
	int i=0;
	unsigned char buff[SEND_SIZE];
	for(i=0;i<SEND_SIZE;i++)
	{
		buff[i]=i;
	}

	for(i=0;i<SEND_CONT/SEND_SIZE&&loopserial;i++)
	{
		write(fd,buff,SEND_SIZE);
		usleep(500);
	}
	
	sleep(3);
	
	loopserial=0;
}

void * thread_recv(void * data)
{
	int i,retval,ret=0;
	int fd=(int)data;
	unsigned char buff[BUFF_SIZE];
	int nread;
	unsigned long readcount=0;
	lastdata=0xff;
	loopserial=1;
	
	while(loopserial)
	{  
		nread=read(fd,buff,BUFF_SIZE);
		if(nread!=0)
		{
			readcount+=nread; 
			retval=check(buff,nread);
		}
		if(retval==1)
			ret=1;
        	usleep(1);
	}
	if(readcount==SEND_CONT&&ret==0)
		printf("no error\n");
	else if(readcount!=SEND_CONT)
		printf("lost some pkgs:%d\n",SEND_CONT-readcount);
	else
		printf("some pkgs error\n");
}


int OpenDev(char *Dev)
{
	int fd = open(Dev,O_RDWR|O_NOCTTY|O_NDELAY); 
	if (-1 == fd) 
	{ 
        	printf("Can't Open DEVICE %s!\n",Dev);
        	return -1; 
	} 
	else 
	{
		//printf("Success Open DEVICE %s!\n",Dev);
		return fd;
	}
}

void CloseDev(int fd)
{
	if(fd>0)
		close(fd);
}


int set_Parity(int fd,int baud,int databits,int stopbits,int parity)
{ 
	int baudrate;
	struct termios options; 
	switch(baud)
	{
		case 2400:              
            		baudrate=B2400;                 
            		break;
		case 4800:
			baudrate=B4800;                 
            		break;
		case 9600:
			baudrate=B9600;                 
			break;
		case 115200:            
			baudrate=B115200;               
			break;
		case 19200:             
			baudrate=B19200;                
			break;
		case 38400:             
			baudrate=B38400;                
			break;
		case 57600:             
			baudrate=B57600;                
			break;
		default :               
			baudrate=B9600;                 
			break;
	}

	tcgetattr(fd,&options);
	bzero(&options,sizeof(options));
	options.c_cflag &= ~CSIZE; 
	
	switch (databits) 
	{ 
		case 7: 
			options.c_cflag |= CS7; 
			break;
		case 8: 
			options.c_cflag |= CS8;
			break; 
	}
    
	switch (parity) 
	{ 
		case 'n':
		case 'N': 
			options.c_cflag &= ~PARENB;
			options.c_iflag &= ~INPCK; 
			break; 
		case 'o': 
		case 'O': 
			options.c_cflag |= (PARODD | PARENB); 
			options.c_iflag |= INPCK; 
			break; 
		case 'e': 
		case 'E': 
			options.c_cflag |= PARENB; 
			options.c_cflag &= ~PARODD; 
			options.c_iflag |= INPCK; 
			break;
		case 'S': 
		case 's': 
			options.c_cflag &= ~PARENB;
			options.c_cflag &= ~CSTOPB;
            		break; 
		default: 
			options.c_cflag &= ~PARENB;
			options.c_iflag &= ~INPCK; 
			break; 
	} 
    
	switch (stopbits)
	{ 
		case 1: 
			options.c_cflag &= ~CSTOPB; 
			break; 
		case 2: 
			options.c_cflag |= CSTOPB; 
			break;
		default: 
			options.c_cflag &= ~CSTOPB; 
			break; 
	}   

	options.c_cc[VTIME] = 0; 
	options.c_cc[VMIN] = 0; 
	options.c_cflag   |=   (CLOCAL|CREAD);
	options.c_oflag   |=   OPOST;
	options.c_oflag   |=   CRTSCTS;
	options.c_iflag   |=   (IXON|IXOFF|IXANY);
	cfsetispeed(&options,baudrate);
	cfsetospeed(&options,baudrate);
	tcflush(fd,TCIFLUSH);
	if (tcsetattr(fd,TCSANOW,&options) != 0) 
	{ 
		perror("SetupSerial"); 
		return -1; 
	} 
    
	return 0; 
}