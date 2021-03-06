defmodule RulesetToExpression do
  def run(%{operation: "OR", rules: rules}, data) do
    Enum.map(rules, fn r -> run(r, data) end)
    |> Enum.any?()
  end

  def run(%{operation: "AND", rules: rules}, data) do
    Enum.map(rules, fn r -> run(r, data) end)
    |> Enum.all?()
  end

  def run(%{lhs: lhs, condition: "EQUAL", rhs: rhs}, %{data: data}) do
    extract_data(lhs, data) == rhs
  end

  def run(%{lhs: lhs, condition: "GREATER_THAN", rhs: rhs}, %{data: data}) do
    Integer.parse(extract_data(lhs, data)) > Integer.parse(rhs)
  end

  def extract_data(key, data) do
    case Map.fetch(data, String.to_existing_atom(key)) do
      {:ok, value} -> value
      _ -> false
    end
  end
end
