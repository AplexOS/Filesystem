#!/bin/sh
echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

# zengjf 2015-8-29 
# this was bug for PTC Touch, so i add this line for normal use

#如下PCT Driver(电容屏）是以.ko模块加载至系统
#电阻屏下面三行需要注释，RES时记得卸载
#rm /dev/input/touchscreen0 -rf
#insmod  /usr/share/qt/bin/hid-multitouch.ko
#eGTouchD &


#mknod /dev/buzzer_ctl c 301 0
rm /dev/io_ctl
mknod /dev/io_ctl c 304 0
mknod /dev/debug_led c 300 0
mknod /dev/buzzer_ctl c 301 0
mknod /dev/serial_ctl c 302 0


base1=qpe
pid=`/bin/pidof $base1`
if [ -n "$pid" ]; then
    killall $base1
fi

base2=qss
pid=`/bin/pidof $base2`
if [ -n "$pid" ]; then
    killall $base2
fi

base3=quicklauncher
pid=`/bin/pidof $base3`
if [ -n "$pid" ]; then
    killall  $base3
fi


base4=fluidlauncher
pid=`/bin/pidof $base4`
if [ -n "$pid" ]; then
    killall  $base4
fi

#tslib config

while [ ! -e /dev/input/touchscreen0 ]
do
	echo "please hang up LCD TOUCH  !"
	sleep 1
done

#if [ ! -e /dev/input/touchscreen0 ]; then
#    echo "please hang up USB TOUCH !"
#    sleep 1
#fi

#if [ -e /dev/input/touchscreen0 ]; then
#    export TSLIB_TSDEVICE=/dev/input/touchscreen0 
#fi

export TSLIB_TSDEVICE=/dev/input/touchscreen0 

export TSLIB_CONFFILE=/etc/ts.conf
export TSLIB_PLUGINDIR=/usr/lib/ts
export POINTERCAL_FILE=/etc/pointercal
export TSLIB_CALIBFILE=/etc/pointercal
export TSLIB_CONSOLEDEVICE=none
export TSLIB_FBDEVICE=/dev/fb0

#qt
export QTDIR=/usr/share/qt
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
export QT_QWS_FONTDIR=$QTDIR/lib/fonts
#export QWS_SIZE=800x480
#export QWS_MOUSE_PROTO="Intellimouse:/dev/input/mice"
export QWS_MOUSE_PROTO="Tslib:/dev/input/touchscreen0"
export QWS_USB_KEYBOARD=/dev/input/event2

export QWS_DISPLAY=LinuxFb:/dev/fb0
#rotation 90
#export QWS_DISPLAY=transformed:rot90:LinuxFb:/dev/fb0


#echo "exec qt.sh"

#if [ ! -e /etc/pointercal ] ; then
#   ts_calibrate
#   sync
#fi

cd /usr/share/web/lighttpd/sbin
./lighttpd -f ../config/lighttpd.conf &

sleep 1

#export QWS_DISPLAY='Transformed:Rot90'
cd /usr/share/qt/bin
#./heatMachine -qws &
#./matrix_gui -qws 2>/dev/null &
#./matrix_gui -qws 2>/dev/null &
if [ -e /on-off-file ] ; then
    ./on-off-test -qws 2>/dev/null &
else
    ./matrix_gui -qws 2>/dev/null &
fi

cat "" > /sys/class/backlight/pwm-backlight/brightness
cat /etc/brightness > /sys/class/backlight/pwm-backlight/brightness

#./on-off-test  -qws &

#./backlight

grep -i "dhcp" /etc/network/interfaces >/dev/null
if [ $? != 0 ] ; then
   echo "udhcpc get"
else 
   udhcpc -b -q -i eth0
   echo "udhcpc no_get"
fi

#
#ifconfig eth0 up
#udhcpc
#if [ ! -f "/dev/mmcblk0" ]; then 
#	insmod g_file_storage.ko file=/dev/mmcblk0 stall=0 removable=1
#fi 
 
#ifconfig eth0 down
# Only modify the eth0 for lan1 and lan2
ifconfig eth0 up
#udhcpc -b -q -i eth0 #DHCP service(eth0) for LAN1,But eth0 is corresponding to LAN2 in Network App 
ethtool -s eth0 autoneg on speed 100 duplex full

#ifconfig eth1 up
#udhcpc -b -q -i eth1
#ethtool -s eth1 autoneg on speed 100 duplex full

#ifconfig eth1 down
#ethtool -s eth1 autoneg off speed 10 duplex half
#udhcpc -b -q -i eth1

