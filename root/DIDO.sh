#!/bin/sh

i=10

echo "LED test"
echo 1 > /dev/IO_LED3
echo 1 > /dev/IO_LED4
echo 1 > /dev/IO_LED6


while [[ $i -gt 0 ]];
do
    let i=i-1;

    echo 1 > /dev/GPIO3
    echo 1 > /dev/GPIO4
    sleep 2
    echo 0 > /dev/GPIO3
    echo 0 > /dev/GPIO4
    sleep 2
    if [ $(cat  /dev/RESET_IP) = '1' ]; then
        echo "reset button out"
    else
        echo "reset button in"
    fi
done;

echo "LED over"
echo 0 > /dev/IO_LED3
echo 0 > /dev/IO_LED4
echo 0 > /dev/IO_LED6

