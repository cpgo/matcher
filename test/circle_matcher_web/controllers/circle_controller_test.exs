defmodule CircleMatcherWeb.CircleControllerTest do
  use CircleMatcherWeb.ConnCase

  alias CircleMatcher.Circles
  alias CircleMatcher.Circles.Circle

  @create_attrs %{
    author_id: "7488a646-e31f-11e4-aace-600308960662",
    name: "some name",
    rules: %{},
    workspace_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    author_id: "7488a646-e31f-11e4-aace-600308960668",
    name: "some updated name",
    rules: %{},
    workspace_id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{author_id: nil, name: nil, rules: nil, workspace_id: nil}

  def fixture(:circle) do
    {:ok, circle} = Circles.create_circle(@create_attrs)
    circle
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all circles", %{conn: conn} do
      conn = get(conn, Routes.circle_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create circle" do
    test "renders circle when data is valid", %{conn: conn} do
      conn = post(conn, Routes.circle_path(conn, :create), circle: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.circle_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author_id" => "7488a646-e31f-11e4-aace-600308960662",
               "name" => "some name",
               "rules" => %{},
               "workspace_id" => "7488a646-e31f-11e4-aace-600308960662"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.circle_path(conn, :create), circle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update circle" do
    setup [:create_circle]

    test "renders circle when data is valid", %{conn: conn, circle: %Circle{id: id} = circle} do
      conn = put(conn, Routes.circle_path(conn, :update, circle), circle: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.circle_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author_id" => "7488a646-e31f-11e4-aace-600308960668",
               "name" => "some updated name",
               "rules" => %{},
               "workspace_id" => "7488a646-e31f-11e4-aace-600308960668"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, circle: circle} do
      conn = put(conn, Routes.circle_path(conn, :update, circle), circle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete circle" do
    setup [:create_circle]

    test "deletes chosen circle", %{conn: conn, circle: circle} do
      conn = delete(conn, Routes.circle_path(conn, :delete, circle))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.circle_path(conn, :show, circle))
      end)
    end
  end

  defp create_circle(_) do
    circle = fixture(:circle)
    %{circle: circle}
  end
end
