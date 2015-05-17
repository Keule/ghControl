
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

    def assertByteValue(self, value):
        if value is None:
            raise QueryPduException("value has to be set in the derived class") 
        elif not isinstance(value, int):
            raise QueryPduException("value has to be an integer") 
        elif value < 0:
            raise QueryPduException("value has to be positive") 
        elif value > 255:
            raise QueryPduException("value should only be 8 bit") 
        else:
            return value

    def serialize(self):
        """
            Generates the data-string to send to the Arduino.
            Numbers are 3 characters wide, zero prefixed. The PDU ends with the
            End Of Transmission Character (ASCII character 4)
        """
        pdu_id = self.getPduId()
        self.assertByteValue(pdu_id)
        return "{0:03d}\n".format(pdu_id) + QueryPdu.EOT


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
        assert "001\n" + QueryPdu.EOT == queryPdu.serialize(), "serializing pdu failed: 1 - got: " + queryPdu.serialize()
        queryPdu = DummyQueryPdu(21)
        assert "021\n" + QueryPdu.EOT == queryPdu.serialize(), "serializing pdu failed: 21 - got: " + queryPdu.serialize()
        queryPdu = DummyQueryPdu(121)
        assert "121\n" + QueryPdu.EOT  == queryPdu.serialize(), "serializing pdu failed: 121 - got: " + queryPdu.serialize()

if __name__ == "__main__":
    unittest.main()
