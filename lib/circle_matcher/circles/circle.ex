defmodule CircleMatcher.Circles.Circle do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "circles" do
    field(:author_id, Ecto.UUID)
    field(:name, :string)
    field(:rules, :map)
    field(:workspace_id, Ecto.UUID)
    field(:query_keys, {:array, :string})
    timestamps()
  end

  @doc false
  def changeset(circle, attrs) do
    circle
    |> cast(attrs, [:rules, :name, :workspace_id, :author_id, :query_keys])
    |> validate_required([:rules, :name, :workspace_id, :author_id])
    |> validate_rules()
    |> put_query_keys()
  end

  def put_query_keys(changeset) do
    if changeset.valid? do
      keys = CircleMatcher.Circles.KeyParser.generate_keys(Map.get(changeset.changes, :rules, %{}))
      put_change(changeset, :query_keys, keys)
    else
      changeset
    end
  end

  def validate_rules(changeset) do
    validate_change(changeset, :rules, fn :rules, rules ->
      case rules do
        nil ->
          [rules: "cannot be nil"]
        _ ->
          []
      end
    end)
  end
end
