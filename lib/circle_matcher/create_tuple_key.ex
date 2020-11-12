defmodule Matcher.CreateTupleKey do
  def generate_keys(json) do
    {:ok, data} = Jason.decode(json, keys: :atoms)

    data.rules.clauses
    |> Enum.map(&clauses_to_map/1)
    |> clause_map_to_tuple
    |> Tuple.insert_at(0, data.workspaceId)
  end

  defp clause_map_to_tuple(clause_maps) when is_list(clause_maps) do
    clause_maps
    |> Enum.reduce({}, fn map, s ->
      Tuple.append(s, clause_map_to_tuple(map))
    end)
  end

  defp clause_map_to_tuple(clause_map) do
    {clause_map.key, clause_map.value}
  end

  defp clauses_to_map(clauses) when is_map_key(clauses, :content) do
    [
      %{
        key: clauses.content.key,
        value: List.first(clauses.content.value)
      }
    ]
  end

  defp clauses_to_map(clauses) when is_map_key(clauses, :clauses) do
    clauses.clauses
    |> Enum.flat_map(&clauses_to_map/1)
  end
end
