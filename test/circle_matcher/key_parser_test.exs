defmodule CircleMatcher.KeyParserTest do
  use CircleMatcher.DataCase

  alias CircleMatcher.Circles.KeyParser

  describe "parse keys" do
    test "parse simple rule" do
      attrs = %{
        "lhs" => "name",
        "condition" => "EQUAL",
        "rhs" => "tester"
      }

      expected = ["name", "tester"]
      assert KeyParser.generate_keys(attrs) == expected
    end

    test "parse grouped rule" do
      attrs = [
        %{
          "operation" => "AND",
          "rules" => [
            %{
              "lhs" => "name",
              "condition" => "EQUAL",
              "rhs" => "joe"
            },
            %{
              "lhs" => "age",
              "condition" => "EQUAL",
              "rhs" => "12"
            }
          ]
        },
        %{
          "lhs" => "role",
          "condition" => "EQUAL",
          "rhs" => "tester"
        }
      ]

      expected = ["name", "joe", "age", "12", "role", "tester"]
      assert KeyParser.generate_keys(attrs) == expected
    end

    test "parse grouped rule with duplicated keys" do
      attrs = [
        %{
          "operation" => "AND",
          "rules" => [
            %{
              "lhs" => "name",
              "condition" => "EQUAL",
              "rhs" => "joe"
            },
            %{
              "lhs" => "name",
              "condition" => "EQUAL",
              "rhs" => "jose"
            }
          ]
        },
        %{
          "lhs" => "role",
          "condition" => "EQUAL",
          "rhs" => "tester"
        }
      ]

      expected = ["name", "joe", "jose", "role", "tester"]
      assert KeyParser.generate_keys(attrs) == expected
    end
  end
end
