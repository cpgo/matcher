defmodule RulesetToExpressionTest do
  use ExUnit.Case
  alias Matcher.CreateEtsRecord

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
