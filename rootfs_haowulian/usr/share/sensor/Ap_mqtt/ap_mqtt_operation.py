#!/usr/bin/python3
import json
from Config.config import *

class ap_mqtt_operation:
    def on_connect(self, client, userdata, flags, rc):
        self.is_connect_flag = 1
        self.all_subscribe(client)

        self.all_device_connect()

    def on_disconnect(self, client, userdata, rc):
        if rc != 0 :
            self.is_connect_flag = 0
            print("mqtt disconnect")

    def on_message(self, client, userdata, msg):
        print(msg.topic)
        try :
            json_data = json.loads(msg.payload.decode('utf8'))
            #logging.debug(json_data)
        except :
            logging.debug("decode msg error")
        else:
            if (msg.topic == "v1/gateway/rpc"):
                if (("device" in json_data) and \
                        ("id" in json_data["data"])) :
                    sensor_id = json_data["device"]
                    params = json_data["data"]["params"]
                    request_id = json_data["data"]["id"]

                    if (json_data["data"]["method"] == "toggle"):
                        self.sensor_control(sensor_id, params["switch"])
                        self.sensor_control_ack(sensor_id, request_id)
                        self.publish_attributes(request_id, \
                                "switch", params["switch"])
                    elif (json_data["data"]["method"] == "query"):
                        self.sensor_status_get(sensor_id, params["key"])

                else :
                    print("dvice error or id error")

