create_attrs = %{
  "circle" => %{
    "name" => "Tester Circle",
    "author_id" => "c7e6dafe-aa7a-4536-be1b-34eaad4c2915",
    "workspace_id" => "c7e6dafe-aa7a-4536-be1b-34eaad4c2915",
    "segmentation" => %{"lhs" => "name", "condition" => "EQUAL", "rhs" => "tester"}
  }
}

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

create_attrs = %{ "circle" => %{ "name" => "Tester Circle", "author_id" => "c7e6dafe-aa7a-4536-be1b-34eaad4c2915", "workspace_id" => "c7e6dafe-aa7a-4536-be1b-34eaad4c2915", "segmentation" => %{"lhs" => "name", "condition" => "EQUAL", "rhs" => "tester"} } }
