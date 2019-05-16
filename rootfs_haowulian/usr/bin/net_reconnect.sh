#!/bin/sh

log=/root/log/network.log
rm /root/log/network.log -rf
sync

watchdog_reboot_file="/root/wat_reboot.txt"

if [ ! -f ${watchdog_reboot_file} ]
then
    echo 0 > ${watchdog_reboot_file}
    sync
fi

watchdog_reboot_value=`cat ${watchdog_reboot_file}`


if [ ! -f ${log} ]
then
    touch ${log}
fi

device="wwan0"
count=0
tty_check_count=0

count_check_ip() {
    let count+=1
    if [ ${count} -eq 180 ]
    then
        # start watchdog
        echo 0 > /dev/watchdog
        let watchdog_reboot_value+=1
        echo ${watchdog_reboot_value} > ${watchdog_reboot_file}
        sync
        sync
    fi
}

while [ 1 ];
do
    if [ -e "/dev/ttyUSB3" ]
    then
        device_name=`ifconfig  -a  | grep ${device} | awk '{print $1}'`
        if [ -z ${device_name} ]
        then
            count_check_ip
            echo "wwan0 No such network node"
            echo ""
            echo "AT\$QCRMCALL=1,1" > /dev/ttyUSB3
            udhcpc -i wwan0 -n -q
        else
            device_ip=`ifconfig ${device} | grep "inet addr:" | awk '{print $2}' | cut -c 6-`
            if [ -z ${device_ip} ]
            then
                count_check_ip
                echo "wwan0 No ip"
                echo ""
                echo "AT\$QCRMCALL=1,1" > /dev/ttyUSB3
                udhcpc -i wwan0 -n -q
            else
                count=0
            fi
        fi
    else
        let tty_check_count+=1
        if [ ${tty_check_count} -eq 3 ]
        then
            echo 0 > /dev/watchdog
        fi
    fi

    sleep 10
done
