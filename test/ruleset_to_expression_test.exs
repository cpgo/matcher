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
    rule = {
      %{
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
    rule = {
      %{
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
end
