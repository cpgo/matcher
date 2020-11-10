defmodule RulesetToExpression do
  def run(%{lhs: lhs, condition: "EQUAL", rhs: rhs}, %{data: data}) do
    extract_data(lhs, data) == rhs
  end

  def run(%{lhs: lhs, condition: "GREATER_THAN", rhs: rhs}, %{data: data}) do
    Integer.parse(extract_data(lhs, data)) > Integer.parse(rhs)
  end

  def extract_data(key, data) do
    {:ok, value} = Map.fetch(data, String.to_existing_atom(key))
    value
  end
end
