defmodule Matcher.CreateEtsRecord do
  def generate_record(rule_json) do
    key = Matcher.CreateTupleKey.generate_keys(rule_json)
    value = Matcher.CreateTupleValue.generate_value(rule_json)
    {key, value}
  end
end
