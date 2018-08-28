#!/bin/sh

echo ""
echo ""
echo "Network test"
ifconfig eth0 192.168.2.201
ifconfig eth1 192.168.3.201
sleep 2

ping 192.168.2.100 -c 5
ping 192.168.3.210 -c 5

echo ""
echo ""
echo "USB test"
ls /dev/sd*

echo ""
echo ""
echo "DI DO test"

/root/DIDO.sh &

echo ""
echo ""
echo "rtc test"
date -s '2017-06-08 19:23:56'
hwclock -w
hwclock -r
sleep 5
hwclock -r

echo ""
echo ""
echo "eeprom test"
echo "1234567890\n"  >  /sys/devices/platform/ocp/44e0b000.i2c/i2c-0/0-0050/eeprom
cat   /sys/devices/platform/ocp/44e0b000.i2c/i2c-0/0-0050/eeprom

