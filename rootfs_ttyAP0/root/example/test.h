#ifndef __TEST_H__
#define __TEST_H__


int OpenDev(char *Dev);
void CloseDev(int fd);
int set_Parity(int fd,int baud,int databits,int stopbits,int parity);
void * thread_send(void * data);
void * thread_recv(void * data);

void *  cansend(void * data);
void *  canrecv(void * data);

#endif