#include "../include/aplex_tty.h"

int main(void)
{
    struct aplex_tty aplex_tty1;
    pid_t pid1;

    char tty_node1[] = "/dev/ttyO1";
    int test_count = 500;
    unsigned int usleep_time = 10000;
    char test_chr[32] = "abcdefg9876543210";

    init_aplex_tty(&aplex_tty1, tty_node1, test_count, usleep_time, test_chr);
    if ((pid1 = fork()) < 0)
    {
        perror("fork error1");
    }
    else if(pid1 == 0)
    {
        test_tty(&aplex_tty1);
        exit(1);
    }

    return 0;
}
