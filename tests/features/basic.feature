Feature: Showing off behave

  Scenario: run a simple test
    # This is a basic comment
    Given I have two numbers 1 and 2
    When I call function add
    Then the result will be 3

  Scenario: run another simple test
    """
      This is a block comment
    """

    Given I have two numbers 2 and 2
    When I call function add
    Then the result will be 4
