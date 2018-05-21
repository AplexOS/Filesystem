#!/bin/sh

count=0
while [ $count -le 10 ];
do
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS1 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS3 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS5 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS7 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS9 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS11 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS13 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS2 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS4 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS6 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS8 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS10 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS12 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS14 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS16 &
    echo 1234567890abcdefghqwertyuiopdasdk > /dev/ttyS15 &
    echo 1 > /dev/DO0
    echo 1 > /dev/DO1
    echo 1 > /dev/DO2
    echo 1 > /dev/DO3
    echo 1 > /dev/LED_GPIO_0
    echo 1 > /dev/LED_GPIO_1
    echo 1 > /dev/RUN_LED

    sleep 1
    echo 0 > /dev/DO0
    echo 0 > /dev/DO1
    echo 0 > /dev/DO2
    echo 0 > /dev/DO3
    echo 0 > /dev/LED_GPIO_0
    echo 0 > /dev/LED_GPIO_1
    echo 0 > /dev/RUN_LED
    sleep 1

    let count+=1
done


