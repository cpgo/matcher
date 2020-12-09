defmodule CircleMatcherWeb.CircleView do
  use CircleMatcherWeb, :view
  alias CircleMatcherWeb.CircleView

  def render("index.json", %{circles: circles}) do
    %{data: render_many(circles, CircleView, "circle.json")}
  end

  def render("show.json", %{circle: circle}) do
    %{data: render_one(circle, CircleView, "circle.json")}
  end

  def render("circle.json", %{circle: circle}) do
    %{id: circle.id,
      segmentation: circle.segmentation,
      name: circle.name,
      workspace_id: circle.workspace_id,
      author_id: circle.author_id}
  end
end
