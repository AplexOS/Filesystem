#!/bin/sh

start() {
    ifconfig wlan0 up
    sleep 2

    wpa_supplicant -Dnl80211 -iwlan0 -c/opt/etc/wpa_supplicant.conf > /dev/null 2>&1 &

    sleep 2
    udhcpc  -i  wlan0
}

stop() {
    echo "stop ..."
}

case "$1" in
    start)
        start
        ;;

    stop)
        stop
        ;;

    restart)
        stop
        sleep 1
        start
        ;;

    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1

esac
