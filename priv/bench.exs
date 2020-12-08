list = Enum.to_list(1..10_000)
map_fun = fn i -> [i, i * i] end

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

quoted = quote do: (var!(name) == "joe" && var!(age) == "12") && var!(role) == "tester"

# IO.inspect(RulesetToExpression.run(rule, match))
# IO.inspect(Code.eval_quoted(quoted, [name: "joe", age: "12", role: "tester"]))
Benchee.run(%{
  "custom_rule" => fn -> RulesetToExpression.run(rule, match) end,
  "eval_quoted" => fn -> Code.eval_quoted(quoted, [name: "joe", age: "12", role: "tester"]) end
})
