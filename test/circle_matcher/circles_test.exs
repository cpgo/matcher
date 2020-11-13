defmodule CircleMatcher.CirclesTest do
  use CircleMatcher.DataCase

  alias CircleMatcher.Circles

  describe "circles" do
    alias CircleMatcher.Circles.Circle

    @valid_attrs %{author_id: "7488a646-e31f-11e4-aace-600308960662", name: "some name", rules: %{}, workspace_id: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{author_id: "7488a646-e31f-11e4-aace-600308960668", name: "some updated name", rules: %{}, workspace_id: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{author_id: nil, name: nil, rules: nil, workspace_id: nil}

    def circle_fixture(attrs \\ %{}) do
      {:ok, circle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Circles.create_circle()

      circle
    end

    test "list_circles/0 returns all circles" do
      circle = circle_fixture()
      assert Circles.list_circles() == [circle]
    end

    test "get_circle!/1 returns the circle with given id" do
      circle = circle_fixture()
      assert Circles.get_circle!(circle.id) == circle
    end

    test "create_circle/1 with valid data creates a circle" do
      assert {:ok, %Circle{} = circle} = Circles.create_circle(@valid_attrs)
      assert circle.author_id == "7488a646-e31f-11e4-aace-600308960662"
      assert circle.name == "some name"
      assert circle.rules == %{}
      assert circle.workspace_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_circle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Circles.create_circle(@invalid_attrs)
    end

    test "update_circle/2 with valid data updates the circle" do
      circle = circle_fixture()
      assert {:ok, %Circle{} = circle} = Circles.update_circle(circle, @update_attrs)
      assert circle.author_id == "7488a646-e31f-11e4-aace-600308960668"
      assert circle.name == "some updated name"
      assert circle.rules == %{}
      assert circle.workspace_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_circle/2 with invalid data returns error changeset" do
      circle = circle_fixture()
      assert {:error, %Ecto.Changeset{}} = Circles.update_circle(circle, @invalid_attrs)
      assert circle == Circles.get_circle!(circle.id)
    end

    test "delete_circle/1 deletes the circle" do
      circle = circle_fixture()
      assert {:ok, %Circle{}} = Circles.delete_circle(circle)
      assert_raise Ecto.NoResultsError, fn -> Circles.get_circle!(circle.id) end
    end

    test "change_circle/1 returns a circle changeset" do
      circle = circle_fixture()
      assert %Ecto.Changeset{} = Circles.change_circle(circle)
    end
  end
end
