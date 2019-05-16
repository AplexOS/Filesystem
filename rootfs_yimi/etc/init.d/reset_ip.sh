#!/bin/sh


passwd root <<EOF
root
root
EOF
sync
cp /etc/network/interfaces_bak /etc/network/interfaces -rf
/etc/init.d/S40network restart
rm /etc/ssh/ssh_host*

/etc/init.d/S50sshd restart

tar -xvf /etc/init.d/upgrade.tar  -C  /usr/share/sensor/

sync

/etc/init.d/S50sshd restart
sync

