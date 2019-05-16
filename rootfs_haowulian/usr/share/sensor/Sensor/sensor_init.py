#!/usr/bin/python3

import sys
import json

sys.path.append('.')
from Config.config import *

class sensor_init:
    def sensor_detect(self):
        self.sensor_config = config_data.sensor_config
        self.sensor_device_config = self.sensor_config["sensor"]

        sensor_list = list()

        for tmp_value in self.sensor_device_config:
            sensor_list.append(tmp_value["device_id"])

        return sensor_list

if __name__ == "__main__" :
    test = sensor_init()
    print(test.sensor_detect())
