#!/usr/bin/python3

import paho.mqtt.client as mqtt
import time
import json
#import threading.Thread
import math
import sys
import queue
import copy
import logging

#sys.path.append('../')
from Config.config import *
from Sensor.sensor import *
from Ap_sqlite.ap_sqlite import *
from Ap_mqtt.ap_mqtt_sensor import *
from Ap_mqtt.ap_mqtt_operation import *

LOG_FORMAT = "%(asctime)s - %(levelname)s - %(message)s"
logging.basicConfig(filename='tmp/mqtt.log', level=logging.DEBUG, \
        format=LOG_FORMAT)

class aplex_mqtt(ap_mqtt_operation, ap_mqtt_sensor):
    def __init__(self):
        self.config = config_data.config
        self.sensor_config = config_data.sensor_config
        self.sensor_device = config_data.sensor_config["sensor"]

        self.is_connect_flag = 0

        self.sen = sensor()
        self.sql = ap_sqlite()
        self.sql.create_tables("tmp/database0.db")

    def mqtt_init_connect(self):
        self.__mqtt_id = str(math.floor(time.time()))
        self.__mqtt__ = mqtt.Client(self.__mqtt_id)
        self.__mqtt__.username_pw_set(self.config["device"]["id"])
        self.__mqtt__.on_connect = self.on_connect
        self.__mqtt__.on_disconnect = self.on_disconnect
        self.__mqtt__.on_message = self.on_message

        self.try_connect_to_mqtthub()

    def try_connect_to_mqtthub(self):
        try :
            logging.debug("connect start")
            self.__mqtt__.connect(self.config["mqtt"]["wss_addr"], \
                    self.config["mqtt"]["wss_port"], keepalive=10)
        except :
            logging.debug("connect error")
            time.sleep(2)
        else :
            logging.debug("connect success")

    def mqtt_loop_forever(self):
        self.__mqtt__.loop_forever()

if __name__ == "__main__":
    pass
