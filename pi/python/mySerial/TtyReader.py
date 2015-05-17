

import serial
import sys

class TtyReader():
    def __init__(self, device = "/dev/ttyACM0", baud = 9600, timeout = 5):
        self.device = device
        self.baud = baud 
        self.timeout = timeout
        self.listeners = []

    def attach(self):
        tty = serial.Serial('/dev/ttyACM0', 9600, timeout=5)

        while True:
            try:
                line = tty.readline().decode('ascii')
                line = line.replace("\r\n", "\n")
                line = line.replace("\r", "\n")
                
                if len(line) == 0:
                    continue
                else:
                    self.raiseOnReceive(line)
            except Exception as e:
                sys.stderr.write(str(e))
                raise e

    def raiseOnReceive(self, line):
        for listener in self.listeners:
            listener(line)

    def addListener(self, listener):
        self.listeners.append(listener)
