
from protocol.AnswerPdu import AnswerPduException, ResetInAnswerPduException, IllegalCharInAnswerException, AnswerPdu
import unittest
from io import StringIO
import csv

class StatusAnswer(AnswerPdu):
    fieldnames = [ "id", "type", "value", "status" ]

    def __init__(self, packetString = None):
        self.lastResult = None
        if packetString is not None:
            self.deserialize(packetString)

    def getPduId(self):
        return 2

    def deserialize(self, packetString):
        # TODO: Decide where to remove PDU Header
        packetString = self.removeAndVerifyPduId(packetString)

        with StringIO(packetString) as stream:
            reader = csv.DictReader(stream, fieldnames = StatusAnswer.fieldnames, restkey="overshoot")
            self.lastResult = [ row for row in reader]
            for row in self.lastResult:
                if row.get("overshoot", None) is not None:
                    exc = AnswerPduException("To many fields to unpack in line %s of\n%s" % repr(row, packetString))
                    self.raiseOnError(exc)
                    raise exc
                for key,value in row.items():
                    if value is None:
                        exc = AnswerPduException("There where to view columns to unpack in line %s when unpacking\n%s" % (repr(row), packetString))
                        self.raiseOnError(exc)
                        raise exc
                    try:
                        row[key] = int(value)
                    except ValueError as e:
                        exc = IllegalCharInAnswerException("Error converting value of key %s: %s when unpacking:\n%s" % (key, e, packetString))
                        self.raiseOnError(exc)
                        raise exc

        self.raiseOnReceive()
        return self.lastResult

    def getLastPacket(self):
        return self.lastResult

    def __repr__(self):
        sensors = ""
        for sensor in self.lastResult:
            sensors = sensors + "  <Sensor id=\"%d\" type=\"%d\" value=\"%d\" status=\"%d\" />\n" % \
                    (sensor.get("id", -1), sensor.get("type", -1), sensor.get("value", -1), sensor.get("status", -1))
        return "<StatusAnswer>\n%s</StatusAnswer>" % sensors



# -------------------------------------------------------------------------------
# Only tests and foo below this line
#

class StatusAnswerTest(unittest.TestCase):
    def testCorrectStatusAnswer(self):
        pdu = StatusAnswer("2\n010,020,030,440\n")
        result = pdu.getLastPacket()

        assert result[0].get("value") == 30, "Expected value of 30" 
        assert result[0].get("id") == 10, "Expected id of 10"
        assert result[0].get("type") == 20, "Expected type 20"
        assert result[0].get("status") == 440, "Expected status 440"
        assert len(result) == 1

if __name__ == "__main__":
    unittest.main()
