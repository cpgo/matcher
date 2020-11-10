defmodule Matcher.Circle do
  use Ecto.Schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "circles" do
    field(:rules, :map)
  end
end
