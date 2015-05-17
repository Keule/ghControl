
from abc import ABCMeta, abstractmethod
import unittest

class QueryPduException(Exception):
    pass

class QueryPdu(metaclass=ABCMeta):
    """
        Abstract class that defines a Protocol Data Unit that is sent from the Raspberry
        to the Arduino. 
        Actual PDUs derive from this class and define a unique pdu_id
    """
    EOT = "Z" # "\004"        # End of transmission
    CAN = chr(0x18)     # Cancel transmission on error

    @abstractmethod
    def __init__(self):
        pass

    @abstractmethod
    def getPduId(self):
        pass

    def serialize(self):
        """
            Generates the data-string to send to the Arduino.
            Numbers are 3 characters wide, zero prefixed. The PDU ends with the
            End Of Transmission Character (ASCII character 4)
        """
        pdu_id = self.getPduId()
        if pdu_id is None:
            raise QueryPduException("pdu_id has to be set in the derived class") 
        elif not isinstance(pdu_id, int):
            raise QueryPduException("pdu_id has to be an integer") 
        elif pdu_id < 0:
            raise QueryPduException("pdu_id has to be positive") 
        elif pdu_id > 255:
            # The Arduino should be able to evaluate PDUs with a higher pdu_id
            # but we should not sent one
            raise QueryPduException("pdu_id should only be 8 bit") 
        else:
            return "{0:03d}".format(pdu_id) + QueryPdu.EOT


# -------------------------------------------------------------------------------
# Only tests and foo below this line
#

class QueryPduTest(unittest.TestCase):
    def testInitializeAbstractClass(self):
        exceptionWasThrown = False
        try:
            queryPdu = QueryPdu()
        except TypeError as e:
            exceptionWasThrown = True
        assert exceptionWasThrown, "QueryPdu should not be initializable"

    def testSerializeBadPduIds(self):
        class DummyQueryPdu(QueryPdu):
            def __init__(self, pdu_id):
                self.pdu_id = pdu_id
            def getPduId(self):
                return self.pdu_id

        for test_pdu in [ None, -1, 256, '1' ]:
            exceptionWasThrown = False
            queryPdu = DummyQueryPdu(test_pdu)
            
            try:
                queryPdu.serialize()
            except QueryPduException as e:
                exceptionWasThrown = True

            assert exceptionWasThrown, "serialize without pdu_id (%s) should have thrown an exception" % repr(test_pdu)

    def testSerializeGoodPduIds(self):
        class DummyQueryPdu(QueryPdu):
            def __init__(self, pdu_id):
                self.pdu_id = pdu_id
            def getPduId(self):
                return self.pdu_id

        queryPdu = DummyQueryPdu(1)
        assert "001\004" == queryPdu.serialize(), "serializing pdu failed: 1" 
        queryPdu = DummyQueryPdu(21)
        assert "021\004" == queryPdu.serialize(), "serializing pdu failed: 21"
        queryPdu = DummyQueryPdu(121)
        assert "121\004" == queryPdu.serialize(), "serializing pdu failed: 121"

if __name__ == "__main__":
    unittest.main()
