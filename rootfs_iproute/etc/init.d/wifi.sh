#!/bin/sh

ifconfig wlan0 up
sleep 1
wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf > /dev/null 2>&1 &
sleep 1
udhcpc -i wlan0
