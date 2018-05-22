sudo mkfs.ubifs  -q -r rootfs_v2 -m 2048 -e 126976 -c 8080 -o  ubifs.img -F
echo mkfs.ubifs over!
sudo ubinize -o ubi.img -m 2048 -p 128KiB ubinize.cfg
echo ubinize over!

sync

cp ubi.img $APLEX_PATH -rf
echo make file system ok !
