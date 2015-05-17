#!/usr/bin/python3

# -*- coding: utf-8 -*-

from protocol.QueryPdu import QueryPdu

class NoOpQuery(QueryPdu):
    """
        Sent from Pi to Arduino.
        Resets the Watch dog on the Arduino
    """

    def __init__(self):
        pass

    def getPduId(self):
        return 0


