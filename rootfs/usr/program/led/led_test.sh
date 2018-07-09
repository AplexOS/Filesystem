#!/bin/sh

echo 29  > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio29/direction

echo 1 > /sys/class/gpio/gpio29/value
sleep 5
echo 0 > /sys/class/gpio/gpio29/value

echo 29  > /sys/class/gpio/unexport
