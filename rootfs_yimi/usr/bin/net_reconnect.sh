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

count=0
tty_check_count=0

while [ 1 ];
do
    ping -c 3 114.114.114.114 -I wwan0 > /dev/null

    if [ $? -ne 0 ]
    then
        if [ -e "/dev/ttyUSB3" ]
        then
            #echo `date` network error  >> ${log}
            echo "AT\$QCRMCALL=1,1" > /dev/ttyUSB3
            udhcpc -i wwan0 -n -q
        else
            let tty_check_count+=1
            if [ ${tty_check_count} -eq 3 ]
            then
                echo 0 > /dev/watchdog
            fi
        fi

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
    else
        # reset count value
        count=0
        tty_check_count=0
    fi
    sleep 10
done
