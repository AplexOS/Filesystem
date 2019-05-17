
sudo mkfs.ubifs  -q -r rootfs_153 -m 2048 -e 126976 -c 1600 -o  ubifs.img -F

echo mkfs.ubifs over!
sudo ubinize -o ubi.img -m 2048 -p 128KiB ubinize.cfg
echo ubinize over!

sync

echo make file system ok !
