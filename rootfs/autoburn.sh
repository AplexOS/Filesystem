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
sleep 3
sync

echo "Star make partition"
#make partition
dd if=/dev/zero of=/dev/mmcblk0 count=10240 bs=10240
fdisk /dev/mmcblk0 <<EOF
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

mkfs.vfat /dev/mmcblk0p1
mkfs.ext4 /dev/mmcblk0p2 <<EOF
y
EOF

sleep 3
sync
mount /dev/mmcblk1p1 /sd
sleep 2
mount /dev/mmcblk0p1 /mmc
sleep 2

cp /sd/* /mmc/
sync
cp /mmc/uEnv_emmc.txt  /mmc/uEnv.txt -arf
sync
umount /sd
sleep 2
umount /mmc
sleep 2

mount /dev/mmcblk0p2  /mmc
sleep 2
mount /dev/mmcblk1p2  /sd
sleep 2

#tar -xvf /rootfs.tar  -C  /mmc
cp  /sd/*  /mmc/   -arf
sleep 5
sync
if [ -e /mmc/autoburn.sh ];then
    rm /mmc/autoburn.sh
fi

cp  /mmc/usr/share/web/lighttpd/webpages/json.use   /mmc/usr/share/web/lighttpd/webpages/json.txt -rf
rm /mmc/etc/pointercal -rf
sleep 2

sync
umount /mmc
sleep 2
umount /sd
sleep 2
sync
echo "\n"
echo "burn the new system over..."
