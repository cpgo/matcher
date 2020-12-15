defmodule Parent do
  @derive {Jason.Encoder, only: [:name, :children, :zica]}
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "parents" do
    field(:name, :string)

    embeds_many :children, Child, [on_replace: :delete, primary_key: false] do
      field(:name, :string)
      field(:age, :integer)
    end


    embeds_one :zica, Zica, [on_replace: :update, primary_key: false] do
      field(:nome_da_zica, :integer)
    end
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [:name])
    |> cast_embed(:children, with: &child_changeset/2)
    |> cast_embed(:zica, with: &zica_changeset/2)
    |> validate_required(:zica)
  end

  defp zica_changeset(schema, params) do
    schema
    |> cast(params, [:nome_da_zica])
    |> validate_required([:nome_da_zica])
  end

  defp child_changeset(schema, params) do
    schema
    |> cast(params, [:name, :age])
    |> validate_required([:name, :age])
  end
end


# Ecto.Changeset.traverse_errors(fn e -> e end)
