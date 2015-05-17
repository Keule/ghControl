#!/usr/bin/python3

# -*- coding: utf-8 -*-

from protocol.QueryPdu import QueryPdu

class ActorListQuery(QueryPdu):
    """
        Sent from Pi to Arduino.
        Causes the Arduino to list all its actors.
    """

    def __init__(self):
        pass

    def getPduId(self):
        return 3




