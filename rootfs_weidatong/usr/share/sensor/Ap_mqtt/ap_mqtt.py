#!/usr/bin/python3

import paho.mqtt.client as mqtt
import time
import json
import threading
import math
import sys
import queue
import copy
import logging

sys.path.append('../')
from Config.config import *

LOG_FORMAT = "%(asctime)s - %(levelname)s - %(message)s"
logging.basicConfig(filename='my.log', level=logging.DEBUG, format=LOG_FORMAT)

class aplex_mqtt():
    def __init__(self):
        self.config = config.config
        self.init_connect()

    def init_connect(self):
        self.__mqtt_id = str(math.floor(time.time()))
        self.__mqtt__ = mqtt.Client(self.__mqtt_id)
        self.__mqtt__.username_pw_set(self.config["mqtt"]["username"], \
                self.config["mqtt"]["passwd"])
        self.__mqtt__.on_connect = self.on_connect
        self.__mqtt__.on_disconnect = self.on_disconnect
        self.__mqtt__.on_message = self.recvmsg_from_mqtthub

        self.try_connect_to_mqtthub()

    def on_connect(self, client, userdata, flags, rc):
        try :
            client.subscribe("v1/gateway/rpc")
            client.subscribe("v1/gateway/attributes")
            client.subscribe("v1/gateway/attributes/response")
        except :
            print("sub eroor")
        else :
            print("sub ok")

    def on_disconnect(self, client, userdata, rc):
        if rc != 0:
            logging.debug("disconect start")
            self.try_connect_to_mqtthub()
            logging.debug("disconect stop")
            time.sleep(2)

    def try_connect_to_mqtthub(self):
        while True :
            try :
                logging.debug("connect start")
                self.__mqtt__.connect(self.config["mqtt"]["wss_addr"], \
                        self.config["mqtt"]["wss_port"], keepalive=10)
            except :
                logging.debug("connect error")
                time.sleep(2)
            else :
                logging.debug("connect success")
                break

    def recvmsg_from_mqtthub(self, client, userdata, msg):
        try :
            json_data = json.loads(msg.payload.decode('utf8'))
            logging.debug(json_data)
        except :
            logging.debug("decode msg error")
        else:
            pass

    def device_connect(self):
        topic = "v1/gateway/connect"
        message = {
                "message" : {
                    "device" : "1001"
                    }
                }
        try :
            self.__mqtt__.publish(topic, payload = json.dumps(message), retain = False)
        except :
            print("publish error")

    def device_disconnect(self):
        topic = "v1/gateway/disconnect"
        message = {
                "message" : {
                    "device" : "1001"
                    }
                }
        try :
            self.__mqtt__.publish(topic, payload = json.dumps(message), retain = False)
        except :
            print("publish error")

    def publish_data(self):
        topic = "v1/gateway/attributes"
        message = {
                "Message": {
                    "1001":{
                        "attribute1":"value1",
                        "attribute2": 42
                        },
                    "1201":{
                        "attribute1":"value1",
                        "attribute2": 42
                        }
                    }
                }
        try :
            self.__mqtt__.publish(topic, payload = json.dumps(message), retain = False)
        except :
            print("publish error")

    def find_atrribute1(self)
        topic = "v1/gateway/attributes/request"
        message = {
                "Message": {
                    "id": "1",
                    "device": "5100100001001201904020003",
                    "client": True,
                    "key": "attribute1"
                    }
                }
        try :
            self.__mqtt__.publish(topic, payload = json.dumps(message), retain = False)
        except :
            print("publish error")

    def sub_shared_attribute(self):
        topic =  "v1/gateway/attributes"
        message = {
                "Message" : {
                    "device": "5100100001001201904020003",
                    "data": {
                        "attribute1": "value1",
                        "attribute2": 42
                        }
                    }
                }
