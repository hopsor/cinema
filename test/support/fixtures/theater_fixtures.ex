defmodule Multiplex.TheaterFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Multiplex.Theater` context.
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
      |> Multiplex.Theater.create_movie()

    movie
  end
end
