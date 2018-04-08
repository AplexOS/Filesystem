#include "../include/lib_dev.h"


#if 0
#define DEBUG_WTD_ALIVE
#endif

int main(int argc, char **argv)
{
    if (argc < 1)
    {
        goto ERR1;
    }

    hito_sys_led_on();
    printf("led on ............\n");
    sleep(10);
    hito_sys_led_off();
    printf("led off ............\n");

    if (strcmp(argv[1], "A") || strcmp(argv[1], "D"))
    {
            printf("Please input one argument: %c or %c...\n", 'A', 'D');
            return -1;
    }

    hito_watchdog_init(5);

    if (!strcmp(argv[1], "A"))
    {
        while(3)
        {
            hito_watchdog_keep_alive();
            sleep(3);
        }
    }
    else if (!strcmp(argv[1], "D"))
    {
        sleep(10);
    }
    else
    {
        printf("Please input one argument: %c or %c...\n", 'A', 'D');
    }

    return 0;

ERR1:
    printf("please input  led_wtd_demo D  to test led and  kill watchdog\n");
    printf("please input  led_wtd_demo A  to test led and  alive watchdog\n");

    return -1;
}
