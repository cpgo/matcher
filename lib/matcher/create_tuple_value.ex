defmodule Matcher.CreateTupleValue do
  def generate_value(json) do
    {:ok, data} = Jason.decode(json, keys: :atoms)

    # extracted_rules =
    #   data.rules.clauses
    #   |> Enum.map(fn x -> extract_content(x) end)
    data.rules.clauses
    |> extract_operation()
    |> extract_content()
    |> wrap_content()
  end

  def extract_operation(clauses) do
    Enum.reduce(clauses, [], fn c, acc ->
      reduce_node(c, acc)
    end)
  end

  def reduce_node(node = %{type: "CLAUSE", clauses: sub_clauses}, acc) do
    %{
      operation: node.logicalOperator,
      clauses: acc ++ sub_clauses
    }
  end

  def reduce_node(%{type: "RULE", content: content}, _) do
    %{
      clause: content
    }
  end

  def extract_content(%{clauses: clauses, operation: operation}) do
    %{
      op: operation,
      rules: extract_content_from_list(clauses)
    }
  end

  def extract_content(%{clause: clause}) do
    %{
      lhs: clause.key,
      condition: clause.condition,
      rhs: clause.value |> List.first()
    }
  end

  def extract_content_from_list(clauses) do
    clauses
    |> Enum.map(fn x ->
      %{
        lhs: x.content.key,
        condition: x.content.condition,
        rhs: x.content.value |> List.first()
      }
    end)
  end

  def wrap_content(clause = %{lhs: _}) do
    {
      %{
        rules: [clause]
      }
    }
  end

  def wrap_content(%{op: op, rules: rules}) do
    {
      %{
        operation: op,
        rules: rules
      }
    }
  end

  # def wrap_content(clause = %{sub_rules: _, operation: _}) do
  #   {
  #     clause
  #   }
  # end

  # def wrap_content(clause) when ??? do
  #
  #   {
  #     %{
  #       operation: clause.operation,
  #       rules: clause.rules
  #     }
  #   }
  # end

  # this logic will be used for groups
  # def extract_content(clauses = %{clauses: sub_clauses}) when length(sub_clauses) == 2 do
  #   %{
  #     lhs: extract_content(List.first(sub_clauses)),
  #     operation: clauses.logicalOperator,
  #     rhs: extract_content(List.last(sub_clauses))
  #   }
  # end

  # def extract_content(clauses) when is_list(clauses) and length(clauses) == 2 do
  #   [first, second | _] = clauses

  #   %{
  #     lhs: extract_content(first),
  #     rhs: extract_content(second)
  #   }
  # end

  # def extract_content(clauses) do
  #   [first_clause | rest] = clauses.clauses

  #   %{
  #     lhs: extract_content(first_clause),
  #     operation: clauses.logicalOperator,
  #     rhs: extract_content(rest)
  #   }
  # end
end
