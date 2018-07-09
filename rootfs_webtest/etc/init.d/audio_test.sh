#!/bin/sh

i=4

while [[ $i -gt 0 ]];
do
    let i=i-1;
    sleep 1
    aplay /root/sbc-7109-test.wav
done;
