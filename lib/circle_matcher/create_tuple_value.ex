defmodule Matcher.CreateTupleValue do
  def generate_value(json) do
    {:ok, data} = Jason.decode(json, keys: :atoms)

    data.rules.clauses
    |> extract_operation()
    |> extract_content()
    |> wrap_content(data.rules)
  end

  defp extract_operation(clauses) do
    Enum.map(clauses, fn c ->
      transform_node(c)
    end)
  end

  defp transform_node(node = %{type: "CLAUSE", clauses: sub_clauses}) do
    %{
      operation: node.logicalOperator,
      clauses: Enum.map(transform_node(sub_clauses), fn c -> c.clause end)
    }
  end

  defp transform_node(%{type: "RULE", content: content}) do
    %{
      clause: content
    }
  end

  defp transform_node(nodes) when is_list(nodes) do
    Enum.map(nodes, fn n -> transform_node(n) end)
  end

  defp extract_content(clauses) when is_list(clauses) do
    clauses
    |> Enum.map(fn clause ->
      extract_content(clause)
    end)
  end

  defp extract_content(%{clauses: clauses, operation: operation}) do
    %{
      operation: operation,
      rules: extract_content_from_list(clauses)
    }
  end

  defp extract_content(%{clause: clause}) do
    %{
      lhs: clause.key,
      condition: clause.condition,
      rhs: clause.value |> List.first()
    }
  end

  defp extract_content_from_list(clauses) do
    clauses
    |> Enum.map(fn x ->
      extract_content(%{clause: x})
    end)
  end

  defp wrap_content(rules, %{logicalOperator: operator}) do
    %{
      operation: operator,
      rules: rules
    }
  end

  defp wrap_content(rules, _) do
    rules
    |> List.first()
  end
end
