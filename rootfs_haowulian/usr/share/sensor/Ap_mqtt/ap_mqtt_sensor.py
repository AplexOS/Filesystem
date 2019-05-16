#!/usr/bin/python3

import json
import time
import sys

sys.path.append('.')
from Config.config import *

class ap_mqtt_sensor:
    def publish_message(self, topic, message, qos=0, retain=False):
        try :
            self.__mqtt__.publish(topic, \
                    payload = json.dumps(message), \
                    qos = qos, retain = retain)
        except :
            print("publish error")
        else :
            pass

    def device_connect(self, device_id):
        topic = "v1/gateway/connect"
        message = {
                "device" : "1001"
                }

        message["device"] = device_id
        qos = 1

        self.publish_message(topic, message, qos)

    def device_disconnect(self, device_id):
        topic = "v1/gateway/disconnect"
        message = {
                    "device" : "1001"
                }
        message["device"] = device_id
        try :
            self.__mqtt__.publish(topic, \
                    payload = json.dumps(message), \
                    retain = False)
        except :
            print("publish error")
        qos = 1

        self.publish_message(topic, message)

    def all_subscribe(self, client):
        try :
            client.subscribe("v1/gateway/rpc")
            client.subscribe("v1/gateway/attributes")
            client.subscribe("v1/gateway/attributes/response")
        except :
            print("sub eroor!!!!")
        else :
            print("sub ok-------")

    def all_device_connect(self):
        sensor_list = self.sen.sensor_detect()
        for sensor_id in sensor_list:
            self.device_connect(sensor_id)

    def pub_sensor_telemetry(self):
        sensor_device_config = self.sensor_device

        message = dict()
        topic = "v1/gateway/telemetry"

        for tmp_device in sensor_device_config:

            if tmp_device["product"] == "zhize_air_temp":
                tmp_device["func"] = self.sen.zhize_temp_data

            elif tmp_device["product"] == "zhize_air_humi":
                tmp_device["func"] =  self.sen.zhize_humi_data

            elif tmp_device["product"] == "zhize_light_intensity":
                tmp_device["func"] = self.sen.zhize_light_data

            elif tmp_device["product"] == "zhize_CO2_concentration":
                tmp_device["func"] = self.sen.zhize_co2_data

            elif tmp_device["product"] == "zhize_soil_temperature":
                tmp_device["func"] = self.sen.zhize_soil_temp_data

            elif tmp_device["product"] == "zhize_soil_moisture":
                tmp_device["func"] = self.sen.zhize_soil_humi_data

            elif tmp_device["product"] == "zhize_soil_salinity":
                tmp_device["func"] = self.sen.zhize_soil_salinity_data

        while True :
            for tmp_device in sensor_device_config:
                time.sleep(0.1)
                tmp_value = None
                ts = int(round(time.time() * 1000))

                tmp_value = tmp_device["func"](tmp_device["addr"])

                if (tmp_value != None):
                    message[tmp_device["device_id"]] = [{"ts" : ts,\
                        "values":{tmp_device["key"] : tmp_value}}]

            if (self.is_connect_flag):
                try :
                    #print(message)
                    self.__mqtt__.publish(topic, \
                            payload = json.dumps(message), \
                            retain = False)
                except :
                    print("publish error")
            else:
                self.sql.insert_data(json.dumps(message), "tmp/database0.db")

            time.sleep(self.config["device"]["interval"])

    def publish_attributes(self, sensor_id, key, value):
        topic = "v1/gateway/attributes"
        message = dict()

        message[sensor_id] = {key : value}
        self.publish_message(topic, message)

    def sensor_control_ack(self, sensor_id, request_id):
        message = {
                "device": "1001",
                "id": 0,
                "data" : {
                    "success": True
                    }
                }
        message["device"] = sensor_id
        message["id"] = request_id
        topic = "v1/gateway/rpc"

        self.publish_message(topic, message)

    def sensor_control(self, sensor_id, status):
        self.sen.control_led("/dev/LED2", status)

    def sensor_status_get(self, sensor_id, key):
        if (sensor_id == "3001"):
            try :
                led_fd = open("/dev/LED2", "rb")
                led_status = led_fd.read(2).decode()
            except :
                led_status = "-1"
            else :
                led_fd.close()

            print(led_status)

            self.publish_attributes(sensor_id, "switch", "on")


    def get_client_side(self):
        topic = "v1/gateway/attributes/request"
        message = {
                "id": "1",
                "device": "1001",
                "client": True,
                "key": "attribute1"
                }
        try :
            self.__mqtt__.publish(topic, \
                    payload = json.dumps(message), \
                    retain = False)
        except :
            print("publish error")


