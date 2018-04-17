#!/bin/sh

if [ $1 = '1' ]; then
    ifconfig eth2 down
    ifconfig eth3 down
    ifconfig eth1 192.168.3.11
    ping 192.168.3.210 -c 5 | grep 64
fi

if [ $1 = '2' ]; then
    ifconfig eth1 down
    ifconfig eth3 down
    ifconfig eth2 192.168.3.11
    ping 192.168.3.210 -c 5 | grep 64
fi

if [ $1 = '3' ]; then
    ifconfig eth2 down
    ifconfig eth1 down
    ifconfig eth3 192.168.3.11
    ping 192.168.3.210 -c 5 | grep 64
fi
