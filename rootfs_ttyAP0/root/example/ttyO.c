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

#define BUFF_SIZE 256

unsigned char ch;
unsigned long pkg_size;

int send_count=0;
int recv_count=0;
int send_inttime;
int loopwait;
int loop;

void threadexit(int signal){
	loopwait=0;
	loop = 0;
}

int set_Parity(int fd,int baud,int databits,int stopbits,int parity)
{ 
	int baudrate;
	struct termios options; 
	printf("set_Parity:%d-%d-%d-%c\n",baud,databits,stopbits,parity);
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
		default: 
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
    tcflush(fd,   TCIFLUSH);
	if (tcsetattr(fd,TCSANOW,&options) != 0) 
	{ 
		perror("SetupSerial"); 
		return -1; 
	} 
	
	return 0; 
}

int OpenDev(char *Dev)
{
	int fd = open(Dev,O_RDWR|O_NOCTTY|O_NDELAY); 
	if (-1 == fd) 
	{ 
		printf("Can't Open Serial Port!\n");
		return -1; 
	} 
	else 
	{ 
		printf("Success Open Serial Port.\n");
		return fd;
	}
}

void * thread_send(void * data)
{
	int fd=(int)data;
	int i=0;
	unsigned char buff[BUFF_SIZE];
	for(i=0;i<BUFF_SIZE;i++)
	{
		buff[i]=ch+i*2;
	}
	while (loop&&send_count>0) 
	{
		if(send_count>pkg_size)
		{
			write(fd,buff,pkg_size); 
			for(i=0;i<pkg_size;i++)
			{
				printf("%02x ",buff[i]);
			}
			printf("\n");
		}
		else
		{
			write(fd,buff,send_count);
			for(i=0;i<send_count;i++)
         	{
                printf("%02x ",buff[i]);
            }
	        printf("\n"); 
		}
		send_count-=pkg_size;
		usleep(send_inttime);
	}
	loopwait=0;
}

void * thread_recv(void * data)
{
	int i;
	unsigned char buff[BUFF_SIZE];
	int fd=(int)data;
	int nread;
	unsigned long readcount=0;
	unsigned long cnt=0;
	while(loop)
	{
		nread=read(fd,buff,BUFF_SIZE);
		readcount+=nread;
		if(cnt%20000==0)
			printf("readcount=%d\n",readcount);	
		if(nread!=0)
		{
			printf("recv:");
			for(i=0;i<nread;i++)
			{
				printf(" %x ",buff[i]);
			}
			printf("\n");
		}
		cnt++;
		usleep(1);
	}
	loopwait=0;
}

int input(int * val, int def)
{
	char chs[100];
	int i=0;
	while((chs[i]=getchar())!='\n' && i<10)
		i++;	
	chs[i]='\0';
	if(i!=0){
		*val=atoi(chs);
	}
	else{
		*val=def;
	}	
}

int main()
{
	int index;
	int speed;
	int tid=0;
	int fd_send,fd_recv;
	char cmd;
	signal(SIGINT,threadexit);
	loop=1;
	unsigned char devname[100];
	while(loop)
	{
		getchar();
		loopwait=1;
		fd_send=0;
		fd_recv=0;
		printf("1.发送\n");
		printf("2.接收\n");
		printf("0.退出\n");
		printf("选择你所要的操作：\n");
		scanf("%c",&cmd);
		getchar();
		switch(cmd)
		{
			case '1':
				printf("串口的index:");
				scanf("%d",&index);
				sprintf(devname,"/dev/ttyO%d",index);
				printf("device:%s\n",devname);
				fd_send=OpenDev(devname);
				ch=0x11;
				printf("每个包的长度（默认15）：");
				input(&pkg_size,15);
				printf("串口速率（默认9600）：");
				input(&speed,9600);
				set_Parity(fd_send,speed,8,1,'n');
				printf("发送包数（默认10000）：");
				input(&send_count,10000);
				send_inttime=30;
				send_inttime*=1000;
				pthread_create(&tid,NULL,(void * (*)(void*))thread_send,fd_send);
				break;
			case '2':
				printf("串口的index:");
				scanf("%d",&index);
				sprintf(devname,"/dev/ttyO%d",index);
				printf("device:%s\n",devname);
				fd_recv=OpenDev(devname);
				printf("串口速率（默认9600）：");
				input(&speed,9600);
				set_Parity(fd_recv,speed,8,1,'n');
				pthread_create(&tid,NULL,(void * (*)(void*))thread_recv,fd_recv);
				break;
			case '0':
				loop=0;
				loopwait=0;
				break;
			default:
				loop=0;
				loopwait=0;
				break;
		}
		while(loopwait)
			sleep(1);
		if(fd_send)
			close(fd_send);
		if(fd_recv)
			close(fd_recv);
	}
		
	
}
