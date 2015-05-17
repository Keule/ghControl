
import threading
import protocol

class Ping():
    """
        Ping sends a NoOpPdu from the Pi tor the Arduino. 
        If this PDU is not sent the Arduino will run into its Watch-Dog timer
    """

    def __init__(self, tty, timeout = 4.0):
        """Timeout is in seconds. Maximum value for arduinos Watchdog timer is 8s"""
        self.tty = tty
        self.lock = threading.Lock()
        self.timeout = timeout

    def sendNoOp(self):
        print("Seinding NoOp")
        pdu = protocol.NoOpQuery()
        self._restart()

    def _restart(self):
        self.lock.acquire()
        if self.thread is not None:
            self.thread = threading.Timer(self.timeout, Ping.sendNoOp, args = [self])
            self.thread.start()
        self.lock.release()

    def start(self):
        self.lock.acquire()
        self.thread = "Not None"
        self.lock.release()
        self._restart()

    def stop(self):
        if self.thread:
            self.lock.acquire()
            self.thread.cancel()
            self.thread = None
            self.lock.release()


