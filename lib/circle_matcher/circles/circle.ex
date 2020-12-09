defmodule Rule do
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

defmodule CompositeRule do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:operation, :string)
    embeds_many(:rules, Rule)
  end

  def changeset(changeset, attrs) do
    changeset
    |> cast(attrs, [:operation, :rules])
    |> validate_inclusion(:operation, ["GREATER_THAN", "EQUALS"])
    |> rules_changes(attrs[:rules])
  end

  defp rules_changes(changeset, rules) do
    Enum.map(rules, fn r -> Rule.changeset(changeset, r) end)
  end
end

defmodule CircleMatcher.Circles.Circle do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "circles" do
    field(:author_id, Ecto.UUID)
    field(:name, :string)
    field(:segmentation, :map)
    field(:workspace_id, Ecto.UUID)

    timestamps()
  end

  @doc false
  def changeset(circle, attrs) do
    circle
    |> cast(attrs, [:segmentation, :name, :workspace_id, :author_id])
    |> validate_required([:segmentation, :name, :workspace_id, :author_id])
    # |> validate_segmentation(:segmentation)
    |> treta(attrs["segmentation"])
  end

  def treta(changeset, segmentation = %{"operation" => _}) do
    c = CompositeRule.changeset(changeset, segmentation)
    IO.inspect(c)
    c
  end

  def treta(changeset, segmentation = %{"condition" => _}) do
    c = Rule.changeset(%Rule{}, segmentation)
    IO.inspect(c)
    IO.inspect(changeset)

    Enum.reduce(c.errors, changeset, fn e, c ->
      add_error(c, :segmentation, "invalid_rule", e)
    end)

    # changeset
  end

  defp validate_rule(field, %{"lhs" => lhs, "condition" => condition, "rhs" => rhs}) do
    valid_lhs = String.length(lhs) > 0
    valid_rhs = String.length(rhs) > 0
    valid_condition = String.length(condition) > 0

    if valid_lhs && valid_rhs && valid_condition do
      []
    else
      [field, "Field must be a non empty string"]
    end
  end

  defp validate_rule(field, %{"operation" => _, "rules" => rules}) do
    Enum.map(rules, fn r -> validate_rule(field, r) end)
  end

  defp validate_rule(field, _unmatched) do
    [
      field,
      "Rule format not valid, must be in the format of {'lsh': 'data', 'operation': 'op', 'rhs': 'data}"
    ]
  end

  defp validate_segmentation(changeset, field) do
    IO.inspect(changeset)

    validate_change(changeset, field, &validate_rule/2)
  end
end
