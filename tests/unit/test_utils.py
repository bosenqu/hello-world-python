import time
import unittest
from typing import List

import src.utils


class TestBasic(unittest.TestCase):
    def test_timer_records_correct_time(self) -> None:
        @src.utils.timer(lambda t: self.assertGreater(t, 1e9))
        def wait_one_sec() -> None:
            time.sleep(1)

        self.assertIsNone(wait_one_sec())

    def test_timer_decorator_returns_correct_output(self) -> None:
        @src.utils.timer(lambda _: None)
        def return_int() -> int:
            return 13

        @src.utils.timer(lambda _: None)
        def return_str() -> str:
            return "hello world"

        @src.utils.timer(lambda _: None)
        def return_list() -> List[int]:
            return [1, 2, 3]

        self.assertEqual(return_int(), 13)
        self.assertEqual(return_str(), "hello world")
        self.assertListEqual(return_list(), [1, 2, 3])
