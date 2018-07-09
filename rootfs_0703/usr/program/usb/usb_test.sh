#!/bin/sh

if [ -e /dev/sda ]; then
    if [ ! -e /sda1 ]; then
        mkdir /sda1
    fi
    mount  /dev/sda1 /sda1
    ls /sda1
    umount /sda1
    sync
    rm /sda1 -rf
else
    echo "no such usb device ******************************************************************************...\n"
fi

if [ -e /dev/sdb1 ]; then
    if [ ! -e /sdb1 ]; then
        mkdir /sdb1
    fi
    mount  /dev/sdb1 /sdb1
    ls /sdb1
    umount /sdb1
    sync
    rm /sdb1 -rf
else
    echo "no such usb device ******************************************************************************...\n"
fi
