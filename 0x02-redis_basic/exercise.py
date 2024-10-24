#!/usr/bin/env python3
"""
importing redis for the redis server
Uuid generates a uniques identifiers
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

    def get(self, key: str, fn:
            optional[callable] = None -> Union[str, bytes, int, float, None]:
            data = self._redis.get(key)
            if data is None:
                return None

            if fn:
                return fn(data)

            return data
    
    def get_str(self, key: str) -> optional[str]:
        """Retrieve a string value from the redis"""
        return self.get(key, lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> optional[int]:
    """Retrieve an integer value from the redis"""
        return self.get(key, lambda d: int(d))
