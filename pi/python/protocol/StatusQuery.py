#!/usr/bin/python3

# -*- coding: utf-8 -*-

from protocol.QueryPdu import QueryPdu

class StatusQuery(QueryPdu):
    """
        Sent from Pi to Arduino.
        Causes the Arduino to list all its sensors. The response to this should be a
        StatusResponsePdu. A StatusResponsePdu may be sent even if no StatusQueryPdu
        has been sent before.
    """

    def __init__(self):
        pass

    def getPduId(self):
        return 1




