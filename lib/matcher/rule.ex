defmodule Matcher.Rule do
  use Ecto.Schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "rules" do
    field(:field_name, :string)
    field(:field_value, :string)
    field(:operation, :string)
    belongs_to(:circle, Matcher.Circle)
  end
end
