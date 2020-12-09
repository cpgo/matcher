defmodule CircleMatcher.Repo.Migrations.CreateCircles do
  use Ecto.Migration

  def change do
    create table(:circles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :segmentation, :map
      add :name, :string
      add :workspace_id, :uuid
      add :author_id, :uuid

      timestamps()
    end

  end
end
