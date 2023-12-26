import dataclasses
import datetime
from typing import List, Optional


@dataclasses.dataclass
class Person:
    name: str
    age: int


def find_age(
    name: str,
    person_arr: List[Person],
) -> Optional[int]:
    result = [person for person in person_arr if person.name == name]
    if not result:
        return None
    return result[0].age


def add(a: int, b: int) -> int:
    return a + b


def add_one_hour(
    t: datetime.datetime,
) -> datetime.datetime:
    return t + datetime.timedelta(hours=1)


def main() -> None:
    print("hello world")


if __name__ == "__main__":
    main()
