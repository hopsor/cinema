defmodule Cinema.TheaterFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cinema.Theater` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        duration: 42,
        title: "some title"
      })
      |> Cinema.Theater.create_movie()

    movie
  end
end
