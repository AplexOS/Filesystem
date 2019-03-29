#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <fcntl.h>
#include "uklib.h"

#define MAX_ETH_NUM 4
#define MAX_ADR_LEN 20

char ipaddrs[MAX_ETH_NUM][MAX_ADR_LEN]={"192.168.2.10","192.168.3.10","192.168.4.10","192.168.5.10"};

int setip()
{
	int i;
	FILE *fp;
	unsigned char ipaddr[20],netmask[20],gwaddr[20];
	unsigned char tmp[100],result[100],*ptmp;
	for(i=0;i<MAX_ETH_NUM;i++)
	{
		memset(tmp,0,sizeof(tmp));
		sprintf(tmp,"cat /etc/net.conf | grep eth%d_ipaddr | awk -F= \'{print $2}\'",i);
		fp=popen(tmp,"r");
		memset(ipaddr,0,sizeof(ipaddr));
		ptmp=fgets(ipaddr,sizeof(ipaddr),fp);
		if(strlen(ipaddr)>1)
			ipaddr[strlen(ipaddr)-1]='\0';
		pclose(fp);
		memset(tmp,0,sizeof(tmp));
		sprintf(tmp,"cat /etc/net.conf | grep eth%d_netmask | awk -F= \'{print $2}\'",i);	
		fp=popen(tmp,"r");
        memset(netmask,0,sizeof(netmask));
        ptmp=fgets(netmask,sizeof(netmask),fp);
        pclose(fp);
		memset(tmp,0,sizeof(tmp));
		sprintf(tmp,"ifconfig eth%d %s netmask %s",i,ipaddr,netmask);
		printf("tmp:%s\n",tmp);
		system(tmp);
	}

	memset(tmp,0,sizeof(tmp));
	sprintf(tmp,"cat /etc/net.conf | grep gateway_addr | awk 'NR==1 {print $1}' | awk -F= \'{print $2}\'");
	fp=popen(tmp,"r");
	memset(gwaddr,0,sizeof(gwaddr));
	ptmp=fgets(gwaddr,sizeof(gwaddr),fp);
	if(strlen(gwaddr)>1)
		gwaddr[strlen(gwaddr)-1]='\0';
	pclose(fp);
	if(strlen(gwaddr)>1){
		memset(tmp,0,sizeof(tmp));
		sprintf(tmp,"route add default gw %s",gwaddr);
		system(tmp);
	}
}

int resetip()
{
	int i;
    char tmp[100];
    for(i=0;i<MAX_ETH_NUM;i++)
    {
		memset(tmp,0,sizeof(tmp));
        sprintf(tmp,"ifconfig eth%d %s",i,ipaddrs[i]);
        system(tmp);
    }
}

int main()
{
	int fd,first=1,ip_reset,val;
	fd=open("/dev/ukio",O_RDWR);
    if(fd<=0)
	{
        printf("don't have the device ukio\n");
    }   
    while(1)
	{
		if(fd)
        	ioctl(fd,UKIO_IPRESET,&ip_reset);
        if(ip_reset==1 || first==1)
		{
			if(first==1)
			{
				setip();
				first=0;
			}
			else if(ip_reset==1)
			{
				sleep(2);
				ioctl(fd,UKIO_DEFAULT,&val);
				if(val==0)
				{
					resetip();
            		printf("reset\n");
				}	
			}
			else;
    	}
        sleep(1);
    }   
    close(fd);
}
