Feature: test person

  Scenario: test find age
    # This is a basic comment
    Given a set of people
      | name  | age |
      | Sarah | 26  |
      | Tim   | 24  |
      | Mike  | 33  |
    Then Sarah is 26 years old
