#!/bin/sh

echo in > /sys/class/gpio/gpio56/direction
echo out > /sys/class/gpio/gpio57/direction
echo in > /sys/class/gpio/gpio58/direction
echo out > /sys/class/gpio/gpio59/direction

echo 0 > /dev/GPIO4
echo 0 > /dev/GPIO2

if [ $1 = '1' ]; then
    echo 1 > /dev/GPIO2
    cat /dev/GPIO1 | grep 1
fi

if [ $1 = '2' ]; then
    echo 1 > /dev/GPIO4
    cat /dev/GPIO3 | grep 1
fi

