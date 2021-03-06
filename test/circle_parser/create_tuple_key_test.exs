defmodule EtsKeyTest do
  use ExUnit.Case
  alias Matcher.CreateTupleKey

  test "angelica" do
    json_string = """
    {
      "name": "Nested",
      "workspaceId": "42be29b6-b045-48cd-88a3-d7859e721a1d",
      "rules": {
        "logicalOperator": "OR",
        "type": "CLAUSE",
        "clauses": [
          {
            "logicalOperator": "AND",
            "type": "CLAUSE",
            "clauses": [
              {
                "type": "RULE",
                "content": {
                  "key": "name",
                  "value": [
                    "tester1"
                  ],
                  "condition": "EQUAL"
                }
              },
              {
                "type": "RULE",
                "content": {
                  "key": "age",
                  "value": [
                    "12"
                  ],
                  "condition": "EQUAL"
                }
              }
            ]
          },
          {
            "type": "RULE",
            "content": {
              "key": "name",
              "value": [
                "tester"
              ],
              "condition": "EQUAL"
            }
          }
        ]
      },
      "authorId": "c7e6dafe-aa7a-4536-be1b-34eaad4c2915"
    }
    """
    expected = {"42be29b6-b045-48cd-88a3-d7859e721a1d", {{"name", "tester1"}, {"age", "12"}}, {{"name", "tester"}}}
    assert CreateTupleKey.generate_keys(json_string) == expected
  end

  test "parse to ets tuple with single rule" do
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

    expected = {"96c4e727-a7d2-4d1f-9ccd-215c54c13889", {{"username", "user@email.com"}}}

    assert CreateTupleKey.generate_keys(json_string) == expected
  end

  test "parse to ets tuple with multiple rules" do
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

    expected =
      {"96c4e727-a7d2-4d1f-9ccd-215c54c13889", {{"username", "email@email.com"}, {"age", "18"}}}

    assert CreateTupleKey.generate_keys(json_string) == expected
  end
end
