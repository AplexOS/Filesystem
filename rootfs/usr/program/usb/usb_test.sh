#!/bin/sh


if [ -e /dev/sda ]; then
    mount  /dev/sda1 /mnt
    ls /mnt
    umount /dev/sda1
    sync
else
    echo "no such usb device ******************************************************************************...\n"
fi
