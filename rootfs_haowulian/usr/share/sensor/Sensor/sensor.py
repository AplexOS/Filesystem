#!/usr/bin/python3

import json
import serial
import threading
import time
import os
import sys
import logging
import copy

LOG_FORMAT = "%(asctime)s - %(levelname)s - %(message)s"
logging.basicConfig(filename='tmp/sensor.log', \
        level=logging.DEBUG, format=LOG_FORMAT)

sys.path.append('.')
#sys.path.append('../')
from Config.config import *
from Sensor.sensor_control import *
from Sensor.sensor_init import *

def check_readdata(data_array):
    result_data = []
    for index in (range(len(data_array) - 2)):
        result_data.append(data_array[index])

    return ca_crc(result_data)

def ca_crc(data_array):
    crc_result = 0xffff
    for index in range(len(data_array)):
        #print("0x%x" % data_array[index])

        crc_result ^= data_array[index]
        crc_num = (crc_result & 0x0001)
        for m in range(8):
            if crc_num :
                xor_flag = 1;
            else:
                xor_flag = 0

            crc_result >>= 1;

            if (xor_flag):
                crc_result ^= 0xa001

            crc_num = (crc_result & 0x0001)

    return crc_result

class sensor(sensor_control, sensor_init):
    def __init__(self):
        self.config = config_data.config
        serial_name = self.config["COM1"]["port"]
        serial_baudrate = self.config["COM1"]["baudrate"]
        serial_timeout = self.config["COM1"]["timeout"]
        self.com = serial.Serial(serial_name, \
                serial_baudrate, timeout = serial_timeout)

        #self.sensor_list = self.sensor_detect()

    def check_device_addr(self, addr):
        check_cmd = [0xfd, 0x03, 0x01, 0x00, 0x00, 0x01]
        check_cmd[0] = addr
        crc_num = ca_crc(check_cmd)
        check_cmd.append(crc_num & 0xff)
        check_cmd.append(crc_num >> 8)
        self.com.write(check_cmd)

        time.sleep(0.05)

        addr_data = self.com.read(7)

        data_len = len(addr_data)
        if (data_len == 7):
            crc_result = check_readdata(addr_data)

            if ((crc_result & 0xff) == addr_data[data_len - 2]) and \
                    ((crc_result >> 8) == addr_data[data_len - 1]) and \
                    (addr_data[4] == addr) :
                return True
            else :
                return False
        else :
            return False

    def change_device_addr(self, old_addr, new_addr):

        change_addr_cmd = [0x01, 0x06, 0x01, 0x00, 0x00, 0x02]
        change_addr_cmd[0] = old_addr
        change_addr_cmd[5] = new_addr

        crc_num = ca_crc(change_addr_cmd)

        change_addr_cmd.append(crc_num & 0xff)
        change_addr_cmd.append(crc_num >> 8)
        self.com.write(change_addr_cmd)

        time.sleep(0.05)

        return_data = self.com.read(8)

        data_len = len(return_data)
        if (data_len == 8):
            crc_result = check_readdata(return_data)

            if ((crc_result & 0xff) == return_data[data_len - 2]) and \
                    ((crc_result >> 8) == return_data[data_len - 1]):
                print(return_data)
                return True
            else :
                return False
        else :
            return False

    def zhize_co2_data(self, addr):
        read_co2_data_cmd = [0x01, 0x03, 0x00, 0x05, 0x00, 0x01]
        read_co2_data_cmd[0] = addr

        # add crc number
        crc_num = ca_crc(read_co2_data_cmd)
        read_co2_data_cmd.append(crc_num & 0xff)
        read_co2_data_cmd.append(crc_num >> 8)

        result = 0
        break_flag = 2
        while break_flag :
            self.com.write(read_co2_data_cmd)
            tmp_data = self.com.read(7)

            data_len = len(tmp_data)
            if (data_len == 7):
                crc_result = check_readdata(tmp_data)

                if ((crc_result & 0xff) == \
                        tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        tmp_data[data_len - 1]):
                    result = (tmp_data[3] << 8) + \
                            tmp_data[4]
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return result

    def zhize_humi_data(self, addr):
        read_humi_data_cmd = [0x01, 0x03, 0x00, 0x00, 0x00, 0x02]
        read_humi_data_cmd[0] = addr

        # add crc number
        crc_num = ca_crc(read_humi_data_cmd)
        read_humi_data_cmd.append(crc_num & 0xff)
        read_humi_data_cmd.append(crc_num >> 8)

        result = 0
        break_flag = 2
        while break_flag :
            self.com.write(read_humi_data_cmd)
            tmp_data = self.com.read(9)

            data_len = len(tmp_data)
            if (data_len == 9):
                crc_result = check_readdata(tmp_data)

                if ((crc_result & 0xff) == \
                        tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        tmp_data[data_len - 1]):
                    result = ((tmp_data[3] << 8) + \
                            tmp_data[4]) / 10
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return result

    def zhize_temp_data(self, addr):
        read_temp_data_cmd = [0x01, 0x03, 0x00, 0x00, 0x00, 0x02]
        read_temp_data_cmd[0] = addr

        # add crc number
        crc_num = ca_crc(read_temp_data_cmd)
        read_temp_data_cmd.append(crc_num & 0xff)
        read_temp_data_cmd.append(crc_num >> 8)

        result = 0
        break_flag = 2
        while break_flag :
            self.com.write(read_temp_data_cmd)
            tmp_data = self.com.read(9)

            data_len = len(tmp_data)
            if (data_len == 9):
                crc_result = check_readdata(tmp_data)

                if ((crc_result & 0xff) == \
                        tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        tmp_data[data_len - 1]):
                    result = ((tmp_data[5] << 8) + \
                            tmp_data[6]) / 10
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return result

    def zhize_light_data(self, addr):
        read_light_data_cmd = [0x01, 0x03, 0x00, 0x07, 0x00, 0x02]
        read_light_data_cmd[0] = addr

        # add crc number
        crc_num = ca_crc(read_light_data_cmd)
        read_light_data_cmd.append(crc_num & 0xff)
        read_light_data_cmd.append(crc_num >> 8)

        result = 0
        break_flag = 2
        while break_flag :
            self.com.write(read_light_data_cmd)
            tmp_data = self.com.read(9)

            data_len = len(tmp_data)
            if (data_len == 9):
                crc_result = check_readdata(tmp_data)

                if ((crc_result & 0xff) == \
                        tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        tmp_data[data_len - 1]):
                    result = ((tmp_data[3] << 24) + \
                            (tmp_data[4] << 16) + \
                            (tmp_data[5] << 8) + \
                            tmp_data[6])
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return result

    def all_data(self):
        soil_tmp_data = []

        tmp_data = self.four_data(0x2)
        time.sleep(0.5)

        soil_tmp_data = self.soil_moisture_temp(0x1)
        tmp_data.append(soil_tmp_data[0])
        tmp_data.append(soil_tmp_data[1])
        time.sleep(0.5)

        tmp_data.append(self.zhize_soil_salinity_data(0x1))
        return tmp_data

    def four_data(self, addr=0x1):
        result_data = []
        humi_data = -1
        temp_data = -1
        light_data = -1
        co2_data = -1

        read_all_data_cmd = [0x01, 0x03, 0x00, 0x00, 0x00, 0x09]
        read_all_data_cmd[0] = addr
        crc_num = ca_crc(read_all_data_cmd)

        read_all_data_cmd.append(crc_num & 0xff)
        read_all_data_cmd.append(crc_num >> 8)

        break_flag = 2
        while break_flag :
            self.com.write(read_all_data_cmd)
            sensor_all_data = self.com.read(23)

            data_len = len(sensor_all_data)
            if (data_len == 23):
                crc_result = check_readdata(sensor_all_data)

                if ((crc_result & 0xff) == \
                        sensor_all_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        sensor_all_data[data_len - 1]):
                    humi_data = ((sensor_all_data[3] << 8) + \
                            sensor_all_data[4]) / 10
                    temp_data = ((sensor_all_data[5] << 8) + \
                            sensor_all_data[6]) / 10
                    co2_data = ((sensor_all_data[13] << 8) + \
                            sensor_all_data[14])
                    light_data = ((sensor_all_data[17] << 24) + \
                            (sensor_all_data[18] << 16) + \
                            (sensor_all_data[19] << 8) + \
                            sensor_all_data[20])
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        result_data.append(temp_data)
        result_data.append(humi_data)
        result_data.append(light_data)
        result_data.append(co2_data)

        #print(result_data)
        return result_data

    def soil_moisture_temp(self, addr):
        soil_moisture_temp_data = []
        soil_temp_data = -1
        soil_humi_data = -1
        soil_moisture_temp_cmd = [0x01, 0x03, 0x00, 0x02, 0x00, 0x02]

        soil_moisture_temp_cmd[0] = addr

        crc_num = ca_crc(soil_moisture_temp_cmd)

        soil_moisture_temp_cmd.append(crc_num & 0xff)
        soil_moisture_temp_cmd.append(crc_num >> 8)

        break_flag = 2
        while break_flag :
            self.com.write(soil_moisture_temp_cmd)
            soil_tmp_data = self.com.read(9)

            data_len = len(soil_tmp_data)
            if (data_len == 9):
                crc_result = check_readdata(soil_tmp_data)

                if ((crc_result & 0xff) == \
                        soil_tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        soil_tmp_data[data_len - 1]):
                    soil_humi_data = ((soil_tmp_data[3] << 8) + \
                            soil_tmp_data[4]) / 10
                    soil_temp_data = ((soil_tmp_data[5] << 8) + \
                            soil_tmp_data[6]) / 10
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        soil_moisture_temp_data.append(soil_temp_data)
        soil_moisture_temp_data.append(soil_humi_data)

        return soil_moisture_temp_data

    def zhize_soil_ec_data(self, addr):
        soil_ec_data = 0
        soil_ec_cmd = [0x01, 0x03, 0x00, 0x14, 0x00, 0x01]

        soil_ec_cmd[0] = addr

        crc_num = ca_crc(soil_ec_cmd)

        soil_ec_cmd.append(crc_num & 0xff)
        soil_ec_cmd.append(crc_num >> 8)

        break_flag = 2
        while break_flag :
            self.com.write(soil_ec_cmd)
            soil_tmp_data = self.com.read(7)

            data_len = len(soil_tmp_data)
            if (data_len == 7):
                crc_result = check_readdata(soil_tmp_data)

                if ((crc_result & 0xff) == \
                        soil_tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        soil_tmp_data[data_len - 1]):
                    soil_ec_data = (soil_tmp_data[3] << 8) + \
                            soil_tmp_data[4]
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return soil_ec_data

    def zhize_soil_salinity_data(self, addr):
        soil_salinity_data = 0
        soil_salinity_cmd = [0x01, 0x03, 0x00, 0x15, 0x00, 0x01]
        soil_salinity_cmd[0] = addr

        crc_num = ca_crc(soil_salinity_cmd)

        soil_salinity_cmd.append(crc_num & 0xff)
        soil_salinity_cmd.append(crc_num >> 8)

        break_flag = 2
        while break_flag :
            self.com.write(soil_salinity_cmd)
            soil_tmp_data = self.com.read(7)

            data_len = len(soil_tmp_data)
            if (data_len == 7):
                crc_result = check_readdata(soil_tmp_data)

                if ((crc_result & 0xff) == \
                        soil_tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        soil_tmp_data[data_len - 1]):
                    soil_salinity_data = (soil_tmp_data[3] << 8) + \
                            soil_tmp_data[4]
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return soil_salinity_data

    def zhize_soil_temp_data(self, addr):
        read_soil_temp_data_cmd = [0x01, 0x03, 0x00, 0x02, 0x00, 0x02]
        read_soil_temp_data_cmd[0] = addr

        # add crc number
        crc_num = ca_crc(read_soil_temp_data_cmd)
        read_soil_temp_data_cmd.append(crc_num & 0xff)
        read_soil_temp_data_cmd.append(crc_num >> 8)

        result = 0
        break_flag = 2
        while break_flag :
            self.com.write(read_soil_temp_data_cmd)
            tmp_data = self.com.read(9)

            data_len = len(tmp_data)
            if (data_len == 9):
                crc_result = check_readdata(tmp_data)

                if ((crc_result & 0xff) == \
                        tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        tmp_data[data_len - 1]):
                    result = ((tmp_data[5] << 8) + \
                            tmp_data[6])/ 10
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return result


    def zhize_soil_humi_data(self, addr):
        read_soil_humi_data_cmd = [0x01, 0x03, 0x00, 0x02, 0x00, 0x01]
        read_soil_humi_data_cmd[0] = addr

        # add crc number
        crc_num = ca_crc(read_soil_humi_data_cmd)
        read_soil_humi_data_cmd.append(crc_num & 0xff)
        read_soil_humi_data_cmd.append(crc_num >> 8)

        result = 0
        break_flag = 2
        while break_flag :
            self.com.write(read_soil_humi_data_cmd)
            tmp_data = self.com.read(7)

            data_len = len(tmp_data)
            if (data_len == 7):
                crc_result = check_readdata(tmp_data)

                if ((crc_result & 0xff) == \
                        tmp_data[data_len - 2]) and \
                        ((crc_result >> 8) == \
                        tmp_data[data_len - 1]):
                    result = ((tmp_data[3] << 8) + \
                            tmp_data[4])/ 10
                    break
                else :
                    self.com.reset_input_buffer()
                    time.sleep(0.5)
                    break_flag = break_flag - 1
            else :
                self.com.reset_input_buffer()
                time.sleep(0.5)
                break_flag = break_flag - 1

        return result

if __name__ == "__main__":
    pass
    '''
    #test.change_device_addr(0x1, 0x2)
    soil_hu_te_data = test.soil_moisture_temp(0x1)
    print(soil_hu_te_data)
    time.sleep(2)
    print(test.soil_ec(0x1))
    time.sleep(2)
    print(test.soil_salinity(0x1))
    '''
    sleep_time = 0.5

    test = sensor()
    print(test.zhize_co2_data(0x2))
    time.sleep(sleep_time)
    print(test.zhize_humi_data(0x2))
    time.sleep(sleep_time)
    print(test.zhize_temp_data(0x2))
    time.sleep(sleep_time)
    print(test.zhize_light_data(0x2))
    time.sleep(sleep_time)

    print(test.zhize_soil_temp_data(0x1))
    time.sleep(sleep_time)
    print(test.zhize_soil_humi_data(0x1))
    time.sleep(sleep_time)
    print(test.zhize_soil_salinity_data(0x1))

