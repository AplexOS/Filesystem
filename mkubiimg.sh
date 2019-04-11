

#sudo mkfs.ubifs  -q -r rootfs -m 2048 -e 126976 -c 2047 -o  ubifs.img -F
#sudo mkfs.ubifs  -q -r rootfs_20180110 -m 2048 -e 126976 -c 2047 -o  ubifs.img -F
#sudo mkfs.ubifs  -q -r rootfs_iproute -m 2048 -e 126976 -c 2047 -o  ubifs.img -F
sudo mkfs.ubifs  -q -r rootfs_iproute -m 2048 -e 124KiB -c 1680 -o  ubifs.img -F
echo mkfs.ubifs over!
#sudo ubinize -o ubi.img -m 2048 -p 124KiB ubinize.cfg
sudo ubinize -o ubi.img -m 2048 -p 128KiB -s 512 -O 2048 ubinize.cfg
echo ubinize over!

sync

sudo cp ubi.img ~/image -rf
echo make file system ok !
