#!/bin/sh
rm -rf /etc/pointercal

ts_calibrate
sync
sync
sync

sleep 1
kill $(pidof matrix_gui)
sleep 3

/etc/init.d/S99aplex restart
