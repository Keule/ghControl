
from protocol.AnswerPdu import AnswerPduException, ResetInAnswerPduException, IllegalCharInAnswerException, AnswerPdu
import unittest
from io import StringIO
import csv

class ActorListAnswer(AnswerPdu):
    fieldnames = [ "id", "type", "value", "status" ]

    def __init__(self, packetString = None):
        self.lastResult = None
        if packetString is not None:
            self.deserialize(packetString)

    def getPduId(self):
        return 4

    def getFieldNames(self):
        return ActorListAnswer.fieldnames

    def getLastPacket(self):
        return self.lastResult

    def __repr__(self):
        actorss = ""
        for actor in self.lastResult:
            actor = actor + "  <Actor id=\"%d\" type=\"%d\" value=\"%d\" status=\"%d\" />\n" % \
                    (sensor.get("id", -1), sensor.get("type", -1), sensor.get("value", -1), sensor.get("status", -1))
        return "<ActorListAnswer>\n%s</ActorListAnswer>" % sensors



# -------------------------------------------------------------------------------
# Only tests and foo below this line
#

class ActorListAnswerTest(unittest.TestCase):
    def testCorrectActorListAnswer(self):
        pdu = ActorListAnswer("4\n010,020,030,440\n")
        result = pdu.getLastPacket()

        assert result[0].get("value") == 30, "Expected value of 30" 
        assert result[0].get("id") == 10, "Expected id of 10"
        assert result[0].get("type") == 20, "Expected type 20"
        assert result[0].get("status") == 440, "Expected status 440"
        assert len(result) == 1

if __name__ == "__main__":
    unittest.main()
