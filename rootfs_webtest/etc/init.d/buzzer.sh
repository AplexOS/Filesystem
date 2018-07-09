#!/bin/sh

echo 0 > /sys/class/pwm/pwmchip1/export

echo 200000 >  /sys/class/pwm/pwmchip1/pwm0/period
echo 5000 > /sys/class/pwm/pwmchip1/pwm0/duty_cycle
echo 1 >  /sys/class/pwm/pwmchip1/pwm0/enable

sleep 2

echo 0 > /sys/class/pwm/pwmchip1/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip1/unexport

echo okay
