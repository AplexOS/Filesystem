#!/bin/sh

echo "*****************TTY test******************"
tty_test5416

echo "*****************DI DO test *****************"
echo 0 > /dev/DO0
echo 0 > /dev/DO1
echo 0 > /dev/DO2
echo 0 > /dev/DO3
sleep 1

if [ `cat /dev/DI0` == 1 ]; then
    echo "DI0 DO0 ok"
else
    echo "DI0 DO0 fail"
fi

if [ `cat /dev/DI1` == 1 ]; then
    echo "DI1 DO1 ok"
else
    echo "DI1 DO1 fail"
fi

if [ `cat /dev/DI2` == 1 ]; then
    echo "DI2 DO2 ok"
else
    echo "DI2 DO2 fail"
fi

if [ `cat /dev/DI3` == 1 ]; then
    echo "DI3 DO3 ok"
else
    echo "DI3 DO3 fail"
fi

echo 1 > /dev/DO0
echo 1 > /dev/DO1
echo 1 > /dev/DO2
echo 1 > /dev/DO3
sleep 1

if [ `cat /dev/DI0` == 0 ]; then
    echo "DI0 DO0 ok"
else
    echo "DI0 DO0 fail"
fi

if [ `cat /dev/DI1` == 0 ]; then
    echo "DI1 DO1 ok"
else
    echo "DI1 DO1 fail"
fi

if [ `cat /dev/DI2` == 0 ]; then
    echo "DI2 DO2 ok"
else
    echo "DI2 DO2 fail"
fi

if [ `cat /dev/DI3` == 0 ]; then
    echo "DI3 DO3 ok"
else
    echo "DI3 DO3 fail"
fi
echo "**********************gpio led test **********************"
echo 1 >  /dev/GPIO_A
echo 1 >  /dev/GPIO_B
echo 1 >  /dev/LED_GPIO_0
echo 1 >  /dev/LED_GPIO_1
echo 1 >  /dev/IO_LED1

echo "*********************** rtc test ************************"
date -s '2017-06-28 19:23:56'
hwclock -w
hwclock -r
sleep 5
hwclock -r

echo "**************** watchdog device list *******************"
ls /dev/watchdog

if [ -e /dev/watchdog ]; then
    ls  /dev/watchdog
    echo "watchdog test ok ...................................."
else
    echo "watchdog test error**********************************"
fi

ifconfig eth0 192.168.2.11
sleep 2
ping 192.168.2.100 -I eth0 -c 5
ifconfig eth0 down

ifconfig eth1 192.168.2.12
sleep 2
ping 192.168.2.100 -I eth1 -c 5
ifconfig eth1 192.168.3.11

ifconfig eth2 192.168.2.13
sleep 2
ping 192.168.2.100 -I eth2 -c 5
ifconfig eth2 192.168.4.11

ifconfig eth3 192.168.2.14
sleep 2
ping 192.168.2.100 -I eth3 -c 5
ifconfig eth3 192.168.5.11

ifconfig eth0 192.168.2.11

echo 0 >  /dev/GPIO_A
echo 0 >  /dev/GPIO_B
echo 0 >  /dev/LED_GPIO_0
echo 0 >  /dev/LED_GPIO_1
echo 0 >  /dev/IO_LED1


