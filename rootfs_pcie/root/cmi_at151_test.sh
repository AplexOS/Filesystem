#!/bin/sh

echo "*****************buzzer test ********************"

echo 0 > /sys/class/pwm/pwmchip0/export
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 200000 >  /sys/class/pwm/pwmchip0/pwm0/period
echo 5000 >  /sys/class/pwm/pwmchip0/pwm0/duty_cycle
sleep  3
echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip0/unexport

echo "*************** eeprom test **********************"
echo "12345678910\n" > /sys/devices/platform/ocp/44e0b000.i2c/i2c-0/0-0050/eeprom
cat /sys/devices/platform/ocp/44e0b000.i2c/i2c-0/0-0050/eeprom
echo "\n";

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

tty_test

ifconfig eth0 192.168.2.101
ifconfig eth1 192.168.3.101

sleep 2
ping 192.168.2.100 -I eth0 -c 10
ping 192.168.3.210 -I eth1 -c 10


