#!/bin/sh

echo COM1 test----------------------
./serial_test  /dev/ttyS1 /dev/ttyS2

echo USB1 tty test -----------------
./serial_test  /dev/ttyS3 /dev/ttyS3

echo rtc test ----------------------
hwclock -r
sleep 3
hwclock -r

echo buzzer test -------------------
test_buzzer

echo USB_GPIO test -----------------
echo 1 > /dev/GPIO7
echo 1 > /dev/GPIO6
sleep 1

echo 0 > /dev/GPIO6
echo 0 > /dev/GPIO7
sleep 1

echo 1 > /dev/GPIO7
echo 1 > /dev/GPIO6
sleep 1

echo 0 > /dev/GPIO6
echo 0 > /dev/GPIO7
sleep 1

echo EEPROM test -------------------
ls /dev/eeprom
cat /dev/eeprom

