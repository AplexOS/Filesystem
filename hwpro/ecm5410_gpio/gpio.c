#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void gpio_help(void)
{
	printf( \
        " USAGE\r\n" \
        "    -d: device node, \r\n" \
        "       /dev/DO0  /dev/DO1  /dev/DO2  /dev/DO3  \r\n"\
        "       /dev/GPIO1  /dev/GPIO2  /dev/GPIO3  /dev/GPIO4  \r\n"\
        "       /dev/GPIO_A  /dev/GPIO_B  /dev/LED_GPIO_0  /dev/LED_GPIO_1  \r\n"\
        "       /dev/RUN_LED  \r\n"\
        "    -o: output 1 or 0\r\n" \
        "       1 is set high\r\n" \
        "       0 is set low\r\n" \
        " EXAMPLE:\r\n" \
        "     # gpio  -d /dev/DO0   -o 0\r\n" \
        "     # gpio  -d /dev/GPIO1   -o 0\r\n" \
        "     # gpio  -d /dev/GPIO_A   -o 0\r\n" \
        "     # gpio  -d /dev/RUN_LED   -o 0\r\n" \
	);
}

int main(int argc, char **argv)
{
    char shell_str[128], device_node[64];
    int ch = 0;

    if(argc == 1)
    {
        gpio_help();
        return -1;
    }

    printf("chenfulin test2\n");

    if ((argc < 3) && !(strcmp(argv[2], "help")))
    {
        gpio_help();
        return -1;
    }

    printf("%d   chenfulin test1\n", argc);

	while((ch = getopt(argc, argv, "d:D:o:h")) != -1)
	{
        printf("c : %d\n", ch);
        printf("c : %c\n", (char)ch);
		switch(ch) {
			case 'd':
                //printf("%s\n", optarg);
			case 'D':
                //printf("%s\n", optarg);
                sprintf(device_node, "%s", optarg);
				break;
			case 'o':
                //printf("%s\n", optarg);
                sprintf(shell_str, "echo %s > %s", optarg, device_node);
				break;
			case 'h':
			default:
				gpio_help();
				exit(-1);
				break;
		}
    }
    //printf("%s\n",shell_str);
    system(shell_str);

    return 0;
}

