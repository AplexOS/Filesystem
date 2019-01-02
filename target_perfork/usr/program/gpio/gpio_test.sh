#!/bin/sh

echo 44  > /sys/class/gpio/export
echo 45  > /sys/class/gpio/export
echo 46  > /sys/class/gpio/export
echo 47  > /sys/class/gpio/export
echo 110 > /sys/class/gpio/export
echo 111 > /sys/class/gpio/export
echo 112 > /sys/class/gpio/export
echo 113 > /sys/class/gpio/export

echo in > /sys/class/gpio/gpio44/direction
echo in > /sys/class/gpio/gpio45/direction
echo in > /sys/class/gpio/gpio46/direction
echo in > /sys/class/gpio/gpio47/direction
echo out > /sys/class/gpio/gpio110/direction
echo out > /sys/class/gpio/gpio111/direction
echo out > /sys/class/gpio/gpio112/direction
echo out > /sys/class/gpio/gpio113/direction


echo 1 > /sys/class/gpio/gpio110/value
echo 1 > /sys/class/gpio/gpio111/value
echo 1 > /sys/class/gpio/gpio112/value
echo 1 > /sys/class/gpio/gpio113/value

sleep 2
VALUE1=$(cat /sys/class/gpio/gpio44/value)
VALUE2=$(cat /sys/class/gpio/gpio45/value)
VALUE3=$(cat /sys/class/gpio/gpio46/value)
VALUE4=$(cat /sys/class/gpio/gpio47/value)

if [ $VALUE1 = '1' ];then
    echo "gpio44 gpio 110 ok\n"
else
    echo "gpio44 gpio 110 failed****************************************************************\n"
fi

if [ $VALUE2 = '1' ];then
    echo "gpio45 gpio 111 ok\n"
else
    echo "gpio45 gpio 111 failed****************************************************************\n"
fi

if [ $VALUE3 = '1' ];then
    echo "gpio46 gpio 112 ok\n"
else
    echo "gpio46 gpio 112 failed****************************************************************\n"
fi

if [ $VALUE4 = '1' ];then
    echo "gpio47 gpio 113 ok\n"
else
    echo "gpio47 gpio 113 failed****************************************************************\n"
fi



echo 44  > /sys/class/gpio/unexport
echo 45  > /sys/class/gpio/unexport
echo 46  > /sys/class/gpio/unexport
echo 47  > /sys/class/gpio/unexport
echo 110 > /sys/class/gpio/unexport
echo 111 > /sys/class/gpio/unexport
echo 112 > /sys/class/gpio/unexport
echo 113 > /sys/class/gpio/unexport

