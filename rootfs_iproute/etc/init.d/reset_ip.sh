#!/bin/sh


passwd root <<EOF
root
root
EOF
cp /etc/network/interfaces_bak /etc/network/interfaces -rf
/etc/init.d/S40network restart
rm /etc/ssh/ssh_host*
sync

ifconfig eth0 192.168.2.10
