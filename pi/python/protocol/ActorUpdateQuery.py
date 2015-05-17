#!/usr/bin/python3

# -*- coding: utf-8 -*-

from protocol.QueryPdu import QueryPdu
import unittest

class ActorUpdateQuery(QueryPdu):
    """
        Sent from Pi to Arduino.
        Causes the Arduino to list all its actors.
    """

    def __init__(self, aktorId, newValue):
        self.assertByteValue(aktorId)
        self.assertByteValue(newValue)

        # XXX: We have to test somewhere that aktorId exists and newValue is valid for it
        self.aktorId = aktorId
        self.newValue = newValue

    def serialize(self):
        ret = super(ActorUpdateQuery, self).serialize()[:-1]    # substring removes EOT
        return "{0}{1:03d},{2:03d}".format(ret, self.aktorId, self.newValue) + QueryPdu.EOT

    def getPduId(self):
        return 5

class ActorUpdateQueryTest(unittest.TestCase):
    def testSerialization(self):
        pdu = ActorUpdateQuery(10, 20)
        assert pdu.serialize() == "005\n010,020" + QueryPdu.EOT

