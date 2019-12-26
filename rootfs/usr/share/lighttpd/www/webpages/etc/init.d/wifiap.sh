#!/bin/sh

ifconfig ra0 192.168.5.1 netmask 255.255.255.0 
sleep 2
touch /var/lib/misc/udhcpd.leases
udhcpd -f /etc/udhcpd.conf &
