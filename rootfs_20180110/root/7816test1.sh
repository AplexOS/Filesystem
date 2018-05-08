#!/bin/sh

one_ttytest_readorwrite  /dev/ttyO1    500  50000  1  &
one_ttytest_readorwrite  /dev/ttyO2    500  50000  0  &
one_ttytest_readorwrite  /dev/ttyO3    500  50000  1  &
one_ttytest_readorwrite  /dev/ttyO4    500  50000  0  &
one_ttytest_readorwrite  /dev/ttyO5    500  50000  1  &
one_ttytest_readorwrite  /dev/ttyUSB0  500  50000  0  &

if [ $1 = "1" ]; then
    ifconfig eth0 192.168.2.11
    ifconfig eth1 192.168.3.201
    sleep 3
    ping 192.168.2.10  -c 30
    ping 192.168.3.138  -c 30
    echo "test network over .... \n\n"
elif [ $1 = "2" ]; then
    ifconfig eth0 192.168.2.12
    ifconfig eth1 192.168.3.202
    sleep 3
    ping 192.168.2.10  -c 30
    ping 192.168.3.138  -c 30
    echo "test network over .... \n\n"
elif [ $1 = "3" ]; then
    ifconfig eth0 192.168.2.13
    ifconfig eth1 192.168.3.203
    sleep 3
    ping 192.168.2.10  -c 30
    ping 192.168.3.138  -c 30
    echo "test network over .... \n\n"
elif [ $1 = "4" ]; then
    ifconfig eth0 192.168.2.14
    ifconfig eth1 192.168.3.204
    sleep 3
    ping 192.168.2.10  -c 30
    ping 192.168.3.138  -c 30
    echo "test network over .... \n\n"
fi


