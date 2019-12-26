#!/bin/sh

one_ttytest_readorwrite  /dev/ttyO1    500  50000  0  &
one_ttytest_readorwrite  /dev/ttyO2    500  50000  1  &
one_ttytest_readorwrite  /dev/ttyO3    500  50000  0  &
one_ttytest_readorwrite  /dev/ttyO4    500  50000  1  &
one_ttytest_readorwrite  /dev/ttyO5    500  50000  0  &
one_ttytest_readorwrite  /dev/ttyUSB0  500  50000  1  &

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

if [ -e /dev/sda ]; then
    ls  /dev/sda*
fi

if [ -e /dev/sdb ]; then
    ls  /dev/sdb*
fi
