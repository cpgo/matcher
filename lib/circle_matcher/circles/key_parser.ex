defmodule CircleMatcher.Circles.KeyParser do
  def generate_keys(%{"lhs" => key, "rhs" => value}) do
    [key, value]
  end

  def generate_keys(%{"operation" => _, "rules" => rules}) do
    generate_keys(rules)
  end

  def generate_keys(rules) when is_list(rules) do
    Enum.flat_map(rules, fn r -> generate_keys(r) end) |> Enum.uniq()
  end
end
