#include <stdio.h>
#include <unistd.h>

#include "uklib.h"


int main(int argc,char *argv[])
{
	int id;
	int fd;
	int val;
	int i;
	printf("argc:%d\n",argc);
	if(argc!=2&&argc!=3){
		printf("Please use this application as:\n");
		printf("\.\/testdido 0\n");
		printf("Or\n");
		printf("\.\/testdido i 0\n");
		return -1;
	}
	fd=hito_open_dido();
	if(fd==-1){
		printf("no device\n");
		return -1;
	}
	if(strcmp(argv[1],"i")!=0){
		id=atoi(argv[1]);
		while(1){
			hito_set_do(fd,id,0);
			sleep(2);
			hito_set_do(fd,id,1);
			sleep(2);
		}
	}else{
		while(1){
			for(i=0;i<2;i++){
				val=hito_get_di(fd,i);
				printf("id:%d,val:%d\n",i,val);
				sleep(1);
			}
		}
	}
	return 0;
}
