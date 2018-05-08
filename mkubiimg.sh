

#sudo mkfs.ubifs  -q -r rootfs -m 2048 -e 126976 -c 2047 -o  ubifs.img -F
#sudo mkfs.ubifs  -q -r rootfs_20180110 -m 2048 -e 126976 -c 2047 -o  ubifs.img -F
sudo mkfs.ubifs  -q -r rootfs_20180508 -m 2048 -e 126976 -c 2047 -o  ubifs.img -F
echo mkfs.ubifs over!
sudo ubinize -o ubi.img -m 2048 -p 128KiB ubinize.cfg
echo ubinize over!

sync

sudo cp ubi.img ~/image -rf
echo make file system ok !
