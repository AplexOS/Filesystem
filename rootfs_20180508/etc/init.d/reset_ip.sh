#!/bin/sh


passwd root <<EOF
root
root
EOF
ifconfig eth0 192.168.2.10
/etc/init.d/S40network restart
rm /etc/ssh/ssh_host*
sync
