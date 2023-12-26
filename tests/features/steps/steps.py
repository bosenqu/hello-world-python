import behave

from src import hello_world


@behave.given("I have two numbers {a:d} and {b:d}")
def given_numbers_step(
    context: behave.runner.Context,
    a: int,
    b: int,
) -> None:
    context.a = a
    context.b = b


@behave.given("a set of people")
def given_people_step(
    context: behave.runner.Context,
) -> None:
    context.people = []
    for row in context.table:
        context.people.append(
            hello_world.Person(
                name=row["name"],
                age=int(row["age"]),
            )
        )


@behave.when("I call function add")
def add_step(
    context: behave.runner.Context,
) -> None:
    context.result = hello_world.add(
        context.a,
        context.b,
    )


@behave.then("the result will be {result:d}")
def check_result_step(
    context: behave.runner.Context,
    result: int,
) -> None:
    assert context.result == result


@behave.then("{name} is {age:d} years old")
def check_age_step(
    context: behave.runner.Context,
    name: str,
    age: int,
):
    assert (
        hello_world.find_age(
            name,
            context.people,
        )
        == age
    )
