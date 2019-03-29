#include <stdio.h>
#include "lib_xr.h"


int main()
{
	char hwid[100];
	get_hwid(hwid);
	printf("#######%s\n",hwid);
	return 0;
}
