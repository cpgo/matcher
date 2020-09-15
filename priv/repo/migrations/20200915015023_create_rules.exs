defmodule Matcher.Repo.Migrations.CreateRules do
  use Ecto.Migration

  def change do
    create table(:rules, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:circle_id, references(:circles, type: :binary_id), null: false)
      add(:field_name, :string, null: false)
      add(:field_value, :string, null: false)
      add(:operation, :string, null: false)
    end
  end
end
