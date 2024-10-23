#!/usr/bin/ env python3
"""
importing redis for the redis server
Uuid genertates a uniques identifiers
union from tying - used for python type annotation
"""


import redis
import uuid
from typing import Union

class Cache:
    """A class that starts redis server, takes data
    and stores it there
    """

    def __init__(self):
        """Constructor that initialzes redis server"""
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """Generates a unique key for every value"""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

