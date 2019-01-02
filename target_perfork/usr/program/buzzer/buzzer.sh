#!/bin/sh

echo 0 > /sys/class/pwm/pwmchip1/export
echo 1 >  /sys/class/pwm/pwmchip1/pwm0/enable
echo 200000 >  /sys/class/pwm/pwmchip1/pwm0/period

echo 100000 >  /sys/class/pwm/pwmchip1/pwm0/duty_cycle
sleep 3
echo 50000 >  /sys/class/pwm/pwmchip1/pwm0/duty_cycle
sleep 3

echo 0 > /sys/class/pwm/pwmchip1/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip1/unexport
