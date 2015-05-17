

from mySerial import TtyReader
import protocol
import sys

def printPdu(pdu):
    print(repr(pdu))

def main():
    reader = TtyReader(device = "/dev/ttyACM0") 
    reader.addListener(protocol.dispatchPacket)

    protocol.addReceiveListener(protocol.NoOpQuery, printPdu)
    protocol.addReceiveListener(protocol.StatusQuery, printPdu)
    protocol.addReceiveListener(protocol.StatusAnswer, printPdu)

    protocol.addErrorListener(protocol.NoOpQuery, printPdu)
    protocol.addErrorListener(protocol.StatusQuery, printPdu)
    protocol.addErrorListener(protocol.StatusAnswer, printPdu)

    reader.attach()

if __name__ == "__main__":
    if sys.version_info[0] < 3 and sys.version_info[1] < 4:
        print("Run using Python 3.4 or higher")
    main()
