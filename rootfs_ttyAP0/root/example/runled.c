#include <stdio.h>
#include <unistd.h>

#include "uklib.h"


int main(int argc,char *argv[])
{
	while(1){
		hito_sys_led_on();
		printf("运行灯亮5秒\n");
		sleep(5);
		hito_sys_led_off();
		printf("运行灯灭5秒\n");
		sleep(5);
	}
	return 0;
}
