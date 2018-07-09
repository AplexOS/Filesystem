#!/bin/sh


mkdir /mnt1
if [ -e /dev/mmcblk1 ]; then
    mount  /dev/mmcblk1p1   /mnt1
    ls /mnt1
    umount /dev/mmcblk1p1
    sync
else
    echo "no soch sd device **********************************************************************!!!!!!!!!"
fi

rm /mnt1 -rf
