
echo 22 >  /sys/class/gpio/export
echo 23 >  /sys/class/gpio/export
#echo 44 >  /sys/class/gpio/export
echo 45 >  /sys/class/gpio/export
echo 46 >  /sys/class/gpio/export
#echo 117 >  /sys/class/gpio/export
#echo 114 >  /sys/class/gpio/export
echo 115 >  /sys/class/gpio/export
echo 116 >  /sys/class/gpio/export
echo 29 >  /sys/class/gpio/export

echo out > /sys/class/gpio/gpio22/direction
echo out > /sys/class/gpio/gpio23/direction
#echo in > /sys/class/gpio/gpio44/direction
echo in > /sys/class/gpio/gpio45/direction
echo in > /sys/class/gpio/gpio46/direction
#echo out > /sys/class/gpio/gpio117/direction
#echo out > /sys/class/gpio/gpio114/direction
echo out > /sys/class/gpio/gpio115/direction
echo out > /sys/class/gpio/gpio116/direction
echo out > /sys/class/gpio/gpio29/direction

ln -s  /sys/class/gpio/gpio29/value   /dev/IO_LED6
ln -s  /sys/class/gpio/gpio23/value   /dev/IO_LED4
ln -s  /sys/class/gpio/gpio22/value   /dev/IO_LED3
#ln -s  /sys/class/gpio/gpio44/value   /dev/RESET_IP
ln -s  /sys/class/gpio/gpio45/value   /dev/DI1
ln -s  /sys/class/gpio/gpio46/value   /dev/DI2
#ln -s  /sys/class/gpio/gpio117/value   /dev/GPIO1
#ln -s  /sys/class/gpio/gpio114/value   /dev/GPIO2
ln -s  /sys/class/gpio/gpio115/value   /dev/GPIO3
ln -s  /sys/class/gpio/gpio116/value   /dev/GPIO4


if [ -e /on-off.file ]; then
    on-off
fi



#/etc/init.d/reset.sh &
