
#sudo mkfs.ubifs  -q -r rootfs -m 2048 -e 126976 -c 1600 -o  ubifs.img -F
sudo mkfs.ubifs  -q -r rootfs_ecm_5202 -m 2048 -e 126976 -c 1600 -o  ubifs.img -F

echo mkfs.ubifs over!
sudo ubinize -o ubi.img -m 2048 -p 128KiB ubinize.cfg
echo ubinize over!

sync

sudo cp ubi.img ~/image -rf

sudo rm ubifs.img  ubi.img  -rf
sync
echo make file system ok !
