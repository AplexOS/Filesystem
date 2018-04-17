#!/bin/sh

if [ $1 = '0' ]; then
    echo 1 > /dev/DO0
    cat /dev/DI0 | grep 0
fi

if [ $1 = '1' ]; then
    echo 1 > /dev/DO1
    cat /dev/DI1 | grep 0
fi

if [ $1 = '2' ]; then
    echo 1 > /dev/DO2
    cat /dev/DI2 | grep 0
fi

if [ $1 = '3' ]; then
    echo 1 > /dev/DO3
    cat /dev/DI3 | grep 0
fi

echo 0 > /dev/DO0
echo 0 > /dev/DO1
echo 0 > /dev/DO2
echo 0 > /dev/DO3
