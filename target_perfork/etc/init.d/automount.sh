#!/bin/sh

MOUNT_PATH=""
MSG_PATH="/dev/ttyO0"

if [ $1 == "" ]; then
    echo "[AutoMount] automount.sh parameter is none" > $MSG_PATH
    exit 0
else
    name=$1
    check=${name%[1-9]}
    MOUNT_PATH="/media/"$name
fi
echo "[AutoMount] mount path : $MOUNT_PATH" >> $MSG_PATH

FORMAT=`/sbin/fdisk -l | grep $1`
OLD_MOUNT_PATH=`mount | grep $MOUNT_PATH`

if [ "$OLD_MOUNT_PATH" == "" ]; then

    if [ ! -x $MOUNT_PATH ]; then
        mkdir -p $MOUNT_PATH
    fi

    for token in $FORMAT
    do
        if [ $token == "FAT32" ]; then
            mount -t vfat /dev/$1 $MOUNT_PATH
            echo "[AutoMount] mount -t vfat /dev/$1 $MOUNT_PATH" > $MSG_PATH
        elif [ $token == "FAT16" ]; then
            mount -t vfat /dev/$1 $MOUNT_PATH
            echo "[AutoMount] mount -t vfat /dev/$1 $MOUNT_PATH" > $MSG_PATH
        elif [ $token == "HPFS/NTFS" ]; then
            if [ -f /usr/app/ntfs-3g ]; then
                echo "[AutoMount] /usr/app/ntfs-3g /dev/"$1" "$MOUNT_PATH > /var/log/automount/mount.log
                export LD_LIBRARY_PATH=/lib/:${LD_LIBRARY_PATH}
                /usr/app/ntfs-3g /dev/$1 $MOUNT_PATH
                echo "[AutoMount] /usr/app/ntfs-3g /dev/$1 $MOUNT_PATH" > $MSG_PATH
            else
                mount -t ntfs /dev/$1 $MOUNT_PATH
                echo "[AutoMount] mount -t ntfs /dev/$1 $MOUNT_PATH" > $MSG_PATH
            fi
        elif [ $token == "Linux" ]; then
            mount /dev/$1 $MOUNT_PATH
            echo "[AutoMount] mount /dev/$1 $MOUNT_PATH" > $MSG_PATH
        fi
    done
else
    umount $MOUNT_PATH
    echo "[AutoMount] umount "$MOUNT_PATH > $MSG_PATH
fi
