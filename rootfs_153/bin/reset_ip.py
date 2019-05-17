#!/usr/bin/python3

import threading
import time
import signal
import os
import fcntl

class rainfull():
    def __init__(self):
        self.rain_data = 0

        self.gpio0_irq_file = open("/dev/switch")
        signal.signal(signal.SIGIO, self.get_rain_data)
        fcntl.fcntl(self.gpio0_irq_file, fcntl.F_SETOWN, os.getpid())
        flags = fcntl.fcntl(self.gpio0_irq_file, fcntl.F_GETFL);
        flags |= os.O_ASYNC;
        fcntl.fcntl(self.gpio0_irq_file, fcntl.F_SETFL, flags);

        self.time_before = time.time()
        self.time_after = 0

    def get_rain_data(self, signum, frame):
        os.system("/etc/init.d/reset_ip.sh")
        pass

if __name__ == "__main__" :
    test = rainfull()
    while True :
        time.sleep(100)

