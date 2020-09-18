defmodule Matcher.CreateTupleValue do
  def generate_value(json) do
    {:ok, data} = Jason.decode(json, keys: :atoms)
    data
  end
end
