#!/usr/bin/python3

from Ap_mqtt.ap_mqtt import *
from Network_check.network_check import *

import threading
import time

if __name__ == "__main__":
    aplex_gateway_mqtt = aplex_mqtt()

    #aplex_mqtt_init = threading.Thread(tartget=\
    #        aplex_gateway_mqtt.mqtt_init_connect())
    #aplex_mqtt_init.start()
    aplex_gateway_mqtt.mqtt_init_connect()

    aplex_sensor_data_pub = threading.Thread(target=\
            aplex_gateway_mqtt.pub_sensor_telemetry)
    aplex_sensor_data_pub.start()

    aplex_mqtt_run = threading.Thread(target=\
            aplex_gateway_mqtt.mqtt_loop_forever)
    aplex_mqtt_run.start()

    aplex_sensor_data_pub.join()
    aplex_mqtt_run.join()
    #aplex_mqtt_init.join()

