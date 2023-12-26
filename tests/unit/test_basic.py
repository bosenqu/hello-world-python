import datetime
import unittest

from src import hello_world


class TestBasic(unittest.TestCase):
    def test_upper(self) -> None:
        self.assertEqual(
            "foo".upper(),
            "FOO",
        )

    def test_add(self) -> None:
        self.assertEqual(
            hello_world.add(1, 2),
            3,
        )

    def test_add_one_hour(self) -> None:
        self.assertEqual(
            hello_world.add_one_hour(
                datetime.datetime(
                    2023,
                    1,
                    1,
                )
            ),
            datetime.datetime(
                2023,
                1,
                1,
                1,
            ),
        )
