#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/time.h>

int set_opt(int fd, int nSpeed, int nBits, char nEvent, int nStop);

int getCurrent()
{
	struct timeval tv;
    gettimeofday (&tv, NULL);
    return tv.tv_sec;
}

int main(int argc, char **argv)
{
    int node_fd, count = 10000;
    char send_chr[32] = "abcdefg1234567890\n";
    unsigned int close_s = 0,  close_e = 0;

    node_fd = open(argv[1], O_RDWR | O_NOCTTY | O_NDELAY);
    if (node_fd < 0)
        perror(argv[1]);

    set_opt(node_fd, 115200, 8, 'N', 1);

    while(1)
    {
        write(node_fd, send_chr, sizeof(send_chr));
        usleep(100 * 1000);
    }

    close_s = getCurrent();

    close(node_fd);

    close_e = getCurrent();

    printf("start : %d   end : %d\n", close_s, close_e);

    return 0;
}


int set_opt(int fd, int nSpeed, int nBits, char nEvent, int nStop)
{
    struct termios newtio, oldtio;
    if(tcgetattr(fd, &oldtio) != 0)
    {
        perror("SetupSerial 1");
        return -1;
    }
    bzero(&newtio, sizeof(newtio));
    newtio.c_cflag |= CLOCAL | CREAD;   //CLOCAL:忽略modem控制线  CREAD：打开接受者
    newtio.c_cflag &= ~CSIZE;           //字符长度掩码。取值为：CS5，CS6，CS7或CS8

    switch( nBits )
    {
    case 7:
        newtio.c_cflag |= CS7;
        break;
    case 8:
        newtio.c_cflag |= CS8;
        break;
    }

    switch( nEvent )
    {
    case 'O':
        newtio.c_cflag |= PARENB;           //允许输出产生奇偶信息以及输入到奇偶校验
        newtio.c_cflag |= PARODD;           //输入和输出是奇及校验
        newtio.c_iflag |= (INPCK | ISTRIP); // INPACK:启用输入奇偶检测；ISTRIP：去掉第八位
        break;
    case 'E':
        newtio.c_iflag |= (INPCK | ISTRIP);
        newtio.c_cflag |= PARENB;
        newtio.c_cflag &= ~PARODD;
        break;
    case 'N':
        newtio.c_cflag &= ~PARENB;
        break;
    }

    switch( nSpeed )
    {
    case 2400:
        cfsetispeed(&newtio, B2400);
        cfsetospeed(&newtio, B2400);
        break;
    case 4800:
        cfsetispeed(&newtio, B4800);
        cfsetospeed(&newtio, B4800);
        break;
    case 9600:
        cfsetispeed(&newtio, B9600);
        cfsetospeed(&newtio, B9600);
        break;
    case 115200:
        cfsetispeed(&newtio, B115200);
        cfsetospeed(&newtio, B115200);
        break;
    case 460800:
        cfsetispeed(&newtio, B460800);
        cfsetospeed(&newtio, B460800);
        break;
    case 921600:
        cfsetispeed(&newtio, B921600);
        cfsetospeed(&newtio, B921600);
        break;
    default:
        cfsetispeed(&newtio, B9600);
        cfsetospeed(&newtio, B9600);
        break;
    }

    if( nStop == 1 )
        newtio.c_cflag &=  ~CSTOPB;     //CSTOPB:设置两个停止位，而不是一个
    else if ( nStop == 2 )
        newtio.c_cflag |=  CSTOPB;

    newtio.c_cc[VTIME]  = 0;            //VTIME:非cannoical模式读时的延时，以十分之一秒位单位
    newtio.c_cc[VMIN] = 0;              //VMIN:非canonical模式读到最小字符数
    tcflush(fd, TCIFLUSH);               // 改变在所有写入 fd 引用的对象的输出都被传输后生效，所有已接受但未读入的输入都在改变发生前丢弃。
    if((tcsetattr(fd,TCSANOW,&newtio))!=0) //TCSANOW:改变立即发生
    {
        perror("com set error");
        return -1;
    }

    return 0;
}

