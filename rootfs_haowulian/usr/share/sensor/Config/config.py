#!/usr/bin/python3

import configparser
import os
import json
import time

class configure():
    def __new__(cls, *args, **kwargs):
        cls.__configure_file_path = "Config/config.json";
        cls.__sensor_file_path = "Config/sensor.json"

        if not hasattr(cls, "_inst"):

            cls._inst = super(configure, cls).__new__(cls);

            try :
                cls.config_file = open(cls.__configure_file_path)
                cls.sensor_file = open(cls.__sensor_file_path)
            except :
                cls.__configure_file_path = "../Config/config.json"
                cls.config_file = open(cls.__configure_file_path)

                cls.__sensor_file_path = "../Config/sensor.json"
                cls.sensor_file = open(cls.__sensor_file_path)

            cls.config = json.load(cls.config_file);
            cls.sensor_config = json.load(cls.sensor_file)

            cls.config_file.close()
            cls.sensor_file.close()

            serial_id = "-1"
            try :
                eeprom_fd = open("/dev/eeprom", "rb")
                serial_id = eeprom_fd.read(25).decode()
            except :
                serial_id = "-1"
            else :
                eeprom_fd.close()

            cls.config["device"]["id"] = serial_id

        return cls._inst;

    def print_cfg(cls):
        sensor_list = list()

        for tmp_value in cls.sensor_config["sensor"]:
            sensor_list.append(tmp_value["device_id"])
            print(tmp_value)

        print(sensor_list)


    def set_file_path(cls, filepath1):
        cls.__configure_file_path = filepath1;

    def save_config_data(cls):
        os.system("sync")
        try :
            with open(cls.__configure_file_path, "w") as config_file :
                config_file.write(json.dumps(cls.config))
            os.system("sync")
        except :
            print("write config data error")

        os.system("sync")

config_data = configure();

if __name__ == '__main__':
    #config_data.set_file_path("Config/config.json");
    config_data.print_cfg();

