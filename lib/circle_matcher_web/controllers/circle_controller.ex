defmodule CircleMatcherWeb.CircleController do
  use CircleMatcherWeb, :controller

  alias CircleMatcher.Circles
  alias CircleMatcher.Circles.Circle

  action_fallback CircleMatcherWeb.FallbackController

  def index(conn, _params) do
    circles = Circles.list_circles()
    render(conn, "index.json", circles: circles)
  end

  def create(conn, %{"circle" => circle_params}) do
    with {:ok, %Circle{} = circle} <- Circles.create_circle(circle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.circle_path(conn, :show, circle))
      |> render("show.json", circle: circle)
    end
  end

  def show(conn, %{"id" => id}) do
    circle = Circles.get_circle!(id)
    render(conn, "show.json", circle: circle)
  end

  def update(conn, %{"id" => id, "circle" => circle_params}) do
    circle = Circles.get_circle!(id)

    with {:ok, %Circle{} = circle} <- Circles.update_circle(circle, circle_params) do
      render(conn, "show.json", circle: circle)
    end
  end

  def delete(conn, %{"id" => id}) do
    circle = Circles.get_circle!(id)

    with {:ok, %Circle{}} <- Circles.delete_circle(circle) do
      send_resp(conn, :no_content, "")
    end
  end

  def identify(conn, %{"data" => data}) do
    Plug.Conn.put_resp_header(conn, "content-type", "application/json")
    |> send_resp(200, "123")
  end
end
