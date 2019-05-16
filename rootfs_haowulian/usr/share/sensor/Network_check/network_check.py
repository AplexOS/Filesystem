#!/usr/bin/env python3
#import serial
import json
import os

def sim7600ce_checkout():
    cmd = "AT+CSQ"
    com_name = "/dev/ttyUSB3"
    com_baudrate = 115200
    com_timeout = 1

    #com = serial.Serial(com_name, com_baudrate, timeout = com_timeout)

def network_checkout():
    exit_code = os.system("ping -c 3 114.114.114.114 > /dev/null")
    #exit_code = os.system("ping -c 3 114.114.114.114 -I wwan0 > /dev/null")
    print(exit_code)
    if exit_code :
        return False
    else :
        return True


if __name__ == "__main__":
    if network_checkout():
        print("network ok ")
    else :
        print("network error ")


