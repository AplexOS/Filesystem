#!/bin/sh

cd /usr/program
buzzer/buzzer.sh &
eeprom/eeprom_test &
gpio/gpio_test.sh &
led/led_test.sh &
networtk/network_test.sh $1 &
rtc/rtc_test.sh &
sd/sd_test.sh &
uart/main/test_tty &
usb/usb_test.sh &
