from protocol.QueryPdu import QueryPdu, QueryPduTest
from protocol.NoOpQuery import NoOpQuery
from protocol.StatusQuery import StatusQuery

from protocol.AnswerPdu import AnswerPdu, AnswerPduTest
from protocol.StatusAnswer import StatusAnswer, StatusAnswerTest

from threading import Lock
import unittest

__all__ = [ NoOpQuery, StatusQuery ]

pdus = [
    NoOpQuery,      # PduId = 0
    StatusQuery,    # PduId = 1
    StatusAnswer    # PduId = 2
    # Query Actors 3
    # Send Control signal 5
    ]

receiveListenerMap = {}
errorListenerMap = {}

buffer = ""
bufferLock = Lock()
def dispatchPacket(read):
    global buffer
    global bufferLock
    global receiveListenerMap
    global errorListenerMap

    bufferLock.acquire()
    buffer = buffer + read
    if AnswerPdu.EOT in buffer:
        packets = buffer.split(AnswerPdu.EOT)
        buffer = packets.pop()
        bufferLock.release()

        for packet in packets:
            try:
                #print("Got: ", packet)
                pdu_id = int(packet.split("\n")[0])
                pdu = pdus[pdu_id]()
                for listener in receiveListenerMap.get(pdus[pdu_id], []):
                    pdu.addOnReceiveHandler(listener)
                for listener in errorListenerMap.get(pdus[pdu_id], []):
                    pdu.addOnErrorHandler(listener)
                pdu.deserialize(packet)
            except ValueError as e:
                # Happens on attach: the first package is not complete
                pass
    else:
        bufferLock.release()

def addReceiveListener(pduClass, callback):
    global receiveListenerMap

    if not pduClass in receiveListenerMap:
        receiveListenerMap[pduClass] = []

    receiveListenerMap[pduClass].append(callback)

def addErrorListener(pduClass, callback):
    global errorListenerMap

    if not pduClass in errorListenerMap:
        errorListenerMap[pduClass] = []

    errorListenerMap[pduClass].append(callback)



class TestAllQueryPdus(unittest.TestCase):
    def testPduIdMapping(self):
        for i in range(0, len(pdus)):
            pdu = pdus[i]
            #assert issubclass(pdu, QueryPdu), "%s has wrong type - expected derived from QueryPdu" % repr(pdu)
            instance = pdu()
            assert i == instance.getPduId(), "Wrong PDU-Mapping from %s to %d" % (repr(pdu), i)

if __name__ == "__main__":
    suite = unittest.TestSuite((
            unittest.makeSuite(TestAllQueryPdus,'test'),
            unittest.makeSuite(QueryPduTest, 'test'),
            unittest.makeSuite(AnswerPduTest, 'test'),
            unittest.makeSuite(StatusAnswerTest, 'test')
        ))

    runner = unittest.TextTestRunner()
    runner.run(suite)

