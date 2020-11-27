defmodule RulesetToExpressionTest do
  use ExUnit.Case

  test "generate correct EQUAL rule" do
    rule = %{
      lhs: "username",
      condition: "EQUAL",
      rhs: "user@email.com"
    }

    match = %{
      data: %{
        username: "user@email.com",
        irrelevant: "data"
      }
    }

    dont_match = %{
      data: %{
        username: "something"
      }
    }

    assert RulesetToExpression.run(rule, match) == true
    assert RulesetToExpression.run(rule, dont_match) == false
  end

  test "generate correct EQUAL rule with OR operation" do
    rule = %{
      operation: "OR",
      rules: [
        %{
          lhs: "username",
          condition: "EQUAL",
          rhs: "email@email.com"
        },
        %{
          lhs: "age",
          condition: "GREATER_THAN",
          rhs: "18"
        }
      ]
    }

    match = %{
      data: %{
        username: "email@email.com",
        age: "20"
      }
    }

    also_match = %{
      data: %{
        username: "email@email.com",
        age: "10"
      }
    }

    dont_match = %{
      data: %{
        username: "another@email.com",
        age: "10"
      }
    }

    assert RulesetToExpression.run(rule, match) == true
    assert RulesetToExpression.run(rule, also_match) == true
    assert RulesetToExpression.run(rule, dont_match) == false
  end

  test "generate correct EQUAL rule with AND operation" do
    rule = %{
      operation: "AND",
      rules: [
        %{
          lhs: "username",
          condition: "EQUAL",
          rhs: "email@email.com"
        },
        %{
          lhs: "age",
          condition: "GREATER_THAN",
          rhs: "18"
        }
      ]
    }

    match = %{
      data: %{
        username: "email@email.com",
        age: "20"
      }
    }

    dont_match = %{
      data: %{
        username: "email@email.com",
        age: "10"
      }
    }

    also_dont_match = %{
      data: %{
        username: "wrong@email.com",
        age: "20"
      }
    }

    assert RulesetToExpression.run(rule, match) == true
    assert RulesetToExpression.run(rule, dont_match) == false
    assert RulesetToExpression.run(rule, also_dont_match) == false
  end

  test "generate corret GREATER_THAN rule" do
    rule = %{
      lhs: "age",
      condition: "GREATER_THAN",
      rhs: "18"
    }

    match = %{
      data: %{
        age: "20"
      }
    }

    dont_match = %{
      data: %{
        age: "17"
      }
    }

    assert RulesetToExpression.run(rule, match) == true
    assert RulesetToExpression.run(rule, dont_match) == false
  end

  test "grouped rule OR" do
    rule = %{
      operation: "OR",
      rules: [
        %{
          operation: "AND",
          rules: [
            %{
              lhs: "name",
              condition: "EQUAL",
              rhs: "tester1"
            },
            %{
              lhs: "age",
              condition: "EQUAL",
              rhs: "12"
            }
          ]
        },
        %{
          lhs: "role",
          condition: "EQUAL",
          rhs: "admin"
        }
      ]
    }

    match = %{
      data: %{
        role: "admin"
      }
    }

    also_match = %{
      data: %{
        name: "tester1",
        age: "12"
      }
    }

    dont_match = %{
      data: %{
        name: "tester1",
        age: "10",
        role: "dev"
      }
    }

    assert RulesetToExpression.run(rule, match) == true
    assert RulesetToExpression.run(rule, also_match) == true
    assert RulesetToExpression.run(rule, dont_match) == false
  end

  test "grouped rule AND" do
    rule = %{
      operation: "AND",
      rules: [
        %{
          operation: "AND",
          rules: [
            %{
              lhs: "name",
              condition: "EQUAL",
              rhs: "joe"
            },
            %{
              lhs: "age",
              condition: "EQUAL",
              rhs: "12"
            }
          ]
        },
        %{
          lhs: "role",
          condition: "EQUAL",
          rhs: "tester"
        }
      ]
    }

    match = %{
      data: %{
        name: "joe",
        age: "12",
        role: "tester"
      }
    }

    dont_match = %{
      data: %{
        name: "tester"
      }
    }

    also_dont_match = %{
      data: %{
        name: "joe",
        age: "12"
      }
    }

    assert RulesetToExpression.run(rule, match) == true
    assert RulesetToExpression.run(rule, dont_match) == false
    assert RulesetToExpression.run(rule, also_dont_match) == false
  end
end
