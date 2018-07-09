#!/bin/sh
rm -rf /etc/pointercal

ts_calibrate
sync
sync
sync

kill $(pidof matrix_gui)

/etc/init.d/S99aplex
