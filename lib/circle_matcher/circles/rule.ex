defmodule CircleMatcher.Circles.Rule do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:lhs, :string)
    field(:rhs, :string)
    field(:condition, :string)
  end

  def changeset(rule, attrs) do
    rule
    |> cast(attrs, [:lhs, :condition, :rhs])
    |> validate_required([:lhs, :condition, :rhs])
    |> validate_inclusion(:condition, ["GREATER_THAN", "EQUALS"])
  end
end
