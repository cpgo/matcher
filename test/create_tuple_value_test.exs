defmodule EtsValueTest do
  use ExUnit.Case
  alias Matcher.CreateTupleValue

  test "parse single rule expression" do
    json_string = """
    {
    "name": "Testestestetsets",
    "workspaceId": "96c4e727-a7d2-4d1f-9ccd-215c54c13889",
    "rules": {
        "logicalOperator": "OR",
        "type": "CLAUSE",
        "clauses": [
            {
                "type": "RULE",
                "content": {
                    "key": "username",
                    "value": [
                        "user@email.com"
                    ],
                    "condition": "EQUAL"
                }
            }
        ]
    },
    "authorId": "c7e6dafe-aa7a-4536-be1b-34eaad4c2915"
    }
    """

    expected = {"username", "EQUAL", "user@email.com"}
    assert CreateTupleValue.generate_value(json_string) == expected
  end

  test "parse multiple rule expression" do
    json_string = """
    {
      "name": "Composite",
      "workspaceId": "96c4e727-a7d2-4d1f-9ccd-215c54c13889",
      "rules": {
        "logicalOperator": "OR",
        "type": "CLAUSE",
        "clauses": [
          {
            "logicalOperator": "OR",
            "type": "CLAUSE",
            "clauses": [
              {
                "type": "RULE",
                "content": {
                  "key": "username",
                  "value": [
                    "email@email.com"
                  ],
                  "condition": "EQUAL"
                }
              },
              {
                "type": "RULE",
                "content": {
                  "key": "age",
                  "value": [
                    "18"
                  ],
                  "condition": "GREATER_THAN"
                }
              }
            ]
          }
        ]
      },
      "authorId": "c7e6dafe-aa7a-4536-be1b-34eaad4c2915"
    }
    """

    expected = {{"username", "EQUAL", "user@email.com"}, "OR", {"age", "GREATER_THAN", "18"}}
    assert CreateTupleValue.rule_value(json_string) == expected
  end
end

[
  {
    {
      {
        :"$1",
        {{"username", "user@email.com"}}
      },
      :"$2"
    },
    [],
    [:"$1"]
  }
]
