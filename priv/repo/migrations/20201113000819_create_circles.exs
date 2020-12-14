defmodule CircleMatcher.Repo.Migrations.CreateCircles do
  use Ecto.Migration

  def change do
    create table(:circles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :rules, :map, null: false
      add :name, :string, null: false
      add :workspace_id, :uuid, null: false
      add :author_id, :uuid, null: false
      add :query_keys, {:array, :string}, null: false

      timestamps()
    end
    create index("circles", [:query_keys], using: "GIN")

  end
end
