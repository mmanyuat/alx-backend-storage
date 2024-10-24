#!/usr/bin/env python3
"""
Importing redis for the Redis server.
Uuid generates unique identifiers.
Union from typing - used for Python type annotation.
"""

import redis
import uuid
from typing import Union, Optional, Callable
from functools import wraps


def count_calls(method: callable) -> callable:
    """Decorator to count how many times a method is called"""

    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """wrapper that increments the count in redis"""
        input_key = f"{method.__qualname__}:inputs"
        output_key = f"{method.__qualname__}:outputs"

        self._redis.rpush(input_key, str(args))
        output = method(self, *args, **kwargs)
        self._redis.rpush(output_key, str(output))
        return output
    return wrapper


class Cache:
    """A class that starts Redis server, takes data
    and stores it there.
    """

    def __init__(self):
        """Constructor that initializes Redis server"""
        self._redis = redis.Redis()
        self._redis.flushdb()

    @call_history
    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """Generates a unique key for every value"""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) ->
    Optional[Union[str, bytes, int, float]]:
        """Retrieveand apply an optional conversion function."""
        data = self._redis.get(key)
        if data is None:
            return None

        if fn:
            return fn(data)

        return data

    def get_str(self, key: str) -> Optional[str]:
        """Retrieve a string value from Redis and decode as UTF-8."""
        return self.get(key, lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        """Retrieve an integer value from Redis."""
        return self.get(key, lambda d: int(d))
