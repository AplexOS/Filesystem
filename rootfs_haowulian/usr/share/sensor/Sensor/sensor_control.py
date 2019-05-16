#!/usr/bin/env python3
import os

class sensor_control:
    def control_led(self, device_name, status):
        value = 0
        if status == "on":
            value = "1"
        elif status == "off":
            value = "0"
        else :
            print("status error")

        cmd = "echo " + value + " > " + device_name
        os.system(cmd)



