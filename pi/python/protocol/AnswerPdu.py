
from abc import ABCMeta, abstractmethod
import unittest

class AnswerPduException(Exception):
    pass

class ResetInAnswerPduException(AnswerPduException):
    pass

class IllegalCharInAnswerException(AnswerPduException):
    pass

class AnswerPdu(metaclass=ABCMeta):
    """
        Abstract class that defines a Protocol Data Unit that is sent from the Raspberry
        to the Arduino. 
        Actual PDUs derive from this class and define a unique pdu_id
    """
    EOT = "Z" #"\004"        # End of transmission
    CAN = chr(0x18)     # Cancel transmission on error

    errorHandlers = []
    receiveHandlers = []

    @abstractmethod
    def __init__(self, packetString):
        """
            Deserializes packetString
        """
        pass

    @abstractmethod
    def getPduId(self):
        pass

    @abstractmethod
    def deserialize(self, packetString):
        pass

    def addOnErrorHandler(self, callback):
        self.receiveHandlers.append(callback)

    def addOnReceiveHandler(self, callback):
        self.errorHandlers.append(callback)

    @abstractmethod
    def getLastPacket(self):
        pass

    def raiseOnError(self, exception = None):
        for handler in self.errorHandlers:
            handler(exception)

    def raiseOnReceive(self):
        for handler in self.receiveHandlers:
            handler(self)

    def removeAndVerifyPduId(self, packetString):
        expectedPdu = "{0}\n".format(self.getPduId())
        if not packetString.startswith(expectedPdu):
            exc = AnswerPduException("PDU did not match %s in %s" % (expectedPdu, packetString))
            self.raiseOnError(exc)
            raise exc
        return packetString[len(expectedPdu):]

# -------------------------------------------------------------------------------
# Only tests and foo below this line
#

class AnswerPduTest(unittest.TestCase):
    def testInitializeAbstractClass(self):
        exceptionWasThrown = False
        try:
            answerPdu = AnswerPdu()
        except TypeError as e:
            exceptionWasThrown = True
        assert exceptionWasThrown, "AnswerPdu should not be initializable"






if __name__ == "__main__":
    unittest.main()
