defmodule EtsValueTest do
  use ExUnit.Case
  alias Matcher.CreateTupleValue

  test "angelica" do
    json_string = """
    {
      "name": "Nested",
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

    expected =
      %{
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
            lhs: "name",
            condition: "EQUAL",
            rhs: "tester"
          }
        ]
      }


    assert CreateTupleValue.generate_value(json_string) == expected
  end

  test "parse single rule expression" do
    json_string = """
    {
    "name": "Testestestetsets",
    "workspaceId": "96c4e727-a7d2-4d1f-9ccd-215c54c13889",
    "rules": {
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

    expected =
      %{
        condition: "EQUAL",
        lhs: "username",
        rhs: "user@email.com"
      }


    assert CreateTupleValue.generate_value(json_string) == expected
  end

  test "parse two rule OR expression" do
    json_string = """
    {
      "name": "Composite",
      "workspaceId": "96c4e727-a7d2-4d1f-9ccd-215c54c13889",
      "rules": {
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


    assert CreateTupleValue.generate_value(json_string) == expected
  end

  test "parse three rule OR expression" do
    json_string = """
    {
    "name": "Composite",
    "rules": {
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
                                "admin"
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
                    },
                    {
                        "type": "RULE",
                        "content": {
                            "key": "role",
                            "value": [
                                "root"
                            ],
                            "condition": "EQUAL"
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
      %{
        operation: "OR",
        rules: [
          %{
            lhs: "username",
            condition: "EQUAL",
            rhs: "admin"
          },
          %{
            lhs: "age",
            condition: "GREATER_THAN",
            rhs: "18"
          },
          %{
            lhs: "role",
            condition: "EQUAL",
            rhs: "root"
          }
        ]
      }


    assert CreateTupleValue.generate_value(json_string) == expected
  end
end
