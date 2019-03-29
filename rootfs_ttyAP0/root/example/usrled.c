#include <stdio.h>
#include <unistd.h>

#include "uklib.h"


int main(int argc,char *argv[])
{
	int uled=0;
	int id=0,on=0;
	while(1)
	{
		uled=hito_get_uled();
		printf("ULED:%x\n",uled);
		printf("输入设置的灯:");
		scanf("%d",&id);
		printf("输入亮灭情况(1亮0灭):");
		scanf("%d",&on);
		hito_set_uled(id,on);
		sleep(1);
	}
	return 0;
}
