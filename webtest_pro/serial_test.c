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

#define _TTY_NUM  10

int set_opt(int fd, int nSpeed, int nBits, char nEvent, int nStop);

int main(int argc, char *argv[])
{
    char node_name1[20], node_name2[20];
    char read_chr[10], write_chr[10] = "01234abcd";
    int node_fd1, node_fd2;
    int read_ret = 0, read_count =0;

    strcpy(node_name1, argv[1]);
    strcpy(node_name2, argv[2]);

    node_fd1 = open(node_name1, O_RDWR | O_NOCTTY | O_NDELAY);
    if (node_fd1 < 0)
        perror(node_name1);

    node_fd2 = open(node_name2, O_RDWR | O_NOCTTY | O_NDELAY);
    if (node_fd2 < 0)
        perror(node_name2);

    set_opt(node_fd1, 115200, 8, 'N', 1);
    set_opt(node_fd2, 115200, 8, 'N', 1);

    while((read_count  <= 3) && (!read_ret))
    {
        write(node_fd1, write_chr, sizeof(write_chr));
        usleep(100000);
        read_ret = read(node_fd2, read_chr, sizeof(read_chr));
        read_count++;

        printf("%s\n",write_chr);
        printf("ret : %d        %s\n", read_ret, read_chr);
    }

    if ( !strcmp(read_chr, write_chr) )
        printf("%s send ok,  %s recv ok\n", node_name1, node_name2);
    else
        printf("%s send fail,  %s recv fail*****************************\n", node_name1, node_name2);

    read_count = 0;
    read_ret = 0;
    bzero(read_chr, 10);

    usleep(100000);

    close(node_fd1);
    close(node_fd2);

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

