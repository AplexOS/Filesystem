#!/bin/sh


if [ ! -e /sd ];then
    echo "create sd dir"
    mkdir /sd
fi

if [ ! -e /mmc ];then
    echo "create mmc dir"
    mkdir /mmc
fi

umount  /media/*

echo "Star make partition"
#make partition
dd if=/dev/zero of=/dev/mmcblk1 count=10240 bs=10240
fdisk /dev/mmcblk1 <<EOF
o
n
p
1

+50M
n
p
2


t
1
e
a
1
w
EOF

mkfs.vfat /dev/mmcblk1p1
mkfs.ext4 /dev/mmcblk1p2 <<EOF
y
EOF


mount /dev/mmcblk0p1 /sd
mount /dev/mmcblk1p1 /mmc
cp /sd/* /mmc/
cp /mmc/uEnv_emmc.txt  /mmc/uEnv.txt -arf
umount /sd
umount /mmc
sync

mount /dev/mmcblk1p2  /mmc
mount /dev/mmcblk0p2  /sd

#tar -xvf /rootfs.tar  -C  /mmc
cp  /sd/*  /mmc/   -arf
if [ -e /mmc/autoburn.sh ];then
    rm /mmc/autoburn.sh
fi

cp  /mmc/usr/share/web/lighttpd/webpages/json.use   /mmc/usr/share/web/lighttpd/webpages/json.txt -rf
rm /mmc/etc/pointercal -rf


sync
umount /mmc
umount /sd
sync
echo "burn the new system over..."
