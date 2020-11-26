defmodule CreateEtsRecordTest do
  use ExUnit.Case
  alias Matcher.CreateEtsRecord

  test "generate record tuple for simple rule" do
    json_string = """
    {
    "name": "Test",
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

    expected = {
      {"96c4e727-a7d2-4d1f-9ccd-215c54c13889", {{"username", "user@email.com"}}},
      {
        %{
          rules: [
            %{
              lhs: "username",
              condition: "EQUAL",
              rhs: "user@email.com"
            }
          ]
        }
      }
    }

    assert CreateEtsRecord.generate_record(json_string) == expected
  end
end
