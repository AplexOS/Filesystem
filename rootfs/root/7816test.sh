#!/bin/sh

if [ $1 = "1" ]; then
    ifconfig eth1 192.168.20.10
    sleep 5
    echo "set ip over"
    ping 192.168.2.11  -c 50
    ping 192.168.20.11  -c 50
    echo "test network over .... \n\n"
elif [ $1 = "2" ]; then
    ifconfig eth0 192.168.2.11
    ifconfig eth1 192.168.20.11
    sleep 5
    echo "set ip over"
    ping 192.168.2.10  -c 50
    ping 192.168.20.10  -c 50
    echo "test network over .... \n\n"
elif [ $1 = "3" ]; then
    ifconfig eth1 192.168.20.12
    sleep 5
    echo "set ip over"
    ping 192.168.2.11  -c 50
    ping 192.168.20.13  -c 50
    echo "test network over .... \n\n"
elif [ $1 = "4" ]; then
    ifconfig eth0 192.168.2.11
    ifconfig eth1 192.168.20.13
    sleep 5
    echo "set ip over"
    ping 192.168.2.10  -c 50
    ping 192.168.20.12  -c 50
    echo "test network over .... \n\n"
fi

test_tty123

