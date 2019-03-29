#include <stdio.h>
#include <unistd.h>
#include "libwatchdog.h"

int main()
{
	int count=0;
	hito_watchdog_init(10);
	while(1)
	{
		hito_watchdog_keep_alive();
		usleep(500000);
	}
}
