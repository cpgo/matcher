defmodule Matcher.CreateTupleValue do
  def generate_value(json) do
    {:ok, data} = Jason.decode(json, keys: :atoms)

    rules =
      data.rules.clauses
      |> Enum.map(fn x -> extract_content(x) end)

    wrap_content(rules)
  end

  def extract_content(clauses) when not is_map_key(clauses, :logicalOperator) do
    %{
      lhs: clauses.content.key,
      condition: clauses.content.condition,
      rhs: clauses.content.value |> List.first()
    }
  end

  def wrap_content(clause) do
    {
      %{
        rules: clause
      }
    }
  end


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
