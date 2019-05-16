#!/usr/bin/python3

import json
import time
import os

class security_app():
    def __init__(self):
        self.count_file_name = "../Security/count_data"
        self.count = 0
        tmp_num = 0
        self.count_restart_app = 0

        with open(self.count_file_name) as f:
            tmp_data = f.read()
            #print(tmp_data)
        try :
            tmp_num = int(tmp_data)
        except :
            tmp_num = self.count

        self.count = tmp_num

    def write_count(self):
        self.count_restart_app = self.count_restart_app + 1
        self.count = self.count + 1
        with open(self.count_file_name, 'w') as f:
            f.write(str(self.count))
        os.system("sync")

    def clear_count(self):
        self.count = 0
        self.count_restart_app = 0
        with open(self.count_file_name, 'w') as f:
            f.write(str(self.count))
        os.system("sync")

    def add_count(self):
        self.write_count()
        if (self.count == 900):
            self.clear_count()
            os.system("echo 0 > /dev/watchdog")

        if (self.count_restart_app == 300):
            os.system("sync")
            os.system("/etc/init.d/S99rc restart")

if __name__ == "__main__":
    test = security_app()
    test.write_count()
    test.add_count()
