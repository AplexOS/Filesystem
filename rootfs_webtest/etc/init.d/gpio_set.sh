#!/bin/sh

echo 29 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio29/direction
ln -s  /sys/class/gpio/gpio29/value   /dev/LED1

echo 44 > /sys/class/gpio/export
echo 45 > /sys/class/gpio/export
echo 46 > /sys/class/gpio/export
echo 47 > /sys/class/gpio/export

echo 2 > /sys/class/gpio/export
echo 3 > /sys/class/gpio/export
echo 40 > /sys/class/gpio/export
echo 41 > /sys/class/gpio/export

echo 110 > /sys/class/gpio/export
echo 111 > /sys/class/gpio/export
echo 112 > /sys/class/gpio/export
echo 113 > /sys/class/gpio/export

echo in > /sys/class/gpio/gpio44/direction
echo in > /sys/class/gpio/gpio45/direction
echo in > /sys/class/gpio/gpio46/direction
echo in > /sys/class/gpio/gpio47/direction

echo in > /sys/class/gpio/gpio3/direction
echo in > /sys/class/gpio/gpio41/direction

echo out > /sys/class/gpio/gpio110/direction
echo out > /sys/class/gpio/gpio111/direction
echo out > /sys/class/gpio/gpio112/direction
echo out > /sys/class/gpio/gpio113/direction

echo out > /sys/class/gpio/gpio2/direction
echo out > /sys/class/gpio/gpio40/direction

ln -s  /sys/class/gpio/gpio44/value  /dev/GPIO_IN0
ln -s  /sys/class/gpio/gpio45/value  /dev/GPIO_IN1
ln -s  /sys/class/gpio/gpio46/value  /dev/GPIO_IN2
ln -s  /sys/class/gpio/gpio47/value  /dev/GPIO_IN3

ln -s  /sys/class/gpio/gpio110/value  /dev/GPIO_OUT0
ln -s  /sys/class/gpio/gpio111/value  /dev/GPIO_OUT1
ln -s  /sys/class/gpio/gpio112/value  /dev/GPIO_OUT2
ln -s  /sys/class/gpio/gpio113/value  /dev/GPIO_OUT3

ln -s  /sys/class/gpio/gpio2/value   /dev/I2C2_SDA
ln -s  /sys/class/gpio/gpio3/value   /dev/I2C2_SCL
ln -s  /sys/class/gpio/gpio40/value  /dev/CAN_TX
ln -s  /sys/class/gpio/gpio41/value  /dev/CAN_RX

echo 1 > /dev/GPIO_OUT0
echo 1 > /dev/GPIO_OUT1
echo 1 > /dev/GPIO_OUT2
echo 1 > /dev/GPIO_OUT3

echo 1 > /dev/I2C2_SDA
echo 1 > /dev/CAN_TX

while [ 1 ]
do
    echo 1 >  /dev/LED1
    sleep 1
    echo 0 >  /dev/LED1
    sleep 1
done
