#include "../include/aplex_tty.h"

void open_uart_set_mode(int gpio)
{
    char open_command[128], set_output_command[128];

    sprintf(open_command, "echo %d > /sys/class/gpio/export ", gpio);
    system(open_command);

    sprintf(set_output_command, "echo out > /sys/class/gpio/gpio%d/direction ", gpio);
    system(set_output_command);
}

void set_uart_mode(int gpio, int value)
{
    char set_gpio_value_command[128];

    sprintf(set_gpio_value_command, "echo %d > /sys/class/gpio/gpio%d/value ", value, gpio);
    system(set_gpio_value_command);
}

void close_uart_set_mode(int gpio)
{
    char close_command[128];

    sprintf(close_command, "echo %d > /sys/class/gpio/unexport ", gpio);
    system(close_command);
}

int main(void)
{
    struct aplex_tty aplex_tty1;
    int gpio_array[3] = {22, 23, 19}, i;

    char tty_node1[] = "/dev/ttyO1";
    int test_count = 500;
    unsigned int usleep_time = 10000;
    char test_chr[32] = "abcdefg9876543210";

    for (i = 0; i < 3; i++)
    {
        open_uart_set_mode(gpio_array[i]);
    }

    set_uart_mode(22, 1);
    set_uart_mode(23, 0);
    set_uart_mode(19, 0);

    init_aplex_tty(&aplex_tty1, tty_node1, test_count, usleep_time, test_chr);
    test_tty(&aplex_tty1);

    for (i = 0; i < 3; i++)
    {
        close_uart_set_mode(gpio_array[i]);
    }

    return 0;
}
