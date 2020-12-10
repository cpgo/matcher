defmodule CircleMatcher.Circles.RuleGroup do
  use Ecto.Schema
  import Ecto.Changeset
  alias CircleMatcher.Circles.Rule

  embedded_schema do
    field(:operation, :string)
    embeds_many(:rules, Rule)
  end

  def changeset(changeset, attrs) do
    changeset
    |> cast(attrs, [:operation, :rules])
    |> validate_inclusion(:operation, ["GREATER_THAN", "EQUALS"])
    # |> rules_changes(attrs[:rules])
  end

  # defp rules_changes(changeset, rules) do
  #   Enum.reduce(rules, changeset, fn r ->
  #     validate(changeset, r).errors
  #     |> Enum.reduce(changeset, fn e -> add_error(changeset, :rule, e) end)
  #   end)
  # end

  # defp validate(changeset, %{ "operation" => _} = rules) do
  #   rules_changes(changeset, rules)
  # end

  # defp validate(changeset, %{ "condition" => _} = rule) do
  #   Rule.changeset(%Rule{}, rule).errors
  #   |> Enum.reduce(changeset, fn e, c ->
  #     add_error(c, :segmentation, "invalid_rule", e)
  #   end)
  # end
end
