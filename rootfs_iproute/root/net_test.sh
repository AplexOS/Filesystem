#!/bin/sh


if [ $1 = "1" ]; then
    ifconfig eth0 192.168.2.11
    ifconfig eth1 192.168.3.201
    sleep 3
    ping 192.168.2.10  -c 5
    ping 192.168.3.138  -c 5
    echo "test network over .... \n\n"
elif [ $1 = "2" ]; then
    ifconfig eth0 192.168.2.12
    ifconfig eth1 192.168.3.202
    sleep 3
    ping 192.168.2.10  -c 5
    ping 192.168.3.138  -c 5
    echo "test network over .... \n\n"
elif [ $1 = "3" ]; then
    ifconfig eth0 192.168.2.13
    ifconfig eth1 192.168.3.203
    sleep 3
    ping 192.168.2.10  -c 5
    ping 192.168.3.138  -c 5
    echo "test network over .... \n\n"
elif [ $1 = "4" ]; then
    ifconfig eth0 192.168.2.14
    ifconfig eth1 192.168.3.204
    sleep 3
    ping 192.168.2.10  -c 5
    ping 192.168.3.138  -c 5
    echo "test network over .... \n\n"
fi


