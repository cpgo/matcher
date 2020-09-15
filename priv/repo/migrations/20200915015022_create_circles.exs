defmodule Matcher.Repo.Migrations.CreateCircles do
  use Ecto.Migration

  def change do
    create table(:circles, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:name, :string, null: false)
    end
  end
end
