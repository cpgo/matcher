defmodule CircleMatcher.Circles do
  @moduledoc """
  The Circles context.
  """

  import Ecto.Query, warn: false
  alias CircleMatcher.Repo

  alias CircleMatcher.Circles.Circle

  @doc """
  Returns the list of circles.

  ## Examples

      iex> list_circles()
      [%Circle{}, ...]

  """
  def list_circles do
    Repo.all(Circle)
  end

  @doc """
  Gets a single circle.

  Raises `Ecto.NoResultsError` if the Circle does not exist.

  ## Examples

      iex> get_circle!(123)
      %Circle{}

      iex> get_circle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_circle!(id), do: Repo.get!(Circle, id)

  @doc """
  Creates a circle.

  ## Examples

      iex> create_circle(%{field: value})
      {:ok, %Circle{}}

      iex> create_circle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_circle(attrs \\ %{}) do
    %Circle{}
    |> Circle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a circle.

  ## Examples

      iex> update_circle(circle, %{field: new_value})
      {:ok, %Circle{}}

      iex> update_circle(circle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_circle(%Circle{} = circle, attrs) do
    circle
    |> Circle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a circle.

  ## Examples

      iex> delete_circle(circle)
      {:ok, %Circle{}}

      iex> delete_circle(circle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_circle(%Circle{} = circle) do
    Repo.delete(circle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking circle changes.

  ## Examples

      iex> change_circle(circle)
      %Ecto.Changeset{data: %Circle{}}

  """
  def change_circle(%Circle{} = circle, attrs \\ %{}) do
    Circle.changeset(circle, attrs)
  end
end
