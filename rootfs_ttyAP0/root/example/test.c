#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <signal.h>
#include <libwatchdog.h>
#include <lib_xr.h>
#include "test.h"

int loop=1;
int loop_feeddog=1;
int tid_wdt=0;

extern int loopserial;

void * th_feeddog(void * data)
{
	while(loop_feeddog)
	{
		hito_watchdog_keep_alive();
		sleep(1);
	}
}

int input(int * val, int def)                                                                                                                                           
{
	char chs[100];
	int i=0;
	while((chs[i]=getchar())!='\n' && i<10)
		i++;        
	chs[i]='\0';
	if(i!=0)
	{
		*val=atoi(chs);
	}   
	else
	{
		*val=def;
	}   
}

void test_serial()
{
	int i,baudindex;
	int testbauds[3]={4800,9600,115200};
	char serialfailed[5][100];
	char testserial_0[5][20]={"/dev/ttyO2","/dev/ttyXR79x0","/dev/ttyXR79x2","/dev/ttyXR79x4","/dev/ttyXR79x6"};
	char testserial_1[5][20]={"/dev/ttyO5","/dev/ttyXR79x1","/dev/ttyXR79x3","/dev/ttyXR79x5","/dev/ttyXR79x7"};
	int fd_r,fd_s,tid_r,tid_s;
	printf("开始测试串口......\n");
	for(baudindex=0;baudindex<3;baudindex++)
	{
		printf("测试波特率:%d\n",testbauds[baudindex]);
		for(i=0;i<5;i++)
		{
			printf("发送串口%s\n",testserial_1[i]);
			printf("接收串口%s\n",testserial_0[i]);
			printf("开始测试......\n");
			fd_r=OpenDev(testserial_0[i]);
			fd_s=OpenDev(testserial_1[i]);
			set_Parity(fd_r,testbauds[baudindex],8,1,'n');
			set_Parity(fd_s,testbauds[baudindex],8,1,'n');
			pthread_create(&tid_r,NULL,thread_recv,fd_r);
			sleep(1);
			pthread_create(&tid_s,NULL,thread_send,fd_s);
			
			pthread_join(tid_s,NULL);
			pthread_join(tid_r,NULL);

			CloseDev(fd_s);
			CloseDev(fd_r);
			
			tid_s=0;
			tid_r=0;
		}
		
		for(i=0;i<5;i++)
		{
			printf("发送串口%s\n",testserial_0[i]);
			printf("接收串口%s\n",testserial_1[i]);
			printf("开始测试......\n");
			fd_r=OpenDev(testserial_1[i]);
			fd_s=OpenDev(testserial_0[i]);
			set_Parity(fd_r,testbauds[baudindex],8,1,'n');
			set_Parity(fd_s,testbauds[baudindex],8,1,'n');
			pthread_create(&tid_r,NULL,thread_recv,fd_r);
			sleep(1);
			pthread_create(&tid_s,NULL,thread_send,fd_s);
			
			pthread_join(tid_s,NULL);
			pthread_join(tid_r,NULL);

			CloseDev(fd_s);
			CloseDev(fd_r);

			tid_s=0;
			tid_r=0;
		}
	}
}



void test_di()
{
	printf("短接开入的输入端并自行和下面显示的结果对照\n");
	system("./testdido i");
}


void test_do()
{
	unsigned char szbuf[100];
	int index;
	printf("输入你要测试的开口的index:");
	input(&index,0);
	sprintf(szbuf,"./testdido %d",index);
	system(szbuf);
}


void test_wdt_en()
{
	loop_feeddog=1;
	hito_watchdog_init(10);
	pthread_create(&tid_wdt,NULL,th_feeddog,NULL);
}

void test_wdt_stopfeed()
{
	loop_feeddog=0;
	if(tid_wdt)
		pthread_join(tid_wdt,NULL);
}



void * func(void * data)
{
	loop=1;
	loopserial=0;
}


int main()
{
	int sel;	
	signal(SIGINT,func);
	while(loop)
	{
		printf("1.串口测试\n");
		printf("2.开入口测试\n");
		printf("3.开出口测试\n");
		printf("4.使能看门狗并开始喂狗\n");
		printf("5.停止喂狗\n");
		printf("0.退出\n");
		printf("输入你要进行的测试(默认1):");
		input(&sel,1);
		switch(sel)
		{
			case 1:
				test_serial();
				break;
			case 2:
				test_di();
				break;
			case 3:
				test_do();
			case 4:
				test_wdt_en();
				break;
			case 5:
				test_wdt_stopfeed();
				break;
			case 0:
				loop=0;
				break;
		}
	}
	return 0;
}
