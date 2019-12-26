
    #echo ARiio_5130
    #sudo cp  ARiio_5130/etc/* rootfs/etc/ -rf
    #sudo cp  ARiio_5130/root/* rootfs/root/ -rf

    #echo ecm_5206
    #sudo cp  ecm_5206/etc/* rootfs/etc/ -rf
    #sudo cp  ecm_5206/root/* rootfs/root/ -rf

    #sudo mkfs.ubifs  -q -r rootfs -m 2048 -e 126976 -c 2047 -o  ubifs.img -F




sudo cp hf_bak/*  rootfs_hf/ -rf
sync
sudo mkfs.ubifs  -q -r rootfs_hf -m 2048 -e 126976 -c 2047 -o  ubifs.img -F

echo mkfs.ubifs over!
#sudo ubinize -o ubi.img -m 2048 -p 124KiB ubinize.cfg
sudo ubinize -o ubi.img -m 2048 -p 128KiB -s 512 -O 2048 ubinize.cfg
echo ubinize over!

sync

sudo cp ubi.img ~/image -rf
echo make file system ok !
