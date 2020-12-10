defmodule CircleMatcher.Circles.Circle do
  use Ecto.Schema
  import Ecto.Changeset
  # alias CircleMatcher.Circles.{Rule, RuleGroup}

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
    |> validate_segmentation()
  end

  def validate_segmentation(changeset) do
    # Wooosh... Valid!
    # (∩｀-´)⊃━☆ﾟ.*･｡ﾟ
    changeset
  end

  # def validate_segmentation(changeset, segmentation = %{"condition" => _}) do
  #   Rule.changeset(%Rule{}, segmentation).errors
  #   |> Enum.reduce(changeset, fn e, c ->
  #     add_error(c, :segmentation, "invalid_rule", e)
  #   end)
  # end
end
