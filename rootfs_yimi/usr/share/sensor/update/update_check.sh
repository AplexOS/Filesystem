#!/bin/sh

pwd

if [ -f "../update/update.sh" ]
then
    echo "update start ..."
    ../update/update.sh

    rm ../update/update.sh -rf
    rm ../update/update_file -rf
    sync
    sync
    sync
    reboot
else
    echo "not update"
fi
