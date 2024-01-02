import time
from typing import Any, Callable, TypeVar

RT = TypeVar("RT")  # return type


def timer(
    output_time_func: Callable[[int], None],
) -> Callable[[Callable[..., RT]], Callable[..., RT]]:
    """Decorator to measure performance"""

    def decorator(func: Callable[..., RT]) -> Callable[..., RT]:
        def wrapper(*args: Any, **kwargs: Any) -> RT:
            t1 = time.perf_counter_ns()
            result = func(*args, **kwargs)
            t2 = time.perf_counter_ns()
            output_time_func(t2 - t1)
            return result

        return wrapper

    return decorator
